/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_main (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset -- active low
);

  // All output pins must be assigned. If not used, assign to 0.
  // assign uo_out  = ui_in + uio_in;  // Example: ou_out is the sum of ui_in and uio_in
  assign uio_out = 0;
  assign uio_oe  = 0;

  // ------------------------------------------------------ //
  // Example of detecting rising clock edge in a process
  // ------------------------------------------------------ //

  // counter bits - set to 0 in beginning
  reg [7:0] counter = 0;

  // assign counter to output
  // no need to ever manually assign counter to uo_out
  assign uo_out = counter;

  // this handles incrementation by 1
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      // we use <= becuase non-blocking assignment is needed for sequential logic
      // reset counter to 0 on reset
      counter <= 8'h00;

    end else begin
      // we use <= becuase non-blocking assignment is needed for sequential logic
      // increment counter by 1 on each clock cycle
      counter <= counter + 1; 
    end
  end



  // ------------------------------------------------------ //

  // List all unused inputs to prevent warnings
  wire _unused = &{ena, 1'b0};

endmodule
