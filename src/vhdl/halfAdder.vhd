library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity halfAdder is
    port (
        a    : in  std_logic;
        b    : in  std_logic;
        sum  : out std_logic;
        cout : out std_logic
    );
end entity halfAdder;

architecture rtl of halfAdder is
begin
    sum  <= a xor b;
    cout <= a and b;
end architecture rtl;
