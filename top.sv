module top (
  input wire clk,
  input wire inc,
  input wire dec,
  output reg pwm
);

// module instantiation
pwm_gen pwm_gen_inst (
  .clk(clk),
  .inc(inc),
  .dec(dec),
  .pwm(pwm)
);

endmodule
