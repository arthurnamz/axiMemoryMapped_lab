module adder_tb;

  // Parameters
  parameter DATA_WIDTH = 32;
  parameter ADDR_WIDTH = 8;

  // Signals
  reg s0_axi_aclk = 0;
  reg s0_axi_aresetn;
  reg [ADDR_WIDTH-1:0] s0_axi_awaddr;
  reg s0_axi_awvalid;
  wire s0_axi_awready;
  reg [DATA_WIDTH-1:0] s0_axi_wdata;
  reg [DATA_WIDTH/8:0] s0_axi_wstrb;
  reg s0_axi_wvalid;
  wire s0_axi_wready;
  wire s0_axi_bresp;
  wire s0_axi_bvalid;
  reg s0_axi_bready;
  reg [ADDR_WIDTH-1:0] s0_axi_araddr;
  reg s0_axi_arvalid;
  wire s0_axi_arready;
  wire [DATA_WIDTH-1:0] s0_axi_rdata;
  wire s0_axi_rresp;
  wire s0_axi_rvalid;
  reg s0_axi_rready;

  // Instantiate the DUT
  adder #(
    .DATA_WIDTH(DATA_WIDTH),
    .ADDR_WIDTH(ADDR_WIDTH)
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
    .s0_axi_rready(s0_axi_rready)
  );

// Toggle clock
  always #5 s0_axi_aclk <= ~s0_axi_aclk;
  // Initialize inputs
  initial begin
    s0_axi_aresetn = 0;
    s0_axi_awvalid = 0;
    s0_axi_wvalid = 0;
    s0_axi_bready = 0;
    s0_axi_arvalid = 0;
    s0_axi_rready = 0;
    s0_axi_wdata = 0;
    s0_axi_wstrb = 0;
    s0_axi_awaddr = 0;
    s0_axi_araddr = 0;
    #1 s0_axi_aresetn = 1;
  end

  

// Write test
initial begin
// Write 0x0000_0000 to address 0x00
    s0_axi_aresetn = 1;
    s0_axi_awvalid = 1;
    s0_axi_wvalid = 1;
    s0_axi_wstrb = 4'b1111; // write all 4 bytes
    s0_axi_awaddr = 8'b0000_0000;
    s0_axi_wdata = 32'h0000_0000;

    #200;

    #100 $finish;
end 

endmodule