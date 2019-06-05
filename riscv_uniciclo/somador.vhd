library	ieee;
use	ieee.std_logic_1164.all;
use	ieee.numeric_std.all;
use work.types_components.all;

ENTITY somador is
	generic	(	WSIZE	:	natural	:=	32);
	port(
		A, B : in std_logic_vector ((WSIZE - 1) downto 0);

		result : out std_logic_vector ((WSIZE - 1) downto 0)
	);
END ENTITY;

ARCHITECTURE rtl of somador is

BEGIN
	PROCESS(A, B)
	BEGIN
		result <= std_logic_vector(signed(A) + signed(B));
	END PROCESS;

END ARCHITECTURE;