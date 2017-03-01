
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity generic_or_beh is
generic 
(
  bits    : integer := 4
);
port 
(
  a       : in  std_logic_vector(bits-1 downto 0);
  b       : in  std_logic_vector(bits-1 downto 0);
  result  : out std_logic_vector(bits-1 downto 0)
);
end entity generic_or_beh;

architecture beh of generic_or_beh is
begin
  result <= a or b;
end beh;