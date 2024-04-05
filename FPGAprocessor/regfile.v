module regfile (
	clock,
	ctrl_writeEnable, ctrl_reset, ctrl_writeReg,
	ctrl_readRegA, ctrl_readRegB, data_writeReg,
	data_readRegA, data_readRegB, reg14
);

	input clock, ctrl_writeEnable, ctrl_reset;
	input [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
	input [31:0] data_writeReg;

	output [31:0] data_readRegA, data_readRegB, reg14;

	wire [31:0] write, read1, read2;

	wire [31:0] r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31;

	assign reg14 = r14;
	
	decoder32 WRITEREG(write, ctrl_writeReg, 1'b1);
	decoder32 READ1REG(read1, ctrl_readRegA, 1'b1);
	decoder32 READ2REG(read2, ctrl_readRegB, 1'b1);

	single_reg R0(r0, 32'b0, clock, write[0], ctrl_writeEnable, ctrl_reset);
	single_reg R1(r1, data_writeReg, clock, write[1], ctrl_writeEnable, ctrl_reset);
	single_reg R2(r2, data_writeReg, clock, write[2], ctrl_writeEnable, ctrl_reset);
	single_reg R3(r3, data_writeReg, clock, write[3], ctrl_writeEnable, ctrl_reset);
	single_reg R4(r4, data_writeReg, clock, write[4], ctrl_writeEnable, ctrl_reset);
	single_reg R5(r5, data_writeReg, clock, write[5], ctrl_writeEnable, ctrl_reset);
	single_reg R6(r6, data_writeReg, clock, write[6], ctrl_writeEnable, ctrl_reset);
	single_reg R7(r7, data_writeReg, clock, write[7], ctrl_writeEnable, ctrl_reset);
	single_reg R8(r8, data_writeReg, clock, write[8], ctrl_writeEnable, ctrl_reset);
	single_reg R9(r9, data_writeReg, clock, write[9], ctrl_writeEnable, ctrl_reset);
	single_reg R10(r10, data_writeReg, clock, write[10], ctrl_writeEnable, ctrl_reset);
	single_reg R11(r11, data_writeReg, clock, write[11], ctrl_writeEnable, ctrl_reset);
	single_reg R12(r12, data_writeReg, clock, write[12], ctrl_writeEnable, ctrl_reset);
	single_reg R13(r13, data_writeReg, clock, write[13], ctrl_writeEnable, ctrl_reset);
	single_reg R14(r14, data_writeReg, clock, write[14], ctrl_writeEnable, ctrl_reset);
	single_reg R15(r15, data_writeReg, clock, write[15], ctrl_writeEnable, ctrl_reset);
	single_reg R16(r16, data_writeReg, clock, write[16], ctrl_writeEnable, ctrl_reset);
	single_reg R17(r17, data_writeReg, clock, write[17], ctrl_writeEnable, ctrl_reset);
	single_reg R18(r18, data_writeReg, clock, write[18], ctrl_writeEnable, ctrl_reset);
	single_reg R19(r19, data_writeReg, clock, write[19], ctrl_writeEnable, ctrl_reset);
	single_reg R20(r20, data_writeReg, clock, write[20], ctrl_writeEnable, ctrl_reset);
	single_reg R21(r21, data_writeReg, clock, write[21], ctrl_writeEnable, ctrl_reset);
	single_reg R22(r22, data_writeReg, clock, write[22], ctrl_writeEnable, ctrl_reset);
	single_reg R23(r23, data_writeReg, clock, write[23], ctrl_writeEnable, ctrl_reset);
	single_reg R24(r24, data_writeReg, clock, write[24], ctrl_writeEnable, ctrl_reset);
	single_reg R25(r25, data_writeReg, clock, write[25], ctrl_writeEnable, ctrl_reset);
	single_reg R26(r26, data_writeReg, clock, write[26], ctrl_writeEnable, ctrl_reset);
	single_reg R27(r27, data_writeReg, clock, write[27], ctrl_writeEnable, ctrl_reset);
	single_reg R28(r28, data_writeReg, clock, write[28], ctrl_writeEnable, ctrl_reset);
	single_reg R29(r29, data_writeReg, clock, write[29], ctrl_writeEnable, ctrl_reset);
	single_reg R30(r30, data_writeReg, clock, write[30], ctrl_writeEnable, ctrl_reset);
	single_reg R31(r31, data_writeReg, clock, write[31], ctrl_writeEnable, ctrl_reset);

	my_tri READ1R0(data_readRegA, r0, read1[0]);
	my_tri READ1R1(data_readRegA, r1, read1[1]);
	my_tri READ1R2(data_readRegA, r2, read1[2]);
	my_tri READ1R3(data_readRegA, r3, read1[3]);
	my_tri READ1R4(data_readRegA, r4, read1[4]);
	my_tri READ1R5(data_readRegA, r5, read1[5]);
	my_tri READ1R6(data_readRegA, r6, read1[6]);
	my_tri READ1R7(data_readRegA, r7, read1[7]);
	my_tri READ1R8(data_readRegA, r8, read1[8]);
	my_tri READ1R9(data_readRegA, r9, read1[9]);
	my_tri READ1R10(data_readRegA, r10, read1[10]);
	my_tri READ1R11(data_readRegA, r11, read1[11]);
	my_tri READ1R12(data_readRegA, r12, read1[12]);
	my_tri READ1R13(data_readRegA, r13, read1[13]);
	my_tri READ1R14(data_readRegA, r14, read1[14]);
	my_tri READ1R15(data_readRegA, r15, read1[15]);
	my_tri READ1R16(data_readRegA, r16, read1[16]);
	my_tri READ1R17(data_readRegA, r17, read1[17]);
	my_tri READ1R18(data_readRegA, r18, read1[18]);
	my_tri READ1R19(data_readRegA, r19, read1[19]);
	my_tri READ1R20(data_readRegA, r20, read1[20]);
	my_tri READ1R21(data_readRegA, r21, read1[21]);
	my_tri READ1R22(data_readRegA, r22, read1[22]);
	my_tri READ1R23(data_readRegA, r23, read1[23]);
	my_tri READ1R24(data_readRegA, r24, read1[24]);
	my_tri READ1R25(data_readRegA, r25, read1[25]);
	my_tri READ1R26(data_readRegA, r26, read1[26]);
	my_tri READ1R27(data_readRegA, r27, read1[27]);
	my_tri READ1R28(data_readRegA, r28, read1[28]);
	my_tri READ1R29(data_readRegA, r29, read1[29]);
	my_tri READ1R30(data_readRegA, r30, read1[30]);
	my_tri READ1R31(data_readRegA, r31, read1[31]);

	my_tri READ2R0(data_readRegB, r0, read2[0]);
	my_tri READ2R1(data_readRegB, r1, read2[1]);
	my_tri READ2R2(data_readRegB, r2, read2[2]);
	my_tri READ2R3(data_readRegB, r3, read2[3]);
	my_tri READ2R4(data_readRegB, r4, read2[4]);
	my_tri READ2R5(data_readRegB, r5, read2[5]);
	my_tri READ2R6(data_readRegB, r6, read2[6]);
	my_tri READ2R7(data_readRegB, r7, read2[7]);
	my_tri READ2R8(data_readRegB, r8, read2[8]);
	my_tri READ2R9(data_readRegB, r9, read2[9]);
	my_tri READ2R10(data_readRegB, r10, read2[10]);
	my_tri READ2R11(data_readRegB, r11, read2[11]);
	my_tri READ2R12(data_readRegB, r12, read2[12]);
	my_tri READ2R13(data_readRegB, r13, read2[13]);
	my_tri READ2R14(data_readRegB, r14, read2[14]);
	my_tri READ2R15(data_readRegB, r15, read2[15]);
	my_tri READ2R16(data_readRegB, r16, read2[16]);
	my_tri READ2R17(data_readRegB, r17, read2[17]);
	my_tri READ2R18(data_readRegB, r18, read2[18]);
	my_tri READ2R19(data_readRegB, r19, read2[19]);
	my_tri READ2R20(data_readRegB, r20, read2[20]);
	my_tri READ2R21(data_readRegB, r21, read2[21]);
	my_tri READ2R22(data_readRegB, r22, read2[22]);
	my_tri READ2R23(data_readRegB, r23, read2[23]);
	my_tri READ2R24(data_readRegB, r24, read2[24]);
	my_tri READ2R25(data_readRegB, r25, read2[25]);
	my_tri READ2R26(data_readRegB, r26, read2[26]);
	my_tri READ2R27(data_readRegB, r27, read2[27]);
	my_tri READ2R28(data_readRegB, r28, read2[28]);
	my_tri READ2R29(data_readRegB, r29, read2[29]);
	my_tri READ2R30(data_readRegB, r30, read2[30]);
	my_tri READ2R31(data_readRegB, r31, read2[31]);

endmodule
