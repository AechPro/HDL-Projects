---------------------------------
--       Matthew Allen        --
--         09/1/2016           --
--           Lab 1             --
--  Basic And gate component   --
---------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity alu_and is port
(
  a : in std_logic;
  b : in std_logic;
  output : out std_logic
);
end alu_and;

architecture arc of alu_and is
begin
  output <= a and b;
end arc;
