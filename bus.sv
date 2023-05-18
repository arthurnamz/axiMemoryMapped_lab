module bus#(
    parameter DATA_WIDTH = 32,
    parameter ADDR_WIDTH = 8
)
(

 /* slave interface */   
    // Global signals
    input s0_axi_aclk,
    input s0_axi_aresetn,

    // Write address channel
    input [ADDR_WIDTH-1:0] s0_axi_awaddr,
    input s0_axi_awvalid,
    output reg s0_axi_awready,

    // Write data channel
    input [DATA_WIDTH-1:0] s0_axi_wdata,
    input [DATA_WIDTH/8:0] s0_axi_wstrb,
    input s0_axi_wvalid,
    output reg s0_axi_wready,

    // Write response channel
    output reg s0_axi_bresp,
    output reg s0_axi_bvalid,
    input s0_axi_bready,

    // Read address channel
    input [ADDR_WIDTH-1:0] s0_axi_araddr,
    input s0_axi_arvalid,
    output reg s0_axi_arready,

    // Read data channel
    output reg [DATA_WIDTH-1:0] s0_axi_rdata,
    output reg s0_axi_rresp,
    output reg s0_axi_rvalid,
    input s0_axi_rready

/* master interface */
   // Global signals
    input m1_axi_aclk,
    input m1_axi_aresetn,

    // Write address channel
    output  [ADDR_WIDTH-1:0] m1_axi_awaddr,
    output  m1_axi_awvalid,
    input  m1_axi_awready,

    // Write data channel
    output  [DATA_WIDTH-1:0] m1_axi_wdata,
    output  [DATA_WIDTH/8:0] m1_axi_wstrb,
    output  m1_axi_wvalid,
    input  m1_axi_wready,

    // Write response channel
    input  m1_axi_bresp,
    input  m1_axi_bvalid,
    output reg m1_axi_bready,

    // Read address channel
    output reg [ADDR_WIDTH-1:0] m1_axi_araddr,
    output reg m1_axi_arvalid,
    input  m1_axi_arready,

    // Read data channel
    input  [DATA_WIDTH-1:0] m1_axi_rdata,
    input  m1_axi_rresp,
    input  m1_axi_rvalid,
    output reg m1_axi_rready
);
// Internal registers
reg [DATA_WIDTH-1:0] cached_read_data;
reg [ADDR_WIDTH-1:0] cached_read_address;
reg [DATA_WIDTH-1:0] cached_write_data;
reg [ADDR_WIDTH-1:0] cached_write_address;
reg [DATA_WIDTH/8:0] cached_wstrb;


// finite state machines
  typedef enum {IDLE_WRITE,VALID_WRITE_ADDR,VALID_WRITE_DATA, WRITE_TO_SLAVE, NOTIFY_MASTER } writing_states;
  typedef enum {IDLE_READ, VALID_READ_ADDR, READ_FROM_SLAVE, CACHE_DATA, WRITE_TO_MASTER } reading_states;
  writing_states write_state;
  reading_states read_state;

// Writing to the slave
always @(posedge s0_axi_aclk) begin
    if (s0_axi_aresetn == 0) begin
      s0_axi_awready <= 0;
      s0_axi_wready <= 0;
    end else begin
      case (write_state)
        IDLE_WRITE: begin
          s0_axi_awready <= 1;
          s0_axi_wready <= 1;
        end
        VALID_WRITE_ADDR: begin
          s0_axi_awready <= 0;
            if (s0_axi_awvalid) begin
                cached_write_address <= s0_axi_awaddr;
                s0_axi_awready <= 1;
            end 
        end
        VALID_WRITE_DATA: begin
          s0_axi_wready <= 0;
            if (s0_axi_wvalid && s0_axi_bready) begin
                cached_write_data <= s0_axi_wdata;
                cached_wstrb <= s0_axi_wstrb;
                s0_axi_wready <= 1;
                s0_axi_bresp <= 1;
                s0_axi_bvalid <= 1;
            end
        end
        WRITE_TO_SLAVE: begin
          if (m1_axi_awready && m1_axi_wready) begin
            m1_axi_awaddr <= cached_write_address;
            m1_axi_wdata <= cached_write_data;
            m1_axi_wstrb <= cached_wstrb;
            m1_axi_awvalid <= 1;
            m1_axi_wvalid <= 1;
          end
        end
        NOTIFY_MASTER: begin
          m1_axi_bready <= 0;
          if(m1_axi_bresp && m1_axi_bvalid) begin
            m1_axi_bready <= 1;
          end   
        end
        
      endcase
    end
  end

// Reading from the slave
always @(posedge m1_axi_aclk) begin
    if (m1_axi_aresetn == 0) begin
      m1_axi_arvalid <= 0;
      s0_axi_arvalid <= 0;
    end else begin
      case (read_state)
        IDLE_READ: begin
          
        end
        VALID_READ_ADDR: begin
          
        end
        READ_FROM_SLAVE: begin
          
        end
        CACHE_DATA: begin
          
        end
        WRITE_TO_MASTER: begin
          
        end
        
      endcase
    end
  end

endmodule