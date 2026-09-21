# UVM / XSIM Makefile

# Simulator
XVLOG  = xvlog
XELAB  = xelab
XSIM   = xsim

# Files
FILELIST = filelist.f

# Top module
TOP = tb_top

# Simulation snapshot
SNAPSHOT = $(TOP)_sim

# UVM
UVM_LIB = uvm

# UVM Verbosity
# Can be overridden from command line:
# make run VERBOSITY=UVM_HIGH

VERBOSITY ?= UVM_LOW

# Compilation options
XVLOG_OPTS = -sv \
             -L $(UVM_LIB) \
             -f $(FILELIST)

# Elaboration options
XELAB_OPTS = -L $(UVM_LIB) \
             -debug typical \
             --relax

# Simulation options
XSIM_OPTS = --runall \
            --testplusarg UVM_VERBOSITY=$(VERBOSITY)


# Targets

.PHONY: all compile elaborate run clean

all: run

# Compile
compile:
	$(XVLOG) $(XVLOG_OPTS)


# Elaborate
elaborate: compile
	$(XELAB) $(TOP) $(XELAB_OPTS) -s $(SNAPSHOT)


# Run simulation
run: elaborate
	$(XSIM) $(SNAPSHOT) $(XSIM_OPTS)


# Clean
clean:
	rm -rf xsim.dir
	rm -rf .Xil
	rm -rf xvlog.pb
	rm -rf xvlog.log
	rm -rf xelab.log
	rm -rf xsim.log
	rm -rf $(SNAPSHOT).*
