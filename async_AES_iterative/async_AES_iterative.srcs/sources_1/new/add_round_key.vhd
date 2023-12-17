library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.defs.all;

entity add_round_key is
    generic(
        DATA_WIDTH : natural := DATA_WIDTH
    );
    Port ( 
        -- input channel 
        in_data : in std_logic_vector(DATA_WIDTH-1 downto 0);
		-- output channel
		out_data : out std_logic_vector(DATA_WIDTH-1 downto 0)
    );
end add_round_key;
    
architecture Behavioral of add_round_key is
    signal round : std_logic_vector(3 downto 0); 
    signal keys : std_logic_vector(127 downto 0);
    signal plainText : std_logic_vector(127 downto 0);
    signal roundKey : std_logic_vector(127 downto 0);
    signal tempOut : std_logic_vector(DATA_WIDTH-1 downto 0);  
    
    attribute dont_touch : string; 
    attribute dont_touch of round : signal is "true";
    attribute dont_touch of keys : signal is "true";
    attribute dont_touch of plainText : signal is "true";
    attribute dont_touch of roundKey: signal is "true";
    attribute dont_touch of tempOut : signal is "true";
     
begin
  
    keys <= in_data(127 downto 0);
    plainText <= in_data(255 downto 128);
    round <= in_data(259 downto 256);

    roundKey <= keys xor plainText;
    tempOut <= round&roundKey&keys; 
    out_data <= tempOut; 

end Behavioral;
