-------------------------------------------------------------------------------
-- Matt Allen
-- generic divider [behavioral]
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity generic_divider_beh is
  generic (
    bits    : integer := 4
  );
  port (
    a       : in  std_logic_vector(bits-1 downto 0);
    b       : in  std_logic_vector(bits-1 downto 0);
    result     : out std_logic_vector((bits*2)-1 downto 0)
  );
end entity generic_divider_beh;

architecture beh of generic_divider_beh is
signal a_pad : std_logic_vector(bits-1 downto 0) := (others => '0');
signal b_pad : std_logic_vector(bits-1 downto 0) := (others => '0');
signal zero_div : std_logic_vector((bits*2)-1 downto 0) := (others => '0');
begin
  process(a, b)
  begin
    if(unsigned(b) /= 0)
    then
      result <= std_logic_vector(unsigned(a_pad & a)/unsigned(b_pad & b));
    else
      result <= zero_div;
    end if;
  end process;
end beh;