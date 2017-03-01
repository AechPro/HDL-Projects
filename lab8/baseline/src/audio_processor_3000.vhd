----------------------------------------
--          Matthew Allen             --
--           12/08/2016               --
--              Lab 8                 --
--    Audio Processor 3000 design     --
----------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity audio_processor_3000 is 
  port(
    clk                 : in std_logic;
    reset               : in std_logic;
    execute_btn         : in std_logic;
    sync                : in std_logic;
    led                 : out std_logic_vector(7 downto 0);
    audio_out           : out std_logic_vector(15 downto 0)
  );
end audio_processor_3000;

architecture beh of audio_processor_3000 is
--BEGIN CONSTANTS--
constant IDLE  : std_logic_vector(2 downto 0) := "000";
constant FETCH : std_logic_vector(2 downto 0) := "001";
constant EXECUTE : std_logic_vector(2 downto 0) := "010";
constant DECODE : std_logic_vector(2 downto 0) := "011";
constant DECODE_ERROR : std_logic_vector(2 downto 0) := "100";

constant OP_PLAY : std_logic_vector(1 downto 0) := "00";
constant OP_PAUSE : std_logic_vector(1 downto 0) := "01";
constant OP_SEEK : std_logic_vector(1 downto 0) := "10";
constant OP_STOP : std_logic_vector(1 downto 0) := "11";

constant AUDIO_BEGIN : std_logic_vector(13 downto 0) := "00000000000000";
constant AUDIO_END : std_logic_vector(13 downto 0) := "11111111111111";
--END CONSTANTS--

signal state_reg : std_logic_vector(2 downto 0) := IDLE; -- current state
signal state_next : std_logic_vector(2 downto 0) := IDLE; -- next state 

signal PC : std_logic_vector(4 downto 0) := (others => '0'); -- program counter pointer
signal instruction : std_logic_vector(7 downto 0) := (others => '0'); -- current instruction that has been fetched
signal instruction_data_out: std_logic_vector(7 downto 0) := (others => '0'); -- output signal for instruction data ROM block
signal opcode : std_logic_vector(1 downto 0) := (others => '0'); -- opcode decoded from instruction
signal error_flag : std_logic := '0'; -- flag to be set if an error is detected in the instruction
signal repeat : std_logic := '0'; -- flag to be set if the repeat bit is detected in the instruction

--the following signals are data address values for each possible audio output state--
signal data_address_reg  : std_logic_vector(13 downto 0) := (others => '0');
signal data_address_play  : std_logic_vector(13 downto 0) := (others => '0');
signal data_address_play_repeat  : std_logic_vector(13 downto 0) := (others => '0');
signal data_address_stop  : std_logic_vector(13 downto 0) := (others => '0');
signal data_address_seek  : std_logic_vector(13 downto 0) := (others => '0');
signal data_address_pause  : std_logic_vector(13 downto 0) := (others => '0');
signal data_address  : std_logic_vector(13 downto 0) := (others => '0');

--end data address values--
signal seek_address : std_logic_vector(13 downto 0) := (others => '0'); -- address to seek to from instructions
signal edge : std_logic := '0'; -- edge detector for button input
  -- instruction memory
  component rom_instructions
    port(
      address    : in std_logic_vector (4 DOWNTO 0);
      clock      : in std_logic  := '1';
      q          : out std_logic_vector (7 DOWNTO 0)
    );
  end component;
  
  -- data memory
  component rom_data
    port(
      address  : in std_logic_vector (13 DOWNTO 0);
      clock    : in std_logic  := '1';
      q        : out std_logic_vector (15 DOWNTO 0)
    );
  end component;
  

begin

  -- data instantiation
  u_rom_data_inst : rom_data
  port map 
  (
    address    => data_address,
    clock      => clk,
    q          => audio_out
  );
  -- instruction instantiation
  instruction_data : rom_instructions
  port map
  (
    address => PC,
    clock => clk,
    q => instruction_data_out
  );
  
  -- process to appropriately iterate all data address signals
  address_process: process(clk,reset)
  begin 
    data_address_stop <= (others => '0');
    if (reset = '1') then 
      data_address_play <= AUDIO_BEGIN;
      data_address_play_repeat <= AUDIO_BEGIN;
      data_address_pause <= (others => '0');
      data_address_seek <= (others => '0');
    elsif (clk'event and clk = '1') 
    then
      if(sync = '1')
      then
        data_address_pause <= data_address;
        if(data_address < AUDIO_END)
        then
          data_address_play <= std_logic_vector(unsigned(data_address) + 1 );
        end if;
        data_address_seek <= seek_address;
        data_address_play_repeat <= std_logic_vector(unsigned(data_address) + 1 );
      end if;
    end if;
  end process;
  
  -- state register
  state_register:process(clk,reset)
  begin 
    if (reset = '1') 
    then
      state_reg <= IDLE; --default to idle state
    elsif (clk'event and clk = '1') 
    then
      state_reg <= state_next;
    end if;
  end process;
  
  -- process to determine which address signal will be sent to the audio output 
  output_register:process(clk,reset)
  begin
    edge <= '0';
    if(execute_btn'event and execute_btn = '0')
    then
      edge <= '1';
    end if;
    if (reset = '1') 
    then
      data_address <= (others => '0');
    elsif (clk'event and clk = '1') 
    then
      if(opcode = OP_PLAY and repeat = '1')
      then
        data_address <= data_address_play_repeat;
      elsif(opcode = OP_PLAY)
      then
        data_address <= data_address_play;
      elsif(opcode = OP_PAUSE)
      then
        data_address <= data_address_pause;
      elsif(opcode = OP_SEEK)
      then
        data_address <= data_address_seek;
      elsif(opcode = OP_STOP)
      then
        data_address <= data_address_stop;
      else
        data_address <= data_address_reg;
      end if;
    end if;
  end process;
  
  -- process to determine which state will be the next state
  state_next_logic: process(execute_btn, clk)
  begin
    if(execute_btn'event and execute_btn = '0')
    then
      PC <= std_logic_vector(unsigned(PC)+1); -- iterate program counter on falling edge of button
      if(state_reg = IDLE)
      then
        state_next <= FETCH;
      end if;
    end if;
    -- advance state machine for all states that are not idle
    if(state_reg = FETCH)
      then
        state_next <= DECODE;
      elsif(state_reg = DECODE and error_flag = '1') 
      then
        state_next <= DECODE_ERROR;
      elsif(state_reg = DECODE and error_flag = '0')
      then
        state_next <= EXECUTE;
      elsif(state_reg = EXECUTE or state_reg = DECODE_ERROR)
      then
        state_next <= IDLE;
      end if;
  end process;
  
  -- process to appropriately act based upon the current state
  state_reg_logic: process(state_reg)
  begin
    if(state_reg = IDLE)
    then
      data_address_reg <= data_address;
    elsif(state_reg = FETCH)
    then
      instruction <= instruction_data_out; -- fetch data
      data_address_reg <= data_address;
    elsif(state_reg = DECODE)
    then
      opcode <= instruction(7 downto 6); -- determine opcode from the instruction
      seek_address <= instruction(4 downto 0)&"000000000"; -- determine what address to seek to
      if(opcode ="10" and instruction(4 downto 0) = "00000") -- determine whether or not an error has been detected
      then
        error_flag <= '1';
      else
        error_flag <= '0';
      end if;
    elsif(state_reg = EXECUTE)
    then
      if(error_flag = '0')
      then
        data_address_reg <= data_address;
    end if;
  end process;
  repeat <= instruction(5); -- asynchronously set repeat bit
  led <= "10101010"; -- set LEDs to determine whether or not the machine is working at all
end beh;