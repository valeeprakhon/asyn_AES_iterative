library ieee;
use ieee.std_logic_1164.all;
use work.defs.all;

entity shift_rows is
	generic ( 
        DATA_WIDTH  : natural    := DATA_WIDTH
    );
    Port (
        -- input channel 
        in_data     : in std_logic_vector(DATA_WIDTH -1 downto 0);
        -- output channel
        out_data    : out   std_logic_vector(DATA_WIDTH -1 downto 0)
    );
end shift_rows;

architecture Behavioral of shift_rows is
	signal round : std_logic_vector(3 downto 0); 
    signal keys : std_logic_vector(127 downto 0);
    signal plainText : std_logic_vector(127 downto 0);
    signal shiftRows : std_logic_vector(127 downto 0);
    signal tempOut  : std_logic_vector(DATA_WIDTH -1 downto 0);
    
 
    attribute dont_touch : string;
    attribute dont_touch of  tempOut : signal is "true";
    attribute dont_touch of  keys : signal is "true";
    attribute dont_touch of  plainText : signal is "true";
    attribute dont_touch of  shiftRows : signal is "true";
    attribute dont_touch of  round : signal is "true";
    
begin

    keys <= in_data(127 downto 0);
    plainText <= in_data(255 downto 128);
    round <= in_data(259 downto 256);
    
	shiftRows(8*16 - 1 downto 8*15) <= plainText(8*12 - 1 downto 8*11);
	shiftRows(8*15 - 1 downto 8*14) <= plainText(8*7 - 1 downto 8*6);
	shiftRows(8*14 - 1 downto 8*13) <= plainText(8*2 - 1   downto  8*1); 
	shiftRows(8*13 - 1 downto 8*12) <= plainText(8*13 - 1  downto  8*12);
	shiftRows(8*12 - 1 downto 8*11) <= plainText(8*8 - 1   downto  8*7);
	shiftRows(8*11 - 1 downto 8*10) <= plainText(8*3 - 1   downto  8*2); 
	shiftRows(8*10 - 1 downto 8*9) <= plainText(8*14 - 1  downto  8*13);
	shiftRows(8*9 - 1 downto 8*8) <= plainText(8*9 - 1   downto  8*8);
	shiftRows(8*8 - 1 downto 8*7) <= plainText(8*4 - 1   downto  8*3);
	shiftRows(8*7 - 1 downto 8*6) <= plainText(8*15 - 1  downto  8*14);
	shiftRows(8*6 - 1 downto 8*5) <= plainText(8*10 - 1  downto  8*9);
	shiftRows(8*5 - 1 downto 8*4) <= plainText(8*5 - 1   downto  8*4);
	shiftRows(8*4 - 1 downto 8*3) <= plainText(8*16 - 1  downto  8*15);
	shiftRows(8*3 - 1 downto 8*2) <= plainText(8*11 - 1  downto  8*10);
	shiftRows(8*2 - 1 downto 8*1) <= plainText(8*6 - 1   downto  8*5);
	shiftRows(8*1 - 1 downto 8*0) <= plainText(8*1 - 1   downto  8*0); 
	
	tempOut <= round&shiftRows&keys;
	out_data <= tempOut;
	
end architecture Behavioral;