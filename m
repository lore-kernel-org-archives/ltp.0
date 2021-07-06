From: Joerg Vehlow <lkml@jv-coder.de>
Date: Tue,  6 Jul 2021 14:04:34 +0200
Subject: [LTP] [PATCH v2 4/4] fs_bind: Remove old framework
In-Reply-To: <20210706120434.867426-1-lkml@jv-coder.de>
References: <20210706120434.867426-1-lkml@jv-coder.de>
Message-ID: <20210706120434.867426-5-lkml@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Joerg Vehlow <joerg.vehlow@aox-tech.de>

After converting the tests to real ltp tests, the old framework
is not required anymore

Signed-off-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>
---
 testcases/kernel/fs/fs_bind/BUGS            |   5 -
 testcases/kernel/fs/fs_bind/CHANGELOG       |  84 ----------
 testcases/kernel/fs/fs_bind/README          | 165 --------------------
 testcases/kernel/fs/fs_bind/TODO            |  11 --
 testcases/kernel/fs/fs_bind/bin/Makefile    |  31 ----
 testcases/kernel/fs/fs_bind/bin/check_prop  |  73 ---------
 testcases/kernel/fs/fs_bind/bin/lockfile    |  84 ----------
 testcases/kernel/fs/fs_bind/bin/makedir     | 101 ------------
 testcases/kernel/fs/fs_bind/bin/nsclone.c   |  68 --------
 testcases/kernel/fs/fs_bind/bin/setup       | 104 ------------
 testcases/kernel/fs/fs_bind/bin/setupnslock |  64 --------
 testcases/kernel/fs/fs_bind/bin/smount.c    |  73 ---------
 12 files changed, 863 deletions(-)
 delete mode 100644 testcases/kernel/fs/fs_bind/BUGS
 delete mode 100644 testcases/kernel/fs/fs_bind/CHANGELOG
 delete mode 100644 testcases/kernel/fs/fs_bind/README
 delete mode 100644 testcases/kernel/fs/fs_bind/TODO
 delete mode 100644 testcases/kernel/fs/fs_bind/bin/Makefile
 delete mode 100755 testcases/kernel/fs/fs_bind/bin/check_prop
 delete mode 100755 testcases/kernel/fs/fs_bind/bin/lockfile
 delete mode 100755 testcases/kernel/fs/fs_bind/bin/makedir
 delete mode 100644 testcases/kernel/fs/fs_bind/bin/nsclone.c
 delete mode 100755 testcases/kernel/fs/fs_bind/bin/setup
 delete mode 100755 testcases/kernel/fs/fs_bind/bin/setupnslock
 delete mode 100644 testcases/kernel/fs/fs_bind/bin/smount.c

diff --git a/testcases/kernel/fs/fs_bind/BUGS b/testcases/kernel/fs/fs_bind/BUGS
deleted file mode 100644
index 51c1e30d9..000000000
--- a/testcases/kernel/fs/fs_bind/BUGS
+++ /dev/null
@@ -1,5 +0,0 @@
-Clone Namespace Tests:
-	Currently the cloneNS test do not accurately report a final success or
-	failure value. To check if a test has passed, view the test output and
-	look at each individual check_prop test, and see if there are any
-	failures.
diff --git a/testcases/kernel/fs/fs_bind/CHANGELOG b/testcases/kernel/fs/fs_bind/CHANGELOG
deleted file mode 100644
index d41598821..000000000
--- a/testcases/kernel/fs/fs_bind/CHANGELOG
+++ /dev/null
@@ -1,84 +0,0 @@
-Remove this file prior to submission??
-------------------------------------
-
-Changes by Matt Helsley <matthltc@us.ibm.com>, March 12th, 2008:
-
-Many (but not all) of these changes are scripted so that I can modify the tests
-quickly by editting the ltp-convert.sh script. It saves a copy of the test foo
-as foo.orig before making any modifications. Currently there's a patch.txt file
-which shows all the changes the script makes.
-
-Moved readme.README to README
-
-Made tests run in the sandbox directory rather than in testcases/working
-
-Moved scripts and executables from testcases/working to bin
-
-Based all non-local paths out of the "$FS_BIND_ROOT" directory rather than
-having a "$path" variable.
-
-Logged mount lists before and after each test, took a diff, and removed the list
-	if they look the same. Otherwise it keeps the two files, reports the
-	diff, cleans up the mounts with a big hammer, and goes onto the next
-	test.
-
-Logged the sandbox contents before and after, took a diff, and removed the
-	logged contents if they look the same. Otherwise it keeps the
-	lists of files and dirs, reports the problem, and cleans up the
-	sandbox. This happens after the mount cleanups otherwise it could fail.
-
-Factored out the "check" function from most tests (still need to work on "childXX" and "parentXX" scripts) and put it into the setup script.
-
-Factored out the "path" variable and pushd bits into the sharedSubtree script.
-
-Added some traps to the test scripts to detect unexpected errors and log them
-
-Switched to LTP infrastructure for the test scripts. The driver scripts however
-are not switched yet (easy to do). I did this by writing some LTP API shims
-rather than try to toss it into ltp-full-XXXXXX.tgz. Then, once everything
-uses LTP we can integrate it.
-
-Made mkdir logdir quiet (restore it??)
-
-Count total tests in a separate loop so we can detect accidentally skipped tests
-
-"test" is a program -- changed variables named "test" to "t" to avoid potential
-	confusion later
-
-Added quotes around paths, variables, and output that may someday contain
-spaces (hopefully never, but..)
-
-Added logdir/errors redirection of stderr
-
-Removed testcases/<Up> script
-
-Removed .c files in testcases/cloneNS which appeared to be unused
-
-Added Makefiles for .c files and for toplevel dir (for LTP integration)
-
-Converted "mmount" to "smount" to match the .c file.
-
-Fixed up nsclone.c and smount.c to compile and do so without warnings.
-	(at least on gcc 4.2.3-1 debian)
-
-Fixed some bugs in the testcases:
-	A couple copy-paste bugs
-	Bugs with uncloneable mounts being bound but the error wasn't expected.
-	A few path bugs.
-
-Added bits to handle commands that are expected to fail (return non-zero)
-	Fixup the return code so that these are trapped properly
-		expected_to_fail && /bin/false || /bin/true
-	Redirected output
-		mount_expected_to_fail 2> /dev/null || result=$?
-
-Added umounts and comments describing cleanup bits which cleanup in case of
-	unexpected mount --move failure for example
-
-Added a BUGS file
-
-Added a CHANGELOG
-
-Added TODO file(s)
-
-Moved the sharedSubtree test to LTPROOT/testscripts and rewrote it for LTP
diff --git a/testcases/kernel/fs/fs_bind/README b/testcases/kernel/fs/fs_bind/README
deleted file mode 100644
index 74b2ee1e7..000000000
--- a/testcases/kernel/fs/fs_bind/README
+++ /dev/null
@@ -1,165 +0,0 @@
-=================================================================
-Test Suite for Bind Mount and Shared Subtree Features in the VFS:
-=================================================================
-Author: Avantika Mathur
-Date: September 16, 2005
-Last update: March 18th, 2008 (by Matt Helsley)
-
-About:
-------
-These tests exercise the Linux Kernel's bind mount and shared subtree
-capabilities. With it administrators may use clear semantics to manage
-complex mount trees on a system.
-
-Bind mount simply allows administrators to make a directory appear in
-two places at once -- somewhat like hard links for files:
-
-# mkdir mnt mnt2
-# mount --bind mnt mnt2
-# touch mnt/a
-# ls mnt2
-a
-
-Note that bind mounts are not recursive. To get a recursive bind mount
-use --rbind.
-
-Another limitation of simple bind mounts is they cannot propagate future binds:
-
-# mkdir mnt mnt2
-# mount --bind mnt mnt2
-# touch mnt/a
-# mkdir mnt/foo
-# ls mnt2
-a foo
-# mkdir sub
-# touch sub/b
-# mount --bind sub /mnt/foo
-# ls mnt/foo
-b
-# ls mnt2/foo
-
-mnt2/foo appears to be empty because the second bind mount did not propagate
-to mnt2. Shared subtrees allow propagation whereas bind mounts do not.
-To enable full administrator control of propagation there are several kinds of
-subtrees:
-	private		[default -- this is a "normal" mount]
-	shared		[propagation goes both ways]
-	slave		[propagation goes one way]
-	unbindable	[cannot --bind and hence cannot share]
-
-For further details on these types of subtrees please see your kernel source's
-Documentation/filesystems/sharedsubtree.txt file.
-
-Building:
----------
-Uses GNU Make. In the root directory type:
-make
-
-Installing:
------------
-Type:
-make install
-
-Cleaning:
----------
-Type:
-make clean
-
-Running:
---------
-run LTPROOT/testscripts/test_fs_bind.sh
-
-
-Testcases:
-----------
-There are multiple testcases testing in each of the following categories,
-testing functionality of different types of mounts, different combinations,
-etc:
--- bind
--- rbind
--- move
--- regression tests
--- clone namespace (currently not run)
-
-
-Directory Structure:
---------------------
-In the root directory of the suite there are scripts to execute the whole test suite. Logged results are stored in LTPROOT/results/fs_bind. PASS/FAIL
-indications are passed to the LTP API and logged in the results directory too.
-
-Basic tests of bind and move mounts are part of the test_fs_bind.sh test
-script itself. These are prerequisites for the more the complicated tests.
-The bind, rbind, and move directories contain tests for bind, rbind, move in
-combination with the various kinds of subtrees. The regression and cloneNS
-directories perform basic regression tests and combine some of the tests with
-mount namespaces respectively.
-
-The bin directory contains scripts used by each of the testcases for
-common setup, creating, and comparing mounts.
-
-Running the Test Suite:
------------------------
-To run the entire testsuite run:
-test_fs_bind.sh
-
-Log directories where the results are stored in LTPROOT/results/fs_bind
-
-Reading the Test Suite Results:
--------------------------------
-Test suite results are logged, by default, in the LTPROOT/results/fs_bind
-directory. Its structure is:
-fs_bind-\
-	|-> errors		 (stderr of main test suite script itself)
-	|-> summary		 (stdout of main test suite script itself)
-	|-move--\
-	|	|->test01-\	(logs of test01)
-	|	|	  |-> log		(stdout)
-	|	|	  |-> err		(stderr)
-	|	|	  |-> mtab.before
-	|	|	  |-> mtab.after
-	|	|	  |-> proc_mounts.before
-	|	|	  |-> proc_mounts.after
-	|	|	  |-> files.before	(files  before running)
-	|	|	  |-> dirs.before	(dirs   before running)
-	|	|	  |-> files.after	(files  after  running)
-	|	|	  \-> dirs.after	(dirs   after  running)
-	|	|->test02-\
-	|	|	  |
-	|	...	  ...
-	|-rbind--\
-	|        |-->
-	...       ...
-
-An testXX/err file will only be left for those tests that had errors and
-stderr was non-empty. mounts.*, files.*, and dirs.* files will be left for
-tests that appear to have broken cleanup sections. The test_fs_bind.sh
-script robustly handles cleanup so, unless the tests are run individually, this
-is not an issue that prevents testing from completing successfully nor does it
-interfere with test results.
-
-These files make it easy to determine what happened during a given test.
-It's easy to see which tests need to be debugged and which do not. It also
-makes it easy to aggregate output or trace sandbox dirtying from test to test.
-
-Running individual Tests:
--------------------------
-Currently tests cannot be run individually because there are several important
-LTP environment dependencies. Some of them are documented below:
-	LTP test script environment variables:
-		LTPROOT
-		TCID
-		TST_TOTAL
-		TST_COUNT
-	LTP commands/functions:
-		tst_resm
-		tst_brkm
-		tst_exit
-	LTP contents:
-		LTPROOT/testcases/bin
-
-It's important to note that the individual test scripts use the current working
-directory extensively but never exit it. This may allow the tests to be run
-individually once the above LTP environment dependencies are resolved.
-Lastly none of the logging or debugging information will appear in the
-LTPROOT/results/fs_bind directory when tests are invoked individually since
-those are collected by the test_fs_bind.sh script.
diff --git a/testcases/kernel/fs/fs_bind/TODO b/testcases/kernel/fs/fs_bind/TODO
deleted file mode 100644
index 1730148ef..000000000
--- a/testcases/kernel/fs/fs_bind/TODO
+++ /dev/null
@@ -1,11 +0,0 @@
-Consider replacing long invocations
-	(replace "$FS_BIND_ROOT/bin/makedir") with something shorter).
-
-Factor out common bits of setup, setupnslock, and lockfile
-
-Rename smount to something more meaningful? (bind_mount ?)
-
-Check for leaks of vfsmount structs by diffing vfs slab cache obj numbers
-	(after -before)
-
-The cloneNS testcases need to be checked and tested -- consider them expiremental. (at least as of March 2008)
diff --git a/testcases/kernel/fs/fs_bind/bin/Makefile b/testcases/kernel/fs/fs_bind/bin/Makefile
deleted file mode 100644
index 2c09a286d..000000000
--- a/testcases/kernel/fs/fs_bind/bin/Makefile
+++ /dev/null
@@ -1,31 +0,0 @@
-#
-#    testcases/kernel/fs/fs_bind/bin Makefile.
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
-# Ngie Cooper, September 2009
-#
-
-top_srcdir		?= ../../../../..
-
-include $(top_srcdir)/include/mk/testcases.mk
-
-INSTALL_DIR		:= $(prefix)/testcases/bin/fs_bind/bin
-
-INSTALL_TARGETS		:= check_prop lockfile makedir setup setupnslock
-
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/fs/fs_bind/bin/check_prop b/testcases/kernel/fs/fs_bind/bin/check_prop
deleted file mode 100755
index 07da8ea28..000000000
--- a/testcases/kernel/fs/fs_bind/bin/check_prop
+++ /dev/null
@@ -1,73 +0,0 @@
-#!/bin/bash
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-reverse=0
-while getopts "n" args $OPTIONS
-do
-	case "$args" in
-        n)      reverse=1
-		shift
-                ;;
- 	esac
-done
-
-if [ $reverse -eq 1 ]
-then
-	echo Check No Propagation $*
-else
-	echo Check Propagation $*
-fi
-
-dir1="$1"
-shift
-
-for dir2 in "$@"
-do
-	# compare adjacent pairs of directory trees
-
-	echo "Checking \"$dir1\" \"$dir2\""
-	diff -r "$dir1" "$dir2" 2> /dev/null
-
-	if [ $? -ne 0 ]
-	then
-		if [ $reverse -eq 1 ]
-		then
-			echo Successful
-			echo "---------"
-			exit 0
-		else
-			echo "FAILED"
-			echo "---------"
-                	exit 1
-		fi
-        fi
-        dir1="$dir2"
-done
-
-if [ $reverse -eq 1 ]
-then
-	echo FAILED
-	echo "---------"
-	exit -1
-else
-	echo Successful
-	echo "---------"
-	exit 0
-fi
diff --git a/testcases/kernel/fs/fs_bind/bin/lockfile b/testcases/kernel/fs/fs_bind/bin/lockfile
deleted file mode 100755
index 93d4d81a9..000000000
--- a/testcases/kernel/fs/fs_bind/bin/lockfile
+++ /dev/null
@@ -1,84 +0,0 @@
-#!/bin/bash
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Ram Pai (linuxram@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-
-lockfile="/.nslock"
-SUCCESS=0
-FAIL=1
-otherpid=
-startparent()
-{
-	rm -f $lockfile
-	echo $$ >| ${lockfile}parent
-	while [ 1 ]
-	do
-		otherpid="$(cat ${lockfile}child 2> /dev/null)"
-		if [ -n "$otherpid" -a -d /proc/$otherpid ]
-		then
-			return
-		fi
-	done
-}
-
-startchild()
-{
-	rm -f $lockfile
-	echo $$ >| ${lockfile}child
-	while [ 1 ]
-	do
-		otherpid="$(cat ${lockfile}parent 2> /dev/null)"
-		if [ -n "$otherpid" -a -d /proc/$otherpid ]
-		then
-			return
-		fi
-	done
-}
-
-iamgoingahead()
-{
-	while [ 1 ]
-	do
-		if [ ! -d /proc/$otherpid ]
-		then
-			return $FAIL
-		fi
-		str=`cat $lockfile 2> /dev/null`
-		pid=$(echo $str | awk '{print $1}')
-		error=$(echo $str | awk '{print $2}')
-		if [ "$pid" == "$$" ]
-		then
-			return $error
-		fi
-		sleep 1
-	done
-}
-
-
-goahead()
-{
-	set -x
-	ret=$SUCCESS
-	if [ -n "$1" ]
-	then
-		ret=$1
-	fi
-	echo "$otherpid $ret" >| $lockfile
-	set +x
-}
diff --git a/testcases/kernel/fs/fs_bind/bin/makedir b/testcases/kernel/fs/fs_bind/bin/makedir
deleted file mode 100755
index 7c0766a1b..000000000
--- a/testcases/kernel/fs/fs_bind/bin/makedir
+++ /dev/null
@@ -1,101 +0,0 @@
-#!/bin/bash
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-mflags=""
-#mflags="-n" # Don't futz with mtab
-
-flag=y
-while getopts "n" arg "$@"
-do
-        case "$arg" in
-        n)      flag=n
-                shift
-                ;;
-        esac
-done
-
-bind_type="$1"
-dir="$2"
-
-
-if [ ! -d "$dir" ]
-then
-	if [ -e "$dir" ]; then
-		echo "ERROR: a file by the name \"$dir\" exists"
-		exit 1
-	fi
-	mkdir -p "$dir"
-	echo "mkdir -p \"$dir\""
-fi
-
-
-if [ "$flag" = "y" ] && [ "$bind_type" != slave ]
-then
-	mount $mflags --bind "$dir" "$dir" || exit $?
-	echo "mount $mflags --bind \"$dir\" \"$dir\""
-fi
-
-# Try to use native mount, else fallback to included smount binary
-case "$bind_type" in
-   share)
-   	echo "mount $mflags --make-rshared \"$dir\""
-	mount $mflags --make-rshared "$dir" 2> /dev/null || \
-	smount "$dir" rshared || exit $?
-      	;;
-   priv)
-   	echo "mount $mflags --make-rprivate \"$dir\""
-	mount $mflags --make-rprivate "$dir" 2> /dev/null || \
-	smount "$dir" rprivate || exit $?
-      	;;
-   slave)
-   	echo "mount $mflags --make-rslave \"$dir\""
-	mount $mflags --make-rslave "$dir" 2> /dev/null || \
-	smount "$dir" rslave || exit $?
-      	;;
-   unclone)
-   	echo "mount $mflags --make-runbindable \"$dir\""
-	mount $mflags --make-runbindable "$dir" 2> /dev/null || \
-	smount "$dir" runclone || exit $?
-      	;;
-   nshare)
-   	echo "mount $mflags --make-shared \"$dir\""
-	mount $mflags --make-shared "$dir" 2> /dev/null || \
-	smount "$dir" shared || exit $?
-      	;;
-   npriv)
-   	echo "mount $mflags --make-private \"$dir\""
-	mount $mflags --make-private "$dir" 2> /dev/null || \
-	smount "$dir" private || exit $?
-      	;;
-   nslave)
-   	echo "mount $mflags --make-slave \"$dir\""
-	mount $mflags --make-slave "$dir" 2> /dev/null || \
-	smount "$dir" slave || exit $?
-      	;;
-   nunclone)
-   	echo "mount $mflags --make-unbindable \"$dir\""
-	mount $mflags --make-unbindable "$dir" 2> /dev/null || \
-	smount "$dir" unclone || exit $?
-      	;;
-   *)
-   	echo "$0: unrecognized bind type (1st arg): $bind_type" 1>&2
-	exit 1
-	;;
-esac
diff --git a/testcases/kernel/fs/fs_bind/bin/nsclone.c b/testcases/kernel/fs/fs_bind/bin/nsclone.c
deleted file mode 100644
index 36ae874db..000000000
--- a/testcases/kernel/fs/fs_bind/bin/nsclone.c
+++ /dev/null
@@ -1,68 +0,0 @@
-/*
- * Copyright (c) International Business Machines  Corp., 2005
- * Author: Ram Pai (linuxram@us.ibm.com)
- *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2.1 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-
-#define _GNU_SOURCE
-
-#include <stdlib.h>
-#include <stdio.h>
-#include <string.h>
-#include <sched.h>
-#include <signal.h>
-#include <unistd.h>
-#include "test.h"
-#include <sys/types.h>
-#include <sys/wait.h>
-
-int myfunc(void *arg)
-{
-	return system(arg);
-}
-
-static void usage(char *cmd)
-{
-	printf("%s  child_script parent_script\n", cmd);
-}
-
-int main(int argc, char *argv[])
-{
-	char *child_cmd;
-	char *parent_cmd;
-	int ret = 0, childret = 0;
-
-	if (argc < 3) {
-		usage(argv[0]);
-		exit(1);
-	}
-
-	child_cmd = (char *)strdup(argv[2]);
-	parent_cmd = (char *)strdup(argv[1]);
-
-	printf("1\n");
-	ret = ltp_clone_quick(CLONE_NEWNS | SIGCHLD, myfunc, (void *)child_cmd);
-	if (ret != -1) {
-		system(parent_cmd);
-		wait(&childret);
-	} else {
-		fprintf(stderr, "clone failed\n");
-	}
-	if (ret || !WIFEXITED(childret)) {
-		exit(1);
-	}
-	exit(0);
-}
diff --git a/testcases/kernel/fs/fs_bind/bin/setup b/testcases/kernel/fs/fs_bind/bin/setup
deleted file mode 100755
index 4e30ef42b..000000000
--- a/testcases/kernel/fs/fs_bind/bin/setup
+++ /dev/null
@@ -1,104 +0,0 @@
-#!/bin/bash -v
-
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-
-disk1=disk1
-disk2=disk2
-disk3=disk3
-disk4=disk4
-fs=ext3
-
-mkdir -p $disk1 $disk2 $disk3 $disk4
-
-
-
-rm -rf $disk1/* $disk2/* $disk3/* $disk4/*
-
-mkdir $disk1/a $disk1/b $disk1/c
-mkdir $disk2/d $disk2/e $disk2/f
-mkdir $disk3/g $disk3/h $disk3/i
-mkdir $disk4/j $disk4/k $disk4/l
-
-lockfile="/.nslock"
-otherpid=
-startparent()
-{
-        rm -f $lockfile
-        echo $$ >| ${lockfile}parent
-        while [ 1 ]
-        do
-                otherpid="$(cat ${lockfile}child 2> /dev/null)"
-                if [ -n "$otherpid" -a -d /proc/$otherpid ]
-                then
-                        return
-                fi
-        done
-}
-
-
-startchild()
-{
-        rm -f $lockfile
-        echo $$ >| ${lockfile}child
-        while [ 1 ]
-        do
-                otherpid="$(cat ${lockfile}parent 2> /dev/null)"
-                if [ -n "$otherpid" -a -d /proc/$otherpid ]
-                then
-                        return
-                fi
-        done
-}
-
-iamgoingahead()
-{
-        while [ 1 ]
-        do
-                pid=`cat $lockfile 2> /dev/null`
-                if [ "$pid" == "$$" ]
-                then
-                        return
-                fi
-                sleep 1
-        done
-}
-
-
-goahead()
-{
-        set -x
-        echo $otherpid > $lockfile
-        set +x
-}
-
-
-check(){
-	"${FS_BIND_ROOT}/bin/check_prop" $*
-	ret=$?
-	if [ $ret -ne 0 ]; then
-		result=$ret
-	fi
-}
-export result=0
-
-cleanup(){
-	rm -rf "disk"*
-}
diff --git a/testcases/kernel/fs/fs_bind/bin/setupnslock b/testcases/kernel/fs/fs_bind/bin/setupnslock
deleted file mode 100755
index e35927b69..000000000
--- a/testcases/kernel/fs/fs_bind/bin/setupnslock
+++ /dev/null
@@ -1,64 +0,0 @@
-#!/bin/bash
-
-lockfile="/.nslock"
-SUCCESS=0
-FAIL=1
-otherpid=
-startparent()
-{
-        rm -f $lockfile
-        echo $$ >| ${lockfile}parent
-        while [ 1 ]
-        do
-                otherpid="$(cat ${lockfile}child 2> /dev/null)"
-                if [ -n "$otherpid" -a -d /proc/$otherpid ]
-                then
-                        return
-                fi
-        done
-}
-
-startchild()
-{
-        rm -f $lockfile
-        echo $$ >| ${lockfile}child
-        while [ 1 ]
-        do
-                otherpid="$(cat ${lockfile}parent 2> /dev/null)"
-                if [ -n "$otherpid" -a -d /proc/$otherpid ]
-                then
-                        return
-                fi
-        done
-}
-
-iamgoingahead()
-{
-        while [ 1 ]
-        do
-                if [ ! -d /proc/$otherpid ]
-                then
-                        return $FAIL
-                fi
-                str=`cat $lockfile 2> /dev/null`
-                pid=$(echo $str | awk '{print $1}')
-                error=$(echo $str | awk '{print $2}')
-                if [ "$pid" == "$$" ]
-                then
-                        return $error
-                fi
-                sleep 1
-        done
-}
-
-goahead()
-{
-        set -x
-        ret=$SUCCESS
-        if [ -n "$1" ]
-        then
-                ret=$1
-        fi
-        echo "$otherpid $ret" >| $lockfile
-        set +x
-}
diff --git a/testcases/kernel/fs/fs_bind/bin/smount.c b/testcases/kernel/fs/fs_bind/bin/smount.c
deleted file mode 100644
index 9484687ee..000000000
--- a/testcases/kernel/fs/fs_bind/bin/smount.c
+++ /dev/null
@@ -1,73 +0,0 @@
-//
-//this code was developed my Miklos Szeredi <miklos@szeredi.hu>
-//and modified by Ram Pai <linuxram@us.ibm.com>
-// sample usage:
-//              newmount /tmp shared
-//
-#include <stdio.h>
-#include <stdlib.h>
-#include <string.h>
-
-#include <unistd.h>
-#include <sys/mount.h>
-#include <sys/fsuid.h>
-
-#ifndef MS_REC
-#define MS_REC		0x4000	/* 16384: Recursive loopback */
-#endif
-
-#ifndef MS_SHARED
-#define MS_SHARED		1<<20	/* Shared */
-#endif
-
-#ifndef MS_PRIVATE
-#define MS_PRIVATE		1<<18	/* Private */
-#endif
-
-#ifndef MS_SLAVE
-#define MS_SLAVE		1<<19	/* Slave */
-#endif
-
-#ifndef MS_UNCLONE
-#define MS_UNCLONE		1<<17	/* UNCLONE */
-#endif
-
-int main(int argc, char *argv[])
-{
-	int type;
-	if (argc != 3) {
-		fprintf(stderr, "usage: %s DIR "
-			"[rshared|rslave|rprivate|runclone|shared|slave|private|unclone]\n",
-			argv[0]);
-		return 1;
-	}
-
-	fprintf(stdout, "%s %s %s\n", argv[0], argv[1], argv[2]);
-
-	if (strcmp(argv[2], "rshared") == 0)
-		type = (MS_SHARED | MS_REC);
-	else if (strcmp(argv[2], "rslave") == 0)
-		type = (MS_SLAVE | MS_REC);
-	else if (strcmp(argv[2], "rprivate") == 0)
-		type = (MS_PRIVATE | MS_REC);
-	else if (strcmp(argv[2], "runclone") == 0)
-		type = (MS_UNCLONE | MS_REC);
-	else if (strcmp(argv[2], "shared") == 0)
-		type = MS_SHARED;
-	else if (strcmp(argv[2], "slave") == 0)
-		type = MS_SLAVE;
-	else if (strcmp(argv[2], "private") == 0)
-		type = MS_PRIVATE;
-	else if (strcmp(argv[2], "unclone") == 0)
-		type = MS_UNCLONE;
-	else {
-		fprintf(stderr, "invalid operation: %s\n", argv[2]);
-		return 1;
-	}
-	setfsuid(getuid());
-	if (mount("", argv[1], "ext2", type, "") == -1) {
-		perror("mount");
-		return 1;
-	}
-	return 0;
-}
-- 
2.25.1

