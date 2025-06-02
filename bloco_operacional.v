module bloco_operacional (
    input wire clk,
    input wire rst,
    input wire load_Reg7s,
    input wire clear_Reg7s,
    output reg fim_7s,
    input wire load_Reg5s,
    input wire clear_Reg5s,
    output reg fim_5s,
    input wire load_Reg05s,
    input wire clear_Reg05s,
    output reg fim_05s
);

    // Ajustes de contagem: 0.25s por ciclo
    parameter CONTAGEM_5S  = 19;
    parameter CONTAGEM_7S  = 27;
    parameter CONTAGEM_05S = 1;

    reg [7:0] contador_7s;
    reg [7:0] contador_5s;
    reg [7:0] contador_05s;

    // Contador 7s
    always @(posedge clk or posedge rst) begin
        if (rst)
            contador_7s <= 0;
        else if (clear_Reg7s)
            contador_7s <= 0;
        else if (load_Reg7s) begin
            if (contador_7s < CONTAGEM_7S)
                contador_7s <= contador_7s + 1;
        end
    end

    always @(*) begin
        fim_7s = (contador_7s >= CONTAGEM_7S);
    end

    // Contador 5s
    always @(posedge clk or posedge rst) begin
        if (rst)
            contador_5s <= 0;
        else if (clear_Reg5s)
            contador_5s <= 0;
        else if (load_Reg5s) begin
            if (contador_5s < CONTAGEM_5S)
                contador_5s <= contador_5s + 1;
        end
    end

    always @(*) begin
        fim_5s = (contador_5s >= CONTAGEM_5S);
    end

    // Contador 0.5s
    always @(posedge clk or posedge rst) begin
        if (rst)
            contador_05s <= 0;
        else if (clear_Reg05s)
            contador_05s <= 0;
        else if (load_Reg05s) begin
            if (contador_05s < CONTAGEM_05S)
                contador_05s <= contador_05s + 1;
        end
    end

    always @(*) begin
        fim_05s = (contador_05s >= CONTAGEM_05S);
    end

endmodule
