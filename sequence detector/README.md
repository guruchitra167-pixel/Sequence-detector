# 1011 Sequence Detector Using Verilog HDL

## 1. Project Title

1011 Sequence Detector Design and Simulation Using Verilog HDL

## 2. Introduction

A sequence detector is a digital circuit used to detect a specific
sequence of binary bits in a serial input stream.

In this project, a Finite State Machine (FSM) is used to detect the
sequence:

    1011

The detector produces an output of 1 whenever the sequence 1011 is
detected.

This project uses a Mealy Finite State Machine and supports overlapping
sequence detection.

## 3. Objective

The objectives of this project are:

- To design a sequence detector using Verilog HDL.
- To understand Finite State Machines.
- To detect the binary sequence 1011.
- To implement overlapping sequence detection.
- To create a Verilog testbench.
- To simulate and verify the design.

## 4. Sequence to Detect

The sequence is:

    1011

For example, if the input stream is:

    1101011011

The sequence 1011 occurs more than once.

Whenever 1011 is detected:

    detect = 1

Otherwise:

    detect = 0

## 5. Inputs

| Input | Description |
|-------|-------------|
| clk | Clock signal |
| reset | Resets the FSM |
| data_in | Serial input bit |

## 6. Output

| Output | Description |
|--------|-------------|
| detect | Becomes 1 when 1011 is detected |

## 7. FSM States

The FSM contains four states:

### S0

No matching bits have been detected.

### S1

The first bit `1` has been detected.

### S2

The sequence `10` has been detected.

### S3

The sequence `101` has been detected.

When the next input is `1`, the complete sequence `1011` is detected.

## 8. State Transition

```text
                 1
          +--------------+
          |              v
       +------+        +------+
       | S0   |        | S1   |
       +------+        +------+
          | 1             | 0
          |               v
          |             +------+
          |             | S2   |
          |             +------+
          |                |
          |                | 1
          |                v
          |             +------+
          +-------------| S3   |
                        +------+
                           |
                           | 1
                           v
                       DETECT = 1