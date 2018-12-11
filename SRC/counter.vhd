library ieee;
use ieee.std_logic_1164.all;
use IEEE.Numeric_std.all;

--------------------------------------------------------------------

entity counter is
	port (
		H, -- CLOCK SIGNAL
		CET,-- COUNTING ENTRY SIGNAL
		RAZN, -- ASYNCHRONOUS RESET ON LOW LEVEL
		LOADN, -- LOADING THE DATA SIGNAL (SAVED VALUE)
		UP_DOWN : in std_logic; -- REVERSE THE COUNTING ON HIGH LEVEL

		DATA : in std_logic_vector (3 downto 0);
		CARRY : out std_logic;
		S : out std_logic_vector (3 downto 0)
		);
end counter;

---------------------------------------------------------------------

architecture arch of counter is
signal CPT : unsigned (3 downto 0);
begin
	process (H, RAZN)
	begin
		if RAZN='0' then 
			CPT <= "0000";
		elsif (rising_edge(H)) then
			if CET='1' then 
				if LOADN = '0' then
					if (unsigned(DATA) < 10) then 
						CPT <= unsigned(DATA);
					else 
						CPT <= "1001";
					end if;
				else
					if UP_DOWN = '0' then
						CPT <= CPT + 1;
						if (CPT="1001") then
							CPT <= "0000";
							CARRY <= '1';
						else
							CARRY <= '0';
						end if;
					else
						CPT <= CPT-1;
						if (CPT="0000") then
							CPT <= "1001";
							CARRY <= '1';
						else 
							CARRY <= '0';
						end if;
					end if;
				end if;
			else 
				CARRY <= '0';
			end if;	 
		end if;
	end process;
S <= std_logic_vector(CPT);
end arch;