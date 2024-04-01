module multdiv(
	data_operandA, data_operandB, 
	ctrl_MULT, ctrl_DIV, 
	clock, 
	data_result, data_exception, data_resultRDY);

    input [31:0] data_operandA, data_operandB;
    input ctrl_MULT, ctrl_DIV, clock;

    output [31:0] data_result;
    output data_exception, data_resultRDY;

    wire [31:0] multResult, divResult;
    wire multOverflow, multReady, divException, divReady, currentlyMult;

    multModBooths multUnit(multResult, multReady, multOverflow, data_operandA, data_operandB, clock, ctrl_MULT); // Needs to change when DIV is done

    nonRestDiv divUnit(divResult, divReady, divException, data_operandA, data_operandB, clock, ctrl_DIV);

    dffe_ref multOp(currentlyMult, ctrl_MULT, clock, ctrl_MULT, ctrl_DIV);

    assign data_result = currentlyMult ? multResult : divResult;
    assign data_resultRDY = currentlyMult ? multReady : divReady;
    assign data_exception = currentlyMult ? multOverflow : divException;
endmodule