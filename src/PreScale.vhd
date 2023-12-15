Library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

Entity PreScale is 
	Port(Clkin : in std_logic;
			Clkout : out std_logic);
End PreScale;

Architecture Behavior of PreScale is 
signal counterState : unsigned(19 downto 0) := "00000000000000000000";
begin
	process(clkin)
	begin
		if rising_edge(clkin) then
			counterState <= counterState + 1;
		end if;
	end process;
	clkout <= counterState(19);
End Behavior;