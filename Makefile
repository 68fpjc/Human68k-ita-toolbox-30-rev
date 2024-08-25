# Makefile for ITA TOOLBOX #30 rev

MAKE = make

AS = HAS060
ASFLAGS = -m 68000 -i $(INCLUDE)
LD = hlk
LDFLAGS = -x
CV = -CV -r
CP = cp
RM = -rm -f

INCLUDE = ../01-fish/include

DESTDIR   = A:/usr/ita
BACKUPDIR = B:/rev/1.0A
RELEASE_ARCHIVE = REV10A
RELEASE_FILES = MANIFEST README ../NOTICE CHANGES rev.1 revr.1 rev.x revr

EXTLIB = ../01-fish/lib/ita.l

###

PROGRAM = rev.x

###

.PHONY: all clean clobber install release backup

.TERMINAL: *.h *.s

%.r : %.x
	$(CV) $<

%.x : %.o $(EXTLIB)
	$(LD) $(LDFLAGS) $^

%.o : %.s
	$(AS) $(ASFLAGS) $<

###

all:: $(PROGRAM)

clean::

clobber:: clean
	$(RM) *.bak *.$$* *.o *.x

###

$(PROGRAM:.x=.o) : $(INCLUDE)/doscall.h $(INCLUDE)/chrcode.h

$(EXTLIB)::
	cd $(@D); $(MAKE) $(@F)

include ../Makefile.sub

###

install::
	$(INSTALL) revr $(DESTDIR)
