#ifndef __fsmc_h__
#define __fsmc_h__

#define fpga_write(offset,data)	*((volatile unsigned short int *)(0x60000000 + (offset << 17))) = data

#define fpga_read(offset)	*((volatile unsigned short int *)(0x60000000 + (offset << 17)))


typedef struct{
	int (* initialize)(void);
}FSMC_T;


extern FSMC_T fsmc;

#endif //__fsmc_h__
