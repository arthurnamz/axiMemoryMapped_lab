`timescale 1ns/1ps
module wrapper_tb;
    parameter DATA_WIDTH = 32;
    parameter ADDR_WIDTH = 8;
    parameter RESP_WIDTH = 3;

    reg s3_axi_aclk = 0;
    reg s3_axi_aresetn;

    // Write address channel
    reg [ADDR_WIDTH-1:0] s3_axi_awaddr;
    reg s3_axi_awvalid;
    wire s3_axi_awready;

    // Write data channel
    reg [DATA_WIDTH-1:0] s3_axi_wdata;
    reg [DATA_WIDTH/8:0] s3_axi_wstrb;
    reg s3_axi_wvalid;
    wire s3_axi_wready;

    // Write response channel
    wire [RESP_WIDTH - 1:0] s3_axi_bresp;
    wire s3_axi_bvalid;
    reg s3_axi_bready;

    // Read address channel
    reg [ADDR_WIDTH-1:0] s3_axi_araddr;
    reg s3_axi_arvalid;
    wire s3_axi_arready;

    // Read data channel
    wire [DATA_WIDTH-1:0] s3_axi_rdata;
    wire [RESP_WIDTH - 1:0] s3_axi_rresp;
    wire s3_axi_rvalid;
    reg s3_axi_rready;

 //internal registers
  reg [7:0] write_in;
  reg [31:0] hold;

    // DuT
     wrapper#(
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH),
        .RESP_WIDTH(RESP_WIDTH)
    ) dut (
        .s3_axi_aclk(s3_axi_aclk),
        .s3_axi_aresetn(s3_axi_aresetn),
        .s3_axi_awaddr(s3_axi_awaddr),
        .s3_axi_awvalid(s3_axi_awvalid),
        .s3_axi_awready(s3_axi_awready),
        .s3_axi_wdata(s3_axi_wdata),
        .s3_axi_wstrb(s3_axi_wstrb),
        .s3_axi_wvalid(s3_axi_wvalid),
        .s3_axi_wready(s3_axi_wready),
        .s3_axi_bresp(s3_axi_bresp),
        .s3_axi_bvalid(s3_axi_bvalid),
        .s3_axi_bready(s3_axi_bready),
        .s3_axi_araddr(s3_axi_araddr),
        .s3_axi_arvalid(s3_axi_arvalid),
        .s3_axi_arready(s3_axi_arready),
        .s3_axi_rdata(s3_axi_rdata),
        .s3_axi_rresp(s3_axi_rresp),
        .s3_axi_rvalid(s3_axi_rvalid),
        .s3_axi_rready(s3_axi_rready)
    );

    // Clock generation
  always #5 s3_axi_aclk = ~s3_axi_aclk;
  
  // Reset generation
  initial begin
    s3_axi_aresetn = 0;
    #5;
    s3_axi_aresetn = 1;

    // write_in = 0;
    // #20;
    // hold = 23;
    #10;
    s3_axi_awvalid = 0;      // 1 bit
    s3_axi_wvalid = 0; 
    s3_axi_bready = 0; 
    #20; 
    s3_axi_awaddr = 0;  // 8 bits
    s3_axi_wdata = 25; // 32 bits
    s3_axi_wstrb = 15; // 4 bits
    s3_axi_bready = 1;   // 1 bit
    #10;
    s3_axi_awvalid = 0;      // 1 bit
    s3_axi_wvalid = 0; 
    s3_axi_bready = 0; 

    #20;
    s3_axi_awaddr = 4;  // 8 bits
    s3_axi_wdata = 34; // 32 bits
    s3_axi_wstrb = 15; // 4 bits
    s3_axi_bready = 1;   // 1 bit
     #10;
    s3_axi_awvalid = 0;      // 1 bit
    s3_axi_wvalid = 0; 
    s3_axi_bready = 0; 
    #30;
    s3_axi_rready = 0;
    #50;
    s3_axi_rready = 1;
    s3_axi_araddr = 8;
    s3_axi_arvalid = 0;
    #60;
    s3_axi_rready = 0;
    #80;
    s3_axi_rready = 1;
    s3_axi_araddr = 12;
    s3_axi_arvalid = 0;
    #90;
    s3_axi_rready = 0;
    
    

    #1500;
    $finish;

    end

    // always @(posedge s3_axi_aclk) begin
    // s3_axi_awvalid <= 0;      // 1 bit
    // s3_axi_wvalid <= 0; 
    // s3_axi_bready <= 0;      // 1 bit
    
    // if (s3_axi_wready && s3_axi_awready ) begin
    //     s3_axi_awaddr <= write_in;  // 8 bits
    //     s3_axi_wdata <= hold; // 32 bits
    //     s3_axi_wstrb <= 15; // 4 bits
    //     s3_axi_bready <= 1;   // 1 bit
    //     s3_axi_awvalid <= 1;      // 1 bit
    //     s3_axi_wvalid <= 1; 
        
        
    //     if (write_in == 4)begin
    //      write_in <= 0;
    //     end else begin
    //       write_in <= 4;
    //     end
        

    //     hold <= hold + 7;
    // end
    // end

    endmodule