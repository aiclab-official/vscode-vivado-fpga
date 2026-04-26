// tb_utils.sv
package tb_utils_pkg;
    timeunit 1ns; timeprecision 100ps;

    int error_count = 0;

    task automatic display_result(input int error_count);
        if (error_count == 0) begin
            $display("\n\033[1;32m");  // Green color
            $display("*************************************************");
            $display("*   _______     _       ______    ______   _    *");
            $display("*  |_   __ \\   / \\    .' ____ \\ .' ____ \\ | |   *");
            $display("*    | |__) | / _ \\   | (___ \\_|| (___ \\_|| |   *");
            $display("*    |  ___/ / ___ \\   _.____`.  _.____`. | |   *");
            $display("*   _| |_  _/ /   \\ \\_| \\____) || \\____) ||_|   *");
            $display("*  |_____||____| |____|\\______.' \\______.'(_)   *");
            $display("*                                               *");
            $display("*************************************************");
            $display("\033[0m");  // Reset color
        end else begin
            $display("\n\033[1;31m");  // Red color
            $display("***********************************************");
            $display("*   ________    _       _____  _____     _    *");
            $display("*  |_   __  |  / \\     |_   _||_   _|   | |   *");
            $display("*    | |_ \\_| / _ \\      | |    | |     | |   *");
            $display("*    |  _|   / ___ \\     | |    | |   _ | |   *");
            $display("*   _| |_  _/ /   \\ \\_  _| |_  _| |__/ ||_|   *");
            $display("*  |_____||____| |____||_____||________|(_)   *");
            $display("*                                             *");
            $display("***********************************************");
            $display("\033[0m");  // Reset color
            $display("Total Errors: %0d", error_count);
        end
    endtask

endpackage