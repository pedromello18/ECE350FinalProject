module UScircuit(LED, JA1, JB1, CLK50MHZ);
    input CLK50MHZ, JA1;
    output[15:0] LED;
    output JB1;

    reg trig, echo, trigCounter;
    reg [31:0] distance;
    wire clk;
    
    initial trig = 0;
    initial echo = 0;
    initial trigCounter = 0;
    initial distance = 0;

    assign JB1 = trig;
    assign clk = CLK50MHZ;
    
    assign LED = (distance*340) / 1000000; // LED will be a reg that displays distance in cm

    always @(posedge clk) begin
        echo <= JA1;
        trigCounter <= trigCounter + 1;
        if (trigCounter < 500) begin
            trig <= 1;
        end else begin
            trig <= 0;
        end
        if (trigCounter > 50000000) begin
            trigCounter <= 0;
        end
        if (echo) begin
            distance <= distance + 1;
        end
    end
endmodule