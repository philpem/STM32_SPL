.PHONY: all test clean

all: test

clean: vendor_st_stm32_stdperiph_clean

export INTERNAL_TEST_MODE=1

include ToolchainCfg.mk
include ../ST_STM32StdPeriph.mk

test:	$(SPL_LIB)

