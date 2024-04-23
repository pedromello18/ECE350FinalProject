`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 04/22/2024 09:56:09 PM
// Design Name:
// Module Name: ToneGenerator
// Project Name:
// Target Devices:
// Tool Versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////
//    always @(posedge CLK100HZ) begin // other direction
//        if (motorEnable) begin
//            if (rotationDirectionChange) begin
//                case(iterCounter)
//                        3'b000 : ctrl = 4'b0100;
//                        3'b001 : ctrl = 4'b0110;
//                        3'b010 : ctrl = 4'b0010;
//                        3'b011 : ctrl = 4'b1010;
//                        3'b100 : ctrl = 4'b1000;
//                        3'b101 : ctrl = 4'b1001;
//                        3'b110 : ctrl = 4'b0001;
//                        3'b111 : ctrl = 4'b0101;
//                endcase

module ToneGenerator(
    input clk,
    // input [1:0] soundEn, // Case for start, score, end, and high score
    output reg audioOut,      // PWM signal to the audio jack     
    output audioEn,
    input [1:0] switches
    // input [1:0] switches
    );
    localparam MHz = 1000000;
      localparam SYSTEM_FREQ = 100*MHz; // System clock frequency
      localparam CLOCK_FREQ = 50000000; // Clock frequency of 50 MHz

    // Array to hold frequencies for ease of access
    reg [31:0] startSeq[7:0] = {Cs5, z, Cs5, z, Cs5, z, Gs5, Gs5}; //good
    reg [31:0] endSeq[7:0] = {Gs4, z, C5, z, Ds5, z, z, z};
    reg [31:0] highScoreSeq[7:0] = {Fs6, Cs6, z, Cs6, Ds5, Cs6, F6, Fs6}; //good
    reg [31:0] scoreSeq[7:0] = {Fs6, Cs6, Gs4, z, z, z, z, z};
    // = {Gs4, z, C5, z, Ds5, z, z, z};
    //old end = {Fs6, Fs6, z, Cs6, Cs6, z, Gs4, Gs4};

   
    //reg [31:0] frequencies [0:6]; = {A, B, C_SHARP, D, E, F_SHARP, G_SHARP};
    reg [2:0] note_index = 0;  // Index to cycle through notes
    reg [31:0] frequency; // = A; // Current note audioEn
   
//    // CHOOSING SEQUENCE
//    always @(posedge clk) begin
//        // select
//        case (switches)
//            2'b00: frequency = startSeq[note_index];
//            2'b01: frequency = scoreSeq[note_index];
//            2'b10: frequency = highScoreSeq[note_index];
//            2'b11: frequency = endSeq[note_index];
//            default = frequency = startSeq[note_index];
//        endcase
   
    // Timing control
    reg [31:0] note_duration_counter = 0;  // Counter for note duration
    localparam NOTE_DURATION = 25_000_000; // One second at 50 MHz clock

    assign audioEn = 1'b1;  // Enable Audio Output
   
     // Frequencies in Hertz
    localparam  Cs5 = 554, Gs5 = 830, Fs6 = 740, Cs6 = 554, Gs4 = 415, C5 = 523, Ds5 = 622, F6 = 698, z = 0;
    //localparam A = 440, B = 493, C_SHARP = 554, D = 587, E = 659, F_SHARP = 740, G_SHARP = 830;
 

    // PWM generation
    reg [31:0] pwm_counter = 0; // PWM frequency counter
    reg pwm = 0;

    // Main logic block
    always @(posedge clk) begin
   
            // select case here
        case (switches)
            2'b00: frequency = startSeq[note_index];
            2'b01: frequency = scoreSeq[note_index];
            2'b10: frequency = highScoreSeq[note_index];
            2'b11: frequency = endSeq[note_index];
            default: frequency = startSeq[note_index];
        endcase
       
        // PWM control for current frequency
        pwm_counter <= pwm_counter + 1;
        if(pwm_counter >= (CLOCK_FREQ / frequency / 2)) begin
            pwm_counter <= 0;
            pwm <= ~pwm;
        end
        audioOut <= pwm;
        // Note duration control
        note_duration_counter <= note_duration_counter + 1;
        if(note_duration_counter >= NOTE_DURATION) begin
            note_duration_counter <= 0;  // Reset note duration counter
            note_index <= note_index + 1; // Move to next note
            if(note_index > 7) begin
                note_index <= 0; // Loop back to the first note
            end
            //frequency <= frequency[note_index]; // Update the frequency
        end
    end
endmodule