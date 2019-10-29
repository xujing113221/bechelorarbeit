//--------------------Module_RST_Ctrl------------------------//
module RST_Ctrl(
	input FPGA_CLK,	//输入板载晶振FPGA_CLK,25M
	output RST_n			//输出全局复位信号
	);
//--------------------RST_n----------------------------------//
	reg [3:0] cnt_rst = 4'd0;
	
	always @(posedge FPGA_CLK)
		if (cnt_rst == 4'd10)
			cnt_rst <= 4'd10;
		else
			cnt_rst <= cnt_rst + 1'd1;

	assign RST_n = (cnt_rst == 4'd10);//复位信号,10个周期后RST_n为1

//--------------------Endmodule------------------------------//
endmodule