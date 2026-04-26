library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fullAdder is
    port (
        a    : in  std_logic;
        b    : in  std_logic;
        cin  : in  std_logic;
        sum  : out std_logic;
        cout : out std_logic
    );
end entity fullAdder;

architecture structural of fullAdder is
    signal s1 : std_logic;
    signal c1 : std_logic;
    signal c2 : std_logic;
begin
    ha1: entity work.halfAdder
        port map (
            a    => a,
            b    => b,
            sum  => s1,
            cout => c1
        );

    ha2: entity work.halfAdder
        port map (
            a    => s1,
            b    => cin,
            sum  => sum,
            cout => c2
        );

    cout <= c1 or c2;
end architecture structural;
