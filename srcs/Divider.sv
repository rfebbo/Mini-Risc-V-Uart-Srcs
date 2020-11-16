// TODO: Maybe merge divsel and mulsel to alusel?
module Divider
(
    input  logic        clk,
    input  logic [31:0] a,
    input  logic [31:0] b,
    input  logic        valid,
    input  logic [1:0]  divsel,
    output logic [31:0] res
);

    reg         busy;
    reg         ready;
    reg   [4:0] count;
    reg  [31:0] rem;
    reg  [31:0] quot;
    reg         a_sign;
    reg         b_sign;
    wire [31:0] div_a;
    wire [31:0] div_b;
    wire        negative;
    wire [32:0] sub;
    wire [31:0] quotient;
    wire [31:0] remainder;

    always @(posedge clk) begin
        a_sign   <= (divsel == 2'b00) || (divsel == 2'b10);
        b_sign   <= (divsel == 2'b00) || (divsel == 2'b10);
    end
    
    assign div_a     = (a_sign && a[31]) ? -a : a;
    assign div_b     = (b_sign && b[31]) ? -b : b;
    assign negative  = (a_sign && a[31]) ^ (b_sign && b[31]);
    assign sub       = {1'b0, rem[30:0], quot[31]} - {1'b0, div_b};
    assign quotient  = negative ? -quot : quot;
    assign remainder = negative ? -rem : rem;

    always @(posedge clk)
    begin
        if (valid)
        begin
            busy  <= 1'b1;
            count <= 5'd31;
            quot  <= div_a;
            rem   <= 32'h0;
        end
        else if (ready)
        begin
            ready <= 1'b0;
        end
        else if (busy)
        begin
            count <= count - 5'd1;
            quot  <= {quot[30:0], !sub[32]};      

            if (sub[32])
                rem <= {rem[30:0], quot[31]};
            else
                rem <= sub[31:0];

            if (count == 5'd0)
            begin
                busy  <= 1'b0;
                ready <= 1'b1;
            end
        end
    end

    always @*
    begin
      case (divsel)
    	2'b00:   res = quotient;  //div
    	2'b01:   res = quotient;  //divu
    	2'b10:   res = remainder; //rem
    	2'b11:   res = remainder; //remu
        default: res = 32'h0;
      endcase
    end
endmodule: Divider

