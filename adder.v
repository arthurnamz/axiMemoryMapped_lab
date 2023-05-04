module adder#(
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

reg [DATA_WIDTH-1:0] operandA;
reg [DATA_WIDTH-1:0] operandB;
reg [DATA_WIDTH-1:0] result;

// Read address channel
always @(posedge s0_axi_aclk) begin
    if (s0_axi_aresetn == 0) begin
        operandA <= 0;
        operandB <= 0;
    end else if (s0_axi_arvalid && s0_axi_arready) begin
        operandA <= s0_axi_rdata;
        operandB <= s0_axi_rdata;
    end
end

// Write address channel
assign s0_axi_awready = 1'b1;

// Write data channel
always @(posedge s0_axi_aclk) begin
    if (!s0_axi_aresetn)
        begin
            operandA <= 0;
            operandB <= 0;
            result <= 0;
            s0_axi_rdata <= 0;
        end
        else if (s0_axi_awvalid && s0_axi_wvalid)
        begin
            if (s0_axi_wstrb[0])
                operandA[7:0] <= s0_axi_wdata[7:0];
            if (s0_axi_wstrb[1])
                operandA[15:8] <= s0_axi_wdata[15:8];
            if (s0_axi_wstrb[2])
                operandA[23:16] <= s0_axi_wdata[23:16];
            if (s0_axi_wstrb[3])
                operandA[31:24] <= s0_axi_wdata[31:24];

            if (s0_axi_wstrb[4])
                operandB[7:0] <= s0_axi_wdata[7:0];
            if (s0_axi_wstrb[5])
                operandB[15:8] <= s0_axi_wdata[15:8];
            if (s0_axi_wstrb[6])
                operandB[23:16] <= s0_axi_wdata[23:16];
            if (s0_axi_wstrb[7])
                operandB[31:24] <= s0_axi_wdata[31:24];

            result <= operandA + operandB;
        end
end

// Write response channel
assign s0_axi_bvalid = 1'b0;
assign s0_axi_bresp = 2'b00;

// Read data channel
always @(posedge s0_axi_aclk) begin
    if (s0_axi_aresetn == 0) begin
        s0_axi_rdata <= 0;
        s0_axi_rresp <= 2'b0;
        s0_axi_rvalid <= 1'b0;
    end else if (s0_axi_arvalid && s0_axi_arready) begin
        s0_axi_rdata <= result;
        s0_axi_rresp <= 2'b0;
        s0_axi_rvalid <= 1'b1;
    end
end

endmodule


// reg [DATA_WIDTH-1:0] operandA, operandB, result;
//     wire carry;

//     assign carry = result[DATA_WIDTH-1] & (operandA[DATA_WIDTH-1] ^ operandB[DATA_WIDTH-1]);

//     always @ (posedge s0_axi_aclk)
//     begin
//         if (!s0_axi_aresetn)
//         begin
//             operandA <= 0;
//             operandB <= 0;
//             result <= 0;
//             s0_axi_rdata <= 0;
//         end
//         else if (s0_axi_awvalid && s0_axi_wvalid)
//         begin
//             if (s0_axi_wstrb[0])
//                 operandA[7:0] <= s0_axi_wdata[7:0];
//             if (s0_axi_wstrb[1])
//                 operandA[15:8] <= s0_axi_wdata[15:8];
//             if (s0_axi_wstrb[2])
//                 operandA[23:16] <= s0_axi_wdata[23:16];
//             if (s0_axi_wstrb[3])
//                 operandA[31:24] <= s0_axi_wdata[31:24];

//             if (s0_axi_wstrb[4])
//                 operandB[7:0] <= s0_axi_wdata[7:0];
//             if (s0_axi_wstrb[5])
//                 operandB[15:8] <= s0_axi_wdata[15:8];
//             if (s0_axi_wstrb[6])
//                 operandB[23:16] <= s0_axi_wdata[23:16];
//             if (s0_axi_wstrb[7])
//                 operandB[31:24] <= s0_axi_wdata[31:24];

//             result <= operandA + operandB;
//         end
//         else if (s0_axi_arvalid && s0_axi_rready)
//         begin
//             if (s0_axi_araddr[ADDR_WIDTH-1:0] == 0)
//                 s0_axi_rdata <= result;
//         end
//     end






