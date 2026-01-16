module day3_lobby (
    digit,
    reset,
    clock,
    start,
    done_,
    result
);

    input [3:0] digit;
    input reset;
    input clock;
    input start;
    output done_;
    output [7:0] result;

    wire [3:0] _20;
    wire [3:0] _22;
    wire [3:0] _1;
    reg [3:0] _21;
    wire [7:0] _27;
    wire [3:0] _24;
    wire [3:0] _3;
    wire _18;
    wire [3:0] _23;
    wire [3:0] _4;
    reg [3:0] _17;
    wire [7:0] _25;
    wire [7:0] _28;
    wire _30;
    wire _7;
    wire _9;
    wire vdd;
    wire _11;
    wire _32;
    wire _12;
    reg _31;
    assign _20 = 4'b0000;
    assign _22 = _18 ? _17 : _21;
    assign _1 = _22;
    always @(posedge _9) begin
        if (_7)
            _21 <= _20;
        else
            _21 <= _1;
    end
    assign _27 = { _20,
                   _21 };
    assign _24 = 4'b1010;
    assign _3 = digit;
    assign _18 = _17 < _3;
    assign _23 = _18 ? _3 : _17;
    assign _4 = _23;
    always @(posedge _9) begin
        if (_7)
            _17 <= _20;
        else
            _17 <= _4;
    end
    assign _25 = _17 * _24;
    assign _28 = _25 + _27;
    assign _30 = 1'b0;
    assign _7 = reset;
    assign _9 = clock;
    assign vdd = 1'b1;
    assign _11 = start;
    assign _32 = _11 ? vdd : _31;
    assign _12 = _32;
    always @(posedge _9) begin
        if (_7)
            _31 <= _30;
        else
            _31 <= _12;
    end
    assign done_ = _31;
    assign result = _28;

endmodule
