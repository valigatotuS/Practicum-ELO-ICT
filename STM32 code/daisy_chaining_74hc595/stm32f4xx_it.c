
/* Includes ------------------------------------------------------------------*/
#include "stm32f4xx_hal.h"
#include "stm32f4xx.h"
#include "stm32f4xx_it.h"
#include "defines.h"
/* USER CODE BEGIN 0 */

/* USER CODE END 0 */
/* External variables --------------------------------------------------------*/

extern DMA_HandleTypeDef hdma_spi1_tx;
extern SPI_HandleTypeDef hspi1;
extern TIM_HandleTypeDef htim1;
extern volatile uint16_t seconds;
extern volatile uint32_t delaytimer;
extern uint32_t dmaStopTime;




void DMA2_Stream3_IRQHandler(void)
{
	/* USER CODE BEGIN DMA2_Stream3_IRQn 0 */
	dmaStopTime = HAL_GetTick();
	setLED(LEDRED_pin, GPIO_PIN_RESET);
	/* USER CODE END DMA2_Stream3_IRQn 0 */
	HAL_DMA_IRQHandler(&hdma_spi1_tx);
	/* USER CODE BEGIN DMA2_Stream3_IRQn 1 */

	/* USER CODE END DMA2_Stream3_IRQn 1 */
}

/**
 * @brief This function handles System tick timer.
 */
void SysTick_Handler(void)
{
	/* USER CODE BEGIN SysTick_IRQn 0 */

	/* USER CODE END SysTick_IRQn 0 */
	HAL_IncTick();
	HAL_SYSTICK_IRQHandler();
	/* USER CODE BEGIN SysTick_IRQn 1 */
	if(delaytimer != 0) delaytimer--;
	/* USER CODE END SysTick_IRQn 1 */
}

/**
 * @brief This function handles TIM1 Trigger and Commutation interrupts and TIM11 global interrupt.
 */
void TIM1_TRG_COM_TIM11_IRQHandler(void)
{
	/* USER CODE BEGIN TIM1_TRG_COM_TIM11_IRQn 0 */

	/* USER CODE END TIM1_TRG_COM_TIM11_IRQn 0 */
	HAL_TIM_IRQHandler(&htim1);
	/* USER CODE BEGIN TIM1_TRG_COM_TIM11_IRQn 1 */

	/* USER CODE END TIM1_TRG_COM_TIM11_IRQn 1 */
}

/**
 * @brief This function handles TIM1 Break interrupt and TIM9 global interrupt.
 */
void TIM1_BRK_TIM9_IRQHandler(void)
{
	/* USER CODE BEGIN TIM1_BRK_TIM9_IRQn 0 */

	/* USER CODE END TIM1_BRK_TIM9_IRQn 0 */
	HAL_TIM_IRQHandler(&htim1);
	/* USER CODE BEGIN TIM1_BRK_TIM9_IRQn 1 */

	/* USER CODE END TIM1_BRK_TIM9_IRQn 1 */
}

/**
 * @brief This function handles TIM1 Capture Compare interrupt.
 */
void TIM1_CC_IRQHandler(void)
{
	/* USER CODE BEGIN TIM1_CC_IRQn 0 */

	/* USER CODE END TIM1_CC_IRQn 0 */
	HAL_TIM_IRQHandler(&htim1);
	/* USER CODE BEGIN TIM1_CC_IRQn 1 */

	/* USER CODE END TIM1_CC_IRQn 1 */
}

/**
 * @brief This function handles TIM1 Update interrupt and TIM10 global interrupt.
 */
void TIM1_UP_TIM10_IRQHandler(void)
{
	/* USER CODE BEGIN TIM1_UP_TIM10_IRQn 0 */

	/* USER CODE END TIM1_UP_TIM10_IRQn 0 */
	HAL_TIM_IRQHandler(&htim1);
	/* USER CODE BEGIN TIM1_UP_TIM10_IRQn 1 */
	/* !!! QUESTO E' L'UNICO CHE ENTRA !!! */
	/* CONFERMATO: entra una volta al secondo */
	/* toggle green led */
	static uint8_t v = 0;
	if(v == 0) {
		v = 1;
		setLED(LEDGREEN_pin, GPIO_PIN_SET);
	}else{
		v = 0;
		setLED(LEDGREEN_pin, GPIO_PIN_RESET);
	}
	seconds++;
	/* USER CODE END TIM1_UP_TIM10_IRQn 1 */
}

/**
 * @brief This function handles SPI1 global interrupt.
 */
void SPI1_IRQHandler(void)
{
	/* USER CODE BEGIN SPI1_IRQn 0 */

	/* USER CODE END SPI1_IRQn 0 */
	HAL_SPI_IRQHandler(&hspi1);
	/* USER CODE BEGIN SPI1_IRQn 1 */

	/* USER CODE END SPI1_IRQn 1 */
}

