`timescale 1ns / 1ps

module main(clk, reset, RxD, segment, anode, pt);

input clk;
input reset;
input RxD;
output [6:0]segment;
output [3:0]anode;
output pt;

reg [3:0]r_ones = 4'b0000;
reg [3:0]r_tens = 4'b0000;
reg [3:0]r_hundreds = 4'b0000;
reg [1:0]r_type = 2'b00;

reg [1:0]status = 2'b00;

reg hundreds_assigned = 1'b0;
reg tens_assigned = 1'b0;
reg ones_assigned = 1'b0;
reg type_assigned = 1'b0;
reg threeFlag = 1'b0;

reg [8:0]sinusNumber;
reg [8:0]cosinusNumber;
reg [8:0]squareRootNumber;
reg [8:0]primeNumber;

wire sinusSign;
wire [3:0]sinusOnes;
wire [3:0]sinusTens;
wire [3:0]sinusHundreds;

wire cosinusSign;
wire [3:0]cosinusOnes;
wire [3:0]cosinusTens;
wire [3:0]cosinusHundreds;

wire [3:0]squareRootOnes;
wire [3:0]squareRootTens;
wire [3:0]squareRootHundreds;
wire [3:0]squareRootThousands;

wire primeResult;

reg [4:0]segmentSign;
reg [3:0]segmentOnes;
reg [3:0]segmentTens;
reg [3:0]segmentHundreds;

reg [7:0]mem;
wire [7:0]w_data;

receiver receiver(
    .clk(clk),
    .reset(reset),
    .RxD(RxD),
    .data(w_data)
);

sinus sinus(
    .clk(clk),
    .reset(reset),
    .number(sinusNumber),
    .sign(sinusSign),
    .ones(sinusOnes),
    .tens(sinusTens),
    .hundreds(sinusHundreds)
);

cosinus cosinus(
    .clk(clk),
    .reset(reset),
    .number(cosinusNumber),
    .sign(cosinusSign),
    .ones(cosinusOnes),
    .tens(cosinusTens),
    .hundreds(cosinusHundreds)
);

squareRoot squareRoot(
    .clk(clk),
    .reset(reset),
    .number(squareRootNumber),
    .ones(squareRootOnes),
    .tens(squareRootTens),
    .hundreds(squareRootHundreds),
    .thousands(squareRootThousands)
);

prime prime(
    .clk(clk),
    .reset(reset),
    .number(primeNumber),
    .result(primeResult)
);

sevenSegment seg7(
    .clk(clk),
    .reset(reset),
    .ones(segmentOnes), 
    .tens(segmentTens),
    .hundreds(segmentHundreds),
    .sign(segmentSign),
    .segment(segment),
    .anode(anode),
    .pt(pt)
);

always @(posedge clk) begin
    if(reset) begin
        status<=2'b00;
        r_ones<=4'b0000;
        r_tens<=4'b0000;
        r_hundreds<=4'b0000;
        r_type<=5'b0_0000;
        hundreds_assigned<=1'b0;
        tens_assigned<=1'b0;
        ones_assigned<=1'b0;
        type_assigned<=1'b0;
        segmentSign<=1'b0;
        segmentOnes<=4'b0000;
        segmentTens<=4'b0000;
        segmentHundreds<=4'b0000;
        mem <= 8'b0000_0000;
    end
    
    if(status == 2'b00 && hundreds_assigned == 1'b0) begin
        mem <= w_data;
        
        if(w_data == 8'b00111001) begin r_hundreds <= 9; hundreds_assigned <= 1'b1; status<=status+1; end
        else if(w_data == 8'b00111000) begin r_hundreds <= 8; hundreds_assigned <= 1'b1; status<=status+1; end
        else if(w_data == 8'b00110111) begin r_hundreds <= 7; hundreds_assigned <= 1'b1; status<=status+1; end
        else if(w_data == 8'b00110110) begin r_hundreds <= 6; hundreds_assigned <= 1'b1; status<=status+1; end
        else if(w_data == 8'b00110101) begin r_hundreds <= 5; hundreds_assigned <= 1'b1; status<=status+1; end
        else if(w_data == 8'b00110100) begin r_hundreds <= 4; hundreds_assigned <= 1'b1; status<=status+1; end
        else if(w_data == 8'b00110100) begin r_hundreds <= 3; hundreds_assigned <= 1'b1; status<=status+1; end
        else if(w_data == 8'b00110010) begin r_hundreds <= 2; hundreds_assigned <= 1'b1; status<=status+1; end
        else if(w_data == 8'b00110001) begin r_hundreds <= 1; hundreds_assigned <= 1'b1; status<=status+1; end
        else if(w_data == 8'b00110000) begin r_hundreds <= 0; hundreds_assigned <= 1'b1; status<=status+1; end
        else begin r_hundreds <= 0; status<=2'b00; hundreds_assigned <= 1'b0; end
        
    end if(r_hundreds == 0 && r_tens == 3 && threeFlag == 1'b0) begin
        r_hundreds <= 3;
        hundreds_assigned <= 1'b1;
        r_tens <= 0;
        status <= 2'b01;
        tens_assigned <= 1'b0;
        threeFlag <= 1'b1;
                
    end if(r_hundreds == 4 && r_tens == 3) begin
        r_hundreds <= 3;
        hundreds_assigned <= 1'b1;
        r_tens <= 0;
        status <= 2'b01;
        tens_assigned <= 1'b0;
           
    end if(status == 2'b01 && hundreds_assigned == 1'b1 && mem != w_data) begin
        mem <= w_data;
        
        if(w_data == 8'b00111001) begin r_tens <= 9; tens_assigned <= 1'b1; status<=status+1; end
        else if(w_data == 8'b00111000) begin r_tens <= 8; tens_assigned <= 1'b1; status<=status+1; end
        else if(w_data == 8'b00110111) begin r_tens <= 7; tens_assigned <= 1'b1; status<=status+1; end
        else if(w_data == 8'b00110110) begin r_tens <= 6; tens_assigned <= 1'b1; status<=status+1; end
        else if(w_data == 8'b00110101) begin r_tens <= 5; tens_assigned <= 1'b1; status<=status+1; end
        else if(w_data == 8'b00110100) begin r_tens <= 4; tens_assigned <= 1'b1; status<=status+1; end
        else if(w_data == 8'b00110011) begin r_tens <= 3; tens_assigned <= 1'b1; status<=status+1; end
        else if(w_data == 8'b00110010) begin r_tens <= 2; tens_assigned <= 1'b1; status<=status+1; end
        else if(w_data == 8'b00110001) begin r_tens <= 1; tens_assigned <= 1'b1; status<=status+1; end
        else if(w_data == 8'b00110000) begin r_tens <= 0; tens_assigned <= 1'b1; status<=status+1; end
        else begin r_tens <= 0; status<=2'b01; tens_assigned <= 1'b0; end
        
    end if(r_tens == 4 && r_ones == 3) begin
        r_tens <= 3;
        tens_assigned <= 1'b1;
        r_ones <= 0;
        status <= 2'b10;
        ones_assigned <= 1'b0;
               
    end if(status == 2'b10 && tens_assigned == 1'b1 && mem != w_data) begin
        mem <= w_data;
    
        if(w_data == 8'b00111001) begin r_ones <= 9; ones_assigned <= 1'b1; status<=status+1; end
        else if(w_data == 8'b00111000) begin r_ones <= 8; ones_assigned <= 1'b1; status<=status+1; end
        else if(w_data == 8'b00110111) begin r_ones <= 7; ones_assigned <= 1'b1; status<=status+1; end
        else if(w_data == 8'b00110110) begin r_ones <= 6; ones_assigned <= 1'b1; status<=status+1; end
        else if(w_data == 8'b00110101) begin r_ones <= 5; ones_assigned <= 1'b1; status<=status+1; end
        else if(w_data == 8'b00110100) begin r_ones <= 4; ones_assigned <= 1'b1; status<=status+1; end
        else if(w_data == 8'b00110011) begin r_ones <= 3; ones_assigned <= 1'b1; status<=status+1; end
        else if(w_data == 8'b00110010) begin r_ones <= 2; ones_assigned <= 1'b1; status<=status+1; end
        else if(w_data == 8'b00110001) begin r_ones <= 1; ones_assigned <= 1'b1; status<=status+1; end
        else if(w_data == 8'b00110000) begin r_ones <= 0; ones_assigned <= 1'b1; status<=status+1; end
        else begin r_ones <= 0; status<=2'b10; ones_assigned <= 1'b0; end
             
    end if(r_ones == 4 && r_type == 3) begin
        r_ones <= 3;
        ones_assigned <= 1'b1;
        r_type <= 0;
        status <= 2'b11;
        type_assigned <= 1'b0;
               
    end if(status == 2'b11 && ones_assigned == 1'b1 && mem != w_data) begin
        mem <= w_data;
        
        if(w_data == 8'b01110011) begin r_type <= 0; type_assigned <= 1'b1; status<=0; end
        else if(w_data == 8'b01100011) begin r_type <= 1; type_assigned <= 1'b1; status<=0; end
        else if(w_data == 8'b01110010) begin r_type <= 2; type_assigned <= 1'b1; status<=0; end
        else if(w_data == 8'b01100001) begin r_type <= 3; type_assigned <= 1'b1; status<=0; end
        else begin r_type <= 3; status<=2'b11; type_assigned <= 1'b0; end
     
    end
    
    if(r_type == 0 && type_assigned == 1'b1) begin
        sinusNumber <= r_hundreds*100+r_tens*10+r_ones*1;
        segmentSign <= sinusSign;
        segmentOnes <= sinusOnes;
        segmentTens <= sinusTens;
        segmentHundreds <= sinusHundreds;
    end else if(r_type == 1 && type_assigned == 1'b1) begin
        cosinusNumber <= r_hundreds*100+r_tens*10+r_ones*1;
        segmentSign <= cosinusSign;
        segmentOnes <= cosinusOnes;
        segmentTens <= cosinusTens;
        segmentHundreds <= cosinusHundreds; 
    end else if(r_type == 2 && type_assigned == 1'b1) begin
        squareRootNumber <= r_hundreds*100+r_tens*10+r_ones*1;
        
        if(squareRootNumber<100) begin 
            segmentSign <= 0; 
            segmentHundreds <= squareRootHundreds;
            segmentTens <= squareRootTens;
            segmentOnes <= squareRootOnes;
        end else if(squareRootNumber>=100) begin 
            segmentSign <= {1, squareRootThousands};
            segmentHundreds <= squareRootHundreds;
            segmentTens <= squareRootTens;
            segmentOnes <= squareRootOnes; 
        end
    end else if(r_type == 3 && type_assigned == 1'b1) begin
        primeNumber <= r_hundreds*100+r_tens*10+r_ones*1;
        segmentSign <= 0;
        segmentOnes <= 0;
        segmentTens <= 0;
        segmentHundreds <= primeResult;
    end
    
end

endmodule