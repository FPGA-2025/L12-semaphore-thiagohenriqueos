module Semaphore #(
    parameter CLK_FREQ = 25_000_000
) (
    input wire clk,
    input wire rst_n,  // reset assíncrono ativo baixo

    input wire pedestrian,

    output wire green,
    output wire yellow,
    output wire red
);

    // Sinais internos entre bloco de controle e bloco operacional
    wire load_Reg5s, clear_Reg5s, fim_5s;
    wire load_Reg7s, clear_Reg7s, fim_7s;
    wire load_Reg05s, clear_Reg05s, fim_05s;

    // Bloco de Controle (FSM)
    bloco_controle ctrl (
        .clk(clk),
        .rst(~rst_n),  // reset ativo alto internamente
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

    // Bloco Operacional (Contadores)
    bloco_operacional op (
        .clk(clk),
        .rst(~rst_n),  // reset ativo alto internamente
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
