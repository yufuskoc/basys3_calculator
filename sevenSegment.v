`timescale 1ns / 1ps

module sevenSegment(clk, reset, ones, tens, hundreds, sign, segment, anode, pt);

input clk;
input reset;
input [3:0]ones;
input [3:0]tens;
input [3:0]hundreds;
input [4:0]sign;
output reg [6:0]segment;
output reg [3:0]anode;
output reg pt;
   
parameter ZERO  = 7'b000_0001;
parameter ONE   = 7'b100_1111;
parameter TWO   = 7'b001_0010; 
parameter THREE = 7'b000_0110;
parameter FOUR  = 7'b100_1100;
parameter FIVE  = 7'b010_0100;
parameter SIX   = 7'b010_0000;
parameter SEVEN = 7'b000_1111;
parameter EIGHT = 7'b000_0000;
parameter NINE  = 7'b000_0100;
parameter MINUS = 7'b111_1110;
parameter PLUS = 7'b111_1111;
parameter NO_POINT = 1'b1;
parameter POINT = 1'b0;
    
 reg [1:0] digit_select;
 reg [16:0] digit_timer;

 always @(posedge clk or posedge reset) begin
    if(reset) begin
         digit_select <= 0;
         digit_timer <= 0; 
     end
     else                                       
         if(digit_timer == 99_999) begin         
             digit_timer <= 0;                   
             digit_select <=  digit_select + 1;
         end
         else
             digit_timer <=  digit_timer + 1;
 end
 
 always @(digit_select) begin
     case(digit_select) 
         2'b00 : anode = 4'b1110;
         2'b01 : anode = 4'b1101;
         2'b10 : anode = 4'b1011;
         2'b11 : anode = 4'b0111;
     endcase
 end
 
 always @(*) begin
     case(digit_select)
         2'b00 : begin
                     case(ones)
                         4'b0000 : begin segment = ZERO; pt=NO_POINT; end
                         4'b0001 : begin segment = ONE; pt=NO_POINT; end
                         4'b0010 : begin segment = TWO; pt=NO_POINT; end
                         4'b0011 : begin segment = THREE; pt=NO_POINT; end
                         4'b0100 : begin segment = FOUR; pt=NO_POINT; end
                         4'b0101 : begin segment = FIVE; pt=NO_POINT; end
                         4'b0110 : begin segment = SIX; pt=NO_POINT; end
                         4'b0111 : begin segment = SEVEN; pt=NO_POINT; end
                         4'b1000 : begin segment = EIGHT; pt=NO_POINT; end
                         4'b1001 : begin segment = NINE; pt=NO_POINT; end
                     endcase
                 end
                 
         2'b01 : begin
                     case(tens)
                         4'b0000 : begin segment = ZERO; pt=NO_POINT; end
                         4'b0001 : begin segment = ONE; pt=NO_POINT; end
                         4'b0010 : begin segment = TWO; pt=NO_POINT; end
                         4'b0011 : begin segment = THREE; pt=NO_POINT; end
                         4'b0100 : begin segment = FOUR; pt=NO_POINT; end
                         4'b0101 : begin segment = FIVE; pt=NO_POINT; end
                         4'b0110 : begin segment = SIX; pt=NO_POINT; end
                         4'b0111 : begin segment = SEVEN; pt=NO_POINT; end
                         4'b1000 : begin segment = EIGHT; pt=NO_POINT; end
                         4'b1001 : begin segment = NINE; pt=NO_POINT; end
                     endcase
                 end
                 
         2'b10 : begin
                     case(hundreds)
                         4'b0000 : begin segment = ZERO; pt=POINT; end
                         4'b0001 : begin segment = ONE; pt=POINT; end                         
                         4'b0010 : begin segment = TWO; pt=POINT; end                                                  
                         4'b0011 : begin segment = THREE; pt=POINT; end                                                                           
                         4'b0100 : begin segment = FOUR; pt=POINT; end                                                                           
                         4'b0101 : begin segment = FIVE; pt=POINT; end                         
                         4'b0110 : begin segment = SIX; pt=POINT; end                         
                         4'b0111 : begin segment = SEVEN; pt=POINT; end                         
                         4'b1000 : begin segment = EIGHT; pt=POINT; end                                                  
                         4'b1001 : begin segment = NINE; pt=POINT; end
                     endcase
                 end
                 
         2'b11 : begin
                     case(sign)
                         1'b0 : begin segment = PLUS; pt=NO_POINT; end
                         1'b1 : begin segment = MINUS; pt=NO_POINT; end
                         
                         5'b1_0001 : begin segment = ONE; pt=NO_POINT; end                         
                         4'b0010 : begin segment = TWO; pt=NO_POINT; end                                                  
                         4'b0011 : begin segment = THREE; pt=NO_POINT; end                                                                           
                         4'b0100 : begin segment = FOUR; pt=NO_POINT; end                                                                           
                         4'b0101 : begin segment = FIVE; pt=NO_POINT; end                         
                         4'b0110 : begin segment = SIX; pt=NO_POINT; end                         
                         4'b0111 : begin segment = SEVEN; pt=NO_POINT; end                         
                         4'b1000 : begin segment = EIGHT; pt=NO_POINT; end                                                  
                         4'b1001 : begin segment = NINE; pt=NO_POINT; end
                     endcase
                 end
     endcase
end

endmodule