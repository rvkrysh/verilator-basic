# Very basic verilator example

This example simulates a PWM generator written in systemverilog using Verilator.
Trace feature of verilator is enabled and so it generates a waveform.

1. To compile the project run `make`
2. Simulate the project, `make run`
3. View the waveform, `gtkwave wave.vcd`

Note: verilator and gtkwave must be installed as prerequisites.
