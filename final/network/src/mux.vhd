library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.project_package.all;

entity mux is
	port( 
		  value	: in	integer;
		  S		: in 	std_logic;
		  DISP0	: out std_logic_vector(0 to 6);
		  DISP1	: out std_logic_vector(0 to 6);
		  DISP2	: out std_logic_vector(0 to 6);
		  DISP3	: out std_logic_vector(0 to 6);
		  DISP4	: out std_logic_vector(0 to 6);
		  DISP5	: out std_logic_vector(0 to 6)
		  );
end entity;

		  
architecture behavior of mux is

function hexToSegments(h:signed(3 downto 0)) return std_logic_vector is
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

signal val	   : signed(31 downto 0);
signal sendOut : signed(23 downto 0) := (others => 'X');

begin
	process(all)
	begin
		val <= to_signed(value,32);
		case S is
			when '1' => sendOut(15 downto 0) <= val(31 downto 16);
			when others => sendOut(15 downto 0) <= val(15 downto 0);
		end case; 
		  
	end process;
	DISP0 <= hexToSegments(sendOut(3 downto 0));
	DISP1 <= hexToSegments(sendOut(7 downto 4));
	DISP2 <= hexToSegments(sendOut(11 downto 8));
	DISP3 <= hexToSegments(sendOut(15 downto 12));
	DISP4 <= hexToSegments(sendOut(19 downto 16));
	DISP5 <= hexToSegments(sendOut(23 downto 20));
		  
end architecture;		  
		  