library ieee;
use ieee.std_logic_1164.all;

entity rcon is
	port (
		input_byte : in std_logic_vector(3 downto 0);
		output_byte : out std_logic_vector(7 downto 0)
	);
end rcon;

architecture behavioral of rcon is

begin
	lut : process (input_byte) is
	begin
		case input_byte is
			when x"1" => output_byte <= x"01";
			when x"2" => output_byte <= x"02";
			when x"3" => output_byte <= x"04";
			when x"4" => output_byte <= x"08";
			when x"5" => output_byte <= x"10";
			when x"6" => output_byte <= x"20";
			when x"7" => output_byte <= x"40";
			when x"8" => output_byte <= x"80";
			when x"9" => output_byte <= x"1B";
			when x"A" => output_byte <= x"36";
			when x"B" => output_byte <= x"6C";
			when others => null;
		end case;

	end process lut;

end architecture behavioral;