library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.defs.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity round_increment is
  generic(
        DATA_WIDTH : natural := DATA_WIDTH
  );
  Port (
    -- input channel 
    in_data : in std_logic_vector(DATA_WIDTH-1 downto 0);
    -- output channel
    out_data    : out   std_logic_vector(DATA_WIDTH -1 downto 0)
  );
end round_increment;

architecture Behavioral of round_increment is
    signal round,temp : std_logic_vector(3 downto 0);
    signal tempOut : std_logic_vector(DATA_WIDTH -1 downto 0);
    attribute dont_touch : string;

    attribute dont_touch of  tempOut : signal is "true"; 
    attribute dont_touch of  round,temp : signal is "true"; 
 
begin
    round <= in_data(DATA_WIDTH - 1 downto DATA_WIDTH - 4);
    temp <= round + 1; 
    tempOut <= temp & in_data(DATA_WIDTH - 5 downto 0);
    out_data <= tempOut;
    
end Behavioral;
