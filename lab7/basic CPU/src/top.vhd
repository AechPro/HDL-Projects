----------------------------------------
--          Matthew Allen             --
--           09/22/2016               --
--              Lab 6                 --
--  Top level design entity for basic --
--         CPU with hardware          --
----------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity top is port
(
  clk : in  std_logic; 
  reset : in  std_logic;
  execute_btn : in std_logic;
  display_one : out std_logic_vector(6 downto 0);
  display_two : out std_logic_vector(6 downto 0);
  display_three : out std_logic_vector(6 downto 0);
  state_LEDS : out std_logic_vector(2 downto 0)
);
end top;

architecture arc of top is
--BEGIN COMPONENT DEFINITIONS--
component ROM is
  port
  (
    address : in std_logic_vector(0 downto 0);
    clock : in std_logic := '1';
    q : out std_logic_vector(10 downto 0)
  );
end component;
component seven_seg is port
(
  clk : in std_logic; 
  reset : in std_logic;
  bcd : in std_logic_vector(3 downto 0);
  seven_seg_out : out std_logic_vector(6 downto 0)
);  
end component;
component alu is 
  generic
  (
    bits : integer := 8
  );
  port
  (
    clk : in std_logic;
    reset : in std_logic;
    saturation_value : in std_logic_vector((bits*2)-1 downto 0);
    op : in std_logic_vector(2 downto 0);
    a : in std_logic_vector(bits-1 downto 0);
    b : in std_logic_vector(bits-1 downto 0);
    result : out std_logic_vector((bits*2)-1 downto 0)
  );
end component;

component memory is 
  generic 
  (
    addr_width : integer := 2;
    data_width : integer := 4
  );
  port 
  (
    clk : in std_logic;
    we : in std_logic;
    addr : in std_logic_vector(addr_width - 1 downto 0);
    din : in std_logic_vector(data_width - 1 downto 0);
    dout : out std_logic_vector(data_width - 1 downto 0)
  );
end component;
--END COMPONENT DEFINITIONS--
constant DISPLAY  : std_logic_vector(2 downto 0) := "000";
constant EXECUTE : std_logic_vector(2 downto 0) := "001";
constant MS : std_logic_vector(2 downto 0) := "010";
constant WR_SAVE : std_logic_vector(2 downto 0) := "011";
constant MR : std_logic_vector(2 downto 0) := "100";
constant CLEAR : std_logic_vector(2 downto 0) := "101";
constant MEM_WRITE : std_logic_vector(2 downto 0) := "110";
constant ALU_SATURATION_VALUE : std_logic_vector(15 downto 0) := "0000000100000000";

--BEGIN INTERNAL SIGNAL CONNECTORS--
signal left_display_output : std_logic_vector(6 downto 0) := (others => '0');
signal center_display_output : std_logic_vector(6 downto 0) := (others => '0');
signal right_display_output : std_logic_vector(6 downto 0) := (others => '0');

signal left_display_input : std_logic_vector(3 downto 0) := (others => '0');
signal center_display_input : std_logic_vector(3 downto 0) := (others => '0');
signal right_display_input : std_logic_vector(3 downto 0) := (others => '0');

signal RAM_in : std_logic_vector(7 downto 0) := "00000001";
signal RAM_out : std_logic_vector(7 downto 0) := (others => '0');
signal RAM_address : std_logic_vector(1 downto 0) := "01";
signal RAM_write: std_logic := '0';

signal alu_operation : std_logic_vector(2 downto 0) := (others => '0');
signal alu_result : std_logic_vector(15 downto 0) := (others => '0');


signal dabble_value_sync : std_logic_vector(11 downto 0) := (others => '0');
signal dabble_value : std_logic_vector(11 downto 0) := (others => '0');

signal next_state : std_logic_vector(2 downto 0) := CLEAR;
signal current_state : std_logic_vector(2 downto 0) := (others => '0');

signal not_reset : std_logic := '0';

signal state_logic_flags : std_logic_vector(2 downto 0) := "000";
signal state_process_trigger : std_logic := '0';

signal instruction_sync : std_logic_vector(10 downto 0) := (others => '0');
signal execute_sync : std_logic := '0';

signal ROM_addr : std_logic_vector(0 downto 0) := (others => '0');
--END INTERNAL SIGNAL CONNECTORS--

begin
  
  state_register:process(clk,reset) -- state register process
  begin
    if(reset = '0') 
    then
      current_state <= CLEAR;
      state_LEDS <= (others => '0');
    elsif(clk'event and clk = '1') 
    then
      current_state <= next_state;
      state_LEDS <= next_state;
    end if;
  end process;
  
  signal_synchronizer:process(clk,reset) -- register for each signal before output
  begin
    not_reset <= not reset;
    if(reset = '0') then
      display_one <= (others => '0');
      display_two <= (others => '0');
      display_three <= (others => '0');
      execute_sync <= '0';
      alu_operation <= (others => '0');
      dabble_value_sync <= (others => '0');
    elsif(clk'event and clk = '1') then
      execute_sync <= execute_btn;
      alu_operation <= '0'&instruction_sync(10 downto 9);
      dabble_value_sync <= dabble_value;
      display_one <= left_display_output;
      display_two <= center_display_output;
      display_three <= right_display_output;
      state_process_trigger <= not state_process_trigger;
    end if;
  end process;
  
  next_state_logic: process(state_logic_flags, execute_sync) -- process to determine next state
  begin
    if(execute_sync = '0') 
    then
      case(instruction_sync(10 downto 8)) is
        when "010" => next_state <= MS;
        when "100" => next_state <= MR;
        when others => next_state <= EXECUTE;
      end case;
    else
      next_state <= DISPLAY;
    end if;
    if(state_logic_flags = "001")
    then
      next_state <= MEM_WRITE;
    elsif(state_logic_flags = "010" and execute_sync = '1')
    then
      next_state <= WR_SAVE;
    end if;
  end process;
  
  current_state_logic: process(state_process_trigger, current_state) -- process to perform appropriate operations based upon current state
  begin
    if(current_state = CLEAR)
    then
      state_logic_flags <= "000";
      dabble_value <= (others => '0');
      RAM_address <= "00";
      RAM_write <= '1';
      RAM_in <= (others => '0');
    elsif(current_state = EXECUTE)
    then
      state_logic_flags <= "010";
      dabble_value <= alu_result(11 downto 0);
      RAM_address <= "00";
      RAM_write <= '0';
      RAM_in <= instruction_sync(7 downto 0);
    elsif(current_state = WR_SAVE)
    then
      state_logic_flags <= "000";
      dabble_value <= dabble_value_sync;
      RAM_address <= "00";
      RAM_write <= '1';
      RAM_in <= alu_result(7 downto 0);
    elsif(current_state = MS)
    then
      state_logic_flags <= "000";
      RAM_in <= RAM_out;
      RAM_address <= "01";
      RAM_write <= '1';
      dabble_value <= dabble_value_sync;
    elsif(current_state = MR)
    then
      state_logic_flags <= "001";
      RAM_in <= RAM_out;
      RAM_address <= "01";
      RAM_write <= '0';
      dabble_value <= dabble_value_sync;
    elsif(current_state = MEM_WRITE)
    then
      state_logic_flags <= "000";
      RAM_write <= '1';
      RAM_address <= "00";
      RAM_in <= RAM_out;
      dabble_value <= dabble_value_sync;
    else -- DISPLAY state
      state_logic_flags <= "000";
      RAM_write <= '0';
      RAM_address <= "00";
      RAM_in <= (others => '0');
      dabble_value <= dabble_value_sync;
    end if;
  end process;
  --DOUBLE DABBLE--
  double_dabble: process(dabble_value_sync)
  variable temp : STD_LOGIC_VECTOR (11 downto 0);
  variable bcd : UNSIGNED (15 downto 0) := (others => '0');
  
  begin
    bcd := (others => '0');
    temp(11 downto 0) := dabble_value_sync;
    for i in 0 to 11 loop
      if bcd(3 downto 0) > 4 then 
        bcd(3 downto 0) := bcd(3 downto 0) + 3;
      end if;
      
      if bcd(7 downto 4) > 4 then 
        bcd(7 downto 4) := bcd(7 downto 4) + 3;
      end if;
    
      if bcd(11 downto 8) > 4 then  
        bcd(11 downto 8) := bcd(11 downto 8) + 3;
      end if;
      bcd := bcd(14 downto 0) & temp(11);
      temp := temp(10 downto 0) & '0';
    end loop;
 
    -- set outputs
    right_display_input <= STD_LOGIC_VECTOR(bcd(3 downto 0));
    center_display_input <= STD_LOGIC_VECTOR(bcd(7 downto 4));
    left_display_input <= STD_LOGIC_VECTOR(bcd(11 downto 8));
  end process;
  --BEGIN COMPONENT INSTANTIATION--
  ROM_block: ROM
  port map
  (
    address => ROM_addr,
    clock => clk,
    q => instruction_sync
  );
  RAM_block: memory
  generic map
  (
    addr_width => 2,
    data_width => 8
  )
  port map
  (
    clk => clk,
    we => RAM_write,
    addr => RAM_address,
    din => RAM_in,
    dout => RAM_out
  );
  
  calculation_unit:alu
  generic map
  (
    bits => 8
  )
  port map
  (
    clk => clk,
    reset => not_reset,
    saturation_value => ALU_SATURATION_VALUE,
    op => alu_operation,
    a => RAM_out,
    b => instruction_sync(7 downto 0),
    result => alu_result
  );
  
  left_display:seven_seg
  port map
  (
    clk => clk,
    reset => not_reset,
    bcd => left_display_input,
    seven_seg_out => left_display_output
  );
  
  center_display:seven_seg
  port map
  (
    clk => clk,
    reset => not_reset,
    bcd => center_display_input,
    seven_seg_out => center_display_output
  );
  
  right_display:seven_seg
  port map
  (
    clk => clk,
    reset => not_reset,
    bcd => right_display_input,
    seven_seg_out => right_display_output
  );
--END COMPONENT INSTANTIATION--
end arc;