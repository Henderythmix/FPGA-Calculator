LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

ENTITY SegDecoder IS
Port ( D : in std_logic_vector( 3 downto 0 );
 Y : out std_logic_vector( 6 downto 0 ) );
END SegDecoder;
architecture Behavioral of SegDecoder is
begin
process(D)
begin
case D is
when "0000" =>
 Y <= "1000000"; ---0
when "0001" =>
 Y <= "1111001"; ---1
when "0010" =>
 Y <= "0100100"; ---2
when "0011" =>
 Y <= "0110000"; ---3
when "0100" =>
 Y <= "0011001"; ---4
when "0101" =>
 Y <= "0010010"; ---5
when "0110" =>
 Y <= "0000010"; ---6
when "0111" =>
 Y <= "1111000"; ---7
when "1000" =>
 Y <= "0000000"; ---8
when "1001" =>
 Y <= "0010000"; ---9
when "1010" =>
 Y <= "0001000"; --- A
when "1011"=>
 Y <= "0000011" ;--- B
when "1100" =>
 Y <= "0100111" ;--- C
when "1101" =>
 Y <= "0100001" ;--- D
when "1110" =>
 Y <= "0000110" ;--- E
when "1111" =>
 Y <= "0111111" ;--- -ve
END case;
end process;
end Behavioral;

