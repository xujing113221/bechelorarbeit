module FSMC_CTRL(
	CLK,
	RST_n,
	Addr,
	DataByte,
	WR_n,
	RD_n,
	CS_n,
	
	CH1_Wave,
	CH1_Amp,
	CH1_Freq,
	CH1_Duty,
	CH2_Wave,
	CH2_Amp,
	CH2_Freq,
	CH2_Duty,
	CH3_Wave,
	CH3_Amp,
	CH3_Freq,
	CH3_Duty,
	CH4_Wave,
	CH4_Amp,
	CH4_Freq,
	CH4_Duty
	);
	
	input CLK;
	input RST_n;
	input[7:0] Addr;
	inout[15:0] DataByte;
	input WR_n;
	input RD_n;
	input CS_n;
	
	output [7:0] CH1_Wave;
	output [7:0] CH1_Amp;
	output [7:0] CH1_Freq;
	output [7:0] CH1_Duty;
	output [7:0] CH2_Wave;
	output [7:0] CH2_Amp;
	output [7:0] CH2_Freq;
	output [7:0] CH2_Duty;
	output [7:0] CH3_Wave;
	output [7:0] CH3_Amp;
	output [7:0] CH3_Freq;
	output [7:0] CH3_Duty;
	output [7:0] CH4_Wave;
	output [7:0] CH4_Amp;
	output [7:0] CH4_Freq;
	output [7:0] CH4_Duty;
	
	wire RD,WR;
	assign RD = (CS_n | RD_n);
	assign WR = (CS_n | WR_n);
	
	wire [15:0]DataByte_OUT;
	assign DataByte = !RD ? DataByte_OUT : 16'hzzzz;
	
	wire[7:0] RAM_Addr;
	reg[7:0] addr;
	assign RAM_Addr = (CS_n) ? addr : Addr;
	
	/*PLL config*/
	wire PLL_100M;
	PLL pll(
				.inclk0(CLK),
				.c0(PLL_100M)
				);	
	/*RAM config*/
	FSMC_RAM   ram(							
			.address(RAM_Addr),
			.clock(PLL_100M),
			.data(DataByte),
			.wren(!WR),
			.rden(WR),
			.q(DataByte_OUT)
			);
	
	
	reg[7:0] ch1_wave, ch1_amp, ch1_freq, ch1_duty;
	reg[7:0] ch2_wave, ch2_amp, ch2_freq, ch2_duty;
	reg[7:0] ch3_wave, ch3_amp, ch3_freq, ch3_duty;
	reg[7:0] ch4_wave, ch4_amp, ch4_freq, ch4_duty;
	
	reg clk_100khz;
	reg[15:0] cnt_clk;
	always@(posedge CLK or negedge RST_n)
		if(!RST_n)begin
			clk_100khz  <= 1'b0;
			cnt_clk <= 16'b0;
			end
		else if(cnt_clk == 125-1) begin
			cnt_clk <= 16'b0;
			clk_100khz <= ~clk_100khz;
			end
		else 
			cnt_clk <= cnt_clk + 1'b1;
		
	
	always@(posedge clk_100khz or negedge RST_n)
		if(!RST_n)begin
			ch1_wave <= 8'b0;
			ch1_amp	<= 8'b0;
			ch1_freq <= 8'b0;
			ch1_duty <= 8'b0;
			ch2_wave <= 8'b0;
			ch2_amp	<= 8'b0;
			ch2_freq <= 8'b0;
			ch2_duty <= 8'b0;
			ch3_wave <= 8'b0;
			ch3_amp	<= 8'b0;
			ch3_freq <= 8'b0;
			ch3_duty <= 8'b0;
			ch4_wave <= 8'b0;
			ch4_amp	<= 8'b0;
			ch4_freq <= 8'b0;
			ch4_duty <= 8'b0;
			addr <= 8'b0;
			end
		else begin
			case(addr)
			0:begin
				if(DataByte_OUT[7:0] != ch1_wave)
					ch1_wave = DataByte_OUT[7:0];
				end
			1:begin
				if(DataByte_OUT[7:0] != ch1_amp)
					ch1_amp	= DataByte_OUT[7:0];
				end
			2:begin
				if(DataByte_OUT[7:0] != ch1_freq)
					ch1_freq = DataByte_OUT[7:0];
				end
			3:begin
				if(DataByte_OUT[7:0] != ch1_duty)
					ch1_duty = DataByte_OUT[7:0];
				end
			4:begin
				if(DataByte_OUT[7:0] != ch2_wave)
					ch2_wave = DataByte_OUT[7:0];
				end
			5:begin
				if(DataByte_OUT[7:0] != ch2_amp)
					ch2_amp	 = DataByte_OUT[7:0];
				end
			6:begin
				if(DataByte_OUT[7:0] != ch2_freq)
					ch2_freq = DataByte_OUT[7:0];
				end
			7:begin
				if(DataByte_OUT[7:0] != ch2_duty)
					ch2_duty = DataByte_OUT[7:0];
				end
			8:begin
				if(DataByte_OUT[7:0] != ch3_wave)
					ch3_wave = DataByte_OUT[7:0];
				end
			9:begin
				if(DataByte_OUT[7:0] != ch3_amp)
					ch3_amp	 = DataByte_OUT[7:0];
				end
			10:begin
				if(DataByte_OUT[7:0] != ch3_freq)
					ch3_freq = DataByte_OUT[7:0];
				end
			11:begin
				if(DataByte_OUT[7:0] != ch3_duty)
					ch3_duty = DataByte_OUT[7:0];
				end
			12:begin
				if(DataByte_OUT[7:0] != ch4_wave)
					ch4_wave = DataByte_OUT[7:0];
				end
			13:begin
				if(DataByte_OUT[7:0] != ch4_amp)
					ch4_amp	 = DataByte_OUT[7:0];
				end
			14:begin
				if(DataByte_OUT[7:0] != ch4_freq)
					ch4_freq = DataByte_OUT[7:0];
				end
			15:begin
				if(DataByte_OUT[7:0] != ch4_duty)
					ch4_duty = DataByte_OUT[7:0];
				end	
			default: addr = 8'hff;
			endcase
			addr = addr + 8'b1;
			end
			
	assign CH1_Wave = ch1_wave;
	assign CH1_Amp  = ch1_amp ;
	assign CH1_Freq = ch1_freq;
	assign CH1_Duty = ch1_duty;
	assign CH2_Wave = ch2_wave;
	assign CH2_Amp  = ch2_amp ;
	assign CH2_Freq = ch2_freq;
	assign CH2_Duty = ch2_duty;
	assign CH3_Wave = ch3_wave;
	assign CH3_Amp  = ch3_amp ;
	assign CH3_Freq = ch3_freq;
	assign CH3_Duty = ch3_duty;
	assign CH4_Wave = ch4_wave;
	assign CH4_Amp  = ch4_amp ;
	assign CH4_Freq = ch4_freq;
	assign CH4_Duty = ch4_duty;
	
endmodule
