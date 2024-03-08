onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /invertercontrol_tb/I_tester/testInfo
add wave -noupdate -group {Reset and clock} /invertercontrol_tb/reset
add wave -noupdate -group {Reset and clock} /invertercontrol_tb/clock
add wave -noupdate -expand -group Controls /invertercontrol_tb/I_DUT/I_ctl/amplitude
add wave -noupdate -expand -group Controls /invertercontrol_tb/threeLevel
add wave -noupdate -expand -group Controls /invertercontrol_tb/switchEvenOdd
add wave -noupdate -expand -group Controls /invertercontrol_tb/doubleFrequency
add wave -noupdate -group {Sine wave} /invertercontrol_tb/sampleEn
add wave -noupdate -group {Sine wave} -format Analog-Step -height 50 -max 16000000.0 -radix unsigned -childformat {{/invertercontrol_tb/I_DUT/phase(23) -radix unsigned} {/invertercontrol_tb/I_DUT/phase(22) -radix unsigned} {/invertercontrol_tb/I_DUT/phase(21) -radix unsigned} {/invertercontrol_tb/I_DUT/phase(20) -radix unsigned} {/invertercontrol_tb/I_DUT/phase(19) -radix unsigned} {/invertercontrol_tb/I_DUT/phase(18) -radix unsigned} {/invertercontrol_tb/I_DUT/phase(17) -radix unsigned} {/invertercontrol_tb/I_DUT/phase(16) -radix unsigned} {/invertercontrol_tb/I_DUT/phase(15) -radix unsigned} {/invertercontrol_tb/I_DUT/phase(14) -radix unsigned} {/invertercontrol_tb/I_DUT/phase(13) -radix unsigned} {/invertercontrol_tb/I_DUT/phase(12) -radix unsigned} {/invertercontrol_tb/I_DUT/phase(11) -radix unsigned} {/invertercontrol_tb/I_DUT/phase(10) -radix unsigned} {/invertercontrol_tb/I_DUT/phase(9) -radix unsigned} {/invertercontrol_tb/I_DUT/phase(8) -radix unsigned} {/invertercontrol_tb/I_DUT/phase(7) -radix unsigned} {/invertercontrol_tb/I_DUT/phase(6) -radix unsigned} {/invertercontrol_tb/I_DUT/phase(5) -radix unsigned} {/invertercontrol_tb/I_DUT/phase(4) -radix unsigned} {/invertercontrol_tb/I_DUT/phase(3) -radix unsigned} {/invertercontrol_tb/I_DUT/phase(2) -radix unsigned} {/invertercontrol_tb/I_DUT/phase(1) -radix unsigned} {/invertercontrol_tb/I_DUT/phase(0) -radix unsigned}} -radixshowbase 0 -subitemconfig {/invertercontrol_tb/I_DUT/phase(23) {-height 17 -radix unsigned -radixshowbase 0} /invertercontrol_tb/I_DUT/phase(22) {-height 17 -radix unsigned -radixshowbase 0} /invertercontrol_tb/I_DUT/phase(21) {-height 17 -radix unsigned -radixshowbase 0} /invertercontrol_tb/I_DUT/phase(20) {-height 17 -radix unsigned -radixshowbase 0} /invertercontrol_tb/I_DUT/phase(19) {-height 17 -radix unsigned} /invertercontrol_tb/I_DUT/phase(18) {-height 17 -radix unsigned} /invertercontrol_tb/I_DUT/phase(17) {-height 17 -radix unsigned} /invertercontrol_tb/I_DUT/phase(16) {-height 17 -radix unsigned} /invertercontrol_tb/I_DUT/phase(15) {-height 17 -radix unsigned} /invertercontrol_tb/I_DUT/phase(14) {-height 17 -radix unsigned} /invertercontrol_tb/I_DUT/phase(13) {-height 17 -radix unsigned} /invertercontrol_tb/I_DUT/phase(12) {-height 17 -radix unsigned} /invertercontrol_tb/I_DUT/phase(11) {-height 17 -radix unsigned} /invertercontrol_tb/I_DUT/phase(10) {-height 17 -radix unsigned} /invertercontrol_tb/I_DUT/phase(9) {-height 17 -radix unsigned} /invertercontrol_tb/I_DUT/phase(8) {-height 17 -radix unsigned} /invertercontrol_tb/I_DUT/phase(7) {-height 17 -radix unsigned} /invertercontrol_tb/I_DUT/phase(6) {-height 17 -radix unsigned} /invertercontrol_tb/I_DUT/phase(5) {-height 17 -radix unsigned} /invertercontrol_tb/I_DUT/phase(4) {-height 17 -radix unsigned} /invertercontrol_tb/I_DUT/phase(3) {-height 17 -radix unsigned} /invertercontrol_tb/I_DUT/phase(2) {-height 17 -radix unsigned} /invertercontrol_tb/I_DUT/phase(1) {-height 17 -radix unsigned} /invertercontrol_tb/I_DUT/phase(0) {-height 17 -radix unsigned}} /invertercontrol_tb/I_DUT/phase
add wave -noupdate -group {Sine wave} /invertercontrol_tb/trigger
add wave -noupdate -group {Sine wave} -format Analog-Step -height 50 -max 500.0 -min -500.0 -radix decimal -radixshowbase 0 /invertercontrol_tb/I_DUT/sine
add wave -noupdate -group PWM /invertercontrol_tb/pwmCountEn
add wave -noupdate -group PWM -format Analog-Step -height 30 -max 500.0 -min -500.0 -radix decimal -radixshowbase 0 /invertercontrol_tb/I_DUT/I_PWM/sawtooth
add wave -noupdate -group PWM /invertercontrol_tb/I_DUT/I_PWM/even_odd
add wave -noupdate -group PWM /invertercontrol_tb/I_DUT/pwm1
add wave -noupdate -group PWM /invertercontrol_tb/I_DUT/pwm2
add wave -noupdate -group PWM -format Analog-Step -height 30 -max 1.0 -min -1.0 -radix decimal -radixshowbase 0 /invertercontrol_tb/I_tester/pwm
add wave -noupdate -group {Non-overlapping controls} /invertercontrol_tb/pwm1High
add wave -noupdate -group {Non-overlapping controls} /invertercontrol_tb/pwm1Low_n
add wave -noupdate -group {Non-overlapping controls} /invertercontrol_tb/pwm2High
add wave -noupdate -group {Non-overlapping controls} /invertercontrol_tb/pwm2Low_n
add wave -noupdate -expand -group {Filtered outputs} -format Analog-Step -height 25 -max 12.0 /invertercontrol_tb/lowpass1
add wave -noupdate -expand -group {Filtered outputs} -format Analog-Step -height 25 -max 12.0 /invertercontrol_tb/lowpass2
add wave -noupdate -expand -group {Filtered outputs} -format Analog-Step -height 50 -max 12.0 -min -12.0 /invertercontrol_tb/lowpassDiff
add wave -noupdate -group Measurements /invertercontrol_tb/I_tester/measuredFrequency
add wave -noupdate -group Measurements -radix unsigned -radixshowbase 0 /invertercontrol_tb/I_tester/measuredDeadTimeNs
add wave -noupdate -group {Amplitude feedback} /invertercontrol_tb/mainsTriggered
add wave -noupdate -group {Amplitude feedback} /invertercontrol_tb/adcClock
add wave -noupdate -group {Amplitude feedback} /invertercontrol_tb/adcData
add wave -noupdate -group {Amplitude feedback} -format Analog-Step -height 50 -max 500.0 -min -500.0 -radix decimal -radixshowbase 0 /invertercontrol_tb/I_DUT/measuredAmplitude
add wave -noupdate -expand -group {UART control} /invertercontrol_tb/I_tester/uartOutString
add wave -noupdate -expand -group {UART control} /invertercontrol_tb/I_tester/uartOutByte
add wave -noupdate -expand -group {UART control} /invertercontrol_tb/I_tester/TxD
add wave -noupdate -expand -group {UART control} /invertercontrol_tb/I_DUT/I_ctl/charEn
add wave -noupdate -expand -group {UART control} -radix ascii -radixshowbase 0 /invertercontrol_tb/I_DUT/I_ctl/charIn
add wave -noupdate -expand -group {UART control} -radix hexadecimal -childformat {{/invertercontrol_tb/I_DUT/I_ctl/command(1) -radix hexadecimal} {/invertercontrol_tb/I_DUT/I_ctl/command(2) -radix hexadecimal} {/invertercontrol_tb/I_DUT/I_ctl/command(3) -radix hexadecimal} {/invertercontrol_tb/I_DUT/I_ctl/command(4) -radix hexadecimal}} -radixshowbase 0 -subitemconfig {/invertercontrol_tb/I_DUT/I_ctl/command(1) {-height 17 -radix hexadecimal -radixshowbase 0} /invertercontrol_tb/I_DUT/I_ctl/command(2) {-height 17 -radix hexadecimal -radixshowbase 0} /invertercontrol_tb/I_DUT/I_ctl/command(3) {-height 17 -radix hexadecimal -radixshowbase 0} /invertercontrol_tb/I_DUT/I_ctl/command(4) {-height 17 -radix hexadecimal -radixshowbase 0}} /invertercontrol_tb/I_DUT/I_ctl/command
add wave -noupdate -expand -group {UART control} /invertercontrol_tb/I_DUT/I_ctl/endOfCommand
add wave -noupdate -expand -group {UART control} -radix hexadecimal -radixshowbase 0 /invertercontrol_tb/I_DUT/I_ctl/value
add wave -noupdate -expand -group {UART control} -radix hexadecimal -radixshowbase 0 /invertercontrol_tb/I_DUT/amplitudeControl
add wave -noupdate -expand -group {UART control} -radix hexadecimal -radixshowbase 0 /invertercontrol_tb/I_DUT/leds
add wave -noupdate -expand -group {UART control} /invertercontrol_tb/I_DUT/buttons
add wave -noupdate -expand -group {UART control} -radix ascii -radixshowbase 0 /invertercontrol_tb/I_DUT/I_ctl/txData
add wave -noupdate -expand -group {UART control} /invertercontrol_tb/I_tester/RxD
add wave -noupdate -expand -group {UART control} /invertercontrol_tb/I_tester/uartInByte
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 2} {0 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 331
configure wave -valuecolwidth 89
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1000
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ms
update
WaveRestoreZoom {0 ps} {21 ms}
