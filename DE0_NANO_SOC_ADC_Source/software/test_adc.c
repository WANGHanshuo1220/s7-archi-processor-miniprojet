/*
 * "Hello World" example.
 *
 * This example prints 'Hello from Nios II' to the STDOUT stream. It runs on
 * the Nios II 'standard', 'full_featured', 'fast', and 'low_cost' example
 * designs. It runs with or without the MicroC/OS-II RTOS and requires a STDOUT
 * device in your system's hardware.
 * The memory footprint of this hosted application is ~69 kbytes by default
 * using the standard reference design.
 *
 * For a reduced footprint version of this template, and an explanation of how
 * to reduce the memory footprint for a given application, see the
 * "small_hello_world" template.
 *
 */

#include <stdio.h>
#include <io.h>
#include <unistd.h>

#include "system.h"

void main(void){
	int ch = 0;
	const int nReadNum = 10; // max 1024
	int i, Value, nIndex=0;
	int j=0;
	volatile int * LED_ptr	= (int *) 0x00081000;	// red LED address

	printf("ADC Demo\r\n");
	while(1){
		ch = IORD(SW_BASE, 0x00) & 0x07;

		printf("======================= %d, ch=%d\r\n", nIndex++, ch);
		// set measure number for ADC convert
		IOWR(ADC_LTC2308_BASE, 0x01, nReadNum);


		// start measure
		IOWR(ADC_LTC2308_BASE, 0x00, (ch << 1) | 0x00);
		IOWR(ADC_LTC2308_BASE, 0x00, (ch << 1) | 0x01);
		IOWR(ADC_LTC2308_BASE, 0x00, (ch << 1) | 0x00);
		usleep(1);

		// wait measure done
		while ((IORD(ADC_LTC2308_BASE,0x00) & 0x01) == 0x00);

		// read adc value
		for(i=0;i<nReadNum;i++){
			Value = IORD(ADC_LTC2308_BASE, 0x01);
			printf("CH%d=%.3fV (0x%04x)\r\n", ch, (float)Value/1000.0, Value);
		}
		*(LED_ptr) =j++;
		if (j==255) j=0;
		usleep(200*1000);
	} // while
}
