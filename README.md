```markdown
# Advent of Code 2025 - Day 3 (Lobby) using Hardcaml + Verilog

<p align="center">
  Hardware implementation of <b>Advent of Code 2025 - Day 3: Lobby</b><br>
  built using <b>Hardcaml</b> and <b>Verilog</b>.
</p>

---

## 🚀 Project Visualization

🔗 **Live Visualization & Demo**  
https://snighdhasarali.github.io/AOFpga_hardcaml_Q3/

---

## 📖 Problem Statement

🔗 Original Problem:  
https://adventofcode.com/2025/day/3

---

# 🧠 Simple Explanation

The challenge provides multiple rows of battery digits.

Example input:

```text
987654321111111
811111111111119
234234234234278
818181911112111
```

Each row represents a **battery bank**.

From every row, we must choose **exactly two digits** while keeping their original order to create the **largest possible 2-digit number**.

---

## ✅ Examples

| Input Row | Maximum Number |
|----------|----------------|
| `987654321111111` | `98` |
| `811111111111119` | `89` |
| `234234234234278` | `78` |
| `818181911112111` | `92` |

Finally, all maximum values are added together to generate the final result.

---

# ⚡ Hardware Approach

This project implements the solution using **FPGA-style sequential logic**.

### Design Flow

- Read one digit every clock cycle
- Continuously track:
  - Largest digit found so far
  - Second largest digit while maintaining order
- Combine both digits into a 2-digit number

```text
result = (largest_digit × 10) + second_largest_digit
```

- Use clocked registers for updates
- Generate final result after processing the input stream

---

# 🛠️ Technologies Used

- **Hardcaml**
- **Verilog**
- **Sequential Hardware Design**
- **FPGA-style Streaming Logic**

---

# 📌 Key Concepts Demonstrated

- Sequential logic design
- Register-based state tracking
- Streaming digit processing
- Hardware implementation of greedy selection logic
- Hardcaml generated Verilog flow

---

# 🎯 Goal of the Project

The purpose of this project was to explore:

- Mapping algorithmic problems to hardware
- Using Hardcaml for hardware generation
- FPGA-style computation pipelines
- Efficient sequential data processing in Verilog

---

# 👩‍💻 Author

**Snighdha Sarali**
