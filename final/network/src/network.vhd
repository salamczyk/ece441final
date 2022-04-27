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


signal state: integer range 0 to 6;   

begin
	
	process(clk)
	variable output_1: intermediate_output;
	variable output_2: final_output;
	begin	
		if(rising_edge(clk)) then
		case state is
			when 0 =>
				report("State 0");
				output_1 := bias_1;	
			
				output_2 := bias_2;
				state <= 1;
			
			when 1 =>
				report("State 1");
				for i in 0 to 127 loop
	        		for j in 0 to 783 loop
	            	output_1(i) := output_1(i) + img(j) * weights_1(j, i); 
					--report(integer'image(j));
	        		end loop;
				end loop;
	    		state <= 2;	 
				
			when 2 => 	
				report("State 2");
				for j in 0 to 127 loop
					if(output_1(j) < 0) then
						output_1(j) := 0;
					end if;
				end loop;  
				
				state <= 3;	
				
			when 3 => 	
				report("State 3");
				for j in 0 to 127 loop 
					output_1(j) :=  output_1(j) / 256;
				end loop;
				
				state <= 4; 
			when 4 =>	
				report("State 4");
				for i in 0 to 9 loop
					for j in 0 to 127 loop
					output_2(i) := output_2(i) + output_1(j) * weights_2(j, i); 
					--report(integer'image(j));
					end loop;
				end loop;
				
				state <= 5;
			when 5 => 	
				report("State 5");
				for j in 0 to 9 loop
					output_2(j) := output_2(j) / 256;
				end loop;
				state <= 6;  
			when 6 => 	   
				report("State 6");
				for j in 0 to 9 loop
					output_2(j) := output_2(j) / 256;
				end loop;
				state <= 0;	
				output <= output_2;	 
			
		end case;
	end if;
	end process;
	 -- enter your statements here --

end network;
