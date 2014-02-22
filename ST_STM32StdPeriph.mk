
# Set up a variable prefix for this Makefile's local variables
PFX:=VENDOR_ST_SPL_REQS

# Save this makefile's path
$(PFX)_PFP := $(dir $(CURDIR)/$(word $(words $(MAKEFILE_LIST)),$(MAKEFILE_LIST)))

# Validate the platform string
$(PFX)_VALID_PLATFORMS := STM32F030 STM32F031 STM32F051 STM32F072 STM32F042 STM23F0XX_MD STM32F0XX_LD STM32F0XX_HD STM32F030X8 STM32F030X6
$(PFX)_VALID_PLATFORMS += STM32F10X_LD_VL STM32F10X_MD_VL STM32F10X_HD_VL STM32F10X_CL
$(PFX)_VALID_PLATFORMS += STM32F2XX
$(PFX)_VALID_PLATFORMS += STM32F30X
$(PFX)_VALID_PLATFORMS += STM32F37X
$(PFX)_VALID_PLATFORMS += STM32F40_41xxx STM32F427_437xx STM32F429_439xx STM32F401xx
$(PFX)_VALID_PLATFORMS += STM32L1XX_MD STM32L1XX_MDP STM32L1XX_HD

ifeq ($(filter $($(PFX)_VALID_PLATFORMS),$(PLATFORM)),)
  $(error PLATFORM is not valid!)
endif


#############################################################################
# Platform specific options
# These only apply to specific platforms.
#############################################################################

# Platform specific rules need to set up the Platform Directory (_PFMDIR).

ifneq ($(filter STM32F030 STM32F031 STM32F051 STM32F072 STM32F042 STM23F0XX_MD STM32F0XX_LD STM32F0XX_HD STM32F030X8 STM32F030X6,$(PLATFORM)),)
  $(PFX)_PFMDIR := STM32F0xx
endif

ifneq ($(filter STM32F10X_LD_VL STM32F10X_MD_VL STM32F10X_HD_VL STM32F10X_CL,$(PLATFORM)),)
  $(PFX)_PFMDIR := STM32F10x
endif

ifneq ($(filter STM32F2XX,$(PLATFORM)),)
  $(PFX)_PFMDIR := STM32F2xx
endif

ifneq ($(filter STM32F30X,$(PLATFORM)),)
  $(PFX)_PFMDIR := STM32F30x
endif

ifneq ($(filter STM32F37X,$(PLATFORM)),)
  $(PFX)_PFMDIR := STM32F37x
endif

ifneq ($(filter STM32F40_41xxx STM32F427_437xx STM32F429_439xx STM32F401xx,$(PLATFORM)),)
  $(PFX)_PFMDIR := STM32F4xx
endif

ifneq ($(filter STM32L1XX_MD STM32L1XX_MDP STM32L1XX_HD,$(PLATFORM)),)
  $(PFX)_PFMDIR := STM32L1xx
endif


#############################################################################
# Library specific options
# These apply to all platforms which use a specific library
#############################################################################

# Library specific options define two things: the list of modules available
# for a given platform (_MODULES) and the filename prefix for each module
# (_PREFIX).
ifeq ($($(PFX)_PFMDIR),STM32F0xx)
  $(PFX)_MODULES := adc can cec comp crc crs dac dbgmcu dma exti flash gpio i2c iwdg misc pwr rcc rtc spi syscfg tim usart wwdg
  $(PFX)_PREFIX  := stm32f0xx
  $(PFX)_ARM_MATH:= ARM_MATH_CM0
  # TODO: CPAL
#  $(PFX)_EXTRA_INC:= $($(PFX)_PFMDIR)_CPAL_Driver/inc
#  $(PFX)_EXTRA_SRC:= $($(PFX)_PFMDIR)_CPAL_Driver/src
endif

ifeq ($($(PFX)_PFMDIR),STM32F10x)
  $(PFX)_MODULES := adc bkp can cec crc dac dbgmcu dma exti flash fsmc gpio i2c iwdg pwr rcc rtc sdio spi tim usart wwdg
  $(PFX)_PREFIX  := stm32f10x
  $(PFX)_EXTRA   := misc
  $(PFX)_ARM_MATH:= ARM_MATH_CM3
endif

ifeq ($($(PFX)_PFMDIR),STM32F2xx)
  $(PFX)_MODULES := adc can crc cryp_aes cryp cryp_des cryp_tdes dac dbgmcu dcmi dma exti flash fsmc gpio hash hash_md5 hash_sha1 i2c iwdg pwr rcc rng rtc sdio spi syscfg tim usart wwdg
  $(PFX)_PREFIX  := stm32f2xx
  $(PFX)_EXTRA   := misc
  $(PFX)_ARM_MATH:= ARM_MATH_CM3
endif

ifeq ($($(PFX)_PFMDIR),STM32F30x)
  $(PFX)_MODULES := adc can comp crc dac dbgmcu dma exti flash gpio i2c iwdg misc opamp pwr rcc rtc spi syscfg tim usart wwdg
  $(PFX)_PREFIX  := stm32f30x
  $(PFX)_EXTRA   := 
  $(PFX)_ARM_MATH:= ARM_MATH_CM3
  # TODO: CPAL
#  $(PFX)_EXTRA_INC:= $($(PFX)_PFMDIR)_I2C_CPAL_Driver/inc
#  $(PFX)_EXTRA_SRC:= $($(PFX)_PFMDIR)_I2C_CPAL_Driver/src
endif

ifeq ($($(PFX)_PFMDIR),STM32F37x)
  $(PFX)_MODULES := adc can cec comp crc dac dbgmcu dma exti flash gpio i2c iwdg misc pwr rcc rtc sdadc spi syscfg tim usart wwdg
  $(PFX)_PREFIX  := stm32f37x
  $(PFX)_EXTRA   := 
  $(PFX)_ARM_MATH:= ARM_MATH_CM3
  # TODO: CPAL
#  $(PFX)_EXTRA_INC:= $($(PFX)_PFMDIR)_I2C_CPAL_Driver/inc
#  $(PFX)_EXTRA_SRC:= $($(PFX)_PFMDIR)_I2C_CPAL_Driver/src
endif

ifeq ($($(PFX)_PFMDIR),STM32F4xx)
  $(PFX)_MODULES := adc can crc cryp_aes cryp cryp_des cryp_tdes dac dbgmcu dcmi dma dma2d exti flash gpio hash hash_md5 hash_sha1 i2c iwdg ltdc pwr rcc rng rtc sai sdio spi syscfg tim usart wwdg
  $(PFX)_EXTRA   := misc
  # Devices which have the FMC peripheral instead of FSMC
  ifneq ($(filter STM32F427_437xx STM32F429_439xx,$(PLATFORM)),)
    $(PFX)_MODULES += fmc
  else
    # Devices which have neither FMC nor FSMC
    ifeq ($(filter STM32F401xx,$(PLATFORM)),)
      $(PFX)_MODULES += fsmc
    endif
  endif
  $(PFX)_PREFIX  := stm32f4xx
  $(PFX)_ARM_MATH:= ARM_MATH_CM4
endif

ifeq ($($(PFX)_PFMDIR),STM32L1xx)
  $(PFX)_MODULES := adc aes aes_util comp crc dac dbgmcu dma exti flash flash_ramfunc fsmc gpio i2c iwdg lcd opamp pwr rcc rtc sdio spi syscfg tim usart wwdg
  $(PFX)_EXTRA   := misc
  $(PFX)_PREFIX  := stm32l1xx
  $(PFX)_ARM_MATH:= ARM_MATH_CM3
endif

# Convert the module list into a list of files we need to build
$(PFX)_REQS := $(addsuffix .o, $(addprefix $($(PFX)_PFP)obj/,$(addprefix $($(PFX)_PREFIX)_,$($(PFX)_MODULES)) $($(PFX)_EXTRA)))

# Create a list of files generated by the CMSIS DSP library
$(PFX)_CMSIS_DSP := $(shell find $($(PFX)_PFP)CMSIS/DSP_Lib/Source -name *.c)
$(PFX)_CMSIS_DSP := $(subst $($(PFX)_PFP),$($(PFX)_PFP)obj/,$($(PFX)_CMSIS_DSP:.c=.o))

#############################################################################
# Global options and build rules
#############################################################################

# Set local CFLAGS for debug mode if library debugging is enabled
ifneq ($(STM_STDPERIPH_DEBUG),)
  $(PFX)_CFLAGS += -g -ggdb -DUSE_FULL_ASSERT
endif

# Set global CFLAGS to enable the Standard Peripheral Library to be used by client applications
CFLAGS += -D$(PLATFORM) -DUSE_STDPERIPH_DRIVER
CFLAGS += -I$($(PFX)_PFP)CMSIS/Include -I$($(PFX)_PFP)CMSIS/Device/ST/$($(PFX)_PFMDIR)/Include -I$($(PFX)_PFP)$($(PFX)_PFMDIR)_StdPeriph_Driver/inc

# This is the path and name of the Standard Peripheral Library .a file
SPL_LIB := $($(PFX)_PFP)spl_$($(PFX)_PFMDIR).a

# Clean up the SPL build directory
vendor_st_stm32_stdperiph_clean:
	-@echo
	-@echo ">>> Cleaning STM32 Standard Peripheral Library"
	-@echo
	-@rm $($(PFX)_PFP)obj/*.o $(SPL_LIB) 2>/dev/null || true
	-@rm -rf $($(PFX)_PFP)obj/CMSIS 2>/dev/null || true

#############################################################################
# Weird magic present below this point...
#############################################################################

# Build the SPL itself
$(SPL_LIB): $($(PFX)_REQS) $($(PFX)_CMSIS_DSP)
	$(AR) -cr $@ $^

# Build rule for SPD source files
$($(PFX)_PFP)obj/%.o: $($(PFX)_PFP)$($(PFX)_PFMDIR)_StdPeriph_Driver/src/%.c
	$(Q)test -d $(@D) || mkdir -pm 775 $(@D)
	$(Q)$(CC) -c $($(PFX)_CFLAGS) $(CFLAGS) -o $@ $<

# Build rule for CMSIS source files
$($(PFX)_PFP)obj/CMSIS/%.o: $($(PFX)_PFP)CMSIS/%.c
	$(Q)test -d $(@D) || mkdir -pm 775 $(@D)
	$(Q)$(CC) -c $($(PFX)_CFLAGS) $(CFLAGS) $(addprefix -D,$($(PFX)_ARM_MATH)) -o $@ $<

