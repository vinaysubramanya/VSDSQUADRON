# UART-Based Sensor Data Transmission using VSDSquadron FPGA Mini

## Objective

Design and implement a UART transmitter that sends real-time sensor data over a serial interface. This ensures the FPGA can communicate sensor values reliably to an external device.

---

## 1. Study the Existing Code

###  Module Analysis

This project utilizes two main Verilog modules:

- `top`: Top-level integration that connects the clock, UART transmission, and RGB LED logic.
- `uart_tx_8n1`: Implements the UART transmitter logic using an 8N1 protocol (8 data bits, no parity, 1 stop bit).

###  Architecture Overview

#### Features:
- **Sensor Data Handling**
- **Baud Rate Generation**
- **UART Transmission Logic**
- **State Machine for Data Control**

---

## 2. System Architecture

###  Block Diagram

![Block Diagram](https://github.com/vinaysubramanya/VSDSQUADRON/blob/main/uart_tx_sense/blockdiagramuart.jpg)

###  ASCII Circuit Diagram

![Circuit Diagram](https://github.com/vinaysubramanya/VSDSQUADRON/blob/main/uart_tx_sense/cicruitdiagram.png)



## 3. Synthesis & Programming

###  Clone & Setup Repository

```bash
git clone https://github.com/vinaysubramanya/VSDSQUADRON.git
cd vsd_squadron_minifpga_4/uart_tx_sense
```

###  Build the Bitstream

```bash
make build
```
- Generates `top.bin` for the FPGA.

###  Flash to FPGA

```bash
sudo make flash
```
- Uploads the bitstream to the FPGA.

###  UART Testing

```bash
sudo make terminal
```
- Opens serial terminal for real-time data.

---

## 4. UART Transmission Showcase

###  Testing and Verification

- Stimulate the sensor (or wait for the counter value to change).
- Observe transmitted data (for example, character "D") over the UART terminal at **9600 baud**.
- Use logic analyzer or USB-to-serial converter for external verification.

---

##  Demo Video

   
 [Watch Demo](https://drive.google.com/drive/folders/1wiExZofSONVrxfD1RS8G1oDFjH9SeGvS?usp=sharing)


