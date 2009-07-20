Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <michal.simek@petalogix.com>) id 1MSlNU-00078B-Su
	for ltp-list@lists.sourceforge.net; Mon, 20 Jul 2009 05:25:32 +0000
Received: from mail-bw0-f215.google.com ([209.85.218.215])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MSlNS-0000m6-5X
	for ltp-list@lists.sourceforge.net; Mon, 20 Jul 2009 05:25:32 +0000
Received: by bwz11 with SMTP id 11so1719130bwz.10
	for <ltp-list@lists.sourceforge.net>;
	Sun, 19 Jul 2009 22:25:28 -0700 (PDT)
Message-ID: <4A63FFC3.80304@petalogix.com>
Date: Mon, 20 Jul 2009 07:25:23 +0200
From: Michal Simek <michal.simek@petalogix.com>
MIME-Version: 1.0
References: <364299f40907181419y73621db2w1242b7a1fa7650c@mail.gmail.com>
In-Reply-To: <364299f40907181419y73621db2w1242b7a1fa7650c@mail.gmail.com>
Subject: Re: [LTP] [PATCH 3/4] Make system enhancements, Draft 3
Reply-To: michal.simek@petalogix.com
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net, Mike Frysinger <vapier@gentoo.org>

Garrett Cooper wrote:
> Version 3 of the epic saga: [PATCH 3/4] Make system enhancements.
>
> ========
> HISTORY
> ========
>
> Draft 1:
> 1. Write up a document on how to use the new Make system
> (README.mk-devel), so others may assist in the work that we're
> spearheading at Cisco and contributing back to LTP, and we can begin
> dropping the adhoc Makefiles.
> 2. Add master_rules.mk which contains canned rules for environment
> setup, leaf directories, and trunk directories to reduce Make logic
> noise in the existing LTP Makefile's. This is a more condensed and
> straightforward version of the original master_rules.mk file
> contributed and never integrated into LTP in the past.
> 3. Add master_include.mk, a file which stands as the defacto include
> Makefile for all . This was created out of the comment provided by
> Mike Frysinger w.r.t. a master include file.
>
> Draft 2:
> 1. Addresses issues brought up by Mike Frysinger in draft 1 review.
> 2. Fixes several bugs found through continued testing.
> 3. Adds lib.mk, testcases.mk to create more structure in Makefiles,
> and prevent ad-hoc structure with libraries and testcases/ directory
> binaries to reduce code duplication.
>
> Draft 3:
> Address all outstanding comments by Mike Frysinger in draft 2 review.
>
> Signed-off-by: Garrett Cooper <yanegomi@gmail.com>
>
> Index: README.mk-devel
> ===================================================================
> RCS file: README.mk-devel
> diff -N README.mk-devel
> --- /dev/null	1 Jan 1970 00:00:00 -0000
> +++ README.mk-devel	18 Jul 2009 21:15:04 -0000
> @@ -0,0 +1,178 @@
> +==============================
> +Introduction
> +==============================
> +
> +The following document briefly describes the steps and methodologies used for
> +the new and improved Makefile system.
> +
> +==============================
> +The Problem
> +==============================
> +
> +The problem with the old Makefile system is that it was very difficult to
> +maintain and it lacked any sense of formal structure, thus developing for LTP
> +and including new targets was very more difficult than it should have been
> +(maintenance). Furthermore, cross-compilation was impossible due to the fact
> +that the Makefiles didn't support a prefixing system, and the appropriate
> +implicit / static rules hadn't been configured to compile into multiple object
> +directories (easy of use / functionality).
I cross compile LTP all the time and Mike do the same for BlackFin.
cross-compilation was possible.
CROSS_COMPILE=mb-linux-
make

>  Finally, there wasn't a means to
> +setup dependencies between components, such that if a component required
> +libltp.a in order to compile, it would go off and compile libltp.a first
> +(easy of use).
> +
> +These items needed to be fixed to reduce maintenance nightmares for the
> +development community contributing to LTP.
> +
> +==============================
> +Design
> +==============================
> +
> +The system was designed such that including a single GNU Makefile compatible
> +set in each new directory component is all that's essentially required to
> +build the system. Here's an example of how one would accomplish that:
> +
> +.../foo/Makefile:
> +#
> +# Copyright disclaimer goes here -- please use GPLv2.
> +#
> +
> +srcdir			?= ../
> +
> +include $(srcdir)/include/mk/master_include.mk
> +
> +$(eval $(generic_dir_target))
> +
> +.../foo/bar/Makefile:
> +#
> +# Copyright disclaimer goes here -- please use GPLv2.
> +#
> +
> +srcdir			?= ../
> +
> +include $(srcdir)/include/mk/master_include.mk
> +
> +$(eval $(generic_leaf_target))
> +
> +==============================
> +Make Rules and Make Variables
> +==============================
> +
> +When using make rules, avoid writing adhoc rules like:
> +
> +[prog]: [dependencies]
> +	cc -I../../include $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $(LDLIBS) \
> +	    -o [prog] [dependencies]
> +
> +etc. This makes cross-compilation and determinism difficult, if not impossible.
> +Besides, implicit rules are your friends and as long as you use `MAKEOPTS=;' in
> +the top-level caller (or do $(subst r,$(MAKEOPTS)) to remove -r), the compile
> +will complete successfully, assuming all other prerequisites have been
> +fulfilled (libraries, headers, etc).
> +
> +$(AR)			: The library archiver.
> +
> +$(CC)			: The system C compiler.
> +
> +$(CXX)			: The system C++ compiler.
> +
> +$(CPP)			: The system C preprocessor.
> +
> +$(CFLAGS)		: C compiler flags.
> +
> +$(CPPFLAGS)		: Preprocessor flags, e.g. -I arguments.
> +
> +$(CXXFLAGS)		: C++ compiler flags, e.g. -I arguments.
> +
> +$(DEBUG_CFLAGS)		: Debug flags to pass to $(CC), -g, etc.
> +
> +$(DEBUG_CXXFLAGS)	: Debug flags to pass to $(CXX).
> +
> +$(LD)			: The system linker (typically $(CC), but not
> +			  necessarily).
> +
> +$(LDFLAGS)		: What to pass in to the linker, including -L arguments
> +			  and other ld arguments, apart from -l library
> +			  includes (see $(LDLIBS)).
> +
> +			  This should be done in the $(CC) args passing style
> +			  when LD := $(CC), e.g. `-Wl,-foo', as opposed to
> +			  `-foo'.
> +
> +$(LDLIBS)		: Libraries to pass to the linker (e.g. -lltp, etc).
> +
> +$(OPT_CFLAGS)		: Optimization flags to pass into the C compiler, -O2,
> +			  etc. If you specify -O2 or higher, make sure that you
> +			  also specify -fno-strict-aliasing, because of gcc
> +			  fstrict-aliasing optimization bugs in the tree
> +			  optimizer! Search for `fstrict-aliasing optimization
> +			  bug'.
> +
> +			  Examples:
> +			  1. tree-optimization/17510
> +			  2. tree-optimization/39100
> +
> +			  Various bugs have occurred in the past due to buggy
> +			  logic in the tree-optimization portion of the gcc
> +			  compiler, from 3.3.x to 4.4, so far.
> +
> +$(OPT_CXXFLAGS)		: Optimization flags to pass to the C++ compiler.
> +
> +$(RANLIB)		: What to run after archiving a library.
> +
> +$(WCFLAGS)		: Warning flags to pass to $(CC), e.g. -Werror,
> +			  -Wall, etc.
> +
> +$(WCXXFLAGS)		: Same as $(WCFLAGS), but for $(CXX).
> +
> +==============================
> +Make System Variables
> +==============================
> +
> +A series of variables are used within the make system that direct what actions
> +need to be taken. Rather than me listing the variables here, please instead
> +refer to the comments contained in `.../include/mk/master_rules.mk'.
> +
> +==============================
> +Guidelines and Recommendations
> +==============================
> +
> +Of course, the GNU Make manual is key to understanding the Make system, but
> +here are the following sections and chapters I suggest reviewing:
> +
> +- implicit rules:
> http://www.gnu.org/software/make/manual/make.html#Implicit-Rules
> +- variables and expansion:
> http://www.gnu.org/software/make/manual/make.html#Using-Variables
> +- origin use: http://www.gnu.org/software/make/manual/make.html#Origin-Function
> +- vpath use: http://www.gnu.org/software/make/manual/make.html#Directory-Search
> +
> +==============================
> +Before Committing
> +==============================
> +
> +One should rebuild from scratch before committing. Here's an example of how to
> +do that:
> +#!/bin/sh
> +
> +TOOLS_PATH=/path/to/tools
> +
> +# Replace [options] with any make specific options and variables, for each
> +# step, example: -j 4, DESTDIR=/path/for/install, etc.
> +make maintainer-clean [options]
> +make \
> +  ACLOCAL=$TOOLS_PATH/bin/aclocal \
> +  AUTOCONF=$TOOLS_PATH/bin/autoconf \
> +  AUTOHEADER=$TOOLS_PATH/bin/autoheader \
> +  AUTOMAKE=$TOOLS_PATH/bin/automake \
> +  autotools
> +./configure [options]
> +make all [options]
> +make install [options]
> +
> +==============================
> +Other Errata
> +==============================
> +
> +- This system (in its current form) supports cross-compilation out of a single
> +directory. Object directory support will be completed soon to properly enable
> +cross-compilation. This is required to avoid sporadic Make-related errors.
> +
> +# vim:
> Index: include/mk/master_rules.mk
> ===================================================================
> RCS file: include/mk/master_rules.mk
> diff -N include/mk/master_rules.mk
> --- /dev/null	1 Jan 1970 00:00:00 -0000
> +++ include/mk/master_rules.mk	18 Jul 2009 21:15:04 -0000
> @@ -0,0 +1,311 @@
> +#
> +#    Master rules Makefile.
> +#
> +#    Copyright (C) 2009, Cisco Systems Inc.
> +#
> +#    This program is free software; you can redistribute it and/or modify
> +#    it under the terms of the GNU General Public License as published by
> +#    the Free Software Foundation; either version 2 of the License, or
> +#    (at your option) any later version.
> +#
> +#    This program is distributed in the hope that it will be useful,
> +#    but WITHOUT ANY WARRANTY; without even the implied warranty of
> +#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +#    GNU General Public License for more details.
> +#
> +#    You should have received a copy of the GNU General Public License along
> +#    with this program; if not, write to the Free Software Foundation, Inc.,
> +#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> +#
> +# Garrett Cooper, July 2009
> +#
> +
> +# Get the absolute path for the source directory.
> +ifeq ($(origin top_srcdir),undefined)
> +$(error top_srcdir is not defined)
> +endif
> +
> +# Where's the root source directory?
> +top_srcdir			:= $(abspath $(top_srcdir))
> +
> +# Where's the root object directory?
> +top_builddir			?= $(top_srcdir)		# Just in case
> +								# it's not
> +								# specified...
> +
> +top_builddir			:= $(abspath $(top_builddir))	# We need the
> +								# absolute
> +								# path...
> +# Where's the source located at?
> +srcdir				?= .
> +# Where's the root object directory?
> +builddir			?= $(srcdir)
> +# Where are we going to install the files? Most of this junk ends up in
> +# testcases/bin, so let's dump it there :)...
> +INSTALL_DIR			?= testcases/bin
> +
> +abs_builddir			:= $(abspath $(builddir))
> +abs_srcdir			:= $(abspath $(srcdir))
> +
> +# We can piece together where we're located in the source and object trees with
> +# just these two vars and $(CURDIR).
> +export top_srcdir top_builddir
> +
> +define generate_vpath_rule
> +vpath %.$(1)	$(if $(2),$(2),$(srcdir))
> +endef
> +
> +define generate_install_rule
> +$$(warning "gir: $(1) => $(2)")
> +
> +$(1):
> +	install -m $$(INSTALL_MODE) "$(2)/$$(@F)" "$$@"
> +endef
> +
> +# Default source search path. Modify as necessary, but I would call that
> +# poor software design if you need more than one search directory, and
> +# would suggest creating a general purpose static library to that end.
> +$(eval $(call generate_vpath_rule,c))
> +
> +#
> +# get_make_dirs
> +#
> +# Sets the make directories in $(SUBDIRS), and then subsequently filters out
> +# the subdirectories based on $(FILTER_OUT_DIRS).
> +#
> +define get_make_dirs
> +
> +SUBDIRS				?= $$(patsubst %/Makefile,%,$$(wildcard */Makefile))
> +
> +ifneq ($$(strip $$(SUBDIRS)),)		# We have directories to parse.
> +ifneq ($$(strip $$(FILTER_OUT_DIRS)),)	# We have directories to filter-out.
> +SUBDIRS				:= $$(filter-out $$(FILTER_OUT_DIRS),$$(SUBDIRS))
> +endif
> +endif
> +
> +endef
> +
> +define generic_target_env_setup
> +
> +ifeq ($$(origin MAKE_TARGETS),undefined)
> +MAKE_TARGETS			:= $$(notdir $$(patsubst %.c,%,$$(wildcard $$(srcdir)/*.c)))
> +endif
> +
> +# Don't append $(MAKE_TARGETS) unless it is non-NUL length.
> +ifneq ($$(strip $$(MAKE_TARGETS)),)
> +
> +CLEAN_TARGETS			+= $$(MAKE_TARGETS)
> +INSTALL_TARGETS			+= $$(MAKE_TARGETS)
> +
> +endif
> +
> +CLEAN_TARGETS			+= $$(wildcard *.o)
> +
> +# The large majority of the files that we install are going to be apps and
> +# scripts, so let's chmod them like that.
> +INSTALL_MODE			?= 00775
> +
> +ifneq ($(filter-out %install,$(MAKECMDGOALS)),)	# Not an install
> target -- skip.
> +ifeq ($$(origin INSTALL_DIR),undefined)	# Not set by the user -- most like a
> +					# programming error now in this .mk
> +					# file.
> +$$(error INSTALL_DIR is not set (undefined))
> +else
> +ifeq ($$(strip $$(INSTALL_DIR)),)	# Set to a NUL-length string (dev
> +					# error in a leaf Makefile, or
> +					# someone's toying with the
> +					# environment).
> +$$(error INSTALL_DIR is not set to a non-NUL string)
> + 					# else $(INSTALL_DIR) is set to a
> + 					# non-NUL string.
> +
> +endif					# END: INSTALL_DIR NUL-length string.
> +endif					# END: undefined
> +endif					# END: Not install
> +
> +# An absolute path; don't append $(DESTDIR)/$(prefix) to the var.
> +ifeq ($$(patsubst /%,,$$(INSTALL_DIR)),)
> +INSTALL_PATH			:= $$(INSTALL_DIR)
> +# Otherwise, let's assume that it's not relative to $(prefix)
> +else
> +INSTALL_PATH			:= $$(DESTDIR)/$$(prefix)/$$(INSTALL_DIR)
> +endif
> +
> +INSTALL_FILES			:= $$(addprefix $$(INSTALL_PATH)/,$$(notdir
> $$(INSTALL_TARGETS)))
> +
> +CLEAN_TARGETS			+= $$(INSTALL_FILES)
> +
> +$$(INSTALL_PATH):
> +	mkdir -p $$@
> +
> +$$(INSTALL_FILES): %: pre-install $$(abs_builddir)/$$(@F) $$(INSTALL_DEPS)
> +	install -m $$(INSTALL_MODE) $$(abs_builddir)/$$(@F) $$@
> +
> +endef
> +
> +#
> +# generic_leaf_target
> +#
> +# Generate a set of basic targets (all, clean, install) for a leaf directory
> +# (no subdirectories).
> +#
> +# In order to properly emulate pre- and post- behavior, a pre-install and
> +# _install target are generated as well. The flow for install is as follows:
> +#
> +# pre-install -> $(INSTALL_FILES) -> install
> +#
> +# Helpful variables are:
> +#
> +# $(MAKE_DEPS)			: What to execute before all.
> +# $(MAKE_TARGETS)		: What to execute as direct dependencies of
> +# 				  all.
> +# 				  1. Defaults to the basename of the targets
> +# 				     produced by the %.c -> % implicit pattern
> +# 				     rules, e.g. the MAKE_TARGET in a directory
> +# 				     like the following:
> +#
> +#				  $$ ls /bar
> +# 				  foo.c
> +#
> +#				     Would be `foo'. Similarly, the following
> +#				     dir structure:
> +#
> +#				  $$ ls /bar
> +# 				  foo.c zanzibar.c
> +#
> +#				     Would be `foo zanzibar'.
> +#
> +#				  2. If you define MAKE_TARGETS as an empty
> +#				     string, this will override the defaults.
> +#				     I did this to avoid providing too much
> +#				     rope to hang one's self in the event of
> +#				     unwanted behavior.
> +#
> +# $(CLEAN_TARGETS)		: What targets should be cleaned (must be
> +#				  real files). This will automatically append
> +#				  adds the .o suffix to all files referenced
> +#				  by $(MAKE_TARGETS)) to CLEAN_TARGETS, if
> +#				  MAKE_TARGETS wasn't defined (see
> +#				  $(MAKE_TARGETS)).
> +# $(PREINSTALL_DEPS)		: What to run as direct dependencies of
> +# 				  pre-install.
> +# $(INSTALL_DEPS)		: What to run as direct dependencies of
> +# 				  the _install target. These must be real
> +# 				  files.
> +# $(POSTINSTALL_DEPS)		: What to install direct dependencies of
> +# 				  the install target.
> +# $(INSTALL_MODE)		: What mode should we using when calling
> +# 				  install(1)?
> +#
> +# If you choose to cherrypick the logic contained here, by changing around the
> +# dependencies for $(INSTALL_DEPS) and $(POSTINSTALL_DEPS), then you must also
> +# emulate the $(INSTALL_DEPS): pre-install and install: $(POSTINSTALL_DEPS)
> +# dependencies, if you _use_ them.
> +#
> +# Also, if you wish to change the installation directory, from the set default
> +# (testcases/bin) you must do something like either one of the following items:
> +#
> +# Method A:
> +#
> +# INSTALL_DIR			:= /path/to/installdir/from/$(DESTDIR)/$(prefix)
> +#
> +# e.g. if I wanted to install my binaries in testcases/bin, I would do:
> +#
> +# INSTALL_DIR			:= testcases/bin
> +#
> +# in my calling Makefile.
> +#
> +# Or Method B:
> +#
> +# INSTALL_DIR			:= /path/to/installdir/from/$(DESTDIR)
> +#
> +# e.g. if I wanted to install my binaries in $(libdir) (which may not exist
> +# outside of $(prefix) right now, but could in the future), I could do the
> +# following:
> +#
> +# INSTALL_DIR			:= $(libdir)
> +#
> +define generic_leaf_target
> +
> +$$(eval $$(generic_target_env_setup))
> +
> +.PHONY: all clean _install install pre-install
> +
> +all: | $$(MAKE_DEPS) $$(MAKE_TARGETS)
> +
> +clean: $$(CLEAN_DEPS)
> +	-$(RM) -f $$(CLEAN_TARGETS)
> +
> +pre-install: | $$(INSTALL_PATH) $$(PREINSTALL_DEPS)
> +
> +install: | $$(INSTALL_FILES) $$(POSTINSTALL_DEPS)
> +
> +endef
> +
> +#
> +# generic_trunk_target
> +#
> +# Generate a set of recursive targets to apply over a trunk directory (has
> +# directories) -- optionally with a set of trunk-based files.
> +#
> +# All variables in this canned define are essentially the same as
> +# generic_leaf_target, with the exception that the install flow for local
> +# targets is:
> +#
> +# pre-install -> $(INSTALL_FILES) -> trunk-install
> +#
> +# All recursive targets are traverse SUBDIRS as defined by the user, or if
> +# undefined, defaults to any subdirectories where Makefile's are contained
> +# within.
> +#
> +# generic_trunk_target specific variables are:
> +#
> +# RECURSIVE_TARGETS		: a list of targets to apply over an entire
> +# 				  directory tree. This defaults to
> +# 				  `all clean install'.
> +#
> +# See generic_leaf_target, generic_target_env_setup, and get_make_dirs for
> +# more details and design notes.
> +#
> +define generic_trunk_target
> +
> +#
> +# Doesn't need forced secondary expansion because $(CURDIR) isn't going to
> +# change (or at least it bloody well shouldn't ;)...).
> +#
> +# Don't do this in generic_target_env_setup, because we only need to do this
> +# by default for generic_dir_target.
> +#
> +$(eval $(get_make_dirs))
> +
> +RECURSIVE_TARGETS		?= all clean install
> +
> +.PHONY: $$(RECURSIVE_TARGETS) $$(addprefix
> trunk-,$$(RECURSIVE_TARGETS)) pre-install
> +
> +$$(eval $$(generic_target_env_setup))
> +
> +trunk-all: | $$(MAKE_DEPS) $$(MAKE_TARGETS)
> +
> +trunk-clean: $$(CLEAN_DEPS)
> +	-$(RM) -f $$(CLEAN_TARGETS)
> +
> +pre-install: | $$(INSTALL_PATH) $$(PREINSTALL_DEPS)
> +
> +trunk-install: | $$(INSTALL_FILES) $$(POSTINSTALL_DEPS)
> +
> +# Avoid creating duplicate .PHONY references to all, clean, and install. IIRC,
> +# I've seen some indeterministic behavior when one does this in the past with
> +# GNU Make...
> +.PHONY: $$(filter-out $$(RECURSIVE_TARGETS),all clean install)
> +all: trunk-all
> +
> +clean: trunk-clean
> +
> +install: trunk-install
> +
> +$$(RECURSIVE_TARGETS): %:
> +	@set -e; for dir in $$(SUBDIRS); do \
> +	    $(MAKE) -C $$$$dir $$@; \
> +	done
> +
> +endef
> Index: include/mk/master_include.mk
> ===================================================================
> RCS file: include/mk/master_include.mk
> diff -N include/mk/master_include.mk
> --- /dev/null	1 Jan 1970 00:00:00 -0000
> +++ include/mk/master_include.mk	18 Jul 2009 21:15:04 -0000
> @@ -0,0 +1,25 @@
> +#
> +#    Master include Makefile.
> +#
> +#    Copyright (C) 2009, Cisco Systems Inc.
> +#
> +#    This program is free software; you can redistribute it and/or modify
> +#    it under the terms of the GNU General Public License as published by
> +#    the Free Software Foundation; either version 2 of the License, or
> +#    (at your option) any later version.
> +#
> +#    This program is distributed in the hope that it will be useful,
> +#    but WITHOUT ANY WARRANTY; without even the implied warranty of
> +#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +#    GNU General Public License for more details.
> +#
> +#    You should have received a copy of the GNU General Public License along
> +#    with this program; if not, write to the Free Software Foundation, Inc.,
> +#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> +#
> +# Garrett Cooper, July 2009
> +#
> +
> +# Only include config.mk for non-clean based targets.
> +-include $(top_srcdir)/include/mk/config.mk
> +include $(top_srcdir)/include/mk/master_rules.mk
> Index: include/mk/lib.mk
> ===================================================================
> RCS file: include/mk/lib.mk
> diff -N include/mk/lib.mk
> --- /dev/null	1 Jan 1970 00:00:00 -0000
> +++ include/mk/lib.mk	18 Jul 2009 21:15:04 -0000
> @@ -0,0 +1,71 @@
> +#
> +#    library include Makefile.
> +#
> +#    Copyright (C) 2009, Cisco Systems Inc.
> +#
> +#    This program is free software; you can redistribute it and/or modify
> +#    it under the terms of the GNU General Public License as published by
> +#    the Free Software Foundation; either version 2 of the License, or
> +#    (at your option) any later version.
> +#
> +#    This program is distributed in the hope that it will be useful,
> +#    but WITHOUT ANY WARRANTY; without even the implied warranty of
> +#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +#    GNU General Public License for more details.
> +#
> +#    You should have received a copy of the GNU General Public License along
> +#    with this program; if not, write to the Free Software Foundation, Inc.,
> +#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> +#
> +# Garrett Cooper, July 2009
> +#
> +
> +include $(top_srcdir)/include/mk/master_include.mk
> +
> +# Change the default goal when nothing is specified to install because we want
> +# to ensure that the libraries get installed ASAP so they can be properly
> +# linked in with all required apps.
> +CPPFLAGS			+= -I$(includedir)
> +
> +# An extension of generic_leaf_target, strictly for libraries.
> +define lib_target
> +
> +.PHONY: install_headers
> +
> +ifeq ($$(origin LIB),undefined)
> +$$(error You must define LIB when including this Makefile)
> +endif
> +
> +install_headers: $$(addprefix $(includedir)/,$$(notdir $$(HEADER_FILES)))
> +
> +INSTALL_DEPS			:= install_headers
> +
> +INSTALL_DIR			:= $(libdir)
> +
> +INSTALL_MODE			?= 00664
> +
> +LIB				:= $$(addprefix $$(builddir)/,$$(LIB))
> +
> +MAKE_TARGETS			:= $$(LIB)
> +
> +ifeq ($$(origin LIBSRCS),undefined)
> +LIBSRCS				?= $$(wildcard $(srcdir)/*.c)
> +endif
> +
> +LIBSRCS				:= $$(notdir $$(LIBSRCS))
> +
> +LIBOBJS				:= $$(addprefix $$(builddir)/,$$(patsubst %.c,%.o,$$(LIBSRCS)))
>   
long line.

Michal


> +
> +$$(warning $$(LIBSRCS))
> +
> +$$(LIB): $$(LIBOBJS)
> +	set -e; if [ -z "$$(strip $$^)" ] ; then \
> +	    echo "Cowardly refusing to create empty archive."; \
> +	    exit 1; \
> +	fi
> +	$$(AR) -rc $$@ $$^
> +	$$(RANLIB) $$@
> +
> +$$(eval $$(generic_leaf_target))
> +
> +endef
> Index: include/mk/testcases.mk
> ===================================================================
> RCS file: include/mk/testcases.mk
> diff -N include/mk/testcases.mk
> --- /dev/null	1 Jan 1970 00:00:00 -0000
> +++ include/mk/testcases.mk	18 Jul 2009 21:15:04 -0000
> @@ -0,0 +1,25 @@
> +#
> +#    testcases include Makefile.
> +#
> +#    Copyright (C) 2009, Cisco Systems Inc.
> +#
> +#    This program is free software; you can redistribute it and/or modify
> +#    it under the terms of the GNU General Public License as published by
> +#    the Free Software Foundation; either version 2 of the License, or
> +#    (at your option) any later version.
> +#
> +#    This program is distributed in the hope that it will be useful,
> +#    but WITHOUT ANY WARRANTY; without even the implied warranty of
> +#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +#    GNU General Public License for more details.
> +#
> +#    You should have received a copy of the GNU General Public License along
> +#    with this program; if not, write to the Free Software Foundation, Inc.,
> +#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> +#
> +# Garrett Cooper, July 2009
> +#
> +
> +include $(top_srcdir)/include/mk/master_include.mk
> +
> +LDLIBS			+= -lltp
>
> ------------------------------------------------------------------------------
> Enter the BlackBerry Developer Challenge  
> This is your chance to win up to $100,000 in prizes! For a limited time, 
> vendors submitting new applications to BlackBerry App World(TM) will have
> the opportunity to enter the BlackBerry Developer Challenge. See full prize  
> details at: http://p.sf.net/sfu/Challenge
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
>   


-- 
Michal Simek, Ing. (M.Eng)
PetaLogix - Linux Solutions for a Reconfigurable World
w: www.petalogix.com p: +61-7-30090663,+42-0-721842854 f: +61-7-30090663


------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have
the opportunity to enter the BlackBerry Developer Challenge. See full prize  
details at: http://p.sf.net/sfu/Challenge
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
