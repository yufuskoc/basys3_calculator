`timescale 1ns / 1ps

module cosinus(clk, reset, number, sign, ones, tens, hundreds);

input clk;
input reset;
input [8:0]number;
output reg sign;
output reg [3:0]ones;
output reg [3:0]tens;
output reg [3:0]hundreds;

reg [8:0]r_number;
reg [6:0]result;

always @(posedge clk) begin
    if(reset) begin
        sign<=0;
        result<=0;
    end 
    
    if(number>=0 && number<5) begin
        sign<=1'b0;
        ones<=0;
        tens<=0;
        hundreds<=1;
    end else if(number>=5 && number<8) begin
        sign<=1'b0;
        ones<=9;
        tens<=9;
        hundreds<=0;
    end else if(number>=8 && number<=90) begin
        sign<=1'b0;
        result<=100-((number)*100*31415/1800000)**2/200+(((number)*100*31415/1800000)**4/24000000)-(((number)*100*31415/1800000)**6/720/100000/100000);
        ones<=result%10;
        tens<=result/10;
        hundreds<=0;
    end else if(number>90 && number<172) begin
        r_number=180-number;
        sign<=1'b1;
        result<=100-((r_number)*100*31415/1800000)**2/200+(((r_number)*100*31415/1800000)**4/24000000)-(((r_number)*100*31415/1800000)**6/720/100000/100000);
        ones<=result%10;
        tens<=result/10;
        hundreds<=0;
    end else if(number>=172 && number<175) begin
        sign<=1'b1;
        ones<=9;
        tens<=9;
        hundreds<=0;
    end else if(number>=175 && number<180) begin
        sign<=1'b1;
        ones<=0;
        tens<=0;
        hundreds<=1;
    end else if(number>=180 && number<185) begin
        sign<=1'b1;
        ones<=0;
        tens<=0;
        hundreds<=1;
    end else if(number>=185 && number<188) begin
        sign<=1'b1;
        ones<=9;
        tens<=9;
        hundreds<=0;
    end else if(number>=188 && number<=270) begin
        r_number=number-180;
        sign<=1'b1;
        result<=100-((r_number)*100*31415/1800000)**2/200+(((r_number)*100*31415/1800000)**4/24000000)-(((r_number)*100*31415/1800000)**6/720/100000/100000);
        ones<=result%10;
        tens<=result/10;
        hundreds<=0;
    end else if(number>270 && number<352) begin
        r_number=360-number;
        sign<=1'b0;
        result<=100-((r_number)*100*31415/1800000)**2/200+(((r_number)*100*31415/1800000)**4/24000000)-(((r_number)*100*31415/1800000)**6/720/100000/100000);
        ones<=result%10;
        tens<=result/10;
        hundreds<=0;
    end else if(number>=352 && number<355) begin
        sign<=1'b0;
        ones<=9;
        tens<=9;
        hundreds<=0;
    end else if(number>=355 && number<=360) begin
        sign<=1'b0;
        ones<=0;
        tens<=0;
        hundreds<=1;
    end       
end

endmodule