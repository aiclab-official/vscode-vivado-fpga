module test_fullAdder;
    timeunit 1ns; timeprecision 100ps;
    import tb_utils_pkg::*;
    // Testbench signals
    logic a, b, cin;
    logic sum, cout;
    int error_count = 0;

    logic exp_sum;
    logic exp_cout;
    
    // Instantiate the full adder
    fullAdder dut (
        .a(a),
        .b(b),
        .cin(cin),
        .sum(sum),
        .cout(cout)
    );
    
    // Test stimulus
    initial begin
        $display("Starting Full Adder tests...");
        
        // Test all possible input combinations
        for (int test = 0; test < 8; test++) begin
            {a, b, cin} = test[2:0];
            #10;
            
            // Calculate expected outputs
            exp_sum = a ^ b ^ cin;
            exp_cout = (a & b) | (b & cin) | (a & cin);
            
            // Check results
            if (sum !== exp_sum || cout !== exp_cout) begin
                error_count++;
                $error("Test failed: a=%b, b=%b, cin=%b, Expected: sum=%b, cout=%b, Got: sum=%b, cout=%b",
                       a, b, cin, exp_sum, exp_cout, sum, cout);
            end else begin
                $display("Test passed: a=%b, b=%b, cin=%b, sum=%b, cout=%b",
                        a, b, cin, sum, cout);
            end
        end
        
        // Display test results
        display_result(error_count);
        if (error_count == 0)
            $display("All tests passed!");
        else
            $display("Some tests failed! Error count: %0d", error_count);
            
        $finish;
    end

endmodule : test_fullAdder