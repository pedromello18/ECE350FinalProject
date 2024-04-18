module FPGA7seg(CA, CB, CC, CD, CE, CF, CG, AN, timer, currentScore, highScore, CLK50MHZ);
    output CA, CB, CC, CD, CE, CF, CG;
    output [7:0] AN;
    input [31:0] timer, highScore, currentScore;
    input CLK50MHZ;

    reg CLK1khz = 0;
    reg [31:0] khz1counter = 0;
    reg [2:0] digitCounter = 0;
    reg [7:0] oneColdAnode = 0;
    reg [6:0] ctrl = 0;

    reg [31:0] timer_msd, timer_lsd, highScore_msd, highScore_lsd, currentScore_msd, currentScore_lsd = 0;
    reg [6:0] ctrl_timer_msd, ctrl_timer_lsd, ctrl_highScore_msd, ctrl_highScore_lsd, ctrl_currentScore_msd, ctrl_currentScore_lsd = 0;

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
            0 : ctrl = ctrl_currentScore_lsd;
            1 : ctrl = ctrl_currentScore_msd;
            2 : ctrl = 7'b111_1111;
            3 : ctrl = ctrl_timer_lsd;
            4 : ctrl = ctrl_timer_msd;
            5 : ctrl = 7'b111_1111;
            6 : ctrl = ctrl_highScore_lsd;
            7 : ctrl = ctrl_highScore_msd;
        endcase


        timer_msd = timer/10;
        timer_lsd = timer - timer_msd*10;
        case (timer_msd)
            0 : ctrl_timer_msd = 7'b0000001;
            1 : ctrl_timer_msd = 7'b1001111;
            2 : ctrl_timer_msd = 7'b0010010;
            3 : ctrl_timer_msd = 7'b0000110;
            4 : ctrl_timer_msd = 7'b1001100;
            5 : ctrl_timer_msd = 7'b0100100;
            6 : ctrl_timer_msd = 7'b0100000;
            7 : ctrl_timer_msd = 7'b0001111;
            8 : ctrl_timer_msd = 7'b0000000;
            9 : ctrl_timer_msd = 7'b0001100;
        endcase
        case (timer_lsd)
            0 : ctrl_timer_lsd = 7'b0000001;
            1 : ctrl_timer_lsd = 7'b1001111;
            2 : ctrl_timer_lsd = 7'b0010010;
            3 : ctrl_timer_lsd = 7'b0000110;
            4 : ctrl_timer_lsd = 7'b1001100;
            5 : ctrl_timer_lsd = 7'b0100100;
            6 : ctrl_timer_lsd = 7'b0100000;
            7 : ctrl_timer_lsd = 7'b0001111;
            8 : ctrl_timer_lsd = 7'b0000000;
            9 : ctrl_timer_lsd = 7'b0001100;
        endcase

        highScore_msd = highScore/10;
        highScore_lsd = highScore - highScore_msd*10;
        case (highScore_msd)
            0 : ctrl_highScore_msd = 7'b0000001;
            1 : ctrl_highScore_msd = 7'b1001111;
            2 : ctrl_highScore_msd = 7'b0010010;
            3 : ctrl_highScore_msd = 7'b0000110;
            4 : ctrl_highScore_msd = 7'b1001100;
            5 : ctrl_highScore_msd = 7'b0100100;
            6 : ctrl_highScore_msd = 7'b0100000;
            7 : ctrl_highScore_msd = 7'b0001111;
            8 : ctrl_highScore_msd = 7'b0000000;
            9 : ctrl_highScore_msd = 7'b0001100;
        endcase
        case (highScore_lsd)
            0 : ctrl_highScore_lsd = 7'b0000001;
            1 : ctrl_highScore_lsd = 7'b1001111;
            2 : ctrl_highScore_lsd = 7'b0010010;
            3 : ctrl_highScore_lsd = 7'b0000110;
            4 : ctrl_highScore_lsd = 7'b1001100;
            5 : ctrl_highScore_lsd = 7'b0100100;
            6 : ctrl_highScore_lsd = 7'b0100000;
            7 : ctrl_highScore_lsd = 7'b0001111;
            8 : ctrl_highScore_lsd = 7'b0000000;
            9 : ctrl_highScore_lsd = 7'b0001100;
        endcase

        currentScore_msd = currentScore/10;
        currentScore_lsd = currentScore - currentScore_msd*10;
        case (currentScore_msd)
            0 : ctrl_currentScore_msd = 7'b0000001;
            1 : ctrl_currentScore_msd = 7'b1001111;
            2 : ctrl_currentScore_msd = 7'b0010010;
            3 : ctrl_currentScore_msd = 7'b0000110;
            4 : ctrl_currentScore_msd = 7'b1001100;
            5 : ctrl_currentScore_msd = 7'b0100100;
            6 : ctrl_currentScore_msd = 7'b0100000;
            7 : ctrl_currentScore_msd = 7'b0001111;
            8 : ctrl_currentScore_msd = 7'b0000000;
            9 : ctrl_currentScore_msd = 7'b0001100;
        endcase
        case (currentScore_lsd)
            0 : ctrl_currentScore_lsd = 7'b0000001;
            1 : ctrl_currentScore_lsd = 7'b1001111;
            2 : ctrl_currentScore_lsd = 7'b0010010;
            3 : ctrl_currentScore_lsd = 7'b0000110;
            4 : ctrl_currentScore_lsd = 7'b1001100;
            5 : ctrl_currentScore_lsd = 7'b0100100;
            6 : ctrl_currentScore_lsd = 7'b0100000;
            7 : ctrl_currentScore_lsd = 7'b0001111;
            8 : ctrl_currentScore_lsd = 7'b0000000;
            9 : ctrl_currentScore_lsd = 7'b0001100;
        endcase
    end
endmodule