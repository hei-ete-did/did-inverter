LIBRARY Common_test;
  USE Common_test.testUtils.all;

ARCHITECTURE test OF inverterControl_tester IS
                                                            -- clock and enables
  constant clockPeriod: time := 1.0/clockFrequency * 1 sec;
  signal sClock: std_uLogic := '1';
  constant mainsPeriod: time := 1.0/mainsFrequency * 1 sec;
  signal sMains: std_uLogic := '1';
  signal mainsDelayed: std_uLogic := '0';
                                                                    -- test info
  signal testInfo : string(1 to 30) := (others => ' ');
                                                                     -- controls
  constant modePeriod: time := 2*mainsPeriod;
                                                                         -- UART
  constant uartDataBitNb: positive := 8;
  constant uartPeriod: time := (1.0/uartBaudRate) * 1 sec;
  constant uartWriteInterval: time := 2 ms;
  signal uartOutString : string(1 to 32) := (others => ' ');
  signal uartSendOutString: std_uLogic;
  signal uartSendOutDone: std_uLogic;
  signal uartOutByte, uartInByte: character;
  signal uartSendOutByte, uartReceivedInByte: std_uLogic;
                                                                      -- lowpass
  constant lowpassShift: positive := 12;
  signal pwm1, pwm2: std_uLogic;
  signal pwm: integer;
                                                           -- period measurement
  signal lastTriggerRisingEdge : time := 0 sec;
  signal measuredPeriod : time := mainsPeriod;
  signal measuredFrequency : real := mainsFrequency;
                                                      -- non-overlap measurement
  signal lastPwmHighFallingEdge : time := 0 sec;
  signal lastPwmLowFallingEdge : time := 0 sec;
  signal measuredDeadTime : time := nonOverlapPeriod;
  signal measuredDeadTimeNs : positive := nonOverlapPeriod / 1 ns;

BEGIN
  ------------------------------------------------------------------------------
                                                              -- clock and reset
  reset <= '1', '0' after 4*clockPeriod;

  sClock <= not sClock after clockPeriod/2;
  clock <= transport sClock after 9.0/10.0 * clockPeriod;

  sMains <= not sMains after mainsPeriod/2;
  mainsDelayed <= transport sMains after 1.0/8.0 * mainsPeriod;
  mainsTriggered <= mainsDelayed;

  --============================================================================
                                                         -- power supply control
  controlSupplyVoltage: process
  begin
    supplyVoltage <= 12.0;

    wait;
  end process controlSupplyVoltage;


  ------------------------------------------------------------------------------
                                                              -- sampling enable
  sampleEn <= '1';
                                                             -- PWM count enable
  pwmCountEn <= '1';

  ------------------------------------------------------------------------------
                                                                     -- controls
  testSequence: process
  begin
    threeLevel <= '0';
    switchEvenOdd <= '0';
    doubleFrequency <= '0';
    uartSendOutString <= '0';

    ----------------------------------------------------------------------------
                                                      -- basic 2-level switching
    wait for 1 ns;
    testInfo <= pad("2-level switching", testInfo'length);
    wait for 1 ns;
    print(testInfo);

    ----------------------------------------------------------------------------
                                                            -- 3 level switching
    wait for modePeriod - now;
    testInfo <= pad("3-level switching", testInfo'length);
    wait for 1 ns;
    print(testInfo);
    threeLevel <= '1';
                                                                -- setting a LED
    uartOutString <= pad("LED 2 1", uartOutString'length);
    uartSendOutString <= '1', '0' after 1 ns;
    wait until uartSendOutDone = '1';
    wait for modePeriod/4;
                                                          -- asking for controls
    uartOutString <= pad("buttons", uartOutString'length);
    uartSendOutString <= '1', '0' after 1 ns;
    wait until uartSendOutDone = '1';

    ----------------------------------------------------------------------------
                                          -- 3-level with switching interleaving
    wait for 2*modePeriod - now;
    testInfo <= pad("even-odd mode switching", testInfo'length);
    wait for 1 ns;
    print(testInfo);
    switchEvenOdd <= '1';
                                                               -- clearing a LED
    uartOutString <= pad("LED 2 0" & lf, uartOutString'length);
    uartSendOutString <= '1', '0' after 1 ns;
    wait until uartSendOutDone = '1';

    ----------------------------------------------------------------------------
                                      -- 3-level switching with double frequency
    wait for 3*modePeriod - now;
    testInfo <= pad("doubling switching frequency", testInfo'length);
    wait for 1 ns;
    print(testInfo);
    doubleFrequency <= '1';
                                                          -- setting another LED
    uartOutString <= pad("LED 3 1", uartOutString'length);
    uartSendOutString <= '1', '0' after 1 ns;
    wait until uartSendOutDone = '1';

    ----------------------------------------------------------------------------
                                                       -- changing the amplitude
    wait for 4*modePeriod - now;
    testInfo <= pad("changing the signal amplitude", testInfo'length);
    wait for 1 ns;
    print(testInfo);
    uartOutString <= pad("amplitude 80", uartOutString'length);
    uartSendOutString <= '1', '0' after 1 ns;
    wait until uartSendOutDone = '1';

    ----------------------------------------------------------------------------
                                                            -- end of simulation
    wait;
  end process testSequence;

  --============================================================================
                                                                   -- uart send
  rsSendSerialString: process
    constant uartBytePeriod : time := 15*uartPeriod;
    variable commandRight: natural;
  begin

    uartSendOutByte <= '0';
    uartSendOutDone <= '0';

    wait until rising_edge(uartSendOutString);

    commandRight := uartOutString'right;
    while uartOutString(commandRight) = ' ' loop
      commandRight := commandRight-1;
    end loop;

    for index in uartOutString'left to commandRight loop
      uartOutByte <= uartOutString(index);
      uartSendOutByte <= '1', '0' after 1 ns;
      wait for uartBytePeriod;
    end loop;

    uartOutByte <= cr;
    uartSendOutByte <= '1', '0' after 1 ns;
    wait for uartBytePeriod;

    uartSendOutDone <= '1';
    wait for 1 ns;

  end process rsSendSerialString;

  rsSendSerialByte: process
    variable txData: unsigned(uartDataBitNb-1 downto 0);
  begin
    TxD <= '1';

    wait until rising_edge(uartSendOutByte);
    txData := to_unsigned(character'pos(uartOutByte), txData'length);

    TxD <= '0';
    wait for uartPeriod;

    for index in txData'reverse_range loop
      TxD <= txData(index);
      wait for uartPeriod;
    end loop;

  end process rsSendSerialByte;

  rsReceiveSerialByte: process
    variable rxData: unsigned(uartDataBitNb-1 downto 0);
  begin
    uartReceivedInByte <= '0';
    rxData := (others => '0');

    wait until falling_edge(RxD);
    wait for 0.5*uartPeriod;

    for index in rxData'reverse_range loop
      wait for uartPeriod;
      rxData(index) := RxD;
    end loop;

    wait for 0.5*uartPeriod;
    uartInByte <= character'val(to_integer(rxData));
    uartReceivedInByte <= '1';
    wait for 1 ns;

  end process rsReceiveSerialByte;

  --============================================================================
                                                                  -- PWM signals
  pwm1 <= '1' when pwm1High = '1'
    else '0' when pwm1Low_n = '1';

  pwm2 <= '1' when pwm2High = '1'
    else '0' when pwm2Low_n = '1';

  pwm <= 1 when (pwm1 = '1') and (pwm2 = '0')
    else -1 when (pwm1 = '0') and (pwm2 = '1')
    else 0;

  ------------------------------------------------------------------------------
                                                           -- period measurement
  updatePeriodMeasurement: process(trigger)
  begin
    if rising_edge(trigger) then
      measuredPeriod <= now - lastTriggerRisingEdge;
      lastTriggerRisingEdge <= now;
    end if;
  end process updatePeriodMeasurement;

  measuredFrequency <= 1.0 / ( real(measuredPeriod / 1 ns) * 1.0E-9 );

  ------------------------------------------------------------------------------
                                                        -- dead time measurement
  updateDeadTimeMeasurement: process(pwm1High, pwm1Low_n)
  begin
    if falling_edge(pwm1High) then
      lastPwmHighFallingEdge <= now;
    end if;
    if falling_edge(pwm1Low_n) then
      lastPwmLowFallingEdge <= now;
    end if;
    if rising_edge(pwm1High) then
      measuredDeadTime <= now - lastPwmLowFallingEdge;
    end if;
    if rising_edge(pwm1Low_n) then
      measuredDeadTime <= now - lastPwmHighFallingEdge;
    end if;
  end process updateDeadTimeMeasurement;

  measuredDeadTimeNs <= measuredDeadTime / 1 ns;

END ARCHITECTURE test;
