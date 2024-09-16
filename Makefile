Library         = libgswteos-10
Program         = gsw_check

PROGRAM_SOURCES = gsw_check_functions.c\
                  gsw_oceanographic_toolbox.c\
                  gsw_saar.c
LIBRARY_SRCS    = gsw_oceanographic_toolbox.c \
                  gsw_saar.c

# NMAKE code \
!ifndef 0 # \
# Optionally set the compiler using the environment variable COMPILER \
# Conditional block for nmake \
!ifndef COMPILER # \
COMPILER = $(CPP) # \
!endif # \
!else
# Make code
# include TOOLS.gcc variables
include TOOLS.gcc

# Optionally set the compiler using the environment variable COMPILER
# Conditional block for make
COMPILER ?= $(CPP)
# \
!endif

all: $(Program) $(Library)

$(Program):
		$(COMPILER) $(CRELEASE) $(PROGRAM_SOURCES) $(LIBS) $(OUT)$(Program)$(X)

library: $(Library)
$(Library):
		$(COMPILER) $(LFLAGS) $(LIBRARY_SRCS) $(LIBS) $(OUT)$(Library)$(SHARED_POSTFIX)

clean:
		$(RM) *.o *.obj *.ilk *.pdb *.tmp *.i *~
		$(RM) $(Library)$(SHARED_POSTFIX)
		$(RM) $(Program)$(X)

name_compiler:
		@echo $(COMPILER)
