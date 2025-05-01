# 🔧 Verilog Implementation Report: Blue LED Blinking on VSDSquadron FPGA Mini

##  Objective

To understand, document, and implement Verilog code that drives the **blue LED** on the **VSDSquadron FPGA Mini** using the **internal oscillator**, a **frequency counter**, and appropriate **pin mappings via a PCF file**.

##  Step 1: Understanding the Verilog Code

**🔗 GitHub Code**: [top.v - Verilog Code on GitHub](https://github.com/vinaysubramanya/VSDSQUADRON/blob/main/my_task/vsdfpgaminitask1/vsdtask1/new-folder/top.v)

###  Module Ports

- input hw_clk: Hardware oscillator input  

- output led_red, led_green, led_blue: RGB LED outputs  

- output testwire: Debug/test output

###  Key Components

- SB_HFOSC: Instantiates a high-frequency internal oscillator (~48 MHz)
- counter: 26-bit counter increments with every clock pulse

###  LED Logic

assign led_blue = counter\[25\]; // Blinks blue LED based on MSB  
assign led_red = 0; // Red LED is always off  
assign led_green = 0; // Green LED is always off

Only the **blue LED** blinks. Red and green are **permanently off**.

##  Step 2: PCF File and Pin Mapping

**🔗 PCF File**: [VSDSquadronFM.pcf on GitHub](https://github.com/thesourcerer8/VSDSquadron_FM/blob/main/led_blue/VSDSquadronFM.pcf)

###  Pin Assignments

| Signal | FPGA Pin |
| --- | --- |
| led_red | 39  |
| led_blue | 40  |
| led_green | 41  |
| hw_clk | 20  |
| testwire | 17  |

These mappings align with the **VSDSquadron FPGA Mini** board specifications.

##  Step 3: Toolchain and Flashing

###  Required Tools Installed

- yosys: Synthesizes the Verilog code
- nextpnr-ice40: Places and routes design
- icepack, icetime: Converts to binary and performs timing analysis
- iceprog: Flashes the .bin file to the FPGA board

###  Build & Flash Commands

make clean  
make build  
sudo make flash

Ensure: - FTDI USB connection is detected - USB passthrough is enabled for VMs

###  Outcome

- **Blue LED blinks** visibly on the board  

- **Timing report**: 6.29 ns (approx. 159.10 MHz max frequency)  

- Internal oscillator was used — no external crystal required

###  Blinking Rate Estimate

Given a ~48 MHz clock:

T = 2^25 / 48,000,000 ≈ 0.67 seconds

Thus, the **blue LED toggles once every ~0.67s**.

##  Final Files

| File Name | Description |
| --- | --- |
| top.v | Verilog source code |
| VSDSquadronFM.pcf | Physical Constraints File (PCF) |
| Makefile | Automates build & flashing process |

##  Project Demonstration

 [**Watch Demo Video on Google Drive**](https://drive.google.com/file/d/1cJLVLQlBpZLIonIlUY4IMrYrCsXqNkw2/view?usp=drive_link)

## Contact Information

- **Author**: Vinay Subramanya CK  

- **Email**: [wompert08@gmail.com](mailto:wompert08@gmail.com)

## 📝 License

This project is licensed under the **MIT License**.  
See the [LICENSE file](https://github.com/thesourcerer8/VSDSquadron_FM/blob/main/LICENSE) for details.
