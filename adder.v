module adder#(
    parameter DATA_WIDTH = 32,
    parameter ADDR_WIDTH = 8
)
(
    // Global signal  
    input ACLK,  // Global clock signal
    input ARESETn, //Global reset signal, of type active LOW 

    // write address channel
    input [ADDR_WIDTH-1:0] AWADDR, 
    input AWVALID,  
    output AWREADY, 

    // write data channel
    input [DATA_WIDTH-1:0] WDATA, //  (Write data, data to be sent from Master to slave)
    input [DATA_WIDTH / 8:0] WSTRB, //  (  Write strobes. This signal indicates which byte lanes hold valid data)
    input WVALID, // ( Write valid, This signal indicates that valid write data and strobes are available)
    output WREADY, // ( Write ready. This signal indicates that the slave can accept the write data)

    // write response channel
    output BRESP,  // ( Write response. This signal indicates the status of the write transaction )
    output BVALID, // ( Write response valid. This signal indicates that the channel is signaling a valid write response )
    input BREADY, // ( Response ready. This signal indicates that the master can accept a write response. )

    //Read address channel
    input [ADDR_WIDTH-1:0] ARADDR, //  ( Read address. The read address gives the address of the first transfer in a read burst transaction )
    input ARVALID, // ( Read address valid. This signal indicates that the channel is signaling valid read address and control information )
    output ARREADY, // ( Read address ready. This signal indicates that the slave is ready to accept an address and associated control signals )

    //Read data channel 
    output [DATA_WIDTH-1:0] RDATA, //  (Read data, This data is retrieved from the address which was asserted by the read address from the master)
    output RRESP, // ( Read response. This signal indicates the status of the read transfer)
    output RVALID, // ( Read valid, This signal indicates that the channel is signaling the required read data )
    input RREADY // ( Read ready. y. This signal indicates that the master can accept the read data and response information )

);

endmodule