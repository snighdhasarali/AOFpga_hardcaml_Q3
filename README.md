Day 3: Lobby — Hardcaml RTL Design & Simulation
📌 Overview

This project implements a hardware (RTL) solution to Day 3: Lobby, using Hardcaml, an OCaml-based hardware description library.

The problem is inspired by an Advent-of-FPGA–style challenge:

Batteries are arranged in banks

Each battery has a digit value between 1 and 9

Digits arrive sequentially

From this sequence, we must select two digits (in order) that form the maximum possible two-digit number

Reordering digits is not allowed

The solution is implemented as synthesizable RTL, written in Hardcaml, converted to Verilog, simulated using Icarus Verilog, and debugged using GTKWave.

🎯 Problem Statement (Hardware View)

Given a stream of digits:

d₀, d₁, d₂, ...


We must compute:

max_two_digit = (tens × 10) + ones


Where:

tens is the largest digit seen so far

ones is the second-largest digit, respecting arrival order

The computation happens incrementally, as digits arrive

This must be done entirely in hardware, using registers and comparison logic.

⚙️ What This Design Does

At a high level, the circuit:

Accepts one digit per cycle

Tracks:

The largest digit so far (max_tens)

The second-largest digit (max_ones)

Computes the result continuously:

result = (max_tens × 10) + max_ones


Produces a valid output once computation has started

This exactly matches the problem requirement of selecting two digits in order to maximize the resulting two-digit number.

🔌 Interface Description
Inputs
Signal	Width	Description
clock	1	System clock
reset	1	Synchronous reset
start	1	Indicates a new digit is valid
digit	4	Incoming battery digit (0–9)
Outputs
Signal	Width	Description
done_	1	Indicates computation has started
result	8	Maximum two-digit value
🧠 Design Approach (Step-by-Step)
1️⃣ Register-Based RTL Design

The design is pure RTL, built using explicit registers:

max_tens → largest digit seen so far

max_ones → second-largest digit

done_ → latched when the first valid digit arrives

Registers are created using:

Variable.reg spec ~width:N


This ensures:

Clocked behavior

Full synthesizability

No inferred latches or behavioral shortcuts

2️⃣ Comparison Logic

Each incoming digit is compared against the current maximum:

digit > max_tens


If the new digit is larger:

The old max_tens shifts into max_ones

The new digit becomes max_tens

This preserves:

Ordering

Maximum possible value

Correct hardware semantics

3️⃣ Arithmetic Construction (Width-Safe)

Hardcaml enforces explicit bit-width control, so arithmetic is carefully resized:

result = (max_tens × 10) + max_ones


Key details:

10 is constructed as a constant

All operands are resized before multiplication

The final result is widened to 8 bits

This avoids:

Accidental truncation

Overflow bugs

Implicit width inference

4️⃣ Sequential Logic (Always Block)

All state updates occur inside a single clocked block:

Always.compile [
  when_ greater [
    max_tens <-- digit;
    max_ones <-- max_tens;
  ];
  when_ start [
    done_ <-- 1;
  ];
]


This directly maps to a Verilog always_ff block and guarantees:

Predictable timing

Clear state transitions

Clean synthesis results

📁 Project Structure
hardcaml_template_project/
├── src/
│   └── day3_lobby.ml        # Hardcaml RTL design
├── bin/
│   └── generate.ml          # Verilog generator
├── day3_lobby.v             # Generated Verilog
├── tb_day3_lobby.v          # Verilog testbench
├── day3_lobby.vcd           # Waveform dump
└── README.md                # This file

🛠️ How to Build the Project
1️⃣ Install Dependencies
sudo apt update
sudo apt install -y opam iverilog gtkwave


Make sure your opam switch has Hardcaml installed.

2️⃣ Build the Hardcaml Design
cd ~/hardcaml_template_project
dune clean
dune build

3️⃣ Generate Verilog
_build/default/bin/generate.exe > day3_lobby.v


This produces synthesizable Verilog RTL.

▶️ Simulation & Waveform Viewing
1️⃣ Compile the Testbench
iverilog -o sim day3_lobby.v tb_day3_lobby.v

2️⃣ Run the Simulation (Important)
./sim


This generates:

day3_lobby.vcd

3️⃣ Open GTKWave
gtkwave day3_lobby.vcd

🔍 What to Inspect in GTKWave

Add these signals:

clock

reset

digit

start

done_

result

📌 Tip
Right-click result → Data Format → Decimal

You will observe:

Digits arriving sequentially

Registers updating on clock edges

result converging to the maximum two-digit value

✅ Verification Strategy

The design is verified using:

A handwritten Verilog testbench

Explicit waveform inspection

Known input/output validation

Example

Input digits:

4 → 9 → 2 → 7


Expected result:

97


The waveform confirms the correct final value.

🧩 Key Takeaways

This is true RTL design, not behavioral code

All state is explicit and clocked

Bit-widths are controlled and safe

The workflow mirrors industry practice:

High-level RTL (Hardcaml)

Verilog generation

Simulation

Waveform debugging

Add assertions for self-checking simulation

Target FPGA synthesis
