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
	
	signal networkclock: std_logic;
	
	signal currentinteger: integer;	
	
	signal currentimage: image;
begin
	
	thepll: entity work.pll port map (CLOCK_50, '0', networkclock);  
	network: entity work.network port map (img => currentimage, clk => networkclock, output => output); 
	mux: entity work.mux port map(value => currentinteger, S => SW(4), DISP0 => HEX0, DISP1 => HEX1, DISP2 => HEX2, DISP3 => HEX3, DISP4 => HEX4, DISP5 => HEX5);
		
		
	process(networkclock)
	begin
		if(rising_edge(networkclock)) then
			case SW(3 downto 0) is 
				when "0000" =>
					currentinteger <= output(0);
				when "0001" =>
					currentinteger <= output(1);
				when "0010" => 
					currentinteger <= output(2);
				when "0011" =>	 
					currentinteger <= output(3);
				when "0100" =>	 
					currentinteger <= output(4);
				when "0101" =>
					currentinteger <= output(5);
				when "0110" =>	 
					currentinteger <= output(6);				
				when "0111" =>
					currentinteger <= output(7);
				when "1000" => 
					currentinteger <= output(8);
				when "1001" => 
					currentinteger <= output(9);
				when others => 
					currentinteger <= output(9);
			end case;
		end if;
	end process;
	
	process(networkclock)
	begin
		if(rising_edge(networkclock)) then
			case SW(8 downto 5) is 
				when "0000" =>
					currentimage <= image_0;
				when "0001" =>
					currentimage <= image_1;
				when "0010" => 
					currentimage <= image_2;
				when "0011" =>	 
					currentimage <= image_3;
				when "0100" =>	 
					currentimage <= image_4;
				when "0101" =>
					currentimage <= image_5;
				when "0110" =>	 
					currentimage <= image_6;				
				when "0111" =>
					currentimage <= image_7;
				when "1000" => 
					currentimage <= image_8;
				when "1001" => 
					currentimage <= image_9;
				when others => 
					currentimage <= image_9;
			end case;
		end if;
	end process;
				
	

	 -- enter your statements here --

end fpga;
