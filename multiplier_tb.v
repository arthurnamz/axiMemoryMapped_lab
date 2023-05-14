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
  
 // internal register
  reg [7:0] read_out;
  reg [7:0] write_in;
  reg [31:0] hold;
  reg waiting;

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

  

  // Reset generation
  initial begin
    s2_axi_aresetn = 0;
    #5
     s2_axi_aresetn = 1;

    write_in = 0;
    waiting = 0;
    #20;
    read_out = 8;
    hold = 23;

    #500;
    $finish;
end
 // Write data
 always @(posedge s2_axi_aclk) begin
    s2_axi_awvalid <= 1;      // 1 bit
    s2_axi_wvalid <= 1;       // 1 bit
    
    if (s2_axi_wready == 1 && s2_axi_awready == 1 && waiting == 0) begin
        s2_axi_awaddr <= write_in;  // 8 bits
        s2_axi_wdata <= hold; // 32 bits
        s2_axi_wstrb <= 15; // 4 bits
        s2_axi_bready <= 1;   // 1 bit
        
        
        if (write_in == 4)begin
         write_in <= 0;
         waiting <= 1;
        end else begin
          write_in <= 4;
          waiting <= 0;
        end

        hold <= hold + 7;
    end

    
    
end
 // Read data
 always @(posedge s2_axi_aclk) 
 begin
    s2_axi_arvalid <= 1;
    s2_axi_rready <= 1;
    if(s2_axi_arready == 1 && waiting == 1) begin
      s2_axi_araddr <= read_out;
      if (read_out == 12)begin
         read_out <= 8;
         waiting <= 0;
        end else begin
          read_out <= 12;
          waiting <= 1;
        end
    end
 end

 // Clock generation
  always #5 s2_axi_aclk = ~s2_axi_aclk;

endmodule

