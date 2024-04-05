`timescale 1 ns/100 ps
module cla_tb;
    wire [31:0] A, B, out;
    wire ovf, AleB, AneB, c0;

    assign A = 32'd1;
    assign B = 32'd1;
    assign c0 = 1'b0;

    carry_lookahead_adder TEST(.out(out), .ovf(ovf), .AleB(AleB), .AneB(AneB), .A(A), .B(B), .c0(c0));

    initial begin;
        $display("A: %b\nB: %b\nout: %b\nAneB: %b\nAleB: %b\novf: %b", A, B, out, AneB, AleB, ovf);
    end
    initial begin
        $dumpfile("cla_wave.vcd");
        $dumpvars(0, cla_tb);
    end
endmodule