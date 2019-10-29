#ifndef __DELAY_H_
#define __DELAY_H_

#include <stm32f4xx.h>

extern void delay_init(void );
extern void delay_us(uint32_t nus);
extern void delay_ms(uint16_t nms);

#endif
