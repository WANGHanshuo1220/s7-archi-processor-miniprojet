-- #############################################################################
-- DE0_nano_SoC_ADC.vhd
--
-- BOARD         : DE0_nano_SoC from Terasic
-- Author        : Yann DOUZE from Sorbonne Universit√©, Polytech Sorbonne
-- Revision      : 1.5
-- Creation date : 09/12/2019
--
-- GROUP  : specify a particular interface (ex: HPS_)
-- NAME   : signal name (ex: CONFIG, D, ...)
-- bit    : signal index
-- _N     : to specify an active-low signal
-- #############################################################################

library ieee;
use ieee.std_logic_1164.all;

entity DE0_nano_SoC_ADC is
    port(
	--//////////////////////////////////
	-- FPGA Pins
	--//////////////////////////////////
        -- ADC
        ADC_CONVST        : out   std_logic;
        ADC_SCK        : out   std_logic;
        ADC_SDI        : out    std_logic;
        ADC_SDO        : in   std_logic;

        -- CLOCK
		FPGA_CLK1_50        : in    std_logic;
		FPGA_CLK2_50        : in    std_logic;
		FPGA_CLK3_50        : in    std_logic;

        -- KEY
        KEY : in std_logic_vector(1 downto 0);

        -- LED
        LED : out std_logic_vector(7 downto 0);

        -- SW
		SW : in std_logic_vector(3 downto 0);
        
        -- GPIO_0
		GPIO_0           : inout std_logic_vector(35 downto 0);

        -- GPIO_1
		GPIO_1           : inout std_logic_vector(35 downto 0)
	
    );
end entity ;

architecture rtl of DE0_nano_SoC_ADC is
    component DE0_NANO_SOC_QSYS is
        port (
            clk_clk                        : in  std_logic                    := 'X';             -- clk
            reset_reset_n                  : in  std_logic                    := 'X';             -- reset_n
            adc_ltc2308_conduit_end_CONVST : out std_logic;                                       -- CONVST
            adc_ltc2308_conduit_end_SCK    : out std_logic;                                       -- SCK
            adc_ltc2308_conduit_end_SDI    : out std_logic;                                       -- SDI
            adc_ltc2308_conduit_end_SDO    : in  std_logic                    := 'X';             -- SDO
            sw_external_connection_export  : in  std_logic_vector(3 downto 0) := (others => 'X'); -- export
            pll_sys_locked_export          : out std_logic;                                       -- export
            pll_sys_outclk2_clk            : out std_logic;                                       -- clk
            --led_external_connection_export : out std_logic_vector(7 downto 0)                     -- export
				avalon_leds_output_readdata             : out std_logic_vector(7 downto 0);                    -- readdata
            avalon_echo_input_beginbursttransfer    : in  std_logic                    := 'X';             -- beginbursttransfer
            avalon_trig_output_writeresponsevalid_n : out std_logic  
		  );
    end component DE0_NANO_SOC_QSYS;
begin
    u0 : component DE0_NANO_SOC_QSYS
        port map (
            clk_clk                        => FPGA_CLK1_50,                        --                     clk.clk
            reset_reset_n                  => KEY(0),                  --                   reset.reset_n
            adc_ltc2308_conduit_end_CONVST => ADC_CONVST, -- adc_ltc2308_conduit_end.CONVST
            adc_ltc2308_conduit_end_SCK    => ADC_SCK,    --                        .SCK
            adc_ltc2308_conduit_end_SDI    => ADC_SDI,    --                        .SDI
            adc_ltc2308_conduit_end_SDO    => ADC_SDO,    --                        .SDO
            sw_external_connection_export  => SW,  --  sw_external_connection.export
            --led_external_connection_export => LED  -- led_external_connection.export
				avalon_leds_output_readdata             => LED,             --      avalon_leds_output.readdata
            avalon_echo_input_beginbursttransfer    => GPIO_0(2),    --       avalon_echo_input.beginbursttransfer
            avalon_trig_output_writeresponsevalid_n => GPIO_0(0)   --      avalon_trig_output.writeresponsevalid_n
        
        );

end architecture;
