----------------------------------------------------------------------------------
-- Implements a 4-bit Ripple-Carry adder from instantiated Full Adders
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ripple_adder is
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           Cin : in STD_LOGIC;
           S : out STD_LOGIC_VECTOR (3 downto 0);
           Cout : out STD_LOGIC);
end ripple_adder;

architecture Behavioral of ripple_adder is

    -- Declare components here
    
    component full_adder
        Port ( A : in  STD_LOGIC;
               B : in  STD_LOGIC;
               Cin : in  STD_LOGIC;
               S : out  STD_LOGIC;
               Cout : out  STD_LOGIC);
    end component;
    
    
    -- Declare signals here 
    signal w_carry, w_sum, w_something : std_logic_vector(3 downto 0);

    
begin

    full_adder_0: full_adder
    port map(
        A     => A(0),
        B     => B(0),
        Cin   => Cin,   -- Carry input from external
        S     => w_sum(0),
        Cout  => w_carry(0)
    );

    full_adder_1: full_adder
    port map(
        A     => A(1),
        B     => B(1),
        Cin   => w_carry(0),
        S     => w_sum(1),
        Cout  => w_carry(1)
    );

    full_adder_2: full_adder
    port map(
        A     => A(2),
        B     => B(2),
        Cin   => w_carry(1),
        S     => w_sum(2),
        Cout  => w_carry(2)
    );

    full_adder_3: full_adder
    port map(
        A     => A(3),
        B     => B(3),
        Cin   => w_carry(2),
        S     => w_sum(3),
        Cout  => w_carry(3)  -- Final carry out
    );

Cout <= w_carry(3);
S <= w_sum;

end Behavioral;
