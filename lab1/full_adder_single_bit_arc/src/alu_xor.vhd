-------------------------------------
--         Matthew Allen          --
--           09/1/2016             --
--             Lab 1               --
--  Basic exclusive or component   --
-------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity alu_xor is port
(
  a : in std_logic;
  b : in std_logic;
  output : out std_logic
);
end alu_xor;

architecture arc of alu_xor is
begin
  output <= a xor b;
end arc;