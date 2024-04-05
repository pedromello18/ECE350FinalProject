/**
 * READ THIS DESCRIPTION!
 *
 * This is your processor module that will contain the bulk of your code submission. You are to implement
 * a 5-stage pipelined processor in this module, accounting for hazards and implementing bypasses as
 * necessary.
 *
 * Ultimately, your processor will be tested by a master skeleton, so the
 * testbench can see which controls signal you active when. Therefore, there needs to be a way to
 * "inject" imem, dmem, and regfile interfaces from some external controller module. The skeleton
 * file, Wrapper.v, acts as a small wrapper around your processor for this purpose. Refer to Wrapper.v
 * for more details.
 *
 * As a result, this module will NOT contain the RegFile nor the memory modules. Study the inputs 
 * very carefully - the RegFile-related I/Os are merely signals to be sent to the RegFile instantiated
 * in your Wrapper module. This is the same for your memory elements. 
 *
 *
 */
module processor(
    // Control signals
    clock,                          // I: The master clock
    reset,                          // I: A reset signal

    // Imem
    address_imem,                   // O: The address of the data to get from imem
    q_imem,                         // I: The data from imem

    // Dmem
    address_dmem,                   // O: The address of the data to get or put from/to dmem
    data,                           // O: The data to write to dmem
    wren,                           // O: Write enable for dmem
    q_dmem,                         // I: The data from dmem

    // Regfile
    ctrl_writeEnable,               // O: Write enable for RegFile
    ctrl_writeReg,                  // O: Register to write to in RegFile
    ctrl_readRegA,                  // O: Register to read from port A of RegFile
    ctrl_readRegB,                  // O: Register to read from port B of RegFile
    data_writeReg,                  // O: Data to write to for RegFile
    data_readRegA,                  // I: Data from port A of RegFile
    data_readRegB                   // I: Data from port B of RegFile
	 
	);

	// Control signals
	input clock, reset;
	
	// Imem
    output [31:0] address_imem;
	input [31:0] q_imem;

	// Dmem
	output [31:0] address_dmem, data;
	output wren;
	input [31:0] q_dmem;

	// Regfile
	output ctrl_writeEnable;
	output [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
	output [31:0] data_writeReg;
	input [31:0] data_readRegA, data_readRegB;

	/* YOUR CODE STARTS HERE */

    // Fetch Stage
    wire [31:0] FetchPCP1, PCinput;
    wire [1:0] PCselect;
    wire DC1, DC2, DC3, BranchTaken; // All outputs

    single_reg PC_F(address_imem, PCinput, ~clock, PipelineOn, StallLogic, reset);
    carry_lookahead_adder PCADDER(FetchPCP1, DC1, DC2, DC3, address_imem, 32'b1, 1'b0);
    assign PCselect = {((~DXOpCode[4] & ~DXOpCode[3] & DXOpCode[2] & ~DXOpCode[1] & ~DXOpCode[0]) | (~DXOpCode[4] & ~DXOpCode[3] & DXOpCode[2] & DXOpCode[1] & ~DXOpCode[0] & rdLessThanRs) | (~DXOpCode[4] & ~DXOpCode[3] & ~DXOpCode[2] & DXOpCode[1] & ~DXOpCode[0] & rdNotEqualRs)), ((~DXOpCode[4] & ~DXOpCode[3] & ~DXOpCode[2] & DXOpCode[0]) | (~DXOpCode[4] & ~DXOpCode[3] & DXOpCode[2] & DXOpCode[1] & ~DXOpCode[0] & rdLessThanRs) | (~DXOpCode[4] & ~DXOpCode[3] & ~DXOpCode[2] & DXOpCode[1] & ~DXOpCode[0] & rdNotEqualRs) | (DXOpCode[4] & ~DXOpCode[3] & DXOpCode[2] & DXOpCode[1] & ~DXOpCode[0] & rstatusNotZero))};
    busmux_4 PCMUX(PCinput, PCselect, FetchPCP1, target, ALUinputB, PCP1PlusN); //target for j/jal/bex isns; ALUinputB for jr isn; PCP1PlusN for bne/blt
    assign BranchTaken = PCselect[1] | PCselect[0];

    // Decode Stage
    wire [31:0] DecodePC, DecodeIR, IR_FD_INPUT;
    wire MultDivStall, StallLogic, BypassStall, LoadRDisNextRS, LoadRDisNextRT, LoadRDisNextRD;

    single_reg PC_FD(DecodePC, FetchPCP1, ~clock, PipelineOn, StallLogic, reset);
    assign IR_FD_INPUT = BranchTaken ? 32'b0 : q_imem;
    single_reg IR_FD(DecodeIR, IR_FD_INPUT, ~clock, PipelineOn, StallLogic, reset);
    assign ctrl_readRegA = (DecodeIR[31] & ~DecodeIR[30] & DecodeIR[29] & DecodeIR[28] & ~DecodeIR[27]) ? 5'b11110 : DecodeIR[21:17];
    assign ctrl_readRegB = ((~DecodeIR[31] & ~DecodeIR[30] & DecodeIR[29] & ~(DecodeIR[28] ^ DecodeIR[27])) | (~DecodeIR[31] & ~DecodeIR[30] & DecodeIR[28] & ~DecodeIR[27])) ? DecodeIR[26:22] : DecodeIR[16:12]; // for sw/jr/bne/blt isns
    
    assign MultDivStall = (~DecodeIR[31] & ~DecodeIR[30] & ~DecodeIR[29] & ~DecodeIR[28] & ~DecodeIR[27] & ~DecodeIR[6] & ~DecodeIR[5] & DecodeIR[4] & DecodeIR[3] & ~ALUOp[4] & ~ALUOp[3] & ALUOp[2] & ALUOp[1]); // Have multdiv operation both in decode and execute stage

    assign StallLogic = ~MultDivStall & ~BypassStall;

    assign BypassStall = (ExecuteIR[31:27] == 5'b01000) & ((LoadRDisNextRS | (LoadRDisNextRT & (DecodeIR[31:27] != 5'b00111))) | (LoadRDisNextRD & (DecodeIR[31:27] != 5'b00111) & ((DecodeIR[31:27] != 5'b00010) | (DecodeIR[31:27] != 5'b00100) | (DecodeIR[31:27] != 5'b00110))));
    assign LoadRDisNextRS = (DecodeIR[21:17] == ExecuteIR[26:22]);
    assign LoadRDisNextRT = (DecodeIR[16:12] == ExecuteIR[26:22]);
    assign LoadRDisNextRD = (DecodeIR[26:22] == ExecuteIR[26:22]);

    // Execute Stage
    wire [31:0] ExecutePC, ExecuteIR, ALUinputA, ALUinputB, ImmSX, ALUinputBorImmSX, ALUResult, multDivResult, XstageResult, target, IR_DX_INPUT, PCP1PlusN, setxIsnIn, DXAReg, DXBReg, ALUinputAnoException, ALUinputBnoException;
    wire [4:0] DXOpCode, ALUOp;
    wire IsImmOp, ALessThanB, ALUovf, ctrlMult, ctrlDiv, dataException, multDivResultReady, rdLessThanRs, rdNotEqualRs, rstatusNotZero, isMultOp, isDivOp, delayedMultOp, delayedDivOp, addOverflow, addiOverflow, subOverflow, multOverflow, divOverflow, WBtoXBypassA, MtoXBypassA, WBtoXBypassB, MtoXBypassB, MchangesReg, MtoXBypassBRegular, MtoXBypassBjrbneblt, WBtoXBypassBRegular, WBtoXBypassBjrbneblt, MExceptionBypassA, MExceptionBypassB, ovfInExecute;
    wire DC5, DC6, DC7;

    single_reg PC_DX(ExecutePC, DecodePC, ~clock, PipelineOn, PipelineOn, reset);
    assign IR_DX_INPUT = BranchTaken | MultDivStall | BypassStall ? 32'b0 : DecodeIR;
    single_reg IR_DX(ExecuteIR, IR_DX_INPUT, ~clock, PipelineOn, PipelineOn, reset);
    single_reg A_DX(DXAReg, data_readRegA, ~clock, PipelineOn, PipelineOn, reset);
    single_reg B_DX(DXBReg, data_readRegB, ~clock, PipelineOn, PipelineOn, reset);

    busmux_4 InABypass(ALUinputAnoException, {WBtoXBypassA & ctrl_writeEnable, MtoXBypassA & MchangesReg}, DXAReg, address_dmem, data_writeReg, address_dmem); // All -> X Bypassing (A)
    assign WBtoXBypassA = (ExecuteIR[21:17] == ctrl_writeReg) & (ExecuteIR[21:17] != 5'b0); // covers WB Exception Bypass
    assign MtoXBypassA = (ExecuteIR[21:17] == MemoryIR[26:22]) & (ExecuteIR[21:17] != 5'b0);
    assign MExceptionBypassA = (ExecuteIR[21:17] == 5'b11110) & (setxIsnOutXM[2] | setxIsnOutXM[1] | setxIsnOutXM[0]);
    assign ALUinputA = MExceptionBypassA ? {29'b0, setxIsnOutXM[2:0]} : ALUinputAnoException;

    busmux_4 InBBypass(ALUinputBnoException, {WBtoXBypassB & ctrl_writeEnable, MtoXBypassB & MchangesReg}, DXBReg, address_dmem, data_writeReg, address_dmem); // All -> X Bypassing (B)
    assign MtoXBypassBRegular = (ExecuteIR[16:12] == MemoryIR[26:22]) & (ExecuteIR[16:12] != 5'b0);
    assign MtoXBypassBjrbneblt = (ExecuteIR[26:22] == MemoryIR[26:22]) & (ExecuteIR[26:22] != 5'b0);
    assign MtoXBypassB = ((ExecuteIR[31:27] == 5'b00100) | (ExecuteIR[31:27] == 5'b00010) | (ExecuteIR[31:27] == 5'b00110)) ? MtoXBypassBjrbneblt : MtoXBypassBRegular;
    assign MchangesReg = ((~MemoryIR[31] & ~MemoryIR[29] & ~MemoryIR[28] & ~MemoryIR[27]) | (~MemoryIR[30] & MemoryIR[29] & ~MemoryIR[28] & MemoryIR[27]) | (~MemoryIR[31] & ~MemoryIR[30] & ~MemoryIR[29] & MemoryIR[28] & MemoryIR[27])) & ~(((MemoryIR[31:27] == 5'b00000) | (MemoryIR[31:27] == 5'b01000) | (MemoryIR[31:27] == 5'b00101)) & (MemoryIR[26:22] == 5'b0));
    assign WBtoXBypassBRegular = (ExecuteIR[16:12] == ctrl_writeReg); // covers WB Exception Bypass
    assign WBtoXBypassBjrbneblt = (ExecuteIR[26:22] == ctrl_writeReg);
    assign WBtoXBypassB = ((ExecuteIR[31:27] == 5'b00100) | (ExecuteIR[31:27] == 5'b00010) | (ExecuteIR[31:27] == 5'b00110)) ? WBtoXBypassBjrbneblt : WBtoXBypassBRegular;
    assign MExceptionBypassB = (ExecuteIR[16:12] == 5'b11110) & (setxIsnOutXM[2] | setxIsnOutXM[1] | setxIsnOutXM[0]);
    assign ALUinputB = MExceptionBypassB ? {29'b0, setxIsnOutXM[2:0]} : ALUinputBnoException;
    

    assign DXOpCode = ExecuteIR[31:27];
    OpCodeALUCodeDecoder XALUDECODE(ALUOp, ExecuteIR);
    assign ImmSX = {ExecuteIR[16], ExecuteIR[16], ExecuteIR[16], ExecuteIR[16], ExecuteIR[16], ExecuteIR[16], ExecuteIR[16], ExecuteIR[16], ExecuteIR[16], ExecuteIR[16], ExecuteIR[16], ExecuteIR[16], ExecuteIR[16], ExecuteIR[16], ExecuteIR[16], ExecuteIR[16:0]};
    assign IsImmOp = (~DXOpCode[4] & ~DXOpCode[3] & DXOpCode[2] & ~DXOpCode[1] & DXOpCode[0]) | (~DXOpCode[4] & ~DXOpCode[3] & DXOpCode[2] & DXOpCode[1] & DXOpCode[0]) | (~DXOpCode[4] & DXOpCode[3] & ~DXOpCode[2] & ~DXOpCode[1] & ~DXOpCode[0]); // addi, sw, lw
    assign ALUinputBorImmSX = IsImmOp ? ImmSX : ALUinputB;
    alu MainALU(ALUinputA, ALUinputBorImmSX, ALUOp, ExecuteIR[11:7], ALUResult, rdNotEqualRs, ALessThanB, ALUovf);

    assign rstatusNotZero = (ALUinputA[0] | ALUinputA[1] | ALUinputA[2] | ALUinputA[3] | ALUinputA[4] | ALUinputA[5] | ALUinputA[6] | ALUinputA[7] | ALUinputA[8] | ALUinputA[9] | ALUinputA[10] | ALUinputA[11] | ALUinputA[12] | ALUinputA[13] | ALUinputA[14] | ALUinputA[15] | ALUinputA[16] | ALUinputA[17] | ALUinputA[18] | ALUinputA[19] | ALUinputA[20] | ALUinputA[21] | ALUinputA[22] | ALUinputA[23] | ALUinputA[24] | ALUinputA[25] | ALUinputA[26] | ALUinputA[27] | ALUinputA[28] | ALUinputA[29] | ALUinputA[30] | ALUinputA[31]);
    assign target = {5'b0, ExecuteIR[26:0]};
    assign rdLessThanRs = ~(~rdNotEqualRs | ALessThanB);
    carry_lookahead_adder PC_N_ADDER(PCP1PlusN, DC5, DC6, DC7, ExecutePC, ImmSX, 1'b0);
    
    wire PipelineOn, PipelineOff;
    dffe_ref PIPELINE_CTRL(PipelineOff, (~ALUOp[4] & ~ALUOp[3] & ALUOp[2] & ALUOp[1]), clock, 1'b1, reset | multDivResultReady);
    assign PipelineOn = ~PipelineOff;
    
//    multdiv MD(ALUinputA, ALUinputB, ctrlMult, ctrlDiv, clock, multDivResult, dataException, multDivResultReady);

//    assign isMultOp = (~ALUOp[4] & ~ALUOp[3] & ALUOp[2] & ALUOp[1] & ~ALUOp[0]);
//    assign isDivOp = (~ALUOp[4] & ~ALUOp[3] & ALUOp[2] & ALUOp[1] & ALUOp[0]);
//    dffe_ref DELAYED_MULT(delayedMultOp, isMultOp, ~clock, 1'b1, reset);
//    dffe_ref DELAYED_DIV(delayedDivOp, isDivOp, ~clock, 1'b1, reset);
//    assign ctrlMult = isMultOp & ~delayedMultOp;
//    assign ctrlDiv = isDivOp & ~delayedDivOp;

//    assign XstageResult = (~ALUOp[4] & ~ALUOp[3] & ALUOp[2] & ALUOp[1]) ? multDivResult : ALUResult;
    assign XstageResult = ALUResult;

    assign addOverflow = ALUovf & ~ExecuteIR[31] & ~ExecuteIR[30] & ~ExecuteIR[29] & ~ExecuteIR[28] & ~ExecuteIR[27] & ~ALUOp[4] & ~ALUOp[3] & ~ALUOp[2] & ~ALUOp[1] & ~ALUOp[0];
    assign addiOverflow = ALUovf & ~ExecuteIR[31] & ~ExecuteIR[30] & ExecuteIR[29] & ~ExecuteIR[28] & ExecuteIR[27] & ~ALUOp[4] & ~ALUOp[3] & ~ALUOp[2] & ~ALUOp[1] & ~ALUOp[0];
    assign subOverflow = ALUovf & ~ExecuteIR[31] & ~ExecuteIR[30] & ~ExecuteIR[29] & ~ExecuteIR[28] & ~ExecuteIR[27] & ~ALUOp[4] & ~ALUOp[3] & ~ALUOp[2] & ~ALUOp[1] & ALUOp[0];
//    assign multOverflow = dataException & ~ExecuteIR[31] & ~ExecuteIR[30] & ~ExecuteIR[29] & ~ExecuteIR[28] & ~ExecuteIR[27] & ~ALUOp[4] & ~ALUOp[3] & ALUOp[2] & ALUOp[1] & ~ALUOp[0];
//    assign divOverflow = dataException & ~ExecuteIR[31] & ~ExecuteIR[30] & ~ExecuteIR[29] & ~ExecuteIR[28] & ~ExecuteIR[27] & ~ALUOp[4] & ~ALUOp[3] & ALUOp[2] & ALUOp[1] & ALUOp[0];

//    assign setxIsnIn = {5'b10101, 24'b0, (multOverflow | divOverflow), (addiOverflow | subOverflow), (addOverflow | subOverflow | divOverflow)};
    assign setxIsnIn = {5'b10101, 24'b0, 1'b0, (addiOverflow | subOverflow), (addOverflow | subOverflow)};
//    assign ovfInExecute = addOverflow | addiOverflow | subOverflow | multOverflow | divOverflow;
    assign ovfInExecute = addOverflow | addiOverflow | subOverflow;

    // Memory Stage
    wire [31:0] MemoryPC, MemoryIR, setxIsnOutXM, XMRegB, MemIRinput;
    wire [4:0] XMOpCode;
    wire isSetXInstruction, WMDependence;

    single_reg DATA_EXCEPTIONSXM(setxIsnOutXM, setxIsnIn, ~clock, PipelineOn, PipelineOn, reset);

    single_reg PC_XM(MemoryPC, ExecutePC, ~clock, PipelineOn, PipelineOn, reset);
    assign MemIRinput = ovfInExecute ? setxIsnIn : ExecuteIR;
    single_reg IR_XM(MemoryIR, MemIRinput, ~clock, PipelineOn, PipelineOn, reset);
    single_reg O_XM(address_dmem, XstageResult, ~clock, PipelineOn, PipelineOn, reset);
    single_reg B_XM(XMRegB, ALUinputB, ~clock, PipelineOn, PipelineOn, reset);
    assign XMOpCode = MemoryIR[31:27];
    assign wren = (~XMOpCode[4] & ~XMOpCode[3] & XMOpCode[2] & XMOpCode[1] & XMOpCode[0]);

    assign data = WMDependence & ctrl_writeEnable ? data_writeReg : XMRegB; // WB -> M Bypassing
    assign WMDependence = (ctrl_writeReg == MemoryIR[26:22]);

    // WriteBack Stage
    wire [31:0] WriteBackPC, WriteBackIR, WB_ALUOut, WB_DMemOut, setxTarget, setxIsnOutMW, dataExceptionMWInput, WriteBackIRInput;
    wire [4:0] MWOpCode, WBrd, prelim_rd;
    wire [1:0] selectWB;
    wire IsJalInstruction, IsAddi;

    single_reg PC_MW(WriteBackPC, MemoryPC, ~clock, PipelineOn, PipelineOn, reset);
    single_reg IR_MW(WriteBackIR, MemoryIR, ~clock, PipelineOn, PipelineOn, reset);
    single_reg O_MW(WB_ALUOut, address_dmem, ~clock, PipelineOn, PipelineOn, reset);
    single_reg D_MW(WB_DMemOut, q_dmem, ~clock, PipelineOn, PipelineOn, reset);
    assign MWOpCode = WriteBackIR[31:27];
    assign IsJalInstruction = (~MWOpCode[4] & ~MWOpCode[3] & ~MWOpCode[2] & MWOpCode[1] & MWOpCode[0]);
    assign IsAddi = (~MWOpCode[4] & ~MWOpCode[3] & MWOpCode[2] & ~MWOpCode[1] & MWOpCode[0]);
    assign selectWB = {IsJalInstruction | isSetXInstruction, (~MWOpCode[4] & MWOpCode[3] & ~MWOpCode[2] & ~MWOpCode[1] & ~MWOpCode[0]) | isSetXInstruction};
    assign setxTarget = {5'b0, WriteBackIR[26:0]};
    assign isSetXInstruction = (MWOpCode[4] & ~MWOpCode[3] & MWOpCode[2] & ~MWOpCode[1] & MWOpCode[0]);
    busmux_4 WriteToRegFile(data_writeReg, selectWB, WB_ALUOut, WB_DMemOut, WriteBackPC, setxTarget);
    assign ctrl_writeEnable = ((~MWOpCode[4] & ~MWOpCode[2] & ~MWOpCode[1] & ~MWOpCode[0]) | IsJalInstruction | IsAddi | isSetXInstruction) & ~(((WriteBackIR[31:27] == 5'b00000) | (WriteBackIR[31:27] == 5'b01000) | (WriteBackIR[31:27] == 5'b00101)) & (WriteBackIR[26:22] == 5'b0)); // First term is combo ALU Opcode + lw
	assign WBrd = WriteBackIR[26:22];
    assign prelim_rd = IsJalInstruction ? 5'b11111 : WBrd;
    assign ctrl_writeReg = isSetXInstruction ? 5'b11110 : prelim_rd;

	/* END CODE */

endmodule