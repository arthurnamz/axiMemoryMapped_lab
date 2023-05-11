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
    #200;
    $finish;
  end

 // Write data
 always @(posedge s1_axi_aclk) 
 begin
    s1_axi_awvalid <= 1;
    s1_axi_wvalid <= 1;
    if(s1_axi_wready == 1 && s1_axi_awready == 1) begin
    s1_axi_awaddr <= 0;
    s1_axi_wdata <= 39;
    s1_axi_wstrb <= 15;
    s1_axi_bready <= 1;
    end

     
    s1_axi_awvalid <= 0;
    s1_axi_wvalid <= 0;
    if(s1_axi_wready == 1 && s1_axi_awready == 1) begin
    s1_axi_awaddr <= 35;
    s1_axi_wdata <= 76;
    s1_axi_wstrb <= 15;
    s1_axi_bready <= 1;
    end
   
    s1_axi_awvalid <= 1;
    s1_axi_wvalid <= 1;
    if(s1_axi_wready == 1 && s1_axi_awready == 1) begin
    s1_axi_awaddr <= 4;
    s1_axi_wdata <= 40;
    s1_axi_wstrb <= 15;
    s1_axi_bready <= 1;
    end
    

    s1_axi_awvalid <= 0;
    s1_axi_wvalid <= 0;
    if(s1_axi_wready == 1 && s1_axi_awready == 1) begin
    s1_axi_awaddr <= 4;
    s1_axi_wdata <= 45;
    s1_axi_wstrb <= 15;
    s1_axi_bready <= 1;
    end
    
    
    s1_axi_awvalid <= 1;
    s1_axi_wvalid <= 1;
    if(s1_axi_wready == 1 && s1_axi_awready == 1) begin
    s1_axi_awaddr <= 45;
    s1_axi_wdata <= 40;
    s1_axi_wstrb <= 15;
    s1_axi_bready <= 1;
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

