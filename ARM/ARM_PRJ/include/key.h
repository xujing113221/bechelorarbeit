#ifndef __key_h__
#define __key_h__

#define KEY_INPUT  GPIO_ReadInputDataBit(GPIOH,GPIO_Pin_15)

typedef struct {
	int (* initialize)(void);
}KEY_T;

extern KEY_T key;

#endif //__led_h__
