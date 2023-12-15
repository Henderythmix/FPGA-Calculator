library ieee;
use ieee.std_logic_1164.all;

entity FSM is
	port (I, reset, clk: in std_logic;
	z : out std_logic_vector(2 downto 0));
end FSM;

architecture FSMFunc of FSM is
type State_Type is (S0, S1, S2, S3, S4, S5);
signal y: State_Type;
begin
	process(reset, clk)
	begin
		if reset = '1' then
			y <= S0;
		elsif rising_edge(clk) then
			case y is
				when S0 =>
					z <= "000";
					if I = '0' then
						y <= S0;
					else
						y <= S1;
					end if;
				when S1 =>
					z <= "001";
					if I = '0' then
						y <= S1;
					else
						y <= S2;
					end if;
				when S2 =>
					z <= "010";
					if I = '0' then
						y <= S2;
					else
						y <= S3;
					end if;
				when S3 =>
					z <= "011";
					if I = '0' then
						y <= S3;
					else
						y <= S4;
					end if;
				when S4 =>
					z <= "100";
					if I = '0' then
						y <= S4;
					else
						y <= S5;
					end if;
				when S5 =>
					z <= "101";
					if I = '0' then
						y <= S5;
					else
						y <= S0;
					end if;
			end case;
		end if;
	end process;
end FSMFunc;