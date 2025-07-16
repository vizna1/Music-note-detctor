`timescale 1ns / 1ps

module musicnotedetector (input clk, input reset, input waveform, output reg [2:0] note_out);

parameter IDLE = 2'b00,
          MEASURE = 2'b01,
          MAP = 2'b10,
          HOLD = 2'b11;

reg [1:0] state, next_state;
  reg [31:0] count;
  reg [31:0] period;
  reg prev_waveform;
  wire rising_edge;

  assign rising_edge = (~prev_waveform) & waveform;

  always @(posedge clk or posedge reset) begin
    if (reset)
      state <= IDLE;
    else
      state <= next_state;
  end

  always @(*) begin
    case (state)
      IDLE:    next_state = rising_edge ? MEASURE : IDLE;
      MEASURE: next_state = rising_edge ? MAP : MEASURE;
      MAP:     next_state = HOLD;
      HOLD:    next_state = IDLE;
      default: next_state = IDLE;
    endcase
  end

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      count <= 0;
      period <= 0;
      note_out <= 3'b000;
      prev_waveform <= 0;
    end else begin
      prev_waveform <= waveform;

      case (state)
        IDLE: count <= 0;

        MEASURE: count <= count + 1;

        MAP: begin
          period <= count;
          if      (count >= 190000 && count < 210000) note_out <= 3'b000; // Sa
          else if (count >= 170000 && count < 190000) note_out <= 3'b001; // Re
          else if (count >= 150000 && count < 170000) note_out <= 3'b010; // Ga
          else if (count >= 135000 && count < 150000) note_out <= 3'b011; // Ma
          else if (count >= 125000 && count < 135000) note_out <= 3'b100; // Pa
          else if (count >= 110000 && count < 125000) note_out <= 3'b101; // Dha
          else if (count >= 95000  && count < 110000) note_out <= 3'b110; // Ni
          else if (count >= 93000  && count < 95000)  note_out <= 3'b111; // High Sa
          else                                        note_out <= 3'b000; // default
        end
        HOLD: count <= 0;
      endcase
    end
  end

endmodule
