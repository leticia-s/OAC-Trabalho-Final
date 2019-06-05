library	ieee;
use	ieee.std_logic_1164.all;
use	ieee.numeric_std.all;
use work.types_components.all;

ENTITY multiplexador_5_bits is
	port(
		selector : in std_logic;
		opt0, opt1 : in std_logic_vector (4 downto 0);
		result : out std_logic_vector (4 downto 0)
	);
END ENTITY;

ARCHITECTURE rtl of multiplexador_5_bits is

BEGIN
	PROCESS(selector, opt0, opt1)
	BEGIN
		case selector is
		when '0' => result <= opt0;
		when others => result <= opt1;
		end case;
	END PROCESS;
END ARCHITECTURE;