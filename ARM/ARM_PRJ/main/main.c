#include "stdio.h"
#include "led.h"
#include "usart.h"
#include "fsmc.h"
#include "key.h"
#include "delay.h"
#include "ramWrite.h"

void PC_control(char* cmd)
{
	uint8_t typ,val;
	CHN_TYP chn;
	
	typ = cmd[2];
	val = cmd[3];
	
	chn = (CHN_TYP)(typ/4);
	switch(typ%4){
		case 0:	ram_write_wave(chn, (WAVE_TYP)val); break;
		case 1:	ram_write_amp(chn, (float)val/10.0f);break;
		case 2:	ram_write_freq(chn, val);break;
		case 3:	ram_write_duty(chn, val);break;
	}
}


int main(void)
{
	usart4.initialize(115200);
	led.initialize();
	key.initialize();
	fsmc.initialize();
	delay_init();
	ram_write_init();
	
	while(1){
			if(usart4.receive_ok_flag == 1){
			usart4.receive_ok_flag = 0;
			PC_control(usart4.receive_buffer);
			printf("%s\r\n",usart4.receive_buffer);
		}
	}
}


/* UART 
if(usart4.receive_ok_flag == 1){
			usart4.receive_ok_flag = 0;
			PC_control(usart4.receive_buffer);
			printf("%s\r\n",usart4.receive_buffer);
		}
*/



//		
////			fpga_write(i,i);
////			delay_us(1);


//		for(i=0; i< 16; i++){
//			data = fpga_read(i);
//			delay_us(1);
//			printf("i = %d,\tdata = %d,\r\n",i,data);
//			delay_ms(200);
//		}


//		LED_RED_ON;
//		LED_GREEN_OFF;
//		LED_BLUE_OFF;
//		delay_ms(300);
//		LED_RED_OFF;
//		LED_GREEN_ON;
//		LED_BLUE_OFF;
//		delay_ms(300);
//		LED_RED_OFF;
//		LED_GREEN_OFF;
//		LED_BLUE_ON;
//		delay_ms(300);
//		if(KEY_INPUT==0){
//			delay_ms(20);
//			if(KEY_INPUT==0)
//				
//				printf("hello:%7.2f\r\n",12.345);
//			while(!KEY_INPUT)
//				delay_ms(20);
//			while(!KEY_INPUT);
//		}
