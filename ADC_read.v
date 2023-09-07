module ADC_read(clk,ADC_DOUT,SCLK_clkTick1,ADC_CS,ADC_DIN,SCLK_clkTick2,DAC_CS,DAC_DIN
,test201,test203,test214,test217
);

output test201,test203,test214,test217;
//generate the sample start signal for ADC 
wire ADC_start;
wire SCLK_clkTick;
CLK_generation sclk_generation(.clk0(clk),.clk1(SCLK_clkTick),.stop_num(2));
CLK_generation sample_generation(.clk0(SCLK_clkTick),.clk1(ADC_start),.stop_num(32));
//wire test201=ADC_DOUT;
//wire test203=ADC_start;
//wire test214=SCLK_clkTick1;
//wire test217=ADC_DOUT;
/*ADC读入电压，最大3.3V*/
input clk;
input ADC_DOUT;
output ADC_DIN,SCLK_clkTick1,ADC_CS;
wire [11:0]DOUT_data;//为什么不能用reg[11:0] DOUT_data
ADC ADC_input(.clk(SCLK_clkTick),.start(ADC_start),.DOUT(ADC_DOUT),.SCLK_clkTick(SCLK_clkTick1),.CS(ADC_CS),.DOUT_data(DOUT_data),.DIN(ADC_DIN));

/*做PID电路*/
wire [11:0] PID_out;
wire PID_CS;
PID PID1 (.u_out(PID_out), .y_in(DOUT_data), .clk(SCLK_clkTick), .start(ADC_CS), .PID_CS(PID_CS));

output SCLK_clkTick2,DAC_CS,DAC_DIN;
DAC DAC_output(.clk(SCLK_clkTick),.start(PID_CS),.DIN_data(PID_out),.SCLK_clkTick(SCLK_clkTick2),.CS(DAC_CS),.DIN(DAC_DIN));
//
///*ADC跟随DAC输出，最大2.55V*/
//ADC DOUT_data tranfers to DAC DIN_data, and the ADC_CS acts as the DAC sample start signal
//
//output SCLK_clkTick2,DAC_CS,DAC_DIN;
//DAC DAC_output(.clk(SCLK_clkTick),.start(ADC_CS),.DIN_data(DOUT_data),.SCLK_clkTick(SCLK_clkTick2),.CS(DAC_CS),.DIN(DAC_DIN));

/*test电路部分*/
wire test201=SCLK_clkTick;
wire test203=ADC_CS;
wire test214=DAC_CS;
wire test217=DAC_DIN;

endmodule