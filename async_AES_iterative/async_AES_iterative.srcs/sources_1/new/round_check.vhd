library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.defs.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity round_check is
    generic ( 
        VALUE       : natural := 0;
        DELAY_SIZE  : natural := INIT_DELAY
    );
    Port ( 
        -- input chennel 
        in_data : in    std_logic_vector(DATA_WIDTH-1 downto 0);
        in_req : in  std_logic;
        in_ack : out std_logic;
        -- output chennel
        selector : out   std_logic;
        out_req : out std_logic;
        out_ack : in  std_logic
    );
end round_check;
architecture Behavioral of round_check is
    signal number : std_logic_vector(3 downto 0):= std_logic_vector(to_unsigned(VALUE, 4));
    signal round : std_logic_vector(3 downto 0);
    signal ack,req : std_logic;
    
    attribute dont_touch : string;
    attribute dont_touch of  ack,req : signal is "true";   
  
begin
    delay_req : entity work.delay_element
    generic map(
      size => DELAY_SIZE    
    )
    port map(
      d => in_req,
      z => out_req
    );
    
--    req <= in_req;
--    out_req <= req;
    
    round <= in_data(DATA_WIDTH - 1 downto DATA_WIDTH - 4);
    selector <= '0' when round < number  else '1';
    
    ack <= out_ack;
    in_ack <= ack;
    
end Behavioral;
