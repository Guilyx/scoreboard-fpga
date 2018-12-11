-----------------------------------------------------------------
library IEEE;
     use IEEE.std_logic_1164.all;
     use IEEE.numeric_std.all;

---------------------------------
entity FDIV is
---------------------------------
  port ( CLK      : in  std_logic;         -- System Clock
         RST      : in  std_logic;         -- Asynchronous Reset Active High
         TICK1US  : out std_logic;         -- Tick every  1 us
         TICK10US : out std_logic;         -- Tick every 10 us
         TICK1MS  : out std_logic;         -- Tick every  1 ms
		 TICK10MS : out std_logic;         -- Tick every  10 ms
         TICK1S   : out std_logic          -- Tick every  1 sec
      );
end entity FDIV;

--------------------------------------
architecture RTL of FDIV is
--------------------------------------

  constant FCLK : positive := 50e6;
  constant TICK1US_DIV : positive := FCLK / 1000000;
  signal cnt1US    : integer range 0 to TICK1US_DIV;
  signal iTICK1US  : std_logic;
  signal cnt10US   : integer range 0 to 9;
  signal iTICK10US : std_logic;
  signal cnt1MS    : integer range 0 to 99;
  signal iTICK1MS  : std_logic;
  signal cnt10MS   : integer range 0 to 9;
  signal iTICK10MS : std_logic;
  signal cnt1S     : integer range 0 to 999;
  signal iTICK1S   : std_logic;

-----------
begin
-----------

  TICK1US  <= iTICK1US;
  TICK10US <= iTICK10US;
  TICK1MS  <= iTICK1MS;
  TICK10MS  <= iTICK10MS;
  TICK1S   <= iTICK1S;

  -- Synchronous Clock Divider
  DIV_proc : process(RST, CLK)
  begin
    if RST = '1' then
      cnt1US    <=  0 ;
      iTICK1US  <= '0';
      cnt10US   <=  0 ;
      iTICK10US <= '0';
      cnt1MS    <=  0 ;
      iTICK1MS  <= '0';
	  cnt10MS    <=  0 ;
      iTICK10MS  <= '0';
      cnt1S     <=  0 ;
      iTICK1S   <= '0';
    elsif rising_edge(CLK) then

      iTICK1US  <= '0';
      iTICK10US <= '0';
      iTICK1MS  <= '0';
	  iTICK10MS  <= '0';
      iTICK1S   <= '0';

      -- Tick1us Generation
      if cnt1US = TICK1US_DIV-1 then
        cnt1US   <=  0 ;
        iTICK1US <= '1';
      else
        cnt1US   <= cnt1US + 1;
      end if;

      -- Tick10us Generation
      if iTICK1US = '1' then
        if cnt10US = 9 then
          cnt10US   <= 0;
          iTICK10US <= '1';
        else
          cnt10US  <= cnt10US + 1;
        end if;
      end if;

      -- Tick1ms Generation
      if iTICK10US = '1' then
        if cnt1MS = 99 then
          cnt1MS   <= 0;
          iTICK1MS <= '1';
        else
          cnt1MS  <= cnt1MS + 1;
        end if;
      end if;
	  
      -- Tick10ms Generation
      if iTICK1MS = '1' then
        if cnt10MS = 9 then
          cnt10MS   <= 0;
          iTICK10MS <= '1';
        else
          cnt10MS  <= cnt10MS + 1;
        end if;
      end if;
	  
      -- Tick1sec Generation
      if iTICK1MS = '1' then
        if cnt1S = 999 then
          cnt1S   <= 0;
          iTICK1S <= '1';
        else
          cnt1S <= cnt1S + 1;
        end if;
      end if;

    end if;
  end process DIV_proc;


---------------------------
end architecture RTL;
---------------------------

