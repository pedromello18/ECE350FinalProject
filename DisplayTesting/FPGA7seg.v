module FPGA7seg(CA, CB, CC, CD, CE, CF, CG, AN, SW, CLK50MHZ);
    output CA, CB, CC, CD, CE, CF, CG;
    output [7:0] AN;
    input [15:0] SW;
    input CLK50MHZ;

    reg CLK1khz = 0;
    reg [31:0] khz1counter = 0;
    reg digitCounter = 0;
    reg [7:0] oneColdAnode = 0;
    reg [6:0] ctrl = 0;

    reg [7:0] fmsd, flsd, smsd, slsd = 0;
    reg [6:0] ctrl_fmsd, ctrl_flsd, ctrl_smsd, ctrl_slsd = 0;

    assign AN = oneColdAnode;
    assign {CA, CB, CC, CD, CE, CF, CG} = ctrl;

    always @(posedge CLK50MHZ) begin
        if (khz1counter < 50000) begin 
            khz1counter <= khz1counter + 1;
        end else begin
            khz1counter <= 0;
            CLK1khz <= ~CLK1khz;
        end
    end

    always @(posedge CLK1khz) begin
        digitCounter = digitCounter + 1;
        if (digitCounter >= 8) begin
            digitCounter = 0;
        end
    end

    always begin
        case (digitCounter)
            0 : oneColdAnode = 8'b1111_1110;
            1 : oneColdAnode = 8'b1111_1101;
            2 : oneColdAnode = 8'b1111_1011;
            3 : oneColdAnode = 8'b1111_0111;
            4 : oneColdAnode = 8'b1110_1111;
            5 : oneColdAnode = 8'b1101_1111;
            6 : oneColdAnode = 8'b1011_1111;
            7 : oneColdAnode = 8'b0111_1111;
        endcase

        case (digitCounter)
            0 : ctrl = ctrl_slsd;
            1 : ctrl = ctrl_smsd;
            2 : ctrl = 7'b000_0000;
            3 : ctrl = 7'b000_0000;
            4 : ctrl = ctrl_flsd;
            5 : ctrl = ctrl_fmsd;
            6 : ctrl = 7'b000_0000;
            7 : ctrl = 7'b000_0000;
        endcase


        fmsd = SW[15:8]/10;
        flsd = SW[15:8] - fmsd*10;
        case (fmsd)
            0 : ctrl_fmsd = 7'b1111110;
            1 : ctrl_fmsd = 7'b0110000;
            2 : ctrl_fmsd = 7'b1101101;
            3 : ctrl_fmsd = 7'b1111001;
            4 : ctrl_fmsd = 7'b0110011;
            5 : ctrl_fmsd = 7'b1011011;
            6 : ctrl_fmsd = 7'b1011111;
            7 : ctrl_fmsd = 7'b1110000;
            8 : ctrl_fmsd = 7'b1111111;
            9 : ctrl_fmsd = 7'b1110011;
        endcase
        case (flsd)
            0 : ctrl_flsd = 7'b1111110;
            1 : ctrl_flsd = 7'b0110000;
            2 : ctrl_flsd = 7'b1101101;
            3 : ctrl_flsd = 7'b1111001;
            4 : ctrl_flsd = 7'b0110011;
            5 : ctrl_flsd = 7'b1011011;
            6 : ctrl_flsd = 7'b1011111;
            7 : ctrl_flsd = 7'b1110000;
            8 : ctrl_flsd = 7'b1111111;
            9 : ctrl_flsd = 7'b1110011;
        endcase

        smsd = SW[7:0]/10;
        slsd = SW[7:0] - smsd*10;
        case (smsd)
            0 : ctrl_smsd = 7'b1111110;
            1 : ctrl_smsd = 7'b0110000;
            2 : ctrl_smsd = 7'b1101101;
            3 : ctrl_smsd = 7'b1111001;
            4 : ctrl_smsd = 7'b0110011;
            5 : ctrl_smsd = 7'b1011011;
            6 : ctrl_smsd = 7'b1011111;
            7 : ctrl_smsd = 7'b1110000;
            8 : ctrl_smsd = 7'b1111111;
            9 : ctrl_smsd = 7'b1110011;
        endcase
        case (slsd)
            0 : ctrl_slsd = 7'b1111110;
            1 : ctrl_slsd = 7'b0110000;
            2 : ctrl_slsd = 7'b1101101;
            3 : ctrl_slsd = 7'b1111001;
            4 : ctrl_slsd = 7'b0110011;
            5 : ctrl_slsd = 7'b1011011;
            6 : ctrl_slsd = 7'b1011111;
            7 : ctrl_slsd = 7'b1110000;
            8 : ctrl_slsd = 7'b1111111;
            9 : ctrl_slsd = 7'b1110011;
        endcase
    end
endmodule