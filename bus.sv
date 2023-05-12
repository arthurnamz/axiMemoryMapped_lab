module bus#(
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

endmodule