module CLK_generation(clk0,clk1,stop_num);
input clk0;
output reg clk1;
reg [30:0] cout=0;
input [30:0] stop_num;

always@(posedge clk0)
begin
cout<=cout+1;
if(cout==stop_num)
begin
	cout<=0;
clk1<=~clk1;
end
end
endmodule
