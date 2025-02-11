--+----------------------------------------------------------------------------
--| Testbench for 4-bit Ripple-Carry Adder
--+----------------------------------------------------------------------------
library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity ripple_adder_tb is
end ripple_adder_tb;

architecture test_bench of ripple_adder_tb is 
	
  -- declare the component of your top-level design unit under test (UUT)
  component ripple_adder is
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           Cin : in STD_LOGIC;
           S : out STD_LOGIC_VECTOR (3 downto 0);
           Cout : out STD_LOGIC
       );
   end component ripple_adder;
  
 
	-- declare signals needed to stimulate the UUT inputs
	signal w_addends     : std_logic_vector(7 downto 0) := x"00"; -- the numbers being added
	signal w_sum         : std_logic_vector(3 downto 0) := x"0";
	signal w_Cin, w_Cout : std_logic;

begin
	-- PORT MAPS ----------------------------------------
	ripple_adder_uut : ripple_adder port map (
	   A    => w_addends(3 downto 0),
	   B    => w_addends(7 downto 4),
	   Cin  => w_Cin,
	   S    => w_sum,
	   Cout => w_Cout
	);
	
	-- PROCESSES ----------------------------------------	
	-- Test Plan Process
	-- Implement the test plan here.  Body of process is continuously from time = 0  
	test_process : process 
	begin
	
	   -- Test all zeros input
	   w_addends <= x"00"; w_Cin <= '0'; wait for 10 ns;
	       assert (w_sum = x"0" and w_Cout = '0') report "bad with zeros" severity failure;
       -- Test all ones input
       w_addends <= x"FF"; w_Cin <= '1'; wait for 10 ns;
	       assert (w_sum = x"F" and w_Cout = '1') report "bad with ones" severity failure;
       -- TODO, a few other test cases
       
       
       -- Test 0 + 0 + Cin = 1
       w_addends <= "00000000"; w_Cin <= '1'; wait for 10 ns;
           assert (w_sum = "0001" and w_Cout = '0') report "bad with 0 + 0 + Cin = 1" severity failure;

       -- Test 7 + 1 = 8 with no carry out
       w_addends <= "01110001"; w_Cin <= '0'; wait for 10 ns;
           assert (w_sum = "1000" and w_Cout = '0') report "bad with 7 + 1" severity failure;

       -- Test 8 + 8 = 16 (except it'll be 0 cuz carry out) with carry out
       w_addends <= "10001000"; w_Cin <= '0'; wait for 10 ns;
           assert (w_sum = "0000" and w_Cout = '1') report "bad with 8 + 8" severity failure;

       -- Test 5 + 3 = 8 with no carry out
       w_addends <= "01010011"; w_Cin <= '0'; wait for 10 ns;
           assert (w_sum = "1000" and w_Cout = '0') report "bad with 5 + 3" severity failure;

       -- Test 9 + 5 = 14 with no carry out
       w_addends <= "10010101"; w_Cin <= '0'; wait for 10 ns;
           assert (w_sum = "1110" and w_Cout = '0') report "bad with 9 + 5" severity failure;



	
		wait; -- wait forever
	end process;	
	-----------------------------------------------------	
	
end test_bench;
