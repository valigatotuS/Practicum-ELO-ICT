library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity UART is
    generic(
    CLK_FREQ: natural;
    BAUDRATE: natural);
    port(
    -- First we define the real hardware I/O ports of the entity:
    CLK: in std_logic ;
    RX: in std_logic := '0';

    -- The entity will put RX_VALID high when it has
    -- received valid data over RX. The valid data can then name
    -- read by using the RX_DATA port.
    RX_VALID: inout std_logic := '0';
    RX_DATA: inout std_logic_vector(7 downto 0) := (others => '0')
    );

end entity UART;

    architecture Behavioral of UART is
    -- We need to define our clock signal
    component CLOCK_DIVIDER is
        generic(
        FREQ_IN: natural;
        FREQ_OUT: natural);
        port(
        CLK_IN : in std_logic;
        CLK_OUT : out std_logic;
        ENABLE : in std_logic
        );
    end component;
    
    -- Signals connected to the clock divider for the RX part
    signal CLK_RX: std_logic := '0';
    signal CLK_RX_EN: std_logic := '0';
    
    -- Buffers for storing RX data
    signal RX_DATA_INTERNAL: std_logic_vector(7 downto 0) := (others => '0');
    

begin

    -- Initialize a clock divider for RX
    RX_BAUD_GEN: CLOCK_DIVIDER
    generic map(FREQ_IN => CLK_FREQ, FREQ_OUT => BAUDRATE)
    port map(CLK_IN => CLK, CLK_OUT => CLK_RX, ENABLE => CLK_RX_EN);

    RX_SAMPLING_PROC:process(CLK, CLK_RX)
        type STATE_T is (IDLE, START_BIT, DATA_BIT, STOP_BIT);
        variable RX_STATE: STATE_T := IDLE;
        variable BIT_COUNTER: natural := 0;
        variable START_RX: boolean := false;
        begin
            if RX = '0' and START_RX = false then
                START_RX := true;
            end if;
            case RX_STATE is
                when IDLE =>
                    if rising_edge(CLK) then
                        RX_VALID <= '0';
                    end if;
                    if START_RX = true then
                        RX_STATE := START_BIT;
                        CLK_RX_EN <= '1';
                        BIT_COUNTER := 0;
                    end if;
                when START_BIT =>
                    if rising_edge(CLK_RX) and RX = '0' then
                        RX_STATE := DATA_BIT;
                    else
                        RX_STATE := IDLE;
                    end if;
                when DATA_BIT =>
                    if rising_edge(CLK_RX) then
                        if BIT_COUNTER = 8 then
                        RX_STATE := STOP_BIT;
                    else
                        RX_DATA_INTERNAL(BIT_COUNTER) <= RX;
                        BIT_COUNTER := BIT_COUNTER + 1;
                    end if;
                end if;
                when STOP_BIT =>
                    if rising_edge(CLK_RX) then
                        START_RX := false;
                        CLK_RX_EN <= '0';
                        RX_STATE := IDLE;
                    if RX = '1' then
                        RX_VALID <= '1';
                        RX_DATA <= RX_DATA_INTERNAL;
                    end if;
                end if;
            end case;
end process;
                        
                        
                        
end architecture;


