library ieee;
use ieee.std_logic_1164.all;
--use ieee.std_logic_arith.all;
Use ieee.numeric_std.all;

entity Calculator is
	port(I0, I1: in unsigned(6 downto 0);
		  Op: in std_logic_vector(1 downto 0);
		  Clk, clr: in std_logic;
		  OutVal: out signed(7 downto 0);
		  Remainder: out unsigned(6 downto 0);
		  negative: out std_logic);
end Calculator;

architecture CalcFunc of Calculator is
signal Q: signed(13 downto 0) := "00000000000000";
signal R: unsigned(6 downto 0) := "0000000";

signal DivOut: integer := 0;
signal DivRem: integer := 0;

component Divider is
	Port(clk, Rst: IN std_logic;
	    A, B: IN integer;
	    Qout: OUT integer;
		 Qrem: OUT integer);
end component;
begin
	Div: Divider port map(clk, '0', to_integer(I0), to_integer(I1), DivOut, DivRem);
	R <= to_unsigned(DivRem, 7);

	process(clk, Op, I0, I1, clr)
	begin
		if clr = '1' then 
			Q <= "00000000000000";
			OutVal <= Q(7 downto 0);
		end if;
		--elsif rising_edge(clk) then
			if Op = "00" then -- Addition
				Q <= ("0000000" & signed(I0)) + ("0000000" & signed(I1));
				negative <= '0';
				OutVal <= Q(7 downto 0);
				Remainder <= "0000000";
			elsif Op = "01" then -- Subtraction
				Q <= ("0000000" & signed(I0)) - ("0000000" & signed(I1));
				Remainder <= "0000000";
				if Q < 0 then 
					negative <= '1';
					OutVal <= signed(not std_logic_vector(Q(7 downto 0))) + 1;
				else
					negative <= '0';
					OutVal <= Q(7 downto 0);
				end if;
			elsif Op = "10" then -- Multiplication
				Q <= signed(I0) * signed(I1);
				negative <= '0';
				OutVal <= Q(7 downto 0);
				Remainder <= "0000000";
			else -- Division
				Q <= to_signed(DivOut, 14);
				negative <= '0';
				OutVal <= Q(7 downto 0);
				Remainder <= R;
			end if;
		--end if;
	end process;
end CalcFunc;
-- 1100011