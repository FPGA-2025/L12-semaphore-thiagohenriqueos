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

    typedef enum reg [1:0] {
        EST_RED    = 2'b00,
        EST_GREEN  = 2'b01,
        EST_YELLOW = 2'b10
    } estado_t;

    reg [1:0] estado_atual, proximo_estado;

    always @(posedge clk or posedge rst) begin
        if (rst)
            estado_atual <= EST_RED;
        else
            estado_atual <= proximo_estado;
    end

    always @(*) begin
        case (estado_atual)
            EST_RED: begin
                if (fim_5s)
                    proximo_estado = EST_GREEN;
                else
                    proximo_estado = EST_RED;
            end

            EST_GREEN: begin
                if (fim_7s || pedestrian)
                    proximo_estado = EST_YELLOW;
                else
                    proximo_estado = EST_GREEN;
            end

            EST_YELLOW: begin
                if (fim_05s)
                    proximo_estado = EST_RED;
                else
                    proximo_estado = EST_YELLOW;
            end

            default: proximo_estado = EST_RED;
        endcase
    end

    always @(*) begin
        green  = 1'b0;
        yellow = 1'b0;
        red    = 1'b0;

        load_Reg5s  = 1'b0;
        clear_Reg5s = 1'b0;
        load_Reg7s  = 1'b0;
        clear_Reg7s = 1'b0;
        load_Reg05s  = 1'b0;
        clear_Reg05s = 1'b0;

        case (estado_atual)
            EST_RED: begin
                red = 1'b1;
                load_Reg5s = 1'b1;
                clear_Reg7s = 1'b1;
                clear_Reg05s = 1'b1;
            end

            EST_GREEN: begin
                green = 1'b1;
                load_Reg7s = 1'b1;
                clear_Reg5s = 1'b1;
                clear_Reg05s = 1'b1;
            end

            EST_YELLOW: begin
                yellow = 1'b1;
                load_Reg05s = 1'b1;
                clear_Reg7s = 1'b1;
                clear_Reg05s = 1'b1;
            end
        endcase
    end

endmodule
