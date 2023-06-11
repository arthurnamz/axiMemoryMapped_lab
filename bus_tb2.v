module bus_tb2;

  // Constants
  parameter DATA_WIDTH = 32;
  parameter ADDR_WIDTH = 8;
  parameter RESP_WIDTH = 3;

  // Signals
  reg s0_axi_aclk;
  reg s0_axi_aresetn;
  reg [ADDR_WIDTH-1:0] s0_axi_awaddr;
  reg s0_axi_awvalid;
  wire s0_axi_awready;
  reg [DATA_WIDTH-1:0] s0_axi_wdata;
  reg [DATA_WIDTH/8:0] s0_axi_wstrb;
  reg s0_axi_wvalid;
  wire s0_axi_wready;
  wire [RESP_WIDTH-1:0] s0_axi_bresp;
  wire s0_axi_bvalid;
  reg s0_axi_bready;
  reg [ADDR_WIDTH-1:0] s0_axi_araddr;
  reg s0_axi_arvalid;
  wire s0_axi_arready;
  wire [DATA_WIDTH-1:0] s0_axi_rdata;
  wire [RESP_WIDTH-1:0] s0_axi_rresp;
  wire s0_axi_rvalid;
  reg s0_axi_rready;
  reg m1_axi_aclk;
  reg m1_axi_aresetn;
  wire [ADDR_WIDTH-1:0] m1_axi_awaddr;
  wire m1_axi_awvalid;
  reg m1_axi_awready;
  wire [DATA_WIDTH-1:0] m1_axi_wdata;
  wire [DATA_WIDTH/8:0] m1_axi_wstrb;
  wire m1_axi_wvalid;
  reg m1_axi_wready;
  reg [RESP_WIDTH-1:0] m1_axi_bresp;
  reg m1_axi_bvalid;
  wire m1_axi_bready;
  wire [ADDR_WIDTH-1:0] m1_axi_araddr;
  wire m1_axi_arvalid;
  reg m1_axi_arready;
  wire [DATA_WIDTH-1:0] m1_axi_rdata;
  wire [RESP_WIDTH-1:0] m1_axi_rresp;
  wire m1_axi_rvalid;
  reg m1_axi_rready;
  reg m2_axi_aclk;
  reg m2_axi_aresetn;
  wire [ADDR_WIDTH-1:0] m2_axi_awaddr;
  wire m2_axi_awvalid;
  reg m2_axi_awready;
  wire [DATA_WIDTH-1:0] m2_axi_wdata;
  wire [DATA_WIDTH/8:0] m2_axi_wstrb;
  wire m2_axi_wvalid;
  reg m2_axi_wready;
  reg [RESP_WIDTH-1:0] m2_axi_bresp;
  reg m2_axi_bvalid;
  wire m2_axi_bready;
  wire [ADDR_WIDTH-1:0] m2_axi_araddr;
  wire m2_axi_arvalid;
  reg m2_axi_arready;
  wire [DATA_WIDTH-1:0] m2_axi_rdata;
  wire [RESP_WIDTH-1:0] m2_axi_rresp;
  wire m2_axi_rvalid;
  reg m2_axi_rready;

  // Instantiate the bus module
  bus #(
    .DATA_WIDTH(DATA_WIDTH),
    .ADDR_WIDTH(ADDR_WIDTH),
    .RESP_WIDTH(RESP_WIDTH)
  ) dut (
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
    .m1_axi_rready(m1_axi_rready),
    .m2_axi_aclk(m2_axi_aclk),
    .m2_axi_aresetn(m2_axi_aresetn),
    .m2_axi_awaddr(m2_axi_awaddr),
    .m2_axi_awvalid(m2_axi_awvalid),
    .m2_axi_awready(m2_axi_awready),
    .m2_axi_wdata(m2_axi_wdata),
    .m2_axi_wstrb(m2_axi_wstrb),
    .m2_axi_wvalid(m2_axi_wvalid),
    .m2_axi_wready(m2_axi_wready),
    .m2_axi_bresp(m2_axi_bresp),
    .m2_axi_bvalid(m2_axi_bvalid),
    .m2_axi_bready(m2_axi_bready),
    .m2_axi_araddr(m2_axi_araddr),
    .m2_axi_arvalid(m2_axi_arvalid),
    .m2_axi_arready(m2_axi_arready),
    .m2_axi_rdata(m2_axi_rdata),
    .m2_axi_rresp(m2_axi_rresp),
    .m2_axi_rvalid(m2_axi_rvalid),
    .m2_axi_rready(m2_axi_rready)
  );

  // Clock generation
  always #5 s0_axi_aclk = ~s0_axi_aclk;
  always #10 m1_axi_aclk = ~m1_axi_aclk;
  always #15 m2_axi_aclk = ~m2_axi_aclk;

  // Reset generation
  initial begin
    s0_axi_aresetn = 0;
    m1_axi_aresetn = 0;
    m2_axi_aresetn = 0;
    #20 s0_axi_aresetn = 1;
    #20 m1_axi_aresetn = 1;
    #20 m2_axi_aresetn = 1;
  end

  // Testbench logic
  initial begin
    // Initialize input signals
    s0_axi_awaddr = 0;
    s0_axi_awvalid = 0;
    s0_axi_wdata = 0;
    s0_axi_wstrb = 0;
    s0_axi_wvalid = 0;
    s0_axi_bready = 0;
    s0_axi_araddr = 0;
    s0_axi_arvalid = 0;
    s0_axi_rready = 0;
    m1_axi_awready = 0;
    m1_axi_wready = 0;
    m1_axi_bvalid = 0;
    m1_axi_arready = 0;
 
    m2_axi_awready = 0;
    m2_axi_wready = 0;
    m2_axi_bvalid = 0;
    m2_axi_arready = 0;

    // Stimulus generation
    #30 s0_axi_awvalid = 1; s0_axi_awaddr = 4'h1; s0_axi_wvalid = 1; s0_axi_wdata = 32'hDEADBEEF; s0_axi_wstrb = 4'hF; s0_axi_bready = 1;
    #10 s0_axi_awvalid = 0; s0_axi_wvalid = 0;
    #20 s0_axi_arvalid = 1; s0_axi_araddr = 4'h2; s0_axi_rready = 1;
    #10 s0_axi_arvalid = 0;
    #50 $finish;
  end

  // Monitor logic
  always @(posedge s0_axi_aclk) begin
    if (s0_axi_awvalid && s0_axi_awready) $display("s0_axi_awaddr = %h", s0_axi_awaddr);
    if (s0_axi_wvalid && s0_axi_wready) $display("s0_axi_wdata = %h", s0_axi_wdata);
    if (s0_axi_bvalid && s0_axi_bready) $display("s0_axi_bresp = %b", s0_axi_bresp);
    if (s0_axi_arvalid && s0_axi_arready) $display("s0_axi_araddr = %h", s0_axi_araddr);
    if (s0_axi_rvalid && s0_axi_rready) $display("s0_axi_rdata = %h", s0_axi_rdata);
  end

endmodule
