module adder#(
    parameter MEM_SIZE = 32,
    parameter DATA_WIDTH = 32,
    parameter ADDR_WIDTH = 8
)
(
    // Global signals
    input s0_axi_aclk,
    input s0_axi_aresetn,

    // Write address channel
    input [ADDR_WIDTH-1:0] s0_axi_awaddr,
    input s0_axi_awvalid,
    output reg s0_axi_awready,

    // Write data channel
    input [DATA_WIDTH-1:0] s0_axi_wdata,
    input [DATA_WIDTH/8:0] s0_axi_wstrb,
    input s0_axi_wvalid,
    output reg s0_axi_wready,

    // Write response channel
    output reg s0_axi_bresp,
    output reg s0_axi_bvalid,
    input s0_axi_bready,

    // Read address channel
    input [ADDR_WIDTH-1:0] s0_axi_araddr,
    input s0_axi_arvalid,
    output reg s0_axi_arready,

    // Read data channel
    output reg [DATA_WIDTH-1:0] s0_axi_rdata,
    output reg s0_axi_rresp,
    output reg s0_axi_rvalid,
    input s0_axi_rready
);
reg [DATA_WITDH-1:0] operandA, operandB;
reg [(2*DATA_WITDH-1):0] result_tmp;
wire [DATA_WITDH-1:0] overflow_adder;

//getting data from the master
always@(posedge clk)
begin
    if(rstn ==0)
	   ready <= 0;
	else   
	if(awvalid == 1 && wvalid == 1)
	  begin
	     case(awaddr)
		   0:
		     begin
		      operandA <= wdata;
			  bresp <= 1;
			 end  
		   4: 
		     begin
		      operandB <= wdata;
			  bresp <= 1;
			 end 
		   default:
		      begin
			     ready <= 1;
			  end

      endcase
	  
	  end
	else
	  begin
	     // maybe other controls need to be set
	  end

end

always@(operandA, operandB)
begin
  result_tmp <= operandA + operandB;
end

assign overflow_adder = (result_tmp > (2**DATA_WITDH)-1)?1:0;   //tri-state assignment


//returning results to the master
always@(posedge clk)
begin
   
   if(arvalid)
   begin
      case(araddress)
	     8:
		    rdata <= result_tmp[31:0];
		 12:
		    rdata <= overflow_adder;
	     default:
                  //do something		 
      endcase
   end
   
end

endmodule