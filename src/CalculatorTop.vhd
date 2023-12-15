library ieee;
use ieee.std_logic_1164.all;

entity CalculatorTop is
	port(
		SW: in std_logic_vector(17 downto 0);
		KEY: in std_logic_vector(3 downto 0);
		CLOCK_50: in std_logic;
		LEDG: out std_logic_vector(8 downto 0);
		LEDR: out std_logic_vector(17 downto 0);
		HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7: out std_logic_vector(6 downto 0)
	);
end CalculatorTop;

architecture Behaviour of CalculatorTop is
component FullCalculator is
	port(Input: in std_logic_vector(17 downto 0);
		K: in std_logic_vector (3 downto 0);
		Clk: in std_logic;
		Disp0, Disp1, Disp2, Disp3, Disp4, Disp5, Disp6, Disp7: out std_logic_vector (6 downto 0);
		FSMPass: out std_logic_vector(8 downto 0));
end component;
begin
	Top: FullCalculator port map(SW, not KEY, CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7, LEDG);
	LEDR <= SW;
end Behaviour;