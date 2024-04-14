module UScircuit(LED, JA1, JB1, CLK50MHZ);
    input CLK50MHZ, JA1; // JA1 is echo pin of sensor
    output[15:0] LED;
    output JB1;

    reg trig = 0;
    reg [31:0] trigcounter = 0;
    reg [15:0] distance = 0;
    reg CLK1MHZ = 0;
    reg [31:0] mhz1counter = 0;

    assign JB1 = trig;
    
    assign LED = (distance*340) / 20000; // LED will be a reg that displays distance in cm

    always @(posedge CLK50MHZ) begin
        if (mhz1counter < 50) begin 
            mhz1counter <= mhz1counter + 1;
        end else begin
            mhz1counter <= 0;
            CLK1MHZ <= ~CLK1MHZ;
        end
    end

    always @(posedge CLK1MHZ) begin
        if (trigcounter <= 10) begin 
            trigcounter <= trigcounter + 1;
            trig <= 1;
            distance <= 0;
        end
        else if ((trigcounter > 10) & (trigcounter < 2000000)) begin
            trigcounter <= trigcounter + 1;
            trig <= 0;
        end
        else begin
            trigcounter <= 0;
        end

        if (JA1) begin
            distance <= distance + 1;
        end
    end

endmodule