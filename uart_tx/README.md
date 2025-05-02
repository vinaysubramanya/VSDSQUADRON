
# UART Transmit Module Report

## 1. Study the Existing Code
the verilog code can be accessed here https://github.com/vinaysubramanya/VSDSQUADRON/blob/main/uart_tx/top.v

### Understanding the Code

#### Top Module Overview:
The top module integrates various components to implement the UART transmission logic, including an internal 12 MHz oscillator, a baud rate generator, and an RGB LED driver. The key functionalities of the top module include:

- **Clock Generation**: An internal 12 MHz oscillator is used as the primary clock. This clock is then divided to generate a 9600 Hz clock for the UART communication.
  
- **Clock Division**: The 12 MHz clock is divided by 1250, which means it takes 1250 clock cycles to generate a 9600 Hz clock. The clock toggles every half-period, resulting in a 625-cycle toggle to achieve the accurate baud rate for UART.

- **UART Transmission**: The UART transmitter (uart_tx_8n1) continuously sends the character 'D' in an 8N1 format (8 data bits, no parity bit, and 1 stop bit) over UART.

- **LED Control**: RGB LEDs toggle based on the frequency counter, providing a visual indication of data transmission and clock signals.

This setup ensures precise baud rate generation for UART communication and enables visual feedback using LED indicators.

#### uart_tx_8n1 Module Overview:
The `uart_tx_8n1` module implements a simple UART transmitter with a finite state machine (FSM). It works based on the following key components:

- **Baud Rate Generator**:
  - The baud rate generator generates a 9600 baud clock from the 12 MHz input clock. This is achieved using a counter-based approach.
  - The counter increments on every rising edge of the 12 MHz clock.
  - When the counter reaches 1249, it resets and toggles the baud clock signal, effectively generating a 9600 Hz clock.

- **State Machine (FSM) for Data Control**:
  The FSM drives the transmission process and handles the following states:

  1. **IDLE STATE (STATE_IDLE)**:
     - Waits for the `senddata` signal to go high, indicating the start of a transmission.
     - When `senddata = 1`, the module moves to the **STARTTX** state, loads the 8-bit data byte into `buf_tx`, and clears the `txdone` signal.

  2. **Start Bit Transmission (STATE_STARTTX)**:
     - The `txbit` is set low to indicate the start of the transmission (start bit in UART communication).
     - The module then moves to the **TXING** state to transmit the data bits.

  3. **Sending Data Bits (STATE_TXING)**:
     - In the **TXING** state, the 8-bit data byte (`buf_tx`) is sequentially transmitted, starting from the least significant bit (LSB).
     - The `buf_tx` register is shifted right on each clock cycle, and the number of bits sent (`bits_sent`) is incremented.

  4. **Stop Bit Transmission (STATE_TXDONE)**:
     - After all 8 data bits have been sent, the stop bit (1) is transmitted.
     - The `bits_sent` counter is reset to 0, and the module moves to the **TXDONE** state.

  5. **Transmission Complete (STATE_TXDONE → STATE_IDLE)**:
     - Once the stop bit is transmitted, the module sets the `txdone` signal to 1, indicating that the transmission is complete.
     - The FSM then returns to the **IDLE** state, ready for the next transmission.

---

## 2. System Architecture

### Block Diagram:

![Block Diagram](https://raw.githubusercontent.com/vinaysubramanya/VSDSQUADRON/main/uart_tx/block.jpg)

### Circuit Diagram:

![Circuit Diagram](https://raw.githubusercontent.com/vinaysubramanya/VSDSQUADRON/main/uart_tx/ckt%20(1)%20(1).drawio.png)

In this circuit diagram:
- The **12 MHz Oscillator** generates the primary clock.
- The **Baud Rate Generator** derives the 9600 Hz baud clock.
- The **uart_tx_8n1 Module** handles the 8N1 UART transmission.
- The **RGB LED Controller** provides visual feedback based on transmission activity.

---

## 3. Synthesis & Programming

### Clone & Setup Repository:

1. Clone the repository:
   ```bash
   git clone https://github.com/vinaysubramanya/VSDSQUADRON.git
   cd "uart_tx"
   ```

2. **Build the Bitstream**:
   - This command compiles the Verilog code and generates a bitstream (`top.bin`) for the FPGA.
   ```bash
   make build
   ```

3. **Flash to FPGA**:
   - The following command uploads the bitstream (`top.bin`) to the FPGA.
   ```bash
   sudo make flash
   ```

4. **UART Testing**:
   - Open a terminal to test the UART transmission:
   ```bash
   sudo make terminal
   ```

---

## 4. UART Transmission Showcase

- After flashing the bitstream to the FPGA, the UART transmitter will start transmitting data at 9600 baud, sending the character 'D' continuously over the serial interface.
- The RGB LEDs will toggle to indicate the progress of the transmission, with visual feedback based on the internal frequency counter.
  
You can observe the data transmission and verify it using a terminal emulator (such as PuTTY or minicom) by connecting the FPGA’s UART TX pin to the computer's serial port and monitoring the output.

---
##  Demo Video

You can watch the working demo of the UART Transmit Module in the following video:

 [Watch on Google Drive](https://drive.google.com/file/d/1cDMsikjzdnfnlmxQdxnY9RZjrTezvj9C/view?usp=drive_link)



---


### Conclusion:
This report provides a comprehensive explanation of the UART Transmit module, including its functionality, code overview, system architecture, and steps to synthesize, program, and test the module on an FPGA. The UART module reliably transmits sensor data over a serial interface using an 8N1 data frame, with visual feedback via RGB LEDs. The implementation ensures accurate timing for UART communication and efficient data transmission.
