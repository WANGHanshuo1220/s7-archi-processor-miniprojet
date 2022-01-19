
module DE0_NANO_SOC_QSYS (
	adc_ltc2308_conduit_end_CONVST,
	adc_ltc2308_conduit_end_SCK,
	adc_ltc2308_conduit_end_SDI,
	adc_ltc2308_conduit_end_SDO,
	avalon_echo_input_beginbursttransfer,
	avalon_leds_output_readdata,
	avalon_trig_output_writeresponsevalid_n,
	clk_clk,
	pll_sys_locked_export,
	pll_sys_outclk2_clk,
	reset_reset_n,
	sw_external_connection_export);	

	output		adc_ltc2308_conduit_end_CONVST;
	output		adc_ltc2308_conduit_end_SCK;
	output		adc_ltc2308_conduit_end_SDI;
	input		adc_ltc2308_conduit_end_SDO;
	input		avalon_echo_input_beginbursttransfer;
	output	[7:0]	avalon_leds_output_readdata;
	output		avalon_trig_output_writeresponsevalid_n;
	input		clk_clk;
	output		pll_sys_locked_export;
	output		pll_sys_outclk2_clk;
	input		reset_reset_n;
	input	[3:0]	sw_external_connection_export;
endmodule
