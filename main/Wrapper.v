`timescale 1ns / 1ps
/**
 * 
 * READ THIS DESCRIPTION:
 *
 * This is the Wrapper module that will serve as the header file combining your processor, 
 * RegFile and Memory elements together.
 *
 * This file will be used to generate the bitstream to upload to the FPGA.
 * We have provided a sibling file, Wrapper_tb.v so that you can test your processor's functionality.
 * 
 * We will be using our own separate Wrapper_tb.v to test your code. You are allowed to make changes to the Wrapper files 
 * for your own individual testing, but we expect your final processor.v and memory modules to work with the 
 * provided Wrapper interface.
 * 
 * Refer to Lab 5 documents for detailed instructions on how to interface 
 * with the memory elements. Each imem and dmem modules will take 12-bit 
 * addresses and will allow for storing of 32-bit values at each address. 
 * Each memory module should receive a single clock. At which edges, is 
 * purely a design choice (and thereby up to you). 
 * 
 * You must change line 36 to add the memory file of the test you created using the assembler
 * For example, you would add sample inside of the quotes on line 38 after assembling sample.s
 *
 **/

module Wrapper (CLK50MHZ, SW0, SW1, JA1, JA2, JA3, JA4, CA, CB, CC, CD, CE, CF, CG, AN, JB1, JB2, JC1, LED, JD1, JD2, JD3, JD4, JD7, JD8, JD9, audioEn, audioOut);
	input CLK50MHZ, SW0, SW1, JB1;
	output JA1, JA2, JA3, JA4, CA, CB, CC, CD, CE, CF, CG, JB2, JC1, JD1, JD2, JD3, JD4, JD7, JD8, JD9, audioEn, audioOut;
	output [7:0] AN;
	output [15:0] LED;
	
	wire clock, reset;
	assign clock = CLK50MHZ;
	assign reset = 1'b0;
	assign LED = {10'b0, distance};

	wire rwe, mwe;
	wire[4:0] rd, rs1, rs2;
	wire[5:0] distance;
	wire[31:0] instAddr, instData, 
		rData, regA, regB,
		memAddr, memDataIn, memDataOut, reg29, reg28, reg27, reg26, reg25, reg23, reg22, reg20;


	// ADD YOUR MEMORY FILE HERE
	localparam INSTR_FILE = "loop";
	
	// Main Processing Unit
	processor CPU(.clock(clock), .reset(reset), 
								
		// ROM
		.address_imem(instAddr), .q_imem(instData),
									
		// Regfile
		.ctrl_writeEnable(rwe),     .ctrl_writeReg(rd),
		.ctrl_readRegA(rs1),     .ctrl_readRegB(rs2), 
		.data_writeReg(rData), .data_readRegA(regA), .data_readRegB(regB),
									
		// RAM
		.wren(mwe), .address_dmem(memAddr), 
		.data(memDataIn), .q_dmem(memDataOut)); 
	
	// Instruction Memory (ROM)
	ROM #(.MEMFILE({INSTR_FILE, ".mem"}))
	InstMem(.clk(clock), 
		.addr(instAddr[11:0]), 
		.dataOut(instData));
	
	// Register File
	regfile RegisterFile(.clock(clock), 
		.ctrl_writeEnable(rwe), .ctrl_reset(reset), 
		.ctrl_writeReg(rd),
		.ctrl_readRegA(rs1), .ctrl_readRegB(rs2), 
		.data_writeReg(rData), .data_readRegA(regA), .data_readRegB(regB), .reg29(reg29), .reg28(reg28), .reg27(reg27), .reg26(reg26), .reg25(reg25), .reg23(reg23), .reg22(reg22), .reg20(reg20));
						
	// Processor Memory (RAM)
	RAM ProcMem(.clk(clock), 
		.wEn(mwe), 
		.addr(memAddr[11:0]), 
		.dataIn(memDataIn), 
		.dataOut(memDataOut),
		.newGame(SW0),
		.distance(distance),
		.goActuator(SW1));

	// Stepper Control (Theta)
	steppers STEPPER_CTRL(JA1, JA2, JA3, JA4, CLK50MHZ, reg25[1], reg25[0]);

	// FPGA 7-seg Control
	FPGA7seg LED_CTRL(CA, CB, CC, CD, CE, CF, CG, AN, reg28, reg27, reg26, CLK50MHZ);

	// Ultrasonic Sensor
	UScircuit SENSOR_CTRL(distance, JB1, JB2, CLK50MHZ);

	// Actuator Control
	assign JC1 = reg23[0];

	// LED Control
	assign JD1 = reg22[0];
	assign JD2 = reg22[1];
	assign JD3 = reg22[2];
	assign JD4 = reg22[3];

	// Audio Control
	ToneGenerator AUDIO_CTRL(CLK50MHZ, audioOut, audioEn, reg20[2:0]);

endmodule
