`include "defs.sv"

module HMM_tb();

	logic [$clog2(OBSERVED_STATES)-1:0] seq [OBSERVED_LEN-1:0]='{D,N,A};
	logic [DATA_PREC-1:0] probability;
	
	HMM dut(.observed_seq(seq),.probability(probability));
	
endmodule 