----------------------------------------
--          Matthew Allen             --
--           09/22/2016               --
--              Lab 3                 --
--  Top level design entity for basic --
--    counter display with hardware   --
----------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity top is port 
  (
    clk             : in  std_logic; 
    reset           : in  std_logic;
    add_button      : in  std_logic;
    subtract_button : in  std_logic;
    input_a         : in  std_logic_vector(2 downto 0);
    input_b         : in  std_logic_vector(2 downto 0);
    display_one     : out std_logic_vector(6 downto 0);
    display_two     : out std_logic_vector(6 downto 0);
    display_three   : out std_logic_vector(6 downto 0)
  );
end top;

architecture arc of top is
--BEGIN COMPONENT DEFINITIONS--
component seven_seg is port
(
    clk             : in std_logic; 
    reset           : in std_logic;
    bcd             : in std_logic_vector(3 downto 0);
    seven_seg_out   : out std_logic_vector(6 downto 0)
);  
end component;
component generic_subtractor_beh is
  generic 
  (
    bits    : integer := 4
  );
  port 
  (
    a       : in  std_logic_vector(bits-1 downto 0);
    b       : in  std_logic_vector(bits-1 downto 0);
    cin     : in  std_logic;
    result  : out std_logic_vector(bits-1 downto 0);
    cout    : out std_logic
  );
end component;
component generic_adder_beh is
  generic 
  (
    bits    : integer := 4
  );
  port 
  (
    a       : in  std_logic_vector(bits-1 downto 0);
    b       : in  std_logic_vector(bits-1 downto 0);
    cin     : in  std_logic;
    sum     : out std_logic_vector(bits-1 downto 0);
    cout    : out std_logic
  );
end component;
--END COMPONENT DEFINITIONS--


--BEGIN INTERNAL SIGNAL CONNECTORS--
signal adder_result : std_logic_vector(3 downto 0);
signal adder_cin : std_logic := '0';
signal adder_cout : std_logic := '0';

signal subtractor_result : std_logic_vector(3 downto 0);
signal subtractor_cin : std_logic := '0';
signal subtractor_cout : std_logic := '0';
signal left_display_output : std_logic_vector(6 downto 0);
signal center_display_output : std_logic_vector(6 downto 0);
signal right_display_output : std_logic_vector(6 downto 0);
signal bcd_result : std_logic_vector(3 downto 0) := (others => '0');

signal add_sub_flag : std_logic := '0';
signal input_a_padded : std_logic_vector(3 downto 0) := (others => '0');
signal input_b_padded : std_logic_vector(3 downto 0) := (others => '0');
--END INTERNAL SIGNAL CONNECTORS--


begin
  sum_register:process(clk,reset) -- synchronizing register process
  begin
    if(reset = '1') then
      bcd_result <= (others => '0');
      add_sub_flag <= '0';
    elsif(clk'event and clk = '1') then -- only act when enabled and on a rising edge
      if(add_button = '1') then
        add_sub_flag <= '1';
      else
        add_sub_flag <= '0';
      end if;
      
      if(add_sub_flag = '1') then
        bcd_result <= adder_result;
      else
        bcd_result <= subtractor_result;
      end if;
      
      display_one <= left_display_output;
      display_two <= center_display_output;
      display_three <= right_display_output;
      input_a_padded <= '0' & input_a;
      input_b_padded <= '0' & input_b;
      
    end if;
  end process;
  
  --BEGIN COMPONENT INSTANTIATION--
  adder: generic_adder_beh
    generic map
    (
      bits => 4
    )
    port map
    (
      a => input_a_padded,
      b => input_b_padded,
      cin => adder_cin,
      cout => adder_cout,
      sum => adder_result
    );
    
  subtractor: generic_subtractor_beh
    generic map
    (
      bits => 4
    )
    port map
    (
      a => input_a_padded,
      b => input_b_padded,
      cin => subtractor_cin,
      cout => subtractor_cout,
      result => subtractor_result
    );
  left_display:seven_seg
  port map
  (
    clk => clk,
    reset => reset,
    bcd => bcd_result,
    seven_seg_out => left_display_output
  );
  
  center_display:seven_seg
  port map
  (
    clk => clk,
    reset => reset,
    bcd => input_a_padded,
    seven_seg_out => center_display_output
  );
  
  right_display:seven_seg
  port map
  (
    clk => clk,
    reset => reset,
    bcd => input_b_padded,
    seven_seg_out => right_display_output
  );
--END COMPONENT INSTANTIATION--
end arc;