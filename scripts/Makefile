# Directories
SIM_DIR = outputs
SCRIPT_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
FILELIST_VHDL := $(SCRIPT_DIR)filelist_vhdl.f
FILELIST_SV := $(SCRIPT_DIR)filelist_sv.f
FILELIST_TB := $(SCRIPT_DIR)filelist_tb.f

# Tool options
XVHDL_OPTS = --incr --relax
XVLOG_OPTS = --incr --relax -L uvm
XELAB_OPTS = --incr --debug typical --relax --mt 8 -L xil_defaultlib -L uvm -L unisims_ver -L unimacro_ver -L secureip -L xpm

# Detect the recipe shell type so Windows + Git Bash/MSYS uses POSIX recipes.
SHELL_NAME := $(basename $(notdir $(SHELL)))
USE_POSIX_SHELL := $(filter sh bash dash zsh ksh,$(SHELL_NAME))

ifneq ($(USE_POSIX_SHELL),)
MKDIR_SIM = mkdir -p $(SIM_DIR)
RM_FILE_CMD = rm -f
RM_DIR_CMD = rm -rf
VHDL_COMPILE_CMD = bash -o pipefail -c 'xvhdl $(XVHDL_OPTS) -f "$(FILELIST_VHDL)" 2>&1 | tee "$(SIM_DIR)/compile_vhdl.log"'
SV_RTL_COMPILE_CMD = bash -o pipefail -c 'xvlog $(XVLOG_OPTS) -sv -f "$(FILELIST_SV)" 2>&1 | tee "$(SIM_DIR)/compile.log"'
SV_TB_COMPILE_CMD = bash -o pipefail -c 'xvlog $(XVLOG_OPTS) -sv -f "$(FILELIST_TB)" 2>&1 | tee -a "$(SIM_DIR)/compile.log"'
CHECK_ENV_CMD = bash -c 'for t in xvhdl xvlog xelab xsim; do command -v $$t >/dev/null 2>&1 || { echo "Missing required tool in PATH: $$t"; exit 1; }; done'
TB_NAME := $(strip $(shell sed -e 's/#.*//' -e '/^[[:space:]]*$$/d' "$(FILELIST_TB)" | grep 'test_.*\.sv' | head -n1 | xargs -I{} basename "{}" .sv))
else ifeq ($(OS),Windows_NT)
MKDIR_SIM = if not exist "$(SIM_DIR)" mkdir "$(SIM_DIR)"
RM_FILE_CMD = del /Q /F
RM_DIR_CMD = rmdir /S /Q
VHDL_COMPILE_CMD = xvhdl $(XVHDL_OPTS) -f "$(FILELIST_VHDL)" > "$(SIM_DIR)/compile_vhdl.log" 2>&1
SV_RTL_COMPILE_CMD = xvlog $(XVLOG_OPTS) -sv -f "$(FILELIST_SV)" > "$(SIM_DIR)/compile.log" 2>&1
SV_TB_COMPILE_CMD = xvlog $(XVLOG_OPTS) -sv -f "$(FILELIST_TB)" >> "$(SIM_DIR)/compile.log" 2>&1
CHECK_ENV_CMD = powershell -NoProfile -Command "$${tools=@('xvhdl','xvlog','xelab','xsim'); $$missing=$$tools | Where-Object { -not (Get-Command $$_ -ErrorAction SilentlyContinue) }; if ($$missing) { Write-Host ('Missing required tools in PATH: ' + ($$missing -join ', ')); exit 1 }}"
TB_NAME := $(strip $(shell powershell -NoProfile -Command "(Get-Content '$(FILELIST_TB)' | Where-Object { $$_.Trim() -ne '' -and -not $$_.Trim().StartsWith('#') -and $$_.Trim() -match 'test_.*\.sv' } | Select-Object -First 1 | ForEach-Object { [System.IO.Path]::GetFileNameWithoutExtension($$_.Trim()) })"))
else
$(error Unsupported shell/OS combination. Use a POSIX shell, or run on Windows with cmd/powershell.)
endif

ifeq ($(strip $(TB_NAME)),)
$(error Could not determine TB_NAME from $(FILELIST_TB). Add a line matching *test_*.sv)
endif

# Targets
.PHONY: all clean check-env compile elaborate simulate wave

all: simulate

check-env:
	@echo "##### CHECKING TOOLCHAIN #####"
	$(CHECK_ENV_CMD)

$(SIM_DIR):
	$(MKDIR_SIM)

compile: check-env $(SIM_DIR)
	@echo "##### COMPILING VHDL Files #####"
	$(VHDL_COMPILE_CMD)
	@echo "##### COMPILING SystemVerilog RTL Files #####"
	$(SV_RTL_COMPILE_CMD)
	@echo "##### COMPILING Testbench Files #####"
	$(SV_TB_COMPILE_CMD)

elaborate: compile
	@echo "##### ELABORATING #####"
	xelab $(XELAB_OPTS) $(TB_NAME) -snapshot $(TB_NAME)_sim -log $(SIM_DIR)/elaborate.log

simulate: elaborate
	@echo "##### RUNNING SIMULATION #####"
	xsim $(TB_NAME)_sim -tclbatch xsim_cfg.tcl -log $(SIM_DIR)/simulate.log

wave: simulate
	@echo "##### OPENING WAVEFORM #####"
	xsim --gui $(TB_NAME)_sim.wdb -view $(TB_NAME)_wave.wcfg

clean:
	-$(RM_DIR_CMD) $(SIM_DIR)
	-$(RM_FILE_CMD) *.jou *.log *.pb *.wdb
	-$(RM_DIR_CMD) xsim.dir
	-$(RM_FILE_CMD) trixv.imem
	-$(RM_DIR_CMD) .Xil

# Caution: This target will remove the entire vivado directory. Use with care.
clean-all: clean
	@echo "Removing vivado directory (if present)"
	-$(RM_DIR_CMD) vivado