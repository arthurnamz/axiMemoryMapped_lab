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
  
 // internal register
  reg [7:0] read_out;
  reg [7:0] write_in;
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

  

  // Reset generation
  initial begin
    s1_axi_aresetn = 0;
    #5
     s1_axi_aresetn = 1;

    write_in = 0;
    #20;
    read_out = 0;
    hold = 23;
    #500;
    $finish;
end
 // Write data
 always @(posedge s1_axi_aclk) begin
    s1_axi_awvalid <= 1;      // 1 bit
    s1_axi_wvalid <= 1;       // 1 bit
    
    if (s1_axi_wready == 1 && s1_axi_awready == 1) begin
        s1_axi_awaddr <= write_in;  // 8 bits
        s1_axi_wdata <= hold; // 32 bits
        s1_axi_wstrb <= 15; // 4 bits
        s1_axi_bready <= 1;   // 1 bit
        write_in <= write_in + 1;
        hold <= hold + 7;
    end
    
end
 // Read data
 always @(posedge s1_axi_aclk) 
 begin
    s1_axi_arvalid <= 1;
    s1_axi_rready <= 1;
    if(s1_axi_arready == 1 ) begin
      s1_axi_araddr <= read_out;
      read_out <= read_out + 1;
    end
 end

 // Clock generation
  always #5 s1_axi_aclk = ~s1_axi_aclk;

endmodule

