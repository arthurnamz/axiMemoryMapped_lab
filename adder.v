module adder#(
    parameter MEM_SIZE = 32,
    parameter DATA_WIDTH = 32,
    parameter ADDR_WIDTH = 8
)
(
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
);
reg [ADDR_WIDTH-1:0] memory [0:MEM_SIZE - 1];
wire [DATA_WIDTH-1:0] operandA;
wire [DATA_WIDTH-1:0] operandB;
wire [DATA_WIDTH-1:0] result;
wire [DATA_WIDTH-1:0] overflow;

// write address channel
always @(posedge s0_axi_aclk) begin
    if (!s0_axi_aresetn)
        begin
            s0_axi_awready <= 1'b0;
        end
        else if (s0_axi_awvalid)
        begin
            if (s0_axi_wstrb[0])
                memory[0] <= s0_axi_awaddr[0];
            if (s0_axi_wstrb[1])
                memory[1] <= s0_axi_awaddr[1];
            if (s0_axi_wstrb[2])
                memory[2] <= s0_axi_awaddr[2];
            if (s0_axi_wstrb[3])
                memory[3] <= s0_axi_awaddr[3];

            if (s0_axi_wstrb[0])
                memory[4] <= s0_axi_awaddr[5];
            if (s0_axi_wstrb[1])
                memory[5] <= s0_axi_awaddr[6];
            if (s0_axi_wstrb[2])
                memory[6] <= s0_axi_awaddr[7];
            if (s0_axi_wstrb[3])
                memory[7] <= s0_axi_awaddr[8];

            s0_axi_awready <= 1'b1;
        end
end

            assign operandA = s0_axi_wdata[15:0];
            assign operandB = s0_axi_wdata[31:16];
            assign result = operandA + operandB;

// Write data channel
always @(posedge s0_axi_aclk) begin
    if (!s0_axi_aresetn)
        begin
            s0_axi_awready <= 1'b1;
        end
        else if (s0_axi_awvalid && s0_axi_wvalid)
        begin
            if (s0_axi_wstrb[0])
                memory[0] <= operandA[7:0];
            if (s0_axi_wstrb[1])
                memory[1] <= operandA[15:8];
            if (s0_axi_wstrb[2])
                memory[2] <= operandA[23:16];
            if (s0_axi_wstrb[3])
                memory[3] <= operandA[31:24];

            if (s0_axi_wstrb[0])
                memory[4] <= operandB[7:0];
            if (s0_axi_wstrb[1])
                memory[65] <= operandB[15:8];
            if (s0_axi_wstrb[2])
                memory[6] <= operandB[23:16];
            if (s0_axi_wstrb[3])
                memory[7] <= operandB[31:24];

             memory[11:8] <= result;
             memory[15:12] <= overflow;
            // Write response channel
            s0_axi_bvalid <= 1'b0;
            s0_axi_bresp <= 2'b00;
        end
end

endmodule