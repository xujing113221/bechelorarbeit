#include <stm32f4xx.h>
#include "usart.h"


static int initialize_usart4(unsigned long int baudrate);

UART_T usart4 = {
	.receive_ok_flag=0,
	.counter=0,
	.initialize=initialize_usart4,
	};
//--------------------------- Function --------------------------//
//USART4 DEBUG
/*
 * Name               : initialize_usart4
 * Description        : ---
 * Author             : XiaomaGee
 * 
 * History
 * -------------------
 * Rev                : 0.00
 * Date               : 01/12/2016
 *
 * create.
 * -------------------
 */
static int initialize_usart4(unsigned long int baudrate)
{	
	GPIO_InitTypeDef GPIO_InitStructure;
	USART_InitTypeDef USART_InitStructure;
	NVIC_InitTypeDef NVIC_InitStructure;
	
	RCC_AHB1PeriphClockCmd(RCC_AHB1Periph_GPIOA,ENABLE);             // GPIO时钟使能
	
	GPIO_InitStructure.GPIO_Pin = GPIO_Pin_0;                        //PA0为复用推挽输出
	GPIO_InitStructure.GPIO_Mode = GPIO_Mode_AF;
	GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
	GPIO_Init(GPIOA, &GPIO_InitStructure);    

	GPIO_InitStructure.GPIO_Pin = GPIO_Pin_1;                        //PA1为浮空输入
	GPIO_InitStructure.GPIO_Mode = GPIO_Mode_AF;
	GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
	GPIO_Init(GPIOA, &GPIO_InitStructure);
	
	GPIO_PinAFConfig(GPIOA,GPIO_PinSource0,GPIO_AF_UART4);           //PA0引脚复用为UART4
	GPIO_PinAFConfig(GPIOA,GPIO_PinSource1,GPIO_AF_UART4);           //PA1引脚复用为UART4
	
	USART_DeInit(UART4);
	RCC_APB1PeriphClockCmd(RCC_APB1Periph_UART4, ENABLE);            //UART4时钟使能
	  
	USART_InitStructure.USART_BaudRate = baudrate;                   //波特率
	USART_InitStructure.USART_WordLength = USART_WordLength_8b;      //8个数据位
	USART_InitStructure.USART_StopBits = USART_StopBits_1;           //1个停止位
	USART_InitStructure.USART_Parity = USART_Parity_No ;             //无奇偶校验位
	USART_InitStructure.USART_HardwareFlowControl = USART_HardwareFlowControl_None;
	USART_InitStructure.USART_Mode = USART_Mode_Rx | USART_Mode_Tx;  //收发模式
	USART_Init(UART4, &USART_InitStructure);                         //初始化UART4
	USART_Cmd(UART4, ENABLE);                                        //使能UART4
	USART_ITConfig(UART4,USART_IT_PE,ENABLE);
	USART_ITConfig(UART4,USART_IT_RXNE,ENABLE);                      //打开UART4的中断
	
	NVIC_InitStructure.NVIC_IRQChannel = UART4_IRQn;
	NVIC_InitStructure.NVIC_IRQChannelPreemptionPriority = 1; 
	NVIC_InitStructure.NVIC_IRQChannelSubPriority = 0;
	NVIC_InitStructure.NVIC_IRQChannelCmd = ENABLE;
	NVIC_Init(&NVIC_InitStructure);
	
	//while(USART_GetFlagStatus(UART4,USART_FLAG_TXE)==RESET);
  //printf(" UART4 Initialize succeeded... \r\n");
	
	return 0;
}


int fputc(int ch,FILE *f)
{
  /*将Printf内容发往串口*/
  USART_SendData(UART4,(unsigned char)ch);
  while(USART_GetFlagStatus(UART4,USART_FLAG_TC) != SET);
  return (ch);
}

int UART4_IRQHandler(void)
{	
	uint8_t c;
  if(USART_GetFlagStatus(UART4,USART_FLAG_RXNE) != 0){        
		c = USART_ReceiveData(UART4);
		usart4.receive_buffer[usart4.counter]=c; 
		
		switch (usart4.counter) {
			case 0: if (c == 0xAA) usart4.counter++; else usart4.counter = 0; break;
			case 1: if (c == 0xAA) usart4.counter++; else usart4.counter = 0; break;
			case 2: usart4.counter++; break;
			case 3: usart4.counter++; break;
			case 4: if (c == 0xFF) {
								usart4.counter = 0;
								usart4.receive_ok_flag = 1;
							}else 
								usart4.counter = 0; 
							break;
			default: usart4.counter = 0;
			}
		while(USART_GetFlagStatus(UART4,USART_FLAG_TC) != SET); 
 		}
	return 0;			
}

