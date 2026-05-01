/**
 * Half Adder module
 * Performs single-bit binary addition of two inputs
 *
 * @param a    First input operand (1 bit)
 * @param b    Second input operand (1 bit)
 * @param sum  Sum output (1 bit)
 * @param cout Carry output (1 bit)
 * 
 * Truth Table:
 * a b | sum cout
 * 0 0 |  0   0
 * 0 1 |  1   0
 * 1 0 |  1   0
 * 1 1 |  0   1
 */
module halfAdder (
    input  logic a, b,
    output logic sum, cout
);
    timeunit 1ns; timeprecision 100ps;
    assign sum  = a ^ b;
    assign cout = a & b;
endmodule : halfAdder