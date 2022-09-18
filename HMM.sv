`include "defs.sv"

module HMM(
	input logic [$clog2(OBSERVED_STATES)-1:0] observed_seq [OBSERVED_LEN-1:0],
	output logic [DATA_PREC-1:0] probability
);

	logic [DATA_PREC-1:0] trans [HIDDEN_STATES-1:0][HIDDEN_STATES-1:0];
	logic [DATA_PREC-1:0] emm [HIDDEN_STATES-1:0][OBSERVED_STATES-1:0];
	logic [DATA_PREC-1:0] stationary_distribution [HIDDEN_STATES-1:0];
	logic [DATA_PREC-1:0] alphas [OBSERVED_LEN-1:0][HIDDEN_STATES-1:0];
	
	logic [DATA_PREC-1:0] pre_probability;
	
	//stationary_state ss(.trans(trans),.stationary_distribution(stationary_distribution));
	gen_alpha ga(.observed_seq(observed_seq),.trans(trans),.emm(emm),.stationary_distribution(stationary_distribution),.alphas(alphas));
	
	assign pre_probability=alphas[OBSERVED_LEN-1].sum;
	assign probability=multiply(alphas[OBSERVED_LEN-1].sum,OBSERVED_LEN_FACTOR);
	
	//synthesis translate_off
	initial begin
		
		integer i,j,fd;
		
		$readmemb(PI,stationary_distribution);
		
		begin
			fd=$fopen(T_FILE,"r");
			for(i=0;i!=HIDDEN_STATES;++i) begin
				for (j=0;j!=HIDDEN_STATES;++j) begin
					$fscanf(fd,RADIX,trans[i][j]);
				end
			end
			$fclose(fd);
			
			fd=$fopen(E_FILE,"r");
			for(i=0;i!=HIDDEN_STATES;++i) begin
				for (j=0;j!=OBSERVED_STATES;++j) begin
					$fscanf(fd,RADIX,emm[i][j]);
				end
			end
			$fclose(fd);
			
		end
	end
	//synthesis translate_on
		
endmodule 