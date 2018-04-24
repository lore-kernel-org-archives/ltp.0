From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 24 Apr 2018 12:14:29 +0200
Subject: [LTP] [RFC PATCH 1/1] Remove old build scripts
Message-ID: <20180424101429.26799-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

These scripts are from CVS era, expect git://ltp.git.sourceforge.net.
Although they have support for git and testing our make build system
it's important, we use travis and anything important should be moved
there.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
BTW: my wish is to move from custom make build system to automake based.
Why: 'make install' for Open POSIX testsuite is broken (some files are missing)
and due being moved-in as sort of sub-project it's not easy to fix it.
And we use autoconf anyway.


Kind regards,
Petr
---
 testscripts/build/README                           |  71 ------
 testscripts/build/build_test_function.sh           | 243 ---------------------
 testscripts/build/default_runtest_set.awk          |  44 ----
 testscripts/build/ltp-missing-install-files.py     | 116 ----------
 testscripts/build/test_install_in_build_tree.sh    |  47 ----
 .../build/test_install_out_of_build_tree.sh        |  49 -----
 testscripts/build/test_out_of_build_tree.sh        |  51 -----
 7 files changed, 621 deletions(-)
 delete mode 100755 testscripts/build/README
 delete mode 100755 testscripts/build/build_test_function.sh
 delete mode 100755 testscripts/build/default_runtest_set.awk
 delete mode 100755 testscripts/build/ltp-missing-install-files.py
 delete mode 100755 testscripts/build/test_install_in_build_tree.sh
 delete mode 100755 testscripts/build/test_install_out_of_build_tree.sh
 delete mode 100755 testscripts/build/test_out_of_build_tree.sh

diff --git a/testscripts/build/README b/testscripts/build/README
deleted file mode 100755
index e3c3190c0..000000000
--- a/testscripts/build/README
+++ /dev/null
@@ -1,71 +0,0 @@
-This scripts contains any and all scripts which will help in testing the make
-infrastructure.
-
-A brief description is as follows:
-
-Foundation Build Regression Test Scripts:
-
-- build_test_functions.sh	    -	Generic library functions for all
-					pull / build / test scenarios.
-
-There are a total of 3 different positive pull / build / test scenarios that
-have been identified which should be tested on a regular basis, both prior to
-and after commit:
-
-- test_install_in_build_tree.sh     -	Build in srcdir, install in srcdir.
-- test_install_out_of_build_tree.sh -	Build in srcdir, install in
-					rootfs / outside of builddir // srcdir.
-- test_out_of_build_tree.sh         -	Build outside of srcdir, install in
-					rootfs / outside of builddir // srcdir.
-
-The scenarios are defined in include/mk/env_pre.mk (look for BUILD_TREE_STATE).
-
-These scenarios all fulfill the following requirements:
-1. Pull LTP from a predefined SCM (cvs is the only method supported today, but
-   other SCMs could be added when and if support is properly enabled by the
-   project admins).
-2. Apply a custom -p0'able patch if defined with LTP_PATCH (THIS MUST BE THE
-   ABSOLUTE PATH TO THE PATCH!!!).
-3. Configure (make autotools -> configure).
-4. Compile (make all).
-5. Install (make install).
-6. Test (execltp -v).
-
-If you want to add another scenario, please email the list requesting the
-enhancement and we'll see what we can do to accomodate it if the scenario
-functionally makes sense.
-
-You can use a variety of variables to control how things operate, such as:
-
-- CLEAN_TEMPFILES	- !1 - don't clean up the temporary generated files
-			  after the scenario is complete.
-			- 1 - clean up the temporary generated files after the
-			  scenario is complete.
-- MAKEFLAGS		- flags which will be passed directly into make
-			  (please ensure that any and all options passed are
-			  properly escaped beforehand if quoted).
-- TMPDIR		- base temporary directory for all generated and
-			  pulled files.
-
-About the warning...
-
-If you see:
-
-	WARNING: Read the [.../]README before executing this script [...]!
-
-this is by design. I inserted this in the script to intentionally underscore
-the fact that folks need to be very careful when executing this script and
-exercise the following common sense:
-
-1. Use a chroot, or lower-privileged user (preferrably a test user). If there's
-   a bug in the make infrastructure, you could end up eating crow after your
-   build host gets hosed!
-2. Properly chmod your files / directories! You shouldn't have 00777 set on
-   anything that you don't mind parting with, or you are begging for trouble!
-
-   set I_HAVE_READ_THE_README_WARNING to 1 in your environment in order to
-   proceed.
-
-Utilities:
-- ltp-missing-install-files.py - A script which does a real basic first cut at
-				 trying to find missing commands or test files.
diff --git a/testscripts/build/build_test_function.sh b/testscripts/build/build_test_function.sh
deleted file mode 100755
index 9ba558272..000000000
--- a/testscripts/build/build_test_function.sh
+++ /dev/null
@@ -1,243 +0,0 @@
-#!/bin/sh
-#
-#    Copyright (C) 2010, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
-# Ngie Cooper, January 2010
-#
-
-# Temporary directory setup.
-#
-# $TMPDIR - base temporary directory; see mktemp(1) for more details.
-setup_env() {
-	testscript_dir=$(readlink -f "${0%/*}")
-	abspath=$(readlink -f "$testscript_dir/../../scripts/abspath.sh")
-	unset vars
-	for i in tmp_builddir tmp_destdir tmp_prefix tmp_srcdir; do
-		eval "if $i=\$(mktemp -d) ; then vars=\"\$vars \$${i}\"; else echo ${0##*/}: failed to create temporary directory for $i; false; fi"
-	done
-	trap cleanup EXIT
-	cat <<EOF
-========================================
-SUMMARY FOR: $1 Scenario
-========================================
-builddir 	-> $tmp_builddir
-destdir		-> $tmp_destdir
-prefix		-> $tmp_prefix
-srcdir		-> $tmp_srcdir
-========================================
-EOF
-
-}
-
-# Clean up the generated directories.
-#
-# $CLEAN_TEMPFILES - !1 -> don't clean.
-#                  - 1 -> clean.
-cleanup() {
-	if [ "x${CLEAN_TEMPFILES:-0}" = x1 -a "x${TEST_PASSED:-0}" = x1 ] ; then
-		cd /
-		trap '' EXIT
-		rm -Rf $vars
-	fi
-}
-
-# Pull from CVS.
-cvs_pull() {
-
-	export CVSROOT=${CVSROOT:-:pserver:anonymous@ltp.cvs.sf.net:/cvsroot/ltp}
-
-	if ( [ -f ~/.cvspass ] || touch ~/.cvspass ) ; then
-		echo "$CVSROOT" | grep -qv '^:pserver:' || cvs -d$CVSROOT login
-		cvs -z3 export -f -r HEAD ltp && srcdir="$PWD/ltp"
-	fi
-
-}
-
-# Pull from git.
-git_pull() {
-	GIT_REPO=${GIT_REPO:-ltp-dev}
-	git archive master \
-	    --remote=git://ltp.git.sourceforge.net/gitroot/ltp/$GIT_REPO . | tar -xf -
-	srcdir="$PWD"
-}
-
-#
-# Pull a fresh copy of the repository for building.
-#
-# 1 - pull method (currently only cvs is supported, but git may be supported
-#     in the future).
-# 2 - source directory.
-#
-# $LTP_PATCH - -p0 based patch to apply after the pull is complete for
-# precommit testing. THE PATH TO THE PATCH MUST BE ABSOLUTE!
-#
-pull_scm() {
-	cd "$2" && eval "${1}_pull"
-	if [ "x$LTP_PATCH" != x ] ; then
-		patch -p0 < "$LTP_PATCH"
-	fi
-	safe_rm="$srcdir/scripts/safe_rm.sh"
-}
-
-# Verify that clean is sane so peoples' rootfs' / host systems don't get
-# cleaned out by accident [sorry Mitani-san :(...].
-#
-# 1 - source directory
-# 2 - build directory (where to deposit the files produced by configure).
-# 3 - the DESTDIR.
-clean_is_sane() {
-	set +e; for i in distclean ac-maintainer-clean; do
-		output=$(make ${2:+-C "$2"} \
-		     ${1:+-f "$1/Makefile" "top_srcdir=$1"} \
-		     ${2:+"top_builddir=$2"} \
-		     ${MAKEFLAGS} \
-		     DESTDIR="$4" \
-		     RM="$safe_rm" $i)
-		if echo "$output" | egrep 'ERROR : not removing .+ to avoid removing root directory'; then
-			return $?
-		fi
-	done
-}
-
-# Configure a source tree for building.
-#
-# 1 - source directory
-# 2 - build directory (where to deposit the files produced by configure).
-# 3 - the argument to pass to --prefix.
-configure() {
-
-	if [ "x$2" != x ] ; then
-		test -d "$2" || mkdir -p "$2"
-	fi
-
-	make ${1:+-C "$1"} \
-	     ${MAKEFLAGS} \
-	     autotools
-
-	if [ -d "${2:-}" ] ; then
-		cd "$2"
-	fi
-
-	"${1:-.}/configure" ${3:+--prefix=$("$abspath" "$3")}
-
-}
-
-# Build a source tree.
-#
-# 1 - source directory
-# 2 - build directory
-#
-# $MAKEFLAGS - flags to pass directly to gmake(1).
-#
-build() {
-	make ${2:+-C "$2"} \
-	     ${1:+-f "$1/Makefile" "top_srcdir=$1"} \
-	     ${2:+"top_builddir=$2"} \
-	     ${MAKEFLAGS} \
-	     all
-}
-
-# Install the binaries and scripts from a build tree.
-#
-# 1 - source directory
-# 2 - build directory
-# 3 - DESTDIR
-#
-# $MAKEFLAGS - flags to pass directly to gmake(1).
-#
-install_ltp() {
-	make ${2:+-C "$2"} \
-	     ${1:+-f "$1/Makefile" "top_srcdir=$1"} \
-	     ${2:+"top_builddir=$2"} \
-	     ${3:+"DESTDIR=$3"} \
-	     ${MAKEFLAGS} \
-	     install
-}
-
-# Run a test on the installed tree.
-#
-# 1 - install directory for tree, e.g. $(DESTDIR)/$(prefix)
-test_ltp() {
-
-	installdir=$(readlink -f "${1:-.}")
-	test_ltp="$installdir/test_ltp.sh"
-
-	# XXX (garrcoop): I haven't tracked down the root cause for the
-	# issue, but some versions of sed combined with some terminal
-	# configurations cause sed to block waiting for EOF on certain
-	# platforms when executing runltp. Thus, we should effectively close
-	# /dev/stdin before executing runltp via execltp.
-	cat <<EOF > "$test_ltp"
-#!/bin/sh
-
-export AR="$AR"
-export ARFLAGS="$ARFLAGS"
-export CC="$CC"
-export CFLAGS="$CFLAGS"
-export CXX="$CXX"
-export CXXFLAGS="$CXXFLAGS"
-export LD="$LD"
-export LDFLAGS="$LDFLAGS"
-export NM="$NM"
-
-# Optional variables required for some of the testcases.
-for i in AR ARFLAGS CC CFLAGS CXX CXXFLAGS LD LDFLAGS NM; do
-	eval "[ \"x\\\$\$i\" = x ] && unset \$i"
-done
-
-export LTPROOT="$LTPROOT"
-export PATH="\$PATH:$installdir/bin:$PATH"
-
-execltp -l "$installdir" -vv < /dev/null
-EOF
-
-	pre_cmd=
-
-	if [ "x$(id -ru)" != "x0" ] ; then
-
-		# Make sure that environment is translated properly with sudo.
-		if type sudo > /dev/null && sudo -- sh -c 'exit 0' ; then
-			pre_cmd='sudo --'
-		elif type su > /dev/null && groups | grep wheel ; then
-			pre_cmd='su -c'
-		fi
-
-		if [ "x$pre_cmd" != x ] ; then
-			echo "chown -Rf $(id -ru) \"$installdir\"" >> "$test_ltp"
-		fi
-
-	fi
-
-	echo "${0##*/}: will execute test_ltp via ${pre_cmd:+$pre_cmd }$test_ltp"
-	chmod +x "$test_ltp"
-	# XXX (garrcoop): uncommenting the following would work around a
-	# craptacular `bug' with libpam where it outputs the Password: prompt
-	# to /dev/stdout instead of /dev/tty, but it also dumps all output from
-	# runltp, etc to the console instead of a log -- therefore if you do
-	# cat all output to a log, just tail -f it and enter in your password
-	# when necessary.
-	#${pre_cmd} "${test_ltp}" > /dev/tty 2>&1 && TEST_PASSED=1
-	${pre_cmd} "${test_ltp}" && TEST_PASSED=1
-
-}
-
-if [ "x$I_HAVE_READ_THE_README_WARNING" != x1 ] ; then
-	echo 'WARNING: Read '${0%/*}'/README before executing this script ('${0##*/}')!' >&2
-	false
-fi
-
-set -x
diff --git a/testscripts/build/default_runtest_set.awk b/testscripts/build/default_runtest_set.awk
deleted file mode 100755
index dcd4a47cd..000000000
--- a/testscripts/build/default_runtest_set.awk
+++ /dev/null
@@ -1,44 +0,0 @@
-#!/usr/bin/awk -f
-#
-#    Script for determining default runtest set from runltp / runltplite.sh.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
-# Ngie Cooper, July 2009
-#
-# Invoke this awk script like:
-#
-# $0 /path/to/ltp/runltp
-#
-# e.g.
-#
-# $0 /opt/ltp/runltp
-#
-# NOTE: $0 corresponds to the script name.
-#
-
-BEGIN { RS="\n"; FS=" "; }
-# We only care about lines with \/runtest\/ strings in them -- skip the rest.
-/\/runtest\// {
-    split ($0,strs," ")
-    for (str in strs) {
-        if ($str ~ /\${LTPROOT}\/runtest\/([^[:space:]]+)/) {
-            sub (/\${LTPROOT}\/runtest\//, "", $str)
-            print $str
-        }
-    }
-}
diff --git a/testscripts/build/ltp-missing-install-files.py b/testscripts/build/ltp-missing-install-files.py
deleted file mode 100755
index 232028bd1..000000000
--- a/testscripts/build/ltp-missing-install-files.py
+++ /dev/null
@@ -1,116 +0,0 @@
-#!/usr/bin/python3
-#
-#    Script for determining items missing from LTP install based on the output
-#    log provided by runltp[lite.sh].
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
-# Ngie Cooper, July 2009
-#
-# Please invoke this script with --help to determine usage.
-#
-
-from optparse import OptionParser
-import os, re, sys
-
-parser = OptionParser(usage='usage: %prog [options] logfile ...')
-
-parser.add_option('-v', '--verbose', action='store_true', default=False,
-                  dest='verbose', help=('print out successful results as '
-                                        'well as failures'))
-
-opts, logfiles = parser.parse_args()
-
-if not len(logfiles):
-    parser.print_help()
-
-for logfile in logfiles:
-    if not os.access(logfile, os.R_OK):
-        sys.exit("%s not readable" % logfile)
-
-todo_res = [
-    re.compile("""initiation_status="pan\(\d+\): execvp of '(?P<app>.+)' \(tag (?P<tag>\w+)\) failed.+errno:2\s+No such file or directory"""),
-    re.compile("(?P<tag>\S+): line \d+: (?P<app>\S+): No such file or directory"),
-    re.compile("(?P<caller>\S+): (?P<app>\s+): No such file or directory"),
-    re.compile("""tag=(?P<tag>\w+) [\w=]+
-cmdline=.+
-contacts=.+
-analysis=.+
-<<<test_output>>>
-(\S+): (?P<app>\w+): command not found
-<<<execution_status>>>
-initiation_status=.+
-.+termination_id=127.+""")
-]
-
-for logfile in logfiles:
-    fd = open(logfile)
-
-    # Case 1:
-
-    # initiation_status="pan(9908): execvp of 'fs_perms_simpletest.sh' (tag fs_perms) failed.  errno:2  No such file or directory"
-
-    # Case 2:
-
-    # /scratch/ltp-install4/testcases/bin/test_controllers.sh: line 109: /scratch/ltp-install4/testcases/bin/run_cpuset_test.sh: No such file or directory
-
-    # Case 3:
-
-    # gcc: /scratch/ltp-install4/testcases/bin/nmfile2.c: No such file or directory
-
-    # Case 4:
-
-    # <<<test_start>>>
-    # tag=iogen01 stime=1248638309
-    # cmdline="export LTPROOT; rwtest -N iogen01 -i 120s -s read,write -Da -Dv -n 2 500b:doio.f1.$$ 1000b:doio.f2.$$"
-    # contacts=""
-    # analysis=exit
-    # <<<test_output>>>
-    # sh: rwtest: command not found
-    # <<<execution_status>>>
-    # initiation_status="ok"
-    # duration=0 termination_type=exited termination_id=127 corefile=no
-
-    missing_ents = []
-
-    try:
-
-        lines = fd.readlines()
-
-        for line in lines:
-
-            for todo_re in todo_res[:-1]:
-
-                m = todo_re.match(line)
-                if m:
-                    missing_ent = " ".join([m.group(1), m.group('app')])
-                    if missing_ent not in missing_ents:
-                        missing_ents.append(missing_ent)
-                    break
-
-        for m in todo_res[2].finditer("".join(lines)):
-            missing_ent = " ".join([m.group('tag'), m.group('app')])
-            if missing_ent not in missing_ents:
-                missing_ents.append(missing_ent)
-
-    finally:
-        fd.close()
-
-    if len(missing_ents):
-        print("\n".join(["%s: %s" % (os.path.basename(logfile), i) for i in ["Tag | App"] + missing_ents]))
-    elif opts.verbose:
-        print("%s: CONGRATULATIONS -- no missing files found!" % os.path.basename(logfile))
diff --git a/testscripts/build/test_install_in_build_tree.sh b/testscripts/build/test_install_in_build_tree.sh
deleted file mode 100755
index 5626e0ff4..000000000
--- a/testscripts/build/test_install_in_build_tree.sh
+++ /dev/null
@@ -1,47 +0,0 @@
-#!/bin/sh
-#
-#    install in build-tree script.
-#
-#    Copyright (C) 2010, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
-# Ngie Cooper, January 2010
-
-export PATH="${0%/*}:$PATH"
-
-set -e
-. build_test_function.sh
-
-# 0. Setup the environment.
-setup_env "Install in build tree"
-# 1. Pull the SCM.
-pull_scm git "$tmp_srcdir"
-# 2. Pre-configure clean sanity.
-# i.   Is srcdir still there (should be)?
-clean_is_sane
-[ -d "$srcdir" ]
-# 3. Configure.
-configure "$srcdir" "$srcdir" "$srcdir"
-# 4. -->> Compile in-build-tree. <<--
-build
-# 5. -->> Install in-build-tree. <<--
-install_ltp
-# 6. Test.
-test_ltp
-# 7. Post-test clean sanity.
-# i.   Is srcdir still there (should be)?
-clean_is_sane
-[ -d "$srcdir" ]
diff --git a/testscripts/build/test_install_out_of_build_tree.sh b/testscripts/build/test_install_out_of_build_tree.sh
deleted file mode 100755
index 8962e13b1..000000000
--- a/testscripts/build/test_install_out_of_build_tree.sh
+++ /dev/null
@@ -1,49 +0,0 @@
-#!/bin/sh
-#
-#    build in srcdir / install outside build-tree script.
-#
-#    Copyright (C) 2010, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
-# Ngie Cooper, January 2010
-
-export PATH="${0%/*}:$PATH"
-
-set -e
-. build_test_function.sh
-
-# 0. Setup the environment.
-setup_env "Install out of srcdir"
-# 1. Pull the SCM.
-pull_scm git "$tmp_srcdir"
-# 2. Pre-configure clean sanity.
-# i.   Is srcdir still there (should be)?
-# ii.  Is $DESTDIR/$prefix there (shouldn't be)?
-clean_is_sane "$srcdir" "$srcdir" "$("$abspath" "$tmp_destdir/$tmp_prefix")"
-[ -d "$srcdir" -a ! -d "$tmp_destdir/$tmp_prefix" ]
-# 3. Configure.
-configure "$srcdir" "$srcdir" "$tmp_prefix"
-# 4. -->> Compile in-build-tree. <<--
-build "$srcdir" "$srcdir"
-# 5. -->> Install out-of-build-tree. <<--
-install_ltp "$srcdir" "$srcdir" "$tmp_destdir"
-# 6. Test.
-test_ltp "$("$abspath" "$tmp_destdir/$tmp_prefix")"
-# 7. Post-test clean sanity.
-# i.   Is srcdir still there (should be)?
-# ii.  Is $DESTDIR/$prefix there (shouldn't be)?
-clean_is_sane "$srcdir" "$srcdir" "$("$abspath" "$tmp_destdir/$tmp_prefix")"
-[ -d "$srcdir" -a ! -d "$tmp_destdir/$tmp_prefix" ]
diff --git a/testscripts/build/test_out_of_build_tree.sh b/testscripts/build/test_out_of_build_tree.sh
deleted file mode 100755
index 4223b9082..000000000
--- a/testscripts/build/test_out_of_build_tree.sh
+++ /dev/null
@@ -1,51 +0,0 @@
-#!/bin/sh
-#
-#    out-of-build-tree script.
-#
-#    Copyright (C) 2010, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
-# Ngie Cooper, January 2010
-
-export PATH="${0%/*}:$PATH"
-
-set -e
-. build_test_function.sh
-
-# 0. Setup the environment.
-setup_env "Build out of build tree"
-# 1. Pull the SCM.
-pull_scm git "$tmp_srcdir"
-# 2. Pre-configure clean sanity.
-# i.   Is srcdir still there (should be)?
-# ii.  Is builddir there (shouldn't be)?
-# iii. Is $DESTDIR/$prefix there (shouldn't be)?
-clean_is_sane "$srcdir" "$tmp_builddir" "$("$abspath" "$tmp_destdir/$tmp_prefix")"
-[ -d "$srcdir" -a ! -d "$tmp_builddir" -a ! -d "$tmp_destdir/$tmp_prefix" ]
-# 3. Configure.
-configure "$srcdir" "$tmp_builddir" "$tmp_prefix"
-# 4. -->> Compile out-of-build-tree. <<--
-build "$srcdir" "$tmp_builddir"
-# 5. Install.
-install_ltp "$srcdir" "$tmp_builddir" "$tmp_destdir"
-# 6. Test.
-test_ltp "$("$abspath" "$tmp_destdir/$tmp_prefix")"
-# 7. Post-test clean sanity.
-# i.   Is srcdir still there (should be)?
-# ii.  Is builddir there (shouldn't be)?
-# iii. Is $DESTDIR/$prefix there (shouldn't be)?
-clean_is_sane "$srcdir" "$tmp_builddir" "$("$abspath" "$tmp_destdir/$tmp_prefix")"
-[ -d "$srcdir" -a ! -d "$tmp_builddir" -a ! -d "$tmp_destdir/$tmp_prefix" ]
-- 
2.16.3

