# Makefile for each steps
# Copyright 2006 Yann E. MORIN <yann.morin.1998@free.fr>

# ----------------------------------------------------------
# This is the steps help entry

help-build::
	@echo  '  list-steps         - List all build steps'

help-env::
	@echo  '  STOP=step          - Stop the build just after this step (list with list-steps)'
	@echo  '  RESTART=step       - Restart the build just before this step (list with list-steps)'

# ----------------------------------------------------------
# The steps list

# The _for_build steps are noop for native and cross,
# but are actual steps for canadian and cross-native.
# Please keep the last line with a '\' and keep the following empy line:
# it helps when diffing and merging.
CT_STEPS := lnp			\
			df			\
			embark		\
			keybinds	\
			dfhack		\
			twbt		\
			therapist	\
			soundsense	\
			legends		\
			finish		

# Keep an empty line above this comment, so the last
# back-slash terminated line works as expected.

# Make the list available to sub-processes (scripts/crosstool-NG.sh needs it)
export CT_STEPS

# Print the steps list
PHONY += list-steps
list-steps:
	@echo  'Available build steps, in order:'
	@for step in $(CT_STEPS); do    \
	     echo "  - $${step}";       \
	 done
	@echo  'Use "<step>" as action to execute only that step.'
	@echo  'Use "+<step>" as action to execute up to that step.'
	@echo  'Use "<step>+" as action to execute from that step onward.'

# ----------------------------------------------------------
# This part deals with executing steps

$(CT_STEPS):
	$(SILENT)$(MAKE) -rf $(CT_NG) V=$(V) RESTART=$@ STOP=$@ build

$(patsubst %,+%,$(CT_STEPS)):
	$(SILENT)$(MAKE) -rf $(CT_NG) V=$(V) STOP=$(patsubst +%,%,$@) build

$(patsubst %,%+,$(CT_STEPS)):
	$(SILENT)$(MAKE) -rf $(CT_NG) V=$(V) RESTART=$(patsubst %+,%,$@) build
