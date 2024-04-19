module UScircuit(Mem1, JB1, JB2, CLK50MHZ);
    input CLK50MHZ, JB1; // JB1 is echo pin of sensor
    output[5:0] Mem1;
    output JB2; // JB2 is trigger pin of sensor

    reg trig = 0;
    reg [31:0] trigcounter = 0;
    reg [15:0] distance = 0;
    reg CLK1MHZ = 0;
    reg [31:0] mhz1counter = 0;
    reg [15:0] distanceLock = 10000; // arbitrary non-zero value that fits in 16 bits

    wire [9:0] dummy = 0;

    assign JB2 = trig;
    
    assign {dummy, Mem1} = (distanceLock*340) / 20000; // Mem1 will be a memory address that displays distance in cm

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
        end
        else if ((trigcounter > 10) & (trigcounter < 700000)) begin // big number determines measure cycle (1/1000) miliseconds
            trigcounter <= trigcounter + 1;
            trig <= 0;
        end
        else begin
            trigcounter <= 0;
            distanceLock <= distance;
            distance <= 0;
        end

        if (JB1) begin
            distance <= distance + 1;
        end
    end
endmodule