# Very basic verilator example

This example simulates a PWM generator written in systemverilog using Verilator.
Trace feature of verilator is enabled and so it generates a waveform.

1. Compile the project
$ make

2. Run
$ make run

3. View the waveform
$ gtkwave wave.vcd