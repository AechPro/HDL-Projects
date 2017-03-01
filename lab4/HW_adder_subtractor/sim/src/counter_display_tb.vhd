library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter_display_tb is
end counter_display_tb;

architecture arc of counter_display_tb is

component top is
  port 
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
end component; 

constant period     : time := 20ns;                                              
signal clk          : std_logic := '0';
signal reset        : std_logic := '1';
signal add_button          : std_logic := '1';
signal subtract_button     : std_logic := '0';
signal input_a             : std_logic_vector(2 downto 0) := (others => '0');
signal input_b             : std_logic_vector(2 downto 0) := (others => '0');
signal display_one         : std_logic_vector(6 downto 0);
signal display_two         : std_logic_vector(6 downto 0);
signal display_three       : std_logic_vector(6 downto 0);

begin
add_button <= not add_button after 5*period;
subtract_button <= not subtract_button after 3*period;
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
  
  --input process
  input_changer: process
  begin
    for i in 0 to 15 loop
      input_a <= std_logic_vector(unsigned(input_a) + 1 );
      for j in 0 to 15  loop
        input_b <= std_logic_vector(unsigned(input_b) + 1 );
        wait for period;
      end loop;
    end loop;
   end process;
  uut: top
  port map
  (        
    clk            => clk,
    reset          => reset,
    add_button => add_button,
    subtract_button => subtract_button,
    input_a => input_a,
    input_b => input_b
  );
end arc;