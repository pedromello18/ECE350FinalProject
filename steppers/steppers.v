module steppers(JA1, JA2, JA3, JA4, CLK50MHZ);
    output JA1, JA2, JA3, JA4;
    input CLK50MHZ;

    wire clk;
    assign clk = CLK50MHZ;

    reg [3:0] ctrl;
    initial begin
       ctrl = 0;
       divcounter = 0;
       iterCounter = 0;
    end
    assign {JA1, JA2, JA3, JA4} = ctrl;

    reg[15:0] divcounter;
    reg[2:0] iterCounter;
    always @(posedge clk) begin
        divcounter <= divcounter + 1;
        if (divcounter == 500000) begin
            divcounter <= 0;
            iterCounter <= iterCounter + 1;
            case(iterCounter)
                3'b000 : ctrl = 4'b0100;
                3'b001 : ctrl = 4'b0101;
                3'b010 : ctrl = 4'b0001;
                3'b011 : ctrl = 4'b1001;
                3'b100 : ctrl = 4'b1000;
                3'b101 : ctrl = 4'b1010;
                3'b110 : ctrl = 4'b0010;
                3'b111 : ctrl = 4'b0110;
            endcase
        end
        if (iterCounter == 7) begin
            iterCounter <= 0;
        end
    end


endmodule