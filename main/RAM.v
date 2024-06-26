`timescale 1ns / 1ps
module RAM #( parameter DATA_WIDTH = 32, ADDRESS_WIDTH = 12, DEPTH = 20) (
    input wire                     clk,
    input wire                     wEn,
    input wire [ADDRESS_WIDTH-1:0] addr,
    input wire [DATA_WIDTH-1:0]    dataIn,
    output reg [DATA_WIDTH-1:0]    dataOut = 0,
    input wire                     newGame,
    input wire [5:0]               distance,
    input wire                     goActuator);
    
    reg[DATA_WIDTH-1:0] MemoryArray[0:DEPTH-1];
    
    integer i;
    initial begin
        for (i = 0; i < DEPTH; i = i + 1) begin
            MemoryArray[i] <= 0;
        end
        // if(MEMFILE > 0) begin
        //     $readmemh(MEMFILE, MemoryArray);
        // end
    end
    
    always @(posedge clk) begin
        if(wEn) begin
            MemoryArray[addr] <= dataIn;
        end else begin
            dataOut <= MemoryArray[addr];
        end
        MemoryArray[0] <= {31'b0, newGame};
        MemoryArray[2] <= {31'b0, goActuator};
        if (distance != 0) begin
            MemoryArray[1] <= {26'b0, distance};
        end
    end
endmodule
