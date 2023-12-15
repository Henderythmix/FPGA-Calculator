library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity UIntRegister is
	port(Input: in unsigned(6 downto 0);
		  clk, clr: in std_logic;
		  Q: out unsigned(6 downto 0));
end UIntRegister;

architecture UIntRegisterFunc of UIntRegister is
begin
	process(clk)
	begin
		if rising_edge(clk) then
			if clr='1' then
				Q <= "0000000";
			else
				Q <= Input;
			end if;
		end if;
	end process;
end UIntRegisterFunc;