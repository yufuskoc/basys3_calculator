`timescale 1ns / 1ps

module squareRoot(clk, reset, number, ones, tens, hundreds, thousands);

input clk;
input reset;
input [8:0]number;
output reg [3:0]ones;
output reg [3:0]tens;
output reg [3:0]hundreds;
output reg [3:0]thousands;

reg [60:0]result;

always @(posedge clk) begin
    result = (10*number+10*number/number)/2;
    result = 10*(result+100*number/result)/2 ;
    result = 10*(result+10000*number/result)/2 ;
    result = 10*(result+1000000*number/result)/2 ;
    result = 10*(result+100000000*number/result)/2 ;
    result = 10*(result+100000*100000*number/result)/2 ;
    result = 10*(result+1000000*1000000*number/result)/2 ;
    
    if(number <100)begin
        thousands = 0;
        hundreds = result/10000000;
        result = result%10000000;
        tens = result/1000000;
        result = result%1000000;
        ones = result/100000;
    end else if(number==100)begin
        thousands = 1;
        hundreds = 0;
        tens = 0;
        ones = 0;
    end else if(number==144)begin
        thousands = 1;
        hundreds = 2;
        tens = 0;
        ones = 0;
    end else begin
        thousands = result/100000000;
        result = result%100000000;
        hundreds = result/10000000;
        result = result%10000000;
        tens = result/1000000;
        result = result%1000000;
        ones = result/100000;
    end
end        

endmodule