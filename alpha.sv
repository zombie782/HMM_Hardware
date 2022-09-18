`include "defs.sv"

module gen_alpha(
	input logic [$clog2(OBSERVED_STATES)-1:0] observed_seq [OBSERVED_LEN-1:0],
	input logic [DATA_PREC-1:0] trans [HIDDEN_STATES-1:0][HIDDEN_STATES-1:0],
	input logic [DATA_PREC-1:0] emm [HIDDEN_STATES-1:0][OBSERVED_STATES-1:0],
	input logic [DATA_PREC-1:0] stationary_distribution [HIDDEN_STATES-1:0],
	output logic [DATA_PREC-1:0] alphas [OBSERVED_LEN-1:0][HIDDEN_STATES-1:0]
);

	genvar i,j;
	generate
		for(i=0;i!=OBSERVED_LEN;++i) begin: gen_alpha_layers //alphai(Xj)
			for(j=0;j!=HIDDEN_STATES;++j) begin: gen_alphas
				assign alphas[i][j]=calculate_alpha(i,j,stationary_distribution);
			end
		end
	endgenerate
	
	function automatic logic [DATA_PREC-1:0] calculate_alpha(input integer i,
																				input integer j,
																				const ref logic [DATA_PREC-1:0] stationary_distribution [HIDDEN_STATES-1:0]);
		
		logic [DATA_PREC-1:0] probability_products [HIDDEN_STATES-1:0];
		
		if(i==0) begin
			return multiply(stationary_distribution[j],emm[j][observed_seq[i]]);
		end
		else begin
			for(integer k=0;k!=HIDDEN_STATES;++k) begin
				probability_products[k]=multiply(alphas[i-1][k],multiply(trans[k][j],emm[j][observed_seq[i]]));
			end
			return probability_products.sum;
		end
		
	endfunction
	
endmodule 