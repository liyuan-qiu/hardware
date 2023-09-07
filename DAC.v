module DAC(clk,start,DIN_data,SCLK_clkTick,CS,DIN);

input clk,start;//start is to tell the DAC to start sampling
input [11:0] DIN_data;//16bit digital input to be tranformed into analog signal 
output CS,SCLK_clkTick;
output reg DIN;//Data to be trasformed

wire SCLK_clkTick=clk; 



//CS generation&bit transfer
reg CS=1;
reg CS_signal=0;
reg [6:0] CS_cout=0;
reg [15:0]DIN_data16=0;
reg [1:0] CS_start;
always @(posedge clk) 
begin
CS_start<={CS_start[0],start};//when CS_start[0]==1,CS_start[1]==0, the process begin
 if (CS_start[0]&&~CS_start[1])
begin  CS_signal<=1;
	DIN_data16<={4'b1100,DIN_data};
end

if(CS_signal==1)
begin 
CS_cout<=CS_cout+1;
CS<=0;
DIN_data16<=DIN_data16<<1;
DIN<=DIN_data16[15];
end

if (CS_cout==17)
begin 
CS_cout<=0;
CS_signal<=0;
CS<=1;
//DIN_data<=0;
end
end


endmodule