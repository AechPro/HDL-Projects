-----------------------------------------
--          Matthew Alllen             --
--           09/22/2016                --
--              Lab 3                  --
--  Seven Segment Display Architecture --
-----------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity seven_seg is port 
(
    clk             : in std_logic; 
    reset           : in std_logic;
    bcd             : in std_logic_vector(3 downto 0);
    seven_seg_out   : out std_logic_vector(6 downto 0)
);  
end seven_seg; 

architecture arc of seven_seg is
  constant ZERO:  std_logic_vector(6 downto 0) := "1000000";
  constant ONE:   std_logic_vector(6 downto 0) := "1111001";
  constant TWO:   std_logic_vector(6 downto 0) := "0100100";
  constant THREE: std_logic_vector(6 downto 0) := "0110000";
  constant FOUR:  std_logic_vector(6 downto 0) := "0011001";
  constant FIVE:  std_logic_vector(6 downto 0) := "0010010";
  constant SIX:   std_logic_vector(6 downto 0) := "0000010"; 
  constant SEVEN: std_logic_vector(6 downto 0) := "1111000";
  constant EIGHT: std_logic_vector(6 downto 0) := "0000000";
  constant NINE:  std_logic_vector(6 downto 0) := "0010000";
  constant A:     std_logic_vector(6 downto 0) := "0001000";
  constant B:     std_logic_vector(6 downto 0) := "0000011";
  constant C:     std_logic_vector(6 downto 0) := "1000110"; 
  constant D:     std_logic_vector(6 downto 0) := "0100001";
  constant E:     std_logic_vector(6 downto 0) := "0000110";
  constant F:     std_logic_vector(6 downto 0) := "0001110";
  constant NEGATIVE: std_logic_vector(6 downto 0):= "0111111";
  constant OFF: std_logic_vector(6 downto 0):= "1111111";
  
  signal int_bcd: std_logic_vector(3 downto 0);
begin

  synchronizer:process(clk,reset)
  begin
    if(reset = '1') then
      int_bcd <= "0000"; -- generic value higher than 9 to turn off display on reset
    elsif(clk'event and clk='1') then
      int_bcd <= bcd;
    end if;
  end process;
  display_driver:process(int_bcd)
  begin
    case(int_bcd) is
        when "0000" => seven_seg_out <= ZERO;
        when "0001" => seven_seg_out <= ONE;
        when "0010" => seven_seg_out <= TWO;
        when "0011" => seven_seg_out <= THREE;
        when "0100" => seven_seg_out <= FOUR;
        when "0101" => seven_seg_out <= FIVE;
        when "0110" => seven_seg_out <= SIX;
        when "0111" => seven_seg_out <= SEVEN;
        when "1000" => seven_seg_out <= EIGHT;
        when "1001" => seven_seg_out <= NINE;
        when "1010" => seven_seg_out <= A;
        when "1011" => seven_seg_out <= B;
        when "1100" => seven_seg_out <= C;
        when "1101" => seven_seg_out <= D;
        when "1110" => seven_seg_out <= E;
        when "1111" => seven_seg_out <= F;
        when others => seven_seg_out <= OFF;
    end case;
  end process;
end arc;