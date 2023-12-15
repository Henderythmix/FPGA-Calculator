library ieee;
use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;

--- example/skeleton TB

Entity FinalCalculator_tb is 
end FinalCalculator_tb;

Architecture Behaviour of FinalCalculator_tb is 

	component ____ is 
		Port(
		a
		...
				);
		end component;
		.
		.
		component Calculator is
	port(I0, I1: in unsigned(6 downto 0);
		  Op: in std_logic_vector(1 downto 0);
		  Clk, clr: in std_logic;
		  OutVal: out signed(7 downto 0);
		  Remainder: out unsigned(6 downto 0);
		  negative: out std_logic);
end Calculator;
	
	
	
	constant clk_hz : integer := 50e6; --f = 50 Mhz clock
	constant clk_period : time := 1 sec / clk_hz; --1/f = T = 20 ns period	
	
	signal a_tb : -- instantiate every signal with same type. ;
	.
	.
	.
	
	Begin 
		DUT : _____
		Port Map (
		a <= a_tb
		...
					);
		.
		.
		.
					
		STIMULUS:
		process Begin
		
			tb_clock <= NOT tb_clock after clk_period / 2;
			
			wait for <time>; -- cannot use this if there is a sensitivity list
			a <= "0000" ;
			wait until <condition> for <time>;
			a<= "0001";
			wait until <condition>
			a <= "0010";
			wait on <signal_name>;
			a <= <initial_value>, <end_value> after <time>;-- if sensitivity list inlcuded we can only use this.. that i know of so far
			.
			.
			
		wait;	
		end process; 
		end Behaviour; 
		