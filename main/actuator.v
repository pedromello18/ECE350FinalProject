module actuator(gofd, gobk, trig, en);
    input trig, en;
    output gofd, gobk;

    assign gofd = trig & en;
    assign gobk = ~gofd;
endmodule