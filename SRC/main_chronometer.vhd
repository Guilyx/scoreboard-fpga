library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-------------------------------------------------------------

entity main_chronometer is
	port(
		H, -- CLOCK SIGNAL

		CET, -- COUNT START SIGNAL
		RAZN, -- ASYNCHRONOUS RESET ON LOW LEVEL
		LOADN, -- LOAD THE DATA VALUE
		UP_DOWN : in std_logic; -- REVERSE COUNTING
		
		ON_OFF : in std_logic; -- START AND STOP
		MEM : in std_logic;
		
		
		
		DISP_1 : out std_logic_vector (6 downto 0);
		DISP_2 : out std_logic_vector (6 downto 0);
		DISP_3 : out std_logic_vector (6 downto 0);
		DISP_4 : out std_logic_vector (6 downto 0)
		);
end main_chronometer;

------------------------------------------------------------

architecture arch of main_chronometer is

	 SIGNAL CPT1, CPT2, CPT3, CPT4, DATA1, DATA2, DATA3, DATA4 : std_logic_vector(3 downto 0);
	 SIGNAL TICK1S, TICK10MS, TICK1US, TICK10US, TICK1MS, CARRY, CARRY2, CARRY3, CARRY4 : std_logic; 
	 SIGNAL MEM1, MEM2,MEM3,MEM4 : std_logic_vector(3 downto 0);
	 
	 COMPONENT compteur PORT ( H, CET, LOADN, UP_DOWN, RAZN: in std_logic ; 
							   DATA : in std_logic_vector (3 downto 0) ;
							   CARRY : out std_logic;
							   S : out std_logic_vector (3 downto 0) 
							 );
	 END COMPONENT;
	 
	 
	 COMPONENT afficheur_7 PORT ( H : in std_logic ; 
								  Ecompt : in std_logic_vector (3 downto 0) ;
								  S : out std_logic_vector(6 downto 0)
								) ;
	 END COMPONENT;
	 
	 COMPONENT FDIV PORT ( CLK : in std_logic;
						   RST : in std_logic; 
						   TICK1US  : out std_logic;         -- Tick every  1 us
						   TICK10US : out std_logic;         -- Tick every 10 us
						   TICK1MS  : out std_logic;         -- Tick every  1 ms
						   TICK10MS : out std_logic;         -- Tick every  10 ms
						   TICK1S   : out std_logic
						 );
	END COMPONENT;
	
	COMPONENT memoire PORT ( ON_OFF : in std_logic;
							 H : in std_logic;
							 RAZN : in std_logic;
							 MEM : in std_logic;
							 COUNT : in std_logic_vector(3 downto 0);
							 OUTPUT : out std_logic_vector (3 downto 0)
							);
	END COMPONENT;
	 
	 BEGIN
	 
		FDIV1 : FDIV PORT MAP (CLK => H, RST => not(RAZN), TICK10MS => TICK10MS, TICK1S => TICK1S, TICK1US => TICK1US, TICK10US => TICK10US, TICK1MS => TICK1MS);
		
		COUNT1 : compteur PORT MAP (H => H, RAZN => RAZN, DATA => DATA1, CET => ON_OFF and TICK10MS, LOADN => LOADN, UP_DOWN => UP_DOWN, CARRY => CARRY, S => CPT1);
		MEMOIRE1 : memoire PORT MAP (H => H, RAZN => RAZN, ON_OFF => ON_OFF, MEM => MEM, COUNT => CPT1, OUTPUT => MEM1);
		DISP1 : afficheur_7 PORT MAP (H => H, Ecompt => MEM1, S => DISP_1);
		
		COUNT2 : compteur PORT MAP (H => H, RAZN => RAZN, DATA => DATA2, CET => CARRY, LOADN => LOADN, UP_DOWN => UP_DOWN, CARRY => CARRY2, S => CPT2);
		MEMOIRE2 : memoire PORT MAP (H => H, RAZN => RAZN, ON_OFF => ON_OFF, MEM => MEM, COUNT => CPT2, OUTPUT => MEM2);
		DISP2 : afficheur_7 PORT MAP (H => H, Ecompt => MEM2, S => DISP_2);
		
		COUNT3 : compteur PORT MAP (H => H, RAZN => RAZN, DATA => DATA3, CET => CARRY2, LOADN => LOADN, UP_DOWN => UP_DOWN, CARRY => CARRY3, S => CPT3);
		MEMOIRE3 : memoire PORT MAP (H => H, RAZN => RAZN, ON_OFF => ON_OFF, MEM => MEM, COUNT => CPT3, OUTPUT => MEM3);
		DISP3 : afficheur_7 PORT MAP (H => H, Ecompt => MEM3, S => DISP_3);
		
		COUNT4 : compteur PORT MAP (H => H, RAZN => RAZN, DATA => DATA4, CET => CARRY3, LOADN => LOADN, UP_DOWN => UP_DOWN, CARRY => CARRY4, S => CPT4);
		MEMOIRE4 : memoire PORT MAP (H => H, RAZN => RAZN, ON_OFF => ON_OFF, MEM => MEM, COUNT => CPT4, OUTPUT => MEM4);
		DISP4 : afficheur_7 PORT MAP (H => H, Ecompt => MEM4, S => DISP_4);
end arch;