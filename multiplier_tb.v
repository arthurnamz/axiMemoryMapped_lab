`timescale 1ns / 1ps

module multiplier_tb;

  // Parameters
  parameter DATA_WIDTH = 32;
  parameter ADDR_WIDTH = 8;

  // Signals
  reg s2_axi_aclk = 0;
  reg s2_axi_aresetn;

  reg [ADDR_WIDTH-1:0] s2_axi_awaddr;
  reg s2_axi_awvalid;
  wire s2_axi_awready;

  reg [DATA_WIDTH-1:0] s2_axi_wdata;
  reg [DATA_WIDTH/8:0] s2_axi_wstrb;
  reg s2_axi_wvalid;
  wire s2_axi_wready;

  wire s2_axi_bresp;
  wire s2_axi_bvalid;
  reg s2_axi_bready;

  reg [ADDR_WIDTH-1:0] s2_axi_araddr;
  reg s2_axi_arvalid;
  wire s2_axi_arready;

  wire [DATA_WIDTH-1:0] s2_axi_rdata;
  wire s2_axi_rresp;
  wire s2_axi_rvalid;
  reg s2_axi_rready;

  // Instantiate the DUT
  multiplier #(
    .DATA_WIDTH(DATA_WIDTH),
    .ADDR_WIDTH(ADDR_WIDTH)
  ) dut (
    .s2_axi_aclk(s2_axi_aclk),
    .s2_axi_aresetn(s2_axi_aresetn),
    .s2_axi_awaddr(s2_axi_awaddr),
    .s2_axi_awvalid(s2_axi_awvalid),
    .s2_axi_awready(s2_axi_awready),
    .s2_axi_wdata(s2_axi_wdata),
    .s2_axi_wstrb(s2_axi_wstrb),
    .s2_axi_wvalid(s2_axi_wvalid),
    .s2_axi_wready(s2_axi_wready),
    .s2_axi_bresp(s2_axi_bresp),
    .s2_axi_bvalid(s2_axi_bvalid),
    .s2_axi_bready(s2_axi_bready),
    .s2_axi_araddr(s2_axi_araddr),
    .s2_axi_arvalid(s2_axi_arvalid),
    .s2_axi_arready(s2_axi_arready),
    .s2_axi_rdata(s2_axi_rdata),
    .s2_axi_rresp(s2_axi_rresp),
    .s2_axi_rvalid(s2_axi_rvalid),
    .s2_axi_rready(s2_axi_rready)
  );

  // Clock generation
  always #5 s2_axi_aclk = ~s2_axi_aclk;

  // Reset generation
  initial begin
    s2_axi_aresetn = 0;
    #10;
    s2_axi_aresetn = 1;
  end

  // Write data
  initial begin
    #10;
    s2_axi_awaddr = 16;
    s2_axi_awvalid = 1;
    s2_axi_wdata = 32'h278;
    s2_axi_wstrb = 4'hF;
    s2_axi_wvalid = 1;
    s2_axi_bready = 1;
    #20;
    
    s2_axi_awaddr = 20;
    s2_axi_awvalid = 1;
    s2_axi_wdata = 32'h1468;
    s2_axi_wstrb = 4'hF;
    s2_axi_wvalid = 1;
    s2_axi_bready = 1;
    #20;
    
    s2_axi_awvalid = 0;
    s2_axi_wvalid = 0;
    #20;
    
    s2_axi_araddr = 24;
    s2_axi_arvalid = 1;
    s2_axi_rready = 1;
    #20;
    
    s2_axi_araddr = 28;
    s2_axi_arvalid = 1;
    s2_axi_rready = 1;
    #20;
    
    s2_axi_arvalid = 0;
    #20;
    
    $finish;
  end

endmodule

