----------------------------------------
--          Matthew Alllen            --
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
    display         : out std_logic_vector(6 downto 0) -- output to map to hex display on board
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
component generic_adder_beh is
  generic 
  (
    bits    : integer := 4
  );
  port (
    a       : in  std_logic_vector(bits-1 downto 0);
    b       : in  std_logic_vector(bits-1 downto 0);
    cin     : in  std_logic;
    sum     : out std_logic_vector(bits-1 downto 0);
    cout    : out std_logic
  );
end component;
component generic_counter is
generic 
(
    max_count       : integer := 3
  );
  port (
    clk             : in  std_logic; 
    reset           : in  std_logic;
    output          : out std_logic
  );  
end component;
--END COMPONENT DEFINITIONS--
--BEGIN INTERNAL SIGNAL CONNECTORS--
signal adder_sum : std_logic_vector(3 downto 0);
signal adder_cin : std_logic := '0';
signal enable : std_logic;
signal display_output : std_logic_vector(6 downto 0);
signal adder_cout : std_logic := '0';
signal adder_b_input : std_logic_vector(3 downto 0) := (others => '0');
signal sum_sig : std_logic_vector(3 downto 0) := (others => '0');
--END INTERNAL SIGNAL CONNECTORS--
begin

  sum_register:process(enable,clk,adder_sum) -- synchronizing register process
  begin
    if(clk'event and clk = '1' and enable = '1') then -- only act when enabled and on a rising edge
      sum_sig <= adder_sum;
      adder_b_input <= "0001";
      display <= display_output;
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
      a => sum_sig,
      b => adder_b_input,
      cin => adder_cin,
      cout => adder_cout,
      sum => adder_sum
    );
  counter: generic_counter
  generic map
  (
    max_count => 50000000
  )
  port map
  (
    clk => clk,
    reset => reset,
    output => enable
  );
  seven_segment_display: seven_seg
  port map
  (
    clk => clk,
    reset => reset,
    bcd => sum_sig,
    seven_seg_out => display_output
  );
--END COMPONENT INSTANTIATION--
end arc;