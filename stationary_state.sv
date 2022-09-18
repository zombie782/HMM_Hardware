`include "defs.sv"

module stationary_state(
	input logic [DATA_PREC-1:0] trans [HIDDEN_STATES-1:0][HIDDEN_STATES-1:0],
	output logic [DATA_PREC-1:0] stationary_distribution [HIDDEN_STATES-1:0]
);
	
	logic [DATA_PREC-1:0] vecs [MULTIPLICATIONS:0][HIDDEN_STATES-1:0];
	
	assign vecs[0][0]=1<<RIGHT_DEC_BITS;
	
	genvar i;
	generate
		for(i=1;i!=HIDDEN_STATES;++i) begin: gen_vecs
			assign vecs[0][i]=0;
		end
	endgenerate
	
	generate
		for(i=0;i!=MULTIPLICATIONS;++i) begin: gen_mult
			vec_mat_mult vmm(.vec(vecs[i]),.mat(trans),.result(vecs[i+1]));
		end
	endgenerate
	
	assign stationary_distribution=vecs[MULTIPLICATIONS];

endmodule 