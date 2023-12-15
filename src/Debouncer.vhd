library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Debouncer is
  port (
    clk : in std_logic;
    rst : in std_logic;
    sw : in std_logic_vector(3 downto 0);
    swd : out std_logic_vector(3 downto 0)
  );
end Debouncer;
architecture behaviour of Debouncer is
	signal debounced : std_logic_vector(3 downto 0);
	signal counter : integer range 0 to 2;
begin
	swd <= debounced;
	
	process(clk)
	begin
		if rising_edge(clk) then
		if rst = '0' then
				counter <= 0;
				debounced <= sw;
			else
				if counter < 2 then
					counter <= counter + 1;
				elsif sw /= debounced then
					counter <= 0;
					debounced <= sw;
				end if;
			end if;
		end if;
	end process;
end behaviour;