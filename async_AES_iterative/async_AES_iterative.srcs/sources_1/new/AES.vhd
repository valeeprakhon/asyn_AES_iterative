library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.defs.all;

entity AES is
    Port (   
        rst             : in std_logic;
        
        -- input
        TOKEN_IN        : in std_logic_vector(DATA_WIDTH-1 downto 0); 
        TOKEN_IN_REQ    : in std_logic;
        TOKEN_IN_ACK    : out std_logic; 
        
        -- output
        TOKEN_OUT       : out std_logic_vector(DATA_WIDTH-1 downto 0);
        TOKEN_OUT_REQ   : out std_logic;
        TOKEN_OUT_ACK   : in std_logic

    );
end AES;

architecture Behavioral of AES is
    
    signal MX_0_outC_req : std_logic;
    signal MX_0_outC_ack : std_logic;
    signal MX_0_outC_data : std_logic_vector(DATA_WIDTH-1 downto 0);
    
    signal LF_0_outB_req    : std_logic;
    signal LF_0_outB_data   : std_logic_vector(DATA_WIDTH-1 downto 0); 
    signal LF_0_outB_ack    : std_logic;
    signal LF_0_outC_req    : std_logic;
    signal LF_0_outC_data   : std_logic_vector(DATA_WIDTH-1 downto 0);
    signal LF_0_outC_ack    : std_logic;
    
    signal CL_0_selector    : std_logic;
    signal CL_0_out_req     : std_logic;
    signal CL_0_out_ack     : std_logic;
    
    signal F_0_outB_req     : std_logic;
    signal F_0_outB_ack     : std_logic;
    signal F_0_outC_req     : std_logic;
    signal F_0_outC_ack     : std_logic;
    
    signal DX_0_outC_data   : std_logic_vector(DATA_WIDTH-1 downto 0);
    signal DX_0_outC_req    : std_logic;
    signal DX_0_outC_ack    : std_logic;
    
    signal DX_0_outB_data   : std_logic_vector(DATA_WIDTH-1 downto 0);
    signal DX_0_outB_req    : std_logic;
    signal DX_0_outB_ack    : std_logic;
    
    signal DL_0_out_data  : std_logic;
    signal DL_0_out_req   : std_logic;
    signal DL_0_out_ack   : std_logic;
    
    signal DL_1_out_data  : std_logic_vector(DATA_WIDTH-1 downto 0);
    signal DL_1_out_req   : std_logic;
    signal DL_1_out_ack   : std_logic;
    
    signal CL_1_out_data    : std_logic_vector(DATA_WIDTH-1 downto 0);
    signal CL_1_out_req     : std_logic;
    signal CL_1_out_ack     : std_logic;
    
    signal DL_2_out_data  : std_logic_vector(DATA_WIDTH-1 downto 0);
    signal DL_2_out_req   : std_logic;
    signal DL_2_out_ack   : std_logic;
    
    signal CL_2_out_data    : std_logic_vector(DATA_WIDTH-1 downto 0);
    signal CL_2_out_req     : std_logic;
    signal CL_2_out_ack     : std_logic;
    
    signal DL_3_out_data  : std_logic_vector(DATA_WIDTH-1 downto 0);
    signal DL_3_out_req   : std_logic;
    signal DL_3_out_ack   : std_logic;
    
    signal CL_3_out_data    : std_logic_vector(DATA_WIDTH-1 downto 0);
    signal CL_3_out_req     : std_logic;
    signal CL_3_out_ack     : std_logic;
   
    signal DL_4_out_data  : std_logic_vector(DATA_WIDTH-1 downto 0);
    signal DL_4_out_req   : std_logic;
    signal DL_4_out_ack   : std_logic;
    
    signal DL_5_out_data  : std_logic_vector(DATA_WIDTH-1 downto 0);
    signal DL_5_out_req   : std_logic;
    signal DL_5_out_ack   : std_logic;
    
    signal CL_4_out_data    : std_logic_vector(DATA_WIDTH-1 downto 0);
    signal CL_4_out_req     : std_logic;
    signal CL_4_out_ack     : std_logic;
    
    signal DL_6_out_data  : std_logic_vector(DATA_WIDTH-1 downto 0);
    signal DL_6_out_req   : std_logic;
    signal DL_6_out_ack   : std_logic;
    
    signal CL_5_out_data    : std_logic_vector(DATA_WIDTH-1 downto 0);
    signal CL_5_out_req     : std_logic;
    signal CL_5_out_ack     : std_logic;
    
    signal DL_7_out_data  : std_logic_vector(DATA_WIDTH-1 downto 0);
    signal DL_7_out_req   : std_logic;
    signal DL_7_out_ack   : std_logic;
    
    signal CL_6_out_data    : std_logic_vector(DATA_WIDTH-1 downto 0);
    signal CL_6_out_req     : std_logic;
    signal CL_6_out_ack     : std_logic;
    
    signal DL_8_out_data  : std_logic_vector(DATA_WIDTH-1 downto 0);
    signal DL_8_out_req   : std_logic;
    signal DL_8_out_ack   : std_logic;
    
begin

    MX_0 : entity work.mux
    port map (
        rst         => rst,
        -- Input from channel 1
        inA_req     => TOKEN_IN_REQ,
        inA_data    => TOKEN_IN,
        inA_ack     => TOKEN_IN_ACK,
        
        -- Input from channel 2
        inB_req     => DL_4_out_req,
        inB_data    => DL_4_out_data ,
        inB_ack     => DL_4_out_ack,
        
        -- Output port 
        outC_req    => MX_0_outC_req,
        outC_data   => MX_0_outC_data,
        outC_ack    => MX_0_outC_ack,
        
        -- Select port
        inSel_req   => DL_0_out_req,
        inSel_ack   => DL_0_out_ack,
        selector(0) => DL_0_out_data
    );
    
    LF_0 : entity work.reg_fork
    generic map(
        PHASE_INIT_A => '0',
        PHASE_INIT_B =>'0',
        PHASE_INIT_C => '0'
    )
    port map (
        rst => rst,
        --Input channel
        inA_req     => MX_0_outC_req,
        inA_data    => MX_0_outC_data,
        inA_ack     => MX_0_outC_ack,
        --Output channel 1
        outB_req    => LF_0_outB_req,
        outB_data   => LF_0_outB_data,
        outB_ack    => LF_0_outB_ack,
        --Output channel 2
        outC_req    => LF_0_outC_req,
        outC_data   => LF_0_outC_data,
        outC_ack    => LF_0_outC_ack
    );
    
    CL_0 : entity work.round_check
    generic map (
         VALUE => 9,
         DELAY_SIZE => CL_0_DELAY
    )
    port map (
        -- input chennel 
        in_data     => LF_0_outB_data,
        in_req      => LF_0_outB_req,
        in_ack      => LF_0_outB_ack,
        -- output chennel
        selector    => CL_0_selector,
        out_req     => CL_0_out_req,
        out_ack     => CL_0_out_ack
    );
    
    F_0 : entity work.fork
    port map (
        rst => rst,
        -- Input channel
        inA_req     => CL_0_out_req,
        inA_ack     => CL_0_out_ack,
        -- Output channel 1
        outB_req    => F_0_outB_req,
        outB_ack    => F_0_outB_ack,
        -- Output channel 2
        outC_req    => F_0_outC_req,
        outC_ack    => F_0_outC_ack
    );
    
    DL_0 : entity work.decoupled_hs_reg
    generic map (
        DATA_WIDTH=> 1,
        VALUE => 1,
        PHASE_INIT_IN => '0',
        PHASE_INIT_OUT => '1'
    )
    port map (
        rst => rst,
        -- Input channel
        in_ack      => F_0_outB_ack,
        in_req      => F_0_outB_req ,
        in_data(0)  => CL_0_selector,
        -- Output channel
        out_req     => DL_0_out_req,
        out_data(0) => DL_0_out_data,
        out_ack     => DL_0_out_ack
    );
    
    DX_0 : entity work.demux
    port map (
        rst => rst,
        -- Input port
        inA_req     => LF_0_outC_req,
        inA_data    => LF_0_outC_data,
        inA_ack     => LF_0_outC_ack,
        -- Select port 
        inSel_req   => F_0_outC_req,
        inSel_ack   => F_0_outC_ack,
        selector    => CL_0_selector,
        -- Output channel 1
        outB_req    => DX_0_outB_req,
        outB_data   => DX_0_outB_data,
        outB_ack    => DX_0_outB_ack,
        -- Output channel 2
        outC_req    => DX_0_outC_req,
        outC_data   => DX_0_outC_data,
        outC_ack    => DX_0_outC_ack
    );

    DL_1 : entity work.decoupled_hs_reg
    generic map (
        PHASE_INIT_IN => '0',
        PHASE_INIT_OUT => '0'
    )
    port map (
        rst         => rst,
        -- Input channel
        in_ack      => DX_0_outC_ack,
        in_req      => DX_0_outC_req,
        in_data     => DX_0_outC_data,
        -- Output channel
        out_req     => DL_1_out_req,
        out_data    => DL_1_out_data,
        out_ack     => DL_1_out_ack
    );
    
    CL_1: entity work.ADD
    generic map ( 
        DATA_WIDTH => DATA_WIDTH,
        DELAY_SIZE => CL_1_DELAY
    )
    port map ( 
        -- input channel 
        in_req => DL_1_out_req,
        in_ack => DL_1_out_ack,
        in_data => DL_1_out_data,
		-- output channel
		out_data => CL_1_out_data,
		out_req => CL_1_out_req,
        out_ack => CL_1_out_ack 
    );
    
    DL_2 : entity work.decoupled_hs_reg
    generic map (
        PHASE_INIT_IN => '0',
        PHASE_INIT_OUT => '0'
    )
    port map (
        rst         => rst,
        -- Input channel
        in_ack      => CL_1_out_ack,
        in_req      => CL_1_out_req,
        in_data     => CL_1_out_data,
        -- Output channel
        out_req     => DL_2_out_req,
        out_data    => DL_2_out_data,
        out_ack     => DL_2_out_ack
    );
    
    CL_2: entity work.SUBH
    generic map ( 
        DATA_WIDTH => DATA_WIDTH,
        DELAY_SIZE => CL_2_DELAY
    )
    port map ( 
        -- input channel 
        in_req => DL_2_out_req,
        in_ack => DL_2_out_ack,
        in_data => DL_2_out_data,
		-- output channel
		out_data => CL_2_out_data,
		out_req => CL_2_out_req,
        out_ack => CL_2_out_ack 
    );
    
    DL_3 : entity work.decoupled_hs_reg
    generic map (
        PHASE_INIT_IN => '0',
        PHASE_INIT_OUT => '0'
    )
    port map (
        rst         => rst,
        -- Input channel
        in_ack      => CL_2_out_ack,
        in_req      => CL_2_out_req,
        in_data     => CL_2_out_data,
        -- Output channel
        out_req     => DL_3_out_req,
        out_data    => DL_3_out_data,
        out_ack     => DL_3_out_ack
    );
    
    CL_3: entity work.MIX
    generic map ( 
        DATA_WIDTH => DATA_WIDTH,
        DELAY_SIZE => CL_3_DELAY
    )
    port map ( 
        -- input channel 
        in_req => DL_3_out_req,
        in_ack => DL_3_out_ack,
        in_data => DL_3_out_data,
		-- output channel
		out_data => CL_3_out_data,
		out_req => CL_3_out_req,
        out_ack => CL_3_out_ack 
    );
    
    DL_4 : entity work.decoupled_hs_reg
    generic map (
        PHASE_INIT_IN => '0',
        PHASE_INIT_OUT => '0'
    )
    port map (
        rst         => rst,
        -- Input channel
        in_ack      => CL_3_out_ack,
        in_req      => CL_3_out_req,
        in_data     => CL_3_out_data,
        -- Output channel
        out_req     => DL_4_out_req,
        out_data    => DL_4_out_data,
        out_ack     => DL_4_out_ack
    );
    
    DL_5 : entity work.decoupled_hs_reg
    generic map (
        PHASE_INIT_IN => '0',
        PHASE_INIT_OUT => '0'
    )
    port map (
        rst         => rst,
        -- Input channel
        in_ack      => DX_0_outB_ack,
        in_req      => DX_0_outB_req,
        in_data     => DX_0_outB_data,
        -- Output channel
        out_req     => DL_5_out_req,
        out_data    => DL_5_out_data,
        out_ack     => DL_5_out_ack
    );
    
    CL_4: entity work.ADD
    generic map ( 
        DATA_WIDTH => DATA_WIDTH,
        DELAY_SIZE => CL_4_DELAY
    )
    port map ( 
        -- input channel 
        in_req => DL_5_out_req,
        in_ack => DL_5_out_ack,
        in_data => DL_5_out_data,
		-- output channel
		out_data => CL_4_out_data,
		out_req => CL_4_out_req,
        out_ack => CL_4_out_ack 
    );
    
    DL_6 : entity work.decoupled_hs_reg
    generic map (
        PHASE_INIT_IN => '0',
        PHASE_INIT_OUT => '0'
    )
    port map (
        rst         => rst,
        -- Input channel
        in_ack      => CL_4_out_ack,
        in_req      => CL_4_out_req,
        in_data     => CL_4_out_data,
        -- Output channel
        out_req     => DL_6_out_req,
        out_data    => DL_6_out_data,
        out_ack     => DL_6_out_ack
    );
    
    CL_5: entity work.SUBH
    generic map ( 
        DATA_WIDTH => DATA_WIDTH,
        DELAY_SIZE => CL_5_DELAY
    )
    port map ( 
        -- input channel 
        in_req => DL_6_out_req,
        in_ack => DL_6_out_ack,
        in_data => DL_6_out_data,
		-- output channel
		out_data => CL_5_out_data,
		out_req => CL_5_out_req,
        out_ack => CL_5_out_ack 
    );
    
    DL_7 : entity work.decoupled_hs_reg
    generic map (
        PHASE_INIT_IN => '0',
        PHASE_INIT_OUT => '0'
    )
    port map (
        rst         => rst,
        -- Input channel
        in_ack      => CL_5_out_ack,
        in_req      => CL_5_out_req,
        in_data     => CL_5_out_data,
        -- Output channel
        out_req     => DL_7_out_req,
        out_data    => DL_7_out_data,
        out_ack     => DL_7_out_ack
    );
    
    CL_6: entity work.ADD
    generic map ( 
        DATA_WIDTH => DATA_WIDTH,
        DELAY_SIZE => CL_6_DELAY
    )
    port map ( 
        -- input channel 
        in_req => DL_7_out_req,
        in_ack => DL_7_out_ack,
        in_data => DL_7_out_data,
		-- output channel
		out_data => CL_6_out_data,
		out_req => CL_6_out_req,
        out_ack => CL_6_out_ack 
    );
    
    DL_8 : entity work.decoupled_hs_reg
    generic map (
        PHASE_INIT_IN => '0',
        PHASE_INIT_OUT => '0'
    )
    port map (
        rst         => rst,
        -- Input channel
        in_ack      => CL_6_out_ack,
        in_req      => CL_6_out_req,
        in_data     => CL_6_out_data,
        -- Output channel
        out_req     => DL_8_out_req,
        out_data    => DL_8_out_data,
        out_ack     => DL_8_out_ack
    );
    
    
     TOKEN_OUT      <= DL_8_out_data;
     TOKEN_OUT_REQ  <= DL_8_out_req;
     DL_8_out_ack   <= TOKEN_OUT_ACK;

end Behavioral;
