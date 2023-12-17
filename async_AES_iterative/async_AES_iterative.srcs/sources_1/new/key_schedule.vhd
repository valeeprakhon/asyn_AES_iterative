library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.defs.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;


entity key_schedule is
    generic(
        DATA_WIDTH : natural := DATA_WIDTH
    );
    Port (
        -- in chennel
        in_data : in  std_logic_vector(DATA_WIDTH -1 downto 0);
        -- out chennel
        out_data : out std_logic_vector(DATA_WIDTH -1 downto 0)
    );
end key_schedule;

architecture Behavioral of key_schedule is
    signal key : std_logic_vector(127 downto 0);
    signal round : std_logic_vector(3 downto 0);
    signal expand_key : std_logic_vector(127 downto 0);
    signal substitued_sk : std_logic_vector(31 downto 0);
	signal shifted_sk : std_logic_vector(31 downto 0);
	signal w3, w2, w1, w0 : std_logic_vector(31 downto 0);
	signal sub_word : std_logic_vector(31 downto 0);
	signal round_const : std_logic_vector(7 downto 0);
	signal ack : std_logic; 
	signal temp : std_logic_vector(DATA_WIDTH -1 downto 0);
    
begin

    round <= in_data(259 downto 256);
    key <= in_data(127 downto 0);
    
	-- sub word
	gen : for i in 12 to 15 generate
	   sbox_inst : entity work.sbox
	       port map(
				input_byte  => key((i + 1)*8 - 1 downto i*8),
				output_byte => substitued_sk((i + 1 - 12)*8 - 1 downto (i - 12)*8)
	       );
	end generate gen;
	
	-- Round constants
	rcon_0 : entity work.rcon
	port map( input_byte  => round,
	          output_byte => round_const);
	
    -- New key schedule    
    shifted_sk <= substitued_sk(7 downto 0) & substitued_sk(31 downto 8);    
	w0(31 downto 8) <= key(31 downto 8) xor shifted_sk(31 downto 8);
    w0(7 downto 0) <= key(7 downto 0) xor round_const xor shifted_sk(7 downto 0);
    w1 <= key(63 downto 32) xor w0;
    w2 <= key(95 downto 64) xor w1;
    w3 <= key(127 downto 96) xor w2;
	
	expand_key <= w3 & w2 & w1 & w0;  
	
	temp <= in_data(259 downto 128)& expand_key;
	out_data <= temp;

end Behavioral;
