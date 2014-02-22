/**
  ******************************************************************************
  * @file    Project/STM32L1xx_StdPeriph_Templates/main.h 
  * @author  MCD Application Team
  * @version V1.1.1
  * @date    13-April-2012
  * @brief   Header for main.c module
  ******************************************************************************
  * @attention
  *
  * <h2><center>&copy; COPYRIGHT 2012 STMicroelectronics</center></h2>
  *
  * Licensed under MCD-ST Liberty SW License Agreement V2, (the "License");
  * You may not use this file except in compliance with the License.
  * You may obtain a copy of the License at:
  *
  *        http://www.st.com/software_license_agreement_liberty_v2
  *
  * Unless required by applicable law or agreed to in writing, software 
  * distributed under the License is distributed on an "AS IS" BASIS, 
  * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  * See the License for the specific language governing permissions and
  * limitations under the License.
  *
  ******************************************************************************
  */
  
/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __MAIN_H
#define __MAIN_H

/* Includes ------------------------------------------------------------------*/
#include "stm32l1xx.h"
#include <stdio.h>

#if defined (USE_STM32L152_EVAL)
 #include "stm32l152_eval.h"
 #include "stm32l152_eval_lcd.h"
 #include "stm32l152_eval_spi_sd.h"
 #include "stm32l152_eval_i2c_tsensor.h"
 #include "stm32l152_eval_i2c_ee.h"
 #include "stm32l152_eval_glass_lcd.h"
#elif defined (USE_STM32L152D_EVAL)
 #include "stm32l152d_eval.h"
 #include "stm32l152d_eval_lcd.h"
 #include "stm32l152d_eval_spi_ee.h"
 #include "stm32l152d_eval_sdio_sd.h"
 #include "stm32l152d_eval_i2c_tsensor.h"
 /*#include "stm32l152d_eval_i2c_ee.h"*/
 #include "stm32l152d_eval_glass_lcd.h"
 #include "stm32l152d_eval_fsmc_sram.h"
 #include "stm32l152d_eval_fsmc_nor.h"
#endif

/* Exported types ------------------------------------------------------------*/
/* Exported constants --------------------------------------------------------*/
/* Exported macro ------------------------------------------------------------*/
/* Exported functions ------------------------------------------------------- */
void TimingDelay_Decrement(void);
void Delay(__IO uint32_t nTime);

#endif /* __MAIN_H */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
