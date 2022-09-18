`ifndef _defs_sv_
`define _defs_sv_

	localparam T_FILE="A.txt";
	localparam E_FILE="B.txt";
	localparam PI="pi.txt";
	localparam RADIX="%b";
	
	//Multiplications used to determine initial distribution
	localparam MULTIPLICATIONS=10;
	
	//Fixed point representation with Q0.32
	localparam LEFT_DEC_BITS=0;
	localparam RIGHT_DEC_BITS=32;
	localparam DATA_PREC=LEFT_DEC_BITS+RIGHT_DEC_BITS;
	
	localparam HIDDEN_STATES=2;
	localparam OBSERVED_STATES=26;
	
	localparam OBSERVED_LEN=3;
	//1/OBSERVED_LEN in Q0.32
	localparam OBSERVED_LEN_FACTOR=reciprocal();
	
	function logic [DATA_PREC-1:0] multiply(input logic [DATA_PREC-1:0] a,
														 input logic [DATA_PREC-1:0] b);
														 
		logic [DATA_PREC*2-1:0] direct_product;
		begin
		direct_product=a*b;
			return direct_product>>RIGHT_DEC_BITS;
		end
	endfunction
	
	//need to manually update this lookup table if DATA_PREC is changed or need longer sequences
	//I used this online converter:
	//https://www.mathsisfun.com/binary-decimal-hexadecimal-converter.html
	function logic [DATA_PREC-1:0] reciprocal;
		case(OBSERVED_LEN)
			1:return 32'b11111111_11111111_11111111_11111111;
			2:return 32'b10000000_00000000_00000000_00000000;
			3:return 32'b01010101_01010101_01010101_01010101;
			4:return 32'b01000000_00000000_00000000_00000000;
			5:return 32'b00110011_00110011_00110011_00110011;
			6:return 32'b00101010_10101010_10101010_10101010;
			7:return 32'b00100100_10010010_01001001_00100100;
			8:return 32'b00100000_00000000_00000000_00000000;
			9:return 32'b00011100_01110001_11000111_00011100;
			10:return 32'b00011001_10011001_10011001_10011001;
			11:return 32'b00010111_01000101_11010001_01110100;
			12:return 32'b00010101_01010101_01010101_01010101;
			13:return 32'b00010011_10110001_00111011_00010011;
			14:return 32'b00010010_01001001_00100100_10010010;
			15:return 32'b00010001_00010001_00010001_00010001;
			16:return 32'b00010000_00000000_00000000_00000000;
			17:return 32'b00001111_00001111_00001111_00001111;
			18:return 32'b00001110_00111000_11100011_10001110;
			19:return 32'b00001101_01111001_01000011_01011110;
			20:return 32'b00001100_11001100_11001100_11001100;
		endcase
		
	endfunction
	
	//alphabet
	localparam A=0;
	localparam B=1;
	localparam C=2;
	localparam D=3;
	localparam E=4;
	localparam F=5;
	localparam G=6;
	localparam H=7;
	localparam I=8;
	localparam J=9;
	localparam K=10;
	localparam L=11;
	localparam M=12;
	localparam N=13;
	localparam O=14;
	localparam P=15;
	localparam Q=16;
	localparam R=17;
	localparam S=18;
	localparam T=19;
	localparam U=20;
	localparam V=21;
	localparam W=22;
	localparam X=23;
	localparam Y=24;
	localparam Z=25;
	
`endif