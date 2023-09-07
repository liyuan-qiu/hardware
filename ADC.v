module ADC(clk,start,DOUT,SCLK_clkTick,CS,DOUT_data,DIN

);
input clk,start;//start is to tell the ADC start sampling 
input DOUT;
output CS,SCLK_clkTick;
output reg[11:0] DOUT_data=0;
output DIN=0;
//----- sclk_clk generation
parameter ClkFrequency=50000000;//FPGA CLK frequency 50MHz=27'b***********************************
parameter SCLK_clk=12500000;// ADC frequency<16MHz
parameter SCLK_clkGeneratorAccWidth = 16;
wire SCLK_clkTick=clk; 


//--------CS generation&bit transfer------------
reg CS=1;
reg CS_signal=0;
reg [6:0] CS_cout=0;
reg [15:0]DOUT_data16=0;
//reg [11:0] DOUT_data=0;
reg [1:0]CS_start;
always @(posedge clk) 
begin
CS_start<={CS_start[0],start};
 if (CS_start[0]&&~CS_start[1])
 CS_signal<=1;

if(CS_signal==1)
begin 
CS_cout<=CS_cout+1;
CS<=0;
DOUT_data16<={DOUT_data16[15:0],DOUT};
end

if (CS_cout==17)
begin 
CS_cout<=0;
CS_signal<=0;
CS<=1;
DOUT_data<=DOUT_data16[11:0];
end
end

//output wire test1=DOUT;
//output wire test2=CS;
endmodule