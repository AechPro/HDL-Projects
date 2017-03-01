library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity CPU_tb is
end CPU_tb;

architecture arc of CPU_tb is

component top is port 
(
  clk : in  std_logic; 
  reset : in  std_logic;
  execute_btn : in std_logic;
  display_one : out std_logic_vector(6 downto 0);
  display_two : out std_logic_vector(6 downto 0);
  display_three : out std_logic_vector(6 downto 0);
  state_LEDS : out std_logic_vector(2 downto 0)
);
end component; 

constant period : time := 20ns;
signal execute_btn : std_logic := '1';
signal SSD1 : std_logic_vector(6 downto 0);
signal SSD2 : std_logic_vector(6 downto 0);
signal SSD3 : std_logic_vector(6 downto 0);

signal clk          : std_logic := '0';
signal reset        : std_logic := '0';

begin

  -- clock process
  clock: process
    begin
      clk <= not clk;
      wait for period/2;
  end process; 
   
  -- reset process
  async_reset: process
    begin
      wait for 2 * period;
      reset <= '1';
      wait;
  end process;
  execute_btn <= not execute_btn after period*50;
  --input process
  input_changer: process
  begin
    for i in 0 to 127 loop
     -- instruction(7 downto 0) <= std_logic_vector(unsigned(instruction(7 downto 0))+1);
      wait for period*2;
    end loop;
  end process;
  uut: TOP
  port map
  (
    clk=>clk,
    reset=>reset,
    execute_btn => execute_btn,
    display_one=>SSD1,
    display_two=>SSD2,
    display_three=>SSD3
  );
end arc;