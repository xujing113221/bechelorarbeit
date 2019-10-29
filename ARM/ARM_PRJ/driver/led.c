#include<stm32f4xx.h>

#include "led.h"

static int initialize(void);

LED_T led = {
	.initialize = initialize
};


static int initialize(void)
{
	GPIO_InitTypeDef   GPIO_uInitStructure;

	//LED IO��ʼ��
	RCC_AHB1PeriphClockCmd(RCC_AHB1Periph_GPIOI,ENABLE);
	GPIO_uInitStructure.GPIO_Pin = GPIO_Pin_5 | GPIO_Pin_6 | GPIO_Pin_7;    //����������ɫLED�Ƶ�IO�˿�
	GPIO_uInitStructure.GPIO_Mode = GPIO_Mode_OUT;                          //���ö˿�Ϊ���ģʽ
	GPIO_uInitStructure.GPIO_OType = GPIO_OType_PP;                         //�������
	GPIO_uInitStructure.GPIO_PuPd = GPIO_PuPd_UP;                           //����
	GPIO_uInitStructure.GPIO_Speed = GPIO_Speed_100MHz;                     //�����ٶ�Ϊ������

	GPIO_Init(GPIOI,&GPIO_uInitStructure);

	//PI5��PI6��PI7����ɫLED�ƣ�PI5��PI6��PI7�øߵ�λ����Ϩ��
	GPIO_SetBits(GPIOI,GPIO_Pin_5 | GPIO_Pin_6 | GPIO_Pin_7);

	return 0;
}
