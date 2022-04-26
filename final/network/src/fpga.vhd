-------------------------------------------------------------------------------
--
-- Title       : fpga
-- Design      : part2
-- Author      : slamc001
-- Company     : ODU
--
-------------------------------------------------------------------------------
--
-- File        : C:\Users\Steph\Documents\GitHub\ece441\lab3\lab3\part2\src\fpga.vhd
-- Generated   : Tue Mar 22 16:10:27 2022
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {fpga} architecture {fpga}}
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.project_package.all;


entity fpga is
	PORT (
		CLOCK_50 : IN STD_LOGIC; -- 50 MHz Clock
		CLOCK2_50 : IN STD_LOGIC; -- 50 MHz Clock
		CLOCK3_50 : IN STD_LOGIC; -- 50 MHz Clock
		CLOCK4_50 : IN STD_LOGIC; -- 50 MHz Clock
		SW : IN STD_LOGIC_VECTOR(9 downto 0); -- switches
		KEY : IN STD_LOGIC_VECTOR(3 downto 0); -- push buttons
		LEDR : OUT STD_LOGIC_VECTOR(9 downto 0); -- red LEDs
		HEX0 : OUT STD_LOGIC_VECTOR(0 to 6);
		HEX1 : OUT STD_LOGIC_VECTOR(0 to 6);
		HEX2 : OUT STD_LOGIC_VECTOR(0 to 6);
		HEX3 : OUT STD_LOGIC_VECTOR(0 to 6);
		HEX4 : OUT STD_LOGIC_VECTOR(0 to 6);
		HEX5 : OUT STD_LOGIC_VECTOR(0 to 6)
		);
end fpga;

--}} End of automatically maintained section

architecture fpga of fpga is

function hexToSegments(h:unsigned(3 downto 0)) return std_logic_vector is
	variable ret:std_logic_vector(0 to 6);
	begin
	    case h is
	        when x"0" => ret := not "1111110";
	        when x"1" => ret := not "0110000";
	        when x"2" => ret := not "1101101";
	        when x"3" => ret := not "1111001";
	        when x"4" => ret := not "0110011";
	        when x"5" => ret := not "1011011";
	        when x"6" => ret := not "1011111";
	        when x"7" => ret := not "1110000";
	        when x"8" => ret := not "1111111";
	        when x"9" => ret := not "1111011";
	        when x"A" => ret := not "1110111";
	        when x"B" => ret := not "0011111";
	        when x"C" => ret := not "1001110";
	        when x"D" => ret := not "0111101";
	        when x"E" => ret := not "1001111";
	        when x"F" => ret := not "1000111";
	        when others => ret:="XXXXXXX";
			end case;
	    return ret;
	end function;
	
	signal output: final_output;
begin 
	network: entity work.network port map (img => image_0, clk => CLOCK_50, output => output); 
	

	 -- enter your statements here --

end fpga;
