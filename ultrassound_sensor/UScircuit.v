module UScircuit(LED, JA[2], JA[1], CLK50MHZ);
    input JA[1], CLK50MHZ;
    output[15:0] LED;
    output JA[2];

    reg trig, echo, trigCounter;
    reg [15:0] distance;

    assign trig = JA[2];
    assign echo = JA[1];
    assign clk = CLK50MHZ;

    always @(posedge clk) begin
        trigCounter <= trigCounter + 1;
        if (trigCounter < 500) begin
            trig <= 1;
        end
        else begin 
            trig <= 0;
        end
        if (trigCounter > 500000000) begin
            trigCounter <= 0;
        end
        if (echo) begin
            distance <= distance + 1;
        end
        LED = (distance*340) / 1000000; // LED will be a reg that displays distance in cm
    end
endmodule