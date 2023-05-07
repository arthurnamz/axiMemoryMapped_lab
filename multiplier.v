module adder#(
    parameter DATA_WIDTH = 32,
    parameter ADDR_WIDTH = 8
)
(
    // Global signals
    input s2_axi_aclk,
    input s2_axi_aresetn,

    // Write address channel
    input [ADDR_WIDTH-1:0] s2_axi_awaddr,
    input s2_axi_awvalid,
    output reg s2_axi_awready,

    // Write data channel
    input [DATA_WIDTH-1:0] s2_axi_wdata,
    input [DATA_WIDTH/8:0] s2_axi_wstrb,
    input s2_axi_wvalid,
    output reg s2_axi_wready,

    // Write response channel
    output reg s2_axi_bresp,
    output reg s2_axi_bvalid,
    input s2_axi_bready,

    // Read address channel
    input [ADDR_WIDTH-1:0] s2_axi_araddr,
    input s2_axi_arvalid,
    output reg s2_axi_arready,

    // Read data channel
    output reg [DATA_WIDTH-1:0] s2_axi_rdata,
    output reg s2_axi_rresp,
    output reg s2_axi_rvalid,
    input s2_axi_rready
);
reg [DATA_WIDTH-1:0] operandA, operandB;
reg [(2*DATA_WIDTH-1):0] result_tmp;
wire [DATA_WIDTH-1:0] overflow_adder;

//getting data from the master
always@(posedge s2_axi_aclk)
begin
    if(~s2_axi_aresetn) 
    begin
	   s2_axi_awready <= 0;
       s2_axi_wready <= 0;
    end
	else if(s2_axi_awvalid == 1 && s2_axi_wvalid == 1 )
	  begin
	     case(s2_axi_awaddr)
		   0:
		     begin
		      operandA <= s2_axi_wdata;
              if (s2_axi_bready == 1) begin
                s2_axi_bresp <= 1;
                s2_axi_bvalid <= 1;
              end

			 end  
		   4: 
		     begin
		      operandB <= s2_axi_wdata;
              if (s2_axi_bready == 1) begin
                s2_axi_bresp <= 1;
                s2_axi_bvalid <= 1;
              end
			 end 
		   default:
		      begin
			     s2_axi_awready <= 1;
                 s2_axi_wready <= 1;
			  end

      endcase
	  
	  end
	else
	  begin
	     s2_axi_bresp <= 0;
         s2_axi_bvalid <= 0;
	  end

end

always@(operandA, operandB)
begin
  result_tmp <= operandA + operandB;
end

assign overflow_adder = (result_tmp > (2**DATA_WIDTH)-1)?1:0;   //tri-state assignment


//returning results to the master
always@(posedge s2_axi_aclk)
begin
   if(~s2_axi_aresetn) begin
	   s2_axi_rvalid <= 0;
       s2_axi_rresp <= 0;
   end 
	else if(s2_axi_rready == 1 && s2_axi_arvalid == 1)
   begin
      case(s2_axi_araddr)
	     8: begin
		    s2_axi_rdata <= result_tmp[31:0];
            s2_axi_rvalid <= 1;
            s2_axi_rresp <= 1;
         end
		 12: begin
		    s2_axi_rdata <= overflow_adder;
            s2_axi_rvalid <= 1;
            s2_axi_rresp <= 1;
         end
	     default: begin
            s2_axi_rdata <= 'bz;  
            s2_axi_arready <= 1;
         end
      endcase
   end
   else
	  begin
	     s2_axi_rdata <= 'bz; 
         s2_axi_arready <= 1;
	  end
   
end

endmodule