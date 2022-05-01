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
--signal i1: integer range 0 to 127:=0;

--input [1x784] vector
--multiply it by the [784x128] weight matrix
--add the bias that is [1x128] long
--every number that is less than zero is now zero
--multiply it by the [128x10] weight matrix
--add the bias that is [1x10] long
--the index of the highest number is the predicted number
begin
	
	process(clk)
	variable output_1: intermediate_output;
	variable output_2: final_output;
	variable i1: integer range 0 to 127:=0;
        variable j1 : integer range 0 to 783:=0;
	-- variable r1: integer range 0 to 783:=0;
        -- variable r2: integer range 0 to 783:=97;
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
                                output_1(i1) := output_1(i1) + img(j1) * weights_1(j1, i1); 
					--report(integer'image(j));
				if i1 = 127 then
                                  i1 := 0;
                                  j1 := 0;
                                  state <= 2;
				else
                                  if j1 = 783 then
                                    j1 := 0;
                                    i1 := i1 + 1;
                                  else
                                    j1 := j1 + 1;
                                  end if;
                                  state <= 1; 
				end if; 
				
			when 2 => 	
				report("State 2");
				if(output_1(i1) < 0) then
					output_1(i1) := 0;
				end if;
				
				if i1 = 127 then
					i1 := 0;
					state <= 3;
				else
					i1 := i1 + 1;
					state <= 2;
				end if; 	
				
			when 3 => 	
				report("State 3"); 
				--output_1(i1) :=  output_1(i1) / 256;
				output_1(i1) := to_integer(shift_right(to_signed(output_1(i1), 32), 8));
				
				if i1 = 127 then
					i1 := 0;
					state <= 4;
				else
					i1 := i1 + 1;
					state <= 3;
				end if; 
				
			when 4 =>	
				report("State 4");
					for j in 0 to 127 loop
						output_2(i1) := output_2(i1) + output_1(j) * weights_2(j, i1); 
						--report(integer'image(j));
					end loop;
					if i1 >= 9 then
						i1 := 0;
						state <= 5;
					else
						i1 := i1 + 1;
						state <= 4;
					end if;
			when 5 => 	
				report("State 5");
				for j in 0 to 9 loop
					--output_2(j) := output_2(j) / 256;
					output_2(j) := to_integer(shift_right(to_signed(output_2(j), 32), 8));
				end loop;
				state <= 6;  
			when 6 => 	   
				report("State 6");
				for j in 0 to 9 loop
					--output_2(j) := output_2(j) / 256;
					output_2(j) := to_integer(shift_right(to_signed(output_2(j), 32), 8));
				end loop;
				state <= 0;	
				output <= output_2;	 
			
		end case;
	end if;
	end process;
	 -- enter your statements here --

end network;
