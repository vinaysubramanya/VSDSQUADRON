
# FPGA-Based UART-Controlled Actuator System

A compact and effective project using the **VSDSquadron FPGA Mini** to receive serial (UART) commands and control **RGB LEDs** based on decoded inputs. This forms the foundation of actuator control via serial interfaces in automation or robotic systems.

---

## 📌 Overview

This project demonstrates how an FPGA can be used to:
- Receive data via **UART**.
- Decode commands in real-time.
- Control actuators like **RGB LEDs** based on the received command.

The current implementation controls **two RGB LEDs** using the commands:
- `'r'` → Turns on red on both RGBs (with variations).
- `'g'` → Turns on green on RGB1 and blue on RGB2.
- `'b'` → Turns on blue on RGB1 and red on RGB2.

---

## 🎯 Objectives

- Parse and interpret command protocols over UART.
- Control RGB LEDs (as actuators) based on UART inputs.
- Understand safe and reliable GPIO output control on an FPGA.

---

## 🔧 System Requirements

### Hardware
- [x] **VSDSquadron FPGA Mini**
- [x] **Two RGB LEDs** (common cathode or anode)
- [x] **Resistors (220Ω recommended)**
- [x] USB to UART module (if UART over USB not directly supported)

### Software
- [x] **Verilog HDL**
- [x] **openFPGALoader** or equivalent for programming
- [x] **Serial Terminal** (e.g., `minicom`, `PuTTY`, or `CoolTerm`)

---

## 🧩 System Architecture

```
+------------------+
| Serial Terminal  |
|   (e.g., PC)     |
+--------+---------+
         |
         | UART (115200 baud)
         |
+--------v---------+       +--------------------+
|  FPGA (VSDSquad) |<----->|  RGB LEDs (2x)     |
|                  |       |  (controlled pins) |
+------------------+       +--------------------+
```

---

## 📜 UART Command Protocol

| Command | RGB1 State | RGB2 State |
|---------|------------|------------|
| `'r'`   | Red        | Red        |
| `'g'`   | Green      | Blue       |
| `'b'`   | Blue       | Red        |

Ensure the character is **sent as ASCII** (e.g., not raw hex).

---

## 💡 Implementation Details

- Uses a **custom UART RX** implementation in Verilog.
- Internal clock of **12 MHz** configured via `SB_HFOSC`.
- RX state machine decodes each UART byte and sets LED states.
- LED control logic is synchronous with internal clock.

### Example Verilog Snippet:
```verilog
if (rx_data == "r") begin
  rgb_red    <= 1;
  rgb_green  <= 0;
  rgb_blue   <= 0;
  rgb2_red_r   <= 1;
  rgb2_green_r <= 0;
  rgb2_blue_r  <= 0;
end
```

---

---

## 🔍 Literature Review

- [FPGA UART Communication Basics](https://www.fpga4student.com/2017/06/uart-serial-communication-in-verilog.html)
- Lattice iCE40 Documentation & SB_HFOSC usage
- Open-source RGB LED Verilog Projects

---

## 📁 Repository Structure

```
├── src/
│   └── top.v               # Main Verilog module
├── constraints/
│   └── top.pcf        # Pin constraint file
├── build/
│   └── Bitstream files
├── docs/
│   └── system_diagram.png  # Architecture diagrams
├── README.md               # Project documentation
└── LICENSE
```

---

## 🧠 Future Improvements

- Extend to more actuators like motors or relays.
- Add UART TX for feedback.
- Implement command sequences or multiple byte protocols.

---

## 🛠️ Usage Instructions

1. Flash the bitstream onto the FPGA.
2. Open a serial terminal at **115200 baud, 8N1**.
3. Send ASCII characters: `'r'`, `'g'`, `'b'`.
4. Observe RGB LEDs changing color based on command.

---

## 📸 Demo

*Insert photo or video of working hardware here*

---

## 👨‍💻 Author

Vinay Subramanya CK  
wompert08@gmail.com

---

## 📄 License

This project is licensed under the MIT License.
