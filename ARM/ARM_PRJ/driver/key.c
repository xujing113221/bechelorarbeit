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
	GPIO_uInitStructure.GPIO_Pin = GPIO_Pin_15;                            //�������Ӱ�����IO�˿�
	GPIO_uInitStructure.GPIO_Mode = GPIO_Mode_IN;                          //���ö˿�Ϊ����ģʽ
	GPIO_uInitStructure.GPIO_Speed = GPIO_Speed_100MHz;                    //�����ٶ�Ϊ������
	GPIO_uInitStructure.GPIO_PuPd = GPIO_PuPd_NOPULL;                      //��������˿ڲ��仯 

	GPIO_Init(GPIOH, &GPIO_uInitStructure);                                //�����õĲ����õ��ṹ��

	return 0;
}
