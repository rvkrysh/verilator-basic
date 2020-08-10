ifneq ($(words $(CURDIR)),1)
  $(error Unsupported: GNU Make cannot build in directories containing spaces: '$(CURDIR)')
endif

TRACE=1
TFLAG:=

ifeq ($(TRACE),1)
  TFLAG := --trace
endif

CFLAGS := "-Wall -Werror -Wextra --std=c++17 -O3 -g"
SIMFLAGS := -O2 --cc --autoflush --assert -sv -Mdir bin -CFLAGS $(CFLAGS)

.PHONY: Vtop run clean info

default: Vtop

Vtop:
	verilator $(SIMFLAGS) top.sv --exe --build sim_main.cpp $(TFLAG)

run:
	./bin/Vtop

clean:
	rm -rf bin

info:
	verilator -V
