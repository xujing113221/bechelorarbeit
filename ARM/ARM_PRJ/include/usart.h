/*
 * FILE                : usart.h
 * DESCRIPTION         : This file is iCore3 usart file header.
 * Author              : XiaomaGee@Gmail.com
 * Copyright           :
 *
 * History
 * --------------------
 * Rev                 : 0.00
 * Date                : 01/12/2016
 *
 * create.
 * --------------------
 */
#ifndef __usart_h__
#define __usart_h__

//----------------------- Include files ------------------------//
#include <stdio.h>
#include <stm32f4xx.h>

//--------------------------- Define ---------------------------//
#define UART_BUFFER_SIZE 5

//------------------------- Data struct ------------------------//
typedef struct{

	char receive_buffer[UART_BUFFER_SIZE];
	int counter;
 
	int receive_ok_flag;
	int baudrate;
	int error;
	int (* initialize)(unsigned long int);

}UART_T;

//----------------------- Extern function ----------------------//
extern UART_T usart4;

//----------------------- Extern variable ----------------------//
#endif // __uart_h__
