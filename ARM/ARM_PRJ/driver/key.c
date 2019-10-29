#include<stm32f4xx.h>
#include "key.h"

static int initialize(void);

KEY_T key = {
	.initialize = initialize
};

static int initialize(void)
{
	GPIO_InitTypeDef   GPIO_uInitStructure;

	RCC_AHB1PeriphClockCmd(RCC_AHB1Periph_GPIOH,ENABLE);
	GPIO_uInitStructure.GPIO_Pin = GPIO_Pin_15;                            //设置连接按键的IO端口
	GPIO_uInitStructure.GPIO_Mode = GPIO_Mode_IN;                          //设置端口为输入模式
	GPIO_uInitStructure.GPIO_Speed = GPIO_Speed_100MHz;                    //设置速度为第三级
	GPIO_uInitStructure.GPIO_PuPd = GPIO_PuPd_NOPULL;                      //设置输入端口不变化 

	GPIO_Init(GPIOH, &GPIO_uInitStructure);                                //把设置的参数用到结构体

	return 0;
}
