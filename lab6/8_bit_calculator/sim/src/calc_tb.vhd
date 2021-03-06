library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity calc_tb is
end calc_tb;

architecture arc of calc_tb is

component top is port 
(
  clk             : in  std_logic; 
  reset           : in  std_logic;
  button_input    : in std_logic_vector(2 downto 0);
  op_input        : in std_logic_vector(1 downto 0);
  switch_input    : in  std_logic_vector(7 downto 0);
  display_one     : out std_logic_vector(6 downto 0);
  display_two     : out std_logic_vector(6 downto 0);
  display_three   : out std_logic_vector(6 downto 0)
);
end component; 

constant period : time := 20ns;
signal switches  : std_logic_vector(7 downto 0) := (others => '0');
signal buttons  : std_logic_vector(2 downto 0) := (others => '0');
signal op : std_logic_vector(1 downto 0) := (others => '0');
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
  op <= std_logic_vector(unsigned(op)+1) after period*2;
  
  --input process
  input_changer: process
  begin
    for i in 0 to 127 loop
      buttons <= "110";
      wait for period*5;
	  buttons <= "101";
      wait for period*5;
	  switches <= std_logic_vector(unsigned(switches)+1);
      buttons <= "110";
      wait for period*5;
      buttons <= "011";
      wait for period*5;
	  switches <= std_logic_vector(unsigned(switches)+1);
    end loop;
  end process;
  uut: TOP
  port map
  (
    clk=>clk,
    reset=>reset,
    button_input=>buttons,
    op_input=>op,
    switch_input=>switches,
    display_one=>SSD1,
    display_two=>SSD2,
    display_three=>SSD3
  );
end arc;