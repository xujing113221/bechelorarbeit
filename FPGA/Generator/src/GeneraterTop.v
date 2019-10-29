module GeneraterTop(CLK,
						DAC_CLK,
						DAC_DIN,
						DAC_FS,
						DAC_CS,
						DAC_LDAC,
						DAC_PD,
						Addr,
						DataByte,
						WR_n,
						RD_n,
						CS_n,
						);
input CLK;
input[7:0] Addr;
inout[15:0] DataByte;
input WR_n;
input RD_n;
input CS_n;
output DAC_CLK;
output DAC_DIN;
output DAC_FS;
output DAC_CS;
output DAC_LDAC;
output DAC_PD;

wire RST_n;
wire UpdateDone;
wire [15:0] DAC_Data;

wire[7:0] CH1_Wave;
wire[7:0] CH1_Amp;
wire[7:0] CH1_Freq;
wire[7:0] CH1_Duty;
wire[7:0] CH2_Wave;
wire[7:0] CH2_Amp;
wire[7:0] CH2_Freq;
wire[7:0] CH2_Duty;
wire[7:0] CH3_Wave;
wire[7:0] CH3_Amp;
wire[7:0] CH3_Freq;
wire[7:0] CH3_Duty;
wire[7:0] CH4_Wave;
wire[7:0] CH4_Amp;
wire[7:0] CH4_Freq;
wire[7:0] CH4_Duty;

wire CH1_TrSgn,CH2_TrSgn,CH3_TrSgn,CH4_TrSgn;
wire[15:0] CH1_Data,CH2_Data,CH3_Data,CH4_Data;

/* ouptput Reset Signal */
RST_Ctrl	res_ctrl(
		.FPGA_CLK(CLK),
		.RST_n(RST_n)
		);	
	
		
FSMC_CTRL fsmc(
		.CLK(CLK),
		.RST_n(RST_n),
		.Addr(Addr),
		.DataByte(DataByte),
		.WR_n(WR_n),
		.RD_n(RD_n),
		.CS_n(CS_n),
	
		.CH1_Wave(CH1_Wave),
		.CH1_Amp(CH1_Amp),
		.CH1_Freq(CH1_Freq),
		.CH1_Duty(CH1_Duty),
		.CH2_Wave(CH2_Wave),
		.CH2_Amp(CH2_Amp),
		.CH2_Freq(CH2_Freq),
		.CH2_Duty(CH2_Duty),
		.CH3_Wave(CH3_Wave),
		.CH3_Amp(CH3_Amp),
		.CH3_Freq(CH3_Freq),
		.CH3_Duty(CH3_Duty),
		.CH4_Wave(CH4_Wave),
		.CH4_Amp(CH4_Amp),
		.CH4_Freq(CH4_Freq),
		.CH4_Duty(CH4_Duty)
		);	

TLV5614_CTRL dac(
		.CLK(CLK),
		.RST_n(RST_n),
		.CH1_TrSgn(CH1_TrSgn),
		.CH2_TrSgn(CH2_TrSgn),
		.CH3_TrSgn(CH3_TrSgn),
		.CH4_TrSgn(CH4_TrSgn),
		.CH1_Data(CH1_Data),
		.CH2_Data(CH2_Data),
		.CH3_Data(CH3_Data),
		.CH4_Data(CH4_Data),
		
		.UpdateDone(UpdateDone),
		.DAC_CLK(DAC_CLK),
		.DAC_DIN(DAC_DIN),
		.DAC_FS(DAC_FS),
		.DAC_CS(DAC_CS),
		.DAC_LDAC(DAC_LDAC),
		.DAC_PD(DAC_PD)
		);	
	
/* channal 1 */
WaveController ch1_ctrl(
		.CLK(CLK),
		.RST_n(RST_n),
		.Channel(2'b00),	
		.Waveform(CH1_Wave),
		.AmpX10(CH1_Amp),
		.Freq(CH1_Freq),	
		.Duty(CH1_Duty),		
		.BusySgn(UpdateDone),
		.DAC_Data(CH1_Data),
		.TriggerSign(CH1_TrSgn)
		);
		
/* channal 2 */
WaveController ch2_ctrl(
		.CLK(CLK),
		.RST_n(RST_n),
		.Channel(2'b01),	
		.Waveform(CH2_Wave),
		.AmpX10(CH2_Amp),
		.Freq(CH2_Freq),	
		.Duty(CH2_Duty),		
		.BusySgn(UpdateDone),
		.DAC_Data(CH2_Data),
		.TriggerSign(CH2_TrSgn)
		);
		
/* channal 3 */
WaveController ch3_ctrl(
		.CLK(CLK),
		.RST_n(RST_n),
		.Channel(2'b10),	
		.Waveform(CH3_Wave),
		.AmpX10(CH3_Amp),
		.Freq(CH3_Freq),	
		.Duty(CH3_Duty),		
		.BusySgn(UpdateDone),
		.DAC_Data(CH3_Data),
		.TriggerSign(CH3_TrSgn)
		);
		
/* channal 4 */
WaveController ch4_ctrl(
		.CLK(CLK),
		.RST_n(RST_n),
		.Channel(2'b11),	
		.Waveform(CH4_Wave),
		.AmpX10(CH4_Amp),
		.Freq(CH4_Freq),	
		.Duty(CH4_Duty),		
		.BusySgn(UpdateDone),
		.DAC_Data(CH4_Data),
		.TriggerSign(CH4_TrSgn)
		);
		
endmodule