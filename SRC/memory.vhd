library ieee;
use ieee.std_logic_1164.all;
use IEEE.Numeric_std.all;

-----------------------------------------------------------------

entity memory is
	port (
		ON_OFF, -- Signal ON OFF
		H, -- CLOCK SIGNAL
		MEM,-- STOCK IN MEMORY
		RAZN, -- ASYNCHRONOUS RESET ON LOW LEVEL
		LOADN, -- LOADING THE DATA (SAVED VALUE) 
		UP_DOWN : in std_logic; -- REVERSE THE COUNTING

		COUNT : in std_logic_vector (3 downto 0);
		
		OUTPUT: out std_logic_vector (3 downto 0)
		);
end memory;

-------------------------------------------------------------------

--Issue when a button is pressed continuously

architecture arch of memory is
signal K, I : unsigned (2 downto 0);
signal DATA1, DATA2, DATA3, DATA4, DATA5, DATA6, DATA7, DATA8: std_logic_vector (3 downto 0);
begin
	process (H, RAZN, MEM)
	begin
		if RAZN = '0' then
			DATA1 <= "0000";
			DATA2 <= "0000";
			DATA3 <= "0000";
			DATA4 <= "0000";
			DATA5 <= "0000";
			DATA6 <= "0000";
			DATA7 <= "0000";
			DATA8 <= "0000";
			OUTPUT <= "0000";
		elsif (rising_edge(MEM)) then
			if (MEM = '0' and ON_OFF = '1') then
				K <= K+1;
				CASE std_logic_vector(K) is
					WHEN "000" => DATA1 <= COUNT;
					WHEN "001" => DATA2 <= COUNT;
					WHEN "010" => DATA3 <= COUNT;
					WHEN "011" => DATA4 <= COUNT;
					WHEN "100" => DATA5 <= COUNT;
					WHEN "101" => DATA6 <= COUNT;
					WHEN "110" => DATA7 <= COUNT;
					WHEN "111" => DATA8 <= COUNT;
				END CASE;
				
			elsif (MEM = '0' and ON_OFF = '0') then
				I <= I + 1;
				CASE std_logic_vector(I) is
					WHEN "000" => OUTPUT <= DATA1;
					WHEN "001" => OUTPUT <= DATA2;
					WHEN "010" => OUTPUT <= DATA3;
					WHEN "011" => OUTPUT <= DATA4;
					WHEN "100" => OUTPUT <= DATA5;
					WHEN "101" => OUTPUT <= DATA6;
					WHEN "110" => OUTPUT <= DATA7;
					WHEN "111" => OUTPUT <= DATA8;
				END CASE;
			end if;
		end if;
		if (ON_OFF = '1') then
			OUTPUT <= COUNT;
		end if;
	end process;
	
	end arch;
			
			