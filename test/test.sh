#!/bin/sh

set -e

PLATFORMS='STM32F10X_LD_VL STM32F10X_MD_VL STM32F10X_HD_VL STM32F10X_CL STM32L1XX_MD STM32L1XX_MDP STM32L1XX_HD STM32F40_41xxx STM32F427_437xx STM32F429_439xx STM32F401xx'

for pfm in $PLATFORMS; do
	echo ">>>> Testing $pfm"
	echo
	make PLATFORM=$pfm clean 2>&1 >/dev/null
	make PLATFORM=$pfm all 2>&1 >/dev/null
	make PLATFORM=$pfm clean 2>&1 >/dev/null
done

echo "All OK"
