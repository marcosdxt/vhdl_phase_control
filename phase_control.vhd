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
--       File               :  phase_controle.vhd
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
ENTITY phase_controls IS
	PORT(
        	clkin       : IN STD_LOGIC;
                zero_cross  : IN STD_LOGIC;
                preset      : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		load_preset : IN STD_LOGIC;
                enable      : IN STD_LOGIC;
                reset       : IN STD_LOGIC;
                gate_signal : OUT STD_LOGIC
	);
END phase_controls;

-----------------------------------------------------------------------------------------
--  Architecture                                                                       --
-----------------------------------------------------------------------------------------
ARCHITECTURE rtl OF phase_controls IS
 --SIGNALS
 SIGNAL counter      : STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0');
 SIGNAL shadow_preset: STD_LOGIC_VECTOR(15 DOWNTO 0);
 -- COMPONENTS
BEGIN

	PROCESS(clkin,zero_cross,preset)
	BEGIN

		  IF RISING_EDGE(clkin) THEN

                    IF reset = '0' THEN
                      gate_signal <= '0';
                      counter <= (OTHERS=> '0');
                      shadow_preset <= (OTHERS=> '1');

                    ELSIF RISING_EDGE(zero_cross) THEN -- Quando ocorre a borda de subida do sinal de zerocross
                       counter <= (OTHERS => '0');      -- reinicia o contador de disparo, desliga o gate e carrega o preset
                       gate_signal <= '0';
                       shadow_preset <= preset;

                    ELSE
		       counter <= counter + 1;

                       IF counter > shadow_preset THEN
                         gate_signal <= '1' AND enable;

                       END IF;

                    END IF;

		  END IF;

	END PROCESS;

END rtl;

-----------------------------------------------------------------------------------------
--  End of file                                                                        --
-----------------------------------------------------------------------------------------