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
// SLAVE INTERFACE
    .s0_axi_aclk(s0_axi_aclk),
    .s0_axi_aresetn(s0_axi_aresetn),
    .s0_axi_awaddr(s0_axi_awaddr),
    .s0_axi_awvalid(s0_axi_awvalid),
    .s0_axi_awready(s0_axi_awready),
    .s0_axi_wdata(s0_axi_wdata),
    .s0_axi_wstrb(s0_axi_wstrb),
    .s0_axi_wvalid(s0_axi_wvalid),
    .s0_axi_wready(s0_axi_wready),
    .s0_axi_bresp(s0_axi_bresp),
    .s0_axi_bvalid(s0_axi_bvalid),
    .s0_axi_bready(s0_axi_bready),
    .s0_axi_araddr(s0_axi_araddr),
    .s0_axi_arvalid(s0_axi_arvalid),
    .s0_axi_arready(s0_axi_arready),
    .s0_axi_rdata(s0_axi_rdata),
    .s0_axi_rresp(s0_axi_rresp),
    .s0_axi_rvalid(s0_axi_rvalid),
    .s0_axi_rready(s0_axi_rready),
// MASTER INTERFACE
    .m1_axi_aclk(m1_axi_aclk),
    .m1_axi_aresetn(m1_axi_aresetn),
    .m1_axi_awaddr(m1_axi_awaddr),
    .m1_axi_awvalid(m1_axi_awvalid),
    .m1_axi_awready(m1_axi_awready),
    .m1_axi_wdata(m1_axi_wdata),
    .m1_axi_wstrb(m1_axi_wstrb),
    .m1_axi_wvalid(m1_axi_wvalid),
    .m1_axi_wready(m1_axi_wready),
    .m1_axi_bresp(m1_axi_bresp),
    .m1_axi_bvalid(m1_axi_bvalid),
    .m1_axi_bready(m1_axi_bready),
    .m1_axi_araddr(m1_axi_araddr),
    .m1_axi_arvalid(m1_axi_arvalid),
    .m1_axi_arready(m1_axi_arready),
    .m1_axi_rdata(m1_axi_rdata),
    .m1_axi_rresp(m1_axi_rresp),
    .m1_axi_rvalid(m1_axi_rvalid),
    .m1_axi_rready(m1_axi_rready)
  );

endmodule