`timescale 1ns / 1ps

module sinus(clk, reset, number, sign, ones, tens, hundreds);

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
    
    if(number>=0 && number<63) begin
        sign<=1'b0;
        result<=(((number)*100*31415/1800000)-(((number)*100*31415/1800000)**3/60000)+(((number)*100*31415/1800000)**5/120/100000/1000));
        ones<=result%10;
        tens<=result/10;
        hundreds<=0;  
    end else if(number == 63)begin
        sign<=1'b0;
        ones<=9;
        tens<=8;
        hundreds<=0;
    end else if(number == 64)begin
        sign<=1'b0;
        ones<=0;
        tens<=9;
        hundreds<=0;
    end else if(number == 65)begin
        sign<=1'b0;
        ones<=1;
        tens<=9;
        hundreds<=0;
    end else if(number == 66)begin
        sign<=1'b0;
        ones<=1;
        tens<=9;
        hundreds<=0;
    end else if(number == 67)begin
        sign<=1'b0;
        ones<=2;
        tens<=9;
        hundreds<=0;
    end else if(number == 68)begin
        sign<=1'b0;
        ones<=3;
        tens<=9;
        hundreds<=0;
    end else if(number == 69)begin
        sign<=1'b0;
        ones<=3;
        tens<=9;
        hundreds<=0;
    end else if(number == 70)begin
        sign<=1'b0;
        ones<=4;
        tens<=9;
        hundreds<=0;
    end else if(number == 71)begin
        sign<=1'b0;
        ones<=5;
        tens<=9;
        hundreds<=0;
    end else if(number == 72)begin
        sign<=1'b0;
        ones<=5;
        tens<=9;
        hundreds<=0;
    end else if(number == 73)begin
        sign<=1'b0;
        ones<=6;
        tens<=9;
        hundreds<=0;
    end else if(number == 74)begin
        sign<=1'b0;
        ones<=6;
        tens<=9;
        hundreds<=0;
    end else if(number == 75)begin
        sign<=1'b0;
        ones<=7;
        tens<=9;
        hundreds<=0;
    end else if(number == 76)begin
        sign<=1'b0;
        ones<=7;
        tens<=9;
        hundreds<=0;
    end else if(number == 77)begin
        sign<=1'b0;
        ones<=7;
        tens<=9;
        hundreds<=0;
    end else if(number == 78)begin
        sign<=1'b0;
        ones<=8;
        tens<=9;
        hundreds<=0;
    end else if(number == 79)begin
        sign<=1'b0;
        ones<=8;
        tens<=9;
        hundreds<=0;
    end else if(number == 80)begin
        sign<=1'b0;
        ones<=8;
        tens<=9;
        hundreds<=0;
    end else if(number>=81 && number<85) begin
        sign<=1'b0;
        ones<=9;
        tens<=9;
        hundreds<=0;
    end else if(number>=85 && number<=90) begin
        sign<=1'b0;
        ones<=0;
        tens<=0;
        hundreds<=1;
    end else if(number>90 && number<95) begin
        sign<=1'b0;
        ones<=0;
        tens<=0;
        hundreds<=1;
    end else if(number>=95 && number<99) begin
        sign<=1'b0;
        ones<=9;
        tens<=9;
        hundreds<=0;
    end else if(number>=99 && number<180) begin
        r_number<=180-number;
        sign<=1'b0;
        result<=(((r_number)*100*31415/1800000)-(((r_number)*100*31415/1800000)**3/60000)+(((r_number)*100*31415/1800000)**5/120/100000/1000));
        ones<=result%10;
        tens<=result/10;
        hundreds<=0;
    end else if(number>=180 && number<262) begin
        r_number<=number-180;
        sign<=1'b1;
        result<=(((r_number)*100*31415/1800000)-(((r_number)*100*31415/1800000)**3/60000)+(((r_number)*100*31415/1800000)**5/120/100000/1000));
        ones<=result%10;
        tens<=result/10;
        hundreds<=0;
    end else if(number>=262 && number<265) begin
        sign<=1'b1;
        ones<=9;
        tens<=9;
        hundreds<=0;
    end else if(number>=265 && number<=270) begin
        sign<=1'b1;
        ones<=0;
        tens<=0;
        hundreds<=1;
    end else if(number>270 && number<275) begin
        sign<=1'b1;
        ones<=0;
        tens<=0;
        hundreds<=1;
    end else if(number>=275 && number<279) begin
        sign<=1'b1;
        ones<=9;
        tens<=9;
        hundreds<=0;
    end else if(number>=279 && number<=360) begin
        r_number<=360-number;
        sign<=1'b1;
        result<=(((r_number)*100*31415/1800000)-(((r_number)*100*31415/1800000)**3/60000)+(((r_number)*100*31415/1800000)**5/120/100000/1000));
        ones<=result%10;
        tens<=result/10;
        hundreds<=0;
    end        
end

endmodule