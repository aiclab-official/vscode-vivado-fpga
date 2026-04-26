/*******************************************************************************
* Full Adder Module
* ----------------------------------------------------------------------------- 
* This module implements a 1-bit full adder using two half adders.
* 
* Inputs:
*   - a    : First input operand
*   - b    : Second input operand
*   - cin  : Carry input from previous stage
*
* Outputs:
*   - sum  : Sum output (a + b + cin)
*   - cout : Carry output to next stage
*
* Implementation:
*   The full adder is implemented using two half adders in cascade:
*   - First half adder adds a and b
*   - Second half adder adds the result with cin
*   - Final carry out is OR of both half adder carries
*******************************************************************************/
module fullAdder (
    input  logic a, b, cin,
    output logic sum, cout
);
    logic s1, c1, c2;

    halfAdder ha1 (.a(a), .b(b), .sum(s1), .cout(c1));
    halfAdder ha2 (.a(s1), .b(cin), .sum(sum), .cout(c2));
    assign cout = c1 | c2;
    
endmodule : fullAdder