library IEEE;
use IEEE.std_logic_1164.all;

package defs is
	constant DATA_WIDTH  : Integer := 260;
	constant KEYS_WIDTH  : Integer := 128;
	constant ROUND_WIDTH : Integer := 4;  
	
	--Delay size
	constant INIT_DELAY : integer := 20;

	constant CL_0_DELAY : integer := 20;
    constant CL_1_DELAY : integer := 20;
    constant CL_2_DELAY : integer := 20;
    constant CL_3_DELAY : integer := 20;
    
    constant CL_4_DELAY : integer := 20;
    constant CL_5_DELAY : integer := 20;
    constant CL_6_DELAY : integer := 20;
    

	
end package;
