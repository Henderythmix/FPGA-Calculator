library ieee;
use ieee.std_logic_1164.all;

entity OperatorEncoder is
	port(I: in std_logic_vector(3 downto 0);
		O: out std_logic_vector(1 downto 0);
		E: out std_logic);
end OperatorEncoder;

architecture OperatorEncoderFunc of OperatorEncoder is
begin
	process(I)
	begin
		if I="0001" then
			O <= "00";
			E <= '0';
		elsif I="0010" then
			O <= "01";
			E <= '0';
		elsif I="0100" then
			O <= "10";
			E <= '0';
		elsif I="1000" then
			O <= "11";
			E <= '0';
		else
			O <= "00";
			E <= '1';
		end if;
	end process;
end OperatorEncoderFunc;