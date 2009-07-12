Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MPrPr-0005M3-BO
	for ltp-list@lists.sourceforge.net; Sun, 12 Jul 2009 05:15:59 +0000
Received: from mail-pz0-f178.google.com ([209.85.222.178])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MPrPm-0001DL-Nt
	for ltp-list@lists.sourceforge.net; Sun, 12 Jul 2009 05:15:59 +0000
Received: by pzk8 with SMTP id 8so1398019pzk.28
	for <ltp-list@lists.sourceforge.net>;
	Sat, 11 Jul 2009 22:15:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <364299f40907112106j53cd2a75l74d654d6a951ef6c@mail.gmail.com>
References: <364299f40907061722v45417bddhac499efa1415d6af@mail.gmail.com>
	<200907082042.33487.vapier@gentoo.org>
	<364299f40907090208o1c0d5b10kb151e6c910cfa79f@mail.gmail.com>
	<200907092007.58019.vapier@gentoo.org>
	<364299f40907111455x3cd6187cs39a43add00cca20f@mail.gmail.com>
	<364299f40907112106j53cd2a75l74d654d6a951ef6c@mail.gmail.com>
Date: Sat, 11 Jul 2009 22:15:53 -0700
Message-ID: <364299f40907112215y2cea044w99af91f3951ab0ff@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH 3/4] Refactor top-level Makefiles,
	modularize 	autoconf logic
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Mike Frysinger <vapier@gentoo.org>
Cc: ltp-list@lists.sourceforge.net

On Sat, Jul 11, 2009 at 9:06 PM, Garrett Cooper<yanegomi@gmail.com> wrote:
> On Sat, Jul 11, 2009 at 2:55 PM, Garrett Cooper<yanegomi@gmail.com> wrote:
>> On Thu, Jul 9, 2009 at 5:07 PM, Mike Frysinger<vapier@gentoo.org> wrote:
>>> On Thursday 09 July 2009 05:08:22 Garrett Cooper wrote:
>>>> On Wed, Jul 8, 2009 at 5:42 PM, Mike Frysinger wrote:
>>>> > On Wednesday 08 July 2009 20:21:11 Garrett Cooper wrote:
>>>> >> On Wed, Jul 8, 2009 at 4:53 PM, Mike Frysinger wrote:
>>>> > testcases/Makefile:
>>>> > i dont get all these xxx_DEPS variables and the install-testcases-bin
>>>> > target
>>>>
>>>> xxx_DEPS aren't used in typical situations. They are used in different
>>>> situations where one _must_ preserve dependency ordering. People
>>>> should NOT have to use these except with code generation, upper-level
>>>> target dependencies (my next stop after this all gets said and done,
>>>> e.g. if I do a submake from somewhere within testcases/kernel, I
>>>> better well have libltp.a built beforehand :)...), etc.
>>>
>>> yes, but in the patch you posted, i didnt see why any of those needed t=
o be in
>>> the Makefile's in question. =A0i dont have a problem adding knobs, but =
i do when
>>> they're used incorrectly or not at all.
>>>
>>> i guess i'll wait until your follow up patch to check this stuff again
>>>
>>>> >> > why cant testcases/kernel/Makefile leverage these .mk files ? =A0=
the
>>>> >> > whole point was to get away from these custom written jobbies ...
>>>> >>
>>>> >> Some of these Makefiles get a bit ugly with the pre- and post- junk=
...
>>>> >> There are a small number of Makefiles that are haunted by this work,
>>>> >> but then again I did some more rework with the generic_trunk_target
>>>> >> define.
>>>> >
>>>> > so that means you'll fix the Makefile to use the .mk files
>>>>
>>>> Yes. Again, these are bad hacks to work around the fact that these are
>>>> initial commits, and the fact that the rest of the source tree isn't
>>>> up to date with the new system (that will take ~3 days with straight
>>>> work and verification, but I'd quote a week and a half because of
>>>> random junk that can get in the way of getting things done). Only in a
>>>> few key Makefiles are these hacks required. testcases/Makefile is just
>>>> one of these examples. Here's the comment:
>>>
>>> ok, transitional hacks which are commented should be fine. =A0i dont re=
call
>>> seeing this comment in the patch posted for review though ;).
>>>
>>>> >> > debugging/optimization/warning/stripping flags shouldnt be added =
in
>>>> >> > any Makefile that is being converted to these common .mk files. =
=A0same
>>>> >> > for any DEBUG_XXX flags.
>>>> >>
>>>> >> Agreed. I was just duplicating what already existed, hoping that we
>>>> >> could sweep up this stuff after everything was in and the base
>>>> >> infrastructure was stable.
>>>> >
>>>> > i'd prefer we scrub the crap now
>>>>
>>>> Yes, but how and when should this stuff be done, and in what way? is
>>>> the ultimate question. If I were to toss in every dumb warning
>>>> compiler flag imaginable (which believe it or not _is_ the default for
>>>> the proprietary code we compile), my group in Cisco would never be
>>>> able to compile LTP because of coding issues. How much is enough, and
>>>> how much is too little?
>>>
>>> create a mirrored set of W*FLAG variables in the top level and stick the
>>> defaults in there. =A0then all sub level should be punted. =A0for now, =
use -Wall
>>> only. =A0we can save the -Wextra/-Werror/etc... bs for a later date.
>>>
>>> i.e. the top level .mk should have:
>>> WFLAGS ?=3D -Wall
>>> WCFLAGS ?=3D $(WFLAGS)
>>> WCXXFLAGS ?=3D $(WFLAGS)
>>> ...
>>> CFLAGS +=3D $(WCFLAGS)
>>> CXXFLAGS +=3D $(WCXXFLAGS)
>>> ...
>>>
>>> keep language-dedicated flags available because there are language-spec=
ific
>>> warnings that if added to the wrong language, you get even more warning=
s (gcc
>>> warning you that this warning flag is not appropriate ;x)
>>>
>>>> >> > i dont see the point in declaring empty rules like "install: ;". =
=A0if
>>>> >> > they're declared .PHONY, there is no need to add explicit rules t=
o sub
>>>> >> > Makefiles.
>>>> >>
>>>> >> They're there to avoid errors with targets not being found if I'm
>>>> >> running recursive Make rules over the entire directory tree. So, I
>>>> >> agree it's silly, but if you have a better idea, I'm all ears and I=
'll
>>>> >> get on it ASAP. I'm trying to avoid cramming more variables into the
>>>> >> Make system because it will only generate more confusion...
>>>> >
>>>> > let's look at testcases/kernel/include/Makefile. =A0how would a miss=
ing
>>>> > install target here generate an error ?
>>>>
>>>> testcases/kernel calls install recursively. I don't want to create
>>>> annoying subvariables for all, install, clean, and whatever other
>>>> recursive target I can think of, because even though I know how to, it
>>>> only serves to confuse and complicate the purpose of the system
>>>> (that's part of the reason why I'm the only individual, apart from two
>>>> others in a team of about 100, who can stumble around our complicated
>>>> build system at work).
>>>
>>> sorry, i'm still not following. =A0why would the default install target=
 not work
>>> in testcases/kernel/include/Makefile ? =A0if there are no subdirs to re=
curse
>>> into and there are no default targets to compile, what would the default
>>> install do exactly ?
>>
>> The way it was originally designed (by whoever.. dunno who), regen did
>> the equivalent to all, and all did the equivalent to install. Pretty
>> whacky, but that's the way it was.
>>
>> I fixed the caller so it doesn't do jack for all, but instead directly
>> calls install, like it basically should.
>>
>> I've had to do a lot of invasive surgery on the build over the past 4
>> hours... once I can get it to compile through clean -> all -> install,
>> without issues, I'll run a diff check on the generated files and
>> resubmit the patch.
>
> Sorry. Finding more and more random arse build issues. I *hope* I can
> have a patch out by midnight PST, pending I don't run into too many
> weird roadblocks.
>
> So much was being hidden because set -e wasn't being run with certain
> sections of the source tree when for-loops were used :(...

Ok, here's version two of the previous diff.

Summary:
1. Logic fixes to multiple Makefiles.
2. Address majority of the issues brought up by Mike Frysinger.
3. Testcases now refer to testcases.mk instead of directly calling
master_includes.mk, so additional testcases/ directory logic can be
applied to the Makefile.
4. Move tool/genload/stress.c sources to tool/genload/genload.c to
avoid hackish Makefile logic.

Index: Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/ltp/ltp/Makefile,v
retrieving revision 1.39
diff -u -r1.39 Makefile
--- Makefile	25 Mar 2009 06:17:48 -0000	1.39
+++ Makefile	12 Jul 2009 05:11:28 -0000
@@ -1,147 +1,165 @@
-# See toplevel INSTALL for build info
+#
+#    Top-level Makefile for LTP. See INSTALL for more info.
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
+#    You should have received a copy of the GNU General Public License alo=
ng
+#    with this program; if not, write to the Free Software Foundation, Inc=
.,
+#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+# Garrett Cooper, July 2009
+#
+
+# Force IDcheck.sh to fix any issues found with $(DESTDIR)/etc/group and
+# $(DESTDIR)/etc/passwd automatically when after running the top-level
+# install target.
+CREATE_ENTRIES		:=3D 0
+
+top_srcdir		:=3D $(CURDIR)
+
+include include/mk/automake.mk
+include include/mk/master_include.mk
+
+# Only check for numa when not cross-compiling.
+ifeq ($(strip $(CROSS_COMPILE)),1)
+# Disable all undetectable cross-compilation required items.
+SKIP_IDCHECK		:=3D 1
+endif

-ifdef CROSS_COMPILE
-CROSS_COMPILER =3D $(CROSS_COMPILE)
+# This variable is automatically changed from help to all once someone has
+# run configure, or the equivalent steps manually, as described in
+# README.mk-user.
+ifeq ($(wildcard include/config.h),)
+.DEFAULT_GOAL		:=3D help
+else
+.DEFAULT_GOAL		:=3D all
 endif
-ifdef CROSS_COMPILER
-CC=3D$(CROSS_COMPILER)gcc
-AR=3D$(CROSS_COMPILER)ar
-RANLIB=3D$(CROSS_COMPILER)ranlib
-endif
-
-HAS_NUMA=3D$(shell sh tools/scripts/numa_test.sh)
-
-export CFLAGS +=3D -Wall $(CROSS_CFLAGS)
-export CC AR RANLIB CPPFLAGS LDFLAGS HAS_NUMA
-
--include config.mk
-
-VPATH +=3D include m4
-all: config.h config.mk libltp.a
-	@$(MAKE) -C pan $@
-	@$(MAKE) -C testcases $@
-	@$(MAKE) -C tools $@
-	@$(MAKE) -C utils $@
-	@echo
-	@echo "***********************************************"
-	@echo "** You now need to do a make install as root **"
-	@echo "***********************************************"
-
-install: all
-	@$(MAKE) -C testcases install
-	@$(MAKE) -C tools install
-	@$(MAKE) -C lib install
-	@$(MAKE) -C include install
-	@$(MAKE) -C pan install
-	@$(MAKE) -C m4 install
-	@$(MAKE) -C doc/man1 install
-	@$(MAKE) -C doc/man3 install
-
-	@./IDcheck.sh
-
-libltp.a: config.h
-	@$(MAKE) -C lib $@
-
-uclinux: uclinux_libltp.a
-	#@$(MAKE) -C pan all
-	@$(MAKE) -C testcases uclinux
-	@$(MAKE) -C tools all
-	@echo
-	@echo "*******************************************************"
-	@echo "** You now need to do a make uclinux_install as root **"
-	@echo "*******************************************************"
-
-uclinux_install: uclinux
-	@$(MAKE) -C testcases uclinux_install
-	@$(MAKE) -C tools install
-	@./IDcheck.sh

-uclinux_libltp.a:
-	@$(MAKE) -C lib UCLINUX=3D1 libltp.a
+export HAS_NUMA

-menuconfig:
-	@./ltpmenu
+vpath %.am		$(top_srcdir)/m4
+vpath %.default		$(top_srcdir)/include
+vpath %.h		$(top_srcdir)/include
+vpath %.in		$(top_srcdir)/include
+vpath %.m4		$(top_srcdir)/m4
+vpath %.mk		$(top_srcdir)/mk:$(top_srcdir)/mk/include
+
+# User wants uclinux binaries?
+UCLINUX			?=3D 0
+
+# User wants uclinux binaries. Do this for backwards compatibility, but
+# print out a warning.
+ifneq ($(filter uclinux%,$(MAKECMDGOALS)),)
+$(warning uclinux* targets will be deprecated in the future.)
+$(warning Please specify UCLINUX=3D1 on the command line to achieve the sa=
me)
+$(warning functionality.)
+UCLINUX			:=3D 1
+endif
+
+# CLEAN_TARGETS:	Targets which exist solely in clean.
+# COMMON_TARGETS:	Targets which exist in all, clean, and install.
+# INSTALL_TARGETS:	Targets which exist in clean and install (contains
+# 			COMMON_TARGETS).
+
+# We're not using uclinux based targets (default).
+ifneq ($(UCLINUX),1)
+COMMON_TARGETS		:=3D pan utils
+INSTALL_TARGETS		:=3D doc m4
+endif

-clean: ac-clean
-	@$(MAKE) -C lib $@
-	@$(MAKE) -C pan $@
-	@$(MAKE) -C tools $@
-	@$(MAKE) -C testcases $@
-	@$(MAKE) -C utils $@
+COMMON_TARGETS		+=3D testcases tools
+INSTALL_TARGETS		+=3D $(COMMON_TARGETS)
+CLEAN_TARGETS		+=3D $(COMMON_TARGETS) include lib

-distclean: clean ac-distclean
-	@$(MAKE) -C include $@
+CLEAN_TARGETS		:=3D $(addsuffix -clean,$(CLEAN_TARGETS))
+INSTALL_TARGETS		:=3D $(addsuffix -install,$(INSTALL_TARGETS))
+MAKE_TARGETS		:=3D $(addsuffix -all,$(filter-out lib,$(COMMON_TARGETS)))

-maintainer-clean: distclean ac-maintainer-clean
-	@$(MAKE) -C include $@
+# There's no reason why we should run `all' twice. Otherwise we're just wa=
sting
+# 3+ mins of useful CPU cycles on a modern machine, and even more time on =
an
+# overtaxed one, or one where -j =3D> 1 was specified.
+all: $(addsuffix -all,$(COMMON_TARGETS))

-package:
-	rpmbuild -ba ltp-devel.spec
+$(MAKE_TARGETS): lib-install

+## Pattern based subtarget rules.
+lib-install: lib-all

-#
-# Autotools related
-#
-.PHONY: autotools
-autotools: aclocal autoconf autoheader automake
+lib-all: config.h $(top_srcdir)/include/mk/config.mk include-install

-.PHONY: aclocal
-aclocal: aclocal.m4
-aclocal.m4: $(wildcard m4/*.m4)
-	aclocal -I m4
-
-.PHONY: autoconf
-autoconf: configure
-configure: configure.ac aclocal.m4
-	autoconf
-
-.PHONY: autoheader
-autoheader: config.h.in
-config.h.in: configure.ac $(wildcard m4/*.m4)
-	autoheader
-	touch include/$@
-config.h: config.h.default
-	cp include/config.h.default include/config.h
-config.mk:
-	touch $@
-
-.PHONY: automake
-AUTOMAKE_FILES =3D config.guess config.sub install-sh missing
-automake: aclocal $(AUTOMAKE_FILES)
-$(AUTOMAKE_FILES): m4/Makefile.in
-m4/Makefile.in: m4/Makefile.am
-	automake -c -a
-
-.PHONY: ac-clean ac-distclean ac-maintainer-clean
-ac-clean:
-	rm -rf autom4te.cache
-	rm -f config.log config.status
-ac-distclean: ac-clean
-ac-maintainer-clean: ac-distclean
-	rm -f aclocal.m4 configure $(AUTOMAKE_FILES) m4/Makefile.in
+$(MAKE_TARGETS) lib-all: %-all:
+	$(MAKE) -C $* all

+#
+# Let's not conflict with ac-clean, maintainer-clean, etc, so.
 #
-# Help
+# Make sure the Makefile already exists before cd'ing to the directory to =
avoid
+# incomplete source trees /
 #
+$(CLEAN_TARGETS): %-clean: %/Makefile
+	-$(MAKE) -C $* clean
+
+# include-install is separate to avoid creating a circular dependency belo=
w in
+# the install target.
+$(INSTALL_TARGETS) include-install lib-install: %-install:
+	$(MAKE) -C $* install
+
+INSTALL_DIR		=3D $(DESTDIR)/$(prefix)
+
+clean: $(CLEAN_TARGETS)
+ifneq ($(wildcard $(INSTALL_DIR)),/)
+	-$(RM) -Rf "$(INSTALL_DIR)"
+endif
+
+$(INSTALL_DIR):
+	mkdir -p $@
+
+RUNLTP			:=3D $(INSTALL_DIR)/runltp
+
+$(RUNLTP): $(top_srcdir)/runltp $(INSTALL_DIR)
+	install -m 00755 "$(firstword $^)" "$@"
+
+INSTALL_TARGETS		+=3D $(RUNLTP)
+
+$(INSTALL_TARGETS): all $(INSTALL_DIR)
+
+## Install
+install: $(INSTALL_TARGETS)
+ifneq ($(SKIP_IDCHECK),0)
+	CREATE_ENTRIES=3D$(CREATE_ENTRIES) \
+	DESTDIR=3D$(DESTDIR) \
+	$(top_srcdir)/IDcheck.sh
+else
+	echo "*******************************************************"
+	echo "** Will not run IDcheck.sh (SKIP_IDCHECK not set to 0)."
+	echo "*******************************************************"
+endif
+
+# The empty line above was intentional. Do _not_ delete.
+
+## Misc targets.
+
+## Help
 .PHONY: help
 help:
-	@echo
-	@echo 'About configuration'
-	@echo '-------------------'
-	@echo 'If you want to use auto configuration,   '
-	@echo 'be sure autoconf and automake are installed. Then run: '
-	@echo '	$$ make autotools '
-	@echo '	$$ ./configure   '
-	@echo '	$$ make all      '
-	@echo
-	@echo 'If you want to use default configuration,  '
-	@echo 'autoconf is not needed. Just run:          '
-	@echo '	$$ touch include/config.h.default '
-	@echo '	$$ make config.h                  '
-	@echo '	$$ make all                       '
-	@echo
-	@echo 'If make all is failed even if you use the '
-	@echo 'auto configuration, please, report it to  '
-	@echo 'ltp developers with config.log, generated '
-	@echo 'by running the configure script.          '
-	@echo
+	@cat $(top_srcdir)/README.mk-user
+
+## Menuconfig
+menuconfig:
+	@$(SHELL) $(top_srcdir)/ltpmenu
+
+## Package
+package:
+	@$(RPMBUILD) -ba ltp-devel.spec
+
+## End misc targets.
Index: README.mk-user
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: README.mk-user
diff -N README.mk-user
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ README.mk-user	12 Jul 2009 05:11:28 -0000
@@ -0,0 +1,33 @@
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
+About configuration
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
+
+If you want to use auto configuration, be sure autoconf and automake are
+installed. Then run:
+ $$ make autotools
+ $$ ./configure
+ $$ make all
+
+If you want to use default configuration, autoconf is not needed.
Just run:
+ $$ touch include/config.h.default
+ $$ make config.h
+ $$ make all
+
+If make all is failed even if you use the auto configuration, please, repo=
rt
+your issue to the ltp developers with config.log, generated by running the
+configure script.
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
+Using non-standard tools
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
+
+Some systems (RHEL 4, etc) only have outdated tools available, due to
+licensing concerns. So if you happen to install these tools in a non-stand=
ard
+spot, here's how you bootstrap LTP with these tools:
+
+ $$ make \
+    ACLOCAL=3D/path/to/aclocal \
+    AUTOCONF=3D/path/to/autoconf \
+    AUTOHEADER=3D/path/to/autoheader \
+    AUTOMAKE=3D/path/to/automake \
+    autotools
Index: include/mk/automake.mk
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: include/mk/automake.mk
diff -N include/mk/automake.mk
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ include/mk/automake.mk	12 Jul 2009 05:11:28 -0000
@@ -0,0 +1,74 @@
+#
+#    Autotools include Makefile.
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
+#    You should have received a copy of the GNU General Public License alo=
ng
+#    with this program; if not, write to the Free Software Foundation, Inc=
.,
+#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+# Garrett Cooper, July 2009
+#
+
+# Override these variables to use non-system available tools.
+ACLOCAL		?=3D aclocal
+AUTOCONF	?=3D autoconf
+AUTOHEADER	?=3D autoheader
+AUTOMAKE	?=3D automake
+
+.PHONY: autotools
+autotools: aclocal autoconf autoheader automake
+
+.PHONY: aclocal
+aclocal: aclocal.m4
+
+aclocal.m4: $(wildcard m4/*.m4)
+	$(ACLOCAL) -I m4
+
+.PHONY: autoconf
+autoconf: configure
+
+configure: configure.ac aclocal.m4
+	$(AUTOCONF)
+
+.PHONY: autoheader
+autoheader: config.h.in
+
+config.h.in: configure.ac $(wildcard m4/*.m4)
+	$(AUTOHEADER)
+	touch include/$@
+
+config.h: config.h.default
+	cp $^ $@
+
+.PHONY: automake
+AUTOMAKE_FILES =3D config.guess config.sub install-sh missing
+automake: aclocal $(AUTOMAKE_FILES)
+$(AUTOMAKE_FILES): m4/Makefile.in
+m4/Makefile.in: m4/Makefile.am
+	$(AUTOMAKE) -c -a
+
+.PHONY: ac-clean ac-distclean ac-maintainer-clean
+ac-clean:
+	$(RM) -rf autom4te.cache
+	$(RM) -f config.log config.status
+	$(RM) -f ltp-devel.spec README.ltp-devel include/mk/config.mk
+	$(RM) -f lib/ltp.pc m4/Makefile
+ac-distclean: ac-clean
+ac-maintainer-clean: ac-distclean
+	$(RM) -f aclocal.m4 configure $(AUTOMAKE_FILES) m4/Makefile.in
+	$(RM) -f config.h
+
+distclean: clean ac-distclean include-clean
+
+maintainer-clean: distclean ac-maintainer-clean
Index: lib/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/ltp/ltp/lib/Makefile,v
retrieving revision 1.16
diff -u -r1.16 Makefile
--- lib/Makefile	3 Apr 2009 06:58:18 -0000	1.16
+++ lib/Makefile	12 Jul 2009 05:11:28 -0000
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
+#    You should have received a copy of the GNU General Public License alo=
ng
+#    with this program; if not, write to the Free Software Foundation, Inc=
.,
+#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+# Garrett Cooper, July 2009
+#

-PREFIX=3D/opt/ltp
+top_srcdir		?=3D ..
+
+include $(top_srcdir)/include/mk/lib.mk

-CFLAGS+=3D -Wall
-CPPFLAGS+=3D -I../include
 ifeq ($(shell uname -s),HP-UX)
-CFLAGS+=3D-Ae -D_LARGEFILE64_SOURCE +DA1.1
+CFLAGS			+=3D-Ae -D_LARGEFILE64_SOURCE +DA1.1
 endif
 ifeq ($(UCLINUX),1)
-CFLAGS+=3D -D_USC_LIB_ -D__UCLIBC__ -DUCLINUX
+CFLAGS			+=3D -D_USC_LIB_ -D__UCLIBC__ -DUCLINUX
 endif
-LDFLAGS+=3D
-TARGET=3Dlibltp.a
-SRCS=3D$(wildcard *.c)
-OBJS=3D$(patsubst %.c,%.o,$(SRCS))
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

+LIB			:=3D libltp.a
+
+pc_file			:=3D $(DESTDIR)/$(datarootdir)/pkgconfig/ltp.pc
+
+INSTALL_TARGETS		:=3D $(pc_file)
+
+$(pc_file):
+	test -d "$(@D)" || mkdir -p "$(@D)"
+	install -m $(INSTALL_MODE) "$(srcdir)/$(@F)" "$@"
+
+$(eval $(lib_target))
Index: testcases/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/ltp/ltp/testcases/Makefile,v
retrieving revision 1.16
diff -u -r1.16 Makefile
--- testcases/Makefile	30 Sep 2008 13:32:59 -0000	1.16
+++ testcases/Makefile	12 Jul 2009 05:11:28 -0000
@@ -1,21 +1,73 @@
-	SUBDIRS =3D `ls */Makefile | sed "s/Makefile//g" | grep -v open | grep
-v pounder | grep -v DOTS | grep -v kdump | grep -v realtime | grep -v
audit-test`
-UCLINUX_SUBDIRS =3D kernel
-all:
-	@set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i ; done
-
-install:
-	mkdir -p bin
-	@set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i install ; done
-
-uclinux:
-	@set -e; for i in $(UCLINUX_SUBDIRS); do $(MAKE) -C $$i uclinux; done
-
-uclinux_install:
-	mkdir -p bin
-	@set -e; for i in $(UCLINUX_SUBDIRS); \
-		do $(MAKE) -C $$i uclinux_install ; done
-
-clean:
-	rm -rf bin/
-	@set -e; for i in $(SUBDIRS) ; do $(MAKE) -C $$i clean ; done
+#
+#    testcases Makefile.
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
+#    You should have received a copy of the GNU General Public License alo=
ng
+#    with this program; if not, write to the Free Software Foundation, Inc=
.,
+#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+# Garrett Cooper, July 2009
+#

+top_srcdir		?=3D ..
+
+include $(top_srcdir)/include/mk/master_include.mk
+
+.PHONY: bin-clean install-testcases-bin
+
+ifeq ($(UCLINUX),1)
+FILTER_OUT_DIRS		:=3D audit-test DOTS kdump open% pounder realtime
+else
+SUBDIRS			:=3D kernel
+endif
+
+CLEAN_DEPS		:=3D bin-clean
+
+INSTALL_DIR		:=3D testcases/bin
+
+MAKE_DEPS		:=3D bin
+
+POSTINSTALL_DEPS	:=3D install-testcases-bin
+
+#
+# XXX (garrcoop):
+#
+# bin, bin-clean, and install-testcases-bin are only here for compatibility
+# until all of the Makefiles properly install files in $(DESTDIR)/$(prefix=
)/...
+# using master_rules.mk, and similar behavior is properly emulated in the
+# top-level Makefiles for larger components (ballista and open_posix_tests=
uite
+# for instance).
+#
+bin:
+	mkdir -p $@
+
+bin-clean:
+	$(RM) -Rf bin
+
+# Don't bother doing the wildcard and generate the following rules if we're
+# not installing anything.
+ifeq ($(MAKECMDGOALS),install)
+TC_BIN_INSTALL_FILES	:=3D $(wildcard bin/*)
+
+install-testcases-bin: $(TC_BIN_INSTALL_FILES)
+
+define backwards_compat_install
+$(DESTDIR)/$(prefix)/$(INSTALL_DIR)/$(notdir $(1)): $(1)
+	install -m 00755 "$^" "$$@"
+endef
+
+$(foreach tc_bin_install_file,$(eval $(call
backwards_compat_install,$(tc_bin_install_file))),$(TC_BIN_INSTALL_FILES))
+endif
+
+$(eval $(generic_trunk_target))
Index: testcases/kernel/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/ltp/ltp/testcases/kernel/Makefile,v
retrieving revision 1.19
diff -u -r1.19 Makefile
--- testcases/kernel/Makefile	26 Feb 2009 11:32:30 -0000	1.19
+++ testcases/kernel/Makefile	12 Jul 2009 05:11:28 -0000
@@ -1,17 +1,42 @@
-SUBDIRS =3D power_management numa containers controllers connectors
include fs io ipc mem pty sched security syscalls timers
-UCLINUX_SUBDIRS =3D include syscalls
+#
+#    kernel test suite Makefile.
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
+#    You should have received a copy of the GNU General Public License alo=
ng
+#    with this program; if not, write to the Free Software Foundation, Inc=
.,
+#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+# Garrett Cooper, July 2009
+#

-all:
-	@set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i ; done
+top_srcdir	?=3D ../..

-install:
-	@set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i install ; done
+include $(top_srcdir)/include/mk/master_include.mk

-uclinux:
-	@set -e; for i in $(UCLINUX_SUBDIRS); do $(MAKE) -C $$i uclinux ; done
+ifneq ($(UCLINUX),1)
+# By some stroke of luck my system doesn't have mm.h support. Interesting.=
..
+#SUBDIRS		:=3D power_management numa containers controllers connectors fs\
+		   mem io ipc pty sched security syscalls timers
+SUBDIRS		:=3D power_management numa containers controllers connectors fs\
+		   io ipc pty sched security syscalls timers
+else
+SUBDIRS		:=3D syscalls
+endif

-uclinux_install:
-	@set -e; for i in $(UCLINUX_SUBDIRS); do $(MAKE) -C $$i uclinux_install ;=
 done
+trunk-all: $(includedir)/linux_syscall_numbers.h

-clean:
-	@set -e; for i in $(SUBDIRS) timers; do $(MAKE) -C $$i clean ; done
+$(includedir)/linux_syscall_numbers.h:
+	$(MAKE) -C include install
+
+$(eval $(generic_trunk_target))
Index: testcases/kernel/controllers/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/ltp/ltp/testcases/kernel/controllers/Makefile,v
retrieving revision 1.11
diff -u -r1.11 Makefile
--- testcases/kernel/controllers/Makefile	15 Jun 2009 18:53:06 -0000	1.11
+++ testcases/kernel/controllers/Makefile	12 Jul 2009 05:11:28 -0000
@@ -1,79 +1,105 @@
+#
+#    kernel/controllers test suite Makefile.
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
+#    You should have received a copy of the GNU General Public License alo=
ng
+#    with this program; if not, write to the Free Software Foundation, Inc=
.,
+#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+# Garrett Cooper, July 2009
+#
+
+top_srcdir		?=3D ../../..
+
+include $(top_srcdir)/include/mk/master_include.mk
+
+SUBDIRS			:=3D
+
 ifdef CROSS_COMPILE
-CHECK_CGROUP :=3D $(shell test -f
$(TARGET_DIR)/usr/include/linux/cgroupstats.h && echo 'cgroup')
+CHECK_CGROUP :=3D $(shell test -f
$(DESTDIR)/usr/include/linux/cgroupstats.h && echo 'cgroup')
 else
 CHECK_CGROUP :=3D $(shell test -f /proc/cgroups && echo 'cgroup')
-CHECK_CPUCTL :=3D $(shell grep -w cpu /proc/cgroups 2>/dev/null|cut -f1)
-CHECK_MEMCTL :=3D $(shell grep -w memory /proc/cgroups 2>/dev/null|cut -f1)
-CHECK_BLOCKIOCTL :=3D $(shell grep -w blockio /proc/cgroups 2>/dev/null|cu=
t -f1)
-CHECK_FREEZER :=3D $(shell grep -w freezer /proc/cgroups 2>/dev/null| cut =
-f1)
-CHECK_CPUSETCTL =3D $(shell grep -w cpuset /proc/cgroups 2>/dev/null|cut -=
f1)
 endif

-ifdef CROSS_COMPILE
+ifeq ($(CROSS_COMPILE),1)	# CROSS_COMPILE =3D=3D 1
 ifeq ($(CHECK_CGROUP),cgroup)
-SUBDIRS +=3D cgroup
-SUBDIRS +=3D cpuctl
-SUBDIRS +=3D memctl
-SUBDIRS +=3D io-throttle
-SUBDIRS +=3D freezer
-SUBDIRS +=3D cpuset
+SUBDIRS +=3D cgroup cpuctl cpuset freezer io-throttle memctl
 else
 $(info "Kernel is not compiled with control cgroup support")
 endif
-else
+else				# CROSS_COMPILE !=3D 1
+
+CHECK_CPUCTL :=3D $(shell grep -w cpu /proc/cgroups 2>/dev/null|cut -f1)
+CHECK_MEMCTL :=3D $(shell grep -w memory /proc/cgroups 2>/dev/null|cut -f1)
+CHECK_BLOCKIOCTL :=3D $(shell grep -w blockio /proc/cgroups 2>/dev/null|cu=
t -f1)
+CHECK_FREEZER :=3D $(shell grep -w freezer /proc/cgroups 2>/dev/null| cut =
-f1)
+CHECK_CPUSETCTL =3D $(shell grep -w cpuset /proc/cgroups 2>/dev/null|cut -=
f1)
+
 ifeq ($(CHECK_CGROUP),cgroup)
 SUBDIRS +=3D cgroup
 else
-$(info "Kernel is not compiled with control cgroup support")
+$(info Kernel is not compiled with control cgroup support)
 endif

 ifeq ($(CHECK_MEMCTL),memory)
 SUBDIRS +=3D memcg
 else
-$(info "Kernel is not compiled with memory resource controller support")
+$(info Kernel is not compiled with memory resource controller support)
 endif

 ifeq ($(CHECK_CPUCTL),cpu)
 SUBDIRS +=3D cpuctl
 else
-$(info "Kernel is not compiled with cpu controller support")
+$(info Kernel is not compiled with cpu controller support)
 endif
 ifeq ($(CHECK_MEMCTL),memory)
 SUBDIRS +=3D memctl
 else
-$(info "Kernel is not compiled with memory resource controller support")
+$(info Kernel is not compiled with memory resource controller support)
 endif
 ifeq ($(CHECK_BLOCKIOCTL),blockio)
 SUBDIRS +=3D io-throttle
 else
-$(info "Kernel is not compiled with blockio resource controller support")
+$(info Kernel is not compiled with blockio resource controller support)
 endif
 ifeq ($(CHECK_FREEZER),freezer)
 SUBDIRS +=3D freezer
 else
-$(info "Kernel is not compiled with cgroup freezer support")
+$(info Kernel is not compiled with cgroup freezer support)
 endif
 ifeq ($(CHECK_CPUSETCTL),cpuset)
 SUBDIRS +=3D cpuset
 else
-$(info "Kernel is not compiled with cpuset resource controller support")
-endif
+$(info Kernel is not compiled with cpuset resource controller support)
 endif
+endif				# END: CROSS_COMPILE

-# If at least one of the controllers is available then build libcontroller=
s.
-ifneq ($(SUBDIRS),)
-SUBDIRS :=3D libcontrollers $(SUBDIRS)
-endif
+LIB			:=3D $(libdir)/libcontrollers.a
+LIBDIR			:=3D libcontrollers
+
+# No need to do this now, because we define SUBDIRS explicitly, but just in
+# case someone adds the reference again by accident..
+FILTER_OUT_DIRS		:=3D $(LIBDIR)

-.PHONY: all install clean
+INSTALL_TARGETS		:=3D test_controllers.sh

-all:
-	@set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i $@ ; done
+# Make the target the real lib so we don't have to deal with rebuilding th=
is
+# every time the dependency is evaluated, like with PHONY rules.
+$(LIB):
+	$(MAKE) -C $(srcdir)/$(LIBDIR) all
+	$(MAKE) -C $(srcdir)/$(LIBDIR) install

-install: test_controllers.sh
-	@chmod ugo+x test_controllers.sh
-	@ln -f test_controllers.sh ../../bin/test_controllers.sh
-	@set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i $@ ; done
+MAKE_DEPS		:=3D $(LIB)

-clean:
-	@set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i $@ ; done
+$(eval $(generic_trunk_target))
Index: testcases/kernel/controllers/Makefile.inc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: testcases/kernel/controllers/Makefile.inc
diff -N testcases/kernel/controllers/Makefile.inc
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ testcases/kernel/controllers/Makefile.inc	12 Jul 2009 05:11:28 -0000
@@ -0,0 +1,44 @@
+#
+#    kernel/controllers test suite Makefile.
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
+#    You should have received a copy of the GNU General Public License alo=
ng
+#    with this program; if not, write to the Free Software Foundation, Inc=
.,
+#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+# Garrett Cooper, July 2009
+#
+
+# DO NOT USE THIS FILE FOR controllers / libcontrollers!!!
+
+top_srcdir		?=3D ../../../..
+
+include $(top_srcdir)/include/mk/master_include.mk
+
+HEADER_FILES		:=3D $(wildcard $(srcdir)/*.h)
+
+LIB			:=3D $(libdir)/libcontrollers.a
+
+LIBDIR			:=3D libcontrollers
+
+# Make the target the real lib so we don't have to deal with rebuilding th=
is
+# every time the dependency is evaluated, like with PHONY rules.
+$(LIB):
+	$(MAKE) -C $(srcdir)/../$(LIBDIR) all
+	$(MAKE) -C $(srcdir)/../$(LIBDIR) install
+
+LDLIBS			+=3D -lcpu_set
+MAKE_DEPS		:=3D $(LIB)
+
+# vim: syntax=3Dmake
Index: testcases/kernel/controllers/cpuset/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/ltp/ltp/testcases/kernel/controllers/cpuset/Makefile,v
retrieving revision 1.3
diff -u -r1.3 Makefile
--- testcases/kernel/controllers/cpuset/Makefile	23 Jun 2009 14:18:16 -0000=
	1.3
+++ testcases/kernel/controllers/cpuset/Makefile	12 Jul 2009 05:11:28 -0000
@@ -1,17 +1,41 @@
-SUBDIRS =3D cpuset_base_ops_test cpuset_lib cpuset_inherit_test
-SUBDIRS +=3D cpuset_exclusive_test cpuset_hierarchy_test cpuset_syscall_te=
st
-SUBDIRS +=3D cpuset_hotplug_test cpuset_load_balance_test
-SUBDIRS +=3D cpuset_memory_pressure_test cpuset_memory_spread_test
-SUBDIRS +=3D cpuset_memory_test
-all:
-	@set -e; \
-	for i in $(SUBDIRS); do $(MAKE) -C $$i $@ ;done;
-
-install:
-	@set -e; \
-	for i in $(SUBDIRS); do $(MAKE) -C $$i install ; done;
-	ln -f run_cpuset_test.sh ../../../bin/run_cpuset_test.sh;
-	chmod +x run_cpuset_test.sh;
+#
+#    kernel/controllers/cpuset testcase suite Makefile.
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
+#    You should have received a copy of the GNU General Public License alo=
ng
+#    with this program; if not, write to the Free Software Foundation, Inc=
.,
+#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+# Garrett Cooper, July 2009
+#

-clean:
-	@set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i clean ; done
+top_srcdir		?=3D ../../../..
+
+include $(top_srcdir)/include/mk/master_include.mk
+
+LIB			:=3D $(libdir)/libcpu_set.a
+
+LIBDIR			:=3D cpuset_lib
+
+FILTER_OUT_DIRS		:=3D $(LIBDIR)
+
+# Make the target the real lib so we don't have to deal with rebuilding th=
is
+# every time the dependency is evaluated, like with PHONY rules.
+$(LIB):
+	$(MAKE) -C $(srcdir)/$(LIBDIR) all
+	$(MAKE) -C $(srcdir)/$(LIBDIR) install
+
+MAKE_DEPS		:=3D $(LIB)
+
+$(eval $(generic_trunk_target))
Index: testcases/kernel/controllers/cpuset/Makefile.inc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: testcases/kernel/controllers/cpuset/Makefile.inc
diff -N testcases/kernel/controllers/cpuset/Makefile.inc
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ testcases/kernel/controllers/cpuset/Makefile.inc	12 Jul 2009 05:11:28 -=
0000
@@ -0,0 +1,45 @@
+#
+#    kernel/controllers/cpuset testcase suite common definitions Makefile.
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
+#    You should have received a copy of the GNU General Public License alo=
ng
+#    with this program; if not, write to the Free Software Foundation, Inc=
.,
+#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+# Garrett Cooper, July 2009
+#
+
+# DO NOT USE THIS FILE FOR cpuset / cpuset_lib!!!
+
+top_srcdir		?=3D ../../../../..
+
+include	$(top_srcdir)/include/mk/master_include.mk
+
+LIB			:=3D $(libdir)/libcpu_set.a
+
+LIBDIR			:=3D cpuset_lib
+
+# Make the target the real lib so we don't have to deal with rebuilding th=
is
+# every time the dependency is evaluated, like with PHONY rules.
+$(LIB):
+	$(MAKE) -C $(srcdir)/../$(LIBDIR) all
+	$(MAKE) -C $(srcdir)/../$(LIBDIR) install
+
+LDLIBS			+=3D -lcpu_set
+MAKE_DEPS		:=3D $(LIB)
+
+# We want to install the bourne scripts -- so let's make that the default.
+INSTALL_TARGETS		?=3D $(wildcard $(srcdir)/*.sh)
+
+# vim: syntax=3Dmake
Index: testcases/kernel/fs/proc/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/ltp/ltp/testcases/kernel/fs/proc/Makefile,v
retrieving revision 1.5
diff -u -r1.5 Makefile
--- testcases/kernel/fs/proc/Makefile	5 Feb 2009 11:18:58 -0000	1.5
+++ testcases/kernel/fs/proc/Makefile	12 Jul 2009 05:11:28 -0000
@@ -16,18 +16,10 @@
 #  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 #

-include ../../../../config.mk
+top_srcdir		?=3D ../../../..

-CFLAGS+=3D	-I../../../../include
-LDLIBS+=3D	-L../../../../lib -lltp $(SELINUX_LIBS)
+include $(top_srcdir)/include/mk/testcases.mk

-SRCS=3D$(wildcard *.c)
-TARGETS=3D$(patsubst %.c,%,$(SRCS))
+LDLIBS			+=3D $(SELINUX_LIBS)

-all: $(TARGETS)
-
-install:
-	@set -e; for i in $(TARGETS) ; do ln -f $$i ../../../bin/$$i ; done ;
-
-clean:
-	rm -f $(TARGETS)
+$(eval $(generic_leaf_target))
Index: testcases/kernel/fs/scsi/ltpscsi/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/ltp/ltp/testcases/kernel/fs/scsi/ltpscsi/Makefile,v
retrieving revision 1.3
diff -u -r1.3 Makefile
--- testcases/kernel/fs/scsi/ltpscsi/Makefile	23 Jun 2009 14:18:17 -0000	1.3
+++ testcases/kernel/fs/scsi/ltpscsi/Makefile	12 Jul 2009 05:11:28 -0000
@@ -1,10 +1,5 @@
 SHELL =3D /bin/sh

-PREFIX=3D/usr/local
-INSTDIR=3D$(DESTDIR)/$(PREFIX)/bin
-MANDIR=3D$(DESTDIR)/$(PREFIX)/man
-
-
 EXECS =3D scsimain

 LARGE_FILE_FLAGS =3D -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64
Index: testcases/kernel/include/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/ltp/ltp/testcases/kernel/include/Makefile,v
retrieving revision 1.7
diff -u -r1.7 Makefile
--- testcases/kernel/include/Makefile	26 Feb 2009 11:32:31 -0000	1.7
+++ testcases/kernel/include/Makefile	12 Jul 2009 05:11:28 -0000
@@ -1,19 +1,38 @@
-all uclinux: ../../../include/linux_syscall_numbers.h
+#
+#    kernel test suite include Makefile.
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
+#    You should have received a copy of the GNU General Public License alo=
ng
+#    with this program; if not, write to the Free Software Foundation, Inc=
.,
+#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+# Garrett Cooper, July 2009
+#
+
+top_srcdir		?=3D ../../..
+
+include $(top_srcdir)/include/mk/master_include.mk

-../../../include/linux_syscall_numbers.h: linux_syscall_numbers.h
-	ln -sf ../testcases/kernel/include/linux_syscall_numbers.h ../../../inclu=
de/
+DEFAULT_GOAL		:=3D install

-clean distclean:
-	rm -f linux_syscall_numbers.h
-	rm -f ../../../include/linux_syscall_numbers.h
+PREINSTALL_DEPS		:=3D regen

-install uclinux_install:
-	@true
+INSTALL_DIR		:=3D $(includedir)

-linux_syscall_numbers.h: *.in regen.sh
-	$(MAKE) regen
+INSTALL_TARGETS		:=3D linux_syscall_numbers.h

 regen:
-	./regen.sh
+	@./regen.sh

-.PHONY: all clean distclean install regen
+$(eval $(generic_leaf_target))
Index: testcases/kernel/io/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/ltp/ltp/testcases/kernel/io/Makefile,v
retrieving revision 1.6
diff -u -r1.6 Makefile
--- testcases/kernel/io/Makefile	29 Dec 2008 11:02:21 -0000	1.6
+++ testcases/kernel/io/Makefile	12 Jul 2009 05:11:28 -0000
@@ -1,10 +1,36 @@
-SUBDIRS =3D direct_io disktest stress_cd stress_floppy writetest aio
+#
+#    kernel/io test suite Makefile.
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
+#    You should have received a copy of the GNU General Public License alo=
ng
+#    with this program; if not, write to the Free Software Foundation, Inc=
.,
+#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+# Garrett Cooper, July 2009
+#

-all:
-	@set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i ; done
+top_srcdir		:=3D ../../..

-install:
-	@set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i install ; done
+include $(top_srcdir)/include/mk/master_include.mk

-clean:
-	@set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i clean ; done
+SUBDIRS 		:=3D direct_io disktest stress_cd stress_floppy \
+			   writetest
+
+# Don't even bother traversing down aio if the system doesn't have -laio
+# support.
+ifneq ($(AIO_LIBS),)
+SUBDIRS			+=3D aio
+endif
+
+$(eval $(generic_trunk_target))
Index: testcases/kernel/io/aio/aio01/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/ltp/ltp/testcases/kernel/io/aio/aio01/Makefile,v
retrieving revision 1.2
diff -u -r1.2 Makefile
--- testcases/kernel/io/aio/aio01/Makefile	28 Jan 2009 06:43:09 -0000	1.2
+++ testcases/kernel/io/aio/aio01/Makefile	12 Jul 2009 05:11:28 -0000
@@ -20,20 +20,11 @@
 # name of file	: Makefile						  #
 # description	: make(1) description file                                #
 ###########################################################################
-include ../../../../../config.mk

-CFLAGS+=3D	-I../../../../../include -Wall
-LOADLIBES+=3D	$(AIO_LIBS) -L../../../../../lib -lltp
+top_srcdir		?=3D ../../../../..

-SRCS=3D$(wildcard *.c)
-TARGETS=3D$(patsubst %.c,%,$(SRCS))
-
-all: $(TARGETS)
-
-install:
-	@set -e; for i in $(TARGETS); do ln -f $$i ../../../../bin/$$i ; done
-
-clean:
-	rm -f $(TARGETS)
+include $(top_srcdir)/include/mk/testcases.mk

+LDLIBS			+=3D $(AIO_LIBS)

+$(eval $(generic_leaf_target))
Index: testcases/kernel/io/aio/aio02/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/ltp/ltp/testcases/kernel/io/aio/aio02/Makefile,v
retrieving revision 1.6
diff -u -r1.6 Makefile
--- testcases/kernel/io/aio/aio02/Makefile	18 Jun 2009 17:06:59 -0000	1.6
+++ testcases/kernel/io/aio/aio02/Makefile	12 Jul 2009 05:11:28 -0000
@@ -1,20 +1,38 @@
-include ../../../../../config.mk
-# foo.
-TEST_SRCS:=3D$(shell find cases/ -name \*.c | sort -n -t/ -k2)
-PROGS:=3D$(patsubst %.c,%,$(TEST_SRCS))
-HARNESS_SRCS:=3Dmain.c
-# io_queue.c
+#
+#    kernel/io/aio/aio2 testcase Makefile.
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
+#    You should have received a copy of the GNU General Public License alo=
ng
+#    with this program; if not, write to the Free Software Foundation, Inc=
.,
+#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+# Garrett Cooper, July 2009
+#

-CFLAGS+=3D-Wall  -g -O -I../../../../../include -Wall
-LDFLAGS+=3D-L../../../../../lib -lltp $(AIO_LIBS)
-#-lpthread -lrt
-all: $(PROGS)
+srcdir			?=3D ../../../../..

-$(PROGS): %: %.c $(HARNESS_SRCS) Makefile
-	$(CC) $(CFLAGS) -DTEST_NAME=3D\"$<\" -o $@ main.c $(LDFLAGS)
+include $(srcdir)/include/mk/testcases.mk

-clean:
-	rm -f $(PROGS) *.o runtests.out rofile wofile rwfile
+LDLIBS			+=3D $(AIO_LIBS)

-install:
+# foo.
+MAKE_TARGETS		:=3D $(patsubst %.c,%,$(wildcard cases/*.c))
+HARNESS_SRCS		:=3D main.c
+# io_queue.c
+
+#-lpthread -lrt
+$(MAKE_TARGETS): %: %.c $(HARNESS_SRCS)
+$(MAKE_TARGETS): CPPFLAGS +=3D -DTEST_NAME=3D\"$(patsubst %.c,%,$(notdir $=
<))\"

+$(eval $(generic_leaf_target))
Index: testcases/kernel/io/stress_floppy/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/ltp/ltp/testcases/kernel/io/stress_floppy/Makefile,v
retrieving revision 1.8
diff -u -r1.8 Makefile
--- testcases/kernel/io/stress_floppy/Makefile	28 Mar 2003 18:27:48 -0000	1=
.8
+++ testcases/kernel/io/stress_floppy/Makefile	12 Jul 2009 05:11:28 -0000
@@ -1,13 +1,35 @@
-all:
+#
+#  Copyright (c) International Business Machines  Corp., 2001
+#
+#  This program is free software;  you can redistribute it and/or modify
+#  it under the terms of the GNU General Public License as published by
+#  the Free Software Foundation; either version 2 of the License, or
+#  (at your option) any later version.
+#
+#  This program is distributed in the hope that it will be useful,
+#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
+#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+#  the GNU General Public License for more details.
+#
+#  You should have received a copy of the GNU General Public License
+#  along with this program;  if not, write to the Free Software
+#  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+#

-install: generate
-	ln -f stress_floppy ../../../bin
-	ln -f *_file ../../../bin
-	cp -rf dumpdir ../../../bin
+top_srcdir		?=3D ../../../..

+include $(top_srcdir)/include/mk/testcases.mk

+CLEAN_TARGETS		:=3D 10*K_file dumpdir
+
+MAKE_TARGETS		:=3D
+
+INSTALL_DEPS		:=3D generate
+# dumpdir's a directory.
+RM			+=3D -r
+
+.PHONY: generate
 generate:
-	./generate.sh
+	@./generate.sh

-clean:
-	rm -rf 10*K_file dumpdir
+$(eval $(generic_leaf_target))
Index: testcases/kernel/security/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/Makefile,v
retrieving revision 1.6
diff -u -r1.6 Makefile
--- testcases/kernel/security/Makefile	28 Apr 2009 07:04:38 -0000	1.6
+++ testcases/kernel/security/Makefile	12 Jul 2009 05:11:28 -0000
@@ -1,12 +1,31 @@
-SUBDIRS =3D mmc_security filecaps integrity cap_bound
+#
+#  Copyright (c) International Business Machines  Corp., 2001
+#
+#  This program is free software;  you can redistribute it and/or modify
+#  it under the terms of the GNU General Public License as published by
+#  the Free Software Foundation; either version 2 of the License, or
+#  (at your option) any later version.
+#
+#  This program is distributed in the hope that it will be useful,
+#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
+#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+#  the GNU General Public License for more details.
+#
+#  You should have received a copy of the GNU General Public License
+#  along with this program;  if not, write to the Free Software
+#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  =
USA
+#

-all:
-	@set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i ; done
+top_srcdir		?=3D ../../..

-install:
-	@set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i install ; done
+include	$(top_srcdir)/include/mk/master_include.mk

-clean:
-	@set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i clean ; done
+OPT_CFLAGS		+=3D -O
+DEBUG_LDFLAGS		+=3D -s

+# There are the inverse directories of the previously incarnation of this
+# Makefile. Don't know if these tests are broken, either at runtime or at
+# compile time.
+FILTER_OUT_DIRS		:=3D digsig selinux-testsuite smack

+$(eval $(generic_trunk_target))
Index: testcases/kernel/security/integrity/ima/src/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/integrity/ima/src/Make=
file,v
retrieving revision 1.1
diff -u -r1.1 Makefile
--- testcases/kernel/security/integrity/ima/src/Makefile	31 Mar 2009
13:58:14 -0000	1.1
+++ testcases/kernel/security/integrity/ima/src/Makefile	12 Jul 2009
05:11:28 -0000
@@ -1,16 +1,37 @@
-include ../../../../../../config.mk
+#
+#    kernel/security/integrity/ima testcase Makefile.
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
+#    You should have received a copy of the GNU General Public License alo=
ng
+#    with this program; if not, write to the Free Software Foundation, Inc=
.,
+#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+# Garrett Cooper, July 2009
+#

-ifeq ($(CRYPTO_LIB),-lcrypto)
-	TARGETS=3Dima_mmap ima_measure ima_boot_aggregate
-	LDLIBS +=3D $(CRYPTO_LIB)
-else
-	TARGETS=3Dima_mmap
+srcdir			?=3D ../../../../../..
+
+include $(srcdir)/include/mk/master_include.mk
+
+ifeq ($(CRYPTO_LIB),)
+LDLIBS			+=3D $(CRYPTO_LIB)
+MAKE_TARGETS		:=3D ima_mmap
 endif

-all: $(TARGETS)
+$(warning $(CRYPTO_LIB))
+$(warning $(MAKE_TARGETS))

-install:
-	@set -e; for i in $(TARGETS); do ln -f $$i ../../../../../bin/$$i; done
+$(eval $(generic_leaf_target))

-clean:
-	rm -f $(TARGETS)
+$(warning $(MAKE_TARGETS))
Index: testcases/kernel/syscalls/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/ltp/ltp/testcases/kernel/syscalls/Makefile,v
retrieving revision 1.63
diff -u -r1.63 Makefile
--- testcases/kernel/syscalls/Makefile	26 Feb 2009 11:37:28 -0000	1.63
+++ testcases/kernel/syscalls/Makefile	12 Jul 2009 05:11:28 -0000
@@ -1,55 +1,34 @@
 #
-#  Copyright (c) International Business Machines  Corp., 2001
+#    testcases/kernel/timers Makefile.
 #
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  =
USA
+#    Copyright (C) 2009, Cisco Systems Inc.
 #
-
-DEBUG_CFLAGS=3D-O
-DEBUG_LDFLAGS=3D-s
-CFLAGS+=3D-I../../include -g -Wall
-LDLIBS+=3D
-EXCLUDE_DIR=3Depoll
-
+#    This program is free software; you can redistribute it and/or modify
+#    it under the terms of the GNU General Public License as published by
+#    the Free Software Foundation; either version 2 of the License, or
+#    (at your option) any later version.
 #
-# Commented this out since there are directories here we don't want
built by default
+#    This program is distributed in the hope that it will be useful,
+#    but WITHOUT ANY WARRANTY; without even the implied warranty of
+#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#    GNU General Public License for more details.
+#
+#    You should have received a copy of the GNU General Public License alo=
ng
+#    with this program; if not, write to the Free Software Foundation, Inc=
.,
+#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+# Garrett Cooper, July 2009
 #
-SUBDIR =3D `ls */Makefile | sed "s/Makefile//g"`
-UCLINUX_SUBDIR =3D `ls */Makefile | sed "s/Makefile//g" | grep -vE
"^fork|epoll|capget|capset|chmod|chown|llseek|nftw|clone|profil|getcontext|=
remap_file_pages"`
-
-all:
-	@set -e; for i in $(SUBDIR); do \
-		$(MAKE) -C $$i  all; \
-	done

-install:
-	@set -e; for i in $(SUBDIR); do \
-		$(MAKE) -C $$i  install; \
-	done
+top_srcdir		?=3D ../../..

-uclinux:
-	@set -e; for i in $(UCLINUX_SUBDIR); do \
-		$(MAKE) -C $$i UCLINUX=3D1 all; \
-	done
+include	$(top_srcdir)/include/mk/master_include.mk

-uclinux_install:
-	@set -e; for i in $(UCLINUX_SUBDIR); do \
-		$(MAKE) -C $$i UCLINUX=3D1 install; \
-	done
+FILTER_OUT_SUBDIRS	:=3D epoll

-clean:
-	@set -e; for i in $(SUBDIR); do \
-		$(MAKE) -C $$i  clean; \
-	done
+ifeq ($(UCLINUX),1)
+FILTER_OUT_SUBDIRS	+=3D capget capset chmod chown clone fork getcontext \
+			   llseek nftw profil remap_file_pages
+endif

+$(eval $(generic_trunk_target))
Index: testcases/kernel/syscalls/eventfd/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/ltp/ltp/testcases/kernel/syscalls/eventfd/Makefile,v
retrieving revision 1.6
diff -u -r1.6 Makefile
--- testcases/kernel/syscalls/eventfd/Makefile	16 Jan 2009 09:03:14 -0000	1=
.6
+++ testcases/kernel/syscalls/eventfd/Makefile	12 Jul 2009 05:11:28 -0000
@@ -16,21 +16,10 @@
 #  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  =
USA
 #

+top_srcdir		?=3D ../../../..

-include ../../../../config.mk
+include $(top_srcdir)/include/mk/testcases.mk

+LDLIBS			+=3D $(AIO_LIBS)

-CFLAGS +=3D -I../../../../include -Wall
-LDLIBS +=3D -L../../../../lib $(AIO_LIBS) -lltp
-
-SRCS    =3D $(wildcard *.c)
-TARGETS =3D $(patsubst %.c, %, $(wildcard *.c))
-
-all: $(TARGETS)
-
-install:
-	@set -e; for i in $(TARGETS); do ln -f $$i ../../../bin/$$i ; done
-
-clean:
-	rm -f $(TARGETS) a.out
-
+$(eval $(generic_leaf_target))
Index: testcases/kernel/syscalls/io_cancel/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/ltp/ltp/testcases/kernel/syscalls/io_cancel/Makefile,v
retrieving revision 1.4
diff -u -r1.4 Makefile
--- testcases/kernel/syscalls/io_cancel/Makefile	20 Jan 2009 10:48:41 -0000=
	1.4
+++ testcases/kernel/syscalls/io_cancel/Makefile	12 Jul 2009 05:11:28 -0000
@@ -20,19 +20,10 @@
 #  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  =
USA
 #

+srcdir			?=3D ../../../..

-include ../../../../config.mk
+include $(srcdir)/include/mk/testcases.mk

-SRCS    =3D $(wildcard *.c)
-TARGETS =3D $(patsubst %.c,%,$(SRCS))
+LDFLAGS			+=3D $(AIO_LIBS)

-CFLAGS +=3D -I../../../../include -Wall
-LDLIBS +=3D $(AIO_LIBS) -L../../../../lib -lltp
-
-all: $(TARGETS)
-
-install:
-	@set -e; for i in $(TARGETS); do ln -f $$i ../../../bin/$$i ; done
-
-clean:
-	rm -f $(TARGETS)
+$(eval $(generic_leaf_target))
Index: testcases/kernel/syscalls/io_destroy/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/ltp/ltp/testcases/kernel/syscalls/io_destroy/Makefile,v
retrieving revision 1.3
diff -u -r1.3 Makefile
--- testcases/kernel/syscalls/io_destroy/Makefile	20 Jan 2009 10:48:41 -000=
0	1.3
+++ testcases/kernel/syscalls/io_destroy/Makefile	12 Jul 2009 05:11:28 -0000
@@ -20,15 +20,15 @@
 #  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  =
USA
 #

+srcdir			?=3D ../../../..

-include ../../../../config.mk
+include $(srcdir)/include/mk/master_include.mk

+CFLAGS 			+=3D -I$(srcdir)/include -Wall
+LDFLAGS			+=3D $(AIO_LIBS) -L$(srcdir)/lib
+LDLIBS			+=3D -lltp

-SRCS    =3D $(wildcard *.c)
-TARGETS =3D $(patsubst %.c,%,$(SRCS))
-
-CFLAGS +=3D -I../../../../include -Wall
-LDLIBS +=3D $(AIO_LIBS) -L../../../../lib -lltp
+TARGETS 		:=3D $(patsubst %.c,%,$(wildcard *.c))

 all: $(TARGETS)

Index: testcases/kernel/syscalls/io_getevents/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/ltp/ltp/testcases/kernel/syscalls/io_getevents/Makefile,v
retrieving revision 1.3
diff -u -r1.3 Makefile
--- testcases/kernel/syscalls/io_getevents/Makefile	20 Jan 2009
10:48:41 -0000	1.3
+++ testcases/kernel/syscalls/io_getevents/Makefile	12 Jul 2009 05:11:28 -0=
000
@@ -20,20 +20,10 @@
 #  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  =
USA
 #

+srcdir			?=3D ../../../..

-include ../../../../config.mk
+include $(srcdir)/include/mk/testcases.mk

+LDFLAGS			+=3D $(AIO_LIBS)

-SRCS    =3D $(wildcard *.c)
-TARGETS =3D $(patsubst %.c,%,$(SRCS))
-
-CFLAGS +=3D -I../../../../include -Wall
-LDLIBS +=3D $(AIO_LIBS) -L../../../../lib -lltp
-
-all: $(TARGETS)
-
-install:
-	@set -e; for i in $(TARGETS); do ln -f $$i ../../../bin/$$i ; done
-
-clean:
-	rm -f $(TARGETS)
+$(eval $(generic_leaf_target))
Index: testcases/kernel/syscalls/io_setup/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/ltp/ltp/testcases/kernel/syscalls/io_setup/Makefile,v
retrieving revision 1.3
diff -u -r1.3 Makefile
--- testcases/kernel/syscalls/io_setup/Makefile	20 Jan 2009 10:48:42 -0000	=
1.3
+++ testcases/kernel/syscalls/io_setup/Makefile	12 Jul 2009 05:11:28 -0000
@@ -20,20 +20,10 @@
 #  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  =
USA
 #

+srcdir			?=3D ../../../..

-include ../../../../config.mk
+include $(srcdir)/include/mk/testcases.mk

+LDFLAGS			+=3D $(AIO_LIBS)

-SRCS    =3D $(wildcard *.c)
-TARGETS =3D $(patsubst %.c,%,$(SRCS))
-
-CFLAGS +=3D -I../../../../include -Wall
-LDLIBS +=3D $(AIO_LIBS) -L../../../../lib -lltp
-
-all: $(TARGETS)
-
-install:
-	@set -e; for i in $(TARGETS); do ln -f $$i ../../../bin/$$i ; done
-
-clean:
-	rm -f $(TARGETS)
+$(eval $(generic_leaf_target))
Index: testcases/kernel/syscalls/io_submit/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/ltp/ltp/testcases/kernel/syscalls/io_submit/Makefile,v
retrieving revision 1.3
diff -u -r1.3 Makefile
--- testcases/kernel/syscalls/io_submit/Makefile	20 Jan 2009 10:48:42 -0000=
	1.3
+++ testcases/kernel/syscalls/io_submit/Makefile	12 Jul 2009 05:11:28 -0000
@@ -20,16 +20,15 @@
 #  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  =
USA
 #

+srcdir			?=3D ../../../..

-include ../../../../config.mk
+include $(srcdir)/include/mk/master_include.mk

+CFLAGS 			+=3D -I$(srcdir)/include -Wall
+LDFLAGS			+=3D $(AIO_LIBS) -L$(srcdir)/lib
+LDLIBS			+=3D -lltp

-SRCS    =3D $(wildcard *.c)
-TARGETS =3D $(patsubst %.c,%,$(SRCS))
-SYSCALL =3D io_submit
-
-CFLAGS +=3D -I../../../../include -Wall
-LDLIBS +=3D $(AIO_LIBS) -L../../../../lib -lltp
+TARGETS 		:=3D $(patsubst %.c,%,$(wildcard *.c))

 all: $(TARGETS)

Index: testcases/kernel/timers/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/ltp/ltp/testcases/kernel/timers/Makefile,v
retrieving revision 1.6
diff -u -r1.6 Makefile
--- testcases/kernel/timers/Makefile	22 Aug 2006 05:14:39 -0000	1.6
+++ testcases/kernel/timers/Makefile	12 Jul 2009 05:11:28 -0000
@@ -1,25 +1,27 @@
 #
-#  Copyright (c) International Business Machines  Corp., 2001
+#    testcases/kernel/timers Makefile.
 #
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  =
USA
+#    Copyright (C) 2009, Cisco Systems, Inc.
 #
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
+#    You should have received a copy of the GNU General Public License alo=
ng
+#    with this program; if not, write to the Free Software Foundation, Inc=
.,
+#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+# Garrett Cooper, July 2009
+#
+
+top_srcdir		?=3D ../../..

-SUBDIRS =3D $(patsubst %/Makefile,%,$(wildcard */Makefile))
+include $(top_srcdir)/include/mk/master_include.mk

-all %::
-	@set -e; \
-	for i in $(SUBDIRS); do \
-		$(MAKE) -C $$i $@; \
-	done
+$(eval $(generic_trunk_target))
Index: testcases/realtime/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/ltp/ltp/testcases/realtime/Makefile,v
retrieving revision 1.1
diff -u -r1.1 Makefile
--- testcases/realtime/Makefile	24 Mar 2008 09:13:49 -0000	1.1
+++ testcases/realtime/Makefile	12 Jul 2009 05:11:28 -0000
@@ -12,4 +12,4 @@

 clean:
 	@set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i clean ; done
-	@rm .config
+	@rm .config *.o
Index: tools/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/ltp/ltp/tools/Makefile,v
retrieving revision 1.11
diff -u -r1.11 Makefile
--- tools/Makefile	19 Aug 2003 14:30:20 -0000	1.11
+++ tools/Makefile	12 Jul 2009 05:11:28 -0000
@@ -1,18 +1,30 @@
-SUBDIRS =3D apicmds genload netpipe-2.4 netpipe-2.4-ipv6 #top-LTP
+#
+#    tools Makefile.
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
+#    You should have received a copy of the GNU General Public License alo=
ng
+#    with this program; if not, write to the Free Software Foundation, Inc=
.,
+#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+# Garrett Cooper, July 2009
+#

-CFLAGS+=3D -Wall -I../include
-LOADLIBES+=3D -L../lib -lltp
+srcdir			?=3D ..

-SRCS=3D$(wildcard *.c)
-TARGETS=3D$(patsubst %.c,%,$(SRCS))
+include $(srcdir)/include/mk/master_include.mk

-all: $(TARGETS)
-	@set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i ; done
+# top-LTP is really broken, apparently.
+FILTER_OUT_DIRS		:=3D top-LTP

-install:
-	@set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i install ; done
-	@set -e; ln -f gethost ../testcases/bin
-
-clean:
-	rm -f $(TARGETS)
-	@set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i clean ; done
+$(eval $(generic_trunk_target))
Index: tools/genload/genload.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: tools/genload/genload.c
diff -N tools/genload/genload.c
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ tools/genload/genload.c	12 Jul 2009 05:11:28 -0000
@@ -0,0 +1,983 @@
+/* A program to put stress on a POSIX system (stress).
+ *
+ * Copyright (C) 2001, 2002 Amos Waterland <awaterl@yahoo.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the F=
ree
+ * Software Foundation; either version 2 of the License, or (at your optio=
n)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but WIT=
HOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License f=
or
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,=
 59
+ * Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include <ctype.h>
+#include <errno.h>
+#include <libgen.h>
+#include <math.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <signal.h>
+#include <time.h>
+#include <unistd.h>
+#include <sys/wait.h>
+
+/* By default, print all messages of severity info and above.  */
+static int global_debug =3D 2;
+
+/* By default, just print warning for non-critical errors.  */
+static int global_ignore =3D 1;
+
+/* By default, retry on non-critical errors every 50ms.  */
+static int global_retry =3D 50000;
+
+/* By default, use this as backoff coefficient for good fork throughput.  =
*/
+static int global_backoff =3D 3000;
+
+/* By default, do not timeout.  */
+static int global_timeout =3D 0;
+
+/* Name of this program */
+static char *global_progname =3D PACKAGE;
+
+/* By default, do not hang after allocating memory.  */
+static int global_vmhang =3D 0;
+
+/* Implemention of runtime-selectable severity message printing.  */
+#define dbg if (global_debug >=3D 3) \
+            fprintf (stdout, "%s: debug: (%d) ", global_progname, __LINE__=
), \
+            fprintf
+#define out if (global_debug >=3D 2) \
+            fprintf (stdout, "%s: info: ", global_progname), \
+            fprintf
+#define wrn if (global_debug >=3D 1) \
+            fprintf (stderr, "%s: warn: (%d) ", global_progname, __LINE__)=
, \
+            fprintf
+#define err if (global_debug >=3D 0) \
+            fprintf (stderr, "%s: error: (%d) ", global_progname, __LINE__=
), \
+            fprintf
+
+/* Implementation of check for option argument correctness.  */
+#define assert_arg(A) \
+          if (++i =3D=3D argc || ((arg =3D argv[i])[0] =3D=3D '-' && \
+              !isdigit ((int)arg[1]) )) \
+            { \
+              err (stderr, "missing argument to option '%s'\n", A); \
+              exit (1); \
+            }
+
+/* Prototypes for utility functions.  */
+int usage (int status);
+int version (int status);
+long long atoll_s (const char *nptr);
+long long atoll_b (const char *nptr);
+
+/* Prototypes for the worker functions.  */
+int hogcpu (long long forks);
+int hogio (long long forks);
+int hogvm (long long forks, long long chunks, long long bytes);
+int hoghdd (long long forks, int clean, long long files, long long bytes);
+
+int
+main (int argc, char **argv)
+{
+  int i, pid, children =3D 0, retval =3D 0;
+  long starttime, stoptime, runtime;
+
+  /* Variables that indicate which options have been selected.  */
+  int do_dryrun =3D 0;
+  int do_timeout =3D 0;
+  int do_cpu =3D 0;               /* Default to 1 fork. */
+  long long do_cpu_forks =3D 1;
+  int do_io =3D 0;                /* Default to 1 fork. */
+  long long do_io_forks =3D 1;
+  int do_vm =3D 0;                /* Default to 1 fork, 1 chunk of 256MB. =
 */
+  long long do_vm_forks =3D 1;
+  long long do_vm_chunks =3D 1;
+  long long do_vm_bytes =3D 256 * 1024 * 1024;
+  int do_hdd =3D 0;               /* Default to 1 fork, clean, 1 file of 1=
GB.  */
+  long long do_hdd_forks =3D 1;
+  int do_hdd_clean =3D 0;
+  long long do_hdd_files =3D 1;
+  long long do_hdd_bytes =3D 1024 * 1024 * 1024;
+
+  /* Record our start time.  */
+  if ((starttime =3D time (NULL)) =3D=3D -1)
+    {
+      err (stderr, "failed to acquire current time\n");
+      exit (1);
+    }
+
+  /* SuSv3 does not define any error conditions for this function.  */
+  global_progname =3D basename (argv[0]);
+
+  /* For portability, parse command line options without getopt_long.  */
+  for (i =3D 1; i < argc; i++)
+    {
+      char *arg =3D argv[i];
+
+      if (strcmp (arg, "--help") =3D=3D 0 || strcmp (arg, "-?") =3D=3D 0)
+        {
+          usage (0);
+        }
+      else if (strcmp (arg, "--version") =3D=3D 0)
+        {
+          version (0);
+        }
+      else if (strcmp (arg, "--verbose") =3D=3D 0 || strcmp (arg, "-v") =
=3D=3D 0)
+        {
+          global_debug =3D 3;
+        }
+      else if (strcmp (arg, "--quiet") =3D=3D 0 || strcmp (arg, "-q") =3D=
=3D 0)
+        {
+          global_debug =3D 0;
+        }
+      else if (strcmp (arg, "--dry-run") =3D=3D 0 || strcmp (arg, "-n") =
=3D=3D 0)
+        {
+          do_dryrun =3D 1;
+        }
+      else if (strcmp (arg, "--no-retry") =3D=3D 0)
+        {
+          global_ignore =3D 0;
+          dbg (stdout, "turning off ignore of non-critical errors");
+        }
+      else if (strcmp (arg, "--retry-delay") =3D=3D 0)
+        {
+          assert_arg ("--retry-delay");
+          global_retry =3D atoll (arg);
+          dbg (stdout, "setting retry delay to %dus\n", global_retry);
+        }
+      else if (strcmp (arg, "--backoff") =3D=3D 0)
+        {
+          assert_arg ("--backoff");
+          global_backoff =3D atoll (arg);
+          if (global_backoff < 0)
+            {
+              err (stderr, "invalid backoff factor: %i\n", global_backoff);
+              exit (1);
+            }
+          dbg (stdout, "setting backoff coeffient to %dus\n", global_backo=
ff);
+        }
+      else if (strcmp (arg, "--timeout") =3D=3D 0 || strcmp (arg, "-t") =
=3D=3D 0)
+        {
+          do_timeout =3D 1;
+          assert_arg ("--timeout");
+          global_timeout =3D atoll_s (arg);
+          dbg (stdout, "setting timeout to %ds\n", global_timeout);
+        }
+      else if (strcmp (arg, "--cpu") =3D=3D 0 || strcmp (arg, "-c") =3D=3D=
 0)
+        {
+          do_cpu =3D 1;
+          assert_arg ("--cpu");
+          do_cpu_forks =3D atoll_b (arg);
+        }
+      else if (strcmp (arg, "--io") =3D=3D 0 || strcmp (arg, "-i") =3D=3D =
0)
+        {
+          do_io =3D 1;
+          assert_arg ("--io");
+          do_io_forks =3D atoll_b (arg);
+        }
+      else if (strcmp (arg, "--vm") =3D=3D 0 || strcmp (arg, "-m") =3D=3D =
0)
+        {
+          do_vm =3D 1;
+          assert_arg ("--vm");
+          do_vm_forks =3D atoll_b (arg);
+        }
+      else if (strcmp (arg, "--vm-chunks") =3D=3D 0)
+        {
+          assert_arg ("--vm-chunks");
+          do_vm_chunks =3D atoll_b (arg);
+        }
+      else if (strcmp (arg, "--vm-bytes") =3D=3D 0)
+        {
+          assert_arg ("--vm-bytes");
+          do_vm_bytes =3D atoll_b (arg);
+        }
+      else if (strcmp (arg, "--vm-hang") =3D=3D 0)
+        {
+          global_vmhang =3D 1;
+        }
+      else if (strcmp (arg, "--hdd") =3D=3D 0 || strcmp (arg, "-d") =3D=3D=
 0)
+        {
+          do_hdd =3D 1;
+          assert_arg ("--hdd");
+          do_hdd_forks =3D atoll_b (arg);
+        }
+      else if (strcmp (arg, "--hdd-noclean") =3D=3D 0)
+        {
+          do_hdd_clean =3D 2;
+        }
+      else if (strcmp (arg, "--hdd-files") =3D=3D 0)
+        {
+          assert_arg ("--hdd-files");
+          do_hdd_files =3D atoll_b (arg);
+        }
+      else if (strcmp (arg, "--hdd-bytes") =3D=3D 0)
+        {
+          assert_arg ("--hdd-bytes");
+          do_hdd_bytes =3D atoll_b (arg);
+        }
+      else
+        {
+          err (stderr, "unrecognized option: %s\n", arg);
+          exit (1);
+        }
+    }
+
+  /* Hog CPU option.  */
+  if (do_cpu)
+    {
+      out (stdout, "dispatching %lli hogcpu forks\n", do_cpu_forks);
+
+      switch (pid =3D fork ())
+        {
+        case 0:                /* child */
+          if (do_dryrun)
+            exit (0);
+          exit (hogcpu (do_cpu_forks));
+        case -1:               /* error */
+          err (stderr, "hogcpu dispatcher fork failed\n");
+          exit (1);
+        default:               /* parent */
+          children++;
+          dbg (stdout, "--> hogcpu dispatcher forked (%i)\n", pid);
+        }
+    }
+
+  /* Hog I/O option.  */
+  if (do_io)
+    {
+      out (stdout, "dispatching %lli hogio forks\n", do_io_forks);
+
+      switch (pid =3D fork ())
+        {
+        case 0:                /* child */
+          if (do_dryrun)
+            exit (0);
+          exit (hogio (do_io_forks));
+        case -1:               /* error */
+          err (stderr, "hogio dispatcher fork failed\n");
+          exit (1);
+        default:               /* parent */
+          children++;
+          dbg (stdout, "--> hogio dispatcher forked (%i)\n", pid);
+        }
+    }
+
+  /* Hog VM option.  */
+  if (do_vm)
+    {
+      out (stdout,
+           "dispatching %lli hogvm forks, each %lli chunks of %lli bytes\n=
",
+           do_vm_forks, do_vm_chunks, do_vm_bytes);
+
+      switch (pid =3D fork ())
+        {
+        case 0:                /* child */
+          if (do_dryrun)
+            exit (0);
+          exit (hogvm (do_vm_forks, do_vm_chunks, do_vm_bytes));
+        case -1:               /* error */
+          err (stderr, "hogvm dispatcher fork failed\n");
+          exit (1);
+        default:               /* parent */
+          children++;
+          dbg (stdout, "--> hogvm dispatcher forked (%i)\n", pid);
+        }
+    }
+
+  /* Hog HDD option.  */
+  if (do_hdd)
+    {
+      out (stdout, "dispatching %lli hoghdd forks, each %lli files of "
+           "%lli bytes\n", do_hdd_forks, do_hdd_files, do_hdd_bytes);
+
+      switch (pid =3D fork ())
+        {
+        case 0:                /* child */
+          if (do_dryrun)
+            exit (0);
+          exit (hoghdd
+                (do_hdd_forks, do_hdd_clean, do_hdd_files, do_hdd_bytes));
+        case -1:               /* error */
+          err (stderr, "hoghdd dispatcher fork failed\n");
+          exit (1);
+        default:               /* parent */
+          children++;
+          dbg (stdout, "--> hoghdd dispatcher forked (%i)\n", pid);
+        }
+    }
+
+  /* We have no work to do, so bail out.  */
+  if (children =3D=3D 0)
+    usage (0);
+
+  /* Wait for our children to exit.  */
+  while (children)
+    {
+      int status, ret;
+
+      if ((pid =3D wait (&status)) > 0)
+        {
+          if ((WIFEXITED (status)) !=3D 0)
+            {
+              if ((ret =3D WEXITSTATUS (status)) !=3D 0)
+                {
+                  err (stderr, "dispatcher %i returned error %i\n", pid, r=
et);
+                  retval +=3D ret;
+                }
+              else
+                {
+                  dbg (stdout, "<-- dispatcher return (%i)\n", pid);
+                }
+            }
+          else
+            {
+              err (stderr, "dispatcher did not exit normally\n");
+              ++retval;
+            }
+
+          --children;
+        }
+      else
+        {
+          dbg (stdout, "wait() returned error: %s\n", strerror (errno));
+          err (stderr, "detected missing dispatcher children\n");
+          ++retval;
+          break;
+        }
+    }
+
+  /* Record our stop time.  */
+  if ((stoptime =3D time (NULL)) =3D=3D -1)
+    {
+      err (stderr, "failed to acquire current time\n");
+      exit (1);
+    }
+
+  /* Calculate our runtime.  */
+  runtime =3D stoptime - starttime;
+
+  /* Print final status message.  */
+  if (retval)
+    {
+      err (stderr, "failed run completed in %lis\n", runtime);
+    }
+  else
+    {
+      out (stdout, "successful run completed in %lis\n", runtime);
+    }
+
+  exit (retval);
+}
+
+int
+usage (int status)
+{
+  char *mesg =3D
+    "`%s' imposes certain types of compute stress on your system\n\n"
+    "Usage: %s [OPTION [ARG]] ...\n\n"
+    " -?, --help            show this help statement\n"
+    "     --version         show version statement\n"
+    " -v, --verbose         be verbose\n"
+    " -q, --quiet           be quiet\n"
+    " -n, --dry-run         show what would have been done\n"
+    "     --no-retry        exit rather than retry non-critical errors\n"
+    "     --retry-delay n   wait n us before continuing past error\n"
+    " -t, --timeout n       timeout after n seconds\n"
+    "     --backoff n       wait for factor of n us before starting work\n"
+    " -c, --cpu n           spawn n procs spinning on sqrt()\n"
+    " -i, --io n            spawn n procs spinning on sync()\n"
+    " -m, --vm n            spawn n procs spinning on malloc()\n"
+    "     --vm-chunks c     malloc c chunks (default is 1)\n"
+    "     --vm-bytes b      malloc chunks of b bytes (default is 256MB)\n"
+    "     --vm-hang         hang in a sleep loop after memory allocated\n"
+    " -d, --hdd n           spawn n procs spinning on write()\n"
+    "     --hdd-noclean     do not unlink file to which random data writte=
n\n"
+    "     --hdd-files f     write to f files (default is 1)\n"
+    "     --hdd-bytes b     write b bytes (default is 1GB)\n\n"
+    "Infinity is denoted with 0.  For -m, -d: n=3D0 means infinite redo,\n"
+    "n<0 means redo abs(n) times. Valid suffixes are m,h,d,y for time;\n"
+    "k,m,g for size.\n\n";
+
+  fprintf (stdout, mesg, global_progname, global_progname);
+
+  if (status <=3D 0)
+    exit (-1 * status);
+
+  return 0;
+}
+
+int
+version (int status)
+{
+  char *mesg =3D "%s %s\n";
+
+  fprintf (stdout, mesg, global_progname, VERSION);
+
+  if (status <=3D 0)
+    exit (-1 * status);
+
+  return 0;
+}
+
+/* Convert a string representation of a number with an optional size suffix
+ * to a long long.
+ */
+long long
+atoll_b (const char *nptr)
+{
+  int pos;
+  char suffix;
+  long long factor =3D 1;
+
+  if ((pos =3D strlen (nptr) - 1) < 0)
+    {
+      err (stderr, "invalid string\n");
+      exit (1);
+    }
+
+  switch (suffix =3D nptr[pos])
+    {
+    case 'k':
+    case 'K':
+      factor =3D 1024;
+      break;
+    case 'm':
+    case 'M':
+      factor =3D 1024 * 1024;
+      break;
+    case 'g':
+    case 'G':
+      factor =3D 1024 * 1024 * 1024;
+      break;
+    default:
+      if (suffix < '0' || suffix > '9')
+        {
+          err (stderr, "unrecognized suffix: %c\n", suffix);
+          exit (1);
+        }
+    }
+
+  factor =3D atoll (nptr) * factor;
+
+  return factor;
+}
+
+/* Convert a string representation of a number with an optional time suffix
+ * to a long long.
+ */
+long long
+atoll_s (const char *nptr)
+{
+  int pos;
+  char suffix;
+  long long factor =3D 1;
+
+  if ((pos =3D strlen (nptr) - 1) < 0)
+    {
+      err (stderr, "invalid string\n");
+      exit (1);
+    }
+
+  switch (suffix =3D nptr[pos])
+    {
+    case 's':
+    case 'S':
+      factor =3D 1;
+      break;
+    case 'm':
+    case 'M':
+      factor =3D 60;
+      break;
+    case 'h':
+    case 'H':
+      factor =3D 60 * 60;
+      break;
+    case 'd':
+    case 'D':
+      factor =3D 60 * 60 * 24;
+      break;
+    case 'y':
+    case 'Y':
+      factor =3D 60 * 60 * 24 * 360;
+      break;
+    default:
+      if (suffix < '0' || suffix > '9')
+        {
+          err (stderr, "unrecognized suffix: %c\n", suffix);
+          exit (1);
+        }
+    }
+
+  factor =3D atoll (nptr) * factor;
+
+  return factor;
+}
+
+int
+hogcpu (long long forks)
+{
+  long long i;
+  double d;
+  int pid, retval =3D 0;
+
+  /* Make local copies of global variables.  */
+  int ignore =3D global_ignore;
+  int retry =3D global_retry;
+  int timeout =3D global_timeout;
+  long backoff =3D global_backoff * forks;
+
+  dbg (stdout, "using backoff sleep of %lius for hogcpu\n", backoff);
+
+  for (i =3D 0; forks =3D=3D 0 || i < forks; i++)
+    {
+      switch (pid =3D fork ())
+        {
+        case 0:                /* child */
+          alarm (timeout);
+
+          /* Use a backoff sleep to ensure we get good fork throughput.  */
+          usleep (backoff);
+
+          while (1)
+            d =3D sqrt (rand ());
+
+          /* This case never falls through; alarm signal can cause exit.  =
*/
+        case -1:               /* error */
+          if (ignore)
+            {
+              ++retval;
+              wrn (stderr, "hogcpu worker fork failed, continuing\n");
+              usleep (retry);
+              continue;
+            }
+
+          err (stderr, "hogcpu worker fork failed\n");
+          return 1;
+        default:               /* parent */
+          dbg (stdout, "--> hogcpu worker forked (%i)\n", pid);
+        }
+    }
+
+  /* Wait for our children to exit.  */
+  while (i)
+    {
+      int status, ret;
+
+      if ((pid =3D wait (&status)) > 0)
+        {
+          if ((WIFEXITED (status)) !=3D 0)
+            {
+              if ((ret =3D WEXITSTATUS (status)) !=3D 0)
+                {
+                  err (stderr, "hogcpu worker %i exited %i\n", pid, ret);
+                  retval +=3D ret;
+                }
+              else
+                {
+                  dbg (stdout, "<-- hogcpu worker exited (%i)\n", pid);
+                }
+            }
+          else
+            {
+              dbg (stdout, "<-- hogcpu worker signalled (%i)\n", pid);
+            }
+
+          --i;
+        }
+      else
+        {
+          dbg (stdout, "wait() returned error: %s\n", strerror (errno));
+          err (stderr, "detected missing hogcpu worker children\n");
+          ++retval;
+          break;
+        }
+    }
+
+  return retval;
+}
+
+int
+hogio (long long forks)
+{
+  long long i;
+  int pid, retval =3D 0;
+
+  /* Make local copies of global variables.  */
+  int ignore =3D global_ignore;
+  int retry =3D global_retry;
+  int timeout =3D global_timeout;
+  long backoff =3D global_backoff * forks;
+
+  dbg (stdout, "using backoff sleep of %lius for hogio\n", backoff);
+
+  for (i =3D 0; forks =3D=3D 0 || i < forks; i++)
+    {
+      switch (pid =3D fork ())
+        {
+        case 0:                /* child */
+          alarm (timeout);
+
+          /* Use a backoff sleep to ensure we get good fork throughput.  */
+          usleep (backoff);
+
+          while (1)
+            sync ();
+
+          /* This case never falls through; alarm signal can cause exit.  =
*/
+        case -1:               /* error */
+          if (ignore)
+            {
+              ++retval;
+              wrn (stderr, "hogio worker fork failed, continuing\n");
+              usleep (retry);
+              continue;
+            }
+
+          err (stderr, "hogio worker fork failed\n");
+          return 1;
+        default:               /* parent */
+          dbg (stdout, "--> hogio worker forked (%i)\n", pid);
+        }
+    }
+
+  /* Wait for our children to exit.  */
+  while (i)
+    {
+      int status, ret;
+
+      if ((pid =3D wait (&status)) > 0)
+        {
+          if ((WIFEXITED (status)) !=3D 0)
+            {
+              if ((ret =3D WEXITSTATUS (status)) !=3D 0)
+                {
+                  err (stderr, "hogio worker %i exited %i\n", pid, ret);
+                  retval +=3D ret;
+                }
+              else
+                {
+                  dbg (stdout, "<-- hogio worker exited (%i)\n", pid);
+                }
+            }
+          else
+            {
+              dbg (stdout, "<-- hogio worker signalled (%i)\n", pid);
+            }
+
+          --i;
+        }
+      else
+        {
+          dbg (stdout, "wait() returned error: %s\n", strerror (errno));
+          err (stderr, "detected missing hogio worker children\n");
+          ++retval;
+          break;
+        }
+    }
+
+  return retval;
+}
+
+int
+hogvm (long long forks, long long chunks, long long bytes)
+{
+  long long i, j, k;
+  int pid, retval =3D 0;
+  char **ptr;
+
+  /* Make local copies of global variables.  */
+  int ignore =3D global_ignore;
+  int retry =3D global_retry;
+  int timeout =3D global_timeout;
+  long backoff =3D global_backoff * forks;
+
+  dbg (stdout, "using backoff sleep of %lius for hogvm\n", backoff);
+
+  if (bytes =3D=3D 0)
+    {
+      /* 512MB is guess at the largest value can than be malloced at once.=
  */
+      bytes =3D 512 * 1024 * 1024;
+    }
+
+  for (i =3D 0; forks =3D=3D 0 || i < forks; i++)
+    {
+      switch (pid =3D fork ())
+        {
+        case 0:                /* child */
+          alarm (timeout);
+
+          /* Use a backoff sleep to ensure we get good fork throughput.  */
+          usleep (backoff);
+
+          while (1)
+            {
+              ptr =3D (char **) malloc ( chunks * 2);
+              for (j =3D 0; chunks =3D=3D 0 || j < chunks; j++)
+                {
+                  if ((ptr[j] =3D (char *) malloc (bytes * sizeof (char))))
+                    {
+                      for (k =3D 0; k < bytes; k++)
+                        ptr[j][k] =3D 'Z';   /* Ensure that COW happens.  =
*/
+                      dbg (stdout, "hogvm worker malloced %lli bytes\n", k=
);
+                    }
+                  else if (ignore)
+                    {
+                      ++retval;
+                      wrn (stderr, "hogvm malloc failed, continuing\n");
+                      usleep (retry);
+                      continue;
+                    }
+                  else
+                    {
+                      ++retval;
+                      err (stderr, "hogvm malloc failed\n");
+                      break;
+                    }
+                }
+              if (global_vmhang && retval =3D=3D 0)
+                {
+                  dbg (stdout, "sleeping forever with allocated memory\n");
+                  while (1)
+                    sleep (1024);
+                }
+              if (retval =3D=3D 0)
+                {
+                  dbg (stdout,
+                       "hogvm worker freeing memory and starting over\n");
+                  for (j =3D 0; chunks =3D=3D 0 || j < chunks; j++) {
+                      free (ptr[j]);
+                  }
+                  free(ptr);
+                  continue;
+                }
+
+              exit (retval);
+            }
+
+          /* This case never falls through; alarm signal can cause exit.  =
*/
+        case -1:               /* error */
+          if (ignore)
+            {
+              ++retval;
+              wrn (stderr, "hogvm worker fork failed, continuing\n");
+              usleep (retry);
+              continue;
+            }
+
+          err (stderr, "hogvm worker fork failed\n");
+          return 1;
+        default:               /* parent */
+          dbg (stdout, "--> hogvm worker forked (%i)\n", pid);
+        }
+    }
+
+  /* Wait for our children to exit.  */
+  while (i)
+    {
+      int status, ret;
+
+      if ((pid =3D wait (&status)) > 0)
+        {
+          if ((WIFEXITED (status)) !=3D 0)
+            {
+              if ((ret =3D WEXITSTATUS (status)) !=3D 0)
+                {
+                  err (stderr, "hogvm worker %i exited %i\n", pid, ret);
+                  retval +=3D ret;
+                }
+              else
+                {
+                  dbg (stdout, "<-- hogvm worker exited (%i)\n", pid);
+                }
+            }
+          else
+            {
+              dbg (stdout, "<-- hogvm worker signalled (%i)\n", pid);
+            }
+
+          --i;
+        }
+      else
+        {
+          dbg (stdout, "wait() returned error: %s\n", strerror (errno));
+          err (stderr, "detected missing hogvm worker children\n");
+          ++retval;
+          break;
+        }
+    }
+
+  return retval;
+}
+
+int
+hoghdd (long long forks, int clean, long long files, long long bytes)
+{
+  long long i, j;
+  int fd, pid, retval =3D 0;
+  int chunk =3D (1024 * 1024) - 1;        /* Minimize slow writing.  */
+  char buff[chunk];
+
+  /* Make local copies of global variables.  */
+  int ignore =3D global_ignore;
+  int retry =3D global_retry;
+  int timeout =3D global_timeout;
+  long backoff =3D global_backoff * forks;
+
+  /* Initialize buffer with some random ASCII data.  */
+  dbg (stdout, "seeding buffer with random data\n");
+  for (i =3D 0; i < chunk - 1; i++)
+    {
+      j =3D rand ();
+      j =3D (j < 0) ? -j : j;
+      j %=3D 95;
+      j +=3D 32;
+      buff[i] =3D j;
+    }
+  buff[i] =3D '\n';
+
+  dbg (stdout, "using backoff sleep of %lius for hoghdd\n", backoff);
+
+  for (i =3D 0; forks =3D=3D 0 || i < forks; i++)
+    {
+      switch (pid =3D fork ())
+        {
+        case 0:                /* child */
+          alarm (timeout);
+
+          /* Use a backoff sleep to ensure we get good fork throughput.  */
+          usleep (backoff);
+
+          while (1)
+            {
+              for (i =3D 0; i < files; i++)
+                {
+                  char name[] =3D "./stress.XXXXXX";
+
+                  if ((fd =3D mkstemp (name)) < 0)
+                    {
+                      perror ("mkstemp");
+                      err (stderr, "mkstemp failed\n");
+                      exit (1);
+                    }
+
+                  if (clean =3D=3D 0)
+                    {
+                      dbg (stdout, "unlinking %s\n", name);
+                      if (unlink (name))
+                        {
+                          err (stderr, "unlink failed\n");
+                          exit (1);
+                        }
+                    }
+
+                  dbg (stdout, "fast writing to %s\n", name);
+                  for (j =3D 0; bytes =3D=3D 0 || j + chunk < bytes; j +=
=3D chunk)
+                    {
+                      if (write (fd, buff, chunk) !=3D chunk)
+                        {
+                          err (stderr, "write failed\n");
+                          exit (1);
+                        }
+                    }
+
+                  dbg (stdout, "slow writing to %s\n", name);
+                  for (; bytes =3D=3D 0 || j < bytes - 1; j++)
+                    {
+                      if (write (fd, "Z", 1) !=3D 1)
+                        {
+                          err (stderr, "write failed\n");
+                          exit (1);
+                        }
+                    }
+                  if (write (fd, "\n", 1) !=3D 1)
+                    {
+                      err (stderr, "write failed\n");
+                      exit (1);
+                    }
+                  ++j;
+
+                  dbg (stdout, "closing %s after writing %lli bytes\n", na=
me,
+                       j);
+                  close (fd);
+
+                  if (clean =3D=3D 1)
+                    {
+                      if (unlink (name))
+                        {
+                          err (stderr, "unlink failed\n");
+                          exit (1);
+                        }
+                    }
+                }
+              if (retval =3D=3D 0)
+                {
+                  dbg (stdout, "hoghdd worker starting over\n");
+                  continue;
+                }
+
+              exit (retval);
+            }
+
+          /* This case never falls through; alarm signal can cause exit.  =
*/
+        case -1:               /* error */
+          if (ignore)
+            {
+              ++retval;
+              wrn (stderr, "hoghdd worker fork failed, continuing\n");
+              usleep (retry);
+              continue;
+            }
+
+          err (stderr, "hoghdd worker fork failed\n");
+          return 1;
+        default:               /* parent */
+          dbg (stdout, "--> hoghdd worker forked (%i)\n", pid);
+        }
+    }
+
+  /* Wait for our children to exit.  */
+  while (i)
+    {
+      int status, ret;
+
+      if ((pid =3D wait (&status)) > 0)
+        {
+          if ((WIFEXITED (status)) !=3D 0)
+            {
+              if ((ret =3D WEXITSTATUS (status)) !=3D 0)
+                {
+                  err (stderr, "hoghdd worker %i exited %i\n", pid, ret);
+                  retval +=3D ret;
+                }
+              else
+                {
+                  dbg (stdout, "<-- hoghdd worker exited (%i)\n", pid);
+                }
+            }
+          else
+            {
+              dbg (stdout, "<-- hoghdd worker signalled (%i)\n", pid);
+            }
+
+          --i;
+        }
+      else
+        {
+          dbg (stdout, "wait() returned error: %s\n", strerror (errno));
+          err (stderr, "detected missing hoghdd worker children\n");
+          ++retval;
+          break;
+        }
+    }
+
+  return retval;
+}
Index: tools/genload/stress.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: tools/genload/stress.c
diff -N tools/genload/stress.c
--- tools/genload/stress.c	26 Jul 2007 12:40:17 -0000	1.3
+++ /dev/null	1 Jan 1970 00:00:00 -0000
@@ -1,983 +0,0 @@
-/* A program to put stress on a POSIX system (stress).
- *
- * Copyright (C) 2001, 2002 Amos Waterland <awaterl@yahoo.com>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the F=
ree
- * Software Foundation; either version 2 of the License, or (at your optio=
n)
- * any later version.
- *
- * This program is distributed in the hope that it will be useful, but WIT=
HOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License f=
or
- * more details.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,=
 59
- * Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-
-#include <ctype.h>
-#include <errno.h>
-#include <libgen.h>
-#include <math.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <string.h>
-#include <signal.h>
-#include <time.h>
-#include <unistd.h>
-#include <sys/wait.h>
-
-/* By default, print all messages of severity info and above.  */
-static int global_debug =3D 2;
-
-/* By default, just print warning for non-critical errors.  */
-static int global_ignore =3D 1;
-
-/* By default, retry on non-critical errors every 50ms.  */
-static int global_retry =3D 50000;
-
-/* By default, use this as backoff coefficient for good fork throughput.  =
*/
-static int global_backoff =3D 3000;
-
-/* By default, do not timeout.  */
-static int global_timeout =3D 0;
-
-/* Name of this program */
-static char *global_progname =3D PACKAGE;
-
-/* By default, do not hang after allocating memory.  */
-static int global_vmhang =3D 0;
-
-/* Implemention of runtime-selectable severity message printing.  */
-#define dbg if (global_debug >=3D 3) \
-            fprintf (stdout, "%s: debug: (%d) ", global_progname, __LINE__=
), \
-            fprintf
-#define out if (global_debug >=3D 2) \
-            fprintf (stdout, "%s: info: ", global_progname), \
-            fprintf
-#define wrn if (global_debug >=3D 1) \
-            fprintf (stderr, "%s: warn: (%d) ", global_progname, __LINE__)=
, \
-            fprintf
-#define err if (global_debug >=3D 0) \
-            fprintf (stderr, "%s: error: (%d) ", global_progname, __LINE__=
), \
-            fprintf
-
-/* Implementation of check for option argument correctness.  */
-#define assert_arg(A) \
-          if (++i =3D=3D argc || ((arg =3D argv[i])[0] =3D=3D '-' && \
-              !isdigit ((int)arg[1]) )) \
-            { \
-              err (stderr, "missing argument to option '%s'\n", A); \
-              exit (1); \
-            }
-
-/* Prototypes for utility functions.  */
-int usage (int status);
-int version (int status);
-long long atoll_s (const char *nptr);
-long long atoll_b (const char *nptr);
-
-/* Prototypes for the worker functions.  */
-int hogcpu (long long forks);
-int hogio (long long forks);
-int hogvm (long long forks, long long chunks, long long bytes);
-int hoghdd (long long forks, int clean, long long files, long long bytes);
-
-int
-main (int argc, char **argv)
-{
-  int i, pid, children =3D 0, retval =3D 0;
-  long starttime, stoptime, runtime;
-
-  /* Variables that indicate which options have been selected.  */
-  int do_dryrun =3D 0;
-  int do_timeout =3D 0;
-  int do_cpu =3D 0;               /* Default to 1 fork. */
-  long long do_cpu_forks =3D 1;
-  int do_io =3D 0;                /* Default to 1 fork. */
-  long long do_io_forks =3D 1;
-  int do_vm =3D 0;                /* Default to 1 fork, 1 chunk of 256MB. =
 */
-  long long do_vm_forks =3D 1;
-  long long do_vm_chunks =3D 1;
-  long long do_vm_bytes =3D 256 * 1024 * 1024;
-  int do_hdd =3D 0;               /* Default to 1 fork, clean, 1 file of 1=
GB.  */
-  long long do_hdd_forks =3D 1;
-  int do_hdd_clean =3D 0;
-  long long do_hdd_files =3D 1;
-  long long do_hdd_bytes =3D 1024 * 1024 * 1024;
-
-  /* Record our start time.  */
-  if ((starttime =3D time (NULL)) =3D=3D -1)
-    {
-      err (stderr, "failed to acquire current time\n");
-      exit (1);
-    }
-
-  /* SuSv3 does not define any error conditions for this function.  */
-  global_progname =3D basename (argv[0]);
-
-  /* For portability, parse command line options without getopt_long.  */
-  for (i =3D 1; i < argc; i++)
-    {
-      char *arg =3D argv[i];
-
-      if (strcmp (arg, "--help") =3D=3D 0 || strcmp (arg, "-?") =3D=3D 0)
-        {
-          usage (0);
-        }
-      else if (strcmp (arg, "--version") =3D=3D 0)
-        {
-          version (0);
-        }
-      else if (strcmp (arg, "--verbose") =3D=3D 0 || strcmp (arg, "-v") =
=3D=3D 0)
-        {
-          global_debug =3D 3;
-        }
-      else if (strcmp (arg, "--quiet") =3D=3D 0 || strcmp (arg, "-q") =3D=
=3D 0)
-        {
-          global_debug =3D 0;
-        }
-      else if (strcmp (arg, "--dry-run") =3D=3D 0 || strcmp (arg, "-n") =
=3D=3D 0)
-        {
-          do_dryrun =3D 1;
-        }
-      else if (strcmp (arg, "--no-retry") =3D=3D 0)
-        {
-          global_ignore =3D 0;
-          dbg (stdout, "turning off ignore of non-critical errors");
-        }
-      else if (strcmp (arg, "--retry-delay") =3D=3D 0)
-        {
-          assert_arg ("--retry-delay");
-          global_retry =3D atoll (arg);
-          dbg (stdout, "setting retry delay to %dus\n", global_retry);
-        }
-      else if (strcmp (arg, "--backoff") =3D=3D 0)
-        {
-          assert_arg ("--backoff");
-          global_backoff =3D atoll (arg);
-          if (global_backoff < 0)
-            {
-              err (stderr, "invalid backoff factor: %i\n", global_backoff);
-              exit (1);
-            }
-          dbg (stdout, "setting backoff coeffient to %dus\n", global_backo=
ff);
-        }
-      else if (strcmp (arg, "--timeout") =3D=3D 0 || strcmp (arg, "-t") =
=3D=3D 0)
-        {
-          do_timeout =3D 1;
-          assert_arg ("--timeout");
-          global_timeout =3D atoll_s (arg);
-          dbg (stdout, "setting timeout to %ds\n", global_timeout);
-        }
-      else if (strcmp (arg, "--cpu") =3D=3D 0 || strcmp (arg, "-c") =3D=3D=
 0)
-        {
-          do_cpu =3D 1;
-          assert_arg ("--cpu");
-          do_cpu_forks =3D atoll_b (arg);
-        }
-      else if (strcmp (arg, "--io") =3D=3D 0 || strcmp (arg, "-i") =3D=3D =
0)
-        {
-          do_io =3D 1;
-          assert_arg ("--io");
-          do_io_forks =3D atoll_b (arg);
-        }
-      else if (strcmp (arg, "--vm") =3D=3D 0 || strcmp (arg, "-m") =3D=3D =
0)
-        {
-          do_vm =3D 1;
-          assert_arg ("--vm");
-          do_vm_forks =3D atoll_b (arg);
-        }
-      else if (strcmp (arg, "--vm-chunks") =3D=3D 0)
-        {
-          assert_arg ("--vm-chunks");
-          do_vm_chunks =3D atoll_b (arg);
-        }
-      else if (strcmp (arg, "--vm-bytes") =3D=3D 0)
-        {
-          assert_arg ("--vm-bytes");
-          do_vm_bytes =3D atoll_b (arg);
-        }
-      else if (strcmp (arg, "--vm-hang") =3D=3D 0)
-        {
-          global_vmhang =3D 1;
-        }
-      else if (strcmp (arg, "--hdd") =3D=3D 0 || strcmp (arg, "-d") =3D=3D=
 0)
-        {
-          do_hdd =3D 1;
-          assert_arg ("--hdd");
-          do_hdd_forks =3D atoll_b (arg);
-        }
-      else if (strcmp (arg, "--hdd-noclean") =3D=3D 0)
-        {
-          do_hdd_clean =3D 2;
-        }
-      else if (strcmp (arg, "--hdd-files") =3D=3D 0)
-        {
-          assert_arg ("--hdd-files");
-          do_hdd_files =3D atoll_b (arg);
-        }
-      else if (strcmp (arg, "--hdd-bytes") =3D=3D 0)
-        {
-          assert_arg ("--hdd-bytes");
-          do_hdd_bytes =3D atoll_b (arg);
-        }
-      else
-        {
-          err (stderr, "unrecognized option: %s\n", arg);
-          exit (1);
-        }
-    }
-
-  /* Hog CPU option.  */
-  if (do_cpu)
-    {
-      out (stdout, "dispatching %lli hogcpu forks\n", do_cpu_forks);
-
-      switch (pid =3D fork ())
-        {
-        case 0:                /* child */
-          if (do_dryrun)
-            exit (0);
-          exit (hogcpu (do_cpu_forks));
-        case -1:               /* error */
-          err (stderr, "hogcpu dispatcher fork failed\n");
-          exit (1);
-        default:               /* parent */
-          children++;
-          dbg (stdout, "--> hogcpu dispatcher forked (%i)\n", pid);
-        }
-    }
-
-  /* Hog I/O option.  */
-  if (do_io)
-    {
-      out (stdout, "dispatching %lli hogio forks\n", do_io_forks);
-
-      switch (pid =3D fork ())
-        {
-        case 0:                /* child */
-          if (do_dryrun)
-            exit (0);
-          exit (hogio (do_io_forks));
-        case -1:               /* error */
-          err (stderr, "hogio dispatcher fork failed\n");
-          exit (1);
-        default:               /* parent */
-          children++;
-          dbg (stdout, "--> hogio dispatcher forked (%i)\n", pid);
-        }
-    }
-
-  /* Hog VM option.  */
-  if (do_vm)
-    {
-      out (stdout,
-           "dispatching %lli hogvm forks, each %lli chunks of %lli bytes\n=
",
-           do_vm_forks, do_vm_chunks, do_vm_bytes);
-
-      switch (pid =3D fork ())
-        {
-        case 0:                /* child */
-          if (do_dryrun)
-            exit (0);
-          exit (hogvm (do_vm_forks, do_vm_chunks, do_vm_bytes));
-        case -1:               /* error */
-          err (stderr, "hogvm dispatcher fork failed\n");
-          exit (1);
-        default:               /* parent */
-          children++;
-          dbg (stdout, "--> hogvm dispatcher forked (%i)\n", pid);
-        }
-    }
-
-  /* Hog HDD option.  */
-  if (do_hdd)
-    {
-      out (stdout, "dispatching %lli hoghdd forks, each %lli files of "
-           "%lli bytes\n", do_hdd_forks, do_hdd_files, do_hdd_bytes);
-
-      switch (pid =3D fork ())
-        {
-        case 0:                /* child */
-          if (do_dryrun)
-            exit (0);
-          exit (hoghdd
-                (do_hdd_forks, do_hdd_clean, do_hdd_files, do_hdd_bytes));
-        case -1:               /* error */
-          err (stderr, "hoghdd dispatcher fork failed\n");
-          exit (1);
-        default:               /* parent */
-          children++;
-          dbg (stdout, "--> hoghdd dispatcher forked (%i)\n", pid);
-        }
-    }
-
-  /* We have no work to do, so bail out.  */
-  if (children =3D=3D 0)
-    usage (0);
-
-  /* Wait for our children to exit.  */
-  while (children)
-    {
-      int status, ret;
-
-      if ((pid =3D wait (&status)) > 0)
-        {
-          if ((WIFEXITED (status)) !=3D 0)
-            {
-              if ((ret =3D WEXITSTATUS (status)) !=3D 0)
-                {
-                  err (stderr, "dispatcher %i returned error %i\n", pid, r=
et);
-                  retval +=3D ret;
-                }
-              else
-                {
-                  dbg (stdout, "<-- dispatcher return (%i)\n", pid);
-                }
-            }
-          else
-            {
-              err (stderr, "dispatcher did not exit normally\n");
-              ++retval;
-            }
-
-          --children;
-        }
-      else
-        {
-          dbg (stdout, "wait() returned error: %s\n", strerror (errno));
-          err (stderr, "detected missing dispatcher children\n");
-          ++retval;
-          break;
-        }
-    }
-
-  /* Record our stop time.  */
-  if ((stoptime =3D time (NULL)) =3D=3D -1)
-    {
-      err (stderr, "failed to acquire current time\n");
-      exit (1);
-    }
-
-  /* Calculate our runtime.  */
-  runtime =3D stoptime - starttime;
-
-  /* Print final status message.  */
-  if (retval)
-    {
-      err (stderr, "failed run completed in %lis\n", runtime);
-    }
-  else
-    {
-      out (stdout, "successful run completed in %lis\n", runtime);
-    }
-
-  exit (retval);
-}
-
-int
-usage (int status)
-{
-  char *mesg =3D
-    "`%s' imposes certain types of compute stress on your system\n\n"
-    "Usage: %s [OPTION [ARG]] ...\n\n"
-    " -?, --help            show this help statement\n"
-    "     --version         show version statement\n"
-    " -v, --verbose         be verbose\n"
-    " -q, --quiet           be quiet\n"
-    " -n, --dry-run         show what would have been done\n"
-    "     --no-retry        exit rather than retry non-critical errors\n"
-    "     --retry-delay n   wait n us before continuing past error\n"
-    " -t, --timeout n       timeout after n seconds\n"
-    "     --backoff n       wait for factor of n us before starting work\n"
-    " -c, --cpu n           spawn n procs spinning on sqrt()\n"
-    " -i, --io n            spawn n procs spinning on sync()\n"
-    " -m, --vm n            spawn n procs spinning on malloc()\n"
-    "     --vm-chunks c     malloc c chunks (default is 1)\n"
-    "     --vm-bytes b      malloc chunks of b bytes (default is 256MB)\n"
-    "     --vm-hang         hang in a sleep loop after memory allocated\n"
-    " -d, --hdd n           spawn n procs spinning on write()\n"
-    "     --hdd-noclean     do not unlink file to which random data writte=
n\n"
-    "     --hdd-files f     write to f files (default is 1)\n"
-    "     --hdd-bytes b     write b bytes (default is 1GB)\n\n"
-    "Infinity is denoted with 0.  For -m, -d: n=3D0 means infinite redo,\n"
-    "n<0 means redo abs(n) times. Valid suffixes are m,h,d,y for time;\n"
-    "k,m,g for size.\n\n";
-
-  fprintf (stdout, mesg, global_progname, global_progname);
-
-  if (status <=3D 0)
-    exit (-1 * status);
-
-  return 0;
-}
-
-int
-version (int status)
-{
-  char *mesg =3D "%s %s\n";
-
-  fprintf (stdout, mesg, global_progname, VERSION);
-
-  if (status <=3D 0)
-    exit (-1 * status);
-
-  return 0;
-}
-
-/* Convert a string representation of a number with an optional size suffix
- * to a long long.
- */
-long long
-atoll_b (const char *nptr)
-{
-  int pos;
-  char suffix;
-  long long factor =3D 1;
-
-  if ((pos =3D strlen (nptr) - 1) < 0)
-    {
-      err (stderr, "invalid string\n");
-      exit (1);
-    }
-
-  switch (suffix =3D nptr[pos])
-    {
-    case 'k':
-    case 'K':
-      factor =3D 1024;
-      break;
-    case 'm':
-    case 'M':
-      factor =3D 1024 * 1024;
-      break;
-    case 'g':
-    case 'G':
-      factor =3D 1024 * 1024 * 1024;
-      break;
-    default:
-      if (suffix < '0' || suffix > '9')
-        {
-          err (stderr, "unrecognized suffix: %c\n", suffix);
-          exit (1);
-        }
-    }
-
-  factor =3D atoll (nptr) * factor;
-
-  return factor;
-}
-
-/* Convert a string representation of a number with an optional time suffix
- * to a long long.
- */
-long long
-atoll_s (const char *nptr)
-{
-  int pos;
-  char suffix;
-  long long factor =3D 1;
-
-  if ((pos =3D strlen (nptr) - 1) < 0)
-    {
-      err (stderr, "invalid string\n");
-      exit (1);
-    }
-
-  switch (suffix =3D nptr[pos])
-    {
-    case 's':
-    case 'S':
-      factor =3D 1;
-      break;
-    case 'm':
-    case 'M':
-      factor =3D 60;
-      break;
-    case 'h':
-    case 'H':
-      factor =3D 60 * 60;
-      break;
-    case 'd':
-    case 'D':
-      factor =3D 60 * 60 * 24;
-      break;
-    case 'y':
-    case 'Y':
-      factor =3D 60 * 60 * 24 * 360;
-      break;
-    default:
-      if (suffix < '0' || suffix > '9')
-        {
-          err (stderr, "unrecognized suffix: %c\n", suffix);
-          exit (1);
-        }
-    }
-
-  factor =3D atoll (nptr) * factor;
-
-  return factor;
-}
-
-int
-hogcpu (long long forks)
-{
-  long long i;
-  double d;
-  int pid, retval =3D 0;
-
-  /* Make local copies of global variables.  */
-  int ignore =3D global_ignore;
-  int retry =3D global_retry;
-  int timeout =3D global_timeout;
-  long backoff =3D global_backoff * forks;
-
-  dbg (stdout, "using backoff sleep of %lius for hogcpu\n", backoff);
-
-  for (i =3D 0; forks =3D=3D 0 || i < forks; i++)
-    {
-      switch (pid =3D fork ())
-        {
-        case 0:                /* child */
-          alarm (timeout);
-
-          /* Use a backoff sleep to ensure we get good fork throughput.  */
-          usleep (backoff);
-
-          while (1)
-            d =3D sqrt (rand ());
-
-          /* This case never falls through; alarm signal can cause exit.  =
*/
-        case -1:               /* error */
-          if (ignore)
-            {
-              ++retval;
-              wrn (stderr, "hogcpu worker fork failed, continuing\n");
-              usleep (retry);
-              continue;
-            }
-
-          err (stderr, "hogcpu worker fork failed\n");
-          return 1;
-        default:               /* parent */
-          dbg (stdout, "--> hogcpu worker forked (%i)\n", pid);
-        }
-    }
-
-  /* Wait for our children to exit.  */
-  while (i)
-    {
-      int status, ret;
-
-      if ((pid =3D wait (&status)) > 0)
-        {
-          if ((WIFEXITED (status)) !=3D 0)
-            {
-              if ((ret =3D WEXITSTATUS (status)) !=3D 0)
-                {
-                  err (stderr, "hogcpu worker %i exited %i\n", pid, ret);
-                  retval +=3D ret;
-                }
-              else
-                {
-                  dbg (stdout, "<-- hogcpu worker exited (%i)\n", pid);
-                }
-            }
-          else
-            {
-              dbg (stdout, "<-- hogcpu worker signalled (%i)\n", pid);
-            }
-
-          --i;
-        }
-      else
-        {
-          dbg (stdout, "wait() returned error: %s\n", strerror (errno));
-          err (stderr, "detected missing hogcpu worker children\n");
-          ++retval;
-          break;
-        }
-    }
-
-  return retval;
-}
-
-int
-hogio (long long forks)
-{
-  long long i;
-  int pid, retval =3D 0;
-
-  /* Make local copies of global variables.  */
-  int ignore =3D global_ignore;
-  int retry =3D global_retry;
-  int timeout =3D global_timeout;
-  long backoff =3D global_backoff * forks;
-
-  dbg (stdout, "using backoff sleep of %lius for hogio\n", backoff);
-
-  for (i =3D 0; forks =3D=3D 0 || i < forks; i++)
-    {
-      switch (pid =3D fork ())
-        {
-        case 0:                /* child */
-          alarm (timeout);
-
-          /* Use a backoff sleep to ensure we get good fork throughput.  */
-          usleep (backoff);
-
-          while (1)
-            sync ();
-
-          /* This case never falls through; alarm signal can cause exit.  =
*/
-        case -1:               /* error */
-          if (ignore)
-            {
-              ++retval;
-              wrn (stderr, "hogio worker fork failed, continuing\n");
-              usleep (retry);
-              continue;
-            }
-
-          err (stderr, "hogio worker fork failed\n");
-          return 1;
-        default:               /* parent */
-          dbg (stdout, "--> hogio worker forked (%i)\n", pid);
-        }
-    }
-
-  /* Wait for our children to exit.  */
-  while (i)
-    {
-      int status, ret;
-
-      if ((pid =3D wait (&status)) > 0)
-        {
-          if ((WIFEXITED (status)) !=3D 0)
-            {
-              if ((ret =3D WEXITSTATUS (status)) !=3D 0)
-                {
-                  err (stderr, "hogio worker %i exited %i\n", pid, ret);
-                  retval +=3D ret;
-                }
-              else
-                {
-                  dbg (stdout, "<-- hogio worker exited (%i)\n", pid);
-                }
-            }
-          else
-            {
-              dbg (stdout, "<-- hogio worker signalled (%i)\n", pid);
-            }
-
-          --i;
-        }
-      else
-        {
-          dbg (stdout, "wait() returned error: %s\n", strerror (errno));
-          err (stderr, "detected missing hogio worker children\n");
-          ++retval;
-          break;
-        }
-    }
-
-  return retval;
-}
-
-int
-hogvm (long long forks, long long chunks, long long bytes)
-{
-  long long i, j, k;
-  int pid, retval =3D 0;
-  char **ptr;
-
-  /* Make local copies of global variables.  */
-  int ignore =3D global_ignore;
-  int retry =3D global_retry;
-  int timeout =3D global_timeout;
-  long backoff =3D global_backoff * forks;
-
-  dbg (stdout, "using backoff sleep of %lius for hogvm\n", backoff);
-
-  if (bytes =3D=3D 0)
-    {
-      /* 512MB is guess at the largest value can than be malloced at once.=
  */
-      bytes =3D 512 * 1024 * 1024;
-    }
-
-  for (i =3D 0; forks =3D=3D 0 || i < forks; i++)
-    {
-      switch (pid =3D fork ())
-        {
-        case 0:                /* child */
-          alarm (timeout);
-
-          /* Use a backoff sleep to ensure we get good fork throughput.  */
-          usleep (backoff);
-
-          while (1)
-            {
-              ptr =3D (char **) malloc ( chunks * 2);
-              for (j =3D 0; chunks =3D=3D 0 || j < chunks; j++)
-                {
-                  if ((ptr[j] =3D (char *) malloc (bytes * sizeof (char))))
-                    {
-                      for (k =3D 0; k < bytes; k++)
-                        ptr[j][k] =3D 'Z';   /* Ensure that COW happens.  =
*/
-                      dbg (stdout, "hogvm worker malloced %lli bytes\n", k=
);
-                    }
-                  else if (ignore)
-                    {
-                      ++retval;
-                      wrn (stderr, "hogvm malloc failed, continuing\n");
-                      usleep (retry);
-                      continue;
-                    }
-                  else
-                    {
-                      ++retval;
-                      err (stderr, "hogvm malloc failed\n");
-                      break;
-                    }
-                }
-              if (global_vmhang && retval =3D=3D 0)
-                {
-                  dbg (stdout, "sleeping forever with allocated memory\n");
-                  while (1)
-                    sleep (1024);
-                }
-              if (retval =3D=3D 0)
-                {
-                  dbg (stdout,
-                       "hogvm worker freeing memory and starting over\n");
-                  for (j =3D 0; chunks =3D=3D 0 || j < chunks; j++) {
-                      free (ptr[j]);
-                  }
-                  free(ptr);
-                  continue;
-                }
-
-              exit (retval);
-            }
-
-          /* This case never falls through; alarm signal can cause exit.  =
*/
-        case -1:               /* error */
-          if (ignore)
-            {
-              ++retval;
-              wrn (stderr, "hogvm worker fork failed, continuing\n");
-              usleep (retry);
-              continue;
-            }
-
-          err (stderr, "hogvm worker fork failed\n");
-          return 1;
-        default:               /* parent */
-          dbg (stdout, "--> hogvm worker forked (%i)\n", pid);
-        }
-    }
-
-  /* Wait for our children to exit.  */
-  while (i)
-    {
-      int status, ret;
-
-      if ((pid =3D wait (&status)) > 0)
-        {
-          if ((WIFEXITED (status)) !=3D 0)
-            {
-              if ((ret =3D WEXITSTATUS (status)) !=3D 0)
-                {
-                  err (stderr, "hogvm worker %i exited %i\n", pid, ret);
-                  retval +=3D ret;
-                }
-              else
-                {
-                  dbg (stdout, "<-- hogvm worker exited (%i)\n", pid);
-                }
-            }
-          else
-            {
-              dbg (stdout, "<-- hogvm worker signalled (%i)\n", pid);
-            }
-
-          --i;
-        }
-      else
-        {
-          dbg (stdout, "wait() returned error: %s\n", strerror (errno));
-          err (stderr, "detected missing hogvm worker children\n");
-          ++retval;
-          break;
-        }
-    }
-
-  return retval;
-}
-
-int
-hoghdd (long long forks, int clean, long long files, long long bytes)
-{
-  long long i, j;
-  int fd, pid, retval =3D 0;
-  int chunk =3D (1024 * 1024) - 1;        /* Minimize slow writing.  */
-  char buff[chunk];
-
-  /* Make local copies of global variables.  */
-  int ignore =3D global_ignore;
-  int retry =3D global_retry;
-  int timeout =3D global_timeout;
-  long backoff =3D global_backoff * forks;
-
-  /* Initialize buffer with some random ASCII data.  */
-  dbg (stdout, "seeding buffer with random data\n");
-  for (i =3D 0; i < chunk - 1; i++)
-    {
-      j =3D rand ();
-      j =3D (j < 0) ? -j : j;
-      j %=3D 95;
-      j +=3D 32;
-      buff[i] =3D j;
-    }
-  buff[i] =3D '\n';
-
-  dbg (stdout, "using backoff sleep of %lius for hoghdd\n", backoff);
-
-  for (i =3D 0; forks =3D=3D 0 || i < forks; i++)
-    {
-      switch (pid =3D fork ())
-        {
-        case 0:                /* child */
-          alarm (timeout);
-
-          /* Use a backoff sleep to ensure we get good fork throughput.  */
-          usleep (backoff);
-
-          while (1)
-            {
-              for (i =3D 0; i < files; i++)
-                {
-                  char name[] =3D "./stress.XXXXXX";
-
-                  if ((fd =3D mkstemp (name)) < 0)
-                    {
-                      perror ("mkstemp");
-                      err (stderr, "mkstemp failed\n");
-                      exit (1);
-                    }
-
-                  if (clean =3D=3D 0)
-                    {
-                      dbg (stdout, "unlinking %s\n", name);
-                      if (unlink (name))
-                        {
-                          err (stderr, "unlink failed\n");
-                          exit (1);
-                        }
-                    }
-
-                  dbg (stdout, "fast writing to %s\n", name);
-                  for (j =3D 0; bytes =3D=3D 0 || j + chunk < bytes; j +=
=3D chunk)
-                    {
-                      if (write (fd, buff, chunk) !=3D chunk)
-                        {
-                          err (stderr, "write failed\n");
-                          exit (1);
-                        }
-                    }
-
-                  dbg (stdout, "slow writing to %s\n", name);
-                  for (; bytes =3D=3D 0 || j < bytes - 1; j++)
-                    {
-                      if (write (fd, "Z", 1) !=3D 1)
-                        {
-                          err (stderr, "write failed\n");
-                          exit (1);
-                        }
-                    }
-                  if (write (fd, "\n", 1) !=3D 1)
-                    {
-                      err (stderr, "write failed\n");
-                      exit (1);
-                    }
-                  ++j;
-
-                  dbg (stdout, "closing %s after writing %lli bytes\n", na=
me,
-                       j);
-                  close (fd);
-
-                  if (clean =3D=3D 1)
-                    {
-                      if (unlink (name))
-                        {
-                          err (stderr, "unlink failed\n");
-                          exit (1);
-                        }
-                    }
-                }
-              if (retval =3D=3D 0)
-                {
-                  dbg (stdout, "hoghdd worker starting over\n");
-                  continue;
-                }
-
-              exit (retval);
-            }
-
-          /* This case never falls through; alarm signal can cause exit.  =
*/
-        case -1:               /* error */
-          if (ignore)
-            {
-              ++retval;
-              wrn (stderr, "hoghdd worker fork failed, continuing\n");
-              usleep (retry);
-              continue;
-            }
-
-          err (stderr, "hoghdd worker fork failed\n");
-          return 1;
-        default:               /* parent */
-          dbg (stdout, "--> hoghdd worker forked (%i)\n", pid);
-        }
-    }
-
-  /* Wait for our children to exit.  */
-  while (i)
-    {
-      int status, ret;
-
-      if ((pid =3D wait (&status)) > 0)
-        {
-          if ((WIFEXITED (status)) !=3D 0)
-            {
-              if ((ret =3D WEXITSTATUS (status)) !=3D 0)
-                {
-                  err (stderr, "hoghdd worker %i exited %i\n", pid, ret);
-                  retval +=3D ret;
-                }
-              else
-                {
-                  dbg (stdout, "<-- hoghdd worker exited (%i)\n", pid);
-                }
-            }
-          else
-            {
-              dbg (stdout, "<-- hoghdd worker signalled (%i)\n", pid);
-            }
-
-          --i;
-        }
-      else
-        {
-          dbg (stdout, "wait() returned error: %s\n", strerror (errno));
-          err (stderr, "detected missing hoghdd worker children\n");
-          ++retval;
-          break;
-        }
-    }
-
-  return retval;
-}
Index: tools/genload/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/ltp/ltp/tools/genload/Makefile,v
retrieving revision 1.4
diff -u -r1.4 Makefile
--- tools/genload/Makefile	29 Sep 2008 16:22:14 -0000	1.4
+++ tools/genload/Makefile	12 Jul 2009 05:11:28 -0000
@@ -1,14 +1,31 @@
-CFLAGS+=3D -DPACKAGE=3D\"stress\" -DVERSION=3D\"0.17pre11\"
+#
+#    tools/genload Makefile.
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
+#    You should have received a copy of the GNU General Public License alo=
ng
+#    with this program; if not, write to the Free Software Foundation, Inc=
.,
+#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+# Garrett Cooper, July 2009
+#

-LDLIBS+=3D -lm
+srcdir		?=3D ../..

-SRCS=3D$(wildcard *.c)
-TARGETS=3D$(patsubst %.c,%,$(SRCS))
+include $(srcdir)/include/mk/master_include.mk

-all: $(TARGETS)
+CFLAGS		+=3D -DPACKAGE=3D\"stress\" -DVERSION=3D\"0.17pre11\"

-install:
-	@ln -f $(TARGETS) ../../testcases/bin/genload
+LDLIBS		+=3D -lm

-clean:
-	rm -fr $(TARGETS)
+$(eval $(generic_leaf_target))

---------------------------------------------------------------------------=
---
Enter the BlackBerry Developer Challenge  =

This is your chance to win up to $100,000 in prizes! For a limited time, =

vendors submitting new applications to BlackBerry App World(TM) will have
the opportunity to enter the BlackBerry Developer Challenge. See full prize=
  =

details at: http://p.sf.net/sfu/Challenge
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
