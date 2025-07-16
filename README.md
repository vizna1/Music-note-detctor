# Music-note-detctor
# FSM-Based Carnatic Music Note Detector

## What is This Project?

This project implements a **Finite State Machine (FSM)** in Verilog to detect **Carnatic musical notes** (Sa to High Sa) by analyzing the **frequency** of a square wave input. Each note corresponds to a specific frequency, and this system converts the waveform into a 3-bit binary code representing the note.

It is a great example of combining **FSM design, frequency measurement, and digital signal interpretation**, applicable in digital music tools, embedded systems, and VLSI projects.

---

## Project Overview

This Verilog-based project simulates the detection of 8 basic Carnatic notes (Sa, Re, Ga, Ma, Pa, Dha, Ni, High Sa) by analyzing the waveform's rising edges. The FSM manages states for capturing the period between waveform pulses, which is then mapped to a musical note.

Key features:

* FSM with four states: `IDLE`, `MEASURE`, `MAP`, `HOLD`
* Period counter to calculate cycles between rising edges
* Note mapper to convert the period into 3-bit musical note codes

---

## System Block Diagram

A basic block diagram of this project includes:

* **Waveform Input** → Square wave corresponding to a sung note
* **Edge Detector** → Detects rising edges
* **Period Counter** → Measures clock cycles between rising edges
* **FSM Controller** → Controls state transitions and processing
* **Note Mapper** → Maps the measured period to Carnatic note
* **Note Output** → 3-bit binary representing the detected note

---

## Inputs & Outputs

### Inputs:

* `clk` (1-bit): Clock signal (e.g. 50 MHz)
* `reset` (1-bit): System reset
* `waveform` (1-bit): Square wave representing the input note

### Outputs:

* `note_out` (3-bit): Binary code for detected note

### Note Encoding:

| note\_out | Note    | Frequency (Hz) |
| --------- | ------- | -------------- |
| 000       | Sa      | 256            |
| 001       | Re      | 280            |
| 010       | Ga      | 312            |
| 011       | Ma      | 346            |
| 100       | Pa      | 384            |
| 101       | Dha     | 426            |
| 110       | Ni      | 480            |
| 111       | High Sa | 512            |

---

## Simulation

The testbench simulates the input waveform for each note using a square wave at its corresponding frequency.

### Tools Used:

* **Icarus Verilog** for simulation
* **GTKWave** for waveform visualization

## Applications

* **Digital Tuner**: Identify pitch of sung/played notes
* **Voice-Controlled Music Tools**
* **Educational Kits**: Teaching FSMs, music frequency
* **Embedded Audio Interfaces**

---

## Conclusion

This project shows how Verilog and FSMs can be used to interpret real-world signals like music. By simulating input waveforms and mapping frequencies to notes, this design bridges the gap between signal processing and music technology. The modular structure also allows for future extensions like microphone input, serial output, or real-time pitch visualization.
