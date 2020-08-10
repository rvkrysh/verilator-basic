`default_nettype none

// PWM - initial duty cycle is 50%
// freq is f_clk/10

module pwm_gen (
  input wire clk,
  input wire inc, // increment duty cycle
  input wire dec, // decrement duty cycle
  output reg pwm
);

// cdc
reg inc_meta = 0;
reg inc_sync = 0;
reg dec_meta = 0;
reg dec_sync = 0;
always @(posedge clk) begin
  inc_meta <= inc;
  inc_sync <= inc_meta;
  dec_meta <= dec;
  dec_sync <= dec_meta;
end

// detect edge
reg inc_sync_q = 0;
reg inc_sync_re = 0;
reg dec_sync_q = 0;
reg dec_sync_re = 0;
always @(posedge clk) begin
  inc_sync_q <= inc_sync;
  inc_sync_re <= inc_sync && !inc_sync_q;
  dec_sync_q <= dec_sync;
  dec_sync_re <= dec_sync && !dec_sync_q;
end

// adjust duty cycle
reg [3:0] duty_cycle = 5;
always @(posedge clk) begin
  if (inc_sync_re && duty_cycle < 10)
    duty_cycle <= duty_cycle + 1;
  else if (dec_sync_re && duty_cycle > 0)
    duty_cycle <= duty_cycle - 1;
end

// generate pwm
reg [3:0] count = 0;
always @(posedge clk) begin
  count <= count + 1;
  if (count == 9)
    count <= 0;
end
assign pwm = (count < duty_cycle) ? 1 : 0;

endmodule

`default_nettype wire
