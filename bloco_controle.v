module bloco_controle (
    input wire clk,
    input wire rst,
    input wire pedestrian,
    input wire fim_5s,
    input wire fim_7s,
    input wire fim_05s,
    output reg green,
    output reg yellow,
    output reg red,
    output reg load_Reg5s,
    output reg clear_Reg5s,
    output reg load_Reg7s,
    output reg clear_Reg7s,
    output reg load_Reg05s,
    output reg clear_Reg05s
);

    parameter EST_RED    = 2'b00;
    parameter EST_GREEN  = 2'b01;
    parameter EST_YELLOW = 2'b10;

    reg [1:0] estado_atual, proximo_estado;

    always @(posedge clk or posedge rst) begin
        if (rst)
            estado_atual <= EST_RED;
        else
            estado_atual <= proximo_estado;
    end

    always @(*) begin
        case (estado_atual)
            EST_RED:
                proximo_estado = fim_5s ? EST_GREEN : EST_RED;

            EST_GREEN:
                proximo_estado = (fim_7s || pedestrian) ? EST_YELLOW : EST_GREEN;

            EST_YELLOW:
                proximo_estado = fim_05s ? EST_RED : EST_YELLOW;

            default:
                proximo_estado = EST_RED;
        endcase
    end

    always @(*) begin
        green  = 0;
        yellow = 0;
        red    = 0;
        load_Reg5s  = 0;
        clear_Reg5s = 0;
        load_Reg7s  = 0;
        clear_Reg7s = 0;
        load_Reg05s  = 0;
        clear_Reg05s = 0;

        case (estado_atual)
            EST_RED: begin
                red = 1;
                load_Reg5s = 1;
                clear_Reg7s = 1;
                clear_Reg05s = 1;
            end

            EST_GREEN: begin
                green = 1;
                load_Reg7s = 1;
                clear_Reg5s = 1;
                clear_Reg05s = 1;
            end

            EST_YELLOW: begin
                yellow = 1;
                load_Reg05s = 1;
                clear_Reg7s = 1;
                clear_Reg5s = 1;
            end
        endcase
    end

endmodule