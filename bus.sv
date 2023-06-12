module bus #(
    parameter DATA_WIDTH = 32,
    parameter ADDR_WIDTH = 8,
    parameter RESP_WIDTH = 3
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
    output reg [RESP_WIDTH - 1:0] s0_axi_bresp,
    output reg s0_axi_bvalid,
    input s0_axi_bready,

    // Read address channel
    input [ADDR_WIDTH-1:0] s0_axi_araddr,
    input s0_axi_arvalid,
    output reg s0_axi_arready,

    // Read data channel
    output reg [DATA_WIDTH-1:0] s0_axi_rdata,
    output reg [RESP_WIDTH - 1:0] s0_axi_rresp,
    output reg s0_axi_rvalid,
    input s0_axi_rready,

/* master interface 1*/
   // Global signals
    input m1_axi_aclk,
    input m1_axi_aresetn,

    // Write address channel
    output  reg [ADDR_WIDTH-1:0] m1_axi_awaddr,
    output  reg m1_axi_awvalid,
    input  m1_axi_awready,

    // Write data channel
    output  reg [DATA_WIDTH-1:0] m1_axi_wdata,
    output  reg [DATA_WIDTH/8:0] m1_axi_wstrb,
    output  reg m1_axi_wvalid,
    input  m1_axi_wready,

    // Write response channel
    input  [RESP_WIDTH - 1:0] m1_axi_bresp,
    input  m1_axi_bvalid,
    output reg m1_axi_bready,

    // Read address channel
    output reg [ADDR_WIDTH-1:0] m1_axi_araddr,
    output reg m1_axi_arvalid,
    input  m1_axi_arready,

    // Read data channel
    input  [DATA_WIDTH-1:0] m1_axi_rdata,
    input  [RESP_WIDTH - 1:0] m1_axi_rresp,
    input  m1_axi_rvalid,
    output reg m1_axi_rready,

    
/* master interface 2*/
   // Global signals
    input m2_axi_aclk,
    input m2_axi_aresetn,

    // Write address channel
    output  reg [ADDR_WIDTH-1:0] m2_axi_awaddr,
    output  reg m2_axi_awvalid,
    input  m2_axi_awready,

    // Write data channel
    output  reg [DATA_WIDTH-1:0] m2_axi_wdata,
    output  reg [DATA_WIDTH/8:0] m2_axi_wstrb,
    output  reg m2_axi_wvalid,
    input  m2_axi_wready,

    // Write response channel
    input  [RESP_WIDTH - 1:0] m2_axi_bresp,
    input  m2_axi_bvalid,
    output reg m2_axi_bready,

    // Read address channel
    output reg [ADDR_WIDTH-1:0] m2_axi_araddr,
    output reg m2_axi_arvalid,
    input  m2_axi_arready,

    // Read data channel
    input  [DATA_WIDTH-1:0] m2_axi_rdata,
    input  [RESP_WIDTH - 1:0] m2_axi_rresp,
    input  m2_axi_rvalid,
    output reg m2_axi_rready
);
// Internal registers for slave 1
reg [DATA_WIDTH-1:0] cached_slave1_read_data;
reg [ADDR_WIDTH-1:0] cached_slave1_read_address;
reg [DATA_WIDTH-1:0] cached_slave1_write_data;
reg  cached_slave1_write_valid_data;
reg [ADDR_WIDTH-1:0] cached_slave1_write_address;
reg [DATA_WIDTH/8:0] cached_slave1_wstrb;
reg  cached_slave1_write_valid_address;


// Internal registers for slave 2
reg [DATA_WIDTH-1:0] cached_slave2_read_data;
reg [ADDR_WIDTH-1:0] cached_slave2_read_address;
reg [DATA_WIDTH-1:0] cached_slave2_write_data;
reg [ADDR_WIDTH-1:0] cached_slave2_write_address;
reg [DATA_WIDTH/8:0] cached_slave2_wstrb;
reg  cached_slave2_write_valid_data;
reg  cached_slave2_write_valid_address;

// finite state machines
  typedef enum {IDLE_WRITE,VALID_WRITE_ADDR,VALID_WRITE_DATA, WRITE_TO_SLAVE1, WRITE_TO_SLAVE2, NOTIFY_MASTER } writing_states;
  typedef enum {IDLE_READ, VALID_READ_ADDR, READ_FROM_SLAVE1, READ_FROM_SLAVE2, CACHE_DATA_FROM_SLAVE1,CACHE_DATA_FROM_SLAVE2, WRITE_TO_MASTER } reading_states;
  writing_states write_state;
  reading_states read_state;

// Writing to the slave
always @(posedge s0_axi_aclk) begin
    if (s0_axi_aresetn == 0) begin
      write_state = IDLE_WRITE;
      s0_axi_awready <= 0;
      s0_axi_wready <= 0;
    end else begin
      case (write_state)
        IDLE_WRITE: begin
          s0_axi_wready <= 1;
          s0_axi_awready <= 1;
          if (s0_axi_awvalid) begin
              write_state = VALID_WRITE_ADDR;
          end
        end
        VALID_WRITE_ADDR: begin
          s0_axi_wready <= 0;
          s0_axi_awready <= 0;
          if(s0_axi_awaddr == 0 || s0_axi_awaddr == 4)begin
                cached_slave1_write_address <= s0_axi_awaddr;
                cached_slave1_write_valid_address <= s0_axi_awvalid;
                write_state = VALID_WRITE_DATA;
              end 
          if(s0_axi_awaddr == 16 || s0_axi_awaddr == 20) begin
                cached_slave2_write_address <= s0_axi_awaddr;
                cached_slave2_write_valid_address <= s0_axi_awvalid;
                write_state = VALID_WRITE_DATA;
              end 
          // if (s0_axi_wvalid && s0_axi_bready) begin
          //     write_state = VALID_WRITE_DATA;
          // end
        end
        VALID_WRITE_DATA: begin
            if(cached_slave1_write_address == 0 || cached_slave1_write_address == 4)begin
                cached_slave1_write_data <= s0_axi_wdata;
                cached_slave1_wstrb <= s0_axi_wstrb;
                cached_slave1_write_valid_data <= s0_axi_wvalid;
                write_state = WRITE_TO_SLAVE1;
              end 
            if(cached_slave2_write_address == 16 || cached_slave2_write_address == 20) begin
                cached_slave2_write_data <= s0_axi_wdata;
                cached_slave2_wstrb <= s0_axi_wstrb;
                cached_slave2_write_valid_data <= s0_axi_wvalid;
                write_state = WRITE_TO_SLAVE2;
              end 
        end
        WRITE_TO_SLAVE1: begin
          if (m1_axi_awready && m1_axi_wready) begin
            m1_axi_awaddr <= cached_slave1_write_address;
            m1_axi_awvalid <= cached_slave1_write_valid_address;
            m1_axi_wdata <= cached_slave1_write_data;
            m1_axi_wstrb <= cached_slave1_wstrb;
            m1_axi_wvalid <= cached_slave1_write_valid_data;
            s0_axi_wready <= 0;
            s0_axi_awready <= 0;
            write_state = NOTIFY_MASTER;
          end
          m1_axi_awvalid <= 0;
          m1_axi_wvalid <= 0;
        end
        WRITE_TO_SLAVE2: begin
          if (m2_axi_awready && m2_axi_wready) begin
            m2_axi_awaddr <= cached_slave2_write_address;
            m2_axi_awvalid <= cached_slave2_write_valid_address;
            m2_axi_wdata <= cached_slave2_write_data;
            m2_axi_wstrb <= cached_slave2_wstrb;
            m2_axi_wvalid <= cached_slave2_write_valid_data;
            s0_axi_wready <= 0;
            s0_axi_awready <= 0;
            write_state = NOTIFY_MASTER;
          end
          m2_axi_awvalid <= 0;
          m2_axi_wvalid <= 0;
        end
        NOTIFY_MASTER: begin
          if(m1_axi_bresp == 0 && m1_axi_bvalid== 0) begin
            m1_axi_bready <= 1;
            s0_axi_wready <= 1;
            s0_axi_awready <= 1;
            write_state = IDLE_WRITE;
          end 
          if(m2_axi_bresp== 0 && m2_axi_bvalid== 0) begin
            m2_axi_bready <= 1;
            s0_axi_wready <= 1;
            s0_axi_awready <= 1;
            write_state = IDLE_WRITE;
          end   
        end
        
      endcase
    end
  end

// Reading from the slave
always @(posedge m1_axi_aclk ,m2_axi_aclk) begin
    if (m1_axi_aresetn == 0) begin
       s0_axi_arready <= 0;
       read_state<=IDLE_READ;
    end else begin
      case (read_state)
        IDLE_READ: begin 
          s0_axi_arready <= 1;
          m1_axi_rready <= 0;
          if(s0_axi_arvalid ) begin
            read_state<=VALID_READ_ADDR;
          end
        end
        VALID_READ_ADDR: begin
            if(s0_axi_araddr == 8 || s0_axi_araddr == 12)begin
                cached_slave1_read_address <= s0_axi_araddr;
                s0_axi_arready <= 0;
                s0_axi_rvalid <= 1;
                read_state = READ_FROM_SLAVE1;
               end 
           if(s0_axi_araddr == 24 || s0_axi_araddr == 28) begin
                 cached_slave2_read_address <= s0_axi_araddr;
                 s0_axi_rvalid <= 1;
                 s0_axi_arready <= 0;
                 read_state = READ_FROM_SLAVE2;
              end 
              s0_axi_rvalid <= 0;
              s0_axi_arready <= 1;

        end
        READ_FROM_SLAVE1: begin
          
          if(m1_axi_arready) begin
            m1_axi_araddr <= cached_slave1_read_address;
            m1_axi_arvalid <= 1;
            read_state = CACHE_DATA_FROM_SLAVE1;
          end
          m1_axi_arvalid <= 0;
        end
        READ_FROM_SLAVE2: begin
          if(m2_axi_arready) begin
            m2_axi_araddr <= cached_slave2_read_address;
            m2_axi_arvalid <= 1;
            m2_axi_rready <= 0;
            read_state = CACHE_DATA_FROM_SLAVE2;
          end
          m2_axi_arvalid <= 0;
          m2_axi_rready <= 1;
        end
        CACHE_DATA_FROM_SLAVE1: begin
          
          if(m1_axi_rvalid) begin
            cached_slave1_read_data <= m1_axi_rdata;
            m1_axi_rready <= 0;
          end
          m1_axi_rready <= 1;
          read_state = WRITE_TO_MASTER;
          
        end
        CACHE_DATA_FROM_SLAVE2: begin
          m2_axi_rready <= 1;
          if(m2_axi_rvalid) begin
            cached_slave2_read_data <= m2_axi_rdata;
            m2_axi_rready <= 0;
            read_state = WRITE_TO_MASTER;
          end
          
        end
        WRITE_TO_MASTER: begin
          s0_axi_rresp <= 0;
          if(s0_axi_rready) begin
            if(m1_axi_rresp == 0) begin
              s0_axi_rdata <= cached_slave1_read_data;
              s0_axi_rvalid <= 1;
              s0_axi_rresp <= 0;
              read_state = IDLE_READ;
            end 
            if(m2_axi_rresp == 0) begin
              s0_axi_rdata <= cached_slave2_read_data;
              s0_axi_rresp <= 0;
              read_state = IDLE_READ;
            end
          end
        end
        
      endcase
    end
  end

endmodule