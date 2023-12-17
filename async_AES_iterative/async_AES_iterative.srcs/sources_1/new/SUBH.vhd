library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.defs.all;

entity SUBH is
    generic ( 
        DATA_WIDTH : natural    := DATA_WIDTH;
        DELAY_SIZE  : natural    := INIT_DELAY
    );
    Port ( 
        -- input channel 
        in_req : in std_logic;
        in_ack : out std_logic;
        in_data : in std_logic_vector(DATA_WIDTH-1 downto 0);
		-- output channel
		out_data : out std_logic_vector(DATA_WIDTH-1 downto 0);
		out_req     : out std_logic;
        out_ack     : in std_logic
    );
end SUBH;

architecture Behavioral of SUBH is
    signal ack : std_logic;
    signal sub_bytes_out_data : std_logic_vector(DATA_WIDTH-1 downto 0);
    signal shift_rows_out_data : std_logic_vector(DATA_WIDTH-1 downto 0);
    
    attribute dont_touch : string;
    attribute dont_touch of  ack : signal is "true";  
    attribute dont_touch of  sub_bytes_out_data : signal is "true";  
    attribute dont_touch of  shift_rows_out_data : signal is "true"; 


begin
    ack <= out_ack;
    in_ack <= ack;
     
    delay_req: entity work.delay_element
    generic map(
      size => DELAY_SIZE
    )
    port map (
      d => in_req,
      z => out_req
    );
    
    sub_bytes: entity work.sub_bytes
    generic map(
      DATA_WIDTH => DATA_WIDTH
    )
    port map (
      in_data => in_data,
      out_data => sub_bytes_out_data
    );
    
    shift_rows: entity work.shift_rows
    generic map(
      DATA_WIDTH => DATA_WIDTH
    )
    port map (
      in_data => sub_bytes_out_data,
      out_data => shift_rows_out_data
    );
  
    out_data <= shift_rows_out_data;
    
end Behavioral;
