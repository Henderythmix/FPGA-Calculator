library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity IntRegister is
	port(Input: in signed(7 downto 0);
		  clk, clr: in std_logic;
		  Q: out signed(7 downto 0));
end IntRegister;

architecture IntRegisterFunc of IntRegister is
begin
	process(clk)
	begin
		if rising_edge(clk) then
			if clr='1' then
				Q <= "00000000";
			else
				Q <= Input;
			end if;
		end if;
	end process;
end IntRegisterFunc;