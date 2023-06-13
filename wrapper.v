module wrapper #(
    parameter DATA_WIDTH = 32,
    parameter ADDR_WIDTH = 8,
    parameter RESP_WIDTH = 3
)
(

 /* slave interface */   
    // Global signals
    input s3_axi_aclk,
    input s3_axi_aresetn,

    // Write address channel
    input [ADDR_WIDTH-1:0] s3_axi_awaddr,
    input s3_axi_awvalid,
    output reg s3_axi_awready,

    // Write data channel
    input [DATA_WIDTH-1:0] s3_axi_wdata,
    input [DATA_WIDTH/8:0] s3_axi_wstrb,
    input s3_axi_wvalid,
    output reg s3_axi_wready,

    // Write response channel
    output reg [RESP_WIDTH - 1:0] s3_axi_bresp,
    output reg s3_axi_bvalid,
    input s3_axi_bready,

    // Read address channel
    input [ADDR_WIDTH-1:0] s3_axi_araddr,
    input s3_axi_arvalid,
    output reg s3_axi_arready,

    // Read data channel
    output reg [DATA_WIDTH-1:0] s3_axi_rdata,
    output reg [RESP_WIDTH - 1:0] s3_axi_rresp,
    output reg s3_axi_rvalid,
    input s3_axi_rready,

/* master interface 1*/
   // Global signals
    input m3_axi_aclk,
    input m3_axi_aresetn,

    // Write address channel
    output  reg [ADDR_WIDTH-1:0] m3_axi_awaddr,
    output  reg m3_axi_awvalid,
    input  m3_axi_awready,

    // Write data channel
    output  reg [DATA_WIDTH-1:0] m3_axi_wdata,
    output  reg [DATA_WIDTH/8:0] m3_axi_wstrb,
    output  reg m3_axi_wvalid,
    input  m3_axi_wready,

    // Write response channel
    input  [RESP_WIDTH - 1:0] m3_axi_bresp,
    input  m3_axi_bvalid,
    output reg m3_axi_bready,

    // Read address channel
    output reg [ADDR_WIDTH-1:0] m3_axi_araddr,
    output reg m3_axi_arvalid,
    input  m3_axi_arready,

    // Read data channel
    input  [DATA_WIDTH-1:0] m3_axi_rdata,
    input  [RESP_WIDTH - 1:0] m3_axi_rresp,
    input  m3_axi_rvalid,
    output reg m3_axi_rready,

    
/* master interface 2*/
   // Global signals
    input m4_axi_aclk,
    input m4_axi_aresetn,

    // Write address channel
    output  reg [ADDR_WIDTH-1:0] m4_axi_awaddr,
    output  reg m4_axi_awvalid,
    input  m4_axi_awready,

    // Write data channel
    output  reg [DATA_WIDTH-1:0] m4_axi_wdata,
    output  reg [DATA_WIDTH/8:0] m4_axi_wstrb,
    output  reg m4_axi_wvalid,
    input  m4_axi_wready,

    // Write response channel
    input  [RESP_WIDTH - 1:0] m4_axi_bresp,
    input  m4_axi_bvalid,
    output reg m4_axi_bready,

    // Read address channel
    output reg [ADDR_WIDTH-1:0] m4_axi_araddr,
    output reg m4_axi_arvalid,
    input  m4_axi_arready,

    // Read data channel
    input  [DATA_WIDTH-1:0] m4_axi_rdata,
    input  [RESP_WIDTH - 1:0] m4_axi_rresp,
    input  m4_axi_rvalid,
    output reg m4_axi_rready
);
//wires




// bus instiation
bus#(
    .DATA_WIDTH(DATA_WIDTH),
    .ADDR_WIDTH(ADDR_WIDTH),
    .RESP_WIDTH(RESP_WIDTH)
) bus_instiate (
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

  // adder
  adder #(
    .DATA_WIDTH(DATA_WIDTH),
    .ADDR_WIDTH(ADDR_WIDTH),
    .RESP_WIDTH(RESP_WIDTH)
  ) adder_instiate (
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

  // multiplier
   multiplier #(
    .DATA_WIDTH(DATA_WIDTH),
    .ADDR_WIDTH(ADDR_WIDTH),
    .RESP_WIDTH(RESP_WIDTH)
   ) multiplier_instiate (
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

endmodule