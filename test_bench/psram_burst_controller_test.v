`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:   21:14:17 07/23/2016
// Design Name:   psram_burst_controller
// Module Name:   /home/manuel/Documents/myCode/hdl/verilog/psram_controller/test_bench/psram_burst_controller_test.v
// Project Name:  psram_controller
// Target Device:
// Tool versions:
// Description:
//
// Verilog Test Fixture created by ISE for module: psram_burst_controller
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
////////////////////////////////////////////////////////////////////////////////

module psram_burst_controller_test;

    // Inputs
    reg rst_i;
    reg clk_i;
    reg [15:0] adr_i;
    reg [15:0] dat_i;
    reg start_i;
    reg we_i;
    reg [15:0] psram_dat_i;

    // Outputs
    wire [15:0] dat_o;
    wire psram_clk;
    wire [22:0] psram_adr;
    wire [15:0] psram_dat_o;
    wire psram_data_oe;
    wire psram_we_n;
    wire psram_ce_n;
    wire psram_adv_n;
    wire psram_oe_n;

    // Instantiate the Unit Under Test (UUT)
    psram_burst_controller uut (
        .rst_i(rst_i),
        .clk_i(clk_i),
        .adr_i(adr_i),
        .dat_i(dat_i),
        .dat_o(dat_o),
        .start_i(start_i),
        .we_i(we_i),
        .psram_clk(psram_clk),
        .psram_adr(psram_adr),
        .psram_dat_o(psram_dat_o),
        .psram_dat_i(psram_dat_i),
        .psram_data_oe(psram_data_oe),
        .psram_we_n(psram_we_n),
        .psram_ce_n(psram_ce_n),
        .psram_adv_n(psram_adv_n),
        .psram_oe_n(psram_oe_n)
    );
    integer counter = 55;

    initial begin
        // Reset
        rst_i = 1;
        clk_i = 0;
        adr_i = 0;
        dat_i = counter + 10;
        start_i = 0;
        we_i = 0;
        psram_dat_i = counter;
        #5;
        clk_i = 1;
        counter = counter + 1;
        #5;

        // Start write
        rst_i = 0;
        clk_i = 0;
        adr_i = 1234567;
        dat_i = counter + 10;
        start_i = 1;
        we_i = 1;
        psram_dat_i = counter;
        #5;
        clk_i = 1;
        counter = counter + 1;
        #5;


        repeat(50)begin
            rst_i = 0;
            clk_i = 0;
            adr_i = 0;
            dat_i = counter + 20;
            start_i = 0;
            we_i = 1;
            psram_dat_i = counter;
            #5;
            counter = counter + 1;
            clk_i = 1;
            #5;
        end

        // Start read cycle
        rst_i = 0;
        clk_i = 0;
        adr_i = 256;
        dat_i = counter + 10;
        start_i = 1;
        we_i = 0;
        psram_dat_i = counter;
        #5;
        clk_i = 1;
        counter = counter + 1;
        #5;

        repeat(50)begin
            rst_i = 0;
            clk_i = 0;
            adr_i = 0;
            dat_i = counter + 10;
            start_i = 0;
            we_i = 1;
            psram_dat_i = counter;
            #5;
            clk_i = 1;
            counter = counter + 1;
            #5;
        end

    end

endmodule

