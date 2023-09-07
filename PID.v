module PID #(parameter W=12) // bit width – 1
(output  [W:0] u_out, // output
input  [W:0] y_in, // input
input clk,
//input reset,
input start
,output reg PID_CS);

parameter k1=2; // change these values to suit your system
parameter k2 =0;
parameter k3 = 0;
parameter setpoint=12'b110000011111;
//ADC分辨率3.3/2^12*1000=8.05664mV，如果要光强要稳定在2V的样子的话，2V/0.622559mV=2482，转换为二进制就是setpoint数值了
//DAC分辨率(3.3 - 0.75)/2^12*1000=0.622559mV，如果AOM要稳定在0.8V的样子的话，0.8V/0.622559mV=1285，转换为二进制就是setpoint数值了
reg  [W:0] y[1:2];
reg  [W:0] u_prev;
reg  [W:0] e_prev[1:2];
reg  [W:0] e_in;
reg  [W:0] u_out_reg;

//reg signed [W+4:0] y4[1:2];
//reg signed [W+4:0] u_prev4;
//reg signed [W+4:0] e_prev41:2];
//reg signed [W+4:0] e_in4;
//reg signed [W+4:0] u_out_reg4;

//assign u_out = u_prev+k1*e_in-k2*e_prev[1]+k3*e_prev[2];
reg [1:0]start_signal;
reg PID_signal=0;
reg [10:0]PID_count=0;

always @ (posedge clk)
begin
	start_signal<={start_signal[0],start};
	if(~start_signal[1]&&start_signal[0])
	begin PID_signal<=1;
	e_prev[2] <= e_prev[1];
	e_prev[1] <= e_in;
	u_prev <= u_out_reg;
	y[2]<=y[1];
	y[1]<=y_in;
	e_in<=setpoint-y[1];
	u_out_reg<=e_in/5-k2*e_prev[1]+k3*e_prev[2];	
	end
	
/*产生PID_CS信号作为下一个子程序的start*/
	if (PID_signal==1)
	begin
	PID_count<=PID_count+1;
	PID_CS<=0;
	end

	if (PID_count==6)
	begin
	PID_signal<=0;
	PID_count<=0;
	PID_CS<=1;
	end
	//end

end
assign u_out=u_out_reg;
endmodule