-------------------------------------------------------------------------------
-- Matthew Allen
-- ALU components package
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package alu_components is

  component generic_multiplier_beh is
  generic 
  (
    bits    : integer := 8
  );
  port 
  (
    a       : in  std_logic_vector(bits-1 downto 0);
    b       : in  std_logic_vector(bits-1 downto 0);
    result  : out std_logic_vector((bits*2)-1 downto 0)
  );
  end component;

  component generic_divider_beh is
  generic 
  (
    bits    : integer := 8
  );
  port 
  (
    a       : in  std_logic_vector(bits-1 downto 0);
    b       : in  std_logic_vector(bits-1 downto 0);
    result  : out std_logic_vector((bits*2)-1 downto 0)
  );
  end component;

  component generic_subtractor_beh is
  generic 
  (
    bits    : integer := 8
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
    bits    : integer := 8
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
  
  component generic_and_beh is
  generic 
  (
    bits    : integer := 8
  );
  port 
  (
    a       : in  std_logic_vector(bits-1 downto 0);
    b       : in  std_logic_vector(bits-1 downto 0);
    result  : out std_logic_vector(bits-1 downto 0)
  );
  end component;
  
  component generic_or_beh is
  generic 
  (
    bits    : integer := 8
  );
  port 
  (
    a       : in  std_logic_vector(bits-1 downto 0);
    b       : in  std_logic_vector(bits-1 downto 0);
    result  : out std_logic_vector(bits-1 downto 0)
  );
  end component;
  
  component generic_not_beh is
  generic 
  (
    bits    : integer := 8
  );
  port 
  (
    a       : in  std_logic_vector(bits-1 downto 0);
    b       : in  std_logic_vector(bits-1 downto 0);
    result  : out std_logic_vector(bits-1 downto 0)
  );
  end component;
  
  component generic_xor_beh is
  generic 
  (
    bits    : integer := 8
  );
  port 
  (
    a       : in  std_logic_vector(bits-1 downto 0);
    b       : in  std_logic_vector(bits-1 downto 0);
    result  : out std_logic_vector(bits-1 downto 0)
  );
  end component;
  
end alu_components;