library ieee;
use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;

ENTITY Divider IS 
Port(clk, Rst: IN std_logic;
	    A, B: IN integer;
	    Qout: OUT integer;
		 QRem: OUT integer);
END Divider;
architecture FcountFunc of Divider is
begin 
	Qout <= A / B;
	QRem <= A mod B;
end FcountFunc;
