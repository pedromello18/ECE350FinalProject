module adder_cell(S, A, B, Cin);
    input A, B, Cin;
    output S;
    xor CALC(S, A, B, Cin); 
endmodule