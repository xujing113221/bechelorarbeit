#ifndef __led_h__
#define __led_h__

//ºìµÆ<----->PI5
#define LED_RED_OFF GPIO_SetBits(GPIOI,GPIO_Pin_5)
#define LED_RED_ON  GPIO_ResetBits(GPIOI,GPIO_Pin_5)
//ÂÌµÆ<----->PI6
#define LED_GREEN_OFF GPIO_SetBits(GPIOI,GPIO_Pin_6)
#define LED_GREEN_ON  GPIO_ResetBits(GPIOI,GPIO_Pin_6)
//À¶µÆ<----->PI7
#define LED_BLUE_OFF GPIO_SetBits(GPIOI,GPIO_Pin_7)
#define LED_BLUE_ON  GPIO_ResetBits(GPIOI,GPIO_Pin_7)


typedef struct {
	int (* initialize)(void);
}LED_T;


extern LED_T led;

#endif //__led_h__
