# Configure as appropriate.

KERB_INCLUDES = -I/usr/local/include
KERB_LIBDIR = /usr/local/lib
KERB_LIBS = -L$(KERB_LIBDIR) -lkrb -ldes -lcom_err

ZEPHYR_INCLUDES = -I/usr/local/include
ZEPHYR_LIBDIR = /usr/local/lib
ZEPHYR_LIBS = -L$(ZEPHYR_LIBDIR) -lzephyr

# You may need to use these to pick up some BSD'ish functions like flock().
# Linux needs MISC_LIBS = -lbsd
# NetBSD needs MISC_LIBS = -lcrypt
# AIX needs MISC_CFLAGS = -D_BSD and MISC_LIBS = -lbsd
# Solaris needs MISC_CFLAGS = -I/usr/include -DNO_SIGMASK
#           and MISC_LIBS = -lsocket -lnsl  /usr/ucblib/libucb.a
MISC_CFLAGS = 
MISC_LIBS = 

# uncomment this if getenv() isn't already available (e.g. SunOS 4.1.x)
# EXTRA_OBJS = getenv.o

CC = gcc
LD = $(CC)

DEFINES = -DINTERREALM
INCLUDES = $(ZEPHYR_INCLUDES) $(KERB_INCLUDES) $(MISC_CFLAGS)
CFLAGS = -g -O -Wall $(DEFINES) $(INCLUDES)

LIBS = $(ZEPHYR_LIBS) $(KERB_LIBS) $(MISC_LIBS)

tzc: tzc.o lread.o $(EXTRA_OBJS)
	$(LD) $(LDFLAGS) -o tzc.new tzc.o lread.o $(EXTRA_OBJS) $(LIBS)
	/bin/mv tzc.new tzc

lread.o: lread.h
tzc.o: lread.h

clean:
	/bin/rm -f *.o tzc tzc.new core
