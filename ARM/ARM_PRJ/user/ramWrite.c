#include <stm32f4xx.h>
#include "fsmc.h"
#include "ramWrite.h"

void ram_write_init(void )
{
	ram_write_wave(ch1,idle_mode);
	ram_write_amp(ch1,0);
	ram_write_freq(ch1,1);
	ram_write_duty(ch1,1);
	ram_write_wave(ch2,idle_mode);
	ram_write_amp(ch2,0);
	ram_write_freq(ch2,1);
	ram_write_duty(ch2,1);
	ram_write_wave(ch3,idle_mode);
	ram_write_amp(ch3,0);
	ram_write_freq(ch3,1);
	ram_write_duty(ch3,1);
	ram_write_wave(ch4,idle_mode);
	ram_write_amp(ch4,0);
	ram_write_freq(ch4,1);
	ram_write_duty(ch4,1);
}

void ram_write_wave(CHN_TYP chn, WAVE_TYP wave)
{
	uint16_t addr;
	uint16_t data;
	
	addr = chn*4 + WAVE;
	data = (uint16_t) wave;
	
	fpga_write(addr,data);
}


void ram_write_amp(CHN_TYP chn, float amp)
{
	const float amp_offset = 0.66f;
	uint16_t addr,data;
	
	addr = chn*4 + AMPX10;
	data = (uint16_t) (amp*amp_offset*10);
	
	fpga_write(addr,data);
}

void ram_write_freq(CHN_TYP chn, uint16_t freq)
{
	uint16_t addr;
	uint16_t data;
	
	addr = chn*4 + FREQ;
	if(freq<=0) data = 0;
	else if(freq>=100)
		data = 100;
	else data = freq;
	
	fpga_write(addr,data);
}

void ram_write_duty(CHN_TYP chn, uint16_t duty)
{
	uint16_t addr;
	uint16_t data;
	
	addr = chn*4 + DUTY;
	if(duty<=0) data = 0;
	else if(duty>=100)
		data = 100;
	else data = duty;
	
	fpga_write(addr,data);
}
