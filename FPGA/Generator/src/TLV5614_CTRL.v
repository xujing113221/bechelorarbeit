module TLV5614_CTRL(
		  input CLK,
		  input RST_n,
		  input CH1_TrSgn,
		  input CH2_TrSgn,
		  input CH3_TrSgn,
		  input CH4_TrSgn,
		  input[15:0] CH1_Data,
		  input[15:0] CH2_Data,
		  input[15:0] CH3_Data,
		  input[15:0] CH4_Data,
		  
//		  output[15:0] test_data,		///testbench
		  output UpdateDone,
		  output DAC_CLK,
		  output DAC_DIN,
		  output DAC_FS,
		  output DAC_CS,
		  output DAC_LDAC,
		  output DAC_PD
			);

	reg dac_work;
	reg[1:0] chn;
	reg[15:0] CTRL_Word,ch1_data,ch2_data,ch3_data,ch4_data;
	
	initial begin
		ch1_data = 16'hffff;
		ch2_data = 16'hffff;
		ch3_data = 16'hffff;
		ch4_data = 16'hffff;
		end
	
	always@(posedge CH1_TrSgn)
		ch1_data <= CH1_Data;
	
	always@(posedge CH2_TrSgn)
		ch2_data <= CH2_Data;
	
	always@(posedge CH3_TrSgn)
		ch3_data <= CH3_Data;
	
	always@(posedge CH4_TrSgn)
		ch4_data <= CH4_Data;
	
	reg[15:0] cnt;
	always @(posedge CLK or negedge RST_n)
		if(!RST_n)
			cnt <= 16'b0;
		else if(cnt == 25000)
			cnt <= 16'b0;
		else	
			cnt <= cnt + 1'b1;


   reg[9:0] dac_cnt;  
	reg updatedone, dac_clk, dac_din, dac_fs, dac_cs, dac_ldac;
	always@(posedge CLK or negedge RST_n)begin
		if(!RST_n)begin
			dac_clk<=1'b0;
			dac_din<=1'b0;
			dac_fs<=1'b1;
			dac_cs<=1'b1;
			updatedone<=1'b0;
			dac_ldac<=1'b1;
			dac_cnt <= 9'b0;
			end
		else if(cnt == 20000)begin
			CTRL_Word <= ch1_data;
			chn <= 2'b00;
			dac_work <= 1'b1;
			end			
		else if(dac_work == 1)begin	
			case(dac_cnt)
			0:begin
				dac_clk<=1'b0;
				dac_din<=1'b0;
				dac_fs<=1'b1;
				updatedone<=1'b0;
				dac_ldac<=1'b1;
				dac_cnt<=dac_cnt+1'b1;
			  end
			1:begin
				dac_cs<=1'b0;
				dac_ldac<=1'b0;
				dac_cnt<=dac_cnt+1'b1;
				end
			2:begin
				dac_clk<=1'b1;
				dac_din<=CTRL_Word[15];
				dac_fs<=1'b0;
				dac_cs<=1'b0;
				dac_cnt<=dac_cnt+1'b1;
			  end
			3:begin
				dac_clk<=1'b0;
				dac_cnt<=dac_cnt+1'b1;
				end
			4:begin
				dac_clk<=1'b1;
				dac_din<=CTRL_Word[14];
				dac_cnt<=dac_cnt+1'b1;
			  end
			5:begin
				dac_clk<=1'b0;
				dac_cnt<=dac_cnt+1'b1;
				end
			6:begin
				dac_clk<=1'b1;
				dac_din<=CTRL_Word[13];
				dac_cnt<=dac_cnt+1'b1;
			  end
			7:begin
				dac_clk<=1'b0;
				dac_cnt<=dac_cnt+1'b1;
				end
			8:begin
				dac_clk<=1'b1;
				dac_din<=CTRL_Word[12];
				dac_cnt<=dac_cnt+1'b1;
			  end
			9:begin 
				dac_clk<=1'b0;
				dac_cnt<=dac_cnt+1'b1;
				end
			10:begin
				dac_clk<=1'b1;
				dac_din<=CTRL_Word[11];
				dac_cnt<=dac_cnt+1'b1;
			  end
			11:begin
				dac_clk<=1'b0;
				dac_cnt<=dac_cnt+1'b1;
				end
			12:begin
				dac_clk<=1'b1;
				dac_din<=CTRL_Word[10];
				dac_cnt<=dac_cnt+1'b1;
			  end
			13:begin
				dac_clk<=1'b0;
				dac_cnt<=dac_cnt+1'b1;
				end
			14:begin
				dac_clk<=1'b1;
				dac_din<=CTRL_Word[9];
				dac_cnt<=dac_cnt+1'b1;
			  end
			15:begin 
				dac_clk<=1'b0;
				dac_cnt<=dac_cnt+1'b1;
				end
			16:begin
				dac_clk<=1'b1;
				dac_din<=CTRL_Word[8];
				dac_cnt<=dac_cnt+1'b1;
			  end
			17:begin
				dac_clk<=1'b0;
				dac_cnt<=dac_cnt+1'b1;
				end
			18:begin
				dac_clk<=1'b1;
				dac_din<=CTRL_Word[7];
				dac_cnt<=dac_cnt+1'b1;
			  end
			19:begin 
				dac_clk<=1'b0;
				dac_cnt<=dac_cnt+1'b1;
				end
			20:begin
				dac_clk<=1'b1;
				dac_din<=CTRL_Word[6];
				dac_cnt<=dac_cnt+1'b1;
			  end
			21:begin
				dac_clk<=1'b0;
				dac_cnt<=dac_cnt+1'b1;
				end
			22:begin
				dac_clk<=1'b1;
				dac_din<=CTRL_Word[5];
				dac_cnt<=dac_cnt+1'b1;
			  end
			23:begin
				dac_clk<=1'b0;
				dac_cnt<=dac_cnt+1'b1;
				end
			24:begin
				dac_clk<=1'b1;
				dac_din<=CTRL_Word[4];
				dac_cnt<=dac_cnt+1'b1;
			  end
			25:begin
				dac_clk<=1'b0;
				dac_cnt<=dac_cnt+1'b1;
				end
			26:begin
				dac_clk<=1'b1;
				dac_din<=CTRL_Word[3];
				dac_cnt<=dac_cnt+1'b1;
			  end
			27:begin
				dac_clk<=1'b0;
				dac_cnt<=dac_cnt+1'b1;
				end
			28:begin
				dac_clk<=1'b1;
				dac_din<=CTRL_Word[2];
				dac_cnt<=dac_cnt+1'b1;
			  end
			29:begin
				dac_clk<=1'b0;
				dac_cnt<=dac_cnt+1'b1;
				end
			30:begin
				dac_clk<=1'b1;
				dac_din<=CTRL_Word[1];
				dac_cnt<=dac_cnt+1'b1;
			  end
			31:begin
				dac_clk<=1'b0;
				dac_cnt<=dac_cnt+1'b1;
				end
			32:begin
				dac_clk<=1'b1;
				dac_din<=CTRL_Word[0];
				dac_cnt<=dac_cnt+1'b1;
			  end
			33:begin
				dac_clk<=1'b0;	
				dac_cnt<=dac_cnt+1'b1;
				end
			34:begin
				dac_clk<=1'b1;
				dac_din<=1'b0;
				dac_cnt<=dac_cnt+1'b1;
				end
			35:begin
				dac_clk<=1'b0;
				dac_cnt<=dac_cnt+1'b1;
				end
			36:begin
				dac_clk<=1'b1;
				dac_ldac<=1'b1;
				dac_cnt<=dac_cnt+1'b1;
			end
			37:begin
				dac_clk<=1'b0;
				dac_fs<=1'b1;
				dac_cnt<=dac_cnt+1'b1;
				end
			38:begin
				dac_cs<=1'b1;
				dac_clk<=1'b0;
				dac_cnt<=dac_cnt+1'b1;
				end
			39:begin
				updatedone<=1'b1;
				dac_cnt<=dac_cnt+1'b1;
				end
			40:begin
				dac_cnt <= 9'b0;
				case(chn)
					2'b00:begin
								CTRL_Word <= ch2_data;
								chn <= 2'b01;
							end
					2'b01:begin
								CTRL_Word <= ch3_data;
								chn <= 2'b10;
							end
					2'b10:begin
								CTRL_Word <= ch4_data;
								chn <= 2'b11;
							end
					2'b11:begin
								dac_work <= 1'b0;
							end
					endcase
				end
			default:;
			endcase
		end
		end
	
	assign UpdateDone = updatedone;
	assign DAC_PD = 1'b1;
	assign DAC_CLK = dac_clk;
	assign DAC_DIN = dac_din;
	assign DAC_FS  = dac_fs;
	assign DAC_CS  = dac_cs;
	assign DAC_LDAC = dac_ldac;
//	assign test_data = CTRL_Word;
	
endmodule