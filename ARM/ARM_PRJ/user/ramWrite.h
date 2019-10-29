#ifndef __RAMWRITE_H_
#define __RAMWRITE_H_
#include <stm32f4xx.h>

#define WAVE 		0
#define AMPX10 	1
#define FREQ		2
#define DUTY		3

typedef enum{
	idle_mode = 0,
	sine_wave,
	tri_wave,
	square_wave,
	dc_mode
} WAVE_TYP;

typedef enum{
	ch1 = 0,
	ch2,
	ch3,
	ch4
} CHN_TYP;



extern void ram_write_init(void );
extern void ram_write_wave(CHN_TYP chn, WAVE_TYP wave);
extern void ram_write_amp(CHN_TYP chn, float amp);
extern void ram_write_freq(CHN_TYP chn, uint16_t freq);
extern void ram_write_duty(CHN_TYP chn, uint16_t duty);

#endif

