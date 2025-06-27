# vscode-vivado-fpga
A comprehensive development environment for FPGA design using Visual Studio Code integrated with Xilinx Vivado Design Suite. This repository provides a complete workflow for compiling, synthesizing, simulating, and programming Xilinx FPGAs directly from VSCode using Vivado command-line tools and TCL scripts.

## Features

- **Integrated Development**: Complete FPGA development workflow within VSCode
- **Automated Build System**: TCL scripts for synthesis, implementation, and bitstream generation
- **Simulation Support**: Integrated testbench simulation with waveform viewing
- **Device Programming**: Direct FPGA programming from VSCode tasks
- **Multi-Language Support**: Verilog, VHDL, and SystemVerilog support
- **Project Templates**: Ready-to-use examples and project templates
- **Version Control Friendly**: Optimized .gitignore for FPGA projects

## Supported Workflows

- **Compilation**: Syntax checking and elaboration
- **Synthesis**: RTL to netlist conversion with optimization
- **Simulation**: Behavioral and post-synthesis simulation
- **Implementation**: Place and route with timing closure
- **Programming**: Bitstream generation and device programming

## Requirements

- Xilinx Vivado Design Suite (2020.1 or later)
- Visual Studio Code
- Xilinx FPGA development board
- TCL support (included with Vivado)

## Quick Start

1. Clone this repository
2. Open in VSCode
3. Configure Vivado paths in `.vscode/settings.json`
4. Use Ctrl+Shift+P → "Tasks: Run Task" to access FPGA workflows
5. Start with examples in the `examples/` directory

## Target Devices

Compatible with all Xilinx FPGA families supported by Vivado:
- Zynq-7000, Zynq UltraScale+
- Kintex-7, Kintex UltraScale, Kintex UltraScale+
- Virtex-7, Virtex UltraScale, Virtex UltraScale+
- Artix-7
- Spartan-7
