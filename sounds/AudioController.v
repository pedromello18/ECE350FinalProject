
module AudioController (

    input clk,                 // System clock, assuming a 50MHz clock frequency

    output reg speaker         // Speaker output

);

 

    // Define frequency for each note in the A major scale

    // Frequencies in Hertz

    localparam A = 440, B = 493, C_SHARP = 554, D = 587, E = 659, F_SHARP = 740, G_SHARP = 830;

    localparam CLOCK_FREQ = 50000000; // Clock frequency of 50 MHz


    // Array to hold frequencies for ease of access
    reg [31:0] frequencies [0:6] = {A, B, C_SHARP, D, E, F_SHARP, G_SHARP};
    reg [2:0] note_index = 0;  // Index to cycle through notes
    reg [31:0] frequency = A; // Current note frequency


    // Timing control
    reg [31:0] note_duration_counter = 0;  // Counter for note duration
    localparam NOTE_DURATION = 50_000_000; // One second at 50 MHz clock

 

    // PWM generation
    reg [31:0] pwm_counter = 0; // PWM frequency counter
    reg pwm = 0;

    // Main logic block
    always @(posedge clk) begin
        // PWM control for current frequency
        pwm_counter <= pwm_counter + 1;
        if(pwm_counter >= (CLOCK_FREQ / frequency / 2)) begin
            pwm_counter <= 0;
            pwm <= ~pwm;
        end
        speaker <= pwm;
        // Note duration control
        note_duration_counter <= note_duration_counter + 1;
        if(note_duration_counter >= NOTE_DURATION) begin
            note_duration_counter <= 0;  // Reset note duration counter
            note_index <= note_index + 1; // Move to next note
            if(note_index > 6) begin
                note_index <= 0; // Loop back to the first note
            end
            frequency <= frequencies[note_index]; // Update the frequency
        end
    end

endmodule