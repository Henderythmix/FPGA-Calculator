library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity FullCalculator is
	port(InputValue: in signed(7 downto 0);
	AddBtn, SubBtn, MultBtn, DivBtn, EqBtn, ClrBtn: in std_logic;
	Disp1, Disp2, Disp3, Disp4, Disp5: out std_logic_vector(6 downto 0));
end FullCalculator;

architecture FullCalcBody of FullCalculator is
signal Saved0, Saved1, Saved2: signed(7 downto 0) := "00000000";
signal Edit: std_logic := '0';
signal CurrentOp: std_logic_vector(1 downto 0) := "00";

signal RunCalculatorClk: std_logic;

-- Constant Signals
signal zero: signed(7 downto 0) := "00000000";

component Calculator is
	port(I0, I1: in signed(7 downto 0);
		  Op: in std_logic_vector(1 downto 0);
		  Clk: in std_logic;
		  OutVal: out signed(7 downto 0));
end component;
begin
	process(AddBtn, SubBtn, MultBtn, DivBtn, EqBtn, ClrBtn, zero)
	begin
		if AddBtn = '1' then
			CurrentOp <= "00";
			Edit <= '1';
		elsif SubBtn = '1' then
			CurrentOp <= "01";
			Edit <= '1';
		elsif MultBtn = '1' then
			CurrentOp <= "10";
			Edit <= '1';
		elsif DivBtn = '1' then
			CurrentOp <= "11";
			Edit <= '1';
		elsif ClrBtn = '1' then
			Saved0 <= zero;
			Saved1 <= zero;
			Edit <= '0';
		end if;
		
		if Edit = '0' then
			Saved0 <= InputValue;
		else
			Saved1 <= InputValue;
		end if;
		
	end process;
	
	U1: Calculator port map(Saved0, Saved1, CurrentOp, EqBtn, Saved2);
end FullCalcBody;