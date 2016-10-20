-------------------------------------
--          Matthew Allen          --
--           09/1/2016             --
--              Lab 1              --
--  Single Bit Adder Architectural --
-------------------------------------
library ieee;
use ieee.std_logic_1164.all;      

entity full_adder_single_bit_arc is port 
  (
    a       : in std_logic;
    b       : in std_logic;
    cin     : in std_logic;
    sum     : out std_logic;
    cout    : out std_logic
  );
end full_adder_single_bit_arc;

architecture arc of full_adder_single_bit_arc is
  signal connectors : std_logic_vector(2 downto 0); -- 3 wires to connect the three gate outputs to my internal outputs
  component alu_and is port
  (
    a : in std_logic;
    b : in std_logic;
    output : out std_logic
  );
  end component;
  
  component alu_xor is port
  (
    a : in std_logic;
    b : in std_logic;
    output : out std_logic
  );
  end component;
begin 
  gate0: alu_xor port map
  (
    a => a,
    b => b,
    output => connectors(0)
  );
  
  gate1: alu_xor port map
  (
    a => connectors(0),
    b => cin,
    output => connectors(1)
  );
  
  gate2: alu_and port map
  (
    a => cin,
    b => connectors(0),
    output => connectors(2)
  );
  
  sum  <= connectors(1);
  cout <= connectors(2);
end arc; 