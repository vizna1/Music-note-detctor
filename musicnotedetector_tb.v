`timescale 1ns / 1ps
`include "musicnotedetector.v"

module musicnotedetector_tb;

  reg clk;
  reg reset;
  reg waveform;
  wire [2:0] note_out;

  musicnotedetector uut (.clk(clk), .reset(reset), .waveform(waveform), .note_out(note_out));

  initial clk = 0;
  always #10 clk = ~clk;

  integer half_periods[0:7];
  initial begin
    half_periods[0] = 97656;  // Sa (256 Hz)
    half_periods[1] = 89285;  // Re (280 Hz)
    half_periods[2] = 80128;  // Ga (312 Hz)
    half_periods[3] = 72368;  // Ma (346 Hz)
    half_periods[4] = 65104;  // Pa (384 Hz)
    half_periods[5] = 58638;  // Dha (426 Hz)
    half_periods[6] = 52083;  // Ni (480 Hz)
    half_periods[7] = 48828;  // High Sa (512 Hz)
  end

  integer i, j;

  initial begin
    $dumpfile("fsm_music.vcd");
    $dumpvars(0, musicnotedetector_tb);
    $display("\nStarting FSM Music Note Detector Test\n");

    reset = 1;
    waveform = 0;
    #50;
    reset = 0;

    for (i = 0; i < 8; i = i + 1) begin
      $display("\nPlaying Note: %0d", i);

      for (j = 0; j < 20; j = j + 1) begin
        #(half_periods[i]) waveform = ~waveform;
      end

      #500000; 
      $display("Detected note = %b", note_out);
    end

    $display("\nSimulation complete.");
    #100 $finish;
  end

endmodule
