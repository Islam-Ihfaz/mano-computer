/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_islam_ihfaz_mano_computer(
    input wire [7:0] ui_in,    // {clock, IR[1:0], 5 unused}
    output wire [7:0] uo_out,   // {A[7:0]}
    input wire [7:0] uio_in,
    output wire [7:0] uio_out,
    output wire [7:0] uio_oe,
    input wire ena,
    input wire clk,
    input wire rst_n
);

    wire clock = ui_in[7];
    wire IR0 = ui_in[0];
    wire IR1 = ui_in[1];

    wire t0, t1, t2, t3, t4, x1, x2, x3, x4, x5, x6, x7, q1, q2, q3;
    wire t5, t6, t7, x8;

    reg SysClk = 0;
    reg [7:0] mem[0:8];
    reg [7:0] MAR = 0, MBR = 0, IR = 0, A = 0, R = 0, PC = 0;
    reg [2:0] T = 0;
    reg [25:0] count = 0;

    // Instruction decoder
    OpDecoder opl(.ir0(IR0), .ir1(IR1), .q1(q1), .q2(q2), .q3(q3));

    // Timing decoder
    TimeDecoder tmr1(.t(T), .t0(t0), .t1(t1), .t2(t2), .t3(t3), .t4(t4),
                     .t5(t5), .t6(t6), .t7(t7));

    // Control logic
    Logic log1(
        .q1(q1), .q2(q2), .q3(q3), .t0(t0), .t1(t1), .t2(t2), .t3(t3), .t4(t4),
        .t5(t5), .t6(t6), .t7(t7),
        .x1(x1), .x2(x2), .x3(x3), .x4(x4), .x5(x5), .x6(x6), .x7(x7), .x8(x8)
    );

    // Reset logic
    always @(negedge rst_n) begin
        SysClk <= 0;
        MAR <= 0;
        MBR <= 0;
        PC <= 0;
        IR <= 0;
        A <= 0;
        R <= 0;
        T <= 0;
    end

    // Micro-operations
    always @(posedge x1 or posedge x2)
        if (x1) MAR <= PC;
        else    MAR <= MBR;

    always @(posedge x3) PC <= PC + 1;
    always @(posedge x4) MBR <= mem[MAR];

    always @(posedge x5 or posedge x6)
        if (x5) A <= MBR;
        else    A <= R;

    always @(posedge x7) T <= 3'b000;

    always @(posedge SysClk)
        if (!x7) T <= T + 1;

    always @(posedge x8) IR <= MBR;

    // Clock divider to generate SysClk from user clock
    always @(posedge clock) begin
        count <= count + 1;
        if (count == 50_000_000) begin
            count <= 0;
            SysClk <= ~SysClk;
        end
    end

    // Output the accumulator value
    assign uo_out = A;

    assign uio_out = 8'b0;
    assign uio_oe  = 8'b0;

    // List all unused inputs to prevent warnings
    wire _unused = &{ena, clk, rst_n, ui_in[6:2], uio_in, 1'b0};

endmodule
