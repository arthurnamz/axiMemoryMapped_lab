module adder#(
    parameter DATA_WIDTH = 32,
    parameter ADDR_WIDTH = 8
)
(
    // Global signals
    input s1_axi_aclk,
    input s1_axi_aresetn,

    // Write address channel
    input [ADDR_WIDTH-1:0] s1_axi_awaddr,
    input s1_axi_awvalid,
    output reg s1_axi_awready,

    // Write data channel
    input [DATA_WIDTH-1:0] s1_axi_wdata,
    input [DATA_WIDTH/8:0] s1_axi_wstrb,
    input s1_axi_wvalid,
    output reg s1_axi_wready,

    // Write response channel
    output reg s1_axi_bresp,
    output reg s1_axi_bvalid,
    input s1_axi_bready,

    // Read address channel
    input [ADDR_WIDTH-1:0] s1_axi_araddr,
    input s1_axi_arvalid,
    output reg s1_axi_arready,

    // Read data channel
    output reg [DATA_WIDTH-1:0] s1_axi_rdata,
    output reg s1_axi_rresp,
    output reg s1_axi_rvalid,
    input s1_axi_rready
);
reg [DATA_WIDTH-1:0] operandA, operandB;
reg [(2*DATA_WIDTH-1):0] result_tmp;
wire [DATA_WIDTH-1:0] overflow_adder;

reg receiveOpA, receiveOpB, addingDone;
wire receiveSignal;
assign receiveSignal = receiveOpA & receiveOpB;

//getting data from the master
always@(posedge s1_axi_aclk)
begin
    if(~s1_axi_aresetn) 
    begin
	    s1_axi_awready <= 0;
       s1_axi_wready <= 0;
       receiveOpA <= 0;
       receiveOpB <= 0;
    end
	else if(s1_axi_awvalid == 1 && s1_axi_wvalid == 1 )
	  begin
	     case(s1_axi_awaddr)
		   0:
		     begin
            s1_axi_awready <= 0;
            s1_axi_wready <= 0;
		      operandA <= s1_axi_wdata;
              if (s1_axi_bready == 1) begin
                s1_axi_awready <= 1;
                s1_axi_wready <= 1;
                s1_axi_bresp <= 1;
                s1_axi_bvalid <= 1;
              end

              if(addingDone)
               receiveOpA <= 1;
            else
                receiveOpA <= 0;

			 end  
		   4: 
		     begin
            s1_axi_awready <= 0;
            s1_axi_wready <= 0;
		      operandB <= s1_axi_wdata;
              if (s1_axi_bready == 1 && addingDone) begin
                s1_axi_awready <= 1;
                s1_axi_wready <= 1;
                s1_axi_bresp <= 1;
                s1_axi_bvalid <= 1;
              end
              if(addingDone)
               receiveOpB <= 1;
            else
                receiveOpB <= 0;
			 end 
		   default:
		      begin
			     s1_axi_awready <= 1;
              s1_axi_wready <= 1;
			  end

        endcase
	  end
	else
	  begin
	   s1_axi_bresp <= 0;
      s1_axi_bvalid <= 0;
	  end

end

always@(operandA, operandB)
begin
   if (receiveSignal) begin
         result_tmp <= operandA + operandB;
         s1_axi_arready <= 0;
         addingDone = 0;
   end else begin
      result_tmp <= 'bz;
      s1_axi_arready <= 1;
      addingDone = 1;
   end
end

assign overflow_adder = (result_tmp > (2**DATA_WIDTH)-1)?1:0;   //tri-state assignment


//returning results to the master
always@(posedge s1_axi_aclk)
begin
   if(~s1_axi_aresetn) begin
	   s1_axi_rvalid <= 0;
       s1_axi_rresp <= 0;
       s1_axi_rdata <= 'bz;
   end 
	else if(s1_axi_rready == 1 && s1_axi_arvalid == 1)
      begin
         case(s1_axi_araddr)
            8: begin
                  s1_axi_rvalid <= 1;
                  s1_axi_rresp <= 1;
                  s1_axi_rdata <= result_tmp[31:0];
               end
            12: begin
                  s1_axi_rvalid <= 1;
                  s1_axi_rresp <= 1;
                  s1_axi_rdata <= overflow_adder;
               end
            default: begin
                  s1_axi_rdata <= 'bz; 
                  s1_axi_rvalid <= 0;
                  s1_axi_rresp <= 0;
                  s1_axi_arready <= 1;
               end
         endcase
      end
   else
	  begin
      //   s1_axi_arready <= 1;
	     s1_axi_rdata <= 'bz; 
	  end
   
end

endmodule