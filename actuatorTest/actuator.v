module actuator(JC1, JC2, SW1, SW0);
    input SW1, SW0;
    output JC1, JC2;

    assign trig = SW1;
    assign en = SW0;

    assign JC1 = gofd;
    assign JC2 = gobk;

    assign gofd = trig & en;
    assign gobk = (~trig);
endmodule