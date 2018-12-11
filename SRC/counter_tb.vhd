library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--------------------------------------------------------

entity counter_tb is
end;

architecture bench of counter_tb is
signal DATA, S : std_logic_vector(3 downto 0);
signal H,CET, RAZN, LOADN, UP_DOWN, CARRY : std_logic;
signal StopClock : BOOLEAN;

--------------------------------------------------------

begin
	M : entity work.compteur(arch) port map (
	H => H,
	CET => CET,
	RAZN => RAZN,
	LOADN => LOADN,
	DATA => DATA,
	UP_DOWN => UP_DOWN,
	CARRY => CARRY,
	S => S);

process
  begin
    while not StopClock loop
      H <= '0';
      wait for 25 ns;
      H <= '1';
      wait for 25 ns;
    end loop;
    wait;
  end process;

process
begin
	UP_DOWN <= '0';
	DATA <= "1100";
	RAZN <= '0';
	CET <= '0';
	LOADN <= '1';
	wait for 10 ns;
	RAZN <= '1';
	wait for 50 ns;
	CET <= '1';
	wait for 990 ns;
	UP_DOWN <= '1';
	wait for 500 ns;
	CET <= '0';
	wait for 50 ns;
	LOADN <= '0';
	wait for 150 ns;
	RAZN <= '0';
	wait for 80 ns;
	StopClock <= TRUE;
    wait;
  end process;
 
end bench;
