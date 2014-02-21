
CROSS	:=	arm-none-eabi-
CC		:=	$(CROSS)gcc
LD		:=	$(CROSS)gcc
AR		:=	$(CROSS)ar
RANLIB	:=	$(CROSS)ranlib
OBJDUMP	:=	$(CROSS)objdump
OBJCOPY	:=	$(CROSS)objcopy

# Assume Cortex M3 to start with
CFLAGS	:=	-mthumb -mcpu=cortex-m3

# Cortex-M0 devices
ifneq ($(filter STM32F030 STM32F031 STM32F051 STM32F072 STM32F042 STM23F0XX_MD STM32F0XX_LD STM32F0XX_HD STM32F030X8 STM32F030X6,$(PLATFORM)),)
  CFLAGS	:=	-mthumb -mcpu=cortex-m0
endif

# Cortex-M4F devices
ifneq ($(filter STM32F40_41xxx STM32F427_437xx STM32F429_439xx STM32F401xx,$(PLATFORM)),)
  # STM32F4 (Cortex M4F) has hardware floating point
  CFLAGS	:=	-mthumb -mcpu=cortex-m4 -mfloat-abi=softfp -mfpu=fpv4-sp-d16 -fsingle-precision-constant -D__FPU_PRESENT=1 -D__FPU_USED=1
else
endif

# to write to flash then run
LDFLAGS+=-Wl,-T,src/stm32_flash.ld

export CROSS CC LD AR RANLIB OBJDUMP CFLAGS

