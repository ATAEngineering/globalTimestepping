# Copyright (C) 2022, ATA Engineering, Inc.
# 
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public
# License as published by the Free Software Foundation; either
# version 3 of the License, or (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# Lesser General Public License for more details.
# 
# You should have received a copy of the GNU Lesser General Public License
# along with this program; if not, write to the Free Software Foundation,
# Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.


LOCI_BASE?=/usr/local/loci
CHEM_BASE?=/usr/local/chem

MODULE_NAME=globalTimeStepping

# Put objects in the module here
OBJS = globalTimeStepping.o

###########################################################################
# No changes required below this line
###########################################################################
include $(CHEM_BASE)/chem.conf
include $(LOCI_BASE)/Loci.conf

INCLUDES = -I$(CHEM_BASE)/include -I$(CHEM_BASE)/include/fluidPhysics
#uncomment this for a debugging compile
#COPT=-O0 -g 


LOCAL_LIBS = 

JUNK = *~  core ti_files ii_files rii_files

LIB_OBJS=$(OBJS:.o=_lo.o)

all: $(MODULE_NAME)_m.so 

$(MODULE_NAME)_m.so: $(LIB_OBJS)
	$(SHARED_LD) $(SHARED_LD_FLAGS) $(MODULE_NAME)_m.so $(LIB_FLAGS) $(LIB_OBJS)
FRC : 

clean:
	rm -fr $(OBJS) $(LIB_OBJS) $(MODULE_NAME)_m.so $(JUNK)

install: $(MODULE_NAME)_m.so
	cp $(MODULE_NAME)_m.so $(CHEM_BASE)/lib

LOCI_FILES = $(wildcard *.loci)
LOCI_LPP_FILES = $(LOCI_FILES:.loci=.cc)

distclean: 
	rm $(DEPEND_FILES)
	rm -fr $(OBJS) $(LIB_OBJS) $(MODULE_NAME)_m.so $(JUNK) $(LOCI_LPP_FILES)

DEPEND_FILES=$(subst .o,.d,$(OBJS))


#include automatically generated dependencies
-include $(DEPEND_FILES)
