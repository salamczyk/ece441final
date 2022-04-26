-------------------------------------------------------------------------------
--
-- Title       : network
-- Design      : network
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : C:\Users\vision lab\Documents\GitHub\ece441final\final\network\src\network.vhd
-- Generated   : Tue Apr 26 14:31:18 2022
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
--{entity {network} architecture {network}}
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.project_package.all;


entity network is
	port(
		img: in image;
		clk: in std_logic;
		output: out final_output);
end network;

--}} End of automatically maintained section

architecture network of network is
signal output_1: intermediate_output;

signal output_2: final_output;



signal state: integer range 0 to 6; 
signal i: integer := 0;
begin
	output <= output_2;
	process(clk)
	
	begin	
		if(rising_edge(clk)) then
		case state is
			when 0 =>
				output_1 <= bias_1;	
			
				output_2 <= bias_2;
				state <= 1;
			
			when 1 =>
			
	        	for j in 0 to 783 loop
	            	output_1(i) <= output_1(i) + resize((img(i) * weights_1(j, i)), 18); 
					--report(integer'image(j));
	        	end loop;
	    		i <= i + 1;
				
				if(i = 127) then 
					state <= 2;
				end if;
				
			when 2 => 
				for j in 0 to 127 loop
					if(output_1(j)(17) = '1') then
						output_1(j) <= "000000000000000000";
					end if;
				end loop;  
				
				i <= 0;
				state <= 3;
				
			when 3 => 
				for j in 0 to 127 loop 
					output_1(j) <=  shift_right(output_1(j), 8);
				end loop;	
				
				state <= 4; 
				i <= 0;
			when 4 =>	
				for j in 0 to 127 loop
	            	output_2(i) <= output_2(i) + resize((output_1(i) * weights_2(j, i)), 18);
	        	end loop;
	    		i <= i + 1;
				
				if(i = 9) then 
					state <= 5;
				end if;
			when 5 => 
				for j in 0 to 9 loop
					output_2(j) <= shift_right(output_1(j), 8);
				end loop;
				state <= 6;  
			when 6 => 
				for j in 0 to 9 loop
					output_2(j) <= shift_right(output_1(j), 8);
				end loop;
				state <= 0;
			
		end case;
	end if;
	end process;
	 -- enter your statements here --

end network;
