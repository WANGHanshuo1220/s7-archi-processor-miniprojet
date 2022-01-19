library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity Telemetre_us_banc is
  port( 
    OK: out boolean := True
    );
end entity;
  
architecture one of Telemetre_us_banc is

signal clk: std_logic;
signal rst: std_logic := '1';
signal trig: std_logic;
signal echo: std_logic;
signal LEDR: std_logic_vector(7 downto 0);
signal read: std_logic;
signal chipselect: std_logic;
signal readdata: std_logic_vector(31 downto 0);
 
begin 
 U0: entity work.Telemetre_us port map ( clk, rst, trig, echo, LEDR, read, chipselect, readdata);
  
 clk_gen: process
 begin
   while now <= 150 ms loop
     wait for 10 ns;
     clk <= '1';
     wait for 10 ns;
     clk <= '0';
   end loop;
   wait;
 end process;
 
 test_echo: process
 begin
   wait for 20 ns;
   while now <= 150 ms loop
     
     chipselect <= '1';
     read <= '1';
     
     echo <= '1';    --0-5cm 1led
     wait for 0.2 ms;
     echo <= '0';
     wait for 0.5 ms;
     if(LEDR /= "00000001" and readdata >= x"00003a98") then
       OK <= False;
     end if;
     wait for 0.5 ms;
     
     echo <= '1';  --5-10cm 2led
     wait for 0.5 ms;
     echo <= '0';
     wait for 0.5 ms;
     if(LEDR /= "00000011" and readdata <= x"00003a98" and readdata >= x"00007530") then
       OK <= False;
     end if;
     wait for 0.5 ms;
     
     echo <= '1';  --10-20cm 3led
     wait for 1.1 ms;
     echo <= '0';
     wait for 0.5 ms;
     if(LEDR /= "00000111" and readdata <= x"00007530" and readdata >= x"0000ea60") then
       OK <= False;
     end if;
     wait for 0.5 ms;
     
     echo <= '1';  --20-40cm 4led
     wait for 2.2 ms;
     echo <= '0';
     wait for 0.5 ms;
     if(LEDR /= "00001111" and readdata <= x"0000ea60" and readdata >= x"0001d4c0") then
       OK <= False;
     end if;
     wait for 0.5 ms;
     
     echo <= '1'; --40-60cm 5led
     wait for 3.5 ms;
     echo <= '0';
     wait for 0.5 ms;
     if(LEDR /= "00011111" and readdata <= x"0001d4c0" and readdata >= x"0002bf20") then
       OK <= False;
     end if;  
     wait for 0.5 ms;
     
     echo <= '1';  --60-100cm 6led
     wait for 5.5 ms;
     echo <= '0';
     wait for 0.5 ms;
     if(LEDR /= "00111111" and readdata <= x"0002bf20" and readdata >= x"00047c70") then
       OK <= False;
     end if;  
     wait for 0.5 ms;
     
     echo <= '1';  --100-200cm 7led
     wait for 11 ms;
     echo <= '0';
     wait for 0.5 ms;
     if(LEDR /= "01111111"and readdata <= x"00047c70" and readdata >= x"000900b0") then
       OK <= False;
     end if;  
     wait for 0.5 ms;
     
     echo <= '1';  -->200cm 8led
     wait for 14 ms;
     echo <= '0';
     wait for 0.5 ms;
     if(LEDR /= "11111111" and readdata <= x"000900b0") then
       OK <= False;
     end if;  
     wait for 0.5 ms;
   end loop;
 end process;
  
end one;
 
 
   