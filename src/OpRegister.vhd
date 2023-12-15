library ieee;
use ieee.std_logic_1164.all;

entity OpRegister is
	port(Input: in std_logic_vector(1 downto 0);
		  clk, clr: in std_logic;
		  Q: out std_logic_vector(1 downto 0));
end OpRegister;

architecture OpRegisterFunc of opRegister is
begin
	process(clk)
	begin
		if rising_edge(clk) then
			if clr='1' then
				Q <= "00";
			else
				Q <= Input;
			end if;
		end if;
	end process;
end OpRegisterFunc;