library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.defs.all;

entity sub_bytes is
  generic ( 
        DATA_WIDTH  : natural    := DATA_WIDTH
  );
  Port (
        -- input channel 
        in_data     : in    std_logic_vector(DATA_WIDTH -1 downto 0);        
        -- output channel
        out_data    : out   std_logic_vector(DATA_WIDTH -1 downto 0)
  );
end sub_bytes;

architecture Behavioral of sub_bytes is
    signal round : std_logic_vector(3 downto 0); 
    signal keys : std_logic_vector(127 downto 0);
    signal plainText : std_logic_vector(127 downto 0);
    signal subBytes : std_logic_vector(127 downto 0);
    signal tempOut : std_logic_vector(DATA_WIDTH -1 downto 0);
    
    attribute dont_touch : string; 
    attribute dont_touch of round : signal is "true";
    attribute dont_touch of keys : signal is "true";
    attribute dont_touch of plainText : signal is "true";
    attribute dont_touch of subBytes : signal is "true";
    attribute dont_touch of tempOut : signal is "true";
    
begin
    
    keys <= in_data(127 downto 0);
    plainText <= in_data(255 downto 128);
    round <= in_data(259 downto 256);
    
    gen : for i in 0 to 15 generate 
            sbox_inst : entity work.sbox
                port map(
                    input_byte  => plainText((i + 1)*8 - 1 downto i*8),
				    output_byte => subBytes((i + 1)*8 - 1 downto i*8)
                );
     end generate gen;
    
    tempOut <= round&subBytes&keys;
    out_data <= tempOut;
end Behavioral;
