----------------------------------------
--          Matthew Allen             --
--           10/20/2016               --
--              Lab 6                 --
--             ALU unit               --
--SATURATE OUTPUT IF MSB IS EQUAL TO 1 THEN RETURN MAX VALUE FOR NUM BITS
----------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.alu_components.all;

entity alu is 
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
end alu;

architecture arc of alu is
CONSTANT ADDOP : std_logic_vector(2 downto 0) :=      "000";
CONSTANT SUBTRACTOP : std_logic_vector(2 downto 0) := "001";
CONSTANT MULTIPLYOP : std_logic_vector(2 downto 0) := "010";
CONSTANT DIVIDEOP : std_logic_vector(2 downto 0) :=   "011";
CONSTANT ANDOP : std_logic_vector(2 downto 0) :=      "100";
CONSTANT OROP : std_logic_vector(2 downto 0) :=       "101";
CONSTANT NOTOP : std_logic_vector(2 downto 0) :=      "110";
CONSTANT XOROP : std_logic_vector(2 downto 0) :=      "111";


signal mult_result : std_logic_vector((bits*2)-1 downto 0) := (others =>'0');
signal div_result : std_logic_vector((bits*2)-1 downto 0) := (others => '0');
signal and_result : std_logic_vector(bits-1 downto 0) := (others => '0');
signal or_result : std_logic_vector(bits-1 downto 0) := (others => '0');
signal not_result : std_logic_vector(bits-1 downto 0) := (others => '0');
signal xor_result : std_logic_vector(bits-1 downto 0) := (others => '0');
signal adder_result : std_logic_vector(bits-1 downto 0);
signal adder_cin : std_logic := '0';
signal adder_cout : std_logic := '0';

signal subtractor_result : std_logic_vector(bits-1 downto 0);
signal subtractor_cin : std_logic := '0';
signal subtractor_cout : std_logic := '0';

signal internal_result : std_logic_vector((bits*2)-1 downto 0) := (others => '0');

signal padder : std_logic_vector(bits-1 downto 0) := (others => '0');
begin
  process(clk, reset)
  begin
    if(reset = '1') then
      internal_result <= (others => '0');
    elsif(clk'event and clk = '1')
    then
      case(op) is
        when ADDOP => internal_result <= padder & adder_result;
        when SUBTRACTOP => internal_result <= padder & subtractor_result;
        when DIVIDEOP => internal_result <= div_result;
        when MULTIPLYOP => internal_result <= mult_result;
        when ANDOP => internal_result <= padder & and_result;
        when OROP => internal_result <= padder & or_result;
        when NOTOP => internal_result <= padder & not_result;
        when XOROP => internal_result <= padder & xor_result;
        when others => internal_result <= padder & adder_result;
      end case;
    end if;
    if(unsigned(internal_result) > unsigned(saturation_value)) 
    then
      internal_result <= saturation_value;
    end if;
  end process;
  result <= internal_result;
  adder: generic_adder_beh
  generic map
  (
    bits => bits
  )
  port map
  (
    a => a,
    b => b,
    cin => adder_cin,
    cout => adder_cout,
    sum => adder_result
  );
    
  subtractor: generic_subtractor_beh
  generic map
  (
    bits => bits
  )
  port map
  (
    a => a,
    b => b,
    cin => subtractor_cin,
    cout => subtractor_cout,
    result => subtractor_result
  );
  
  multiplier: generic_multiplier_beh
  generic map
  (
		bits => bits
	)
  port map
  (
    a => a,
    b => b,
    result => mult_result
  );
  
  divider: generic_divider_beh
  generic map
  (
		bits => bits
	)
  port map
  (
    a => a,
    b => b,
    result => div_result
  );
  
  and_unit: generic_and_beh
  generic map
  (
    bits => bits
  )
  port map
  (
    a => a,
    b => b,
    result => and_result
  );
  
  or_unit: generic_or_beh
  generic map
  (
    bits => bits
  )
  port map
  (
    a => a,
    b => b,
    result => or_result
  );
  
  xor_unit: generic_xor_beh
  generic map
  (
    bits => bits
  )
  port map
  (
    a => a,
    b => b,
    result => xor_result
  );
  
  not_unit: generic_not_beh
  generic map
  (
    bits => bits
  )
  port map
  (
    a => a,
    b => b,
    result => not_result
  );
end arc;
