library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity serialtoparallel is
    generic (
        N: natural := 8
    );
    port (
        serial_in: in std_logic;
        clk: in std_logic;
        data_out: out std_logic_vector(N-1 downto 0)
    );
end entity;

architecture structural of serialtoparallel is
    signal din, dout: std_logic_vector(N-1 downto 0);
begin
    reg : entity work.reg_n(behavioral)
        generic map(N)
        port map(
            data_in => din,
            clk => clk,
            data_out => dout
        );
    
    gen : for i in 1 to N-1
        generate
        begin
            din(i) <= dout(i-1);
        end generate;
        
    din(0) <= serial_in;
    data_out <= dout;
end architecture;
