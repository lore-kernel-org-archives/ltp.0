Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MO36W-000398-U4
	for ltp-list@lists.sourceforge.net; Tue, 07 Jul 2009 05:20:32 +0000
Received: from wf-out-1314.google.com ([209.85.200.174])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MO36U-0006PB-GP
	for ltp-list@lists.sourceforge.net; Tue, 07 Jul 2009 05:20:32 +0000
Received: by wf-out-1314.google.com with SMTP id 26so1683560wfd.4
	for <ltp-list@lists.sourceforge.net>;
	Mon, 06 Jul 2009 22:20:29 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 6 Jul 2009 22:20:29 -0700
Message-ID: <364299f40907062220h4410d6ehebfe063e5b3d6fe4@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH 2/4] Make system enhancements, Draft 2
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: LTP list <ltp-list@lists.sourceforge.net>

Taking the 1st Draft patch, there were some potential unresolved
usability issues that needed to be addressed, dealing with sensible
defaults and error heuristics.

Summary of changes:
1. Default INSTALL_DIR's value to testcases/bin (most probable
location where files will be deposited).
2. Convert existing references to
$$(DESTDIR)/$$(prefix)/$$(INSTALL_DIR) with $$(INSTALL_PATH).
3. If INSTALL_DIR has $(prefix) in it, don't bother prefixing
INSTALL_PATH with $(prefix) (end-user most likely wanted to use the
autoconf standard var, which makes more sense in some cases, or just
hardcoded some value that was absolute).
4. Switch from objroot to objdir, as it appears to be the implicit
defacto standard in large open source groups, like Mozilla, for
specifying object directories with which to install generated and
standalone Makefile trees.

Index: README.mk-devel
===================================================================
RCS file: README.mk-devel
diff -N README.mk-devel
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ README.mk-devel	7 Jul 2009 05:14:55 -0000
@@ -0,0 +1,127 @@
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
+	cc -I../../include $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $(LOADLIBES) \
+	    -o [prog] [dependencies]
+
+etc. This makes cross-compilation and determinism difficult, if not impossible.
+Besides, implicit rules are your friends and as long as you use `MAKEOPTS=;' in
+the top-level caller, the compile will complete successfully,
assuming all other
+prerequisites have been fulfilled (libraries, headers, etc).
+
+$(CC)			: The system compiler. Please avoid sending in options
+			  that should be in $(CFLAGS),
+
+$(CFLAGS)		: What to pass in to $(CC)
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
+++ include/mk/master_include.mk	7 Jul 2009 05:14:55 -0000
@@ -0,0 +1,28 @@
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
+# Copyright (c) 2009 by Cisco Systems, Inc.
+# All rights reserved
+#
+
+# Only include config.mk for non-clean based targets.
+-include $(srcdir)/include/mk/config.mk
+-include $(srcdir)/include/mk/master_rules.mk
Index: include/mk/master_rules.mk
===================================================================
RCS file: include/mk/master_rules.mk
diff -N include/mk/master_rules.mk
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ include/mk/master_rules.mk	7 Jul 2009 05:14:55 -0000
@@ -0,0 +1,300 @@
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
+# Copyright (c) 2009 by Cisco Systems, Inc.
+# All rights reserved
+#
+
+# Get the absolute path for the source directory.
+ifeq ($(origin srcdir),undefined)
+$(error "srcdir isn't defined.")
+endif
+
+# Where's the root source directory?
+srcdir				:= $(abspath $(srcdir))
+# Where's the root object directory?
+objdir				?= $(srcdir)
+# Where are we currently located in the object and source tree?
+relpath				:= $(subst $(objdir),,$(CURDIR))
+# Where are we going to install the files? Most of this junk ends up in
+# testcases/bin, so let's dump it there :)...
+INSTALL_DIR			?= testcases/bin
+
+# We can piece together where we're located in the source and object trees with
+# just these two vars and $(CURDIR).
+export srcdir objdir
+
+# Default source search path. Modify as necessary, but I would call that
+# poor software design if you need more than one search directory, and
+# would suggest creating a general purpose static library to that end.
+vpath	%.c			$(srcdir)/$(relpath)
+
+#
+# .o -> .a lib pattern rule.
+#
+# The way all you have to do is something like:
+#
+# mylib.a: myobj1.o myobj2.o
+#
+# and make would compile myobj.o and myobj2.o using its internal pattern rules
+# and archive it using $(AR) ;)...
+#
+%.a:
+ifeq ($^,)
+	$(error Cowardly refusing to create empty archive.)
+endif
+	$(AR) -rc $@ $^
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
+MAKE_TARGETS			:= $$(notdir $$(patsubst %.c,%,$$(wildcard
$$(srcdir)/$$(relpath)/*.c)))
+endif
+
+# Don't append $(MAKE_TARGETS) unless it is non-NUL length.
+ifneq ($$(strip $$(MAKE_TARGETS)),)
+
+$$(MAKE_TARGETS): $$(MAKE_DEPS)
+
+CLEAN_TARGETS			+= $$(MAKE_TARGETS) $$(addsuffix .o,$$(MAKE_TARGETS))
+INSTALL_TARGETS			+= $$(MAKE_TARGETS)
+
+endif
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
+# For whatever reason the end user felt compelled to put in the $(prefix)'ed
+# path (maybe via autoconf var route), let's not get in their way...
+ifeq ($$(patsubst $$(prefix)%,%,$$(INSTALL_DIR)),$$(INSTALL_DIR))
+INSTALL_PATH			:= $$(DESTDIR)/$$(INSTALL_DIR)
+# Otherwise, let's assume that it's relative to $(prefix)
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
+# Also, if you wish to change the installation directory, you must do something
+# like:
+#
+# INSTALL_DIR			:= /path/to/installdir/from/$(DESTDIR)/$(prefix)
+#
+# e.g. if I wanted to install my binaries in testcases/bin, I would do:
+#
+# INSTALL_DIR			:= testcases/bin
+#
+# in my calling Makefile.
+#
+define generic_leaf_target
+
+$$(eval $$(generic_target_env_setup))
+
+.PHONY: all clean _install install pre-install
+
+all: $$(MAKE_TARGETS)
+
+clean: $$(CLEAN_DEPS)
+	-$(RM) -f $$(CLEAN_TARGETS)
+
+pre-install: | $$(INSTALL_PATH) $$(PREINSTALL_DEPS)
+
+$$(INSTALL_FILES): %: pre-install $$(INSTALL_DEPS)
+	install -m $$(INSTALL_MODE) "$$(notdir $$@)" "$$@"
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
+trunk-all: $$(MAKE_TARGETS)
+
+trunk-clean: $$(CLEAN_DEPS)
+	-$(RM) -f $$(CLEAN_TARGETS)
+
+pre-install: | $$(INSTALL_PATH) $$(PREINSTALL_DEPS)
+
+$$(INSTALL_FILES): %: pre-install $$(INSTALL_DEPS)
+	install -m $$(INSTALL_MODE) \
+	    "$$(objdir)/$$(relpath)/$$(notdir $$@)" "$$@"
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

------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have 
the opportunity to enter the BlackBerry Developer Challenge. See full prize 
details at: http://p.sf.net/sfu/blackberry
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
