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

// Contador de 7 segundos (175 milhões de ciclos)
reg [27:0] contador_7s;
always @(posedge clk or posedge rst) begin
    if (rst)
        contador_7s <= 28'd0;
    else if (clear_Reg7s)
        contador_7s <= 28'd0;
    else if (load_Reg7s) begin
        if (contador_7s < 28'd175000000)
            contador_7s <= contador_7s + 1;
    end
end

always @(*) begin
    if (contador_7s >= 28'd175000000)
        fim_7s = 1'b1;
    else
        fim_7s = 1'b0;
end

// Contador de 5 segundos (125 milhões de ciclos)
reg [26:0] contador_5s;
always @(posedge clk or posedge rst) begin
    if (rst)
        contador_5s <= 27'd0;
    else if (clear_Reg5s)
        contador_5s <= 27'd0;
    else if (load_Reg5s) begin
        if (contador_5s < 27'd125000000)
            contador_5s <= contador_5s + 1;
    end
end

always @(*) begin
    if (contador_5s >= 27'd125000000)
        fim_5s = 1'b1;
    else
        fim_5s = 1'b0;
end

// Contador de 0,5 segundos (12,5 milhões de ciclos)
reg [23:0] contador_05s;
always @(posedge clk or posedge rst) begin
    if (rst)
        contador_05s <= 24'd0;
    else if (clear_Reg05s)
        contador_05s <= 24'd0;
    else if (load_Reg05s) begin
        if (contador_05s < 24'd12500000)
            contador_05s <= contador_05s + 1;
    end
end

always @(*) begin
    if (contador_05s >= 24'd12500000)
        fim_05s = 1'b1;
    else
        fim_05s = 1'b0;
end

endmodule
