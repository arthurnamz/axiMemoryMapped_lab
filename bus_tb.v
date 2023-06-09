`timescale 1ns/1ps
module bus_tb;
parameter DATA_WIDTH = 32;
parameter ADDR_WIDTH = 8;
parameter RESP_WIDTH = 3;

/* slave interface */   
    // Global signals
    reg s0_axi_aclk = 0;
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
    wire [RESP_WIDTH - 1:0] s0_axi_bresp;
    wire s0_axi_bvalid;
    reg s0_axi_bready;

    // Read address channel
    reg [ADDR_WIDTH-1:0] s0_axi_araddr;
    reg s0_axi_arvalid;
    wire s0_axi_arready;

    // Read data channel
    wire [DATA_WIDTH-1:0] s0_axi_rdata;
    wire [RESP_WIDTH - 1:0] s0_axi_rresp;
    wire s0_axi_rvalid;
    reg s0_axi_rready;

/* master interface 1*/
   // Global signals
    reg m1_axi_aclk = 0;
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
    reg  [RESP_WIDTH - 1:0] m1_axi_bresp;
    reg  m1_axi_bvalid;
    wire m1_axi_bready;

    // Read address channel
    wire [ADDR_WIDTH-1:0] m1_axi_araddr;
    wire m1_axi_arvalid;
    reg  m1_axi_arready;

    // Read data channel
    reg  [DATA_WIDTH-1:0] m1_axi_rdata;
    reg  [RESP_WIDTH - 1:0] m1_axi_rresp;
    reg  m1_axi_rvalid;
    wire m1_axi_rready;

    /* master interface 2 */
   // Global signals
    reg m2_axi_aclk = 0;
    reg m2_axi_aresetn;

    // Write address channel
    wire  [ADDR_WIDTH-1:0] m2_axi_awaddr;
    wire  m2_axi_awvalid;
    reg  m2_axi_awready;

    // Write data channel
    wire  [DATA_WIDTH-1:0] m2_axi_wdata;
    wire  [DATA_WIDTH/8:0] m2_axi_wstrb;
    wire  m2_axi_wvalid;
    reg  m2_axi_wready;

    // Write response channel
    reg  [RESP_WIDTH - 1:0] m2_axi_bresp;
    reg  m2_axi_bvalid;
    wire m2_axi_bready;

    // Read address channel
    wire [ADDR_WIDTH-1:0] m2_axi_araddr;
    wire m2_axi_arvalid;
    reg  m2_axi_arready;

    // Read data channel
    reg  [DATA_WIDTH-1:0] m2_axi_rdata;
    reg  [RESP_WIDTH - 1:0] m2_axi_rresp;
    reg  m2_axi_rvalid;
    wire m2_axi_rready;
// internal register
  reg [7:0] read_out;
  reg [31:0] write_in = 56;
  reg [ADDR_WIDTH-1:0] hold = 0;
  integer m;

    bus#(
    .DATA_WIDTH(DATA_WIDTH),
    .ADDR_WIDTH(ADDR_WIDTH),
    .RESP_WIDTH(RESP_WIDTH)
  ) dut (
// SLAVE     INTERFACE
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
// MASTER INTERFACE 1
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

    // MASTER INTERFACE 2
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
  always #5 m1_axi_aclk = ~m1_axi_aclk;
  always #5 m2_axi_aclk = ~m2_axi_aclk;
  // Reset generation
  initial begin
    s0_axi_aresetn = 0;
    m1_axi_aresetn = 0;
    m2_axi_aresetn = 0;
    #5;
    s0_axi_aresetn = 1;
    m1_axi_aresetn = 1;
    m2_axi_aresetn = 1;
 #10;
for(m=0; m<2; m=m+1) begin
    s0_axi_awvalid = 0;      
    s0_axi_wvalid = 0;
    m1_axi_awready = 1;
    m1_axi_wready = 1;
    #20;
    s0_axi_awvalid = 0;   
    s0_axi_awaddr = hold;     
    s0_axi_wvalid = 0;       
    s0_axi_wdata = write_in; 
    s0_axi_wstrb = 15; 
    s0_axi_bready = 1; 
    m1_axi_awready = 1;
    m1_axi_wready = 1;
    m1_axi_bresp = 0;
    m1_axi_bvalid = 0;
    #20;
    s0_axi_awvalid = 0;      
    s0_axi_wvalid = 0;
    m1_axi_awready = 1;
    m1_axi_wready = 1;
    s0_axi_bready = 0; 

    hold = hold + 4;
    write_in = write_in + 8;
end

  //    #20;
  // //  write to slave 2
  //   s0_axi_awvalid = 0;      
  //   s0_axi_wvalid = 0;
  //   m2_axi_awready = 1;
  //   m2_axi_wready = 1;
  //   #20;
  //   s0_axi_awvalid = 0;   
  //   s0_axi_awaddr = 16;     
  //   s0_axi_wvalid = 0;       
  //   s0_axi_wdata = 56; 
  //   s0_axi_wstrb = 15; 
  //   s0_axi_bready = 1; 
  //   m2_axi_awready = 1;
  //   m2_axi_wready = 1;
  //   m2_axi_bresp = 0;
  //   m2_axi_bvalid = 0;
  //   #20;
  //   s0_axi_awvalid = 0;      
  //   s0_axi_wvalid = 0;
  //   m2_axi_awready = 1;
  //   m2_axi_wready = 1;
  //   s0_axi_bready = 0; 
   

  // #120;
  //  // read from slave 1
  //   s0_axi_arvalid = 0;      
  //   s0_axi_rready = 1;
  //   m1_axi_arready = 1;
  //   m1_axi_rvalid = 0;
  //   #20;
  //   s0_axi_rready = 0;
  //   s0_axi_arvalid = 1;   
  //   s0_axi_araddr = 8;    
  //   m1_axi_rdata = 49;
  //   m1_axi_rresp = 0;
  //   m1_axi_arready = 0;
  //   #5;
  //   m1_axi_arready = 1;
  //   m1_axi_rvalid = 0;
  //   s0_axi_arvalid = 0;      
  //   s0_axi_rready = 0;

    // #20;
    //  // read from slave 2
    // s0_axi_arvalid = 0;      
    // s0_axi_rready = 1;
    // m2_axi_arready = 1;
    // m2_axi_rvalid = 0;
    // #20;
    // s0_axi_rready = 0;
    // s0_axi_arvalid = 1;   
    // s0_axi_araddr = 24;    
    // m2_axi_rdata = 76;
    // m2_axi_rresp = 0;
    // m2_axi_arready = 0;
    // #5;
    // m2_axi_arready = 1;
    // m2_axi_rvalid = 0;
    // s0_axi_arvalid = 0;      
    // s0_axi_rready = 0;
    

    #1500;
    $finish;
end
endmodule