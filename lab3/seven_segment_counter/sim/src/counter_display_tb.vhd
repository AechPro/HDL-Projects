library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter_display_tb is
end counter_display_tb;

architecture arc of counter_display_tb is

component top is
  port 
  (
    clk             : in std_logic; 
    reset           : in std_logic
  );  
end component; 

constant period     : time := 20ns;                                              
signal clk          : std_logic := '0';
signal reset        : std_logic := '1';

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
    reset <= '0';
    wait;
  end process; 

  uut: top
  port map
  (        
    clk            => clk,
    reset          => reset
  );
end arc;