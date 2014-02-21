
CROSS	:=	arm-none-eabi-
CC		:=	$(CROSS)gcc
LD		:=	$(CROSS)gcc
AR		:=	$(CROSS)ar
RANLIB	:=	$(CROSS)ranlib
OBJDUMP	:=	$(CROSS)objdump
OBJCOPY	:=	$(CROSS)objcopy

ifneq ($(filter STM32F40_41xxx STM32F427_437xx STM32F429_439xx STM32F401xx,$(PLATFORM)),)
  # STM32F4 (Cortex M4F) has hardware floating point
  CFLAGS	:=	-mthumb -mcpu=cortex-m4 -mfloat-abi=softfp -mfpu=fpv4-sp-d16 -fsingle-precision-constant -D__FPU_PRESENT=1 -D__FPU_USED=1
else
  CFLAGS	:=	-mthumb -mcpu=cortex-m3
endif
#-DSTM32F10X_MD_VL -DUSE_STDPERIPH_DRIVER

# to write to flash then run
LDFLAGS+=-Wl,-T,src/stm32_flash.ld

export CROSS CC LD AR RANLIB OBJDUMP CFLAGS

