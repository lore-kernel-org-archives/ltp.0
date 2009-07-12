Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MPrp8-0002bK-GA
	for ltp-list@lists.sourceforge.net; Sun, 12 Jul 2009 05:42:06 +0000
Received: from wf-out-1314.google.com ([209.85.200.174])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MPrp5-00015f-U4
	for ltp-list@lists.sourceforge.net; Sun, 12 Jul 2009 05:42:06 +0000
Received: by wf-out-1314.google.com with SMTP id 26so534485wfd.4
	for <ltp-list@lists.sourceforge.net>;
	Sat, 11 Jul 2009 22:42:03 -0700 (PDT)
MIME-Version: 1.0
Date: Sat, 11 Jul 2009 22:42:03 -0700
Message-ID: <364299f40907112242j13b7349fued53c53f3f8defee@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Content-Type: multipart/mixed; boundary=000e0cd32bba42aaf6046e7baae4
Subject: [LTP] [PATCH 3/4] Make system enhancements, Draft 2
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
To: LTP list <ltp-list@lists.sourceforge.net>

--000e0cd32bba42aaf6046e7baae4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

A continuation of `[PATCH 2/3] Make system enhancements, Draft 1'.

Summary:
1. Addresses issues brought up by Mike Frysinger.
2. Fixes several bugs found through continued testing.
3. Adds lib.mk, testcases.mk to create more structure in Makefiles,
and prevent ad-hoc structure with libraries and testcases/ directory
binaries to reduce code duplication.

Signed-off-by: Garrett Cooper <yanegomi@gmail.com>

Index: README.mk-devel
===================================================================
RCS file: README.mk-devel
diff -N README.mk-devel
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ README.mk-devel	12 Jul 2009 05:38:40 -0000
@@ -0,0 +1,159 @@
+==============================
+Introduction
+==============================
+
+The following document briefly describes the steps and methodologies used for
+the new and improved Makefile system.
+
+==============================
+The Problem
+==============================
+
+The problem with the old Makefile system is that it was very difficult to
+maintain and it lacked any sense of formal structure, thus developing for LTP
+and including new targets was very more difficult than it should have been
+(maintenance). Furthermore, cross-compilation was impossible due to the fact
+that the Makefiles didn't support a prefixing system, and the appropriate
+implicit / static rules hadn't been configured to compile into multiple object
+directories (easy of use / functionality). Finally, there wasn't a means to
+setup dependencies between components, such that if a component required
+libltp.a in order to compile, it would go off and compile libltp.a first
+(easy of use).
+
+These items needed to be fixed to reduce maintenance nightmares for the
+development community contributing to LTP.
+
+==============================
+Design
+==============================
+
+The system was designed such that including a single GNU Makefile compatible
+set in each new directory component is all that's essentially required to
+build the system. Here's an example of how one would accomplish that:
+
+.../foo/Makefile:
+#
+# Copyright disclaimer goes here -- please use GPLv2.
+#
+
+srcdir			?= ../
+
+include $(srcdir)/include/mk/master_include.mk
+
+$(eval $(generic_dir_target))
+
+.../foo/bar/Makefile:
+#
+# Copyright disclaimer goes here -- please use GPLv2.
+#
+
+srcdir			?= ../
+
+include $(srcdir)/include/mk/master_include.mk
+
+$(eval $(generic_leaf_target))
+
+==============================
+Make Rules and Make Variables
+==============================
+
+When using make rules, avoid writing adhoc rules like:
+
+[prog]: [dependencies]
+	cc -I../../include $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $(LDLIBS) \
+	    -o [prog] [dependencies]
+
+etc. This makes cross-compilation and determinism difficult, if not impossible.
+Besides, implicit rules are your friends and as long as you use `MAKEOPTS=;' in
+the top-level caller (or do $(subst r,$(MAKEOPTS)) to remove -r), the compile
+will complete successfully, assuming all other prerequisites have been
+fulfilled (libraries, headers, etc).
+
+$(AR)			: The library archiver.
+
+$(CC)			: The system C compiler.
+
+$(CXX)			: The system C++ compiler.
+
+$(CFLAGS)		: Compiler flags.
+
+$(CPPFLAGS)		: Preprocessor flags, e.g. -I arguments.
+
+$(DEBUG_CFLAGS)		: Debug flags to pass into the C compiler, -g, etc.
+
+$(DEBUG_CXXFLAGS)	: Debug flags to pass into the C++ compiler.
+
+$(LD)			: The library linker.
+
+$(LDFLAGS)		: What to pass in to the linker, including -L arguments
+			  and other ld arguments, apart from -l library
+			  includes (see $(LDLIBS)).
+
+$(LDLIBS)		: Libraries to pass into the linker (e.g. -lltp, etc).
+
+$(OPT_CFLAGS)		: Optimization flags to pass into the C compiler, -O2,
+			  etc. IF YOU SPECIFY -O2 OR HIGHER, ENSURE THAT YOU
+			  ALSO SPECIFY -fno-strict-aliasing, BECAUSE OF PAST
+			  OPTIMIZATION GCC BUGS!!!
+
+$(OPT_CXXFLAGS)		: Optimization flags to pass into the C++ compiler.
+
+$(RANLIB)		: What to run after archiving a library.
+
+$(WCFLAGS)		: Warning flags to pass into the C compiler, e.g.
+			  -Werror, -Wall, etc.
+
+$(WCXXFLAGS)		: Same as $(WCFLAGS), but for the C++ compiler.
+
+==============================
+Make System Variables
+==============================
+
+A series of variables are used within the make system that direct what actions
+need to be taken. Rather than me listing the variables here, please instead
+refer to the comments contained in `.../include/mk/master_rules.mk'.
+
+==============================
+Guidelines and Recommendations
+==============================
+
+Of course, the GNU Make manual is key to understanding the Make system, but
+here are the following sections and chapters I suggest reviewing:
+
+- implicit rules:
http://www.gnu.org/software/make/manual/make.html#Implicit-Rules
+- variables and expansion:
http://www.gnu.org/software/make/manual/make.html#Using-Variables
+- origin use: http://www.gnu.org/software/make/manual/make.html#Origin-Function
+- vpath use: http://www.gnu.org/software/make/manual/make.html#Directory-Search
+
+==============================
+Before Committing
+==============================
+
+One should rebuild from scratch before committing. Here's an example of how to
+do that:
+#!/bin/sh
+
+TOOLS_PATH=/path/to/tools
+
+# Replace [options] with any make specific options and variables, for each
+# step, example: -j 4, DESTDIR=/path/for/install, etc.
+make ac-clean ac-maintainer-clean distclean maintainer-clean [options]
+make \
+  ACLOCAL=$TOOLS_PATH/bin/aclocal \
+  AUTOCONF=$TOOLS_PATH/bin/autoconf \
+  AUTOHEADER=$TOOLS_PATH/bin/autoheader \
+  AUTOMAKE=$TOOLS_PATH/bin/automake \
+  autotools
+./configure [options]
+make all [options]
+make install [options]
+
+==============================
+Other Errata
+==============================
+
+- This system (in its current form) supports cross-compilation out of a single
+directory. Object directory support will be completed soon to properly enable
+cross-compilation. This is required to avoid sporadic Make-related errors.
+
+# vim:
Index: include/mk/master_include.mk
===================================================================
RCS file: include/mk/master_include.mk
diff -N include/mk/master_include.mk
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ include/mk/master_include.mk	12 Jul 2009 05:38:40 -0000
@@ -0,0 +1,25 @@
+#
+#    Master include Makefile.
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
+# Only include config.mk for non-clean based targets.
+-include $(top_srcdir)/include/mk/config.mk
+include $(top_srcdir)/include/mk/master_rules.mk
Index: include/mk/master_rules.mk
===================================================================
RCS file: include/mk/master_rules.mk
diff -N include/mk/master_rules.mk
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ include/mk/master_rules.mk	12 Jul 2009 05:38:40 -0000
@@ -0,0 +1,304 @@
+#
+#    Master rules Makefile.
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
+# Get the absolute path for the source directory.
+ifeq ($(origin top_srcdir),undefined)
+$(error top_srcdir is not defined)
+endif
+
+# Where's the root source directory?
+top_srcdir			:= $(abspath $(top_srcdir))
+# Where's the source located at?
+srcdir				?= .
+# Where's the root object directory?
+builddir			?= $(srcdir)
+# Where are we currently located in the object and source tree?
+relpath				:= $(subst $(abs_builddir),,$(CURDIR))
+# Where are we going to install the files? Most of this junk ends up in
+# testcases/bin, so let's dump it there :)...
+INSTALL_DIR			?= testcases/bin
+
+abs_builddir			:= $(abspath $(builddir))
+abs_srcdir			:= $(abspath $(srcdir))
+
+# We can piece together where we're located in the source and object trees with
+# just these two vars and $(CURDIR).
+export top_srcdir builddir
+
+define generate_vpath_rule
+vpath %.$(1)	$(if $(2),$(2),$(srcdir))
+endef
+
+define generate_install_rule
+$$(warning "gir: $(1) => $(2)")
+
+$(1):
+	install -m $$(INSTALL_MODE) "$(2)/$$(@F)" "$$@"
+endef
+
+# Default source search path. Modify as necessary, but I would call that
+# poor software design if you need more than one search directory, and
+# would suggest creating a general purpose static library to that end.
+$(eval $(call generate_vpath_rule,c))
+
+#
+# get_make_dirs
+#
+# Sets the make directories in $(SUBDIRS), and then subsequently filters out
+# the subdirectories based on $(FILTER_OUT_DIRS).
+#
+define get_make_dirs
+
+SUBDIRS				?= $$(patsubst %/Makefile,%,$$(wildcard */Makefile))
+
+ifneq ($$(strip $$(SUBDIRS)),)		# We have directories to parse.
+ifneq ($$(strip $$(FILTER_OUT_DIRS)),)	# We have directories to filter-out.
+SUBDIRS				:= $$(filter-out $$(FILTER_OUT_DIRS),$$(SUBDIRS))
+endif
+endif
+
+endef
+
+define generic_target_env_setup
+
+ifeq ($$(origin MAKE_TARGETS),undefined)
+MAKE_TARGETS			:= $$(notdir $$(patsubst %.c,%,$$(wildcard $$(srcdir)/*.c)))
+endif
+
+# Don't append $(MAKE_TARGETS) unless it is non-NUL length.
+ifneq ($$(strip $$(MAKE_TARGETS)),)
+
+CLEAN_TARGETS			+= $$(MAKE_TARGETS)
+INSTALL_TARGETS			+= $$(MAKE_TARGETS)
+
+endif
+
+CLEAN_TARGETS			+= $$(wildcard *.o)
+
+# The large majority of the files that we install are going to be apps and
+# scripts, so let's chmod them like that.
+INSTALL_MODE			?= 00775
+
+ifneq ($(filter-out %install,$(MAKECMDGOALS)),)	# Not an install
target -- skip.
+ifeq ($$(origin INSTALL_DIR),undefined)	# Not set by the user -- most like a
+					# programming error now in this .mk
+					# file.
+$$(error INSTALL_DIR is not set (undefined))
+else
+ifeq ($$(strip $$(INSTALL_DIR)),)	# Set to a NUL-length string (dev
+					# error in a leaf Makefile, or
+					# someone's toying with the
+					# environment).
+$$(error INSTALL_DIR is not set to a non-NUL string)
+ 					# else $(INSTALL_DIR) is set to a
+ 					# non-NUL string.
+
+endif					# END: INSTALL_DIR NUL-length string.
+endif					# END: undefined
+endif					# END: Not install
+
+# An absolute path; don't append $(DESTDIR)/$(prefix) to the var.
+ifeq ($$(patsubst /%,,$$(INSTALL_DIR)),)
+INSTALL_PATH			:= $$(INSTALL_DIR)
+# Otherwise, let's assume that it's not relative to $(prefix)
+else
+INSTALL_PATH			:= $$(DESTDIR)/$$(prefix)/$$(INSTALL_DIR)
+endif
+
+INSTALL_FILES			:= $$(addprefix $$(INSTALL_PATH)/,$$(notdir
$$(INSTALL_TARGETS)))
+
+CLEAN_TARGETS			+= $$(INSTALL_FILES)
+
+$$(INSTALL_PATH):
+	mkdir -p $$@
+
+$$(INSTALL_FILES): %: pre-install $$(abs_builddir)/$$(@F) $$(INSTALL_DEPS)
+	install -m $$(INSTALL_MODE) $$(abs_builddir)/$$(@F) $$@
+
+endef
+
+#
+# generic_leaf_target
+#
+# Generate a set of basic targets (all, clean, install) for a leaf directory
+# (no subdirectories).
+#
+# In order to properly emulate pre- and post- behavior, a pre-install and
+# _install target are generated as well. The flow for install is as follows:
+#
+# pre-install -> $(INSTALL_FILES) -> install
+#
+# Helpful variables are:
+#
+# $(MAKE_DEPS)			: What to execute before all.
+# $(MAKE_TARGETS)		: What to execute as direct dependencies of
+# 				  all.
+# 				  1. Defaults to the basename of the targets
+# 				     produced by the %.c -> % implicit pattern
+# 				     rules, e.g. the MAKE_TARGET in a directory
+# 				     like the following:
+#
+#				  $$ ls /bar
+# 				  foo.c
+#
+#				     Would be `foo'. Similarly, the following
+#				     dir structure:
+#
+#				  $$ ls /bar
+# 				  foo.c zanzibar.c
+#
+#				     Would be `foo zanzibar'.
+#
+#				  2. If you define MAKE_TARGETS as an empty
+#				     string, this will override the defaults.
+#				     I did this to avoid providing too much
+#				     rope to hang one's self in the event of
+#				     unwanted behavior.
+#
+# $(CLEAN_TARGETS)		: What targets should be cleaned (must be
+#				  real files). This will automatically append
+#				  adds the .o suffix to all files referenced
+#				  by $(MAKE_TARGETS)) to CLEAN_TARGETS, if
+#				  MAKE_TARGETS wasn't defined (see
+#				  $(MAKE_TARGETS)).
+# $(PREINSTALL_DEPS)		: What to run as direct dependencies of
+# 				  pre-install.
+# $(INSTALL_DEPS)		: What to run as direct dependencies of
+# 				  the _install target. These must be real
+# 				  files.
+# $(POSTINSTALL_DEPS)		: What to install direct dependencies of
+# 				  the install target.
+# $(INSTALL_MODE)		: What mode should we using when calling
+# 				  install(1)?
+#
+# If you choose to cherrypick the logic contained here, by changing around the
+# dependencies for $(INSTALL_DEPS) and $(POSTINSTALL_DEPS), then you must also
+# emulate the $(INSTALL_DEPS): pre-install and install: $(POSTINSTALL_DEPS)
+# dependencies, if you _use_ them.
+#
+# Also, if you wish to change the installation directory, from the set default
+# (testcases/bin) you must do something like either one of the following items:
+#
+# Method A:
+#
+# INSTALL_DIR			:= /path/to/installdir/from/$(DESTDIR)/$(prefix)
+#
+# e.g. if I wanted to install my binaries in testcases/bin, I would do:
+#
+# INSTALL_DIR			:= testcases/bin
+#
+# in my calling Makefile.
+#
+# Or Method B:
+#
+# INSTALL_DIR			:= /path/to/installdir/from/$(DESTDIR)
+#
+# e.g. if I wanted to install my binaries in $(libdir) (which may not exist
+# outside of $(prefix) right now, but could in the future), I could do the
+# following:
+#
+# INSTALL_DIR			:= $(libdir)
+#
+define generic_leaf_target
+
+$$(eval $$(generic_target_env_setup))
+
+.PHONY: all clean _install install pre-install
+
+all: | $$(MAKE_DEPS) $$(MAKE_TARGETS)
+
+clean: $$(CLEAN_DEPS)
+	-$(RM) -f $$(CLEAN_TARGETS)
+
+pre-install: | $$(INSTALL_PATH) $$(PREINSTALL_DEPS)
+
+install: | $$(INSTALL_FILES) $$(POSTINSTALL_DEPS)
+
+endef
+
+#
+# generic_trunk_target
+#
+# Generate a set of recursive targets to apply over a trunk directory (has
+# directories) -- optionally with a set of trunk-based files.
+#
+# All variables in this canned define are essentially the same as
+# generic_leaf_target, with the exception that the install flow for local
+# targets is:
+#
+# pre-install -> $(INSTALL_FILES) -> trunk-install
+#
+# All recursive targets are traverse SUBDIRS as defined by the user, or if
+# undefined, defaults to any subdirectories where Makefile's are contained
+# within.
+#
+# generic_trunk_target specific variables are:
+#
+# RECURSIVE_TARGETS		: a list of targets to apply over an entire
+# 				  directory tree. This defaults to
+# 				  `all clean install'.
+#
+# See generic_leaf_target, generic_target_env_setup, and get_make_dirs for
+# more details and design notes.
+#
+define generic_trunk_target
+
+#
+# Doesn't need forced secondary expansion because $(CURDIR) isn't going to
+# change (or at least it bloody well shouldn't ;)...).
+#
+# Don't do this in generic_target_env_setup, because we only need to do this
+# by default for generic_dir_target.
+#
+$(eval $(get_make_dirs))
+
+RECURSIVE_TARGETS		?= all clean install
+
+.PHONY: $$(RECURSIVE_TARGETS) $$(addprefix
trunk-,$$(RECURSIVE_TARGETS)) pre-install
+
+$$(eval $$(generic_target_env_setup))
+
+trunk-all: | $$(MAKE_DEPS) $$(MAKE_TARGETS)
+
+trunk-clean: $$(CLEAN_DEPS)
+	-$(RM) -f $$(CLEAN_TARGETS)
+
+pre-install: | $$(INSTALL_PATH) $$(PREINSTALL_DEPS)
+
+trunk-install: | $$(INSTALL_FILES) $$(POSTINSTALL_DEPS)
+
+# Avoid creating duplicate .PHONY references to all, clean, and install. IIRC,
+# I've seen some indeterministic behavior when one does this in the past with
+# GNU Make...
+.PHONY: $$(filter-out $$(RECURSIVE_TARGETS),all clean install)
+all: trunk-all
+
+clean: trunk-clean
+
+install: trunk-install
+
+$$(RECURSIVE_TARGETS): %:
+	@set -e; for dir in $$(SUBDIRS); do \
+	    $(MAKE) -C $$$$dir $$@; \
+	done
+
+endef
Index: include/mk/lib.mk
===================================================================
RCS file: include/mk/lib.mk
diff -N include/mk/lib.mk
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ include/mk/lib.mk	12 Jul 2009 05:38:40 -0000
@@ -0,0 +1,71 @@
+#
+#    library include Makefile.
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
+include $(top_srcdir)/include/mk/master_include.mk
+
+# Change the default goal when nothing is specified to install because we want
+# to ensure that the libraries get installed ASAP so they can be properly
+# linked in with all required apps.
+CPPFLAGS			+= -I$(includedir)
+
+# An extension of generic_leaf_target, strictly for libraries.
+define lib_target
+
+.PHONY: install_headers
+
+ifeq ($$(origin LIB),undefined)
+$$(error You must define LIB when including this Makefile)
+endif
+
+install_headers: $$(addprefix $(includedir)/,$$(notdir $$(HEADER_FILES)))
+
+INSTALL_DEPS			:= install_headers
+
+INSTALL_DIR			:= $(libdir)
+
+INSTALL_MODE			?= 00664
+
+LIB				:= $$(addprefix $$(builddir)/,$$(LIB))
+
+MAKE_TARGETS			:= $$(LIB)
+
+ifeq ($$(origin LIBSRCS),undefined)
+LIBSRCS				?= $$(wildcard $(srcdir)/*.c)
+endif
+
+LIBSRCS				:= $$(notdir $$(LIBSRCS))
+
+LIBOBJS				:= $$(addprefix $$(builddir)/,$$(patsubst %.c,%.o,$$(LIBSRCS)))
+
+$$(warning $$(LIBSRCS))
+
+$$(LIB): $$(LIBOBJS)
+	set -e; if [ -z "$$(strip $$^)" ] ; then \
+	    echo "Cowardly refusing to create empty archive."; \
+	    exit 1; \
+	fi
+	$$(AR) -rc $$@ $$^
+	$$(RANLIB) $$@
+
+$$(eval $$(generic_leaf_target))
+
+endef
Index: include/mk/testcases.mk
===================================================================
RCS file: include/mk/testcases.mk
diff -N include/mk/testcases.mk
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ include/mk/testcases.mk	12 Jul 2009 05:38:40 -0000
@@ -0,0 +1,25 @@
+#
+#    testcases include Makefile.
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
+include $(top_srcdir)/include/mk/master_include.mk
+
+LDLIBS			+= -lltp

--000e0cd32bba42aaf6046e7baae4
Content-Type: application/octet-stream; name="Make-system-enhancements.2.diff"
Content-Disposition: attachment; filename="Make-system-enhancements.2.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fx1c6ark0

SW5kZXg6IFJFQURNRS5tay1kZXZlbAo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09ClJDUyBmaWxlOiBSRUFETUUubWstZGV2
ZWwKZGlmZiAtTiBSRUFETUUubWstZGV2ZWwKLS0tIC9kZXYvbnVsbAkxIEphbiAxOTcwIDAwOjAw
OjAwIC0wMDAwCisrKyBSRUFETUUubWstZGV2ZWwJMTIgSnVsIDIwMDkgMDU6Mzg6NDAgLTAwMDAK
QEAgLTAsMCArMSwxNTkgQEAKKz09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQorSW50cm9k
dWN0aW9uCis9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KKworVGhlIGZvbGxvd2luZyBk
b2N1bWVudCBicmllZmx5IGRlc2NyaWJlcyB0aGUgc3RlcHMgYW5kIG1ldGhvZG9sb2dpZXMgdXNl
ZCBmb3IKK3RoZSBuZXcgYW5kIGltcHJvdmVkIE1ha2VmaWxlIHN5c3RlbS4KKworPT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09CitUaGUgUHJvYmxlbQorPT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09CisKK1RoZSBwcm9ibGVtIHdpdGggdGhlIG9sZCBNYWtlZmlsZSBzeXN0ZW0gaXMg
dGhhdCBpdCB3YXMgdmVyeSBkaWZmaWN1bHQgdG8KK21haW50YWluIGFuZCBpdCBsYWNrZWQgYW55
IHNlbnNlIG9mIGZvcm1hbCBzdHJ1Y3R1cmUsIHRodXMgZGV2ZWxvcGluZyBmb3IgTFRQCithbmQg
aW5jbHVkaW5nIG5ldyB0YXJnZXRzIHdhcyB2ZXJ5IG1vcmUgZGlmZmljdWx0IHRoYW4gaXQgc2hv
dWxkIGhhdmUgYmVlbgorKG1haW50ZW5hbmNlKS4gRnVydGhlcm1vcmUsIGNyb3NzLWNvbXBpbGF0
aW9uIHdhcyBpbXBvc3NpYmxlIGR1ZSB0byB0aGUgZmFjdAordGhhdCB0aGUgTWFrZWZpbGVzIGRp
ZG4ndCBzdXBwb3J0IGEgcHJlZml4aW5nIHN5c3RlbSwgYW5kIHRoZSBhcHByb3ByaWF0ZQoraW1w
bGljaXQgLyBzdGF0aWMgcnVsZXMgaGFkbid0IGJlZW4gY29uZmlndXJlZCB0byBjb21waWxlIGlu
dG8gbXVsdGlwbGUgb2JqZWN0CitkaXJlY3RvcmllcyAoZWFzeSBvZiB1c2UgLyBmdW5jdGlvbmFs
aXR5KS4gRmluYWxseSwgdGhlcmUgd2Fzbid0IGEgbWVhbnMgdG8KK3NldHVwIGRlcGVuZGVuY2ll
cyBiZXR3ZWVuIGNvbXBvbmVudHMsIHN1Y2ggdGhhdCBpZiBhIGNvbXBvbmVudCByZXF1aXJlZAor
bGlibHRwLmEgaW4gb3JkZXIgdG8gY29tcGlsZSwgaXQgd291bGQgZ28gb2ZmIGFuZCBjb21waWxl
IGxpYmx0cC5hIGZpcnN0CisoZWFzeSBvZiB1c2UpLgorCitUaGVzZSBpdGVtcyBuZWVkZWQgdG8g
YmUgZml4ZWQgdG8gcmVkdWNlIG1haW50ZW5hbmNlIG5pZ2h0bWFyZXMgZm9yIHRoZQorZGV2ZWxv
cG1lbnQgY29tbXVuaXR5IGNvbnRyaWJ1dGluZyB0byBMVFAuCisKKz09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PQorRGVzaWduCis9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KKwor
VGhlIHN5c3RlbSB3YXMgZGVzaWduZWQgc3VjaCB0aGF0IGluY2x1ZGluZyBhIHNpbmdsZSBHTlUg
TWFrZWZpbGUgY29tcGF0aWJsZQorc2V0IGluIGVhY2ggbmV3IGRpcmVjdG9yeSBjb21wb25lbnQg
aXMgYWxsIHRoYXQncyBlc3NlbnRpYWxseSByZXF1aXJlZCB0bworYnVpbGQgdGhlIHN5c3RlbS4g
SGVyZSdzIGFuIGV4YW1wbGUgb2YgaG93IG9uZSB3b3VsZCBhY2NvbXBsaXNoIHRoYXQ6CisKKy4u
Li9mb28vTWFrZWZpbGU6CisjCisjIENvcHlyaWdodCBkaXNjbGFpbWVyIGdvZXMgaGVyZSAtLSBw
bGVhc2UgdXNlIEdQTHYyLgorIworCitzcmNkaXIJCQk/PSAuLi8KKworaW5jbHVkZSAkKHNyY2Rp
cikvaW5jbHVkZS9tay9tYXN0ZXJfaW5jbHVkZS5taworCiskKGV2YWwgJChnZW5lcmljX2Rpcl90
YXJnZXQpKQorCisuLi4vZm9vL2Jhci9NYWtlZmlsZToKKyMKKyMgQ29weXJpZ2h0IGRpc2NsYWlt
ZXIgZ29lcyBoZXJlIC0tIHBsZWFzZSB1c2UgR1BMdjIuCisjCisKK3NyY2RpcgkJCT89IC4uLwor
CitpbmNsdWRlICQoc3JjZGlyKS9pbmNsdWRlL21rL21hc3Rlcl9pbmNsdWRlLm1rCisKKyQoZXZh
bCAkKGdlbmVyaWNfbGVhZl90YXJnZXQpKQorCis9PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT0KK01ha2UgUnVsZXMgYW5kIE1ha2UgVmFyaWFibGVzCis9PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT0KKworV2hlbiB1c2luZyBtYWtlIHJ1bGVzLCBhdm9pZCB3cml0aW5nIGFkaG9jIHJ1
bGVzIGxpa2U6CisKK1twcm9nXTogW2RlcGVuZGVuY2llc10KKwljYyAtSS4uLy4uL2luY2x1ZGUg
JChDRkxBR1MpICQoQ1BQRkxBR1MpICQoTERGTEFHUykgJChMRExJQlMpIFwKKwkgICAgLW8gW3By
b2ddIFtkZXBlbmRlbmNpZXNdCisKK2V0Yy4gVGhpcyBtYWtlcyBjcm9zcy1jb21waWxhdGlvbiBh
bmQgZGV0ZXJtaW5pc20gZGlmZmljdWx0LCBpZiBub3QgaW1wb3NzaWJsZS4KK0Jlc2lkZXMsIGlt
cGxpY2l0IHJ1bGVzIGFyZSB5b3VyIGZyaWVuZHMgYW5kIGFzIGxvbmcgYXMgeW91IHVzZSBgTUFL
RU9QVFM9OycgaW4KK3RoZSB0b3AtbGV2ZWwgY2FsbGVyIChvciBkbyAkKHN1YnN0IHIsJChNQUtF
T1BUUykpIHRvIHJlbW92ZSAtciksIHRoZSBjb21waWxlCit3aWxsIGNvbXBsZXRlIHN1Y2Nlc3Nm
dWxseSwgYXNzdW1pbmcgYWxsIG90aGVyIHByZXJlcXVpc2l0ZXMgaGF2ZSBiZWVuCitmdWxmaWxs
ZWQgKGxpYnJhcmllcywgaGVhZGVycywgZXRjKS4KKworJChBUikJCQk6IFRoZSBsaWJyYXJ5IGFy
Y2hpdmVyLgorCiskKENDKQkJCTogVGhlIHN5c3RlbSBDIGNvbXBpbGVyLgorCiskKENYWCkJCQk6
IFRoZSBzeXN0ZW0gQysrIGNvbXBpbGVyLgorCiskKENGTEFHUykJCTogQ29tcGlsZXIgZmxhZ3Mu
IAorCiskKENQUEZMQUdTKQkJOiBQcmVwcm9jZXNzb3IgZmxhZ3MsIGUuZy4gLUkgYXJndW1lbnRz
LgorCiskKERFQlVHX0NGTEFHUykJCTogRGVidWcgZmxhZ3MgdG8gcGFzcyBpbnRvIHRoZSBDIGNv
bXBpbGVyLCAtZywgZXRjLgorCiskKERFQlVHX0NYWEZMQUdTKQk6IERlYnVnIGZsYWdzIHRvIHBh
c3MgaW50byB0aGUgQysrIGNvbXBpbGVyLgorCiskKExEKQkJCTogVGhlIGxpYnJhcnkgbGlua2Vy
LgorCiskKExERkxBR1MpCQk6IFdoYXQgdG8gcGFzcyBpbiB0byB0aGUgbGlua2VyLCBpbmNsdWRp
bmcgLUwgYXJndW1lbnRzCisJCQkgIGFuZCBvdGhlciBsZCBhcmd1bWVudHMsIGFwYXJ0IGZyb20g
LWwgbGlicmFyeQorCQkJICBpbmNsdWRlcyAoc2VlICQoTERMSUJTKSkuCisKKyQoTERMSUJTKQkJ
OiBMaWJyYXJpZXMgdG8gcGFzcyBpbnRvIHRoZSBsaW5rZXIgKGUuZy4gLWxsdHAsIGV0YykuCisK
KyQoT1BUX0NGTEFHUykJCTogT3B0aW1pemF0aW9uIGZsYWdzIHRvIHBhc3MgaW50byB0aGUgQyBj
b21waWxlciwgLU8yLAorCQkJICBldGMuIElGIFlPVSBTUEVDSUZZIC1PMiBPUiBISUdIRVIsIEVO
U1VSRSBUSEFUIFlPVQorCQkJICBBTFNPIFNQRUNJRlkgLWZuby1zdHJpY3QtYWxpYXNpbmcsIEJF
Q0FVU0UgT0YgUEFTVAorCQkJICBPUFRJTUlaQVRJT04gR0NDIEJVR1MhISEKKworJChPUFRfQ1hY
RkxBR1MpCQk6IE9wdGltaXphdGlvbiBmbGFncyB0byBwYXNzIGludG8gdGhlIEMrKyBjb21waWxl
ci4KKworJChSQU5MSUIpCQk6IFdoYXQgdG8gcnVuIGFmdGVyIGFyY2hpdmluZyBhIGxpYnJhcnku
CisKKyQoV0NGTEFHUykJCTogV2FybmluZyBmbGFncyB0byBwYXNzIGludG8gdGhlIEMgY29tcGls
ZXIsIGUuZy4KKwkJCSAgLVdlcnJvciwgLVdhbGwsIGV0Yy4KKworJChXQ1hYRkxBR1MpCQk6IFNh
bWUgYXMgJChXQ0ZMQUdTKSwgYnV0IGZvciB0aGUgQysrIGNvbXBpbGVyLgorCis9PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT0KK01ha2UgU3lzdGVtIFZhcmlhYmxlcworPT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09CisKK0Egc2VyaWVzIG9mIHZhcmlhYmxlcyBhcmUgdXNlZCB3aXRo
aW4gdGhlIG1ha2Ugc3lzdGVtIHRoYXQgZGlyZWN0IHdoYXQgYWN0aW9ucworbmVlZCB0byBiZSB0
YWtlbi4gUmF0aGVyIHRoYW4gbWUgbGlzdGluZyB0aGUgdmFyaWFibGVzIGhlcmUsIHBsZWFzZSBp
bnN0ZWFkCityZWZlciB0byB0aGUgY29tbWVudHMgY29udGFpbmVkIGluIGAuLi4vaW5jbHVkZS9t
ay9tYXN0ZXJfcnVsZXMubWsnLgorCis9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KK0d1
aWRlbGluZXMgYW5kIFJlY29tbWVuZGF0aW9ucworPT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09CisKK09mIGNvdXJzZSwgdGhlIEdOVSBNYWtlIG1hbnVhbCBpcyBrZXkgdG8gdW5kZXJzdGFu
ZGluZyB0aGUgTWFrZSBzeXN0ZW0sIGJ1dAoraGVyZSBhcmUgdGhlIGZvbGxvd2luZyBzZWN0aW9u
cyBhbmQgY2hhcHRlcnMgSSBzdWdnZXN0IHJldmlld2luZzoKKworLSBpbXBsaWNpdCBydWxlczog
aHR0cDovL3d3dy5nbnUub3JnL3NvZnR3YXJlL21ha2UvbWFudWFsL21ha2UuaHRtbCNJbXBsaWNp
dC1SdWxlcworLSB2YXJpYWJsZXMgYW5kIGV4cGFuc2lvbjogaHR0cDovL3d3dy5nbnUub3JnL3Nv
ZnR3YXJlL21ha2UvbWFudWFsL21ha2UuaHRtbCNVc2luZy1WYXJpYWJsZXMKKy0gb3JpZ2luIHVz
ZTogaHR0cDovL3d3dy5nbnUub3JnL3NvZnR3YXJlL21ha2UvbWFudWFsL21ha2UuaHRtbCNPcmln
aW4tRnVuY3Rpb24KKy0gdnBhdGggdXNlOiBodHRwOi8vd3d3LmdudS5vcmcvc29mdHdhcmUvbWFr
ZS9tYW51YWwvbWFrZS5odG1sI0RpcmVjdG9yeS1TZWFyY2gKKworPT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09CitCZWZvcmUgQ29tbWl0dGluZworPT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09CisKK09uZSBzaG91bGQgcmVidWlsZCBmcm9tIHNjcmF0Y2ggYmVmb3JlIGNvbW1pdHRp
bmcuIEhlcmUncyBhbiBleGFtcGxlIG9mIGhvdyB0bworZG8gdGhhdDoKKyMhL2Jpbi9zaAorCitU
T09MU19QQVRIPS9wYXRoL3RvL3Rvb2xzCisKKyMgUmVwbGFjZSBbb3B0aW9uc10gd2l0aCBhbnkg
bWFrZSBzcGVjaWZpYyBvcHRpb25zIGFuZCB2YXJpYWJsZXMsIGZvciBlYWNoCisjIHN0ZXAsIGV4
YW1wbGU6IC1qIDQsIERFU1RESVI9L3BhdGgvZm9yL2luc3RhbGwsIGV0Yy4KK21ha2UgYWMtY2xl
YW4gYWMtbWFpbnRhaW5lci1jbGVhbiBkaXN0Y2xlYW4gbWFpbnRhaW5lci1jbGVhbiBbb3B0aW9u
c10KK21ha2UgXAorICBBQ0xPQ0FMPSRUT09MU19QQVRIL2Jpbi9hY2xvY2FsIFwKKyAgQVVUT0NP
TkY9JFRPT0xTX1BBVEgvYmluL2F1dG9jb25mIFwKKyAgQVVUT0hFQURFUj0kVE9PTFNfUEFUSC9i
aW4vYXV0b2hlYWRlciBcCisgIEFVVE9NQUtFPSRUT09MU19QQVRIL2Jpbi9hdXRvbWFrZSBcCisg
IGF1dG90b29scworLi9jb25maWd1cmUgW29wdGlvbnNdCittYWtlIGFsbCBbb3B0aW9uc10KK21h
a2UgaW5zdGFsbCBbb3B0aW9uc10KKworPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09CitP
dGhlciBFcnJhdGEKKz09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQorCistIFRoaXMgc3lz
dGVtIChpbiBpdHMgY3VycmVudCBmb3JtKSBzdXBwb3J0cyBjcm9zcy1jb21waWxhdGlvbiBvdXQg
b2YgYSBzaW5nbGUKK2RpcmVjdG9yeS4gT2JqZWN0IGRpcmVjdG9yeSBzdXBwb3J0IHdpbGwgYmUg
Y29tcGxldGVkIHNvb24gdG8gcHJvcGVybHkgZW5hYmxlCitjcm9zcy1jb21waWxhdGlvbi4gVGhp
cyBpcyByZXF1aXJlZCB0byBhdm9pZCBzcG9yYWRpYyBNYWtlLXJlbGF0ZWQgZXJyb3JzLgorCisj
IHZpbToKSW5kZXg6IGluY2x1ZGUvbWsvbWFzdGVyX2luY2x1ZGUubWsKPT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQpSQ1Mg
ZmlsZTogaW5jbHVkZS9tay9tYXN0ZXJfaW5jbHVkZS5tawpkaWZmIC1OIGluY2x1ZGUvbWsvbWFz
dGVyX2luY2x1ZGUubWsKLS0tIC9kZXYvbnVsbAkxIEphbiAxOTcwIDAwOjAwOjAwIC0wMDAwCisr
KyBpbmNsdWRlL21rL21hc3Rlcl9pbmNsdWRlLm1rCTEyIEp1bCAyMDA5IDA1OjM4OjQwIC0wMDAw
CkBAIC0wLDAgKzEsMjUgQEAKKyMKKyMgICAgTWFzdGVyIGluY2x1ZGUgTWFrZWZpbGUuCisjCisj
ICAgIENvcHlyaWdodCAoQykgMjAwOSwgQ2lzY28gU3lzdGVtcyBJbmMuCisjCisjICAgIFRoaXMg
cHJvZ3JhbSBpcyBmcmVlIHNvZnR3YXJlOyB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3Ig
bW9kaWZ5CisjICAgIGl0IHVuZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGlj
IExpY2Vuc2UgYXMgcHVibGlzaGVkIGJ5CisjICAgIHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRp
b247IGVpdGhlciB2ZXJzaW9uIDIgb2YgdGhlIExpY2Vuc2UsIG9yCisjICAgIChhdCB5b3VyIG9w
dGlvbikgYW55IGxhdGVyIHZlcnNpb24uCisjCisjICAgIFRoaXMgcHJvZ3JhbSBpcyBkaXN0cmli
dXRlZCBpbiB0aGUgaG9wZSB0aGF0IGl0IHdpbGwgYmUgdXNlZnVsLAorIyAgICBidXQgV0lUSE9V
VCBBTlkgV0FSUkFOVFk7IHdpdGhvdXQgZXZlbiB0aGUgaW1wbGllZCB3YXJyYW50eSBvZgorIyAg
ICBNRVJDSEFOVEFCSUxJVFkgb3IgRklUTkVTUyBGT1IgQSBQQVJUSUNVTEFSIFBVUlBPU0UuICBT
ZWUgdGhlCisjICAgIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGZvciBtb3JlIGRldGFpbHMu
CisjCisjICAgIFlvdSBzaG91bGQgaGF2ZSByZWNlaXZlZCBhIGNvcHkgb2YgdGhlIEdOVSBHZW5l
cmFsIFB1YmxpYyBMaWNlbnNlIGFsb25nCisjICAgIHdpdGggdGhpcyBwcm9ncmFtOyBpZiBub3Qs
IHdyaXRlIHRvIHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb24sIEluYy4sCisjICAgIDUxIEZy
YW5rbGluIFN0cmVldCwgRmlmdGggRmxvb3IsIEJvc3RvbiwgTUEgMDIxMTAtMTMwMSBVU0EuCisj
CisjIEdhcnJldHQgQ29vcGVyLCBKdWx5IDIwMDkKKyMKKworIyBPbmx5IGluY2x1ZGUgY29uZmln
Lm1rIGZvciBub24tY2xlYW4gYmFzZWQgdGFyZ2V0cy4KKy1pbmNsdWRlICQodG9wX3NyY2Rpcikv
aW5jbHVkZS9tay9jb25maWcubWsKK2luY2x1ZGUgJCh0b3Bfc3JjZGlyKS9pbmNsdWRlL21rL21h
c3Rlcl9ydWxlcy5tawpJbmRleDogaW5jbHVkZS9tay9tYXN0ZXJfcnVsZXMubWsKPT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PQpSQ1MgZmlsZTogaW5jbHVkZS9tay9tYXN0ZXJfcnVsZXMubWsKZGlmZiAtTiBpbmNsdWRlL21r
L21hc3Rlcl9ydWxlcy5tawotLS0gL2Rldi9udWxsCTEgSmFuIDE5NzAgMDA6MDA6MDAgLTAwMDAK
KysrIGluY2x1ZGUvbWsvbWFzdGVyX3J1bGVzLm1rCTEyIEp1bCAyMDA5IDA1OjM4OjQwIC0wMDAw
CkBAIC0wLDAgKzEsMzA0IEBACisjCisjICAgIE1hc3RlciBydWxlcyBNYWtlZmlsZS4KKyMKKyMg
ICAgQ29weXJpZ2h0IChDKSAyMDA5LCBDaXNjbyBTeXN0ZW1zIEluYy4KKyMKKyMgICAgVGhpcyBw
cm9ncmFtIGlzIGZyZWUgc29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vciBt
b2RpZnkKKyMgICAgaXQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMg
TGljZW5zZSBhcyBwdWJsaXNoZWQgYnkKKyMgICAgdGhlIEZyZWUgU29mdHdhcmUgRm91bmRhdGlv
bjsgZWl0aGVyIHZlcnNpb24gMiBvZiB0aGUgTGljZW5zZSwgb3IKKyMgICAgKGF0IHlvdXIgb3B0
aW9uKSBhbnkgbGF0ZXIgdmVyc2lvbi4KKyMKKyMgICAgVGhpcyBwcm9ncmFtIGlzIGRpc3RyaWJ1
dGVkIGluIHRoZSBob3BlIHRoYXQgaXQgd2lsbCBiZSB1c2VmdWwsCisjICAgIGJ1dCBXSVRIT1VU
IEFOWSBXQVJSQU5UWTsgd2l0aG91dCBldmVuIHRoZSBpbXBsaWVkIHdhcnJhbnR5IG9mCisjICAg
IE1FUkNIQU5UQUJJTElUWSBvciBGSVRORVNTIEZPUiBBIFBBUlRJQ1VMQVIgUFVSUE9TRS4gIFNl
ZSB0aGUKKyMgICAgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgZm9yIG1vcmUgZGV0YWlscy4K
KyMKKyMgICAgWW91IHNob3VsZCBoYXZlIHJlY2VpdmVkIGEgY29weSBvZiB0aGUgR05VIEdlbmVy
YWwgUHVibGljIExpY2Vuc2UgYWxvbmcKKyMgICAgd2l0aCB0aGlzIHByb2dyYW07IGlmIG5vdCwg
d3JpdGUgdG8gdGhlIEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbiwgSW5jLiwKKyMgICAgNTEgRnJh
bmtsaW4gU3RyZWV0LCBGaWZ0aCBGbG9vciwgQm9zdG9uLCBNQSAwMjExMC0xMzAxIFVTQS4KKyMK
KyMgR2FycmV0dCBDb29wZXIsIEp1bHkgMjAwOQorIworCisjIEdldCB0aGUgYWJzb2x1dGUgcGF0
aCBmb3IgdGhlIHNvdXJjZSBkaXJlY3RvcnkuCitpZmVxICgkKG9yaWdpbiB0b3Bfc3JjZGlyKSx1
bmRlZmluZWQpCiskKGVycm9yIHRvcF9zcmNkaXIgaXMgbm90IGRlZmluZWQpCitlbmRpZgorCisj
IFdoZXJlJ3MgdGhlIHJvb3Qgc291cmNlIGRpcmVjdG9yeT8KK3RvcF9zcmNkaXIJCQk6PSAkKGFi
c3BhdGggJCh0b3Bfc3JjZGlyKSkKKyMgV2hlcmUncyB0aGUgc291cmNlIGxvY2F0ZWQgYXQ/Citz
cmNkaXIJCQkJPz0gLgorIyBXaGVyZSdzIHRoZSByb290IG9iamVjdCBkaXJlY3Rvcnk/CitidWls
ZGRpcgkJCT89ICQoc3JjZGlyKQorIyBXaGVyZSBhcmUgd2UgY3VycmVudGx5IGxvY2F0ZWQgaW4g
dGhlIG9iamVjdCBhbmQgc291cmNlIHRyZWU/CityZWxwYXRoCQkJCTo9ICQoc3Vic3QgJChhYnNf
YnVpbGRkaXIpLCwkKENVUkRJUikpCisjIFdoZXJlIGFyZSB3ZSBnb2luZyB0byBpbnN0YWxsIHRo
ZSBmaWxlcz8gTW9zdCBvZiB0aGlzIGp1bmsgZW5kcyB1cCBpbgorIyB0ZXN0Y2FzZXMvYmluLCBz
byBsZXQncyBkdW1wIGl0IHRoZXJlIDopLi4uCitJTlNUQUxMX0RJUgkJCT89IHRlc3RjYXNlcy9i
aW4KKworYWJzX2J1aWxkZGlyCQkJOj0gJChhYnNwYXRoICQoYnVpbGRkaXIpKQorYWJzX3NyY2Rp
cgkJCTo9ICQoYWJzcGF0aCAkKHNyY2RpcikpCisKKyMgV2UgY2FuIHBpZWNlIHRvZ2V0aGVyIHdo
ZXJlIHdlJ3JlIGxvY2F0ZWQgaW4gdGhlIHNvdXJjZSBhbmQgb2JqZWN0IHRyZWVzIHdpdGgKKyMg
anVzdCB0aGVzZSB0d28gdmFycyBhbmQgJChDVVJESVIpLgorZXhwb3J0IHRvcF9zcmNkaXIgYnVp
bGRkaXIKKworZGVmaW5lIGdlbmVyYXRlX3ZwYXRoX3J1bGUKK3ZwYXRoICUuJCgxKQkkKGlmICQo
MiksJCgyKSwkKHNyY2RpcikpCitlbmRlZgorCitkZWZpbmUgZ2VuZXJhdGVfaW5zdGFsbF9ydWxl
CiskJCh3YXJuaW5nICJnaXI6ICQoMSkgPT4gJCgyKSIpCisKKyQoMSk6CisJaW5zdGFsbCAtbSAk
JChJTlNUQUxMX01PREUpICIkKDIpLyQkKEBGKSIgIiQkQCIKK2VuZGVmCisKKyMgRGVmYXVsdCBz
b3VyY2Ugc2VhcmNoIHBhdGguIE1vZGlmeSBhcyBuZWNlc3NhcnksIGJ1dCBJIHdvdWxkIGNhbGwg
dGhhdAorIyBwb29yIHNvZnR3YXJlIGRlc2lnbiBpZiB5b3UgbmVlZCBtb3JlIHRoYW4gb25lIHNl
YXJjaCBkaXJlY3RvcnksIGFuZAorIyB3b3VsZCBzdWdnZXN0IGNyZWF0aW5nIGEgZ2VuZXJhbCBw
dXJwb3NlIHN0YXRpYyBsaWJyYXJ5IHRvIHRoYXQgZW5kLgorJChldmFsICQoY2FsbCBnZW5lcmF0
ZV92cGF0aF9ydWxlLGMpKQorCisjCisjIGdldF9tYWtlX2RpcnMKKyMKKyMgU2V0cyB0aGUgbWFr
ZSBkaXJlY3RvcmllcyBpbiAkKFNVQkRJUlMpLCBhbmQgdGhlbiBzdWJzZXF1ZW50bHkgZmlsdGVy
cyBvdXQKKyMgdGhlIHN1YmRpcmVjdG9yaWVzIGJhc2VkIG9uICQoRklMVEVSX09VVF9ESVJTKS4K
KyMKK2RlZmluZSBnZXRfbWFrZV9kaXJzCisKK1NVQkRJUlMJCQkJPz0gJCQocGF0c3Vic3QgJS9N
YWtlZmlsZSwlLCQkKHdpbGRjYXJkICovTWFrZWZpbGUpKQorCitpZm5lcSAoJCQoc3RyaXAgJCQo
U1VCRElSUykpLCkJCSMgV2UgaGF2ZSBkaXJlY3RvcmllcyB0byBwYXJzZS4KK2lmbmVxICgkJChz
dHJpcCAkJChGSUxURVJfT1VUX0RJUlMpKSwpCSMgV2UgaGF2ZSBkaXJlY3RvcmllcyB0byBmaWx0
ZXItb3V0LgorU1VCRElSUwkJCQk6PSAkJChmaWx0ZXItb3V0ICQkKEZJTFRFUl9PVVRfRElSUyks
JCQoU1VCRElSUykpCitlbmRpZgorZW5kaWYKKworZW5kZWYKKworZGVmaW5lIGdlbmVyaWNfdGFy
Z2V0X2Vudl9zZXR1cAorCitpZmVxICgkJChvcmlnaW4gTUFLRV9UQVJHRVRTKSx1bmRlZmluZWQp
CitNQUtFX1RBUkdFVFMJCQk6PSAkJChub3RkaXIgJCQocGF0c3Vic3QgJS5jLCUsJCQod2lsZGNh
cmQgJCQoc3JjZGlyKS8qLmMpKSkKK2VuZGlmCisKKyMgRG9uJ3QgYXBwZW5kICQoTUFLRV9UQVJH
RVRTKSB1bmxlc3MgaXQgaXMgbm9uLU5VTCBsZW5ndGguCitpZm5lcSAoJCQoc3RyaXAgJCQoTUFL
RV9UQVJHRVRTKSksKQorCitDTEVBTl9UQVJHRVRTCQkJKz0gJCQoTUFLRV9UQVJHRVRTKQorSU5T
VEFMTF9UQVJHRVRTCQkJKz0gJCQoTUFLRV9UQVJHRVRTKQorCitlbmRpZgorCitDTEVBTl9UQVJH
RVRTCQkJKz0gJCQod2lsZGNhcmQgKi5vKQorCisjIFRoZSBsYXJnZSBtYWpvcml0eSBvZiB0aGUg
ZmlsZXMgdGhhdCB3ZSBpbnN0YWxsIGFyZSBnb2luZyB0byBiZSBhcHBzIGFuZAorIyBzY3JpcHRz
LCBzbyBsZXQncyBjaG1vZCB0aGVtIGxpa2UgdGhhdC4KK0lOU1RBTExfTU9ERQkJCT89IDAwNzc1
CisKK2lmbmVxICgkKGZpbHRlci1vdXQgJWluc3RhbGwsJChNQUtFQ01ER09BTFMpKSwpCSMgTm90
IGFuIGluc3RhbGwgdGFyZ2V0IC0tIHNraXAuCitpZmVxICgkJChvcmlnaW4gSU5TVEFMTF9ESVIp
LHVuZGVmaW5lZCkJIyBOb3Qgc2V0IGJ5IHRoZSB1c2VyIC0tIG1vc3QgbGlrZSBhCisJCQkJCSMg
cHJvZ3JhbW1pbmcgZXJyb3Igbm93IGluIHRoaXMgLm1rCisJCQkJCSMgZmlsZS4KKyQkKGVycm9y
IElOU1RBTExfRElSIGlzIG5vdCBzZXQgKHVuZGVmaW5lZCkpCitlbHNlCitpZmVxICgkJChzdHJp
cCAkJChJTlNUQUxMX0RJUikpLCkJIyBTZXQgdG8gYSBOVUwtbGVuZ3RoIHN0cmluZyAoZGV2CisJ
CQkJCSMgZXJyb3IgaW4gYSBsZWFmIE1ha2VmaWxlLCBvcgorCQkJCQkjIHNvbWVvbmUncyB0b3lp
bmcgd2l0aCB0aGUKKwkJCQkJIyBlbnZpcm9ubWVudCkuCiskJChlcnJvciBJTlNUQUxMX0RJUiBp
cyBub3Qgc2V0IHRvIGEgbm9uLU5VTCBzdHJpbmcpCisgCQkJCQkjIGVsc2UgJChJTlNUQUxMX0RJ
UikgaXMgc2V0IHRvIGEKKyAJCQkJCSMgbm9uLU5VTCBzdHJpbmcuCisKK2VuZGlmCQkJCQkjIEVO
RDogSU5TVEFMTF9ESVIgTlVMLWxlbmd0aCBzdHJpbmcuCitlbmRpZgkJCQkJIyBFTkQ6IHVuZGVm
aW5lZAorZW5kaWYJCQkJCSMgRU5EOiBOb3QgaW5zdGFsbAorCisjIEFuIGFic29sdXRlIHBhdGg7
IGRvbid0IGFwcGVuZCAkKERFU1RESVIpLyQocHJlZml4KSB0byB0aGUgdmFyLgoraWZlcSAoJCQo
cGF0c3Vic3QgLyUsLCQkKElOU1RBTExfRElSKSksKQorSU5TVEFMTF9QQVRICQkJOj0gJCQoSU5T
VEFMTF9ESVIpCisjIE90aGVyd2lzZSwgbGV0J3MgYXNzdW1lIHRoYXQgaXQncyBub3QgcmVsYXRp
dmUgdG8gJChwcmVmaXgpCitlbHNlCitJTlNUQUxMX1BBVEgJCQk6PSAkJChERVNURElSKS8kJChw
cmVmaXgpLyQkKElOU1RBTExfRElSKQorZW5kaWYKKworSU5TVEFMTF9GSUxFUwkJCTo9ICQkKGFk
ZHByZWZpeCAkJChJTlNUQUxMX1BBVEgpLywkJChub3RkaXIgJCQoSU5TVEFMTF9UQVJHRVRTKSkp
CisKK0NMRUFOX1RBUkdFVFMJCQkrPSAkJChJTlNUQUxMX0ZJTEVTKQorCiskJChJTlNUQUxMX1BB
VEgpOgorCW1rZGlyIC1wICQkQAorCiskJChJTlNUQUxMX0ZJTEVTKTogJTogcHJlLWluc3RhbGwg
JCQoYWJzX2J1aWxkZGlyKS8kJChARikgJCQoSU5TVEFMTF9ERVBTKQorCWluc3RhbGwgLW0gJCQo
SU5TVEFMTF9NT0RFKSAkJChhYnNfYnVpbGRkaXIpLyQkKEBGKSAkJEAKKworZW5kZWYKKworIwor
IyBnZW5lcmljX2xlYWZfdGFyZ2V0CisjCisjIEdlbmVyYXRlIGEgc2V0IG9mIGJhc2ljIHRhcmdl
dHMgKGFsbCwgY2xlYW4sIGluc3RhbGwpIGZvciBhIGxlYWYgZGlyZWN0b3J5CisjIChubyBzdWJk
aXJlY3RvcmllcykuCisjCisjIEluIG9yZGVyIHRvIHByb3Blcmx5IGVtdWxhdGUgcHJlLSBhbmQg
cG9zdC0gYmVoYXZpb3IsIGEgcHJlLWluc3RhbGwgYW5kCisjIF9pbnN0YWxsIHRhcmdldCBhcmUg
Z2VuZXJhdGVkIGFzIHdlbGwuIFRoZSBmbG93IGZvciBpbnN0YWxsIGlzIGFzIGZvbGxvd3M6Cisj
CisjIHByZS1pbnN0YWxsIC0+ICQoSU5TVEFMTF9GSUxFUykgLT4gaW5zdGFsbAorIworIyBIZWxw
ZnVsIHZhcmlhYmxlcyBhcmU6CisjCisjICQoTUFLRV9ERVBTKQkJCTogV2hhdCB0byBleGVjdXRl
IGJlZm9yZSBhbGwuCisjICQoTUFLRV9UQVJHRVRTKQkJOiBXaGF0IHRvIGV4ZWN1dGUgYXMgZGly
ZWN0IGRlcGVuZGVuY2llcyBvZgorIyAJCQkJICBhbGwuCisjIAkJCQkgIDEuIERlZmF1bHRzIHRv
IHRoZSBiYXNlbmFtZSBvZiB0aGUgdGFyZ2V0cworIyAJCQkJICAgICBwcm9kdWNlZCBieSB0aGUg
JS5jIC0+ICUgaW1wbGljaXQgcGF0dGVybgorIyAJCQkJICAgICBydWxlcywgZS5nLiB0aGUgTUFL
RV9UQVJHRVQgaW4gYSBkaXJlY3RvcnkKKyMgCQkJCSAgICAgbGlrZSB0aGUgZm9sbG93aW5nOgor
IworIwkJCQkgICQkIGxzIC9iYXIKKyMgCQkJCSAgZm9vLmMKKyMKKyMJCQkJICAgICBXb3VsZCBi
ZSBgZm9vJy4gU2ltaWxhcmx5LCB0aGUgZm9sbG93aW5nCisjCQkJCSAgICAgZGlyIHN0cnVjdHVy
ZToKKyMKKyMJCQkJICAkJCBscyAvYmFyCisjIAkJCQkgIGZvby5jIHphbnppYmFyLmMKKyMKKyMJ
CQkJICAgICBXb3VsZCBiZSBgZm9vIHphbnppYmFyJy4KKyMKKyMJCQkJICAyLiBJZiB5b3UgZGVm
aW5lIE1BS0VfVEFSR0VUUyBhcyBhbiBlbXB0eQorIwkJCQkgICAgIHN0cmluZywgdGhpcyB3aWxs
IG92ZXJyaWRlIHRoZSBkZWZhdWx0cy4KKyMJCQkJICAgICBJIGRpZCB0aGlzIHRvIGF2b2lkIHBy
b3ZpZGluZyB0b28gbXVjaAorIwkJCQkgICAgIHJvcGUgdG8gaGFuZyBvbmUncyBzZWxmIGluIHRo
ZSBldmVudCBvZgorIwkJCQkgICAgIHVud2FudGVkIGJlaGF2aW9yLgorIworIyAkKENMRUFOX1RB
UkdFVFMpCQk6IFdoYXQgdGFyZ2V0cyBzaG91bGQgYmUgY2xlYW5lZCAobXVzdCBiZQorIwkJCQkg
IHJlYWwgZmlsZXMpLiBUaGlzIHdpbGwgYXV0b21hdGljYWxseSBhcHBlbmQKKyMJCQkJICBhZGRz
IHRoZSAubyBzdWZmaXggdG8gYWxsIGZpbGVzIHJlZmVyZW5jZWQKKyMJCQkJICBieSAkKE1BS0Vf
VEFSR0VUUykpIHRvIENMRUFOX1RBUkdFVFMsIGlmCisjCQkJCSAgTUFLRV9UQVJHRVRTIHdhc24n
dCBkZWZpbmVkIChzZWUKKyMJCQkJICAkKE1BS0VfVEFSR0VUUykpLgorIyAkKFBSRUlOU1RBTExf
REVQUykJCTogV2hhdCB0byBydW4gYXMgZGlyZWN0IGRlcGVuZGVuY2llcyBvZgorIyAJCQkJICBw
cmUtaW5zdGFsbC4KKyMgJChJTlNUQUxMX0RFUFMpCQk6IFdoYXQgdG8gcnVuIGFzIGRpcmVjdCBk
ZXBlbmRlbmNpZXMgb2YKKyMgCQkJCSAgdGhlIF9pbnN0YWxsIHRhcmdldC4gVGhlc2UgbXVzdCBi
ZSByZWFsCisjIAkJCQkgIGZpbGVzLgorIyAkKFBPU1RJTlNUQUxMX0RFUFMpCQk6IFdoYXQgdG8g
aW5zdGFsbCBkaXJlY3QgZGVwZW5kZW5jaWVzIG9mCisjIAkJCQkgIHRoZSBpbnN0YWxsIHRhcmdl
dC4KKyMgJChJTlNUQUxMX01PREUpCQk6IFdoYXQgbW9kZSBzaG91bGQgd2UgdXNpbmcgd2hlbiBj
YWxsaW5nCisjIAkJCQkgIGluc3RhbGwoMSk/CisjCisjIElmIHlvdSBjaG9vc2UgdG8gY2hlcnJ5
cGljayB0aGUgbG9naWMgY29udGFpbmVkIGhlcmUsIGJ5IGNoYW5naW5nIGFyb3VuZCB0aGUKKyMg
ZGVwZW5kZW5jaWVzIGZvciAkKElOU1RBTExfREVQUykgYW5kICQoUE9TVElOU1RBTExfREVQUyks
IHRoZW4geW91IG11c3QgYWxzbworIyBlbXVsYXRlIHRoZSAkKElOU1RBTExfREVQUyk6IHByZS1p
bnN0YWxsIGFuZCBpbnN0YWxsOiAkKFBPU1RJTlNUQUxMX0RFUFMpCisjIGRlcGVuZGVuY2llcywg
aWYgeW91IF91c2VfIHRoZW0uCisjCisjIEFsc28sIGlmIHlvdSB3aXNoIHRvIGNoYW5nZSB0aGUg
aW5zdGFsbGF0aW9uIGRpcmVjdG9yeSwgZnJvbSB0aGUgc2V0IGRlZmF1bHQKKyMgKHRlc3RjYXNl
cy9iaW4pIHlvdSBtdXN0IGRvIHNvbWV0aGluZyBsaWtlIGVpdGhlciBvbmUgb2YgdGhlIGZvbGxv
d2luZyBpdGVtczoKKyMKKyMgTWV0aG9kIEE6CisjCisjIElOU1RBTExfRElSCQkJOj0gL3BhdGgv
dG8vaW5zdGFsbGRpci9mcm9tLyQoREVTVERJUikvJChwcmVmaXgpCisjCisjIGUuZy4gaWYgSSB3
YW50ZWQgdG8gaW5zdGFsbCBteSBiaW5hcmllcyBpbiB0ZXN0Y2FzZXMvYmluLCBJIHdvdWxkIGRv
OgorIworIyBJTlNUQUxMX0RJUgkJCTo9IHRlc3RjYXNlcy9iaW4KKyMKKyMgaW4gbXkgY2FsbGlu
ZyBNYWtlZmlsZS4KKyMKKyMgT3IgTWV0aG9kIEI6CisjCisjIElOU1RBTExfRElSCQkJOj0gL3Bh
dGgvdG8vaW5zdGFsbGRpci9mcm9tLyQoREVTVERJUikKKyMKKyMgZS5nLiBpZiBJIHdhbnRlZCB0
byBpbnN0YWxsIG15IGJpbmFyaWVzIGluICQobGliZGlyKSAod2hpY2ggbWF5IG5vdCBleGlzdAor
IyBvdXRzaWRlIG9mICQocHJlZml4KSByaWdodCBub3csIGJ1dCBjb3VsZCBpbiB0aGUgZnV0dXJl
KSwgSSBjb3VsZCBkbyB0aGUKKyMgZm9sbG93aW5nOgorIworIyBJTlNUQUxMX0RJUgkJCTo9ICQo
bGliZGlyKQorIworZGVmaW5lIGdlbmVyaWNfbGVhZl90YXJnZXQKKworJCQoZXZhbCAkJChnZW5l
cmljX3RhcmdldF9lbnZfc2V0dXApKQorCisuUEhPTlk6IGFsbCBjbGVhbiBfaW5zdGFsbCBpbnN0
YWxsIHByZS1pbnN0YWxsCisKK2FsbDogfCAkJChNQUtFX0RFUFMpICQkKE1BS0VfVEFSR0VUUykK
KworY2xlYW46ICQkKENMRUFOX0RFUFMpCisJLSQoUk0pIC1mICQkKENMRUFOX1RBUkdFVFMpCisK
K3ByZS1pbnN0YWxsOiB8ICQkKElOU1RBTExfUEFUSCkgJCQoUFJFSU5TVEFMTF9ERVBTKQorCitp
bnN0YWxsOiB8ICQkKElOU1RBTExfRklMRVMpICQkKFBPU1RJTlNUQUxMX0RFUFMpCisKK2VuZGVm
CisKKyMKKyMgZ2VuZXJpY190cnVua190YXJnZXQKKyMKKyMgR2VuZXJhdGUgYSBzZXQgb2YgcmVj
dXJzaXZlIHRhcmdldHMgdG8gYXBwbHkgb3ZlciBhIHRydW5rIGRpcmVjdG9yeSAoaGFzCisjIGRp
cmVjdG9yaWVzKSAtLSBvcHRpb25hbGx5IHdpdGggYSBzZXQgb2YgdHJ1bmstYmFzZWQgZmlsZXMu
CisjCisjIEFsbCB2YXJpYWJsZXMgaW4gdGhpcyBjYW5uZWQgZGVmaW5lIGFyZSBlc3NlbnRpYWxs
eSB0aGUgc2FtZSBhcworIyBnZW5lcmljX2xlYWZfdGFyZ2V0LCB3aXRoIHRoZSBleGNlcHRpb24g
dGhhdCB0aGUgaW5zdGFsbCBmbG93IGZvciBsb2NhbAorIyB0YXJnZXRzIGlzOgorIworIyBwcmUt
aW5zdGFsbCAtPiAkKElOU1RBTExfRklMRVMpIC0+IHRydW5rLWluc3RhbGwKKyMKKyMgQWxsIHJl
Y3Vyc2l2ZSB0YXJnZXRzIGFyZSB0cmF2ZXJzZSBTVUJESVJTIGFzIGRlZmluZWQgYnkgdGhlIHVz
ZXIsIG9yIGlmCisjIHVuZGVmaW5lZCwgZGVmYXVsdHMgdG8gYW55IHN1YmRpcmVjdG9yaWVzIHdo
ZXJlIE1ha2VmaWxlJ3MgYXJlIGNvbnRhaW5lZAorIyB3aXRoaW4uCisjCisjIGdlbmVyaWNfdHJ1
bmtfdGFyZ2V0IHNwZWNpZmljIHZhcmlhYmxlcyBhcmU6CisjCisjIFJFQ1VSU0lWRV9UQVJHRVRT
CQk6IGEgbGlzdCBvZiB0YXJnZXRzIHRvIGFwcGx5IG92ZXIgYW4gZW50aXJlCisjIAkJCQkgIGRp
cmVjdG9yeSB0cmVlLiBUaGlzIGRlZmF1bHRzIHRvCisjIAkJCQkgIGBhbGwgY2xlYW4gaW5zdGFs
bCcuCisjCisjIFNlZSBnZW5lcmljX2xlYWZfdGFyZ2V0LCBnZW5lcmljX3RhcmdldF9lbnZfc2V0
dXAsIGFuZCBnZXRfbWFrZV9kaXJzIGZvcgorIyBtb3JlIGRldGFpbHMgYW5kIGRlc2lnbiBub3Rl
cy4KKyMKK2RlZmluZSBnZW5lcmljX3RydW5rX3RhcmdldAorCisjCisjIERvZXNuJ3QgbmVlZCBm
b3JjZWQgc2Vjb25kYXJ5IGV4cGFuc2lvbiBiZWNhdXNlICQoQ1VSRElSKSBpc24ndCBnb2luZyB0
bworIyBjaGFuZ2UgKG9yIGF0IGxlYXN0IGl0IGJsb29keSB3ZWxsIHNob3VsZG4ndCA7KS4uLiku
CisjCisjIERvbid0IGRvIHRoaXMgaW4gZ2VuZXJpY190YXJnZXRfZW52X3NldHVwLCBiZWNhdXNl
IHdlIG9ubHkgbmVlZCB0byBkbyB0aGlzCisjIGJ5IGRlZmF1bHQgZm9yIGdlbmVyaWNfZGlyX3Rh
cmdldC4KKyMKKyQoZXZhbCAkKGdldF9tYWtlX2RpcnMpKQorCitSRUNVUlNJVkVfVEFSR0VUUwkJ
Pz0gYWxsIGNsZWFuIGluc3RhbGwKKworLlBIT05ZOiAkJChSRUNVUlNJVkVfVEFSR0VUUykgJCQo
YWRkcHJlZml4IHRydW5rLSwkJChSRUNVUlNJVkVfVEFSR0VUUykpIHByZS1pbnN0YWxsCisKKyQk
KGV2YWwgJCQoZ2VuZXJpY190YXJnZXRfZW52X3NldHVwKSkKKwordHJ1bmstYWxsOiB8ICQkKE1B
S0VfREVQUykgJCQoTUFLRV9UQVJHRVRTKQorCit0cnVuay1jbGVhbjogJCQoQ0xFQU5fREVQUykK
KwktJChSTSkgLWYgJCQoQ0xFQU5fVEFSR0VUUykKKworcHJlLWluc3RhbGw6IHwgJCQoSU5TVEFM
TF9QQVRIKSAkJChQUkVJTlNUQUxMX0RFUFMpCisKK3RydW5rLWluc3RhbGw6IHwgJCQoSU5TVEFM
TF9GSUxFUykgJCQoUE9TVElOU1RBTExfREVQUykKKworIyBBdm9pZCBjcmVhdGluZyBkdXBsaWNh
dGUgLlBIT05ZIHJlZmVyZW5jZXMgdG8gYWxsLCBjbGVhbiwgYW5kIGluc3RhbGwuIElJUkMsCisj
IEkndmUgc2VlbiBzb21lIGluZGV0ZXJtaW5pc3RpYyBiZWhhdmlvciB3aGVuIG9uZSBkb2VzIHRo
aXMgaW4gdGhlIHBhc3Qgd2l0aAorIyBHTlUgTWFrZS4uLgorLlBIT05ZOiAkJChmaWx0ZXItb3V0
ICQkKFJFQ1VSU0lWRV9UQVJHRVRTKSxhbGwgY2xlYW4gaW5zdGFsbCkKK2FsbDogdHJ1bmstYWxs
CisKK2NsZWFuOiB0cnVuay1jbGVhbgorCitpbnN0YWxsOiB0cnVuay1pbnN0YWxsCisKKyQkKFJF
Q1VSU0lWRV9UQVJHRVRTKTogJToKKwlAc2V0IC1lOyBmb3IgZGlyIGluICQkKFNVQkRJUlMpOyBk
byBcCisJICAgICQoTUFLRSkgLUMgJCQkJGRpciAkJEA7IFwKKwlkb25lCisKK2VuZGVmCkluZGV4
OiBpbmNsdWRlL21rL2xpYi5tawo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09ClJDUyBmaWxlOiBpbmNsdWRlL21rL2xpYi5t
awpkaWZmIC1OIGluY2x1ZGUvbWsvbGliLm1rCi0tLSAvZGV2L251bGwJMSBKYW4gMTk3MCAwMDow
MDowMCAtMDAwMAorKysgaW5jbHVkZS9tay9saWIubWsJMTIgSnVsIDIwMDkgMDU6Mzg6NDAgLTAw
MDAKQEAgLTAsMCArMSw3MSBAQAorIworIyAgICBsaWJyYXJ5IGluY2x1ZGUgTWFrZWZpbGUuCisj
CisjICAgIENvcHlyaWdodCAoQykgMjAwOSwgQ2lzY28gU3lzdGVtcyBJbmMuCisjCisjICAgIFRo
aXMgcHJvZ3JhbSBpcyBmcmVlIHNvZnR3YXJlOyB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQv
b3IgbW9kaWZ5CisjICAgIGl0IHVuZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05VIEdlbmVyYWwgUHVi
bGljIExpY2Vuc2UgYXMgcHVibGlzaGVkIGJ5CisjICAgIHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5k
YXRpb247IGVpdGhlciB2ZXJzaW9uIDIgb2YgdGhlIExpY2Vuc2UsIG9yCisjICAgIChhdCB5b3Vy
IG9wdGlvbikgYW55IGxhdGVyIHZlcnNpb24uCisjCisjICAgIFRoaXMgcHJvZ3JhbSBpcyBkaXN0
cmlidXRlZCBpbiB0aGUgaG9wZSB0aGF0IGl0IHdpbGwgYmUgdXNlZnVsLAorIyAgICBidXQgV0lU
SE9VVCBBTlkgV0FSUkFOVFk7IHdpdGhvdXQgZXZlbiB0aGUgaW1wbGllZCB3YXJyYW50eSBvZgor
IyAgICBNRVJDSEFOVEFCSUxJVFkgb3IgRklUTkVTUyBGT1IgQSBQQVJUSUNVTEFSIFBVUlBPU0Uu
ICBTZWUgdGhlCisjICAgIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGZvciBtb3JlIGRldGFp
bHMuCisjCisjICAgIFlvdSBzaG91bGQgaGF2ZSByZWNlaXZlZCBhIGNvcHkgb2YgdGhlIEdOVSBH
ZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGFsb25nCisjICAgIHdpdGggdGhpcyBwcm9ncmFtOyBpZiBu
b3QsIHdyaXRlIHRvIHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb24sIEluYy4sCisjICAgIDUx
IEZyYW5rbGluIFN0cmVldCwgRmlmdGggRmxvb3IsIEJvc3RvbiwgTUEgMDIxMTAtMTMwMSBVU0Eu
CisjCisjIEdhcnJldHQgQ29vcGVyLCBKdWx5IDIwMDkKKyMKKworaW5jbHVkZSAkKHRvcF9zcmNk
aXIpL2luY2x1ZGUvbWsvbWFzdGVyX2luY2x1ZGUubWsKKworIyBDaGFuZ2UgdGhlIGRlZmF1bHQg
Z29hbCB3aGVuIG5vdGhpbmcgaXMgc3BlY2lmaWVkIHRvIGluc3RhbGwgYmVjYXVzZSB3ZSB3YW50
CisjIHRvIGVuc3VyZSB0aGF0IHRoZSBsaWJyYXJpZXMgZ2V0IGluc3RhbGxlZCBBU0FQIHNvIHRo
ZXkgY2FuIGJlIHByb3Blcmx5CisjIGxpbmtlZCBpbiB3aXRoIGFsbCByZXF1aXJlZCBhcHBzLgor
Q1BQRkxBR1MJCQkrPSAtSSQoaW5jbHVkZWRpcikKKworIyBBbiBleHRlbnNpb24gb2YgZ2VuZXJp
Y19sZWFmX3RhcmdldCwgc3RyaWN0bHkgZm9yIGxpYnJhcmllcy4KK2RlZmluZSBsaWJfdGFyZ2V0
CisKKy5QSE9OWTogaW5zdGFsbF9oZWFkZXJzCisKK2lmZXEgKCQkKG9yaWdpbiBMSUIpLHVuZGVm
aW5lZCkKKyQkKGVycm9yIFlvdSBtdXN0IGRlZmluZSBMSUIgd2hlbiBpbmNsdWRpbmcgdGhpcyBN
YWtlZmlsZSkKK2VuZGlmCisKK2luc3RhbGxfaGVhZGVyczogJCQoYWRkcHJlZml4ICQoaW5jbHVk
ZWRpcikvLCQkKG5vdGRpciAkJChIRUFERVJfRklMRVMpKSkKKworSU5TVEFMTF9ERVBTCQkJOj0g
aW5zdGFsbF9oZWFkZXJzCisKK0lOU1RBTExfRElSCQkJOj0gJChsaWJkaXIpCisKK0lOU1RBTExf
TU9ERQkJCT89IDAwNjY0CisKK0xJQgkJCQk6PSAkJChhZGRwcmVmaXggJCQoYnVpbGRkaXIpLywk
JChMSUIpKQorCitNQUtFX1RBUkdFVFMJCQk6PSAkJChMSUIpCisKK2lmZXEgKCQkKG9yaWdpbiBM
SUJTUkNTKSx1bmRlZmluZWQpCitMSUJTUkNTCQkJCT89ICQkKHdpbGRjYXJkICQoc3JjZGlyKS8q
LmMpCitlbmRpZgorCitMSUJTUkNTCQkJCTo9ICQkKG5vdGRpciAkJChMSUJTUkNTKSkKKworTElC
T0JKUwkJCQk6PSAkJChhZGRwcmVmaXggJCQoYnVpbGRkaXIpLywkJChwYXRzdWJzdCAlLmMsJS5v
LCQkKExJQlNSQ1MpKSkKKworJCQod2FybmluZyAkJChMSUJTUkNTKSkKKworJCQoTElCKTogJCQo
TElCT0JKUykKKwlzZXQgLWU7IGlmIFsgLXogIiQkKHN0cmlwICQkXikiIF0gOyB0aGVuIFwKKwkg
ICAgZWNobyAiQ293YXJkbHkgcmVmdXNpbmcgdG8gY3JlYXRlIGVtcHR5IGFyY2hpdmUuIjsgXAor
CSAgICBleGl0IDE7IFwKKwlmaQorCSQkKEFSKSAtcmMgJCRAICQkXgorCSQkKFJBTkxJQikgJCRA
CisKKyQkKGV2YWwgJCQoZ2VuZXJpY19sZWFmX3RhcmdldCkpCisKK2VuZGVmCkluZGV4OiBpbmNs
dWRlL21rL3Rlc3RjYXNlcy5tawo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09ClJDUyBmaWxlOiBpbmNsdWRlL21rL3Rlc3Rj
YXNlcy5tawpkaWZmIC1OIGluY2x1ZGUvbWsvdGVzdGNhc2VzLm1rCi0tLSAvZGV2L251bGwJMSBK
YW4gMTk3MCAwMDowMDowMCAtMDAwMAorKysgaW5jbHVkZS9tay90ZXN0Y2FzZXMubWsJMTIgSnVs
IDIwMDkgMDU6Mzg6NDAgLTAwMDAKQEAgLTAsMCArMSwyNSBAQAorIworIyAgICB0ZXN0Y2FzZXMg
aW5jbHVkZSBNYWtlZmlsZS4KKyMKKyMgICAgQ29weXJpZ2h0IChDKSAyMDA5LCBDaXNjbyBTeXN0
ZW1zIEluYy4KKyMKKyMgICAgVGhpcyBwcm9ncmFtIGlzIGZyZWUgc29mdHdhcmU7IHlvdSBjYW4g
cmVkaXN0cmlidXRlIGl0IGFuZC9vciBtb2RpZnkKKyMgICAgaXQgdW5kZXIgdGhlIHRlcm1zIG9m
IHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBhcyBwdWJsaXNoZWQgYnkKKyMgICAgdGhl
IEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbjsgZWl0aGVyIHZlcnNpb24gMiBvZiB0aGUgTGljZW5z
ZSwgb3IKKyMgICAgKGF0IHlvdXIgb3B0aW9uKSBhbnkgbGF0ZXIgdmVyc2lvbi4KKyMKKyMgICAg
VGhpcyBwcm9ncmFtIGlzIGRpc3RyaWJ1dGVkIGluIHRoZSBob3BlIHRoYXQgaXQgd2lsbCBiZSB1
c2VmdWwsCisjICAgIGJ1dCBXSVRIT1VUIEFOWSBXQVJSQU5UWTsgd2l0aG91dCBldmVuIHRoZSBp
bXBsaWVkIHdhcnJhbnR5IG9mCisjICAgIE1FUkNIQU5UQUJJTElUWSBvciBGSVRORVNTIEZPUiBB
IFBBUlRJQ1VMQVIgUFVSUE9TRS4gIFNlZSB0aGUKKyMgICAgR05VIEdlbmVyYWwgUHVibGljIExp
Y2Vuc2UgZm9yIG1vcmUgZGV0YWlscy4KKyMKKyMgICAgWW91IHNob3VsZCBoYXZlIHJlY2VpdmVk
IGEgY29weSBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgYWxvbmcKKyMgICAgd2l0
aCB0aGlzIHByb2dyYW07IGlmIG5vdCwgd3JpdGUgdG8gdGhlIEZyZWUgU29mdHdhcmUgRm91bmRh
dGlvbiwgSW5jLiwKKyMgICAgNTEgRnJhbmtsaW4gU3RyZWV0LCBGaWZ0aCBGbG9vciwgQm9zdG9u
LCBNQSAwMjExMC0xMzAxIFVTQS4KKyMKKyMgR2FycmV0dCBDb29wZXIsIEp1bHkgMjAwOQorIwor
CitpbmNsdWRlICQodG9wX3NyY2RpcikvaW5jbHVkZS9tay9tYXN0ZXJfaW5jbHVkZS5taworCitM
RExJQlMJCQkrPSAtbGx0cAo=
--000e0cd32bba42aaf6046e7baae4
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
--000e0cd32bba42aaf6046e7baae4
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--000e0cd32bba42aaf6046e7baae4--

