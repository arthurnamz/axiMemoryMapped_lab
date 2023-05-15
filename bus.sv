module bus#(
    parameter DATA_WIDTH = 32,
    parameter ADDR_WIDTH = 8
)
(

 /* slave interface */   
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

/* master interface */
   // Global signals
    input m1_axi_aclk,
    input m1_axi_aresetn,

    // Write address channel
    output [ADDR_WIDTH-1:0] m1_axi_awaddr,
    output m1_axi_awvalid,
    input  m1_axi_awready,

    // Write data channel
    output [DATA_WIDTH-1:0] m1_axi_wdata,
    output [DATA_WIDTH/8:0] m1_axi_wstrb,
    output m1_axi_wvalid,
    input  m1_axi_wready,

    // Write response channel
    input reg m1_axi_bresp,
    input reg m1_axi_bvalid,
    output m1_axi_bready,

    // Read address channel
    output [ADDR_WIDTH-1:0] m1_axi_araddr,
    output m1_axi_arvalid,
    input  m1_axi_arready,

    // Read data channel
    input reg [DATA_WIDTH-1:0] m1_axi_rdata,
    input reg m1_axi_rresp,
    input reg m1_axi_rvalid,
    output  m1_axi_rready
);
// Internal registers



// Writing to the slave






// Reading from the slave

endmodule