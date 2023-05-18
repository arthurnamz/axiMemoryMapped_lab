module bus_tb;
parameter DATA_WIDTH = 32;
parameter ADDR_WIDTH = 8;

/* slave interface */   
    // Global signals
    reg s0_axi_aclk;
    reg s0_axi_aresetn;

    // Write address channel
    reg [ADDR_WIDTH-1:0] s0_axi_awaddr;
    reg s0_axi_awvalid;
    wire s0_axi_awready;

    // Write data channel
    reg [DATA_WIDTH-1:0] s0_axi_wdata;
    reg [DATA_WIDTH/8:0] s0_axi_wstrb;
    reg s0_axi_wvalid;
    wire s0_axi_wready;

    // Write response channel
    wire s0_axi_bresp;
    wire s0_axi_bvalid;
    reg s0_axi_bready;

    // Read address channel
    reg [ADDR_WIDTH-1:0] s0_axi_araddr;
    reg s0_axi_arvalid;
    wire s0_axi_arready;

    // Read data channel
    wire [DATA_WIDTH-1:0] s0_axi_rdata;
    wire s0_axi_rresp;
    wire s0_axi_rvalid;
    reg s0_axi_rready;

/* master interface */
   // Global signals
    reg m1_axi_aclk;
    reg m1_axi_aresetn;

    // Write address channel
    wire  [ADDR_WIDTH-1:0] m1_axi_awaddr;
    wire  m1_axi_awvalid;
    reg  m1_axi_awready;

    // Write data channel
    wire  [DATA_WIDTH-1:0] m1_axi_wdata;
    wire  [DATA_WIDTH/8:0] m1_axi_wstrb;
    wire  m1_axi_wvalid;
    reg  m1_axi_wready;

    // Write response channel
    reg  m1_axi_bresp;
    reg  m1_axi_bvalid;
    wire m1_axi_bready;

    // Read address channel
    wire [ADDR_WIDTH-1:0] m1_axi_araddr;
    wire m1_axi_arvalid;
    reg  m1_axi_arready;

    // Read data channel
    reg  [DATA_WIDTH-1:0] m1_axi_rdata;
    reg  m1_axi_rresp;
    reg  m1_axi_rvalid;
    wire m1_axi_rready;

    bus #(
    .DATA_WIDTH(DATA_WIDTH),
    .ADDR_WIDTH(ADDR_WIDTH)
  ) dut (

  );

endmodule