-----------------------------------------------------------------------------------------
--       Aquino Technical Stuff LLC
--       
--       Orlando/FL - USA
--       www.marcosaquino.com
-----------------------------------------------------------------------------------------
--
--       This source code was developed by Aquino Technical Stuff  and cannot be copied, 
--       in part or in whole, or used, except when legally licensed by Aquino or its 
--       distributors.
-----------------------------------------------------------------------------------------
--
--       File               :  phase_control_tb.vhd
--       Description        :  
-- 
--       Author             :  Marcos Aquino
--       Date start         :  8/18/2018
--
--       Version            :  1.0.0.0
--
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
--  Librarys                                                                           --
-----------------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.all;

-----------------------------------------------------------------------------------------
--  Entitys                                                                            --
-----------------------------------------------------------------------------------------
ENTITY phase_control_tb IS

END phase_control_tb;

-----------------------------------------------------------------------------------------
--  Architecture                                                                       --
-----------------------------------------------------------------------------------------
ARCHITECTURE rtl OF phase_control_tb IS
 --SIGNALS
 SIGNAL clk,zero,ena,rst,load: STD_LOGIC;
 SIGNAL preset_tb : STD_LOGIC_VECTOR(15 DOWNTO 0) := "0000000000001111";   
 -- COMPONENTS
	COMPONENT phase_controls IS
		PORT(
	        	clkin       : IN STD_LOGIC;
	                zero_cross  : IN STD_LOGIC;
	                preset      : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
			load_preset : IN STD_LOGIC;
	                enable      : IN STD_LOGIC;
	                reset       : IN STD_LOGIC;
	                gate_signal : OUT STD_LOGIC
		);
	END COMPONENT;
BEGIN

	U1:phase_controls PORT MAP(
	  clkin => clk,
	  zero_cross  => zero,
	  preset => preset_tb,
	  load_preset => load,
	  enable => ena,
	  reset => rst    
	);

	PROCESS
 	BEGIN
		clk <= '1'; 
                WAIT FOR 1 ns;
                clk <= '0';
                WAIT FOR 1 ns;		
	END PROCESS;

        PROCESS
        BEGIN
     
        	zero<= '1';
                WAIT FOR 50 NS;
                zero<= '0';
                WAIT FOR 50 NS;

        END PROCESS;


        PROCESS
        BEGIN

		rst <= '0';
                WAIT FOR 20 NS;
                rst <= '1';
                WAIT FOR 500 NS;

        END PROCESS;

	PROCESS 
	BEGIN
	
		WAIT FOR 300 NS;
                preset_tb <= "0000000000000111";
		
	END PROCESS;

        ena <= '1';

END rtl;

-----------------------------------------------------------------------------------------
--  End of file                                                                        --
-----------------------------------------------------------------------------------------
