`include "defs.sv"

module vec_mat_mult(
	input logic [DATA_PREC-1:0] vec [HIDDEN_STATES-1:0],
	input logic [DATA_PREC-1:0] mat [HIDDEN_STATES-1:0][HIDDEN_STATES-1:0],
	output logic [DATA_PREC-1:0] result [HIDDEN_STATES-1:0]
);

	logic [DATA_PREC-1:0] products [HIDDEN_STATES-1:0][HIDDEN_STATES-1:0];
	
	genvar i,j;
	generate
		for(i=0;i!=HIDDEN_STATES;++i) begin: gen_mult_i
			for(j=0;j!=HIDDEN_STATES;++j) begin: gen_mult_j
				assign products[j][i]=multiply(vec[i],mat[i][j]);	
			end
			assign result[i]=products[i].sum;
		end
	endgenerate
	
	

endmodule 