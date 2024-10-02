library ieee;
use ieee.std_logic_1164.all;

entity paralleltoserial is
    generic( 
        N: natural := 8 
    );
    port(
        data_in: in std_logic_vector(N-1 downto 0);
        serialize_load: in std_logic; -- 1 = serialize, 0 = load
        clk: in std_logic;
        serial_out: out std_logic
    );
end entity;

architecture structural of paralleltoserial is
    signal din, dout : std_logic_vector(N-1 downto 0);
begin
    reg: entity work.reg_n(behavioral)
    generic map(N)
    port map(
        data_in => din,
        clk => clk,
        data_out => dout
    );
        
    din(0) <= (data_in(0) and (not serialize_load)); 
        
    gen: for i in 1 to N-1 generate
    begin
        din(i) <= (data_in(i) and (not serialize_load)) or (serialize_load and dout(i-1));
    end generate;

    serial_out <= dout(N-1);
    
end architecture;
