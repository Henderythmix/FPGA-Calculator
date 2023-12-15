library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity FullCalculator is
	port(Input: in std_logic_vector(17 downto 0);
	K: in std_logic_vector (3 downto 0);
	Clk: in std_logic;
	Disp0, Disp1, Disp2, Disp3, Disp4, Disp5, Disp6, Disp7: out std_logic_vector (6 downto 0);
	FSMPass: out std_logic_vector(8 downto 0));
end FullCalculator;

architecture FullCalcBody of FullCalculator is

-- Components --
component Calculator is
	port(I0, I1: in unsigned(6 downto 0);
		  Op: in std_logic_vector(1 downto 0);
		  Clk, clr: in std_logic;
		  OutVal: out signed(7 downto 0);
		  Remainder: out unsigned(6 downto 0);
		  negative: out std_logic);
end component;

component IntRegister is
	port(Input: in signed(7 downto 0);
		  clk, clr: in std_logic;
		  Q: out signed(7 downto 0));
end component;

component UIntRegister is
	port(Input: in unsigned(6 downto 0);
		  clk, clr: in std_logic;
		  Q: out unsigned(6 downto 0));
end component;

component OpRegister is
	port(Input: in std_logic_vector(1 downto 0);
		  clk, clr: in std_logic;
		  Q: out std_logic_vector(1 downto 0));
end component;

component FSM is
	port (I, reset, clk: in std_logic;
	z : out std_logic_vector(2 downto 0));
end component;

component OperatorEncoder is
	port(I: in std_logic_vector(3 downto 0);
		O: out std_logic_vector(1 downto 0);
		E: out std_logic);
end component;

component SegDecoder is
	Port ( D : in std_logic_vector( 3 downto 0 );
		Y : out std_logic_vector( 6 downto 0 ) );
end component;

component PreScale is
	Port(Clkin : in std_logic;
			Clkout : out std_logic);
end component;

component Binary2BCD is
    generic(N: positive := 7);
    port(
        clk, reset: in std_logic;
        binary_in: in std_logic_vector(N-1 downto 0);
        bcd0, bcd1, bcd2, bcd3, bcd4: out std_logic_vector(3 downto 0)
    );
end component;

component Debouncer is
	port (
    clk : in std_logic;
    rst : in std_logic;
    sw : in std_logic_vector(3 downto 0);
    swd : out std_logic_vector(3 downto 0)
	);
end component;

-- Intermediate Signals --
signal ScaledClock: std_logic := '0';
signal ErrorThrown: std_logic := '0';

signal DK: std_logic_vector(3 downto 0);

signal In1, In2: unsigned(6 downto 0) := "0000000";
signal Out1, Out2: unsigned(6 downto 0) := "0000000";

signal EncodedOp: std_logic_vector(1 downto 0) := "00";
signal CurrentOp: std_logic_vector(1 downto 0) := "00";
signal StoredOp: std_logic_vector(1 downto 0) := "00";

signal CalcIn1, CalcIn2: unsigned(6 downto 0) := "0000000";
signal CalcInOp: std_logic_vector(1 downto 0) := "00";
signal negative: std_logic := '0';

signal CalcOut: signed(7 downto 0) := "00000000";
signal CalcDisplay: signed(7 downto 0) := "00000000";
signal CalcRem: unsigned(6 downto 0) := "0000000";

signal RemOut: unsigned(6 downto 0) := "0000000";
signal CalcRegOut: signed(7 downto 0) := "00000000";

signal FSMOut: std_logic_vector(2 downto 0) := "000";

signal R0, R1, R2, R3, R4, R5, R6, R7: std_logic_vector(3 downto 0) := "0000";

signal RR1, RR0 : std_logic_vector(3 downto 0) := "0000";
signal RQ2, RQ1, RQ0 : std_logic_vector(3 downto 0) := "0000";
signal remShow : std_logic := '0';

signal ShowDisplay: std_logic_vector(3 downto 0) := "0000";

-- Resetting Values
signal MUXIn1, MUXIn2: unsigned(6 downto 0) := "0000000";
signal ClearVals: std_logic := '0';

signal CalcTrigger: std_logic := '0';

begin
	-- State Components --
	S0: PreScale port map(Clk, ScaledClock);
	Deb: Debouncer port map(ScaledClock, '0', K, DK);

	S01: FSM port map(DK(2), DK(3), ScaledClock, FSMOut);
	S02: OperatorEncoder port map(Input(17 downto 14), EncodedOp, ErrorThrown);
	
	S1: UIntRegister port map(In1, ScaledClock, ClearVals, Out1);
	S2: OpRegister port map(CurrentOp, ScaledClock, ClearVals, StoredOp);
	S3: UIntRegister port map(In2, ScaledClock, ClearVals, Out2);
	
	S4: Calculator port map(Out1, Out2, storedOp, CalcTrigger, ClearVals, CalcOut, CalcRem, negative);
	
	-- Output Registers
	S41: UIntRegister port map(CalcRem, ScaledClock, ClearVals, RemOut);
	S42: IntRegister port map(CalcDisplay, ScaledClock, ClearVals, CalcRegOut);
	
	-- Displays
	
	Converter1: Binary2BCD port map(ScaledClock, '0', std_logic_vector(Out1), R6, R7);
	Converter2: Binary2BCD port map(ScaledClock, '0', std_logic_vector(Out2), R4, R5);
	Converter3: Binary2BCD port map(ScaledClock, '0', std_logic_vector(CalcRegOut(6 downto 0)), RQ0, RQ1, RQ2);
	Converter4: Binary2BCD port map(ScaledClock, '0', std_logic_vector(RemOut), RR0, RR1);
	
	D0: SegDecoder port map(R0 and showdisplay, Disp0);
	D1: SegDecoder port map(R1 and showdisplay, Disp1);
	D2: SegDecoder port map(R2 and showdisplay, Disp2);
	D3: SegDecoder port map(R3 and showdisplay, Disp3);
	D4: SegDecoder port map(R4, Disp4);
	D5: SegDecoder port map(R5, Disp5);
	D6: SegDecoder port map(R6, Disp6);
	D7: SegDecoder port map(R7, Disp7);
	
	process(FSMOut)
	begin
		if DK(1) = '1' then
			ClearVals <= '1';
		else
			ClearVals <= '0';
		end if;
		
		if RemOut = 0 then
			R0 <= RQ0;
			R1 <= RQ1;
			R2 <= RQ2;
			remShow <= '0';
		else
			R0 <= RR0;
			R1 <= RR1;
			R2 <= RQ0;

			remShow <= '1';
		end if;
		
		if FSMOUT="101" then
			if negative='1' then
				R3 <= "1111";
			else
				if RemOut = 0 then
					R3 <= "0000";
				else
					R3 <= RQ1;		
				end if;
			end if;
			
			CalcDisplay <= CalcOut;
		else
			CalcDisplay <= "00000000";
		end if;
	
		if FSMOut="000" then -- Idle
			In1 <= "0000000";
			In2 <= "0000000";
			
			ShowDisplay <= "0000";
			
			FSMPass <= "000100000";
			CalcTrigger <= '0';
		elsif FSMOut="001" then -- Input 1
			if DK(1) = '1' then 
				In1 <= "0000000";
				In2 <= "0000000";
				CurrentOp <= "00";
			elsif rising_edge(DK(0)) then
				In1 <= unsigned(Input(6 downto 0));
			end if;
			
			FSMPass <= "000010000";
		elsif FSMOut="010" then -- Operator Input
			if DK(1) = '1' then 
				In1 <= "0000000";
				In2 <= "0000000";
				CurrentOp <= "00";
			elsif rising_edge(DK(0)) then
				CurrentOp <= EncodedOp;
			end if;
			
			FSMPass <= "000001000";
		elsif FSMOut="011" then -- Input 2
			if DK(1) = '1' then 
				In1 <= "0000000";
				In2 <= "0000000";
				CurrentOp <= "00";
			elsif rising_edge(DK(0)) then
				In2 <= unsigned(Input(6 downto 0));
			end if;
			
			FSMPass <= "000000100";
		elsif FSMOut="100" then -- Calculate
			FSMPass <= "000000010";
			CalcTrigger <= '1';
		elsif FSMOut="101" then -- Output
			ShowDisplay <= "1111";
			FSMPass <= remShow & "00000001";
			CalcTrigger <= '0';
			
			if DK(1) = '1' then 
				In1 <= "0000000";
				In2 <= "0000000";
				CurrentOp <= "00";
			end if;
			
		end if;
	end process;
	
end FullCalcBody;