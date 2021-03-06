
/* Includes ------------------------------------------------------------------*/
#include "stm32f4xx_hal.h"
#include "dma.h"
#include "spi.h"
#include "tim.h"
#include "usart.h"
#include "gpio.h"
#include "defines.h"

/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Private variables ---------------------------------------------------------*/

/* USER CODE BEGIN PV */

/* USER CODE END PV */

/* Private function prototypes -----------------------------------------------*/
void SystemClock_Config(void);
void setLED(uint16_t GPIO_Pin, GPIO_PinState PinState);
void setSTCP(GPIO_PinState PinState);
void delay(uint32_t ms);

/* USER CODE BEGIN PFP */
volatile uint16_t seconds = 0;
volatile uint32_t delaytimer = 0;
volatile uint32_t dmaStartTime = 0;
volatile uint32_t dmaStopTime = 0;
/* USER CODE END PFP */

/* USER CODE BEGIN 0 */
extern TIM_HandleTypeDef htim1;
extern UART_HandleTypeDef huart2;
extern DMA_HandleTypeDef hdma_spi1_tx;
/* USER CODE END 0 */

int main(void)
{

	/* USER CODE BEGIN 1 */

	/* USER CODE END 1 */

	/* MCU Configuration----------------------------------------------------------*/

	/* Reset of all peripherals, Initializes the Flash interface and the Systick. */
	HAL_Init();

	/* Configure the system clock */
	SystemClock_Config();

	/* Initialize all configured peripherals */
	MX_GPIO_Init();
	MX_DMA_Init();
	MX_SPI1_Init();
	MX_TIM1_Init();
	MX_USART2_UART_Init();

	/* USER CODE BEGIN 2 */

	/* start the TIM1 timer */
	HAL_StatusTypeDef res_TIM1 = HAL_TIM_Base_Start_IT(&htim1);

	/* USER CODE END 2 */

	/* USER CODE BEGIN 3 */
	uint16_t t_seconds = seconds;
	uint32_t data = 0x80000000;
	const uint16_t bufflen = 256;
	uint8_t buff[bufflen];
	//	uint32_t data = 0xFF;
	/* Infinite loop */
	while (1)
	{
		if(t_seconds != seconds) {
			// one second passed
			t_seconds = seconds;

			// print number of elapsed seconds to USART
			// HAL_UART_Transmit(&huart2, (uint8_t*)&t_seconds, 2, 2);

			// print collected data regarding dma timing
			uint16_t dmaTimeDiff = (uint16_t)((dmaStopTime-dmaStartTime) & 0xFFFF);
			HAL_UART_Transmit(&huart2, (uint8_t*)&dmaTimeDiff, 2, 2);

			// send 4 bytes to SPI using DMA
			setSTCP(GPIO_PIN_SET);
			setLED(LEDRED_pin, GPIO_PIN_SET);
			// delay(1);
			setSTCP(GPIO_PIN_RESET);

			// last bytes will display on DOUT module
			buff[bufflen-4] = (data & 0xff);
			buff[bufflen-3] = ((data >> 8) & 0xff);
			buff[bufflen-2] = ((data >> 16) & 0xff);
			buff[bufflen-1] = ((data >> 24) & 0xff);
			dmaStartTime = HAL_GetTick();
			HAL_StatusTypeDef dmares = HAL_SPI_Transmit_DMA(&hspi1, buff, bufflen);

			//			HAL_StatusTypeDef dmares = HAL_SPI_Transmit_DMA(&hspi1, (uint8_t *)&data, 4);
			data = data >> 1;
			if(data == 0) data = 0x80000000;
		}
	}
	/* USER CODE END 3 */

}

void delay(uint32_t ms)
{
	delaytimer = ms;
	while(delaytimer > 0);
}

void setSTCP(GPIO_PinState PinState)
{
	HAL_GPIO_WritePin(STCP_port, STCP_pin, PinState);
}

void setLED(uint16_t GPIO_Pin, GPIO_PinState PinState)
{
	HAL_GPIO_WritePin(LEDS_port, GPIO_Pin, PinState);
}

/** System Clock Configuration
 */
void SystemClock_Config(void)
{

	RCC_OscInitTypeDef RCC_OscInitStruct;
	RCC_ClkInitTypeDef RCC_ClkInitStruct;

	__PWR_CLK_ENABLE();

	__HAL_PWR_VOLTAGESCALING_CONFIG(PWR_REGULATOR_VOLTAGE_SCALE1);

	RCC_OscInitStruct.OscillatorType = RCC_OSCILLATORTYPE_HSE;
	RCC_OscInitStruct.HSEState = RCC_HSE_ON;
	RCC_OscInitStruct.PLL.PLLState = RCC_PLL_ON;
	RCC_OscInitStruct.PLL.PLLSource = RCC_PLLSOURCE_HSE;
	RCC_OscInitStruct.PLL.PLLM = 8;
	RCC_OscInitStruct.PLL.PLLN = 336;
	RCC_OscInitStruct.PLL.PLLP = RCC_PLLP_DIV2;
	RCC_OscInitStruct.PLL.PLLQ = 7;
	HAL_RCC_OscConfig(&RCC_OscInitStruct);

	RCC_ClkInitStruct.ClockType = RCC_CLOCKTYPE_SYSCLK|RCC_CLOCKTYPE_PCLK1
			|RCC_CLOCKTYPE_PCLK2;
	RCC_ClkInitStruct.SYSCLKSource = RCC_SYSCLKSOURCE_PLLCLK;
	RCC_ClkInitStruct.AHBCLKDivider = RCC_SYSCLK_DIV1;
	RCC_ClkInitStruct.APB1CLKDivider = RCC_HCLK_DIV4;
	RCC_ClkInitStruct.APB2CLKDivider = RCC_HCLK_DIV2;
	HAL_RCC_ClockConfig(&RCC_ClkInitStruct, FLASH_LATENCY_5);

}

/* USER CODE BEGIN 4 */

/* USER CODE END 4 */

#ifdef USE_FULL_ASSERT

/**
 * @brief Reports the name of the source file and the source line number
 * where the assert_param error has occurred.
 * @param file: pointer to the source file name
 * @param line: assert_param error line source number
 * @retval None
 */
void assert_failed(uint8_t* file, uint32_t line)
{
	/* USER CODE BEGIN 6 */
	/* User can add his own implementation to report the file name and line number,
    ex: printf("Wrong parameters value: file %s on line %d\r\n", file, line) */
	/* USER CODE END 6 */

}

#endif

