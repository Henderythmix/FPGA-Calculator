library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity Calculator is
	port(I0, I1: in signed(7 downto 0);
		  Op: in std_logic_vector(1 downto 0);
		  Clk: in std_logic;
		  OutVal: out signed(7 downto 0));
end Calculator;

architecture CalcFunc of Calculator is
signal Q: signed(15 downto 0) := "0000000000000000";
begin
	process(clk, Op, I0, I1)
	begin
		if rising_edge(clk) then
			if Op = "00" then
				Q <= "00000000" & (I0 + I1);
			elsif Op = "01" then
				Q <= "00000000" & (I0 - I1);
			elsif Op = "10" then
				Q <= I0 * I1;
			else -- Should be Division, but I do not know how to implement it yet
				Q <= I0 * I1;
			end if;
		end if;
	end process;
	
	OutVal <= Q(7 downto 0);
end CalcFunc;