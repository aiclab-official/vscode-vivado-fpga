# FPGA Vivado + VS Code RTL Workflow

This repository shows a practical workflow to develop RTL in VS Code and simulate with Vivado tools.
It supports mixed-language designs (VHDL + Verilog/SystemVerilog), includes task automation, and provides a Tcl script to create a Vivado project from filelists.

## What You Can Do in This Project

- Edit RTL in VS Code with real-time syntax checking.
- Jump to definitions with CTags (`F12`).
- Run compile/elaborate/simulation from a Makefile.
- Open waveforms from the same Makefile flow.
- Create a Vivado GUI project from Tcl using the same filelists.

## Project Structure

```text
vscode-vivado-fpga
├── .vscode/
│   ├── settings.json
│   ├── tasks.json
│   └── launch.json
├── scripts/
│   ├── Makefile
│   ├── create_project.tcl
│   ├── filelist_sv.f
│   ├── filelist_vhdl.f
│   ├── filelist_tb.f
│   ├── xsim_cfg.tcl
│   └── test_fullAdder_wave.wcfg
├── src/
│   ├── systemverilog/
│   │   ├── halfAdder.sv
│   │   └── fullAdder.sv
│   └── vhdl/
│       ├── halfAdder.vhd
│       └── fullAdder.vhd
└── tb/
    ├── tb_utils_pkg.sv
    └── test_fullAdder.sv
```

## Prerequisites

- Xilinx Vivado installed and available in `PATH`.
- Visual Studio Code.
- GNU Make.
- Universal CTags.
- Recommended on Linux/macOS: Bash available.
- Recommended on Windows: PowerShell and Vivado tools in `PATH`.

The Makefile includes a `check-env` target and will fail early if Vivado tools are missing.

## Install and Configure Vivado

1. Download Vivado installer from:
   `https://www.xilinx.com/support/download.html`
2. Install Vivado.
3. Add Vivado environment setup to your shell startup file.

Example for Linux Bash:

```bash
source /tools/Xilinx/Vivado/2024.2/settings64.sh
```

## VS Code Extensions and Settings

Install:

- Verilog-HDL/SystemVerilog/Bluespec SystemVerilog extension.
- Ctags Companion extension.
- Universal CTags on your machine.

Current workspace settings are in `.vscode/settings.json`:

```json
{
  "verilog.ctags.path": "/tools/ctags/bin/",
  "ctags-companion.command": "ctags --fields=+nKz --langmap=SystemVerilog:+.v.sv.svh --langmap=VHDL:+.vhd.vhdl --languages=SystemVerilog,VHDL -R .",
  "verilog.linting.xvlog.includePath": [
    "${workspaceFolder}"
  ],
  "verilog.linting.linter": "xvlog"
}
```

This gives you:

- Real-time syntax feedback using `xvlog`.
- CTags support for navigation.

## Enable Go To Definition (F12)

1. Open the **Run and Debug** panel in VS Code.
2. Select task/config: **Generate RTL CTags**.
3. Click the green play button.
4. Use `F12` on symbols to jump to definitions.

The task is defined in `.vscode/tasks.json` and runs:

```bash
ctags --fields=+nKz --langmap=SystemVerilog:+.v.sv.svh --langmap=VHDL:+.vhd.vhdl --languages=SystemVerilog,VHDL -R .
```

## Simulation Flow (Makefile)

Run from the `scripts` directory.

```bash
cd scripts
make all
```

This performs:

1. Toolchain check.
2. VHDL compile (`xvhdl`) from `filelist_vhdl.f`.
3. SystemVerilog RTL compile (`xvlog`) from `filelist_sv.f`.
4. Testbench compile (`xvlog`) from `filelist_tb.f`.
5. Elaboration (`xelab`).
6. Simulation (`xsim`).

To open waveform viewer:

```bash
make wave
```

Useful helper targets:

```bash
make clean
make clean-all
```

## Filelists

The build flow is driven by three filelists in `scripts/`:

- `filelist_vhdl.f`: VHDL design files.
- `filelist_sv.f`: SystemVerilog/Verilog design files.
- `filelist_tb.f`: testbench and verification files.

Keep these filelists updated when adding files.

## Create Vivado Project from Tcl

1. Open Vivado.
2. Go to **Tools -> Run Tcl Script...**
3. Select `scripts/create_project.tcl`.
4. Vivado reads all three filelists and creates the project.
5. In Tcl console, confirm this message appears:

```text
Project created successfully!
```

## Notes

- The Tcl script sets:
  - source top: `fullAdder`
  - simulation top: `test_fullAdder`
- The Makefile automatically extracts simulation top from `filelist_tb.f` by looking for `test_*.sv`.

## Contributing

Contributions are welcome. Suggested improvements:

- Add new RTL examples.
- Add new testbenches.
- Add CI checks for lint/build/sim.

## License

See `LICENSE` for license details.