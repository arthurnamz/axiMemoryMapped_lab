`timescale 1ns / 1ps

module adder_tb;

  // Parameters
  parameter DATA_WIDTH = 32;
  parameter ADDR_WIDTH = 8;

  // Signals
  reg s1_axi_aclk = 0;
  reg s1_axi_aresetn;

  reg [ADDR_WIDTH-1:0] s1_axi_awaddr;
  reg s1_axi_awvalid;
  wire s1_axi_awready;

  reg [DATA_WIDTH-1:0] s1_axi_wdata;
  reg [DATA_WIDTH/8:0] s1_axi_wstrb;
  reg s1_axi_wvalid;
  wire s1_axi_wready;

  wire s1_axi_bresp;
  wire s1_axi_bvalid;
  reg s1_axi_bready;

  reg [ADDR_WIDTH-1:0] s1_axi_araddr;
  reg s1_axi_arvalid;
  wire s1_axi_arready;

  wire [DATA_WIDTH-1:0] s1_axi_rdata;
  wire s1_axi_rresp;
  wire s1_axi_rvalid;
  reg s1_axi_rready;
  reg [46:0] tester [0:15];
  
  integer i;
  reg k;
  reg l;
  reg m;
  reg [7:0] p;
  reg [3:0] q;
  reg [31:0] hold;
  // Instantiate the DUT
  adder #(
    .DATA_WIDTH(DATA_WIDTH),
    .ADDR_WIDTH(ADDR_WIDTH)
  ) dut (
    .s1_axi_aclk(s1_axi_aclk),
    .s1_axi_aresetn(s1_axi_aresetn),
    .s1_axi_awaddr(s1_axi_awaddr),
    .s1_axi_awvalid(s1_axi_awvalid),
    .s1_axi_awready(s1_axi_awready),
    .s1_axi_wdata(s1_axi_wdata),
    .s1_axi_wstrb(s1_axi_wstrb),
    .s1_axi_wvalid(s1_axi_wvalid),
    .s1_axi_wready(s1_axi_wready),
    .s1_axi_bresp(s1_axi_bresp),
    .s1_axi_bvalid(s1_axi_bvalid),
    .s1_axi_bready(s1_axi_bready),
    .s1_axi_araddr(s1_axi_araddr),
    .s1_axi_arvalid(s1_axi_arvalid),
    .s1_axi_arready(s1_axi_arready),
    .s1_axi_rdata(s1_axi_rdata),
    .s1_axi_rresp(s1_axi_rresp),
    .s1_axi_rvalid(s1_axi_rvalid),
    .s1_axi_rready(s1_axi_rready)
  );

  // Clock generation
  always #5 s1_axi_aclk = ~s1_axi_aclk;

  // Reset generation
  initial begin
    s1_axi_aresetn = 0;
    #5;
    s1_axi_aresetn = 1;
    k = 1;
    l = 1;
    m = 1;
    p= 0;
    q = 15;

    
    // Generate random numbers
    repeat (16) begin
      hold = $random;
        tester[i] = tester[k] + tester[l] + tester[p] + tester[hold] + tester[q] + tester[m];
        p = p + 1;
    end
    
    #200;
    $finish;
end
 // Write data
 always @(posedge s1_axi_aclk) begin
    s1_axi_awvalid <= tester[i][0];      // 1 bit
    s1_axi_wvalid <= tester[i][1];       // 1 bit
    
    if (s1_axi_wready == 1 && s1_axi_awready == 1) begin
        s1_axi_awaddr <= tester[i][9:2];  // 8 bits
        s1_axi_wdata <= tester[i][41:10]; // 32 bits
        s1_axi_wstrb <= tester[i][45:42]; // 4 bits
        s1_axi_bready <= tester[i][46];   // 1 bit
    end
end
 // Read data
 always @(posedge s1_axi_aclk) 
 begin
    s1_axi_arvalid <= 1;
    s1_axi_rready <= 1;
    s1_axi_araddr <= 8;

    s1_axi_arvalid <= 0;
    s1_axi_rready <= 0;
    
   
    s1_axi_arvalid <= 1;
    s1_axi_rready <= 1;
    s1_axi_araddr <= 12;
 end

endmodule

