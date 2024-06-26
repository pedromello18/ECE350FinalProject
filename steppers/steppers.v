module steppers(JA1, JA2, JA3, JA4, CLK50MHZ, rotationDirectionChange, motorEnable);
    output JA1, JA2, JA3, JA4;
    input CLK50MHZ, rotationDirectionChange, motorEnable;
    assign rotationDirectionChange = SW0;

    assign {JA1, JA2, JA3, JA4} = ctrl;

    reg[3:0] ctrl = 0;
    reg[31:0] divcounter = 0;
    reg[2:0] iterCounter = 0;
    reg CLK100HZ = 0;

    always @(posedge CLK50MHZ) begin
        if (divcounter < 500000) begin // final will prob be between 50000 and 500000
            divcounter <= divcounter + 1;
        end else begin
            divcounter <= 0;
            CLK100HZ <= ~CLK100HZ;
        end
    end
    
    always @(posedge CLK100HZ) begin // other direction
        if (motorEnable) begin
            if (rotationDirectionChange) begin
                case(iterCounter)
                        3'b000 : ctrl = 4'b0100;
                        3'b001 : ctrl = 4'b0110;
                        3'b010 : ctrl = 4'b0010;
                        3'b011 : ctrl = 4'b1010;
                        3'b100 : ctrl = 4'b1000;
                        3'b101 : ctrl = 4'b1001;
                        3'b110 : ctrl = 4'b0001;
                        3'b111 : ctrl = 4'b0101;
                endcase
            end else begin
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
            if (iterCounter >= 7) begin
                    iterCounter <= 0;
                end else begin
                    iterCounter <= iterCounter + 1;
                end
        end
    end
endmodule