library	ieee;
use	ieee.std_logic_1164.all;
use	ieee.numeric_std.all;

entity c_ula is
	port(
	  func   : in std_logic_vector(5 downto 0);
	  opUla  : in std_logic_vector(1 downto 0);
	  ctrula : out std_logic_vector(3 downto 0)
	  );
end c_ula;

architecture rtl of c_ula is
signal c4 : std_logic_vector(3 downto 0);
begin
ctrula <= c4;

process (func, opUla, c4)
begin
  -- if opUla = '00' then ctrula <= '0010';
	--end if;
  case opUla is
	when "00" =>
   c4 <= "0010";
	when "01" =>
	c4 <= "0110";
	when "10" =>
	if(func = "000000")
		then c4 <= "0010";
	elsif(func = "000010") 
		then c4 <= "0110";
	elsif(func = "000100") 
		then c4 <= "0000";
	elsif(func = "000101")
		then c4 <= "0001";
	elsif(func = "001010")
		then c4 <= "0111";
	end if;
	when others =>
	c4 <= (others	=>	'X');	
	
	end case;
end process;
end rtl;