`timescale 1 ns/100 ps
module adder_cell_tb;
    wire A, B, Cin, S;

    assign A = 1'b1;
    assign B = 1'b1;
    assign Cin = 1'b1;    

    adder_cell TEST(.S(S), .A(A), .B(B), .Cin(Cin));

    initial begin
        #20;
        $display("A: %b\nB: %b\nCin: %b\nS: %b", A, B, Cin, S);
    end
endmodule