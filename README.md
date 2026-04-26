# FPGA Vivado VSCode Project

This project demonstrates how to use Xilinx Vivado with Visual Studio Code for FPGA design and simulation. It includes examples in Verilog, VHDL, and SystemVerilog, along with Tcl scripts to automate the workflow.

## Project Structure

```
fpga-vivado-vscode
├── src

├── scripts

├── .vscode

└── README.md
```

## Getting Started


### Prerequisites

- Xilinx Vivado installed on your machine.
- Visual Studio Code with the necessary extensions for Tcl and FPGA development.

### Install Vivado

- Xilinx's Downloads page: https://www.xilinx.com/support/download.html
- Download `Self Extracting Web Installer`
- Change to the directrory
- chmod +x <installer>.bin && sudo ./<installer>.bin
- After installation completed successfully:
  - Run `the installLibs.sh` as it is shown in the window.
- Install USB driver: 
  - `cd /tools/Xilinx/Vivado/2024.2/data/xicom/cable_drivers/lin64/install_script/install_drivers/`
  - `sudo ./install_drivers`
- To open the Vivado from new terminal session, add this to the ~/.bashrc:
  - `source /tools/Xilinx/Vivado/2024.2/settings64.sh`

### Add VScode extension:

- Verilog-HDL/SystemVerilog/Bluespec SystemVerilog: 
    - https://www.youtube.com/watch?v=-DTGf3Z6v_o
    - Install Universal Ctags
    - A path to the installation of Universal Ctags: 
      - /tools/ctags/bin/
    - Verilog › Linting: Linter: 
      - xvlog
    - Verilog › Linting: Path 
      - /tools/Xilinx/Vivado/2024.2/bin/
- Enable "Go to Definition (F12) "
    - Install Ctags Companion extension
    - Install Universal Ctags:
      - sudo apt-get install universal-ctags
      - Add settings.json:        
        ```
        {
            "verilog.ctags.path": "/tools/ctags/bin/",
            "ctags-companion.command": "ctags --fields=+nKz --langmap=SystemVerilog:+.v.sv.svh --languages=SystemVerilog -R .",
            "verilog.linting.xvlog.includePath": [
                "${workspaceFolder}"
            ],
            "verilog.linting.linter": "xvlog"


        }
        ```
      - Generate tags file:
        ```
        # Run from project root
        ctags -R --fields=+nKz --languages=SystemVerilog --langmap=SystemVerilog:+.sv,+.v,+.svh -R rtl .
        ```






### File Descriptions


### Usage



### Contributing

Feel free to contribute to this project by adding more examples or improving the scripts. 

### License

This project is licensed under the MIT License. See the LICENSE file for more details.