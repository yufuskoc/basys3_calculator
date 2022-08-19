`timescale 1ns / 1ps

module receiver(clk, reset, RxD, data);

input clk;
input reset; 
input RxD;
output [7:0]data;

reg shift;
reg state, nextstate;
reg [3:0]bitcounter;
reg [1:0]samplecounter;
reg [13:0]counter;
reg [9:0]rxshiftreg;
reg clear_bitcounter, inc_bitcounter, inc_samplecounter, clear_samplecounter;

initial begin
    rxshiftreg[1] = 1'b0;
    rxshiftreg[2] = 1'b0;
    rxshiftreg[3] = 1'b0;
    rxshiftreg[4] = 1'b0;
    rxshiftreg[5] = 1'b0;
    rxshiftreg[6] = 1'b0;
    rxshiftreg[7] = 1'b0;
    rxshiftreg[8] = 1'b0;
end

parameter clk_freq = 100_000_000;
parameter baud_rate = 9_600;
parameter div_sample = 4;
parameter div_counter = clk_freq/(baud_rate*div_sample);
parameter mid_sample = (div_sample/2);
parameter div_bit = 10;

assign data = (reset==1'b0) ? rxshiftreg[8:1] : 8'b0000_0000;

always @(posedge clk) begin 
        if(reset) begin 
            state<=0;
            bitcounter<=0;
            counter<=0;
            samplecounter<=0;
            rxshiftreg[8:1]<=8'b0000_0000;
        end else begin
            counter<=counter+1;
            if(counter>=div_counter-1) begin
                counter<=0;
                state<=nextstate;
                if(shift) rxshiftreg<={RxD, rxshiftreg[9:1]};
                if(clear_samplecounter) samplecounter<=0;
                if(inc_samplecounter) samplecounter<=samplecounter+1; 
                if(clear_bitcounter) bitcounter<=0;
                if(inc_bitcounter) bitcounter<=bitcounter+1;
            end
        end
end
   
always @(posedge clk) begin 
    shift<=0;
    clear_samplecounter<=0;
    inc_samplecounter<=0;
    clear_bitcounter<=0; 
    inc_bitcounter<=0; 
    nextstate<=0;
    case (state)
        0: begin
            if(RxD) begin
              nextstate<=0;
              end
            else begin
                nextstate<=1;
                clear_bitcounter<=1;
                clear_samplecounter<=1;
            end
        end
        1: begin
            nextstate<= 1;
            if(samplecounter== mid_sample - 1) shift<=1;
                if(samplecounter== div_sample - 1) begin
                    if(bitcounter == div_bit - 1) begin
                nextstate<=0;
                end 
                inc_bitcounter<=1;
                clear_samplecounter<=1; 
            end else inc_samplecounter<=1;
        end
       default: nextstate<=0;
     endcase
end
   
endmodule