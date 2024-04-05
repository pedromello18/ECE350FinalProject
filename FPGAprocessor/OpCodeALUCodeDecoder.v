module OpCodeALUCodeDecoder(ALUCode, ExecuteIR);
    input [31:0] ExecuteIR;
    output [4:0] ALUCode;

    wire IsRType, ALUShouldAdd;
    wire [4:0] RTypeCode, NotRTypeCode;

    assign IsRType = (~ExecuteIR[31] & ~ExecuteIR[30] & ~ExecuteIR[29] & ~ExecuteIR[28] & ~ExecuteIR[27]);
    assign RTypeCode = ExecuteIR[6:2];

    assign ALUShouldAdd = (~ExecuteIR[31] & ~ExecuteIR[30] & ExecuteIR[29] & ExecuteIR[27]) | (~ExecuteIR[31] & ExecuteIR[30] & ~ExecuteIR[29] & ~ExecuteIR[28] & ~ExecuteIR[27]); //First term is combo (sw + addi)
    assign NotRTypeCode = ALUShouldAdd ? 5'b0 : 5'b00001;
    
    assign ALUCode = IsRType ? RTypeCode : NotRTypeCode;
endmodule