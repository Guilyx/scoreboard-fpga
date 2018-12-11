----------------------------------
library ieee;
use ieee.std_logic_1164.all;
----------------------------------
entity FDIV_tb is
end;
----------------------------------
architecture bench of FDIV_tb is
signal CLK     	: std_logic;
signal RST     	: std_logic;
signal TICK1US 	: std_logic;
signal TICK10US	: std_logic;
signal TICK1MS 	: std_logic;
signal TICK10MS 	: std_logic;
signal TICK1S  	: std_logic;
signal StopClock : BOOLEAN;
----------------------------------
begin 
	M : entity work.FDIV(RTL) 
	port map (
	CLK     =>	CLK     ,
	RST     =>	RST     ,
	TICK1US =>	TICK1US ,
	TICK10US=>	TICK10US,
	TICK1MS =>	TICK1MS ,
	TICK10MS =>	TICK10MS ,
	TICK1S =>	TICK1S
	);
	
 process
  begin
    while not StopClock loop
      CLK <= '0';
      wait for 5 ns;
      CLK <= '1';
      wait for 5 ns;
    end loop;
    wait;
  end process;
  
 process
begin
	RST <='1';
	wait for 8 NS;
	RST <='0';
	wait for 102 mS;
    StopClock <= TRUE;
    wait;
  end process;
end bench;