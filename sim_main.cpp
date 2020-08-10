#include <iostream>
#include "verilated.h"
#include "verilated_vcd_c.h"
#include "Vtop.h"

Vtop *top_;  // module instantiation
VerilatedVcdC *trace_;

vluint64_t main_time = 0; // simulation time
int increment = 0;
int decrement = 0;

void init() {
  top_->clk = 1;
  top_->inc = 0;
  top_->dec = 0;
}

void tick() {
  // toggle clock
  top_->clk = !top_->clk;
  if (top_->clk) top_->inc = 0;
  if (top_->clk) top_->dec = 0;

  if (increment)
    top_->inc = 1;

  if (decrement)
    top_->dec = 1;

  top_->eval();
  trace_->dump(main_time);
  trace_->flush();
  main_time++;
}

int main(int argc, char** argv) {
  Verilated::commandArgs(argc, argv); // remember args
  Verilated::traceEverOn(true);

  top_ = new Vtop;
  trace_ = new VerilatedVcdC;

  top_->trace(trace_, 99);  // trace 99 levels of hierarchy
  trace_->spTrace()->set_time_resolution("ps");
  trace_->spTrace()->set_time_unit("ps");
  trace_->open("wave.vcd");

  init();
  for (int i = 0; i < 1000; i++) {
    tick();

    // randomly toggle inc/dec
    if (!(rand()%41)) increment = !increment;
    if (!(rand()%43)) decrement = !decrement;
  }

  top_->final(); // done simulating
  delete top_; // destroy model
  trace_->close();
  delete trace_;

  exit(0);
}
