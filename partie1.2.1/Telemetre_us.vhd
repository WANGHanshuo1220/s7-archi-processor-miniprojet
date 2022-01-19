library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity Telemetre_us is
  generic( period1 : integer := 600;
           period2 : integer := 3000000);
  port( clk : in std_logic;
        rst : in std_logic;
        trig: out std_logic;
        echo: in std_logic;
        LEDR: out std_logic_vector(7 downto 0);
        
        read: in std_logic;
        chipselect: in std_logic;
        readdata: out std_logic_vector(31 downto 0)
        );
end entity;

architecture one of Telemetre_us is

signal trig_counter: unsigned(31 downto 0) := (others => '0');
signal wait_counter: unsigned(31 downto 0) := (others => '0');
signal output_trig : std_logic;
signal output_LEDR : std_logic_vector(7 downto 0) := (others => '1');
signal duree_counter: unsigned(31 downto 0) := (others => '0');
signal state: std_logic := '0';
signal distance: unsigned(31 downto 0);

begin
  
  count: process(rst, clk)
  begin
    if rst = '0' then
      trig_counter <= (others => '0');
      wait_counter <= (others => '0');
    elsif clk'event and clk = '1' then
      if trig_counter <= To_unsigned(period1,32) then
        trig_counter <= trig_counter + 1;
      else
        if wait_counter <= To_unsigned(period2,32) then
          wait_counter <= wait_counter + 1;
        else
          trig_counter <= (others => '0');
          wait_counter <= (others => '0');
        end if;
      end if;
    end if;
  end process;
  
  output_cycle: process(rst,clk)
  begin
    if rst = '0' then
      output_trig <= '0';
    elsif clk'event and clk = '1' then
      if trig_counter <= To_unsigned(period1,32) then
        output_trig <= '1';
      elsif trig_counter > To_unsigned(period1,32) then
        output_trig <= '0';
      end if;
    end if;
  end process;
  
  LED: process(rst, clk)
  begin
    if rst = '0' then 
      output_LEDR <= (others => '0');
    elsif clk'event and clk = '1' then
		if echo = '0' then
			if state = '1' then
				if duree_counter <= x"00003a98" then output_LEDR <= "00000001";
				elsif duree_counter <= x"00007530" then output_LEDR <= "00000011";
				elsif duree_counter <= x"0000ea60" then output_LEDR <= "00000111";
				elsif duree_counter <= x"0001d4c0" then output_LEDR <= "00001111";
				elsif duree_counter <= x"0002bf20" then output_LEDR <= "00011111";
				elsif duree_counter <= x"00047c70" then output_LEDR <= "00111111";
				elsif duree_counter <= x"000900b0" then output_LEDR <= "01111111";
				else output_LEDR <= "11111111";
				end if;
				state <= '0';
				distance <= duree_counter;
			elsif state = '0' then
				duree_counter <= (others => '0');
			end if;
		elsif echo = '1' then
			state <= '1';
			duree_counter <= duree_counter + 1;
		end if;
    end if;
  end process;

  LEDR <= output_LEDR;
  trig <= output_trig;
  readdata <= std_logic_vector(distance) when chipselect = '1' and read = '1' else (others => '0');
  
end one;