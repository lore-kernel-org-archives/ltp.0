Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MPrwi-0002oY-LP
	for ltp-list@lists.sourceforge.net; Sun, 12 Jul 2009 05:49:56 +0000
Received: from mail-pz0-f178.google.com ([209.85.222.178])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MPrwh-0007st-9Z
	for ltp-list@lists.sourceforge.net; Sun, 12 Jul 2009 05:49:56 +0000
Received: by pzk8 with SMTP id 8so1405483pzk.28
	for <ltp-list@lists.sourceforge.net>;
	Sat, 11 Jul 2009 22:49:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <364299f40907062033j1660f689t65b8b8bdfb402f11@mail.gmail.com>
References: <364299f40907061818q7cda3465vffb00323af18c5f8@mail.gmail.com>
	<20090707021215.GC32310@count0.beaverton.ibm.com>
	<364299f40907062033j1660f689t65b8b8bdfb402f11@mail.gmail.com>
Date: Sat, 11 Jul 2009 22:49:52 -0700
Message-ID: <364299f40907112249g1a04c53cn4d25ce385f88bcaf@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Content-Type: multipart/mixed; boundary=000e0cd32f1e35e775046e7bc635
Subject: Re: [LTP] [PATCH 4/4] Make makefiles more autoconf friendly
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
To: Matt Helsley <matthltc@us.ibm.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

--000e0cd32f1e35e775046e7bc635
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Summary:
1. Fix a few minor bugs.
2. Update to reflect changes in master_rules.mk.
3. Add correct logic in configure.ac to set the default prefix.
4. Add mm.h check.
5. Don't remove generated files by default (whether or not it's a good
idea with CVS checkins, is another question...).

Signed-off-by: Garrett Cooper <yanegomi@gmail.com>

Index: configure.ac
===================================================================
RCS file: /cvsroot/ltp/ltp/configure.ac,v
retrieving revision 1.13
diff -u -r1.13 configure.ac
--- configure.ac	25 May 2009 15:01:45 -0000	1.13
+++ configure.ac	12 Jul 2009 05:46:28 -0000
@@ -2,15 +2,19 @@
 AC_INIT([ltp], [cvs], [ltp-results@lists.sourceforge.net])
 AM_INIT_AUTOMAKE([1.10])
 AC_CONFIG_HEADERS([include/config.h])
-AC_CONFIG_FILES([config.mk m4/Makefile])
+AC_CONFIG_FILES([ include/mk/config.mk lib/ltp.pc ltp-devel.spec m4/Makefile \
+README.ltp-devel ])

 AC_CANONICAL_HOST
 AC_PROG_CC
 AC_PROG_AR
 AC_PROG_RANLIB
+AC_PREFIX_DEFAULT(/opt/ltp)

 AC_CHECK_HEADERS_ONCE([ \
 ifaddrs.h \
+libaio.h \
+mm.h \
 sys/capability.h \
 sys/inotify.h \
 ])
Index: config.mk.in
===================================================================
RCS file: config.mk.in
diff -N config.mk.in
--- config.mk.in	31 Mar 2009 13:58:13 -0000	1.4
+++ /dev/null	1 Jan 1970 00:00:00 -0000
@@ -1,11 +0,0 @@
-CC = @CC@
-AR = @AR@
-RANLIB = @RANLIB@
-
-CPPFLAGS = @CPPFLAGS@
-CFLAGS = @CFLAGS@
-LDFLAGS = @LDFLAGS@
-
-AIO_LIBS = @AIO_LIBS@
-SELINUX_LIBS = @SELINUX_LIBS@
-CRYPTO_LIB = @CRYPTO_LIB@
Index: ltp-devel.spec.in
===================================================================
RCS file: ltp-devel.spec.in
diff -N ltp-devel.spec.in
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ ltp-devel.spec.in	12 Jul 2009 05:46:28 -0000
@@ -0,0 +1,68 @@
+#
+# RPM Package Manager (RPM) spec file for ltp-devel
+#
+Summary: Linux Test Project (LTP) Software Development Kit (SDK)
+Name: ltp-devel
+Version: 2.0
+Release: 0.0
+Prefix: @prefix@
+License: GPL
+Group: Development/Libraries
+URL: http://www.linuxtestproject.org
+Vendor: IBM Corp
+Packager: Subrata Modak <subrata.modak@@in.ibm.com>
+AutoReqProv:    0
+Provides:       LTP
+#ExclusiveArch:  i386
+ExclusiveOS:    linux
+%description
+This is a development package of the Linux Test Project (LTP).
+It is intended to be used to build testcases using the provided API.
+%files
+@prefix@/lib/libltp.a
+@datarootdir@/pkgconfig/ltp.pc
+@prefix@/bin/ltp-pan
+@prefix@/bin/ltp-scanner
+@prefix@/bin/ltp-bump
+@prefix@/include/linux_syscall_numbers.h
+@prefix@/include/libtestsuite.h
+@prefix@/include/usctest.h
+@prefix@/include/string_to_tokens.h
+@prefix@/include/str_to_bytes.h
+@prefix@/include/databin.h
+@prefix@/include/open_flags.h
+@prefix@/include/write_log.h
+@prefix@/include/dataascii.h
+@prefix@/include/forker.h
+@prefix@/include/compiler.h
+@prefix@/include/test.h
+@prefix@/include/tlibio.h
+@prefix@/include/pattern.h
+@prefix@/include/file_lock.h
+@prefix@/include/random_range.h
+@prefix@/include/search_path.h
+@prefix@/include/rmobj.h
+@mandir@/man3/tst_tmpdir.3
+@mandir@/man3/random_range_seed.3
+@mandir@/man3/pattern.3
+@mandir@/man3/parse_ranges.3
+@mandir@/man3/usctest.3
+@mandir@/man3/random_range.3
+@mandir@/man3/forker.3
+@mandir@/man3/rmobj.3
+@mandir@/man3/parse_open_flags.3
+@mandir@/man3/tst_res.3
+@mandir@/man3/write_log.3
+@mandir@/man3/str_to_bytes.3
+@mandir@/man3/tst_set_error.3
+@mandir@/man3/parse_opts.3
+@mandir@/man3/string_to_tokens.3
+@mandir@/man3/tst_sig.3
+@mandir@/man3/get_attrib.3
+@mandir@/man1/ltp-pan.1
+@mandir@/man1/doio.1
+@mandir@/man1/iogen.1
+@mandir@/man1/ltp-bump.1
+# Post-install stuff would go here.
+#EOF
+
Index: README.ltp-devel.in
===================================================================
RCS file: README.ltp-devel.in
diff -N README.ltp-devel.in
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ README.ltp-devel.in	12 Jul 2009 05:46:28 -0000
@@ -0,0 +1,48 @@
+This is a README to describe the ltp-devel.patch functional changes.
+
+"make install" is to build and install:
+
+	@prefix@/bin/ltp-bump
+	@prefix@/bin/ltp-pan
+	@prefix@/bin/ltp-scanner
+	@prefix@/lib/libltp.a
+	@datarootdir@/pkgconfig/ltp.pc
+	@prefix@/include/
+	@mandir@
+
+"make package" is to rpm package what was installed above:
+
+	/usr/src/redhat/RPMS/i386/ltp-devel-1.0-0.0.i386.rpm
+
+For someone wanting to write a standalone test that uses "libltp.a", then
+their Makefile would compile their test program like this:
+
+	test: test.c
+		cc test.c `pkg-config --cflags --libs ltp`
+
+To read manual pages, then the developer would type:
+(Most Important man pages)
+
+	man usctest
+	man ltp-pan
+	man tst_res
+	man tst_sig
+	man tst_set_error
+	man tst_tmpdir
+	man parse_opts
+
+(Others)
+	man ltp-bump
+	man doio
+	man iogen
+	man forker
+	man pattern
+	man random_range_seed
+	man string_to_tokens
+	man get_attrib
+	man parse_open_flags
+	man parse_ranges
+	man random_range
+	man rmobj
+	man str_to_bytes
+	man write_log
Index: include/mk/config.mk.in
===================================================================
RCS file: include/mk/config.mk.in
diff -N include/mk/config.mk.in
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ include/mk/config.mk.in	12 Jul 2009 05:46:28 -0000
@@ -0,0 +1,82 @@
+#
+#    config.mk.in.
+#
+#    Copyright (C) 2009, Cisco Systems Inc.
+#
+#    This program is free software; you can redistribute it and/or modify
+#    it under the terms of the GNU General Public License as published by
+#    the Free Software Foundation; either version 2 of the License, or
+#    (at your option) any later version.
+#
+#    This program is distributed in the hope that it will be useful,
+#    but WITHOUT ANY WARRANTY; without even the implied warranty of
+#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#    GNU General Public License for more details.
+#
+#    You should have received a copy of the GNU General Public License along
+#    with this program; if not, write to the Free Software Foundation, Inc.,
+#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+# Garrett Cooper, July 2009
+#
+
+# Application specifying variables. You should never have to change these.
+AR		= @AR@
+CC		= @CC@
+RANLIB		= @RANLIB@
+
+RPMBUILD	?= rpmbuild
+
+AIO_LIBS	= @AIO_LIBS@
+CRYPTO_LIB	= @CRYPTO_LIB@
+SELINUX_LIBS	= @SELINUX_LIBS@
+
+prefix		= @prefix@
+
+datarootdir	= @datarootdir@
+includedir	= @includedir@
+exec_prefix	= @exec_prefix@
+libdir		= @libdir@
+mandir		= @mandir@
+
+srcdir		?= .
+
+# Avoid overwriting definitions in leaf callers.
+CPPFLAGS	?= @CPPFLAGS@ -I$(includedir)
+CFLAGS		?= @CFLAGS@
+LDLIBS		?= @LIBS@
+LDFLAGS		?= @LDFLAGS@ -L$(libdir)
+
+DEBUG_CFLAGS	?= -g
+DEBUG_CXXFLAGS	?= $(DEBUG_CFLAGS)
+
+CFLAGS		+= $(DEBUG_CFLAGS)
+CXXFLAGS	+= $(DEBUG_CXXFLAGS)
+
+# There have been several bugs in the past related to -O2+ when
+# -fno-strict-aliasing is not specified.
+OPT_CFLAGS	?= -O2 -fno-strict-aliasing
+OPT_CXXFLAGS	?= $(OPT_CFLAGS)
+
+CFLAGS		+= $(OPT_CFLAGS)
+CXXFLAGS	+= $(OPT_CXXFLAGS)
+
+WCFLAGS		?= -Wall
+WCXXFLAGS	?= $(WCFLAGS)
+
+CFLAGS		+= $(WCFLAGS)
+CXXFLAGS	+= $(WCXXFLAGS)
+
+LDFLAGS		+= $(WLDFLAGS)
+
+# Only check for numa when not cross-compiling.
+ifeq ($(strip $(CROSS_COMPILE)),1)
+# Disable all undetectable cross-compilation required items.
+HAS_NUMA	?= 0
+else
+# Only check for numa when not cross-compiling.
+HAS_NUMA	?= $(shell sh $(top_srcdir)/tools/scripts/numa_test.sh 2>/dev/null)
+endif
+
+#export AR CC CFLAGS CPPFLAGS LDLIBS LDFLAGS RANLIB
+export datarootdir includedir libdir mandir prefix
Index: include/Makefile
===================================================================
RCS file: /cvsroot/ltp/ltp/include/Makefile,v
retrieving revision 1.7
diff -u -r1.7 Makefile
--- include/Makefile	23 Jun 2009 14:18:16 -0000	1.7
+++ include/Makefile	12 Jul 2009 05:46:28 -0000
@@ -1,27 +1,46 @@
+#
+#    include Makefile.
+#
+#    Copyright (C) 2009, Cisco Systems Inc.
+#
+#    This program is free software; you can redistribute it and/or modify
+#    it under the terms of the GNU General Public License as published by
+#    the Free Software Foundation; either version 2 of the License, or
+#    (at your option) any later version.
+#
+#    This program is distributed in the hope that it will be useful,
+#    but WITHOUT ANY WARRANTY; without even the implied warranty of
+#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#    GNU General Public License for more details.
+#
+#    You should have received a copy of the GNU General Public License along
+#    with this program; if not, write to the Free Software Foundation, Inc.,
+#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+# Garrett Cooper, July 2009
+#
+
+top_srcdir		?= ..
+
+include $(top_srcdir)/include/mk/master_include.mk
+
+CLEAN_DEPS		:= ac-clean
+
+INSTALL_DIR		:= $(includedir)

+INSTALL_MODE		:= 00644

-PREFIX=/opt/ltp
-HEADERS=compiler.h dataascii.h databin.h file_lock.h forker.h open_flags.h \
-	pattern.h random_range.h rmobj.h search_path.h string_to_tokens.h \
-	str_to_bytes.h test.h tlibio.h usctest.h write_log.h \
-	linux_syscall_numbers.h libtestsuite.h config.h
-
-.PHONY: all install
-all:
-
-install: $(HEADERS)
-	@set -e; for i in $(HEADERS); do \
-		install -D -m 644 $$i $(DESTDIR)/$(PREFIX)/include/ltp/$$i; \
-	done
+INSTALL_TARGETS		:= $(wildcard $(srcdir)/*.h)

-.PHONY: clean distclean maintainer-clean
-clean: ac-clean
+MAKE_TARGETS		:=
+
+.PHONY: ac-clean ac-distclean ac-maintainer-clean distclean maintainer-clean
 distclean: clean ac-distclean
 maintainer-clean: distclean ac-maintainer-clean
-
-.PHONY: ac-clean ac-distclean ac-maintainerclean
 ac-clean:
 ac-distclean:
-	rm -f config.h
+	$(RM) -f config.h
 ac-maintainer-clean:
-	rm -f config.h.in
+	$(RM) -f config.h.in
+
+$(eval $(generic_leaf_target))
Index: lib/Makefile
===================================================================
RCS file: /cvsroot/ltp/ltp/lib/Makefile,v
retrieving revision 1.16
diff -u -r1.16 Makefile
--- lib/Makefile	3 Apr 2009 06:58:18 -0000	1.16
+++ lib/Makefile	12 Jul 2009 05:46:28 -0000
@@ -1,26 +1,44 @@
+#
+#    lib Makefile.
+#
+#    Copyright (C) 2009, Cisco Systems Inc.
+#
+#    This program is free software; you can redistribute it and/or modify
+#    it under the terms of the GNU General Public License as published by
+#    the Free Software Foundation; either version 2 of the License, or
+#    (at your option) any later version.
+#
+#    This program is distributed in the hope that it will be useful,
+#    but WITHOUT ANY WARRANTY; without even the implied warranty of
+#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#    GNU General Public License for more details.
+#
+#    You should have received a copy of the GNU General Public License along
+#    with this program; if not, write to the Free Software Foundation, Inc.,
+#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+# Garrett Cooper, July 2009
+#

-PREFIX=/opt/ltp
+top_srcdir		?= ..
+
+include $(top_srcdir)/include/mk/lib.mk

-CFLAGS+= -Wall
-CPPFLAGS+= -I../include
 ifeq ($(shell uname -s),HP-UX)
-CFLAGS+=-Ae -D_LARGEFILE64_SOURCE +DA1.1
+CFLAGS			+=-Ae -D_LARGEFILE64_SOURCE +DA1.1
 endif
 ifeq ($(UCLINUX),1)
-CFLAGS+= -D_USC_LIB_ -D__UCLIBC__ -DUCLINUX
+CFLAGS			+= -D_USC_LIB_ -D__UCLIBC__ -DUCLINUX
 endif
-LDFLAGS+=
-TARGET=libltp.a
-SRCS=$(wildcard *.c)
-OBJS=$(patsubst %.c,%.o,$(SRCS))
-
-$(TARGET): $(OBJS)
-	$(AR) -cr $@ $^
-
-clean:
-	rm -f $(TARGET) $(OBJS)
-
-install: $(TARGET)
-	install -D -m 644 $(TARGET) $(DESTDIR)/$(PREFIX)/lib$(LIBSUFFIX)/$(TARGET)
-	install -D -m 644 ltp.pc $(DESTDIR)/$(PREFIX)/share/pkgconfig/ltp.pc

+LIB			:= libltp.a
+
+pc_file			:= $(DESTDIR)/$(datarootdir)/pkgconfig/ltp.pc
+
+INSTALL_TARGETS		:= $(pc_file)
+
+$(pc_file):
+	test -d "$(@D)" || mkdir -p "$(@D)"
+	install -m $(INSTALL_MODE) "$(srcdir)/$(@F)" "$@"
+
+$(eval $(lib_target))
Index: lib/ltp.pc.in
===================================================================
RCS file: lib/ltp.pc.in
diff -N lib/ltp.pc.in
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ lib/ltp.pc.in	12 Jul 2009 05:46:28 -0000
@@ -0,0 +1,11 @@
+prefix=@prefix@
+exec_prefix=@exec_prefix@
+includedir=@includedir@
+libdir=@libdir@
+
+Name: LTP
+Description: Linux Test Project
+Version: 1.0
+Libs: -L${libdir} -lltp
+Cflags: -I${includedir}
+Libs.private: -L${libdir} -lltp
Index: m4/GNUmakefile
===================================================================
RCS file: /cvsroot/ltp/ltp/m4/GNUmakefile,v
retrieving revision 1.1
diff -u -r1.1 GNUmakefile
--- m4/GNUmakefile	18 Jan 2009 22:22:40 -0000	1.1
+++ m4/GNUmakefile	12 Jul 2009 05:46:28 -0000
@@ -1,12 +1,37 @@
+#
+#    m4 Makefile.
+#
+#    Copyright (C) 2009, Cisco Systems Inc.
+#
+#    This program is free software; you can redistribute it and/or modify
+#    it under the terms of the GNU General Public License as published by
+#    the Free Software Foundation; either version 2 of the License, or
+#    (at your option) any later version.
+#
+#    This program is distributed in the hope that it will be useful,
+#    but WITHOUT ANY WARRANTY; without even the implied warranty of
+#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#    GNU General Public License for more details.
+#
+#    You should have received a copy of the GNU General Public License along
+#    with this program; if not, write to the Free Software Foundation, Inc.,
+#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+# Garrett Cooper, July 2009
+#

+srcdir			?= ..

-PREFIX=/opt/ltp
-M4MACROS=$(notdir $(wildcard *.m4))
+include $(srcdir)/include/mk/master_include.mk

-all:
+M4MACROS		:= $(notdir $(wildcard *.m4))

-install: $(M4MACROS)
-	for i in $(M4MACROS); do \
-		install -D -m 644 $$i $(DESTDIR)/$(PREFIX)/share/aclocal/$$i; \
-	done
+INSTALL_DIR		:= $(datarootdir)/aclocal

+INSTALL_MODE		:= 00644
+
+INSTALL_TARGETS		:= $(M4_MACROS)
+
+MAKE_TARGETS		:=
+
+$(eval $(generic_leaf_target))
Index: pan/Makefile
===================================================================
RCS file: /cvsroot/ltp/ltp/pan/Makefile,v
retrieving revision 1.19
diff -u -r1.19 Makefile
--- pan/Makefile	19 May 2009 09:39:11 -0000	1.19
+++ pan/Makefile	12 Jul 2009 05:46:28 -0000
@@ -1,24 +1,39 @@
+#
+#    pan Makefile.
+#
+#    Copyright (C) 2009, Cisco Systems Inc.
+#
+#    This program is free software; you can redistribute it and/or modify
+#    it under the terms of the GNU General Public License as published by
+#    the Free Software Foundation; either version 2 of the License, or
+#    (at your option) any later version.
+#
+#    This program is distributed in the hope that it will be useful,
+#    but WITHOUT ANY WARRANTY; without even the implied warranty of
+#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#    GNU General Public License for more details.
+#
+#    You should have received a copy of the GNU General Public License along
+#    with this program; if not, write to the Free Software Foundation, Inc.,
+#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+# Garrett Cooper, July 2009
+#
+
+top_srcdir		?= ..
+
+include $(top_srcdir)/include/mk/master_include.mk
+
+LDLIBS			+= -lm
+LFLAGS			+= -l -w
+CFLAGS			+= -w

-LOADLIBES += -lm
-LFLAGS += -l -w
-CFLAGS += -w
-PREFIX = /opt/ltp
-
-all: ltp-pan ltp-bump ltp-scanner
-
-ltp-pan: ltp-pan.o zoolib.o splitstr.o
-
+MAKE_TARGETS		:= ltp-bump ltp-pan ltp-scanner

 ltp-bump: ltp-bump.o zoolib.o

+ltp-pan: ltp-pan.o zoolib.o splitstr.o

 ltp-scanner: scan.o ltp-scanner.o reporter.o tag_report.o symbol.o
splitstr.o debug.o

-
-install: ltp-pan ltp-bump ltp-scanner
-	install -D ltp-scanner $(DESTDIR)/$(PREFIX)/bin/ltp-scanner
-	install -D ltp-pan $(DESTDIR)/$(PREFIX)/bin/ltp-pan
-	install -D ltp-bump $(DESTDIR)/$(PREFIX)/bin/ltp-bump
-
-clean:
-	rm -f *.o ltp-pan ltp-bump ltp-scanner
+$(eval $(generic_leaf_target))

--000e0cd32f1e35e775046e7bc635
Content-Type: application/octet-stream; 
	name="better-autoconf-Make-system.2.diff"
Content-Disposition: attachment; filename="better-autoconf-Make-system.2.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fx1cizd80

SW5kZXg6IGNvbmZpZ3VyZS5hYwo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09ClJDUyBmaWxlOiAvY3Zzcm9vdC9sdHAvbHRw
L2NvbmZpZ3VyZS5hYyx2CnJldHJpZXZpbmcgcmV2aXNpb24gMS4xMwpkaWZmIC11IC1yMS4xMyBj
b25maWd1cmUuYWMKLS0tIGNvbmZpZ3VyZS5hYwkyNSBNYXkgMjAwOSAxNTowMTo0NSAtMDAwMAkx
LjEzCisrKyBjb25maWd1cmUuYWMJMTIgSnVsIDIwMDkgMDU6NDY6MjggLTAwMDAKQEAgLTIsMTUg
KzIsMTkgQEAKIEFDX0lOSVQoW2x0cF0sIFtjdnNdLCBbbHRwLXJlc3VsdHNAbGlzdHMuc291cmNl
Zm9yZ2UubmV0XSkKIEFNX0lOSVRfQVVUT01BS0UoWzEuMTBdKQogQUNfQ09ORklHX0hFQURFUlMo
W2luY2x1ZGUvY29uZmlnLmhdKQotQUNfQ09ORklHX0ZJTEVTKFtjb25maWcubWsgbTQvTWFrZWZp
bGVdKQorQUNfQ09ORklHX0ZJTEVTKFsgaW5jbHVkZS9tay9jb25maWcubWsgbGliL2x0cC5wYyBs
dHAtZGV2ZWwuc3BlYyBtNC9NYWtlZmlsZSBcCitSRUFETUUubHRwLWRldmVsIF0pCiAKIEFDX0NB
Tk9OSUNBTF9IT1NUCiBBQ19QUk9HX0NDCiBBQ19QUk9HX0FSCiBBQ19QUk9HX1JBTkxJQgorQUNf
UFJFRklYX0RFRkFVTFQoL29wdC9sdHApCiAKIEFDX0NIRUNLX0hFQURFUlNfT05DRShbIFwKIGlm
YWRkcnMuaCBcCitsaWJhaW8uaCBcCittbS5oIFwKIHN5cy9jYXBhYmlsaXR5LmggXAogc3lzL2lu
b3RpZnkuaCBcCiBdKQpJbmRleDogY29uZmlnLm1rLmluCj09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KUkNTIGZpbGU6IGNv
bmZpZy5tay5pbgpkaWZmIC1OIGNvbmZpZy5tay5pbgotLS0gY29uZmlnLm1rLmluCTMxIE1hciAy
MDA5IDEzOjU4OjEzIC0wMDAwCTEuNAorKysgL2Rldi9udWxsCTEgSmFuIDE5NzAgMDA6MDA6MDAg
LTAwMDAKQEAgLTEsMTEgKzAsMCBAQAotQ0MgPSBAQ0NACi1BUiA9IEBBUkAKLVJBTkxJQiA9IEBS
QU5MSUJACi0KLUNQUEZMQUdTID0gQENQUEZMQUdTQAotQ0ZMQUdTID0gQENGTEFHU0AKLUxERkxB
R1MgPSBATERGTEFHU0AKLQotQUlPX0xJQlMgPSBAQUlPX0xJQlNACi1TRUxJTlVYX0xJQlMgPSBA
U0VMSU5VWF9MSUJTQAotQ1JZUFRPX0xJQiA9IEBDUllQVE9fTElCQApJbmRleDogbHRwLWRldmVs
LnNwZWMuaW4KPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PQpSQ1MgZmlsZTogbHRwLWRldmVsLnNwZWMuaW4KZGlmZiAtTiBs
dHAtZGV2ZWwuc3BlYy5pbgotLS0gL2Rldi9udWxsCTEgSmFuIDE5NzAgMDA6MDA6MDAgLTAwMDAK
KysrIGx0cC1kZXZlbC5zcGVjLmluCTEyIEp1bCAyMDA5IDA1OjQ2OjI4IC0wMDAwCkBAIC0wLDAg
KzEsNjggQEAKKyMKKyMgUlBNIFBhY2thZ2UgTWFuYWdlciAoUlBNKSBzcGVjIGZpbGUgZm9yIGx0
cC1kZXZlbAorIworU3VtbWFyeTogTGludXggVGVzdCBQcm9qZWN0IChMVFApIFNvZnR3YXJlIERl
dmVsb3BtZW50IEtpdCAoU0RLKQorTmFtZTogbHRwLWRldmVsCitWZXJzaW9uOiAyLjAKK1JlbGVh
c2U6IDAuMAorUHJlZml4OiBAcHJlZml4QAorTGljZW5zZTogR1BMCitHcm91cDogRGV2ZWxvcG1l
bnQvTGlicmFyaWVzCitVUkw6IGh0dHA6Ly93d3cubGludXh0ZXN0cHJvamVjdC5vcmcKK1ZlbmRv
cjogSUJNIENvcnAKK1BhY2thZ2VyOiBTdWJyYXRhIE1vZGFrIDxzdWJyYXRhLm1vZGFrQEBpbi5p
Ym0uY29tPgorQXV0b1JlcVByb3Y6ICAgIDAKK1Byb3ZpZGVzOiAgICAgICBMVFAKKyNFeGNsdXNp
dmVBcmNoOiAgaTM4NgorRXhjbHVzaXZlT1M6ICAgIGxpbnV4CislZGVzY3JpcHRpb24KK1RoaXMg
aXMgYSBkZXZlbG9wbWVudCBwYWNrYWdlIG9mIHRoZSBMaW51eCBUZXN0IFByb2plY3QgKExUUCku
CitJdCBpcyBpbnRlbmRlZCB0byBiZSB1c2VkIHRvIGJ1aWxkIHRlc3RjYXNlcyB1c2luZyB0aGUg
cHJvdmlkZWQgQVBJLgorJWZpbGVzCitAcHJlZml4QC9saWIvbGlibHRwLmEKK0BkYXRhcm9vdGRp
ckAvcGtnY29uZmlnL2x0cC5wYworQHByZWZpeEAvYmluL2x0cC1wYW4KK0BwcmVmaXhAL2Jpbi9s
dHAtc2Nhbm5lcgorQHByZWZpeEAvYmluL2x0cC1idW1wCitAcHJlZml4QC9pbmNsdWRlL2xpbnV4
X3N5c2NhbGxfbnVtYmVycy5oCitAcHJlZml4QC9pbmNsdWRlL2xpYnRlc3RzdWl0ZS5oCitAcHJl
Zml4QC9pbmNsdWRlL3VzY3Rlc3QuaAorQHByZWZpeEAvaW5jbHVkZS9zdHJpbmdfdG9fdG9rZW5z
LmgKK0BwcmVmaXhAL2luY2x1ZGUvc3RyX3RvX2J5dGVzLmgKK0BwcmVmaXhAL2luY2x1ZGUvZGF0
YWJpbi5oCitAcHJlZml4QC9pbmNsdWRlL29wZW5fZmxhZ3MuaAorQHByZWZpeEAvaW5jbHVkZS93
cml0ZV9sb2cuaAorQHByZWZpeEAvaW5jbHVkZS9kYXRhYXNjaWkuaAorQHByZWZpeEAvaW5jbHVk
ZS9mb3JrZXIuaAorQHByZWZpeEAvaW5jbHVkZS9jb21waWxlci5oCitAcHJlZml4QC9pbmNsdWRl
L3Rlc3QuaAorQHByZWZpeEAvaW5jbHVkZS90bGliaW8uaAorQHByZWZpeEAvaW5jbHVkZS9wYXR0
ZXJuLmgKK0BwcmVmaXhAL2luY2x1ZGUvZmlsZV9sb2NrLmgKK0BwcmVmaXhAL2luY2x1ZGUvcmFu
ZG9tX3JhbmdlLmgKK0BwcmVmaXhAL2luY2x1ZGUvc2VhcmNoX3BhdGguaAorQHByZWZpeEAvaW5j
bHVkZS9ybW9iai5oCitAbWFuZGlyQC9tYW4zL3RzdF90bXBkaXIuMworQG1hbmRpckAvbWFuMy9y
YW5kb21fcmFuZ2Vfc2VlZC4zCitAbWFuZGlyQC9tYW4zL3BhdHRlcm4uMworQG1hbmRpckAvbWFu
My9wYXJzZV9yYW5nZXMuMworQG1hbmRpckAvbWFuMy91c2N0ZXN0LjMKK0BtYW5kaXJAL21hbjMv
cmFuZG9tX3JhbmdlLjMKK0BtYW5kaXJAL21hbjMvZm9ya2VyLjMKK0BtYW5kaXJAL21hbjMvcm1v
YmouMworQG1hbmRpckAvbWFuMy9wYXJzZV9vcGVuX2ZsYWdzLjMKK0BtYW5kaXJAL21hbjMvdHN0
X3Jlcy4zCitAbWFuZGlyQC9tYW4zL3dyaXRlX2xvZy4zCitAbWFuZGlyQC9tYW4zL3N0cl90b19i
eXRlcy4zCitAbWFuZGlyQC9tYW4zL3RzdF9zZXRfZXJyb3IuMworQG1hbmRpckAvbWFuMy9wYXJz
ZV9vcHRzLjMKK0BtYW5kaXJAL21hbjMvc3RyaW5nX3RvX3Rva2Vucy4zCitAbWFuZGlyQC9tYW4z
L3RzdF9zaWcuMworQG1hbmRpckAvbWFuMy9nZXRfYXR0cmliLjMKK0BtYW5kaXJAL21hbjEvbHRw
LXBhbi4xCitAbWFuZGlyQC9tYW4xL2RvaW8uMQorQG1hbmRpckAvbWFuMS9pb2dlbi4xCitAbWFu
ZGlyQC9tYW4xL2x0cC1idW1wLjEKKyMgUG9zdC1pbnN0YWxsIHN0dWZmIHdvdWxkIGdvIGhlcmUu
CisjRU9GCisKSW5kZXg6IFJFQURNRS5sdHAtZGV2ZWwuaW4KPT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQpSQ1MgZmlsZTog
UkVBRE1FLmx0cC1kZXZlbC5pbgpkaWZmIC1OIFJFQURNRS5sdHAtZGV2ZWwuaW4KLS0tIC9kZXYv
bnVsbAkxIEphbiAxOTcwIDAwOjAwOjAwIC0wMDAwCisrKyBSRUFETUUubHRwLWRldmVsLmluCTEy
IEp1bCAyMDA5IDA1OjQ2OjI4IC0wMDAwCkBAIC0wLDAgKzEsNDggQEAKK1RoaXMgaXMgYSBSRUFE
TUUgdG8gZGVzY3JpYmUgdGhlIGx0cC1kZXZlbC5wYXRjaCBmdW5jdGlvbmFsIGNoYW5nZXMuCisK
KyJtYWtlIGluc3RhbGwiIGlzIHRvIGJ1aWxkIGFuZCBpbnN0YWxsOgorCisJQHByZWZpeEAvYmlu
L2x0cC1idW1wCisJQHByZWZpeEAvYmluL2x0cC1wYW4KKwlAcHJlZml4QC9iaW4vbHRwLXNjYW5u
ZXIKKwlAcHJlZml4QC9saWIvbGlibHRwLmEKKwlAZGF0YXJvb3RkaXJAL3BrZ2NvbmZpZy9sdHAu
cGMKKwlAcHJlZml4QC9pbmNsdWRlLworCUBtYW5kaXJACisKKyJtYWtlIHBhY2thZ2UiIGlzIHRv
IHJwbSBwYWNrYWdlIHdoYXQgd2FzIGluc3RhbGxlZCBhYm92ZToKKworCS91c3Ivc3JjL3JlZGhh
dC9SUE1TL2kzODYvbHRwLWRldmVsLTEuMC0wLjAuaTM4Ni5ycG0KKworRm9yIHNvbWVvbmUgd2Fu
dGluZyB0byB3cml0ZSBhIHN0YW5kYWxvbmUgdGVzdCB0aGF0IHVzZXMgImxpYmx0cC5hIiwgdGhl
bgordGhlaXIgTWFrZWZpbGUgd291bGQgY29tcGlsZSB0aGVpciB0ZXN0IHByb2dyYW0gbGlrZSB0
aGlzOgorCisJdGVzdDogdGVzdC5jCisJCWNjIHRlc3QuYyBgcGtnLWNvbmZpZyAtLWNmbGFncyAt
LWxpYnMgbHRwYAorCitUbyByZWFkIG1hbnVhbCBwYWdlcywgdGhlbiB0aGUgZGV2ZWxvcGVyIHdv
dWxkIHR5cGU6CisoTW9zdCBJbXBvcnRhbnQgbWFuIHBhZ2VzKQorCisJbWFuIHVzY3Rlc3QKKwlt
YW4gbHRwLXBhbgorCW1hbiB0c3RfcmVzCisJbWFuIHRzdF9zaWcKKwltYW4gdHN0X3NldF9lcnJv
cgorCW1hbiB0c3RfdG1wZGlyCisJbWFuIHBhcnNlX29wdHMKKworKE90aGVycykKKwltYW4gbHRw
LWJ1bXAKKwltYW4gZG9pbworCW1hbiBpb2dlbgorCW1hbiBmb3JrZXIKKwltYW4gcGF0dGVybgor
CW1hbiByYW5kb21fcmFuZ2Vfc2VlZAorCW1hbiBzdHJpbmdfdG9fdG9rZW5zCisJbWFuIGdldF9h
dHRyaWIKKwltYW4gcGFyc2Vfb3Blbl9mbGFncworCW1hbiBwYXJzZV9yYW5nZXMKKwltYW4gcmFu
ZG9tX3JhbmdlCisJbWFuIHJtb2JqCisJbWFuIHN0cl90b19ieXRlcworCW1hbiB3cml0ZV9sb2cK
SW5kZXg6IGluY2x1ZGUvbWsvY29uZmlnLm1rLmluCj09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KUkNTIGZpbGU6IGluY2x1
ZGUvbWsvY29uZmlnLm1rLmluCmRpZmYgLU4gaW5jbHVkZS9tay9jb25maWcubWsuaW4KLS0tIC9k
ZXYvbnVsbAkxIEphbiAxOTcwIDAwOjAwOjAwIC0wMDAwCisrKyBpbmNsdWRlL21rL2NvbmZpZy5t
ay5pbgkxMiBKdWwgMjAwOSAwNTo0NjoyOCAtMDAwMApAQCAtMCwwICsxLDgyIEBACisjCisjICAg
IGNvbmZpZy5tay5pbi4KKyMKKyMgICAgQ29weXJpZ2h0IChDKSAyMDA5LCBDaXNjbyBTeXN0ZW1z
IEluYy4KKyMKKyMgICAgVGhpcyBwcm9ncmFtIGlzIGZyZWUgc29mdHdhcmU7IHlvdSBjYW4gcmVk
aXN0cmlidXRlIGl0IGFuZC9vciBtb2RpZnkKKyMgICAgaXQgdW5kZXIgdGhlIHRlcm1zIG9mIHRo
ZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBhcyBwdWJsaXNoZWQgYnkKKyMgICAgdGhlIEZy
ZWUgU29mdHdhcmUgRm91bmRhdGlvbjsgZWl0aGVyIHZlcnNpb24gMiBvZiB0aGUgTGljZW5zZSwg
b3IKKyMgICAgKGF0IHlvdXIgb3B0aW9uKSBhbnkgbGF0ZXIgdmVyc2lvbi4KKyMKKyMgICAgVGhp
cyBwcm9ncmFtIGlzIGRpc3RyaWJ1dGVkIGluIHRoZSBob3BlIHRoYXQgaXQgd2lsbCBiZSB1c2Vm
dWwsCisjICAgIGJ1dCBXSVRIT1VUIEFOWSBXQVJSQU5UWTsgd2l0aG91dCBldmVuIHRoZSBpbXBs
aWVkIHdhcnJhbnR5IG9mCisjICAgIE1FUkNIQU5UQUJJTElUWSBvciBGSVRORVNTIEZPUiBBIFBB
UlRJQ1VMQVIgUFVSUE9TRS4gIFNlZSB0aGUKKyMgICAgR05VIEdlbmVyYWwgUHVibGljIExpY2Vu
c2UgZm9yIG1vcmUgZGV0YWlscy4KKyMKKyMgICAgWW91IHNob3VsZCBoYXZlIHJlY2VpdmVkIGEg
Y29weSBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgYWxvbmcKKyMgICAgd2l0aCB0
aGlzIHByb2dyYW07IGlmIG5vdCwgd3JpdGUgdG8gdGhlIEZyZWUgU29mdHdhcmUgRm91bmRhdGlv
biwgSW5jLiwKKyMgICAgNTEgRnJhbmtsaW4gU3RyZWV0LCBGaWZ0aCBGbG9vciwgQm9zdG9uLCBN
QSAwMjExMC0xMzAxIFVTQS4KKyMKKyMgR2FycmV0dCBDb29wZXIsIEp1bHkgMjAwOQorIworCisj
IEFwcGxpY2F0aW9uIHNwZWNpZnlpbmcgdmFyaWFibGVzLiBZb3Ugc2hvdWxkIG5ldmVyIGhhdmUg
dG8gY2hhbmdlIHRoZXNlLgorQVIJCT0gQEFSQAorQ0MJCT0gQENDQAorUkFOTElCCQk9IEBSQU5M
SUJACisKK1JQTUJVSUxECT89IHJwbWJ1aWxkCisKK0FJT19MSUJTCT0gQEFJT19MSUJTQAorQ1JZ
UFRPX0xJQgk9IEBDUllQVE9fTElCQAorU0VMSU5VWF9MSUJTCT0gQFNFTElOVVhfTElCU0AKKwor
cHJlZml4CQk9IEBwcmVmaXhACisKK2RhdGFyb290ZGlyCT0gQGRhdGFyb290ZGlyQAoraW5jbHVk
ZWRpcgk9IEBpbmNsdWRlZGlyQAorZXhlY19wcmVmaXgJPSBAZXhlY19wcmVmaXhACitsaWJkaXIJ
CT0gQGxpYmRpckAKK21hbmRpcgkJPSBAbWFuZGlyQAorCitzcmNkaXIJCT89IC4KKworIyBBdm9p
ZCBvdmVyd3JpdGluZyBkZWZpbml0aW9ucyBpbiBsZWFmIGNhbGxlcnMuCitDUFBGTEFHUwk/PSBA
Q1BQRkxBR1NAIC1JJChpbmNsdWRlZGlyKQorQ0ZMQUdTCQk/PSBAQ0ZMQUdTQAorTERMSUJTCQk/
PSBATElCU0AKK0xERkxBR1MJCT89IEBMREZMQUdTQCAtTCQobGliZGlyKQorCitERUJVR19DRkxB
R1MJPz0gLWcKK0RFQlVHX0NYWEZMQUdTCT89ICQoREVCVUdfQ0ZMQUdTKQorCitDRkxBR1MJCSs9
ICQoREVCVUdfQ0ZMQUdTKQorQ1hYRkxBR1MJKz0gJChERUJVR19DWFhGTEFHUykKKworIyBUaGVy
ZSBoYXZlIGJlZW4gc2V2ZXJhbCBidWdzIGluIHRoZSBwYXN0IHJlbGF0ZWQgdG8gLU8yKyB3aGVu
CisjIC1mbm8tc3RyaWN0LWFsaWFzaW5nIGlzIG5vdCBzcGVjaWZpZWQuCitPUFRfQ0ZMQUdTCT89
IC1PMiAtZm5vLXN0cmljdC1hbGlhc2luZworT1BUX0NYWEZMQUdTCT89ICQoT1BUX0NGTEFHUykK
KworQ0ZMQUdTCQkrPSAkKE9QVF9DRkxBR1MpCitDWFhGTEFHUwkrPSAkKE9QVF9DWFhGTEFHUykK
KworV0NGTEFHUwkJPz0gLVdhbGwKK1dDWFhGTEFHUwk/PSAkKFdDRkxBR1MpCisKK0NGTEFHUwkJ
Kz0gJChXQ0ZMQUdTKQorQ1hYRkxBR1MJKz0gJChXQ1hYRkxBR1MpCisKK0xERkxBR1MJCSs9ICQo
V0xERkxBR1MpCisKKyMgT25seSBjaGVjayBmb3IgbnVtYSB3aGVuIG5vdCBjcm9zcy1jb21waWxp
bmcuCitpZmVxICgkKHN0cmlwICQoQ1JPU1NfQ09NUElMRSkpLDEpCisjIERpc2FibGUgYWxsIHVu
ZGV0ZWN0YWJsZSBjcm9zcy1jb21waWxhdGlvbiByZXF1aXJlZCBpdGVtcy4KK0hBU19OVU1BCT89
IDAKK2Vsc2UKKyMgT25seSBjaGVjayBmb3IgbnVtYSB3aGVuIG5vdCBjcm9zcy1jb21waWxpbmcu
CitIQVNfTlVNQQk/PSAkKHNoZWxsIHNoICQodG9wX3NyY2RpcikvdG9vbHMvc2NyaXB0cy9udW1h
X3Rlc3Quc2ggMj4vZGV2L251bGwpCitlbmRpZgorCisjZXhwb3J0IEFSIENDIENGTEFHUyBDUFBG
TEFHUyBMRExJQlMgTERGTEFHUyBSQU5MSUIKK2V4cG9ydCBkYXRhcm9vdGRpciBpbmNsdWRlZGly
IGxpYmRpciBtYW5kaXIgcHJlZml4CkluZGV4OiBpbmNsdWRlL01ha2VmaWxlCj09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0K
UkNTIGZpbGU6IC9jdnNyb290L2x0cC9sdHAvaW5jbHVkZS9NYWtlZmlsZSx2CnJldHJpZXZpbmcg
cmV2aXNpb24gMS43CmRpZmYgLXUgLXIxLjcgTWFrZWZpbGUKLS0tIGluY2x1ZGUvTWFrZWZpbGUJ
MjMgSnVuIDIwMDkgMTQ6MTg6MTYgLTAwMDAJMS43CisrKyBpbmNsdWRlL01ha2VmaWxlCTEyIEp1
bCAyMDA5IDA1OjQ2OjI4IC0wMDAwCkBAIC0xLDI3ICsxLDQ2IEBACisjCisjICAgIGluY2x1ZGUg
TWFrZWZpbGUuCisjCisjICAgIENvcHlyaWdodCAoQykgMjAwOSwgQ2lzY28gU3lzdGVtcyBJbmMu
CisjCisjICAgIFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNvZnR3YXJlOyB5b3UgY2FuIHJlZGlzdHJp
YnV0ZSBpdCBhbmQvb3IgbW9kaWZ5CisjICAgIGl0IHVuZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05V
IEdlbmVyYWwgUHVibGljIExpY2Vuc2UgYXMgcHVibGlzaGVkIGJ5CisjICAgIHRoZSBGcmVlIFNv
ZnR3YXJlIEZvdW5kYXRpb247IGVpdGhlciB2ZXJzaW9uIDIgb2YgdGhlIExpY2Vuc2UsIG9yCisj
ICAgIChhdCB5b3VyIG9wdGlvbikgYW55IGxhdGVyIHZlcnNpb24uCisjCisjICAgIFRoaXMgcHJv
Z3JhbSBpcyBkaXN0cmlidXRlZCBpbiB0aGUgaG9wZSB0aGF0IGl0IHdpbGwgYmUgdXNlZnVsLAor
IyAgICBidXQgV0lUSE9VVCBBTlkgV0FSUkFOVFk7IHdpdGhvdXQgZXZlbiB0aGUgaW1wbGllZCB3
YXJyYW50eSBvZgorIyAgICBNRVJDSEFOVEFCSUxJVFkgb3IgRklUTkVTUyBGT1IgQSBQQVJUSUNV
TEFSIFBVUlBPU0UuICBTZWUgdGhlCisjICAgIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGZv
ciBtb3JlIGRldGFpbHMuCisjCisjICAgIFlvdSBzaG91bGQgaGF2ZSByZWNlaXZlZCBhIGNvcHkg
b2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGFsb25nCisjICAgIHdpdGggdGhpcyBw
cm9ncmFtOyBpZiBub3QsIHdyaXRlIHRvIHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb24sIElu
Yy4sCisjICAgIDUxIEZyYW5rbGluIFN0cmVldCwgRmlmdGggRmxvb3IsIEJvc3RvbiwgTUEgMDIx
MTAtMTMwMSBVU0EuCisjCisjIEdhcnJldHQgQ29vcGVyLCBKdWx5IDIwMDkKKyMKKwordG9wX3Ny
Y2RpcgkJPz0gLi4KKworaW5jbHVkZSAkKHRvcF9zcmNkaXIpL2luY2x1ZGUvbWsvbWFzdGVyX2lu
Y2x1ZGUubWsKKworQ0xFQU5fREVQUwkJOj0gYWMtY2xlYW4KKworSU5TVEFMTF9ESVIJCTo9ICQo
aW5jbHVkZWRpcikKIAorSU5TVEFMTF9NT0RFCQk6PSAwMDY0NAogCi1QUkVGSVg9L29wdC9sdHAK
LUhFQURFUlM9Y29tcGlsZXIuaCBkYXRhYXNjaWkuaCBkYXRhYmluLmggZmlsZV9sb2NrLmggZm9y
a2VyLmggb3Blbl9mbGFncy5oIFwKLQlwYXR0ZXJuLmggcmFuZG9tX3JhbmdlLmggcm1vYmouaCBz
ZWFyY2hfcGF0aC5oIHN0cmluZ190b190b2tlbnMuaCBcCi0Jc3RyX3RvX2J5dGVzLmggdGVzdC5o
IHRsaWJpby5oIHVzY3Rlc3QuaCB3cml0ZV9sb2cuaCBcCi0JbGludXhfc3lzY2FsbF9udW1iZXJz
LmggbGlidGVzdHN1aXRlLmggY29uZmlnLmgKLQotLlBIT05ZOiBhbGwgaW5zdGFsbAotYWxsOgot
Ci1pbnN0YWxsOiAkKEhFQURFUlMpCi0JQHNldCAtZTsgZm9yIGkgaW4gJChIRUFERVJTKTsgZG8g
XAotCQlpbnN0YWxsIC1EIC1tIDY0NCAkJGkgJChERVNURElSKS8kKFBSRUZJWCkvaW5jbHVkZS9s
dHAvJCRpOyBcCi0JZG9uZQorSU5TVEFMTF9UQVJHRVRTCQk6PSAkKHdpbGRjYXJkICQoc3JjZGly
KS8qLmgpCiAKLS5QSE9OWTogY2xlYW4gZGlzdGNsZWFuIG1haW50YWluZXItY2xlYW4KLWNsZWFu
OiBhYy1jbGVhbgorTUFLRV9UQVJHRVRTCQk6PQorCisuUEhPTlk6IGFjLWNsZWFuIGFjLWRpc3Rj
bGVhbiBhYy1tYWludGFpbmVyLWNsZWFuIGRpc3RjbGVhbiBtYWludGFpbmVyLWNsZWFuCiBkaXN0
Y2xlYW46IGNsZWFuIGFjLWRpc3RjbGVhbgogbWFpbnRhaW5lci1jbGVhbjogZGlzdGNsZWFuIGFj
LW1haW50YWluZXItY2xlYW4KLQotLlBIT05ZOiBhYy1jbGVhbiBhYy1kaXN0Y2xlYW4gYWMtbWFp
bnRhaW5lcmNsZWFuCiBhYy1jbGVhbjoKIGFjLWRpc3RjbGVhbjoKLQlybSAtZiBjb25maWcuaAor
CSQoUk0pIC1mIGNvbmZpZy5oCiBhYy1tYWludGFpbmVyLWNsZWFuOgotCXJtIC1mIGNvbmZpZy5o
LmluCisJJChSTSkgLWYgY29uZmlnLmguaW4KKworJChldmFsICQoZ2VuZXJpY19sZWFmX3Rhcmdl
dCkpCkluZGV4OiBsaWIvTWFrZWZpbGUKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQpSQ1MgZmlsZTogL2N2c3Jvb3QvbHRw
L2x0cC9saWIvTWFrZWZpbGUsdgpyZXRyaWV2aW5nIHJldmlzaW9uIDEuMTYKZGlmZiAtdSAtcjEu
MTYgTWFrZWZpbGUKLS0tIGxpYi9NYWtlZmlsZQkzIEFwciAyMDA5IDA2OjU4OjE4IC0wMDAwCTEu
MTYKKysrIGxpYi9NYWtlZmlsZQkxMiBKdWwgMjAwOSAwNTo0NjoyOCAtMDAwMApAQCAtMSwyNiAr
MSw0NCBAQAorIworIyAgICBsaWIgTWFrZWZpbGUuCisjCisjICAgIENvcHlyaWdodCAoQykgMjAw
OSwgQ2lzY28gU3lzdGVtcyBJbmMuCisjCisjICAgIFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNvZnR3
YXJlOyB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5CisjICAgIGl0IHVuZGVy
IHRoZSB0ZXJtcyBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgYXMgcHVibGlzaGVk
IGJ5CisjICAgIHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb247IGVpdGhlciB2ZXJzaW9uIDIg
b2YgdGhlIExpY2Vuc2UsIG9yCisjICAgIChhdCB5b3VyIG9wdGlvbikgYW55IGxhdGVyIHZlcnNp
b24uCisjCisjICAgIFRoaXMgcHJvZ3JhbSBpcyBkaXN0cmlidXRlZCBpbiB0aGUgaG9wZSB0aGF0
IGl0IHdpbGwgYmUgdXNlZnVsLAorIyAgICBidXQgV0lUSE9VVCBBTlkgV0FSUkFOVFk7IHdpdGhv
dXQgZXZlbiB0aGUgaW1wbGllZCB3YXJyYW50eSBvZgorIyAgICBNRVJDSEFOVEFCSUxJVFkgb3Ig
RklUTkVTUyBGT1IgQSBQQVJUSUNVTEFSIFBVUlBPU0UuICBTZWUgdGhlCisjICAgIEdOVSBHZW5l
cmFsIFB1YmxpYyBMaWNlbnNlIGZvciBtb3JlIGRldGFpbHMuCisjCisjICAgIFlvdSBzaG91bGQg
aGF2ZSByZWNlaXZlZCBhIGNvcHkgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGFs
b25nCisjICAgIHdpdGggdGhpcyBwcm9ncmFtOyBpZiBub3QsIHdyaXRlIHRvIHRoZSBGcmVlIFNv
ZnR3YXJlIEZvdW5kYXRpb24sIEluYy4sCisjICAgIDUxIEZyYW5rbGluIFN0cmVldCwgRmlmdGgg
Rmxvb3IsIEJvc3RvbiwgTUEgMDIxMTAtMTMwMSBVU0EuCisjCisjIEdhcnJldHQgQ29vcGVyLCBK
dWx5IDIwMDkKKyMKIAotUFJFRklYPS9vcHQvbHRwCit0b3Bfc3JjZGlyCQk/PSAuLgorCitpbmNs
dWRlICQodG9wX3NyY2RpcikvaW5jbHVkZS9tay9saWIubWsKIAotQ0ZMQUdTKz0gLVdhbGwKLUNQ
UEZMQUdTKz0gLUkuLi9pbmNsdWRlIAogaWZlcSAoJChzaGVsbCB1bmFtZSAtcyksSFAtVVgpCi1D
RkxBR1MrPS1BZSAtRF9MQVJHRUZJTEU2NF9TT1VSQ0UgK0RBMS4xCitDRkxBR1MJCQkrPS1BZSAt
RF9MQVJHRUZJTEU2NF9TT1VSQ0UgK0RBMS4xCiBlbmRpZgogaWZlcSAoJChVQ0xJTlVYKSwxKQot
Q0ZMQUdTKz0gLURfVVNDX0xJQl8gLURfX1VDTElCQ19fIC1EVUNMSU5VWAorQ0ZMQUdTCQkJKz0g
LURfVVNDX0xJQl8gLURfX1VDTElCQ19fIC1EVUNMSU5VWAogZW5kaWYKLUxERkxBR1MrPQotVEFS
R0VUPWxpYmx0cC5hCi1TUkNTPSQod2lsZGNhcmQgKi5jKQotT0JKUz0kKHBhdHN1YnN0ICUuYywl
Lm8sJChTUkNTKSkKLQotJChUQVJHRVQpOiAkKE9CSlMpCi0JJChBUikgLWNyICRAICReCi0KLWNs
ZWFuOgotCXJtIC1mICQoVEFSR0VUKSAkKE9CSlMpCi0KLWluc3RhbGw6ICQoVEFSR0VUKQotCWlu
c3RhbGwgLUQgLW0gNjQ0ICQoVEFSR0VUKSAkKERFU1RESVIpLyQoUFJFRklYKS9saWIkKExJQlNV
RkZJWCkvJChUQVJHRVQpCi0JaW5zdGFsbCAtRCAtbSA2NDQgbHRwLnBjICQoREVTVERJUikvJChQ
UkVGSVgpL3NoYXJlL3BrZ2NvbmZpZy9sdHAucGMKIAorTElCCQkJOj0gbGlibHRwLmEKKworcGNf
ZmlsZQkJCTo9ICQoREVTVERJUikvJChkYXRhcm9vdGRpcikvcGtnY29uZmlnL2x0cC5wYworCitJ
TlNUQUxMX1RBUkdFVFMJCTo9ICQocGNfZmlsZSkKKworJChwY19maWxlKToKKwl0ZXN0IC1kICIk
KEBEKSIgfHwgbWtkaXIgLXAgIiQoQEQpIgorCWluc3RhbGwgLW0gJChJTlNUQUxMX01PREUpICIk
KHNyY2RpcikvJChARikiICIkQCIKKworJChldmFsICQobGliX3RhcmdldCkpCkluZGV4OiBsaWIv
bHRwLnBjLmluCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT0KUkNTIGZpbGU6IGxpYi9sdHAucGMuaW4KZGlmZiAtTiBsaWIv
bHRwLnBjLmluCi0tLSAvZGV2L251bGwJMSBKYW4gMTk3MCAwMDowMDowMCAtMDAwMAorKysgbGli
L2x0cC5wYy5pbgkxMiBKdWwgMjAwOSAwNTo0NjoyOCAtMDAwMApAQCAtMCwwICsxLDExIEBACitw
cmVmaXg9QHByZWZpeEAKK2V4ZWNfcHJlZml4PUBleGVjX3ByZWZpeEAKK2luY2x1ZGVkaXI9QGlu
Y2x1ZGVkaXJACitsaWJkaXI9QGxpYmRpckAKKworTmFtZTogTFRQCitEZXNjcmlwdGlvbjogTGlu
dXggVGVzdCBQcm9qZWN0CitWZXJzaW9uOiAxLjAKK0xpYnM6IC1MJHtsaWJkaXJ9IC1sbHRwCitD
ZmxhZ3M6IC1JJHtpbmNsdWRlZGlyfQorTGlicy5wcml2YXRlOiAtTCR7bGliZGlyfSAtbGx0cCAK
SW5kZXg6IG00L0dOVW1ha2VmaWxlCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KUkNTIGZpbGU6IC9jdnNyb290L2x0cC9s
dHAvbTQvR05VbWFrZWZpbGUsdgpyZXRyaWV2aW5nIHJldmlzaW9uIDEuMQpkaWZmIC11IC1yMS4x
IEdOVW1ha2VmaWxlCi0tLSBtNC9HTlVtYWtlZmlsZQkxOCBKYW4gMjAwOSAyMjoyMjo0MCAtMDAw
MAkxLjEKKysrIG00L0dOVW1ha2VmaWxlCTEyIEp1bCAyMDA5IDA1OjQ2OjI4IC0wMDAwCkBAIC0x
LDEyICsxLDM3IEBACisjCisjICAgIG00IE1ha2VmaWxlLgorIworIyAgICBDb3B5cmlnaHQgKEMp
IDIwMDksIENpc2NvIFN5c3RlbXMgSW5jLgorIworIyAgICBUaGlzIHByb2dyYW0gaXMgZnJlZSBz
b2Z0d2FyZTsgeW91IGNhbiByZWRpc3RyaWJ1dGUgaXQgYW5kL29yIG1vZGlmeQorIyAgICBpdCB1
bmRlciB0aGUgdGVybXMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGFzIHB1Ymxp
c2hlZCBieQorIyAgICB0aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uOyBlaXRoZXIgdmVyc2lv
biAyIG9mIHRoZSBMaWNlbnNlLCBvcgorIyAgICAoYXQgeW91ciBvcHRpb24pIGFueSBsYXRlciB2
ZXJzaW9uLgorIworIyAgICBUaGlzIHByb2dyYW0gaXMgZGlzdHJpYnV0ZWQgaW4gdGhlIGhvcGUg
dGhhdCBpdCB3aWxsIGJlIHVzZWZ1bCwKKyMgICAgYnV0IFdJVEhPVVQgQU5ZIFdBUlJBTlRZOyB3
aXRob3V0IGV2ZW4gdGhlIGltcGxpZWQgd2FycmFudHkgb2YKKyMgICAgTUVSQ0hBTlRBQklMSVRZ
IG9yIEZJVE5FU1MgRk9SIEEgUEFSVElDVUxBUiBQVVJQT1NFLiAgU2VlIHRoZQorIyAgICBHTlUg
R2VuZXJhbCBQdWJsaWMgTGljZW5zZSBmb3IgbW9yZSBkZXRhaWxzLgorIworIyAgICBZb3Ugc2hv
dWxkIGhhdmUgcmVjZWl2ZWQgYSBjb3B5IG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5z
ZSBhbG9uZworIyAgICB3aXRoIHRoaXMgcHJvZ3JhbTsgaWYgbm90LCB3cml0ZSB0byB0aGUgRnJl
ZSBTb2Z0d2FyZSBGb3VuZGF0aW9uLCBJbmMuLAorIyAgICA1MSBGcmFua2xpbiBTdHJlZXQsIEZp
ZnRoIEZsb29yLCBCb3N0b24sIE1BIDAyMTEwLTEzMDEgVVNBLgorIworIyBHYXJyZXR0IENvb3Bl
ciwgSnVseSAyMDA5CisjCiAKK3NyY2RpcgkJCT89IC4uCiAKLVBSRUZJWD0vb3B0L2x0cAotTTRN
QUNST1M9JChub3RkaXIgJCh3aWxkY2FyZCAqLm00KSkKK2luY2x1ZGUgJChzcmNkaXIpL2luY2x1
ZGUvbWsvbWFzdGVyX2luY2x1ZGUubWsKIAotYWxsOgorTTRNQUNST1MJCTo9ICQobm90ZGlyICQo
d2lsZGNhcmQgKi5tNCkpCiAKLWluc3RhbGw6ICQoTTRNQUNST1MpCi0JZm9yIGkgaW4gJChNNE1B
Q1JPUyk7IGRvIFwKLQkJaW5zdGFsbCAtRCAtbSA2NDQgJCRpICQoREVTVERJUikvJChQUkVGSVgp
L3NoYXJlL2FjbG9jYWwvJCRpOyBcCi0JZG9uZQorSU5TVEFMTF9ESVIJCTo9ICQoZGF0YXJvb3Rk
aXIpL2FjbG9jYWwKIAorSU5TVEFMTF9NT0RFCQk6PSAwMDY0NAorCitJTlNUQUxMX1RBUkdFVFMJ
CTo9ICQoTTRfTUFDUk9TKQorCitNQUtFX1RBUkdFVFMJCTo9CisKKyQoZXZhbCAkKGdlbmVyaWNf
bGVhZl90YXJnZXQpKQpJbmRleDogcGFuL01ha2VmaWxlCj09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KUkNTIGZpbGU6IC9j
dnNyb290L2x0cC9sdHAvcGFuL01ha2VmaWxlLHYKcmV0cmlldmluZyByZXZpc2lvbiAxLjE5CmRp
ZmYgLXUgLXIxLjE5IE1ha2VmaWxlCi0tLSBwYW4vTWFrZWZpbGUJMTkgTWF5IDIwMDkgMDk6Mzk6
MTEgLTAwMDAJMS4xOQorKysgcGFuL01ha2VmaWxlCTEyIEp1bCAyMDA5IDA1OjQ2OjI4IC0wMDAw
CkBAIC0xLDI0ICsxLDM5IEBACisjCisjICAgIHBhbiBNYWtlZmlsZS4KKyMKKyMgICAgQ29weXJp
Z2h0IChDKSAyMDA5LCBDaXNjbyBTeXN0ZW1zIEluYy4KKyMKKyMgICAgVGhpcyBwcm9ncmFtIGlz
IGZyZWUgc29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vciBtb2RpZnkKKyMg
ICAgaXQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBh
cyBwdWJsaXNoZWQgYnkKKyMgICAgdGhlIEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbjsgZWl0aGVy
IHZlcnNpb24gMiBvZiB0aGUgTGljZW5zZSwgb3IKKyMgICAgKGF0IHlvdXIgb3B0aW9uKSBhbnkg
bGF0ZXIgdmVyc2lvbi4KKyMKKyMgICAgVGhpcyBwcm9ncmFtIGlzIGRpc3RyaWJ1dGVkIGluIHRo
ZSBob3BlIHRoYXQgaXQgd2lsbCBiZSB1c2VmdWwsCisjICAgIGJ1dCBXSVRIT1VUIEFOWSBXQVJS
QU5UWTsgd2l0aG91dCBldmVuIHRoZSBpbXBsaWVkIHdhcnJhbnR5IG9mCisjICAgIE1FUkNIQU5U
QUJJTElUWSBvciBGSVRORVNTIEZPUiBBIFBBUlRJQ1VMQVIgUFVSUE9TRS4gIFNlZSB0aGUKKyMg
ICAgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgZm9yIG1vcmUgZGV0YWlscy4KKyMKKyMgICAg
WW91IHNob3VsZCBoYXZlIHJlY2VpdmVkIGEgY29weSBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGlj
IExpY2Vuc2UgYWxvbmcKKyMgICAgd2l0aCB0aGlzIHByb2dyYW07IGlmIG5vdCwgd3JpdGUgdG8g
dGhlIEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbiwgSW5jLiwKKyMgICAgNTEgRnJhbmtsaW4gU3Ry
ZWV0LCBGaWZ0aCBGbG9vciwgQm9zdG9uLCBNQSAwMjExMC0xMzAxIFVTQS4KKyMKKyMgR2FycmV0
dCBDb29wZXIsIEp1bHkgMjAwOQorIworCit0b3Bfc3JjZGlyCQk/PSAuLgorCitpbmNsdWRlICQo
dG9wX3NyY2RpcikvaW5jbHVkZS9tay9tYXN0ZXJfaW5jbHVkZS5taworCitMRExJQlMJCQkrPSAt
bG0KK0xGTEFHUwkJCSs9IC1sIC13CitDRkxBR1MJCQkrPSAtdyAKIAotTE9BRExJQkVTICs9IC1s
bQotTEZMQUdTICs9IC1sIC13Ci1DRkxBR1MgKz0gLXcgCi1QUkVGSVggPSAvb3B0L2x0cAotCi1h
bGw6IGx0cC1wYW4gbHRwLWJ1bXAgbHRwLXNjYW5uZXIKLQotbHRwLXBhbjogbHRwLXBhbi5vIHpv
b2xpYi5vIHNwbGl0c3RyLm8KLQorTUFLRV9UQVJHRVRTCQk6PSBsdHAtYnVtcCBsdHAtcGFuIGx0
cC1zY2FubmVyCiAKIGx0cC1idW1wOiBsdHAtYnVtcC5vIHpvb2xpYi5vCiAKK2x0cC1wYW46IGx0
cC1wYW4ubyB6b29saWIubyBzcGxpdHN0ci5vCiAKIGx0cC1zY2FubmVyOiBzY2FuLm8gbHRwLXNj
YW5uZXIubyByZXBvcnRlci5vIHRhZ19yZXBvcnQubyBzeW1ib2wubyBzcGxpdHN0ci5vIGRlYnVn
Lm8KIAotCi1pbnN0YWxsOiBsdHAtcGFuIGx0cC1idW1wIGx0cC1zY2FubmVyCi0JaW5zdGFsbCAt
RCBsdHAtc2Nhbm5lciAkKERFU1RESVIpLyQoUFJFRklYKS9iaW4vbHRwLXNjYW5uZXIKLQlpbnN0
YWxsIC1EIGx0cC1wYW4gJChERVNURElSKS8kKFBSRUZJWCkvYmluL2x0cC1wYW4KLQlpbnN0YWxs
IC1EIGx0cC1idW1wICQoREVTVERJUikvJChQUkVGSVgpL2Jpbi9sdHAtYnVtcAotCi1jbGVhbjoK
LQlybSAtZiAqLm8gbHRwLXBhbiBsdHAtYnVtcCBsdHAtc2Nhbm5lcgorJChldmFsICQoZ2VuZXJp
Y19sZWFmX3RhcmdldCkpCg==
--000e0cd32f1e35e775046e7bc635
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have
the opportunity to enter the BlackBerry Developer Challenge. See full prize  
details at: http://p.sf.net/sfu/Challenge
--000e0cd32f1e35e775046e7bc635
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--000e0cd32f1e35e775046e7bc635--

