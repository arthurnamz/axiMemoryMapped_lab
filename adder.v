module adder#(
    parameter DATA_WIDTH = 32,
    parameter ADDR_WIDTH = 8
)
(
    // Global signal  
    input s0_axi_s0_axi_aclk,  // Global clock signal
    input s0_axi_aresetn, //Global reset signal, of type active LOW 

    // write address channel
    input [ADDR_WIDTH-1:0] s0_axi_awaddr, 
    input s0_axi_awvalid,  
    output s0_axi_awready, 

    // write data channel
    input [DATA_WIDTH-1:0] s0_axi_wdata, //  (Write data, data to be sent from Master to slave)
    input [DATA_WIDTH / 8:0] s0_axi_wstrb, //  (  Write strobes. This signal indicates which byte lanes hold valid data)
    input s0_axi_wvalid, // ( Write valid, This signal indicates that valid write data and strobes are available)
    output s0_axi_wready, // ( Write ready. This signal indicates that the slave can accept the write data)

    // write response channel
    output s0_axi_bresp,  // ( Write response. This signal indicates the status of the write transaction )
    output s0_axi_bvalid, // ( Write response valid. This signal indicates that the channel is signaling a valid write response )
    input s0_axi_bready, // ( Response ready. This signal indicates that the master can accept a write response. )

    //Read address channel
    input [ADDR_WIDTH-1:0] s0_axi_araddr, //  ( Read address. The read address gives the address of the first transfer in a read burst transaction )
    input s0_axi_arvalid, // ( Read address valid. This signal indicates that the channel is signaling valid read address and control information )
    output s0_axi_arready, // ( Read address ready. This signal indicates that the slave is ready to accept an address and associated control signals )

    //Read data channel 
    output [DATA_WIDTH-1:0] s0_axi_rdata, //  (Read data, This data is retrieved from the address which was asserted by the read address from the master)
    output s0_axi_rresp, // ( Read response. This signal indicates the status of the read transfer)
    output s0_axi_rvalid, // ( Read valid, This signal indicates that the channel is signaling the required read data )
    input s0_axi_rready // ( Read ready. y. This signal indicates that the master can accept the read data and response information )

);

endmodule