library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity Binary2BCD is
    generic(N: positive := 16);
    port(
        clk, reset: in std_logic;
        binary_in: in std_logic_vector(N-1 downto 0);
        bcd0, bcd1, bcd2, bcd3, bcd4: out std_logic_vector(3 downto 0)
    );
end Binary2BCD;

architecture behaviour of Binary2BCD is
    signal O0, O1, O2: unsigned(3 downto 0) := "0000";
begin
    process(clk, reset, O0, O1, O2)
		variable O0, O1, O2 : std_logic_vector(3 downto 0) := "0000";
    begin
        if rising_edge(clk) then
            O0 := "0000";
            O1 := "0000";
            O2 := "0000";
            
				if reset = '0' then
					if binary_in <= 9 then
						O0 := binary_in(3 downto 0);
					else
					for k in 0 to N-1 loop
						if O0 >= 5 then
							O0 := O0 + 3;
						end if;

						if O1 >= 5 then
							O1 := O1 + 3;
						end if;

						if O2 >= 5 then
							O2 := O2 + 3;
						end if;
						
						O2 := O2(2 downto 0) & O1(3);
						O1 := O1(2 downto 0) & O0(3);
						O0 := O0(2 downto 0) & binary_in(N-1-k);
					end loop;
					end if;
				end if;
				
				bcd0 <= std_logic_vector(O0);
				bcd1 <= std_logic_vector(O1);
				bcd2 <= std_logic_vector(O2);
        end if;
    end process;
end behaviour;