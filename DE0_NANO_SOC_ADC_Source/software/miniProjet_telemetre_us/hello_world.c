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
#include <unistd.h>
#include <io.h>
#include "system.h"

int main()
{
	int nb_clk;
	float distance;
	printf("Nous allons commencer a mesurer!\n");
	while(1){
		usleep(100000);
		wait(3);
		nb_clk = IORD(TELEMETRE_US_INST_BASE,0);
		distance = nb_clk * 0.00034;
		printf("La distance de l'obstacle est: %.2fcm\n",distance);
	}

	return 0;
}

