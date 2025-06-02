module Semaphore #(
    parameter CLK_FREQ = 25_000_000  // valor simbólico (não usado no modelo)
) (
    input wire clk,
    input wire rst_n,  
    input wire pedestrian,
    output wire green,
    output wire yellow,
    output wire red
);

    wire load_Reg5s, clear_Reg5s, fim_5s;
    wire load_Reg7s, clear_Reg7s, fim_7s;
    wire load_Reg05s, clear_Reg05s, fim_05s;

    bloco_controle ctrl (
        .clk(clk),
        .rst(~rst_n),
        .pedestrian(pedestrian),
        .fim_5s(fim_5s),
        .fim_7s(fim_7s),
        .fim_05s(fim_05s),
        .green(green),
        .yellow(yellow),
        .red(red),
        .load_Reg5s(load_Reg5s),
        .clear_Reg5s(clear_Reg5s),
        .load_Reg7s(load_Reg7s),
        .clear_Reg7s(clear_Reg7s),
        .load_Reg05s(load_Reg05s),
        .clear_Reg05s(clear_Reg05s)
    );

    bloco_operacional op (
        .clk(clk),
        .rst(~rst_n),
        .load_Reg5s(load_Reg5s),
        .clear_Reg5s(clear_Reg5s),
        .fim_5s(fim_5s),
        .load_Reg7s(load_Reg7s),
        .clear_Reg7s(clear_Reg7s),
        .fim_7s(fim_7s),
        .load_Reg05s(load_Reg05s),
        .clear_Reg05s(clear_Reg05s),
        .fim_05s(fim_05s)
    );

endmodule