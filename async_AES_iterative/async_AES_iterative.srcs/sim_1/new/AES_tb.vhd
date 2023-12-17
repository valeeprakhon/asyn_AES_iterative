library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use work.defs.all;
use std.env.stop;

entity AES_tb is
--  Port ( );
end AES_tb;

architecture Behavioral of AES_tb is
    
    signal rst : std_logic;
        
    -- input
    signal TOKEN_IN : std_logic_vector(DATA_WIDTH-1 downto 0);
    signal TOKEN_IN_REQ : std_logic;
    signal TOKEN_IN_ACK : std_logic; 
    
    -- output
    signal TOKEN_OUT : std_logic_vector(DATA_WIDTH-1 downto 0);
    signal TOKEN_OUT_REQ : std_logic;
    signal TOKEN_OUT_ACK : std_logic;
    
    -- temp input
    signal temp_plan_text : std_logic_vector(127 downto 0);
    signal temp_key : std_logic_vector(127 downto 0);
    signal temp_round : std_logic_vector(3 downto 0);
    
    -- temp output 
    signal temp_out_key : std_logic_vector(127 downto 0);
    signal temp_out_chiper_text : std_logic_vector(127 downto 0);
    signal temp_out_round : std_logic_vector(3 downto 0);
    
    component AES is
    Port (   
        rst : in std_logic;
        
        -- input
        TOKEN_IN : in std_logic_vector(DATA_WIDTH-1 downto 0); 
        TOKEN_IN_REQ : in std_logic;
        TOKEN_IN_ACK : out std_logic; 
        
        -- output
        TOKEN_OUT : out std_logic_vector(DATA_WIDTH-1 downto 0);
        TOKEN_OUT_REQ : out std_logic;
        TOKEN_OUT_ACK : in std_logic  
    );
    end component AES;
    
    begin
        AES_module : component AES
        port map(
             rst => rst,
            -- input
            TOKEN_IN => TOKEN_IN,
            TOKEN_IN_REQ => TOKEN_IN_REQ,
            TOKEN_IN_ACK => TOKEN_IN_ACK, 
            
            -- output
            TOKEN_OUT => TOKEN_OUT,
            TOKEN_OUT_REQ => TOKEN_OUT_REQ,
            TOKEN_OUT_ACK => TOKEN_OUT_ACK
        );
        
--        process
--        begin
            
--            temp_plan_text <= x"340737e0a29831318d305a88a8f64332";
--            temp_key <= x"3c4fcf098815f7aba6d2ae2816157e2b";
--            temp_round <= x"0";
--            rst <= '1', '0' after 50 ns;
--            TOKEN_IN <= temp_round&temp_plan_text&temp_key;
        
--            TOKEN_OUT_ACK <= '0';
--            TOKEN_IN_REQ <= '0', '1' after 100 ns;
            
--            wait until TOKEN_OUT_REQ = '1';
--            rst <= '1', '0' after 50 ns;
            
        
--        end process;
        
        
        temp_plan_text <= x"340737e0a29831318d305a88a8f64332";
        temp_key <= x"3c4fcf098815f7aba6d2ae2816157e2b";
        temp_round <= x"0";
        rst <= '1', '0' after 50 ns;
        TOKEN_IN <= temp_round&temp_plan_text&temp_key;
        
        TOKEN_OUT_ACK <= '0';
        TOKEN_IN_REQ <= '0', '1' after 100 ns;

        temp_out_key <= TOKEN_OUT(127 downto 0);
        temp_out_chiper_text <= TOKEN_OUT(255 downto 128);
        temp_out_round <= TOKEN_OUT(259 downto 256);
                      
end Behavioral;
