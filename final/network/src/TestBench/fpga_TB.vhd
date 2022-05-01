library network;
use network.project_package.all;


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.project_package.all;

	-- Add your library and packages declaration here ...

entity fpga_tb is
end fpga_tb;

architecture TB_ARCHITECTURE of fpga_tb is
	-- Component declaration of the tested unit
	component fpga
	port(
		CLOCK_50 : in STD_LOGIC;
		CLOCK2_50 : in STD_LOGIC;
		CLOCK3_50 : in STD_LOGIC;
		CLOCK4_50 : in STD_LOGIC;
		SW : in STD_LOGIC_VECTOR(9 downto 0);
		KEY : in STD_LOGIC_VECTOR(3 downto 0);
		LEDR : out STD_LOGIC_VECTOR(9 downto 0);
		HEX0 : out STD_LOGIC_VECTOR(0 to 6);
		HEX1 : out STD_LOGIC_VECTOR(0 to 6);
		HEX2 : out STD_LOGIC_VECTOR(0 to 6);
		HEX3 : out STD_LOGIC_VECTOR(0 to 6);
		HEX4 : out STD_LOGIC_VECTOR(0 to 6);
		HEX5 : out STD_LOGIC_VECTOR(0 to 6) );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal CLOCK_50 : STD_LOGIC;
	signal CLOCK2_50 : STD_LOGIC;
	signal CLOCK3_50 : STD_LOGIC;
	signal CLOCK4_50 : STD_LOGIC;
	signal SW : STD_LOGIC_VECTOR(9 downto 0);
	signal KEY : STD_LOGIC_VECTOR(3 downto 0);
	-- Observed signals - signals mapped to the output ports of tested entity
	signal LEDR : STD_LOGIC_VECTOR(9 downto 0);
	signal HEX0 : STD_LOGIC_VECTOR(0 to 6);
	signal HEX1 : STD_LOGIC_VECTOR(0 to 6);
	signal HEX2 : STD_LOGIC_VECTOR(0 to 6);
	signal HEX3 : STD_LOGIC_VECTOR(0 to 6);
	signal HEX4 : STD_LOGIC_VECTOR(0 to 6);
	signal HEX5 : STD_LOGIC_VECTOR(0 to 6);

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : fpga
		port map (
			CLOCK_50 => CLOCK_50,
			CLOCK2_50 => CLOCK2_50,
			CLOCK3_50 => CLOCK3_50,
			CLOCK4_50 => CLOCK4_50,
			SW => SW,
			KEY => KEY,
			LEDR => LEDR,
			HEX0 => HEX0,
			HEX1 => HEX1,
			HEX2 => HEX2,
			HEX3 => HEX3,
			HEX4 => HEX4,
			HEX5 => HEX5
		);

	-- Add your stimulus here ...
	SW(8 downto 5) <= "0001";
	SW(4 downto 0) <= "00000";
	process
	begin
		CLOCK_50 <= '0';
		wait for 10ns;
		CLOCK_50 <= '1';
		wait for 10ns;
	end process;

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_fpga of fpga_tb is
	for TB_ARCHITECTURE
		for UUT : fpga
			use entity work.fpga(fpga);
		end for;
	end for;
end TESTBENCH_FOR_fpga;

