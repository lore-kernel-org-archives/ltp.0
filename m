Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1MMp2R-0002ru-LR
	for ltp-list@lists.sourceforge.net; Fri, 03 Jul 2009 20:07:15 +0000
Received: from relay1.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id D80FF5362F
	for <ltp-list@lists.sourceforge.net>;
	Fri,  3 Jul 2009 22:07:08 +0200 (CEST)
Date: Fri, 3 Jul 2009 22:07:08 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20090703200708.GB1651@schrodinger.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
Subject: [LTP] [RFC] [PATCH] build system cleanup
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,
following patch introduces ltp buildsystem cleanup, not all the source are fixed
but it's big enough to show you the direction. I would gladly write
comprehensive HOWTO for creating makefiles the new way in case this cleanup
patch will be accepted.

This patch introduces Makefile.include, where all the hard work is done. If you
have any questions or edhancements don't hesitate to ask. Most of this file
contains definitions of generic make rules so that you don't need to say make
how to create binary test from source test.c. The rest of the file are rules
for subdirectory handling. There are two rules, one for make and one for make
install as quite lot of directories contains only shell scripts so make
entering this directories only slows down building process. Also it turns on
warnings for all sources, so furhter code cleanups are easier to do.

Every Makefile starts with definition of subdirectories to build and
subdirectories to install followed by including the Makefile.include from the
top of ltp directory. So if there are some directories to run make in; makefile
should look like:

SUBDIRS=test_a test_b
SUBDIRS_INSTALL=$(SUBDIRS) test_c
TOPDIR=../../../../
include $(TOPDIR)Makefile.include

And that's it, nothing more is needed for running make in subdirectories. Also
subdirs are defined as targets (in Makefile.include) so make can execute
submakes in paralel.

If some directories are needed to build before the others (for example because
they contain code used by the rest of the tests in subdirectories) one
additional rule is needed.

SUBDIRS=test_a test_b libtest
SUBDIRS_INSTALL=$(SUBDIRS) test_c
TOPDIR=../../../../
include $(TOPDIR)Makefile.include
libtest: test_a test_b

This will work allways correctly with make -jN where N > 2 (when make runs in
paralel).

When we need to create binaries, objectfiles or libraries we start with
including Makefile.include. Then we define additional libraries here we need
-lm and we use ltp tst_* calls. In the end we define what to build, binary
names and source names must match.

TOPDIR=../../../../
include $(TOPDIR)Makefile.include

LDFLAGS+=-lm
LOADLIBES+=$(TOPDIR)lib/libltp.a

SOURCES=$(wildcard *.c)
TARGETS=$(SOURCES:.c=)

all: $(TARGETS)

If we need to add additional compile flags for one file, we need to add line:

test.c: LDFLAGS+=-lpthread

That's all folks! Now waiting for your comments.

-- 
Cyril Hrubis
chrubis@suse.cz

--u3/rZRmxL6MmkK24
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="clean-build-messages.patch"

Index: ltp-full-20090630/Makefile.include
===================================================================
--- /dev/null
+++ ltp-full-20090630/Makefile.include
@@ -0,0 +1,87 @@
+#
+# This file overrides default building rules in order to create much more
+# readable build messages.
+#
+# Copyright (c) 2009 Cyril Hrubis chrubis@suse.cz
+#
+# Distributed under GPLv2 or any later
+#
+
+#
+# Suppress the long gcc line in order to have less noisy build output
+#
+%.o: %.c
+	@echo "CC  $@"
+	@$(CC) $(CFLAGS) -Wall -W -I$(TOPDIR)include -c $< -o $@
+
+%.o: %.cpp
+	@echo "CXX $@"
+	@$(CXX) $(CPPFLAGS) -Wall -W -c $< -o $@
+
+#
+# How to create binaries from object files
+#
+%: %.o
+	@echo "LN  $@"
+	@$(CC) $(LDFLAGS) $^ $(LOADLIBES) -o $@
+
+#
+# How to create binaries from C sources
+#
+%: %.c
+	@echo "CC  $@"
+	@$(CC) $^ -Wall -W -I$(TOPDIR)include $(CFLAGS) $(LDFLAGS) $(LOADLIBES) -o $@
+
+%:: %.cpp
+	@echo "CXX $@"
+	@$(CXX) -Wall -W $(LDFLAGS) $(CPPFLAGS) $< -o $@
+
+#
+# How to create static library
+#
+%.a:
+	@echo "AR  $@"
+	@$(AR) -cr $@ $^
+
+#
+# SUBDIRS MAKE MAGICK
+#
+#
+# We mangle SUBDIRS_INSTALL to be different from SUBDIRS
+#
+MANGLE=424242424242
+SUBDIRS_INSTALL_MANGLED=$(foreach SUBDIR,$(SUBDIRS_INSTALL),$(SUBDIR)$(MANGLE))
+.PHONY: all clean install uninstall subdirs $(SUBDIRS) $(SUBDIRS_INSTALL_MANGLED)
+
+all: export MAKE_CMD=
+all: subdirs
+clean: export MAKE_CMD=clean
+clean: subdirs
+subdirs: $(SUBDIRS)
+install: export MAKE_CMD=install
+install: $(SUBDIRS_INSTALL_MANGLED)
+uninstall: export MAKE_CMD=uninstall
+uninstall: $(SUBDIRS_INSTALL_MANGLED)
+
+#
+# Subdirs for make and make clean
+#
+$(SUBDIRS):
+	@export LTP_CUR_DIR="$$LTP_CUR_DIR/$@" &&\
+	echo "DIR $$LTP_CUR_DIR"               &&\
+	cd "$@" && $(MAKE) --no-print-directory $(MAKE_CMD)
+
+#
+# As some directories contain just bash scritps, make and make clean slowns down
+# building, so make install has it's own rule.
+#
+$(SUBDIRS_INSTALL_MANGLED):
+	@SUBDIR=`echo "$@" | sed s/$(MANGLE)//`     &&\
+	export LTP_CUR_DIR="$$LTP_CUR_DIR/$$SUBDIR" &&\
+	echo "DIR $$LTP_CUR_DIR install"            &&\
+	cd "$$SUBDIR" && $(MAKE) --no-print-directory $(MAKE_CMD)
+
+#
+# Printing functions
+#
+print_warn=@echo 'WAR ***${1} ****'
Index: ltp-full-20090630/lib/Makefile
===================================================================
--- ltp-full-20090630.orig/lib/Makefile
+++ ltp-full-20090630/lib/Makefile
@@ -1,7 +1,8 @@
+TOPDIR=../
+include $(TOPDIR)Makefile.include
 
 PREFIX=/opt/ltp
 
-CFLAGS+= -Wall
 CPPFLAGS+= -I../include 
 ifeq ($(shell uname -s),HP-UX)
 CFLAGS+=-Ae -D_LARGEFILE64_SOURCE +DA1.1
@@ -9,13 +10,13 @@ endif
 ifeq ($(UCLINUX),1)
 CFLAGS+= -D_USC_LIB_ -D__UCLIBC__ -DUCLINUX
 endif
-LDFLAGS+=
 TARGET=libltp.a
 SRCS=$(wildcard *.c)
 OBJS=$(patsubst %.c,%.o,$(SRCS))
 
+all: $(TARGET)
+
 $(TARGET): $(OBJS)
-	$(AR) -cr $@ $^
 
 clean:
 	rm -f $(TARGET) $(OBJS)
@@ -23,4 +24,3 @@ clean:
 install: $(TARGET)
 	install -D -m 644 $(TARGET) $(DESTDIR)/$(PREFIX)/lib$(LIBSUFFIX)/$(TARGET)
 	install -D -m 644 ltp.pc $(DESTDIR)/$(PREFIX)/share/pkgconfig/ltp.pc
-
Index: ltp-full-20090630/pan/Makefile
===================================================================
--- ltp-full-20090630.orig/pan/Makefile
+++ ltp-full-20090630/pan/Makefile
@@ -1,3 +1,5 @@
+TOPDIR=../
+include $(TOPDIR)/Makefile.include
 
 LOADLIBES += -lm
 LFLAGS += -l -w
Index: ltp-full-20090630/testcases/kernel/containers/sysvipc/Makefile
===================================================================
--- ltp-full-20090630.orig/testcases/kernel/containers/sysvipc/Makefile
+++ ltp-full-20090630/testcases/kernel/containers/sysvipc/Makefile
@@ -1,6 +1,7 @@
 ################################################################################
 ##                                                                            ##
 ## Copyright (c) International Business Machines  Corp., 2007                 ##
+## Copyrignt (c) Cyril Hrubis chrubis@suse.cz 2009                            ##
 ##                                                                            ##
 ## This program is free software;  you can redistribute it and#or modify      ##
 ## it under the terms of the GNU General Public License as published by       ##
@@ -18,8 +19,11 @@
 ##                                                                            ##
 ################################################################################
 
-CFLAGS += -I../../../../include -I../libclone -Wall
-LDLIBS += -L../../../../lib -L../libclone ../libclone/libclone.a -lltp
+TOPDIR=../../../../
+include $(TOPDIR)Makefile.include
+
+CFLAGS  += -I../libclone
+LDFLAGS += ../libclone/libclone.a $(TOPDIR)lib/libltp.a
 
 SRCS    := $(wildcard *.c)
 TARGETS := $(SRCS:%.c=%)
Index: ltp-full-20090630/testcases/kernel/containers/libclone/Makefile
===================================================================
--- ltp-full-20090630.orig/testcases/kernel/containers/libclone/Makefile
+++ ltp-full-20090630/testcases/kernel/containers/libclone/Makefile
@@ -1,6 +1,7 @@
 ################################################################################
 ##                                                                            ##
 ## Copyright (c) International Business Machines  Corp., 2007                 ##
+## Copyrignt (c) Cyril Hrubis chrubis@suse.cz 2009                            ##
 ##                                                                            ##
 ## This program is free software;  you can redistribute it and#or modify      ##
 ## it under the terms of the GNU General Public License as published by       ##
@@ -18,10 +19,8 @@
 ##                                                                            ##
 ################################################################################
 
-SRCS := $(wildcard *.c)
-OBJS := $(SRCS:%.c=%.o)
-
-CFLAGS += -I../../../../include
+TOPDIR=../../../../
+include $(TOPDIR)Makefile.include
 
 HAS_UNSHARE ?= $(shell ../check_for_unshare && echo y)
 ifeq ($(HAS_UNSHARE),y)
@@ -30,16 +29,13 @@ else
 TARGET :=
 endif
 
+OBJS = libclone.o libnetns.o
+
 all: $(TARGET)
 
-libclone.a: $(OBJS)
-	$(AR) -cr $@ libclone.o
+libclone.a: libclone.o
 
-libnetns.a: $(OBJS)
-	$(AR) -cr $@ libnetns.o 
-#	$(AR) -cr $@ $^
+libnetns.a: libnetns.o
 
 clean:
 	rm -f $(TARGET) $(OBJS)
-
-install:
Index: ltp-full-20090630/testcases/kernel/containers/mqns/Makefile
===================================================================
--- ltp-full-20090630.orig/testcases/kernel/containers/mqns/Makefile
+++ ltp-full-20090630/testcases/kernel/containers/mqns/Makefile
@@ -2,6 +2,7 @@
 ##                                                                            ##
 ## Copyright (c) International Business Machines  Corp., 2009                 ##
 ## Copyright (c) Nadia Derbey, 2009                                           ##
+## Copyrignt (c) Cyril Hrubis chrubis@suse.cz 2009                            ##
 ##                                                                            ##
 ## This program is free software;  you can redistribute it and#or modify      ##
 ## it under the terms of the GNU General Public License as published by       ##
@@ -19,9 +20,11 @@
 ##                                                                            ##
 ################################################################################
 
-CFLAGS += -Wall
-CPPFLAGS += -I../../../../include -I../libclone
-LDLIBS += -L../../../../lib -L../libclone ../libclone/libclone.a -lltp -lrt
+TOPDIR=../../../../
+include $(TOPDIR)Makefile.include
+
+CFLAGS  += -I../libclone
+LDFLAGS += ../libclone/libclone.a $(TOPDIR)lib/libltp.a -lrt
 
 SRCS    := $(wildcard *.c)
 TARGETS := $(SRCS:%.c=%)
Index: ltp-full-20090630/testcases/kernel/containers/netns/Makefile
===================================================================
--- ltp-full-20090630.orig/testcases/kernel/containers/netns/Makefile
+++ ltp-full-20090630/testcases/kernel/containers/netns/Makefile
@@ -1,6 +1,7 @@
 ################################################################################
 ##                                                                            ##
 ## Copyright (c) International Business Machines  Corp., 2008                 ##
+## Copyrignt (c) Cyril Hrubis chrubis@suse.cz 2009                            ##
 ##                                                                            ##
 ## This program is free software;  you can redistribute it and#or modify      ##
 ## it under the terms of the GNU General Public License as published by       ##
@@ -19,9 +20,12 @@
 ## Author:      Veerendra <veeren@linux.vnet.ibm.com>                         ##
 ################################################################################
 
-CFLAGS += -Wall
-CPPFLAGS += -I../../../../include -I../libclone
-LDLIBS += -L../../../../lib -L../libclone ../libclone/libnetns.a -lltp
+TOPDIR=../../../../
+include $(TOPDIR)Makefile.include
+
+CFLAGS  += -I../libclone
+LDFLAGS += ../libclone/libnetns.a $(TOPDIR)lib/libltp.a
+
 SCRIPTS = initialize.sh parentns.sh childns.sh                  \
 parent.sh child.sh                                              \
 parent_view.sh parent_share.sh  child_propagate.sh              \
Index: ltp-full-20090630/testcases/kernel/containers/pidns/Makefile
===================================================================
--- ltp-full-20090630.orig/testcases/kernel/containers/pidns/Makefile
+++ ltp-full-20090630/testcases/kernel/containers/pidns/Makefile
@@ -1,6 +1,7 @@
 ################################################################################
 ##                                                                            ##
 ## Copyright (c) International Business Machines  Corp., 2007                 ##
+## Copyrignt (c) Cyril Hrubis chrubis@suse.cz 2009                            ##
 ##                                                                            ##
 ## This program is free software;  you can redistribute it and#or modify      ##
 ## it under the terms of the GNU General Public License as published by       ##
@@ -18,9 +19,11 @@
 ##                                                                            ##
 ################################################################################
 
-CFLAGS += -Wall
-CPPFLAGS += -I../../../../include -I../libclone
-LDLIBS += -L../../../../lib -L../libclone ../libclone/libclone.a -lltp -lrt
+TOPDIR=../../../../
+include $(TOPDIR)Makefile.include
+
+CFLAGS  += -I../libclone
+LDFLAGS += ../libclone/libclone.a $(TOPDIR)lib/libltp.a -lrt
 
 SRCS    := $(wildcard *.c)
 TARGETS := $(SRCS:%.c=%)
Index: ltp-full-20090630/testcases/kernel/containers/utsname/Makefile
===================================================================
--- ltp-full-20090630.orig/testcases/kernel/containers/utsname/Makefile
+++ ltp-full-20090630/testcases/kernel/containers/utsname/Makefile
@@ -1,6 +1,7 @@
 ################################################################################
 ##                                                                            ##
 ## Copyright (c) International Business Machines  Corp., 2007                 ##
+## Copyrignt (c) Cyril Hrubis chrubis@suse.cz 2009                            ##
 ##                                                                            ##
 ## This program is free software;  you can redistribute it and#or modify      ##
 ## it under the terms of the GNU General Public License as published by       ##
@@ -18,9 +19,11 @@
 ##                                                                            ##
 ################################################################################
 
-CFLAGS += -Wall
-CPPFLAGS += -I../../../../include -I../libclone
-LDLIBS += -L../../../../lib -L../libclone ../libclone/libclone.a -lltp
+TOPDIR=../../../../
+include $(TOPDIR)Makefile.include
+
+CFLAGS  += -I../libclone
+LDFLAGS += ../libclone/libclone.a $(TOPDIR)lib/libltp.a
 
 SRCS    := $(wildcard *.c)
 TARGETS := $(SRCS:%.c=%)
Index: ltp-full-20090630/Makefile
===================================================================
--- ltp-full-20090630.orig/Makefile
+++ ltp-full-20090630/Makefile
@@ -1,5 +1,9 @@
 # See toplevel INSTALL for build info
 
+SUBDIRS=pan lib testcases tools utils
+SUBDIRS_INSTALL=$(SUBDIRS) include m4 doc/man1 doc/man2
+include Makefile.include
+
 ifdef CROSS_COMPILE
 CROSS_COMPILER = $(CROSS_COMPILE)
 endif
@@ -17,33 +21,19 @@ export CC AR RANLIB CPPFLAGS LDFLAGS HAS
 -include config.mk
 
 VPATH += include m4
-all: config.h config.mk libltp.a 
-	@$(MAKE) -C pan $@
-	@$(MAKE) -C testcases $@
-	@$(MAKE) -C tools $@
-	@$(MAKE) -C utils $@
+
+
+all: config.h config.mk libltp.a $(SUBDIRS)
 	@echo
 	@echo "***********************************************"
 	@echo "** You now need to do a make install as root **"
 	@echo "***********************************************"
 
 install: all
-	@$(MAKE) -C testcases install
-	@$(MAKE) -C tools install
-	@$(MAKE) -C lib install
-	@$(MAKE) -C include install
-	@$(MAKE) -C pan install
-	@$(MAKE) -C m4 install
-	@$(MAKE) -C doc/man1 install
-	@$(MAKE) -C doc/man3 install
-
 	@./IDcheck.sh
 
-libltp.a: config.h
-	@$(MAKE) -C lib $@
-
 uclinux: uclinux_libltp.a
-	#@$(MAKE) -C pan all
+	@$(MAKE) -C pan all
 	@$(MAKE) -C testcases uclinux
 	@$(MAKE) -C tools all
 	@echo
@@ -63,11 +53,7 @@ menuconfig:
 	@./ltpmenu
 
 clean: ac-clean
-	@$(MAKE) -C lib $@
-	@$(MAKE) -C pan $@
-	@$(MAKE) -C tools $@
-	@$(MAKE) -C testcases $@
-	@$(MAKE) -C utils $@
+	$(call submake, $(SUBDIRS), clean)
 
 distclean: clean ac-distclean
 	@$(MAKE) -C include $@
Index: ltp-full-20090630/testcases/kernel/connectors/pec/Makefile
===================================================================
--- ltp-full-20090630.orig/testcases/kernel/connectors/pec/Makefile
+++ ltp-full-20090630/testcases/kernel/connectors/pec/Makefile
@@ -1,5 +1,7 @@
-CFLAGS += -I../../../../include -Wall
-LDLIBS += -L../../../../lib -lltp
+TOPDIR=../../../../
+include $(TOPDIR)Makefile.include
+
+LDLIBS += $(TOPDIR)lib/libltp.a
 
 SRCS:=$(wildcard *.c)
 TARGETS:=$(patsubst %.c,%,$(SRCS))
Index: ltp-full-20090630/testcases/kernel/controllers/cgroup/Makefile
===================================================================
--- ltp-full-20090630.orig/testcases/kernel/controllers/cgroup/Makefile
+++ ltp-full-20090630/testcases/kernel/controllers/cgroup/Makefile
@@ -1,6 +1,5 @@
-CFLAGS += -Wall
-CPPFLAGS += -I../../../../include -I../libcontrollers
-LDLIBS += -L../../../../lib/ -lltp
+TOPDIR=../../../../
+include $(TOPDIR)Makefile.include
 
 SRCS    = $(wildcard *.c)
 
Index: ltp-full-20090630/testcases/kernel/controllers/cpuctl/Makefile
===================================================================
--- ltp-full-20090630.orig/testcases/kernel/controllers/cpuctl/Makefile
+++ ltp-full-20090630/testcases/kernel/controllers/cpuctl/Makefile
@@ -1,6 +1,8 @@
-CFLAGS += -Wall
-CPPFLAGS += -I../../../../include -I../libcontrollers
-LDLIBS += -lm -L../../../../lib/ -L../libcontrollers -lcontrollers -lltp
+TOPDIR=../../../../
+include $(TOPDIR)Makefile.include
+
+CFLAGS  += -I../libcontrollers
+LDFLAGS += ../libcontrollers/libcontrollers.a $(TOPDIR)lib/libltp.a -lm
 
 SRCS    = $(wildcard *.c)
 
Index: ltp-full-20090630/testcases/kernel/controllers/cpuset/cpuset_lib/Makefile
===================================================================
--- ltp-full-20090630.orig/testcases/kernel/controllers/cpuset/cpuset_lib/Makefile
+++ ltp-full-20090630/testcases/kernel/controllers/cpuset/cpuset_lib/Makefile
@@ -1,14 +1,24 @@
-CFLAGS += -Wall -g -Wextra
-CPPFLAGS += -I../../../../include
-LDLIBS += -lm -L../../../../lib/ -lcontrollers -lltp
+#
+# Copyright (c) 2009 Cyril Hrubis chrubis@suse.cz
+#
+# Distributed under GPLv2 or any later
+#
+
+TOPDIR=../../../../../
+include $(TOPDIR)Makefile.include
+
+LDFLAGS += -lm
 
 SRCS=$(wildcard *.c)
-TARGETS=$(patsubst %.c,%.o,$(SRCS))
+OBJS=$(SRCS:.c=.o)
+TARGET=cpuset_lib.a
+
+all: $(TARGET)
 
-all: $(TARGETS)
+$(TARGET): $(OBJS)
 
 clean:
-	rm -f $(TARGETS)
+	rm -f $(TARGET) $(OBJS)
 
 install:
 	@set -e; \
Index: ltp-full-20090630/testcases/kernel/controllers/cpuset/cpuset_syscall_test/Makefile
===================================================================
--- ltp-full-20090630.orig/testcases/kernel/controllers/cpuset/cpuset_syscall_test/Makefile
+++ ltp-full-20090630/testcases/kernel/controllers/cpuset/cpuset_syscall_test/Makefile
@@ -1,11 +1,19 @@
-SRCS = $(wildcard *.sh)
+#
+# Copyright (c) 2009 Cyril Hrubis chrubis@suse.cz
+#
+# Distributed under GPLv2 or any later
+#
 
-LIBSRCS=$(wildcard ../cpuset_lib/*.c)
-LIBOBJECTS=$(patsubst %.c,%.o,$(LIBSRCS))
+TOPDIR=../../../../../
+include $(TOPDIR)Makefile.include
 
-all:cpuset_syscall_test
+LOADLIBES = ../cpuset_lib/cpuset_lib.a
 
-cpuset_syscall_test: %: %.o $(LIBOBJECTS)
+SRC = $(wildcard *.sh)
+
+all: cpuset_syscall_test
+
+cpuset_syscall_test: cpuset_syscall_test.c
 
 clean:
 	rm -rf cpuset_syscall_test
Index: ltp-full-20090630/testcases/kernel/controllers/freezer/Makefile
===================================================================
--- ltp-full-20090630.orig/testcases/kernel/controllers/freezer/Makefile
+++ ltp-full-20090630/testcases/kernel/controllers/freezer/Makefile
@@ -1,5 +1,6 @@
 # Copyright (c) International Business Machines  Corp., 2008
 # Author: Matt Helsley <matthltc@us.ibm.com>
+# Copyrignt (c) Cyril Hrubis chrubis@suse.cz 2009
 #
 # This library is free software; you can redistribute it and/or
 # modify it under the terms of the GNU Lesser General Public
@@ -15,18 +16,18 @@
 # License along with this library; if not, write to the Free Software
 # Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 #
-CFLAGS := -Wall -O3
-PROGS := timed_forkbomb #  vfork fork_exec_loop
+TOPDIR=../../../../
+include $(TOPDIR)Makefile.include
+
+CFLAGS += -O3
+PROGS = timed_forkbomb #  vfork fork_exec_loop
 
 .PHONY: all install clean
 
 all: $(PROGS)
-	chmod u+x *.sh
+	@chmod u+x *.sh
 
 install:
 
-$(PROGS): %: %.c
-	gcc $(CFLAGS) -o $@ $^
-
 clean:
 	rm -f $(PROGS)
Index: ltp-full-20090630/testcases/kernel/controllers/io-throttle/Makefile
===================================================================
--- ltp-full-20090630.orig/testcases/kernel/controllers/io-throttle/Makefile
+++ ltp-full-20090630/testcases/kernel/controllers/io-throttle/Makefile
@@ -1,6 +1,5 @@
-CFLAGS += -Wall
-CPPFLAGS += -I../../../../include -I../libcontrollers
-LDLIBS += -lm -L../../../../lib/ -L../libcontrollers -lcontrollers -lltp
+TOPDIR=../../../../
+include $(TOPDIR)Makefile.include
 
 SRCS    = $(wildcard *.c)
 
Index: ltp-full-20090630/testcases/kernel/controllers/libcontrollers/Makefile
===================================================================
--- ltp-full-20090630.orig/testcases/kernel/controllers/libcontrollers/Makefile
+++ ltp-full-20090630/testcases/kernel/controllers/libcontrollers/Makefile
@@ -1,3 +1,6 @@
+TOPDIR=../../../../
+include $(TOPDIR)Makefile.include
+
 TARGET=libcontrollers.a
 SRCS=$(wildcard *.c)
 OBJS=$(patsubst %.c,%.o,$(SRCS))
@@ -5,11 +8,9 @@ OBJS=$(patsubst %.c,%.o,$(SRCS))
 all : $(TARGET)
 
 $(TARGET): $(OBJS)
-	$(AR) -cr $@ $^
 
 clean:
 	rm -f $(TARGET) $(OBJS)
 
 install:
-
-
+	@true
Index: ltp-full-20090630/testcases/kernel/controllers/memctl/Makefile
===================================================================
--- ltp-full-20090630.orig/testcases/kernel/controllers/memctl/Makefile
+++ ltp-full-20090630/testcases/kernel/controllers/memctl/Makefile
@@ -1,6 +1,8 @@
-CFLAGS += -Wall
-CPPFLAGS += -I../../../../include -I../libcontrollers
-LDLIBS += -lm -L../../../../lib/ -L../libcontrollers -lcontrollers -lltp
+TOPDIR=../../../../
+include $(TOPDIR)Makefile.include
+
+CFLAGS  += -I../libcontrollers
+LDFLAGS += ../libcontrollers/libcontrollers.a $(TOPDIR)lib/libltp.a -lm
 
 SRCS    = $(wildcard *.c)
 
Index: ltp-full-20090630/testcases/kernel/containers/Makefile
===================================================================
--- ltp-full-20090630.orig/testcases/kernel/containers/Makefile
+++ ltp-full-20090630/testcases/kernel/containers/Makefile
@@ -1,6 +1,7 @@
 ################################################################################
 ##                                                                            ##
 ## Copyright (c) International Business Machines  Corp., 2007                 ##
+## Copyrignt (c) Cyril Hrubis chrubis@suse.cz 2009                            ##
 ##                                                                            ##
 ## This program is free software;  you can redistribute it and#or modify      ##
 ## it under the terms of the GNU General Public License as published by       ##
@@ -18,20 +19,24 @@
 ##                                                                            ##
 ################################################################################
 
-SUBDIRS := libclone utsname sysvipc pidns netns mqns
+SUBDIRS=libclone utsname sysvipc pidns netns mqns
+SUBDIRS_INSTALL=utsname sysvipc pidns netns mqns
+TOPDIR=../../../
+include $(TOPDIR)Makefile.include
+LDFLAGS+=-rdynamic -ldl
 
-all: check_for_unshare
-	@set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i $@; done
+all:
+	$(call print_warn, check_for_unshare is compiled the same way as the rest of ltp this will broke crosscompilation)
 
-check_for_unshare: check_for_unshare.c
-	$(CC) $(CFLAGS) -rdynamic -o $@ $< ../../../lib/tst_kvercmp.c -I../../../include -ldl
+$(SUBDIRS): check_for_unshare
+
+#check_for_unshare: check_for_unshare.c
+#	$(CC) $(CFLAGS) -rdynamic -o $@ $< -ldl
 
 install: check_for_unshare
 	@set -e; ln -f check_for_unshare ../../bin/check_for_unshare; \
 	ln -f container_test.sh ../../bin/container_test.sh; \
-	for i in $(SUBDIRS); do $(MAKE) -C $$i $@ ; done; \
 	chmod ugo+x container_test.sh
 
 clean:
-	@set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i $@ ; done
 	rm -f check_for_unshare
Index: ltp-full-20090630/testcases/kernel/fs/Makefile
===================================================================
--- ltp-full-20090630.orig/testcases/kernel/fs/Makefile
+++ ltp-full-20090630/testcases/kernel/fs/Makefile
@@ -1,12 +1,10 @@
-SUBDIRS = acls doio fs_inod fsstress fs_perms fsx-linux ftest inode lftest linktest openfile proc stream fs_di fs_bind racer quota_remount
-
-all:
-	@set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i ; done
-
-install:
-	@set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i install ; done
-
-clean:
-	@set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i clean ; done
-
+#
+# Copyright (c) 2009 Cyril Hrubis chrubis@suse.cz
+#
+# Distributed under GPLv2 or any later
+#
 
+SUBDIRS=acls doio fsstress fs_perms fsx-linux ftest inode lftest openfile proc stream fs_di fs_bind
+SUBDIRS_INSTALL=acls doio fs_inod fsstress fs_perms fsx-linux ftest inode lftest linktest openfile proc stream fs_di fs_bind racer quota_remount
+TOPDIR=../../../
+include $(TOPDIR)Makefile.include
Index: ltp-full-20090630/testcases/kernel/fs/acls/Makefile
===================================================================
--- ltp-full-20090630.orig/testcases/kernel/fs/acls/Makefile
+++ ltp-full-20090630/testcases/kernel/fs/acls/Makefile
@@ -1,3 +1,6 @@
+TOPDIR=../../../../
+include $(TOPDIR)Makefile.include
+
 check_header = $(shell \
 	if echo "\#include <$(1)>" | $(CC) -E - > /dev/null 2>&1 ; \
 	then echo yes ; \
@@ -11,11 +14,6 @@ endif
 
 all: $(TARGETS)
 
-acl_file_test: acl_file_test.c
-	$(CC) $(CFLAGS) $(LDFLAGS) -o acl_file_test acl_file_test.c
-acl_link_test: acl_link_test.c
-	$(CC) $(CFLAGS) $(LDFLAGS) -o acl_link_test acl_link_test.c
-
 install:
 	chmod 755 acl_test01
 	@set -e; for i in $(TARGETS) acl_test01 ; do ln -f $$i ../../../bin/ ; done
Index: ltp-full-20090630/testcases/kernel/fs/doio/Makefile
===================================================================
--- ltp-full-20090630.orig/testcases/kernel/fs/doio/Makefile
+++ ltp-full-20090630/testcases/kernel/fs/doio/Makefile
@@ -1,6 +1,14 @@
+#
+# Copyright (c) 2009 Cyril Hrubis chrubis@suse.cz
+#
+# Distributed under GPLv2 or any later
+#
 
-CFLAGS+= -Wall -I../../../../include -D_LARGEFILE64_SOURCE
-LDLIBS+= -L../../../../lib -lltp -lrt -lpthread
+TOPDIR=../../../../
+include $(TOPDIR)Makefile.include
+
+CFLAGS  += -D_LARGEFILE64_SOURCE
+LDFLAGS += $(TOPDIR)lib/libltp.a -lrt -lpthread
 
 TARGETS=doio growfiles rwtest iogen
 SRCS=$(wildcard *.c)
@@ -8,15 +16,6 @@ OBJS=$(patsubst %.c,%.o,$(SRCS))
 
 all: $(TARGETS)
 
-doio: doio.o
-		 $(CC) -o $@ $^ -I. $(CFLAGS) $(LDFLAGS) $(LDLIBS)
-
-growfiles: growfiles.o
-		 $(CC) -o $@ $^ $(CFLAGS) $(LDFLAGS) $(LDLIBS)
-
-iogen: iogen.o
-		 $(CC) -o $@ $^ $(CFLAGS) $(LDFLAGS) $(LDLIBS)
-
 rwtest: rwtest.sh doio iogen
 	cp rwtest.sh rwtest
 	chmod a+rx rwtest
@@ -25,4 +24,4 @@ install:
 	@set -e; for i in $(TARGETS) ; do ln -f $$i ../../../bin/$$i ; done ;
 
 clean:
-	rm -f $(OBJS) $(TARGETS)
+	rm -f $(TARGETS)
Index: ltp-full-20090630/testcases/Makefile
===================================================================
--- ltp-full-20090630.orig/testcases/Makefile
+++ ltp-full-20090630/testcases/Makefile
@@ -1,21 +1,17 @@
-	SUBDIRS = `ls */Makefile | sed "s/Makefile//g" | grep -v open | grep -v pounder | grep -v DOTS | grep -v kdump | grep -v realtime | grep -v audit-test` 
-UCLINUX_SUBDIRS = kernel
-all:
-	@set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i ; done
+#
+# Copyright (c) 2009 Cyril Hrubis chrubis@suse.cz
+#
+# Distributed under GPLv2 or any later
+#
 
-install:
-	mkdir -p bin
-	@set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i install ; done
-
-uclinux:
-	@set -e; for i in $(UCLINUX_SUBDIRS); do $(MAKE) -C $$i uclinux; done
+SUBDIRS=ballista commands kernel misc network
+SUBDIRS_INSTALL=ballista commands kernel misc network
+SUBDIRS_UCLINUX=kernel
+TOPDIR=../
+include $(TOPDIR)Makefile.include
 
-uclinux_install:
+install:
 	mkdir -p bin
-	@set -e; for i in $(UCLINUX_SUBDIRS); \
-		do $(MAKE) -C $$i uclinux_install ; done
 
 clean:
 	rm -rf bin/
-	@set -e; for i in $(SUBDIRS) ; do $(MAKE) -C $$i clean ; done
-
Index: ltp-full-20090630/testcases/ballista/ballista/Makefile
===================================================================
--- ltp-full-20090630.orig/testcases/ballista/ballista/Makefile
+++ ltp-full-20090630/testcases/ballista/ballista/Makefile
@@ -23,10 +23,12 @@
 #
 ########################
 
+TOPDIR=../../../
+include $(TOPDIR)Makefile.include
+
 # compiler info for the host
-CC=${CXX} -Wno-deprecated
-CFLAGS += -w ${TARGET_DEF}
-CLIBS = -lpthread -ldl -lnsl -rdynamic
+CPPFLAGS += -w ${TARGET_DEF} -Wno-deprecated
+LDFLAGS  += -lpthread -ldl -lnsl -rdynamic
 TEST_MAN_FILE = selfHost
 TARGET_DEF    = -DB_SELFHOST
 
@@ -39,70 +41,27 @@ all : callGen callGen_standAlone genCode
 
 # run-of-of-the-mill rules for utility programs
 callGen: callGen.cpp
-	${CC} ${CFLAGS} callGen.cpp -o callGen
 
 callGen_standAlone: callGen_standAlone.cpp
-	${CC} ${CFLAGS} callGen_standAlone.cpp -o callGen_standAlone
 
 genCodeCreator: genCodeCreator.cpp
-	${CC} ${CFLAGS} genCodeCreator.cpp -o genCodeCreator
 
 replacer: replacer.cpp
-	${CC} ${CFLAGS} replacer.cpp -o replacer
-
-# run-of-of-the-mill rules for harness components
-hack.o : hack.cpp
-	${CC} ${CFLAGS} -c $?
-
-line.o : line.cpp
-	${CC} ${CFLAGS} -c $?
-
-ballistaRPC.o : ballistaRPC.c
-	${CC} ${CFLAGS} -c $?
-
-ballistaXDR.o : ballistaXDR.c
-	${CC} ${CFLAGS} -c $?
-
-ballistaUtil.o : ballistaUtil.cpp
-	${CC} ${CFLAGS} -c $?
-
-testCaseIterator.o : testCaseIterator.cpp 
-	${CC} ${CFLAGS} -c $?
-
-serverCommunication.o : serverCommunication.cpp 
-	${CC} ${CFLAGS} -c $?
-
-parseArguments.o : parseArguments.cpp
-	${CC} ${CFLAGS} -c $?
-
-ballistaError.o : ballistaError.cpp
-	${CC} ${CFLAGS} -c $?
-
-marshal.o : marshal.cpp
-	${CC} ${CFLAGS} -c $?
-
-match.o : match.cpp
-	${CC} ${CFLAGS} -c $?
 
 # the Test Manager is OS dependant, so is built from the ${TEST_MAN_FILE}
 #  environment variable
 ${TEST_MAN_FILE}.o : ${TEST_MAN_FILE}.h ${TEST_MAN_FILE}.cpp
-	${CC} ${CFLAGS} -c ${TEST_MAN_FILE}.cpp
 
 # ballista is built from several static components, but the Test Manager
 #  (${TEST_MAN_FILE}) is platform dependant
-ballista : ballista.cpp ${OBJS}
-	${CC} ${CFLAGS} ${CLIBS} ballista.cpp ${OBJS} -o ballista
+ballista: ballista.o ${OBJS}
+	@echo "LN  $@"
+	@$(CXX) $(CPPFLAGS) $(LDFLAGS) $^ -o $@
 
 # rules that are only used for testing purposes
-unmarshal.o : unmarshal.cpp
-	${CC} ${CFLAGS} -c $?
-
-testmarshal.o : testmarshal.cpp 
-	${CC} ${CFLAGS} -c $?
-
-testmarshal : marshal.o unmarshal.o testmarshal.o
-	${CC} marshal.o unmarshal.o testmarshal.o -o testmarshal
+unmarshal.o: unmarshal.cpp
+testmarshal.o: testmarshal.cpp
+testmarshal: marshal.o unmarshal.o testmarshal.o
 
 test_parse_arguments.o : test_parse_arguments.cpp
 	${CC} ${CC_OPTS} -c $?
Index: ltp-full-20090630/testcases/commands/Makefile
===================================================================
--- ltp-full-20090630.orig/testcases/commands/Makefile
+++ ltp-full-20090630/testcases/commands/Makefile
@@ -1,12 +1,10 @@
-#SUBDIRS = `ls */Makefile | sed "s/Makefile//g" | grep -v at | grep -v unzip`
-SUBDIRS = `ls */Makefile | sed "s/Makefile//g"`
-
-all:
-	@set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i ; done
-
-install:
-	@set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i install ; done
-
-clean:
-	@set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i clean ; done
+#
+# Copyright (c) 2009 Cyril Hrubis chrubis@suse.cz
+#
+# Distributed under GPLv2 or any later
+#
 
+SUBDIRS=ade cron eject unzip
+SUBDIRS_INSTALL=ade at cpio cron eject fileutils gzip logrotate mail su tar tpm-tools unzip
+TOPDIR=../../
+include $(TOPDIR)Makefile.include
Index: ltp-full-20090630/testcases/commands/ade/Makefile
===================================================================
--- ltp-full-20090630.orig/testcases/commands/ade/Makefile
+++ ltp-full-20090630/testcases/commands/ade/Makefile
@@ -1,10 +1,10 @@
-SUBDIRS = ar objdump size ld ldd nm file
+#
+# Copyright (c) 2009 Cyril Hrubis chrubis@suse.cz
+#
+# Distributed under GPLv2 or any later
+#
 
-all:
-	@set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i ; done
-
-install:
-	@set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i install ; done
-
-clean:
-	@set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i clean ; done
+SUBDIRS=ar objdump size ld ldd nm
+SUBDIRS_INSTALL=ar objdump size ld ldd nm file
+TOPDIR=../../../
+include $(TOPDIR)Makefile.include
Index: ltp-full-20090630/testcases/commands/ade/ldd/Makefile
===================================================================
--- ltp-full-20090630.orig/testcases/commands/ade/ldd/Makefile
+++ ltp-full-20090630/testcases/commands/ade/ldd/Makefile
@@ -1,4 +1,7 @@
-CFLAGS += -c -O -fpic
+TOPDIR=../../../../
+include $(TOPDIR)Makefile.include
+
+CFLAGS += -O -fpic
 LDFLAGS += 
 
 SRCS:=$(wildcard *.c)
Index: ltp-full-20090630/testcases/commands/ade/nm/Makefile
===================================================================
--- ltp-full-20090630.orig/testcases/commands/ade/nm/Makefile
+++ ltp-full-20090630/testcases/commands/ade/nm/Makefile
@@ -1,5 +1,7 @@
-CFLAGS += -O -Wall
-LOADLIBES += 
+TOPDIR=../../../../
+include $(TOPDIR)Makefile.include
+
+CFLAGS += -O
 
 SRCS=$(wildcard *.c)
 OBJECTS=$(patsubst %.c,%.o,$(SRCS))
Index: ltp-full-20090630/testcases/commands/ade/objdump/Makefile
===================================================================
--- ltp-full-20090630.orig/testcases/commands/ade/objdump/Makefile
+++ ltp-full-20090630/testcases/commands/ade/objdump/Makefile
@@ -1,10 +1,25 @@
-CFLAGS += -w -o
-LDFLAGS +=
+#
+# Copyright (c) 2009 Cyril Hrubis chrubis@suse.cz
+#
+# Distributed under GPLv2 or any later
+#
+
+TOPDIR=../../../../
+include $(TOPDIR)Makefile.include
+
+TARGETS=test test_arch.o test_D
+
+all: $(TARGETS)
+
+#
+# Create symlinks so make can use default rules
+#
+test_arch.c:
+	@if [ -e test_arch.c ]; then true; else ln -s test.c test_arch.c; fi
 
-SRCS=$(wildcard *.c)
-TESTS= test test_arch.o test_D
+test_D.c:
+	@if [ -e test_D.c ]; then true; else ln -s test.c test_D.c; fi
 
-all: $(TESTS)
 
 install:
 	ln -f objdump01 ../../../bin
@@ -12,11 +27,11 @@ install:
 	ln -f test ../../../bin
 	ln -f test_D ../../../bin
 
+#
+# Extra flags for test binary, I'm not sure why, but
+# it was in previous Makefile.
+#
+test: CFLAGS+=-O
 
 clean:
-	rm -f $(TESTS)
-
-$(TESTS): 
-	$(CC) -O $(CFLAGS) $(cflags) test $(LDFLAGS) ./test.c
-	$(CC) -c $(CFLAGS) $(cflags) test_arch.o ./test.c
-	$(CC) $(CFLAGS) $(cflags) test_D $(LDFLAGS) ./test.c
+	rm -f $(TARGETS) test_arch.c test_D.c
Index: ltp-full-20090630/testcases/commands/ade/size/Makefile
===================================================================
--- ltp-full-20090630.orig/testcases/commands/ade/size/Makefile
+++ ltp-full-20090630/testcases/commands/ade/size/Makefile
@@ -1,3 +1,6 @@
+TOPDIR=../../../../
+include $(TOPDIR)Makefile.include
+
 CFLAGS += -w -O
 LDFLAGS += 
 
Index: ltp-full-20090630/testcases/commands/cron/Makefile
===================================================================
--- ltp-full-20090630.orig/testcases/commands/cron/Makefile
+++ ltp-full-20090630/testcases/commands/cron/Makefile
@@ -1,7 +1,7 @@
-all: cron_dirs_check
+TOPDIR=../../../
+include $(TOPDIR)Makefile.include
 
-cron_dirs_check:
-	$(CC) $(CROSS_CFLAGS) $(LDFLAGS) -o cron_dirs_check cron_dirs_check.c
+all: cron_dirs_check
 
 install:
 	chmod 755 cron_tests.sh
Index: ltp-full-20090630/testcases/commands/eject/Makefile
===================================================================
--- ltp-full-20090630.orig/testcases/commands/eject/Makefile
+++ ltp-full-20090630/testcases/commands/eject/Makefile
@@ -1,5 +1,5 @@
-CFLAGS+=    -I../../../include -Wall
-LOADLIBES+= -L../../../lib
+TOPDIR=../../../
+include $(TOPDIR)Makefile.include
 
 SRCS=$(wildcard *.c)
 TARGETS=$(patsubst %.c,%,$(SRCS))
Index: ltp-full-20090630/testcases/commands/unzip/Makefile
===================================================================
--- ltp-full-20090630.orig/testcases/commands/unzip/Makefile
+++ ltp-full-20090630/testcases/commands/unzip/Makefile
@@ -17,7 +17,7 @@ tst_unzip_file.zip: tst_unzip.dir
 # This target should be auto-removed by Make
 .INTERMEDIATE: tst_unzip.dir
 tst_unzip.dir: unzip_genfile.sh
-	./unzip_genfile.sh tst_unzip.dir
+	@./unzip_genfile.sh tst_unzip.dir
 
 install: all
 	@set -e; for i in $(BINS); do \
Index: ltp-full-20090630/testcases/kernel/Makefile
===================================================================
--- ltp-full-20090630.orig/testcases/kernel/Makefile
+++ ltp-full-20090630/testcases/kernel/Makefile
@@ -1,17 +1,11 @@
+#
+# Copyright (c) 2009 Cyril Hrubis chrubis@suse.cz
+#
+# Distributed under GPLv2 or any later
+#
+
 SUBDIRS = power_management numa containers controllers connectors include fs io ipc mem pty sched security syscalls timers
+SUBDIRS_INSTALL=$(SUBDIRS)
 UCLINUX_SUBDIRS = include syscalls
-
-all:
-	@set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i ; done
-
-install:
-	@set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i install ; done
-
-uclinux:
-	@set -e; for i in $(UCLINUX_SUBDIRS); do $(MAKE) -C $$i uclinux ; done
-
-uclinux_install:
-	@set -e; for i in $(UCLINUX_SUBDIRS); do $(MAKE) -C $$i uclinux_install ; done
-
-clean:
-	@set -e; for i in $(SUBDIRS) timers; do $(MAKE) -C $$i clean ; done
+TOPDIR=../../
+include $(TOPDIR)Makefile.include
Index: ltp-full-20090630/testcases/kernel/power_management/Makefile
===================================================================
--- ltp-full-20090630.orig/testcases/kernel/power_management/Makefile
+++ ltp-full-20090630/testcases/kernel/power_management/Makefile
@@ -1,6 +1,7 @@
 ################################################################################
 ##                                                                            ##
 ## Copyright (c) International Business Machines  Corp., 2008                 ##
+## Copyrignt (c) Cyril Hrubis chrubis@suse.cz 2009                            ##
 ##                                                                            ##
 ## This program is free software;  you can redistribute it and#or modify      ##
 ## it under the terms of the GNU General Public License as published by       ##
@@ -18,14 +19,12 @@
 ##                                                                            ##
 ################################################################################
 
-SUBDIRS := 
+TOPDIR=../../../
+include $(TOPDIR)Makefile.include
 
-all: 
-	@set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i $@; done;
-	$(MAKE) check_kv_arch ;
+LDFLAGS += $(TOPDIR)lib/libltp.a
 
-check_kv_arch: check_kv_arch.c
-	$(CC) -o $@ $< ../../../lib/tst_kvercmp.c -I../../../include
+all: check_kv_arch
 
 install:
 	@set -e; ln -f check_kv_arch ../../bin/check_kv_arch; \
@@ -45,6 +44,5 @@ install:
 	ln -f  sched_domain.py ../../bin/sched_domain.py
 	chmod ugo+x *.sh
 clean:
-	@set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i $@ ; done
 	rm -f check_kv_arch
 
Index: ltp-full-20090630/testcases/kernel/fs/fs_perms/Makefile
===================================================================
--- ltp-full-20090630.orig/testcases/kernel/fs/fs_perms/Makefile
+++ ltp-full-20090630/testcases/kernel/fs/fs_perms/Makefile
@@ -1,7 +1,7 @@
-CFLAGS += -Wall
-CPPFLAGS += -I../../../../include
-LDLIBS += -lltp
-LDFLAGS += -L../../../../lib
+TOPDIR=../../../../
+include $(TOPDIR)Makefile.include
+
+LDFLAGS=$(TOPDIR)lib/libltp.a
 
 TARGETS = fs_perms testx
 
Index: ltp-full-20090630/testcases/kernel/fs/fsstress/Makefile
===================================================================
--- ltp-full-20090630.orig/testcases/kernel/fs/fsstress/Makefile
+++ ltp-full-20090630/testcases/kernel/fs/fsstress/Makefile
@@ -1,5 +1,7 @@
-CFLAGS += -Wall -g -DNO_XFS -I. -D_LARGEFILE64_SOURCE -D_GNU_SOURCE
-LDFLAGS += 
+TOPDIR=../../../../
+include $(TOPDIR)Makefile.include
+
+CFLAGS += -DNO_XFS -D_LARGEFILE64_SOURCE -D_GNU_SOURCE
 
 SRCS=$(wildcard *.c)
 TARGETS=$(patsubst %.c,%,$(SRCS))
Index: ltp-full-20090630/testcases/kernel/fs/fsx-linux/Makefile
===================================================================
--- ltp-full-20090630.orig/testcases/kernel/fs/fsx-linux/Makefile
+++ ltp-full-20090630/testcases/kernel/fs/fsx-linux/Makefile
@@ -1,5 +1,7 @@
+TOPDIR=../../../../
+include $(TOPDIR)Makefile.include
+
 CFLAGS += -w -O
-LDFLAGS += 
 
 SRCS=$(wildcard *.c)
 TARGETS=$(patsubst %.c,%,$(SRCS))
Index: ltp-full-20090630/testcases/kernel/numa/Makefile
===================================================================
--- ltp-full-20090630.orig/testcases/kernel/numa/Makefile
+++ ltp-full-20090630/testcases/kernel/numa/Makefile
@@ -1,5 +1,6 @@
 #
 #  Copyright (c) International Business Machines  Corp., 2007
+#  Copyrignt (c) Cyril Hrubis chrubis@suse.cz 2009
 #
 #  This program is free software;  you can redistribute it and/or modify
 #  it under the terms of the GNU General Public License as published by
@@ -16,12 +17,14 @@
 #  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 #
 
-CFLAGS += -I../../../include -Wall -DNUMA_VERSION1_COMPATIBILITY
+TOPDIR=../../../
+include $(TOPDIR)Makefile.include
 
-LDLIBS += -L../../../lib -lltp 
+CFLAGS += -DNUMA_VERSION1_COMPATIBILITY
+LDFLAGS += $(TOPDIR)lib/libltp.a
 
 ifeq ($(HAS_NUMA),yes)    #its a numa machine
-LDLIBS += -L../../../lib  -lnuma
+LDFLAGS += -lnuma
 SRCS    = $(wildcard *.c)
 TARGETS = $(patsubst %.c,%,$(SRCS))
 else                                    #its not a numa machine
Index: ltp-full-20090630/testcases/kernel/fs/inode/Makefile
===================================================================
--- ltp-full-20090630.orig/testcases/kernel/fs/inode/Makefile
+++ ltp-full-20090630/testcases/kernel/fs/inode/Makefile
@@ -1,5 +1,6 @@
 #
 #  Copyright (c) International Business Machines  Corp., 2001
+#  Copyright (c) Cyril Hrubis chrubis@suse.cz 2009
 #
 #  This program is free software;  you can redistribute it and/or modify
 #  it under the terms of the GNU General Public License as published by
@@ -16,11 +17,14 @@
 #  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 #
 
+TOPDIR=../../../../
+include $(TOPDIR)Makefile.include
+
 ###########################################################################
 # name of file	: Makefile						  #
 ###########################################################################
-CFLAGS+=	-I../../../../include -g -O -Wall -DLINUX
-LOADLIBES+=	-L../../../../lib -lltp 
+CFLAGS += -O -DLINUX
+LDFLAGS+= $(TOPDIR)lib/libltp.a
 
 SRCS=$(wildcard *.c)
 TARGETS=$(patsubst %.c,%,$(SRCS))
Index: ltp-full-20090630/testcases/kernel/fs/lftest/Makefile
===================================================================
--- ltp-full-20090630.orig/testcases/kernel/fs/lftest/Makefile
+++ ltp-full-20090630/testcases/kernel/fs/lftest/Makefile
@@ -1,3 +1,6 @@
+TOPDIR=../../../../
+include $(TOPDIR)Makefile.include
+
 CFLAGS+= -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE
 SRCS=$(wildcard *.c)
 TARGETS=$(patsubst %.c,%,$(SRCS))
Index: ltp-full-20090630/testcases/kernel/fs/fs_di/Makefile
===================================================================
--- ltp-full-20090630.orig/testcases/kernel/fs/fs_di/Makefile
+++ ltp-full-20090630/testcases/kernel/fs/fs_di/Makefile
@@ -1,4 +1,7 @@
-CFLAGS+= -Wall -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE
+TOPDIR=../../../../
+include $(TOPDIR)Makefile.include
+
+CFLAGS+=-D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE
 SRCS=$(wildcard *.c)
 TARGETS=$(patsubst %.c,%,$(SRCS))
 
Index: ltp-full-20090630/testcases/kernel/fs/stream/Makefile
===================================================================
--- ltp-full-20090630.orig/testcases/kernel/fs/stream/Makefile
+++ ltp-full-20090630/testcases/kernel/fs/stream/Makefile
@@ -1,5 +1,6 @@
 #
 #  Copyright (c) International Business Machines  Corp., 2001
+#  Copyright (c) Cyril Hrubis chrubis@suse.cz 2009
 #
 #  This program is free software;  you can redistribute it and/or modify
 #  it under the terms of the GNU General Public License as published by
@@ -16,12 +17,15 @@
 #  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 #
 
+TOPDIR=../../../../
+include $(TOPDIR)Makefile.include
+
 ###########################################################################
 # name of file	: Makefile						  #
 # description	: make(1) description file for the send(2) tests.	  #
 ###########################################################################
-CFLAGS+=	-I../../../../include -Wall -g
-LOADLIBES+=	-L../../../../lib -lltp
+
+LDFLAGS+= $(TOPDIR)lib/libltp.a
 
 SRCS=$(wildcard *.c)
 TARGETS=$(patsubst %.c,%,$(SRCS))
Index: ltp-full-20090630/testcases/kernel/fs/fs_bind/Makefile
===================================================================
--- ltp-full-20090630.orig/testcases/kernel/fs/fs_bind/Makefile
+++ ltp-full-20090630/testcases/kernel/fs/fs_bind/Makefile
@@ -1,11 +1,15 @@
-# Propagate make "commands" (TARGETS) to subdirs
-TARGETS=all clean install uninstall
+#
+# Copyright (c) 2009 Cyril Hrubis chrubis@suse.cz
+#
+# Distributed under GPLv2 or any later
+#
+
 SUBDIRS=bin
+SUBDIRS_INSTALL=bin
+TOPDIR=../../../../
+include $(TOPDIR)Makefile.include
 
-.PHONY: $(TARGETS)
+$(SUBDIRS): do_warning
 
-$(TARGETS):%:
-	@set -e ; \
-	for dir in $(SUBDIRS); do \
-		$(MAKE) -C $$dir $@ ; \
-	done
+do_warning:
+	$(call print_warn, testcases/fs/fs_bind/ directory contains tests that are newer installed)
Index: ltp-full-20090630/testcases/kernel/fs/fs_bind/bin/Makefile
===================================================================
--- ltp-full-20090630.orig/testcases/kernel/fs/fs_bind/bin/Makefile
+++ ltp-full-20090630/testcases/kernel/fs/fs_bind/bin/Makefile
@@ -1,28 +1,20 @@
-.PHONY: all clean install
+#
+# Copyright (c) 2009 Cyril Hrubis chrubis@suse.cz
+#
+# Distributed under GPLv2 or any later
+#
 
-LTP_SRC_ROOT=../../../../..
-LTP_BIN=$(LTP_SRC_ROOT)/testcases/bin
-#CFLAGS+= -I$(LTP_SRC_ROOT)/include -Wall -g
-CFLAGS+= -Wall -g
-#LIBS+= -L$(LTP_SRC_ROOT)/lib -lltp
-LIBS+=
+TOPDIR=../../../../../
+include $(TOPDIR)Makefile.include
+
+LTP_BIN=$(TOPDIR)/testcases/bin
 
 all: smount nsclone
+	$(call print_warn, for some reason install target is commented; so this test is effectively disabled)
 
 install: all
 	#@ln -f nsclone $(LTP_BIN)/nsclone
 	#@ln -f smount $(LTP_BIN)/smount
-	@/bin/true
-
-uninstall:
-	#rm -f $(LTP_BIN)/nsclone $(LTP_BIN)/smount
-	@/bin/true
-
-nsclone: nsclone.c
-	$(CC) $(CFLAGS) $(LIBS) -o nsclone nsclone.c
-
-smount: smount.c
-	$(CC) $(CFLAGS) $(LIBS) -o smount smount.c
 
 clean:
 	rm -f smount nsclone
Index: ltp-full-20090630/testcases/kernel/fs/openfile/Makefile
===================================================================
--- ltp-full-20090630.orig/testcases/kernel/fs/openfile/Makefile
+++ ltp-full-20090630/testcases/kernel/fs/openfile/Makefile
@@ -1,4 +1,6 @@
-CFLAGS += -Wall
+TOPDIR=../../../../
+include $(TOPDIR)Makefile.include
+
 LOADLIBES += -lpthread
 
 SRCS=$(wildcard *.c)
Index: ltp-full-20090630/testcases/kernel/fs/proc/Makefile
===================================================================
--- ltp-full-20090630.orig/testcases/kernel/fs/proc/Makefile
+++ ltp-full-20090630/testcases/kernel/fs/proc/Makefile
@@ -1,5 +1,6 @@
 #
 #  Copyright (c) International Business Machines  Corp., 2001
+#  Copyright (c) Cyril Hrubis chrubis@suse.cz 2009
 #
 #  This program is free software;  you can redistribute it and/or modify
 #  it under the terms of the GNU General Public License as published by
@@ -16,10 +17,12 @@
 #  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 #
 
+TOPDIR=../../../../
+include $(TOPDIR)Makefile.include
+
 include ../../../../config.mk
 
-CFLAGS+=	-I../../../../include
-LDLIBS+=	-L../../../../lib -lltp $(SELINUX_LIBS)
+LDFLAGS += $(SELINUX_LIBS) $(TOPDIR)lib/libltp.a
 
 SRCS=$(wildcard *.c)
 TARGETS=$(patsubst %.c,%,$(SRCS))
Index: ltp-full-20090630/testcases/kernel/io/Makefile
===================================================================
--- ltp-full-20090630.orig/testcases/kernel/io/Makefile
+++ ltp-full-20090630/testcases/kernel/io/Makefile
@@ -1,10 +1,10 @@
-SUBDIRS = direct_io disktest stress_cd stress_floppy writetest aio
+#
+# Copyright (c) 2009 Cyril Hrubis chrubis@suse.cz
+#
+# Distributed under GPLv2 or any later
+#
 
-all:
-	@set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i ; done
-
-install:
-	@set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i install ; done
-
-clean:
-	@set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i clean ; done
+SUBDIRS=direct_io disktest stress_cd stress_floppy writetest aio
+SUBDIRS_INSTALL=$(SUBDIRS)
+TOPDIR=../../../
+include $(TOPDIR)Makefile.include
Index: ltp-full-20090630/testcases/kernel/io/direct_io/Makefile
===================================================================
--- ltp-full-20090630.orig/testcases/kernel/io/direct_io/Makefile
+++ ltp-full-20090630/testcases/kernel/io/direct_io/Makefile
@@ -4,55 +4,23 @@
 # History:
 # 04/10/2002	nsharoff	nsharoff@us.ibm.com
 #
+# Copyright Cyril Hrubis chrubi@suse.cz 2009
+#
 
+TOPDIR=../../../../
+include $(TOPDIR)Makefile.include
 
-CFLAGS+=		 -O -Wall -DSHARED_OFILE -D_GNU_SOURCE -I../../../../include -L../../../../lib 
-LOADLIBES+= -lltp
-
-SRCS=	diotest1.c diotest2.c diotest3.c diotest4.c diotest5.c \
-	diotest6.c dma_thread_diotest7.c
-
-BINS=	diotest1 diotest2 diotest3 diotest4 diotest5 \
-	diotest6 dma_thread_diotest7  
-
-all:	diotest_routines.o bins
-
-bins: $& $(BINS)
-
-diotest_routines.o: diotest_routines.c
-		 $(CC) -c diotest_routines.c $(CFLAGS) 
-
-diotest1: diotest1.c diotest_routines.o
-	$(CC) -o diotest1 diotest_routines.o diotest1.c  $(CFLAGS) $(LDFLAGS) $(LOADLIBES)
-	rm -f diotest1.o
-
-diotest2: diotest2.c diotest_routines.o
-	$(CC) -o diotest2 diotest_routines.o diotest2.c $(CFLAGS) $(LDFLAGS) $(LOADLIBES)
-	rm -f diotest2.o
-
-diotest3: diotest3.c diotest_routines.o 
-	$(CC) -o diotest3 diotest_routines.o diotest3.c $(CFLAGS) $(LDFLAGS) $(LOADLIBES)
-	rm -f diotest3.o
-
-diotest4: diotest4.c diotest_routines.o
-	$(CC) -o diotest4 diotest_routines.o diotest4.c $(CFLAGS) $(LDFLAGS) $(LOADLIBES)
-	rm -f diotest4.o
-
-diotest5: diotest5.c diotest_routines.o
-	$(CC) -o diotest5 diotest_routines.o diotest5.c $(CFLAGS) $(LDFLAGS) $(LOADLIBES)
-	rm -f diotest5.o
+CFLAGS +=-O -DSHARED_OFILE -D_GNU_SOURCE
+LDFLAGS+=diotest_routines.o $(TOPDIR)lib/libltp.a -lpthread
 
-diotest6: diotest6.c diotest_routines.o
-	$(CC) -o diotest6 diotest_routines.o diotest6.c $(CFLAGS) $(LDFLAGS) $(LOADLIBES)
-	rm -f diotest6.o
+BINS = diotest1 diotest2 diotest3 diotest4 diotest5\
+       diotest6 dma_thread_diotest7
 
-dma_thread_diotest7: dma_thread_diotest7.c
-	$(CC) -g -o dma_thread_diotest7 dma_thread_diotest7.c -lpthread
+all: diotest_routines.o $(BINS)
 
-clean:	
+clean:
 	rm -f $(BINS) diotest_routines.o
 
 install:
 	ln -f $(BINS) ../../../bin
 	ln -f test_dma_thread_diotest7.sh ../../../bin/
-
Index: ltp-full-20090630/testcases/kernel/io/disktest/Makefile
===================================================================
--- ltp-full-20090630.orig/testcases/kernel/io/disktest/Makefile
+++ ltp-full-20090630/testcases/kernel/io/disktest/Makefile
@@ -1,7 +1,7 @@
 #
 # Disktest Makefile
 # Copyright (c) International Business Machines Corp., 2001
-#
+# Copyright (c) Cyril Hrubis chrubis@suse.cz 2009
 #
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License as published by
@@ -22,140 +22,9 @@
 #
 #  Project Website:  TBD
 #
-#
-# $Id: Makefile,v 1.11 2008/02/14 08:22:22 subrata_modak Exp $
-# $Log: Makefile,v $
-# Revision 1.11  2008/02/14 08:22:22  subrata_modak
-# Disktest application update to version 1.4.2, by, Brent Yardley <yardleyb@us.ibm.com>
-#
-# Revision 1.31  2008/02/07 15:43:37  yardleyb
-# Applied patch from Mike Frysinger to ensure Makefile properly respect CFLAGS/LDFLAGS
-#
-# Revision 1.30  2006/10/19 20:01:48  yardleyb
-# changes made to support rpm builds
-#
-# Revision 1.29  2006/10/19 17:30:27  yardleyb
-# Added basic signal handling.
-#
-# Revision 1.28  2006/05/12 19:44:47  yardleyb
-# added CHANGELOG to distro
-# uninstall does not force a build
-#
-# Revision 1.27  2005/10/12 23:13:35  yardleyb
-# Updates to code to support new function in disktest version 1.3.x.
-# Actual changes are recorded in the README
-#
-# Revision 1.26  2004/12/18 06:13:03  yardleyb
-# Updated timer schema to more accurately use the time options.  Added
-# fsync on write option to -If.
-#
-# Revision 1.25  2004/12/17 06:34:56  yardleyb
-# removed -mf -ml.  These mark options cause to may issues when using
-# random block size transfers.  Fixed -ma option for endian-ness.  Fixed
-# false data misscompare during multiple cycles.
-#
-# Revision 1.24  2004/11/20 04:43:42  yardleyb
-# Minor code fixes.  Checking for alloc errors.
-#
-# Revision 1.23  2004/11/19 21:45:12  yardleyb
-# Fixed issue with code added for -F option.  Cased disktest
-# to SEG FAULT when cleaning up threads.
-#
-# Revision 1.22  2004/11/19 03:47:45  yardleyb
-# Fixed issue were args data was not being copied from a
-# clean source.
-#
-# Revision 1.21  2004/11/02 20:47:13  yardleyb
-# Added -F functions.
-# lots of minor fixes. see README
-#
-# Revision 1.20  2003/09/12 21:23:56  yardleyb
-# Updated version to 1.12
-#
-# Revision 1.19  2003/01/13 21:33:31  yardleyb
-# Added code to detect AIX volume size.
-# Updated mask for random LBA to use start_lba offset
-# Updated version to 1.1.10
-#
-# Revision 1.18  2002/05/31 18:48:50  yardleyb
-# Updated version to 1.1.9
-#
-# Revision 1.17  2002/04/24 01:59:45  yardleyb
-# Update to version v1.1.3
-#
-# Revision 1.16  2002/04/02 00:11:04  yardleyb
-# Corrected -D for each OS type
-#
-# Revision 1.15  2002/04/01 20:05:26  yardleyb
-# Modified Makefiles for linux,
-# Created Makefiles for windows/aix
-#
-# Revision 1.14  2002/03/07 03:38:52  yardleyb
-# Added dump function from command
-# line.  Created formatted dump output
-# for Data miscomare and command line.
-# Can now leave off filespec the full
-# path header as it will be added based
-# on -I.
-#
-# Revision 1.13  2002/02/28 04:25:45  yardleyb
-# reworked threading code
-# made locking code a macro.
-#
-# Revision 1.12  2002/02/26 19:35:59  yardleyb
-# Updates to parsing routines for user
-# input.  Added multipliers for -S and
-# -s command line arguments. Forced
-# default seeks to default if performing
-# a diskcache test.
-#
-# Revision 1.11  2002/02/21 21:42:15  yardleyb
-# Updated distro for man1
-#
-# Revision 1.10  2002/02/21 21:34:16  yardleyb
-# Cleaned up make dependancies
-# added install and uninstall
-#
-# Revision 1.9  2002/02/21 01:00:50  yardleyb
-# Added README and directory
-# structure to distro
-#
-# Revision 1.8  2002/02/19 02:46:37  yardleyb
-# Added changes to compile for AIX.
-# Update getvsiz so it returns a -1
-# if the ioctl fails and we handle
-# that fact correctly.  Added check
-# to force vsiz to always be greater
-# then stop_lba.
-#
-# Revision 1.7  2001/12/04 19:00:33  yardleyb
-# Updated to add new files and
-# filename changes
-#
-# Revision 1.6  2001/10/10 00:17:14  yardleyb
-# Added Copyright and GPL license text.
-# Miner bug fixes throughout text.
-#
-# Revision 1.5  2001/09/22 03:29:51  yardleyb
-# Added dependence on main.o for sfunc.h usage.h header files
-#
-# Revision 1.4  2001/09/10 22:14:27  yardleyb
-# Added clean up for tar file. Included man page in distro
-#
-# Revision 1.3  2001/09/06 18:23:30  yardleyb
-# Added duty cycle -D.  Updated usage. Added
-# make option to create .tar.gz of all files
-#
-# Revision 1.2  2001/09/05 22:44:42  yardleyb
-# Split out some of the special functions.
-# added O_DIRECT -Id.  Updated usage.  Lots
-# of clean up to functions.  Added header info
-# to pMsg.
-#
-# Revision 1.1  2001/09/04 19:28:07  yardleyb
-# Split usage out. Split header out.  Added usage text.
-# Made signal handler one function. code cleanup.
-#
+
+TOPDIR=../../../../
+include $(TOPDIR)Makefile.include
 
 # -D "_LARGE_FILES" is used in AIX to support 64bit functions and data types
 # -D"_LARGEFILE64_SOURCE" -D"_FILE_OFFSET_BITS=64" is used in Linux to support 64bit functions and data types. -D"_GNU_SOURCE" is to support Linux O_DIRECT
@@ -172,13 +41,13 @@ SRCS=$(wildcard *.c)
 OBJS=$(SRCS:.c=.o)
 
 CFLAGS += -g -Wall -O -D"LINUX" -D"_THREAD_SAFE" -D"_GNU_SOURCE" -D"_LARGE_FILES" -D"_LARGEFILE64_SOURCE" -D"_FILE_OFFSET_BITS=64" $(RPM_OPT_FLAGS)
+LDFLAGS += -lpthread
 
-all: $(OBJS) disktest
+all: disktest
 
-disktest: $(OBJS) $(SRCS) $(ALLHDRS)
-	$(CC) $(CFLAGS) -o disktest $(OBJS) $(LDFLAGS) -lpthread
+disktest: $(OBJS)
 
-main.o: main.c $(ALLHDRS)
+disktest.o: disktest.c $(ALLHDRS)
 sfunc.o: sfunc.c sfunc.h $(GBLHDRS)
 parse.o: parse.c parse.h sfunc.h $(GBLHDRS)
 childmain.o: childmain.c childmain.h sfunc.h parse.h threading.h $(GBLHDRS)
Index: ltp-full-20090630/testcases/kernel/io/disktest/disktest.c
===================================================================
--- /dev/null
+++ ltp-full-20090630/testcases/kernel/io/disktest/disktest.c
@@ -0,0 +1,509 @@
+/*
+* Disktest
+* Copyright (c) International Business Machines Corp., 2001
+*
+*
+* This program is free software; you can redistribute it and/or modify
+* it under the terms of the GNU General Public License as published by
+* the Free Software Foundation; either version 2 of the License, or
+* (at your option) any later version.
+*
+* This program is distributed in the hope that it will be useful,
+* but WITHOUT ANY WARRANTY; without even the implied warranty of
+* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+* GNU General Public License for more details.
+*
+* You should have received a copy of the GNU General Public License
+* along with this program; if not, write to the Free Software
+* Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+*
+*  Please send e-mail to yardleyb@us.ibm.com if you have
+*  questions or comments.
+*
+*  Project Website:  TBD
+*
+* $Id: main.c,v 1.11 2009/02/26 12:14:53 subrata_modak Exp $
+*
+*/
+#include <stdio.h>
+#ifdef WINDOWS
+#include <windows.h>
+#include <winioctl.h>
+#include <io.h>
+#include <process.h>
+#include <sys/stat.h>
+#include "getopt.h"
+#else
+#include <pthread.h>
+#include <sys/types.h>
+#include <unistd.h>
+#endif
+#include <stdlib.h>
+#include <stdarg.h>
+#include <stdint.h>
+#include <signal.h>
+#include <time.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <string.h>
+#include <ctype.h>
+
+#include "defs.h"
+#include "globals.h"
+#include "main.h"
+#include "usage.h"
+#include "sfunc.h"
+#include "parse.h"
+#include "childmain.h"
+#include "threading.h"
+#include "dump.h"
+#include "timer.h"
+#include "stats.h"
+#include "signals.h"
+
+/* global */
+child_args_t cleanArgs;
+test_env_t cleanEnv;
+char hostname[HOSTNAME_SIZE]; /* global system hostname */
+
+void linear_read_write_test(test_ll_t *test)
+{
+	OFF_T *pVal1 = (OFF_T *)test->env->shared_mem;
+	int i;
+
+	if(test->args->flags & CLD_FLG_W) {
+		test->env->bContinue = TRUE;
+		*(pVal1 + OFF_WLBA) = test->args->start_lba;
+		test->args->test_state = DIRCT_INC(test->args->test_state);
+		test->env->lastAction.oper = WRITER;
+		test->args->test_state = SET_OPER_W(test->args->test_state);
+		test->args->test_state = SET_wFST_TIME(test->args->test_state);
+//		srand(test->args->seed);	/* reseed so we can re create the same random transfers */
+		memset(test->env->action_list,0,sizeof(action_t)*test->args->t_kids);
+		test->env->action_list_entry = 0;
+		test->env->wcount = 0;
+		test->env->rcount = 0;
+		if(test->args->flags & CLD_FLG_CYC)
+			if(test->args->cycles == 0) {
+				pMsg(INFO,test->args, "Starting write pass, cycle %lu\n", (unsigned long) test->env->pass_count);
+			} else {
+				pMsg(INFO,test->args, "Starting write pass, cycle %lu of %lu\n", (unsigned long) test->env->pass_count, test->args->cycles);
+			}
+		else {
+			pMsg(INFO,test->args, "Starting write pass\n");
+		}
+		CreateTestChild(ChildTimer, test);
+		for(i=0;i<test->args->t_kids;i++) {
+			CreateTestChild(ChildMain, test);
+		}
+		/* Wait for the writers to finish */
+		cleanUpTestChildren(test);
+	}
+
+	/* If the write test failed don't start the read test */
+	if(!(TST_STS(test->args->test_state))) { return; }
+
+	if(test->args->flags & CLD_FLG_R) {
+		test->env->bContinue = TRUE;
+		*(pVal1 + OFF_RLBA) = test->args->start_lba;
+		test->args->test_state = DIRCT_INC(test->args->test_state);
+		test->env->lastAction.oper = READER;
+		test->args->test_state = SET_OPER_R(test->args->test_state);
+		test->args->test_state = SET_rFST_TIME(test->args->test_state);
+//		srand(test->args->seed);	/* reseed so we can re create the same random transfers */
+		memset(test->env->action_list,0,sizeof(action_t)*test->args->t_kids);
+		test->env->action_list_entry = 0;
+		test->env->wcount = 0;
+		test->env->rcount = 0;
+		if(test->args->flags & CLD_FLG_CYC)
+			if(test->args->cycles == 0) {
+				pMsg(INFO,test->args, "Starting read pass, cycle %lu\n", (unsigned long) test->env->pass_count);
+			} else {
+				pMsg(INFO,test->args, "Starting read pass, cycle %lu of %lu\n", (unsigned long) test->env->pass_count, test->args->cycles);
+			}
+		else {
+			pMsg(INFO,test->args, "Starting read pass\n");
+		}
+		CreateTestChild(ChildTimer, test);
+		for(i=0;i<test->args->t_kids;i++) {
+			CreateTestChild(ChildMain, test);
+		}
+		/* Wait for the readers to finish */
+		cleanUpTestChildren(test);
+	}
+}
+
+unsigned long init_data(test_ll_t *test, unsigned char **data_buffer_unaligned)
+{
+	int i;
+	OFF_T *pVal1;
+
+	unsigned long data_buffer_size;
+
+#ifdef WINDOWS
+	if(CreateMutex(NULL, FALSE, "gbl") == NULL) {
+		pMsg(ERR, test->args, "Failed to create semaphore, error = %u\n", GetLastError());
+		return(GetLastError());
+	}
+	if((test->env->mutexs.MutexACTION = CreateMutex(NULL, FALSE, NULL)) == NULL) {
+		pMsg(ERR, test->args, "Failed to create semaphore, error = %u\n", GetLastError());
+		return(GetLastError());
+	}
+	if((test->env->mutexs.MutexIO = CreateMutex(NULL, FALSE, NULL)) == NULL) {
+		pMsg(ERR, test->args, "Failed to create semaphore, error = %u\n", GetLastError());
+		return(GetLastError());
+	}
+#else
+
+	mutexs_t mutexs = { PTHREAD_MUTEX_INITIALIZER, PTHREAD_MUTEX_INITIALIZER };
+	test->env->mutexs = mutexs;
+
+#endif
+
+	if(test->args->seed == 0) test->args->seed = test->args->pid;
+	srand(test->args->seed);
+
+	/* create bitmap to hold write/read context: each bit is an LBA */
+	/* the stuff before BMP_OFFSET is the data for child/thread shared context */
+	test->env->bmp_siz = (((((size_t)test->args->vsiz))/8) == 0) ? 1 : ((((size_t)test->args->vsiz))/8);
+	if ((test->args->vsiz/8) != 0) test->env->bmp_siz += 1;	/* account for rounding error */
+
+	/* We use that same data buffer for static data, so alloc here. */
+	data_buffer_size = ((test->args->htrsiz*BLK_SIZE)*2);
+	if((*data_buffer_unaligned = (unsigned char *) ALLOC(data_buffer_size+ALIGNSIZE)) == NULL) {
+		pMsg(ERR,test->args,  "Failed to allocate static data buffer memory.\n");
+		return(-1);
+	}
+	/* create list to hold lbas currently be written */
+	if((test->env->action_list = (action_t *) ALLOC(sizeof(action_t)*test->args->t_kids)) == NULL) {
+		pMsg(ERR,test->args,  "Failed to allocate static data buffer memory.\n");
+		return(-1);
+	}
+
+	test->env->data_buffer = (unsigned char *) BUFALIGN(*data_buffer_unaligned);
+
+	if((test->env->shared_mem = (void *) ALLOC(test->env->bmp_siz+BMP_OFFSET)) == NULL) {
+		pMsg(ERR, test->args, "Failed to allocate bitmap memory\n");
+		return(-1);
+	}
+
+	memset(test->env->shared_mem,0,test->env->bmp_siz+BMP_OFFSET);
+	memset(test->env->data_buffer,0,data_buffer_size);
+	memset(test->env->action_list,0,sizeof(action_t)*test->args->t_kids);
+	test->env->action_list_entry = 0;
+
+	pVal1 = (OFF_T *)test->env->shared_mem;
+	*(pVal1 + OFF_WLBA) = test->args->start_lba;
+	*(pVal1 + OFF_RLBA) = test->args->start_lba;
+	test->args->test_state = SET_STS_PASS(test->args->test_state);
+	test->args->test_state = SET_wFST_TIME(test->args->test_state);
+	test->args->test_state = SET_rFST_TIME(test->args->test_state);
+	test->args->test_state = DIRCT_INC(test->args->test_state);
+	if(test->args->flags & CLD_FLG_W) {
+		test->env->lastAction.oper = WRITER;
+		test->args->test_state = SET_OPER_W(test->args->test_state);
+	} else {
+		test->env->lastAction.oper = READER;
+		test->args->test_state = SET_OPER_R(test->args->test_state);
+	}
+
+	/* prefill the data buffer with data for compares and writes */
+	switch(test->args->flags & CLD_FLG_PTYPS) {
+		case CLD_FLG_FPTYPE :
+			for(i=0;i<sizeof(test->args->pattern);i++) {
+				if((test->args->pattern & (((OFF_T) 0xff) << (((sizeof(test->args->pattern)-1)-i)*8))) != 0) break;
+			}
+			/* special case for pattern = 0 */
+			if(i == sizeof(test->args->pattern)) i = 0;
+			fill_buffer(test->env->data_buffer, data_buffer_size, &test->args->pattern, sizeof(test->args->pattern)-i, CLD_FLG_FPTYPE);
+			break;
+		case CLD_FLG_RPTYPE :
+			fill_buffer(test->env->data_buffer, data_buffer_size, NULL, 0, CLD_FLG_RPTYPE);
+			break;
+		case CLD_FLG_CPTYPE :
+			fill_buffer(test->env->data_buffer, data_buffer_size, 0, 0, CLD_FLG_CPTYPE);
+		case CLD_FLG_LPTYPE :
+			break;
+		default :
+			pMsg(WARN, test->args, "Unknown fill pattern\n");
+			return(-1);
+	}
+
+	return 0;
+}
+
+#ifdef WINDOWS
+DWORD WINAPI threadedMain(test_ll_t *test)
+#else
+void *threadedMain(void *vtest)
+#endif
+{
+#ifndef WINDOWS
+	test_ll_t *test = (test_ll_t *) vtest;
+#endif
+
+	OFF_T *pVal1;
+	unsigned char *data_buffer_unaligned = NULL;
+	unsigned long ulRV;
+	int i;
+	unsigned char *sharedMem;
+
+	extern unsigned long glb_run;
+	extern int signal_action;
+
+
+	test->args->pid = GETPID();
+
+	init_gbl_data(test->env);
+
+	if(make_assumptions(test->args) < 0) { TEXIT((uintptr_t)GETLASTERROR()); }
+	if(check_conclusions(test->args) < 0) { TEXIT((uintptr_t)GETLASTERROR()); }
+	if(test->args->flags & CLD_FLG_DUMP) {
+		/*
+		 * All we are doing is dumping filespec data to STDOUT, so
+		 * we will do this here and be done.
+		 */
+		do_dump(test->args);
+		TEXIT((uintptr_t)GETLASTERROR());
+	} else {
+		ulRV = init_data(test, &data_buffer_unaligned);
+		if(ulRV != 0) { TEXIT(ulRV); }
+		pVal1 = (OFF_T *)test->env->shared_mem;
+	}
+
+	pMsg(START, test->args, "Start args: %s\n", test->args->argstr);
+
+	/*
+	 * This loop takes care of passes
+	 */
+	do {
+		test->env->pass_count++;
+		test->env->start_time = time(NULL);
+		if(test->args->flags & CLD_FLG_RPTYPE) { /* force random data to be different each cycle */
+			fill_buffer(test->env->data_buffer, ((test->args->htrsiz*BLK_SIZE)*2), NULL, 0, CLD_FLG_RPTYPE);
+		}
+		sharedMem = test->env->shared_mem;
+		memset(sharedMem+BMP_OFFSET,0,test->env->bmp_siz);
+		if((test->args->flags & CLD_FLG_LINEAR) && !(test->args->flags & CLD_FLG_NTRLVD)) {
+			linear_read_write_test(test);
+		} else {
+			/* we only reset the end time if not running a linear read / write test */
+			test->env->end_time = test->env->start_time + test->args->run_time;
+			test->env->bContinue = TRUE;
+			*(pVal1 + OFF_WLBA) = test->args->start_lba;
+			test->args->test_state = DIRCT_INC(test->args->test_state);
+			test->args->test_state = SET_wFST_TIME(test->args->test_state);
+			test->args->test_state = SET_rFST_TIME(test->args->test_state);
+			if(test->args->flags & CLD_FLG_W) {
+				test->env->lastAction.oper = WRITER;
+				test->args->test_state = SET_OPER_W(test->args->test_state);
+			} else {
+				test->env->lastAction.oper = READER;
+				test->args->test_state = SET_OPER_R(test->args->test_state);
+			}
+			memset(test->env->action_list,0,sizeof(action_t)*test->args->t_kids);
+			test->env->action_list_entry = 0;
+			test->env->wcount = 0;
+			test->env->rcount = 0;
+
+			if(test->args->flags & CLD_FLG_CYC)
+				if(test->args->cycles == 0) {
+					pMsg(INFO,test->args, "Starting pass %lu\n", (unsigned long) test->env->pass_count);
+				} else {
+					pMsg(INFO,test->args, "Starting pass %lu of %lu\n", (unsigned long) test->env->pass_count, test->args->cycles);
+				}
+			else {
+				pMsg(INFO,test->args, "Starting pass\n");
+			}
+
+			CreateTestChild(ChildTimer, test);
+			for(i=0;i<test->args->t_kids;i++) {
+				CreateTestChild(ChildMain, test);
+			}
+			/* Wait for the children to finish */
+			cleanUpTestChildren(test);
+		}
+
+		update_cyc_stats(test->env);
+		if((test->args->flags & CLD_FLG_CYC) && (test->args->flags & CLD_FLG_PCYC)) {
+			print_stats(test->args, test->env, CYCLE);
+		}
+		update_gbl_stats(test->env);
+
+		if(signal_action & SIGNAL_STOP) { break; }	/* user request to stop */
+		if((glb_run == 0)) { break; }				/* global request to stop */
+
+		if(!(test->args->flags & CLD_FLG_CYC)) {
+			break;					/* leave, unless cycle testing */
+		} else {
+			if((test->args->cycles > 0) && (test->env->pass_count >= test->args->cycles)) {
+				break;				/* leave, cycle testing complete */
+			}
+		}
+	} while(TST_STS(test->args->test_state));
+	print_stats(test->args, test->env, TOTAL);
+
+	FREE(data_buffer_unaligned);
+	FREE(test->env->shared_mem);
+#ifdef WINDOWS
+	CloseHandle(OpenMutex(SYNCHRONIZE, TRUE, "gbl"));
+	CloseHandle(OpenMutex(SYNCHRONIZE, TRUE, "data"));
+#endif
+
+	if(TST_STS(test->args->test_state)) {
+		if (signal_action & SIGNAL_STOP) {
+			pMsg(END, test->args, "User Interrupt: Test Done (Passed)\n");
+		} else {
+			pMsg(END, test->args, "Test Done (Passed)\n");
+		}
+	} else {
+		if (signal_action & SIGNAL_STOP) {
+			pMsg(END, test->args, "User Interrupt: Test Done (Failed)\n");
+		} else {
+			pMsg(END, test->args, "Test Done (Failed)\n");
+		}
+	}
+	TEXIT((uintptr_t)GETLASTERROR());
+}
+
+/*
+ * Creates a new test structure and adds it to the list of
+ * test structures already available.  Allocate all memory
+ * needed by the new test.
+ *
+ * Returns the newly created test structure
+ */
+test_ll_t *getNewTest(test_ll_t *testList) {
+	test_ll_t *pNewTest;
+
+	if((pNewTest = (test_ll_t *)ALLOC(sizeof(test_ll_t))) == NULL) {
+		pMsg(ERR, &cleanArgs, "%d : Could not allocate memory for new test.\n", GETLASTERROR());
+		return NULL;
+	}
+
+	memset(pNewTest, 0, sizeof(test_ll_t));
+
+	if((pNewTest->args = (child_args_t *)ALLOC(sizeof(child_args_t))) == NULL) {
+		pMsg(ERR, &cleanArgs, "%d : Could not allocate memory for new test.\n", GETLASTERROR());
+		FREE(pNewTest);
+		return NULL;
+	}
+	if((pNewTest->env = (test_env_t *)ALLOC(sizeof(test_env_t))) == NULL) {
+		pMsg(ERR, &cleanArgs, "%d : Could not allocate memory for new test.\n", GETLASTERROR());
+		FREE(pNewTest->args);
+		FREE(pNewTest);
+		return NULL;
+	}
+	memcpy(pNewTest->args, &cleanArgs, sizeof(child_args_t));
+	memcpy(pNewTest->env, &cleanEnv, sizeof(test_env_t));
+
+	pNewTest->next = testList;
+	testList = pNewTest;
+	return pNewTest;
+}
+
+test_ll_t *run() {
+	test_ll_t *newTest = NULL, *lastTest = NULL;
+
+	if(cleanArgs.flags & CLD_FLG_FSLIST) {
+		char *filespec = cleanArgs.device;
+		char *aFilespec = NULL;
+		FILE *file = NULL;
+
+		if((aFilespec = (char *)ALLOC(80)) == NULL) {
+			pMsg(ERR, &cleanArgs, "Could not allocate memory to read file");
+			return newTest;
+		}
+
+		file = fopen(filespec, "r");
+			if(file == NULL) {
+				pMsg(
+					ERR,
+					&cleanArgs,
+					"%s is not a regular file, could not be opened for reading, or was not found.",
+					filespec);
+
+				return newTest;
+			}
+
+		while(!feof(file)) {
+			memset(aFilespec, 0, 80);
+			fscanf(file, "%79s", aFilespec);
+			if(aFilespec[0] != 0) { /* if we read something useful */
+				lastTest = newTest;
+				newTest = getNewTest(lastTest);
+				if(newTest != lastTest) {
+					memset(newTest->args->device, 0, DEV_NAME_LEN);
+					strncpy(newTest->args->device, aFilespec, strlen(aFilespec));
+					createChild(threadedMain, newTest);
+				} else {
+					newTest = lastTest;
+					break;
+				}
+			}
+		}
+
+		fclose(file);
+		FREE(aFilespec);
+	} else {
+		newTest = getNewTest(newTest);
+		if(newTest != NULL) {
+			createChild(threadedMain, newTest);
+		}
+	}
+
+	return newTest;
+}
+
+int main(int argc, char **argv)
+{
+	extern time_t global_start_time;
+	extern unsigned long glb_flags;	/* global flags GLB_FLG_xxx */
+	int i;
+
+#ifdef WINDOWS
+	WORD wVersionRequested;
+	WSADATA wsaData;
+	int err;
+
+	wVersionRequested = MAKEWORD( 2, 2 );
+
+	err = WSAStartup( wVersionRequested, &wsaData );
+	if(err != 0) {
+		pMsg(WARN, &cleanArgs, "Windows setup of Winsock failed, can't retrieve host name, continuing");
+	}
+#endif
+
+	setup_sig_mask();
+
+	memset(hostname, 0, HOSTNAME_SIZE);
+	gethostname(hostname, HOSTNAME_SIZE);
+
+	setbuf(stdout, (char *)NULL);
+
+	glb_flags = 0;
+	global_start_time = time(NULL);
+
+	strncpy(cleanArgs.device, "No filespec", strlen("No filespec"));
+	cleanArgs.stop_lba = -1;
+	cleanArgs.stop_blk = -1;
+	cleanArgs.ioTimeout = DEFAULT_IO_TIMEOUT;
+	cleanArgs.flags |= CLD_FLG_ALLDIE;
+	cleanArgs.flags |= CLD_FLG_ERR_REREAD;
+	cleanArgs.flags |= CLD_FLG_LBA_SYNC;
+
+	for(i=1;i<argc-1;i++) {
+		strncat(cleanArgs.argstr, argv[i], (MAX_ARG_LEN-1)-strlen(cleanArgs.argstr));
+		strncat(cleanArgs.argstr, " ", (MAX_ARG_LEN-1)-strlen(cleanArgs.argstr));
+	}
+
+	if(fill_cld_args(argc, argv, &cleanArgs) < 0) exit(1);
+
+	cleanUp(run());
+
+#ifdef WINDOWS
+    WSACleanup();
+#endif
+
+	return 0;
+}
Index: ltp-full-20090630/testcases/kernel/io/disktest/main.c
===================================================================
--- ltp-full-20090630.orig/testcases/kernel/io/disktest/main.c
+++ /dev/null
@@ -1,509 +0,0 @@
-/*
-* Disktest
-* Copyright (c) International Business Machines Corp., 2001
-*
-*
-* This program is free software; you can redistribute it and/or modify
-* it under the terms of the GNU General Public License as published by
-* the Free Software Foundation; either version 2 of the License, or
-* (at your option) any later version.
-*
-* This program is distributed in the hope that it will be useful,
-* but WITHOUT ANY WARRANTY; without even the implied warranty of
-* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-* GNU General Public License for more details.
-*
-* You should have received a copy of the GNU General Public License
-* along with this program; if not, write to the Free Software
-* Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
-*
-*  Please send e-mail to yardleyb@us.ibm.com if you have
-*  questions or comments.
-*
-*  Project Website:  TBD
-*
-* $Id: main.c,v 1.11 2009/02/26 12:14:53 subrata_modak Exp $
-*
-*/
-#include <stdio.h>
-#ifdef WINDOWS
-#include <windows.h>
-#include <winioctl.h>
-#include <io.h>
-#include <process.h>
-#include <sys/stat.h>
-#include "getopt.h"
-#else
-#include <pthread.h>
-#include <sys/types.h>
-#include <unistd.h>
-#endif
-#include <stdlib.h>
-#include <stdarg.h>
-#include <stdint.h>
-#include <signal.h>
-#include <time.h>
-#include <errno.h>
-#include <fcntl.h>
-#include <string.h>
-#include <ctype.h>
-
-#include "defs.h"
-#include "globals.h"
-#include "main.h"
-#include "usage.h"
-#include "sfunc.h"
-#include "parse.h"
-#include "childmain.h"
-#include "threading.h"
-#include "dump.h"
-#include "timer.h"
-#include "stats.h"
-#include "signals.h"
-
-/* global */
-child_args_t cleanArgs;
-test_env_t cleanEnv;
-char hostname[HOSTNAME_SIZE]; /* global system hostname */
-
-void linear_read_write_test(test_ll_t *test)
-{
-	OFF_T *pVal1 = (OFF_T *)test->env->shared_mem;
-	int i;
-
-	if(test->args->flags & CLD_FLG_W) {
-		test->env->bContinue = TRUE;
-		*(pVal1 + OFF_WLBA) = test->args->start_lba;
-		test->args->test_state = DIRCT_INC(test->args->test_state);
-		test->env->lastAction.oper = WRITER;
-		test->args->test_state = SET_OPER_W(test->args->test_state);
-		test->args->test_state = SET_wFST_TIME(test->args->test_state);
-//		srand(test->args->seed);	/* reseed so we can re create the same random transfers */
-		memset(test->env->action_list,0,sizeof(action_t)*test->args->t_kids);
-		test->env->action_list_entry = 0;
-		test->env->wcount = 0;
-		test->env->rcount = 0;
-		if(test->args->flags & CLD_FLG_CYC)
-			if(test->args->cycles == 0) {
-				pMsg(INFO,test->args, "Starting write pass, cycle %lu\n", (unsigned long) test->env->pass_count);
-			} else {
-				pMsg(INFO,test->args, "Starting write pass, cycle %lu of %lu\n", (unsigned long) test->env->pass_count, test->args->cycles);
-			}
-		else {
-			pMsg(INFO,test->args, "Starting write pass\n");
-		}
-		CreateTestChild(ChildTimer, test);
-		for(i=0;i<test->args->t_kids;i++) {
-			CreateTestChild(ChildMain, test);
-		}
-		/* Wait for the writers to finish */
-		cleanUpTestChildren(test);
-	}
-
-	/* If the write test failed don't start the read test */
-	if(!(TST_STS(test->args->test_state))) { return; }
-
-	if(test->args->flags & CLD_FLG_R) {
-		test->env->bContinue = TRUE;
-		*(pVal1 + OFF_RLBA) = test->args->start_lba;
-		test->args->test_state = DIRCT_INC(test->args->test_state);
-		test->env->lastAction.oper = READER;
-		test->args->test_state = SET_OPER_R(test->args->test_state);
-		test->args->test_state = SET_rFST_TIME(test->args->test_state);
-//		srand(test->args->seed);	/* reseed so we can re create the same random transfers */
-		memset(test->env->action_list,0,sizeof(action_t)*test->args->t_kids);
-		test->env->action_list_entry = 0;
-		test->env->wcount = 0;
-		test->env->rcount = 0;
-		if(test->args->flags & CLD_FLG_CYC)
-			if(test->args->cycles == 0) {
-				pMsg(INFO,test->args, "Starting read pass, cycle %lu\n", (unsigned long) test->env->pass_count);
-			} else {
-				pMsg(INFO,test->args, "Starting read pass, cycle %lu of %lu\n", (unsigned long) test->env->pass_count, test->args->cycles);
-			}
-		else {
-			pMsg(INFO,test->args, "Starting read pass\n");
-		}
-		CreateTestChild(ChildTimer, test);
-		for(i=0;i<test->args->t_kids;i++) {
-			CreateTestChild(ChildMain, test);
-		}
-		/* Wait for the readers to finish */
-		cleanUpTestChildren(test);
-	}
-}
-
-unsigned long init_data(test_ll_t *test, unsigned char **data_buffer_unaligned)
-{
-	int i;
-	OFF_T *pVal1;
-
-	unsigned long data_buffer_size;
-
-#ifdef WINDOWS
-	if(CreateMutex(NULL, FALSE, "gbl") == NULL) {
-		pMsg(ERR, test->args, "Failed to create semaphore, error = %u\n", GetLastError());
-		return(GetLastError());
-	}
-	if((test->env->mutexs.MutexACTION = CreateMutex(NULL, FALSE, NULL)) == NULL) {
-		pMsg(ERR, test->args, "Failed to create semaphore, error = %u\n", GetLastError());
-		return(GetLastError());
-	}
-	if((test->env->mutexs.MutexIO = CreateMutex(NULL, FALSE, NULL)) == NULL) {
-		pMsg(ERR, test->args, "Failed to create semaphore, error = %u\n", GetLastError());
-		return(GetLastError());
-	}
-#else
-
-	mutexs_t mutexs = { PTHREAD_MUTEX_INITIALIZER, PTHREAD_MUTEX_INITIALIZER };
-	test->env->mutexs = mutexs;
-
-#endif
-
-	if(test->args->seed == 0) test->args->seed = test->args->pid;
-	srand(test->args->seed);
-
-	/* create bitmap to hold write/read context: each bit is an LBA */
-	/* the stuff before BMP_OFFSET is the data for child/thread shared context */
-	test->env->bmp_siz = (((((size_t)test->args->vsiz))/8) == 0) ? 1 : ((((size_t)test->args->vsiz))/8);
-	if ((test->args->vsiz/8) != 0) test->env->bmp_siz += 1;	/* account for rounding error */
-
-	/* We use that same data buffer for static data, so alloc here. */
-	data_buffer_size = ((test->args->htrsiz*BLK_SIZE)*2);
-	if((*data_buffer_unaligned = (unsigned char *) ALLOC(data_buffer_size+ALIGNSIZE)) == NULL) {
-		pMsg(ERR,test->args,  "Failed to allocate static data buffer memory.\n");
-		return(-1);
-	}
-	/* create list to hold lbas currently be written */
-	if((test->env->action_list = (action_t *) ALLOC(sizeof(action_t)*test->args->t_kids)) == NULL) {
-		pMsg(ERR,test->args,  "Failed to allocate static data buffer memory.\n");
-		return(-1);
-	}
-
-	test->env->data_buffer = (unsigned char *) BUFALIGN(*data_buffer_unaligned);
-
-	if((test->env->shared_mem = (void *) ALLOC(test->env->bmp_siz+BMP_OFFSET)) == NULL) {
-		pMsg(ERR, test->args, "Failed to allocate bitmap memory\n");
-		return(-1);
-	}
-
-	memset(test->env->shared_mem,0,test->env->bmp_siz+BMP_OFFSET);
-	memset(test->env->data_buffer,0,data_buffer_size);
-	memset(test->env->action_list,0,sizeof(action_t)*test->args->t_kids);
-	test->env->action_list_entry = 0;
-
-	pVal1 = (OFF_T *)test->env->shared_mem;
-	*(pVal1 + OFF_WLBA) = test->args->start_lba;
-	*(pVal1 + OFF_RLBA) = test->args->start_lba;
-	test->args->test_state = SET_STS_PASS(test->args->test_state);
-	test->args->test_state = SET_wFST_TIME(test->args->test_state);
-	test->args->test_state = SET_rFST_TIME(test->args->test_state);
-	test->args->test_state = DIRCT_INC(test->args->test_state);
-	if(test->args->flags & CLD_FLG_W) {
-		test->env->lastAction.oper = WRITER;
-		test->args->test_state = SET_OPER_W(test->args->test_state);
-	} else {
-		test->env->lastAction.oper = READER;
-		test->args->test_state = SET_OPER_R(test->args->test_state);
-	}
-
-	/* prefill the data buffer with data for compares and writes */
-	switch(test->args->flags & CLD_FLG_PTYPS) {
-		case CLD_FLG_FPTYPE :
-			for(i=0;i<sizeof(test->args->pattern);i++) {
-				if((test->args->pattern & (((OFF_T) 0xff) << (((sizeof(test->args->pattern)-1)-i)*8))) != 0) break;
-			}
-			/* special case for pattern = 0 */
-			if(i == sizeof(test->args->pattern)) i = 0;
-			fill_buffer(test->env->data_buffer, data_buffer_size, &test->args->pattern, sizeof(test->args->pattern)-i, CLD_FLG_FPTYPE);
-			break;
-		case CLD_FLG_RPTYPE :
-			fill_buffer(test->env->data_buffer, data_buffer_size, NULL, 0, CLD_FLG_RPTYPE);
-			break;
-		case CLD_FLG_CPTYPE :
-			fill_buffer(test->env->data_buffer, data_buffer_size, 0, 0, CLD_FLG_CPTYPE);
-		case CLD_FLG_LPTYPE :
-			break;
-		default :
-			pMsg(WARN, test->args, "Unknown fill pattern\n");
-			return(-1);
-	}
-
-	return 0;
-}
-
-#ifdef WINDOWS
-DWORD WINAPI threadedMain(test_ll_t *test)
-#else
-void *threadedMain(void *vtest)
-#endif
-{
-#ifndef WINDOWS
-	test_ll_t *test = (test_ll_t *) vtest;
-#endif
-
-	OFF_T *pVal1;
-	unsigned char *data_buffer_unaligned = NULL;
-	unsigned long ulRV;
-	int i;
-	unsigned char *sharedMem;
-
-	extern unsigned long glb_run;
-	extern int signal_action;
-
-
-	test->args->pid = GETPID();
-
-	init_gbl_data(test->env);
-
-	if(make_assumptions(test->args) < 0) { TEXIT((uintptr_t)GETLASTERROR()); }
-	if(check_conclusions(test->args) < 0) { TEXIT((uintptr_t)GETLASTERROR()); }
-	if(test->args->flags & CLD_FLG_DUMP) {
-		/*
-		 * All we are doing is dumping filespec data to STDOUT, so
-		 * we will do this here and be done.
-		 */
-		do_dump(test->args);
-		TEXIT((uintptr_t)GETLASTERROR());
-	} else {
-		ulRV = init_data(test, &data_buffer_unaligned);
-		if(ulRV != 0) { TEXIT(ulRV); }
-		pVal1 = (OFF_T *)test->env->shared_mem;
-	}
-
-	pMsg(START, test->args, "Start args: %s\n", test->args->argstr);
-
-	/*
-	 * This loop takes care of passes
-	 */
-	do {
-		test->env->pass_count++;
-		test->env->start_time = time(NULL);
-		if(test->args->flags & CLD_FLG_RPTYPE) { /* force random data to be different each cycle */
-			fill_buffer(test->env->data_buffer, ((test->args->htrsiz*BLK_SIZE)*2), NULL, 0, CLD_FLG_RPTYPE);
-		}
-		sharedMem = test->env->shared_mem;
-		memset(sharedMem+BMP_OFFSET,0,test->env->bmp_siz);
-		if((test->args->flags & CLD_FLG_LINEAR) && !(test->args->flags & CLD_FLG_NTRLVD)) {
-			linear_read_write_test(test);
-		} else {
-			/* we only reset the end time if not running a linear read / write test */
-			test->env->end_time = test->env->start_time + test->args->run_time;
-			test->env->bContinue = TRUE;
-			*(pVal1 + OFF_WLBA) = test->args->start_lba;
-			test->args->test_state = DIRCT_INC(test->args->test_state);
-			test->args->test_state = SET_wFST_TIME(test->args->test_state);
-			test->args->test_state = SET_rFST_TIME(test->args->test_state);
-			if(test->args->flags & CLD_FLG_W) {
-				test->env->lastAction.oper = WRITER;
-				test->args->test_state = SET_OPER_W(test->args->test_state);
-			} else {
-				test->env->lastAction.oper = READER;
-				test->args->test_state = SET_OPER_R(test->args->test_state);
-			}
-			memset(test->env->action_list,0,sizeof(action_t)*test->args->t_kids);
-			test->env->action_list_entry = 0;
-			test->env->wcount = 0;
-			test->env->rcount = 0;
-
-			if(test->args->flags & CLD_FLG_CYC)
-				if(test->args->cycles == 0) {
-					pMsg(INFO,test->args, "Starting pass %lu\n", (unsigned long) test->env->pass_count);
-				} else {
-					pMsg(INFO,test->args, "Starting pass %lu of %lu\n", (unsigned long) test->env->pass_count, test->args->cycles);
-				}
-			else {
-				pMsg(INFO,test->args, "Starting pass\n");
-			}
-
-			CreateTestChild(ChildTimer, test);
-			for(i=0;i<test->args->t_kids;i++) {
-				CreateTestChild(ChildMain, test);
-			}
-			/* Wait for the children to finish */
-			cleanUpTestChildren(test);
-		}
-
-		update_cyc_stats(test->env);
-		if((test->args->flags & CLD_FLG_CYC) && (test->args->flags & CLD_FLG_PCYC)) {
-			print_stats(test->args, test->env, CYCLE);
-		}
-		update_gbl_stats(test->env);
-
-		if(signal_action & SIGNAL_STOP) { break; }	/* user request to stop */
-		if((glb_run == 0)) { break; }				/* global request to stop */
-
-		if(!(test->args->flags & CLD_FLG_CYC)) {
-			break;					/* leave, unless cycle testing */
-		} else {
-			if((test->args->cycles > 0) && (test->env->pass_count >= test->args->cycles)) {
-				break;				/* leave, cycle testing complete */
-			}
-		}
-	} while(TST_STS(test->args->test_state));
-	print_stats(test->args, test->env, TOTAL);
-
-	FREE(data_buffer_unaligned);
-	FREE(test->env->shared_mem);
-#ifdef WINDOWS
-	CloseHandle(OpenMutex(SYNCHRONIZE, TRUE, "gbl"));
-	CloseHandle(OpenMutex(SYNCHRONIZE, TRUE, "data"));
-#endif
-
-	if(TST_STS(test->args->test_state)) {
-		if (signal_action & SIGNAL_STOP) {
-			pMsg(END, test->args, "User Interrupt: Test Done (Passed)\n");
-		} else {
-			pMsg(END, test->args, "Test Done (Passed)\n");
-		}
-	} else {
-		if (signal_action & SIGNAL_STOP) {
-			pMsg(END, test->args, "User Interrupt: Test Done (Failed)\n");
-		} else {
-			pMsg(END, test->args, "Test Done (Failed)\n");
-		}
-	}
-	TEXIT((uintptr_t)GETLASTERROR());
-}
-
-/*
- * Creates a new test structure and adds it to the list of
- * test structures already available.  Allocate all memory
- * needed by the new test.
- *
- * Returns the newly created test structure
- */
-test_ll_t *getNewTest(test_ll_t *testList) {
-	test_ll_t *pNewTest;
-
-	if((pNewTest = (test_ll_t *)ALLOC(sizeof(test_ll_t))) == NULL) {
-		pMsg(ERR, &cleanArgs, "%d : Could not allocate memory for new test.\n", GETLASTERROR());
-		return NULL;
-	}
-
-	memset(pNewTest, 0, sizeof(test_ll_t));
-
-	if((pNewTest->args = (child_args_t *)ALLOC(sizeof(child_args_t))) == NULL) {
-		pMsg(ERR, &cleanArgs, "%d : Could not allocate memory for new test.\n", GETLASTERROR());
-		FREE(pNewTest);
-		return NULL;
-	}
-	if((pNewTest->env = (test_env_t *)ALLOC(sizeof(test_env_t))) == NULL) {
-		pMsg(ERR, &cleanArgs, "%d : Could not allocate memory for new test.\n", GETLASTERROR());
-		FREE(pNewTest->args);
-		FREE(pNewTest);
-		return NULL;
-	}
-	memcpy(pNewTest->args, &cleanArgs, sizeof(child_args_t));
-	memcpy(pNewTest->env, &cleanEnv, sizeof(test_env_t));
-
-	pNewTest->next = testList;
-	testList = pNewTest;
-	return pNewTest;
-}
-
-test_ll_t *run() {
-	test_ll_t *newTest = NULL, *lastTest = NULL;
-
-	if(cleanArgs.flags & CLD_FLG_FSLIST) {
-		char *filespec = cleanArgs.device;
-		char *aFilespec = NULL;
-		FILE *file = NULL;
-
-		if((aFilespec = (char *)ALLOC(80)) == NULL) {
-			pMsg(ERR, &cleanArgs, "Could not allocate memory to read file");
-			return newTest;
-		}
-
-		file = fopen(filespec, "r");
-			if(file == NULL) {
-				pMsg(
-					ERR,
-					&cleanArgs,
-					"%s is not a regular file, could not be opened for reading, or was not found.",
-					filespec);
-
-				return newTest;
-			}
-
-		while(!feof(file)) {
-			memset(aFilespec, 0, 80);
-			fscanf(file, "%79s", aFilespec);
-			if(aFilespec[0] != 0) { /* if we read something useful */
-				lastTest = newTest;
-				newTest = getNewTest(lastTest);
-				if(newTest != lastTest) {
-					memset(newTest->args->device, 0, DEV_NAME_LEN);
-					strncpy(newTest->args->device, aFilespec, strlen(aFilespec));
-					createChild(threadedMain, newTest);
-				} else {
-					newTest = lastTest;
-					break;
-				}
-			}
-		}
-
-		fclose(file);
-		FREE(aFilespec);
-	} else {
-		newTest = getNewTest(newTest);
-		if(newTest != NULL) {
-			createChild(threadedMain, newTest);
-		}
-	}
-
-	return newTest;
-}
-
-int main(int argc, char **argv)
-{
-	extern time_t global_start_time;
-	extern unsigned long glb_flags;	/* global flags GLB_FLG_xxx */
-	int i;
-
-#ifdef WINDOWS
-	WORD wVersionRequested;
-	WSADATA wsaData;
-	int err;
-
-	wVersionRequested = MAKEWORD( 2, 2 );
-
-	err = WSAStartup( wVersionRequested, &wsaData );
-	if(err != 0) {
-		pMsg(WARN, &cleanArgs, "Windows setup of Winsock failed, can't retrieve host name, continuing");
-	}
-#endif
-
-	setup_sig_mask();
-
-	memset(hostname, 0, HOSTNAME_SIZE);
-	gethostname(hostname, HOSTNAME_SIZE);
-
-	setbuf(stdout, (char *)NULL);
-
-	glb_flags = 0;
-	global_start_time = time(NULL);
-
-	strncpy(cleanArgs.device, "No filespec", strlen("No filespec"));
-	cleanArgs.stop_lba = -1;
-	cleanArgs.stop_blk = -1;
-	cleanArgs.ioTimeout = DEFAULT_IO_TIMEOUT;
-	cleanArgs.flags |= CLD_FLG_ALLDIE;
-	cleanArgs.flags |= CLD_FLG_ERR_REREAD;
-	cleanArgs.flags |= CLD_FLG_LBA_SYNC;
-
-	for(i=1;i<argc-1;i++) {
-		strncat(cleanArgs.argstr, argv[i], (MAX_ARG_LEN-1)-strlen(cleanArgs.argstr));
-		strncat(cleanArgs.argstr, " ", (MAX_ARG_LEN-1)-strlen(cleanArgs.argstr));
-	}
-
-	if(fill_cld_args(argc, argv, &cleanArgs) < 0) exit(1);
-
-	cleanUp(run());
-
-#ifdef WINDOWS
-    WSACleanup();
-#endif
-
-	return 0;
-}
Index: ltp-full-20090630/testcases/kernel/controllers/cpuset/Makefile
===================================================================
--- ltp-full-20090630.orig/testcases/kernel/controllers/cpuset/Makefile
+++ ltp-full-20090630/testcases/kernel/controllers/cpuset/Makefile
@@ -1,17 +1,27 @@
-SUBDIRS = cpuset_base_ops_test cpuset_lib cpuset_inherit_test
-SUBDIRS += cpuset_exclusive_test cpuset_hierarchy_test cpuset_syscall_test
-SUBDIRS += cpuset_hotplug_test cpuset_load_balance_test
-SUBDIRS += cpuset_memory_pressure_test cpuset_memory_spread_test
-SUBDIRS += cpuset_memory_test
-all:
-	@set -e; \
-	for i in $(SUBDIRS); do $(MAKE) -C $$i $@ ;done;
+#
+# Copyright (c) 2009 Cyril Hrubis chrubis@suse.cz
+#
+# Distributed under GPLv2 or any later
+#
+
+#SUBDIRS = cpuset_base_ops_test cpuset_lib cpuset_inherit_test
+#SUBDIRS += cpuset_exclusive_test cpuset_hierarchy_test cpuset_syscall_test
+#SUBDIRS += cpuset_hotplug_test cpuset_load_balance_test
+#SUBDIRS += cpuset_memory_pressure_test cpuset_memory_spread_test
+#SUBDIRS += cpuset_memory_test
+
+DIRS=cpuset_hotplug_test cpuset_load_balance_test cpuset_memory_test
+SUBDIRS=cpuset_lib $(DIRS) cpuset_memory_pressure_test cpuset_memory_spread_test
+SUBDIRS_INSTALL=$(SUBDIRS) cpuset_base_ops_test cpuset_exclusive_test cpuset_hierarchy_test cpuset_inherit_test
+
+TOPDIR=../../../../
+include $(TOPDIR)Makefile.include
+
+#
+# Some tests depends on cpuset_lib library, this fixes fails under "make -jN" for N > 2
+#
+$(DIRS): cpuset_lib
 
 install:
-	@set -e; \
-	for i in $(SUBDIRS); do $(MAKE) -C $$i install ; done;
 	ln -f run_cpuset_test.sh ../../../bin/run_cpuset_test.sh;
 	chmod +x run_cpuset_test.sh;
-
-clean:
-	@set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i clean ; done
Index: ltp-full-20090630/testcases/commands/ade/ld/Makefile
===================================================================
--- ltp-full-20090630.orig/testcases/commands/ade/ld/Makefile
+++ ltp-full-20090630/testcases/commands/ade/ld/Makefile
@@ -1,5 +1,13 @@
-CFLAGS += -O -Wall -fPIC
-LOADLIBES += 
+#
+# Copyright (c) 2009 Cyril Hrubis chrubis@suse.cz
+#
+# Distributed under GPLv2 or any later
+#
+
+TOPDIR=../../../../
+include $(TOPDIR)Makefile.include
+
+CFLAGS += -O -fPIC
 
 SRCS=$(wildcard *.c)
 OBJECTS=$(patsubst %.c,%.o,$(SRCS))
Index: ltp-full-20090630/testcases/commands/ade/ar/Makefile
===================================================================
--- ltp-full-20090630.orig/testcases/commands/ade/ar/Makefile
+++ ltp-full-20090630/testcases/commands/ade/ar/Makefile
@@ -1,5 +1,13 @@
-CFLAGS += -w -O
-LDFLAGS += 
+#
+# Copyright (c) 2009 Cyril Hrubis chrubis@suse.cz
+#
+# Distributed under GPLv2 or any later
+#
+
+TOPDIR=../../../../
+include $(TOPDIR)Makefile.include
+
+CFLAGS += -O
 
 SRCS=$(wildcard *.c)
 TARGETS=$(patsubst %.c,%,$(SRCS))
@@ -11,9 +19,6 @@ install:
 	ln -f file*.in ../../../bin
 	ln -f file1.o ../../../bin
 
-$(TARGETS):
-	$(CC) -o $@ $@.c $(CFLAGS) $(LDFLAGS)
-
 clean:
 	rm -f $(TARGETS) file1.o
 
Index: ltp-full-20090630/testcases/kernel/controllers/cpuset/cpuset_base_ops_test/Makefile
===================================================================
--- ltp-full-20090630.orig/testcases/kernel/controllers/cpuset/cpuset_base_ops_test/Makefile
+++ ltp-full-20090630/testcases/kernel/controllers/cpuset/cpuset_base_ops_test/Makefile
@@ -1,10 +1,10 @@
-SRCS = $(wildcard *.sh)
-
-all:
-	@true
+#
+# Copyright (c) 2009 Cyril Hrubis chrubis@suse.cz
+#
+# Distributed under GPLv2 or any later
+#
 
-clean:
-	@true
+SRCS = $(wildcard *.sh)
 
 install:
 	@set -e; \
Index: ltp-full-20090630/testcases/kernel/controllers/cpuset/cpuset_exclusive_test/Makefile
===================================================================
--- ltp-full-20090630.orig/testcases/kernel/controllers/cpuset/cpuset_exclusive_test/Makefile
+++ ltp-full-20090630/testcases/kernel/controllers/cpuset/cpuset_exclusive_test/Makefile
@@ -1,10 +1,10 @@
-SRCS = $(wildcard *.sh)
-
-all:
-	@true
+#
+# Copyright (c) 2009 Cyril Hrubis chrubis@suse.cz
+#
+# Distributed under GPLv2 or any later
+#
 
-clean:
-	@true
+SRCS = $(wildcard *.sh)
 
 install:
 	@set -e; \
Index: ltp-full-20090630/testcases/kernel/controllers/cpuset/cpuset_hierarchy_test/Makefile
===================================================================
--- ltp-full-20090630.orig/testcases/kernel/controllers/cpuset/cpuset_hierarchy_test/Makefile
+++ ltp-full-20090630/testcases/kernel/controllers/cpuset/cpuset_hierarchy_test/Makefile
@@ -1,10 +1,10 @@
-SRCS = $(wildcard *.sh)
-
-all:
-	@true
+#
+# Copyright (c) 2009 Cyril Hrubis chrubis@suse.cz
+#
+# Distributed under GPLv2 or any later
+#
 
-clean:
-	@true
+SRCS = $(wildcard *.sh)
 
 install:
 	@set -e; \
Index: ltp-full-20090630/testcases/kernel/controllers/cpuset/cpuset_hotplug_test/Makefile
===================================================================
--- ltp-full-20090630.orig/testcases/kernel/controllers/cpuset/cpuset_hotplug_test/Makefile
+++ ltp-full-20090630/testcases/kernel/controllers/cpuset/cpuset_hotplug_test/Makefile
@@ -1,19 +1,22 @@
-CFLAGS += -Wall -g -Wextra
-LDLIBS := -lm
+#
+# Copyright (c) 2009 Cyril Hrubis chrubis@suse.cz
+#
+# Distributed under GPLv2 or any later
+#
 
-LIBSRCS=$(wildcard ../cpuset_lib/*.c)
-LIBOBJECTS=$(patsubst %.c,%.o,$(LIBSRCS))
+TOPDIR=../../../../../
+include $(TOPDIR)Makefile.include
+
+LDFLAGS += -lm
+LOADLIBES = ../cpuset_lib/cpuset_lib.a
 
 SRCS=$(wildcard *.c)
-OBJECTS=$(patsubst %.c,%.o,$(SRCS))
-TARGETS=$(patsubst %.c,%,$(SRCS))
+TARGETS=$(SRCS:.c=)
 
 all: $(TARGETS)
 
-$(TARGETS): %: %.o $(LIBOBJECTS)
-
 clean:
-	rm -f $(TARGETS) $(OBJECTS) $(LIBOBJECTS)
+	rm -f $(TARGETS)
 
 install:
 	@set -e; \
Index: ltp-full-20090630/testcases/kernel/controllers/cpuset/cpuset_inherit_test/Makefile
===================================================================
--- ltp-full-20090630.orig/testcases/kernel/controllers/cpuset/cpuset_inherit_test/Makefile
+++ ltp-full-20090630/testcases/kernel/controllers/cpuset/cpuset_inherit_test/Makefile
@@ -1,10 +1,10 @@
-SRCS = $(wildcard *.sh)
-
-all:
-	@true
+#
+# Copyright (c) 2009 Cyril Hrubis chrubis@suse.cz
+#
+# Distributed under GPLv2 or any later
+#
 
-clean:
-	@true
+SRCS = $(wildcard *.sh)
 
 install:
 	@set -e; \
Index: ltp-full-20090630/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/Makefile
===================================================================
--- ltp-full-20090630.orig/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/Makefile
+++ ltp-full-20090630/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/Makefile
@@ -1,19 +1,22 @@
-CFLAGS += -Wall -g -Wextra
-LDLIBS := -lm
+#
+# Copyright (c) 2009 Cyril Hrubis chrubis@suse.cz
+#
+# Distributed under GPLv2 or any later
+#
 
-LIBSRCS=$(wildcard ../cpuset_lib/*.c)
-LIBOBJECTS=$(patsubst %.c,%.o,$(LIBSRCS))
+TOPDIR=../../../../../
+include $(TOPDIR)Makefile.include
+
+LDFLAGS += -lm
+LOADLIBES = ../cpuset_lib/cpuset_lib.a
 
 SRCS=$(wildcard *.c)
-OBJECTS=$(patsubst %.c,%.o,$(SRCS))
-TARGETS=$(patsubst %.c,%,$(SRCS))
+TARGETS=$(SRCS:.c=)
 
 all: $(TARGETS)
 
-$(TARGETS): %: %.o $(LIBOBJECTS)
-
 clean:
-	rm -f $(TARGETS) $(OBJECTS) $(LIBOBJECTS)
+	rm -f $(TARGETS) $(OBJECTS)
 
 install:
 	@set -e; \
Index: ltp-full-20090630/testcases/kernel/controllers/cpuset/cpuset_memory_pressure_test/Makefile
===================================================================
--- ltp-full-20090630.orig/testcases/kernel/controllers/cpuset/cpuset_memory_pressure_test/Makefile
+++ ltp-full-20090630/testcases/kernel/controllers/cpuset/cpuset_memory_pressure_test/Makefile
@@ -1,12 +1,16 @@
-CFLAGS += -Wall -g -Wextra
+#
+# Copyright (c) 2009 Cyril Hrubis chrubis@suse.cz
+#
+# Distributed under GPLv2 or any later
+#
 
-all: cpuset_memory_pressure
+TOPDIR=../../../../../
+include $(TOPDIR)Makefile.include
 
-cpuset_memory_pressure: cpuset_memory_pressure.o
-	cc cpuset_memory_pressure.o -o cpuset_memory_pressure
+all: cpuset_memory_pressure
 
 clean:
-	rm -f cpuset_memory_pressure.o cpuset_memory_pressure
+	rm -f cpuset_memory_pressure
 
 install:
 	@set -e;
Index: ltp-full-20090630/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/Makefile
===================================================================
--- ltp-full-20090630.orig/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/Makefile
+++ ltp-full-20090630/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/Makefile
@@ -1,12 +1,16 @@
-CFLAGS += -Wall -g -Wextra
+#
+# Copyright (c) 2009 Cyril Hrubis chrubis@suse.cz
+#
+# Distributed under GPLv2 or any later
+#
 
-all: cpuset_mem_hog
+TOPDIR=../../../../../
+include $(TOPDIR)Makefile.include
 
-cpuset_mem_hog: cpuset_mem_hog.o
-	cc cpuset_mem_hog.o -o cpuset_mem_hog
+all: cpuset_mem_hog
 
 clean:
-	rm -f cpuset_mem_hog.o cpuset_mem_hog
+	rm -f cpuset_mem_hog
 
 install:
 	@set -e;
Index: ltp-full-20090630/testcases/kernel/controllers/cpuset/cpuset_memory_test/Makefile
===================================================================
--- ltp-full-20090630.orig/testcases/kernel/controllers/cpuset/cpuset_memory_test/Makefile
+++ ltp-full-20090630/testcases/kernel/controllers/cpuset/cpuset_memory_test/Makefile
@@ -1,16 +1,19 @@
-CFLAGS += -Wall -g -Wextra
+#
+# Copyright (c) 2009 Cyril Hrubis chrubis@suse.cz
+#
+# Distributed under GPLv2 or any later
+#
 
-LIBSRCS=$(wildcard ../cpuset_lib/*.c)
-LIBOBJECTS=$(patsubst %.c,%.o,$(LIBSRCS))
+TOPDIR=../../../../../
+include $(TOPDIR)Makefile.include
 
-all: cpuset_memory_test
+LOADLIBES = ../cpuset_lib/cpuset_lib.a
+LDFLAGS = -lpthread
 
-cpuset_memory_test: cpuset_memory_test.o $(LIBOBJECTS)
-	cc cpuset_memory_test.o $(LIBOBJECTS) -o cpuset_memory_test -lpthread
+all: cpuset_memory_test
 
 clean:
-	rm -f cpuset_memory_test cpuset_memory_test.o
-	rm -f $(LIBOBJECTS)
+	rm -f cpuset_memory_test
 
 install:
 	@set -e;
Index: ltp-full-20090630/testcases/kernel/fs/ftest/Makefile
===================================================================
--- ltp-full-20090630.orig/testcases/kernel/fs/ftest/Makefile
+++ ltp-full-20090630/testcases/kernel/fs/ftest/Makefile
@@ -1,6 +1,8 @@
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
+#  Copyright (c) 2009 Cyril Hrubis chrubis@suse.cz
+#
 #  This program is free software;  you can redistribute it and/or modify
 #  it under the terms of the GNU General Public License as published by
 #  the Free Software Foundation; either version 2 of the License, or
@@ -16,15 +18,12 @@
 #  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 #
 
-###########################################################################
-# name of file	: Makefile						  #
-# description	: make(1) description file for the send(2) tests.	  #
-###########################################################################
-CFLAGS+=	-I../../../../include -Wall -g
-LOADLIBES+=	-L../../../../lib -lltp
+TOPDIR=../../../../
+include $(TOPDIR)Makefile.include
 
 SRCS=$(wildcard *.c)
 TARGETS=$(patsubst %.c,%,$(SRCS))
+LOADLIBES=$(TOPDIR)lib/libltp.a
 
 all: $(TARGETS)
 
@@ -33,5 +32,3 @@ install:
 
 clean:
 	rm -f $(TARGETS)
-
-

--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--u3/rZRmxL6MmkK24--

