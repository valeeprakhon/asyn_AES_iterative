library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.defs.all;
entity mix_columns is
     generic ( 
        DATA_WIDTH  : natural       := DATA_WIDTH
    );
    Port ( 
        -- in chennel
        in_data : in std_logic_vector(DATA_WIDTH -1 downto 0);
        -- out chennel
        out_data : out std_logic_vector(DATA_WIDTH -1 downto 0)
    );
end mix_columns;

architecture Behavioral of mix_columns is

signal p0,p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12,p13,p14,p15:std_logic_vector(7 downto 0);

signal round : std_logic_vector(3 downto 0); 
signal keys : std_logic_vector(127 downto 0);
signal plainText : std_logic_vector(127 downto 0);
signal mixColumns : std_logic_vector(127 downto 0);
signal tempOut  : std_logic_vector(DATA_WIDTH -1 downto 0);

signal ack, req : std_logic;
    
attribute dont_touch : string;
attribute dont_touch of  ack, req : signal is "true";   
attribute dont_touch of  round : signal is "true";   
attribute dont_touch of  keys : signal is "true"; 
attribute dont_touch of  plainText : signal is "true"; 
attribute dont_touch of  mixColumns : signal is "true"; 
attribute dont_touch of  tempOut : signal is "true"; 

component one_byte_mix_column is
    Port ( i1,i2,i3,i4: in STD_LOGIC_VECTOR (7 downto 0);
           data_out : out  STD_LOGIC_VECTOR (7 downto 0));
end component;

begin

    keys <= in_data(127 downto 0);
    plainText <= in_data(255 downto 128);
    round <= in_data(259 downto 256);
   
	mix_columns_inst0 : entity work.column_calculator
		port map(
			in_data  => plainText(31 downto 0),
			out_data => mixColumns(31 downto 0)
		);
	mix_columns_inst1 : entity work.column_calculator
		port map(
			in_data  => plainText(63 downto 32),
			out_data => mixColumns(63 downto 32)
		);		
	mix_columns_inst2 : entity work.column_calculator
		port map(
			in_data  => plainText(95 downto 64),
			out_data => mixColumns(95 downto 64)
		);
	mix_columns_inst3 : entity work.column_calculator
		port map(
			in_data  => plainText(127 downto 96),
			out_data => mixColumns(127 downto 96)
		);
    
    tempOut <= round&mixColumns&keys;
    out_data <= tempOut;
    
end Behavioral;
