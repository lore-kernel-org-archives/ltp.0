From: Cristian Marussi <cristian.marussi@arm.com>
Date: Fri, 21 Dec 2018 18:25:16 +0000
Subject: [LTP] [PATCH v3]  cgroup_regression_test.sh ported to newlib
Message-ID: <20181221182516.45689-1-cristian.marussi@arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Ported to newlib and cleaned up.

 - removed absolute/relative commands invocations
 - avoid bashism
  + removed bash shebang
  + giving up 'kill' bash-builtin: this needs redefining
    used sigspec strings
 - A common function 'get_cgroup_mountpoint' is added to help
   parse /proc/mounts in search of specific cgroup subsystems
   mountpoints. It is added as part of a common cgroup_lib.sh.
 - converted Copyright headers to SPDX
 - renamed each helper to include a tag prefix (cgroup_regress_)
   in order to avoid possible name clashes once installed all together
   into testcases/bin

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 .../kernel/controllers/cgroup/.gitignore      |   2 +-
 testcases/kernel/controllers/cgroup/Makefile  |  22 +-
 .../cgroup/cgroup_regress_test_10_1.sh        |  14 +
 .../cgroup/cgroup_regress_test_10_2.sh        |  12 +
 .../cgroup/cgroup_regress_test_3_1.sh         |  14 +
 .../cgroup/cgroup_regress_test_3_2.sh         |  11 +
 .../cgroup/cgroup_regress_test_6_1.sh         |  13 +
 .../cgroup/cgroup_regress_test_6_2.c          |  39 ++
 .../cgroup/cgroup_regress_test_9_1.sh         |  14 +
 .../cgroup/cgroup_regress_test_9_2.sh         |  13 +
 .../cgroup/cgroup_regression_test.sh          | 341 +++++++++---------
 .../controllers/cgroup/fork_processes.c       |  27 +-
 .../kernel/controllers/cgroup/getdelays.c     |  14 +-
 .../kernel/controllers/cgroup/test_10_1.sh    |  33 --
 .../kernel/controllers/cgroup/test_10_2.sh    |  31 --
 .../kernel/controllers/cgroup/test_3_1.sh     |  33 --
 .../kernel/controllers/cgroup/test_3_2.sh     |  30 --
 .../kernel/controllers/cgroup/test_6_1.sh     |  32 --
 .../kernel/controllers/cgroup/test_6_2.c      |  52 ---
 .../kernel/controllers/cgroup/test_9_1.sh     |  33 --
 .../kernel/controllers/cgroup/test_9_2.sh     |  32 --
 testcases/kernel/controllers/cgroup_lib.sh    |  33 ++
 22 files changed, 341 insertions(+), 504 deletions(-)
 create mode 100755 testcases/kernel/controllers/cgroup/cgroup_regress_test_10_1.sh
 create mode 100755 testcases/kernel/controllers/cgroup/cgroup_regress_test_10_2.sh
 create mode 100755 testcases/kernel/controllers/cgroup/cgroup_regress_test_3_1.sh
 create mode 100755 testcases/kernel/controllers/cgroup/cgroup_regress_test_3_2.sh
 create mode 100755 testcases/kernel/controllers/cgroup/cgroup_regress_test_6_1.sh
 create mode 100644 testcases/kernel/controllers/cgroup/cgroup_regress_test_6_2.c
 create mode 100755 testcases/kernel/controllers/cgroup/cgroup_regress_test_9_1.sh
 create mode 100755 testcases/kernel/controllers/cgroup/cgroup_regress_test_9_2.sh
 delete mode 100755 testcases/kernel/controllers/cgroup/test_10_1.sh
 delete mode 100755 testcases/kernel/controllers/cgroup/test_10_2.sh
 delete mode 100755 testcases/kernel/controllers/cgroup/test_3_1.sh
 delete mode 100755 testcases/kernel/controllers/cgroup/test_3_2.sh
 delete mode 100755 testcases/kernel/controllers/cgroup/test_6_1.sh
 delete mode 100644 testcases/kernel/controllers/cgroup/test_6_2.c
 delete mode 100755 testcases/kernel/controllers/cgroup/test_9_1.sh
 delete mode 100755 testcases/kernel/controllers/cgroup/test_9_2.sh
 create mode 100644 testcases/kernel/controllers/cgroup_lib.sh

diff --git a/testcases/kernel/controllers/cgroup/.gitignore b/testcases/kernel/controllers/cgroup/.gitignore
index a7f8569a8..1b6e05477 100644
--- a/testcases/kernel/controllers/cgroup/.gitignore
+++ b/testcases/kernel/controllers/cgroup/.gitignore
@@ -1,3 +1,3 @@
 /fork_processes
 /getdelays
-/test_6_2
+/cgroup_regress_test_6_2
diff --git a/testcases/kernel/controllers/cgroup/Makefile b/testcases/kernel/controllers/cgroup/Makefile
index 0cd60adae..8075ae80d 100644
--- a/testcases/kernel/controllers/cgroup/Makefile
+++ b/testcases/kernel/controllers/cgroup/Makefile
@@ -1,24 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2009, Cisco Systems Inc.
+# Author: Ngie Cooper, July 2009
 #
 #    kernel/controllers/cgroup test suite Makefile.
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
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/controllers/cgroup/cgroup_regress_test_10_1.sh b/testcases/kernel/controllers/cgroup/cgroup_regress_test_10_1.sh
new file mode 100755
index 000000000..d7bc5feb2
--- /dev/null
+++ b/testcases/kernel/controllers/cgroup/cgroup_regress_test_10_1.sh
@@ -0,0 +1,14 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2009 FUJITSU LIMITED
+# Author: Li Zefan <lizf@cn.fujitsu.com>
+
+trap exit USR1
+while true
+do
+	mount -t cgroup xxx cgroup/ > /dev/null 2>&1
+	mkdir cgroup/0 > /dev/null 2>&1
+	rmdir cgroup/0 > /dev/null 2>&1
+	umount cgroup/ > /dev/null 2>&1
+done
+
diff --git a/testcases/kernel/controllers/cgroup/cgroup_regress_test_10_2.sh b/testcases/kernel/controllers/cgroup/cgroup_regress_test_10_2.sh
new file mode 100755
index 000000000..b1222422d
--- /dev/null
+++ b/testcases/kernel/controllers/cgroup/cgroup_regress_test_10_2.sh
@@ -0,0 +1,12 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2009 FUJITSU LIMITED
+# Author: Li Zefan <lizf@cn.fujitsu.com>
+
+trap exit USR1
+while true
+do
+	mount -t cgroup xxx cgroup/ > /dev/null 2>&1
+	umount cgroup/ > /dev/null 2>&1
+done
+
diff --git a/testcases/kernel/controllers/cgroup/cgroup_regress_test_3_1.sh b/testcases/kernel/controllers/cgroup/cgroup_regress_test_3_1.sh
new file mode 100755
index 000000000..a23afab4c
--- /dev/null
+++ b/testcases/kernel/controllers/cgroup/cgroup_regress_test_3_1.sh
@@ -0,0 +1,14 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2009 FUJITSU LIMITED
+# Author: Li Zefan <lizf@cn.fujitsu.com>
+
+trap exit USR1
+
+path=$1
+
+while true
+do
+	mkdir $path/0
+	rmdir $path/0
+done
diff --git a/testcases/kernel/controllers/cgroup/cgroup_regress_test_3_2.sh b/testcases/kernel/controllers/cgroup/cgroup_regress_test_3_2.sh
new file mode 100755
index 000000000..e1836a3e2
--- /dev/null
+++ b/testcases/kernel/controllers/cgroup/cgroup_regress_test_3_2.sh
@@ -0,0 +1,11 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2009 FUJITSU LIMITED
+# Author: Li Zefan <lizf@cn.fujitsu.com>
+
+trap exit USR1
+while true
+do
+	cat /proc/sched_debug > /dev/null
+done
+
diff --git a/testcases/kernel/controllers/cgroup/cgroup_regress_test_6_1.sh b/testcases/kernel/controllers/cgroup/cgroup_regress_test_6_1.sh
new file mode 100755
index 000000000..3ca5e3154
--- /dev/null
+++ b/testcases/kernel/controllers/cgroup/cgroup_regress_test_6_1.sh
@@ -0,0 +1,13 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2009 FUJITSU LIMITED
+# Author: Li Zefan <lizf@cn.fujitsu.com>
+
+trap exit USR1
+while true
+do
+	mount -t cgroup -o ns xxx cgroup/ > /dev/null 2>&1
+	rmdir cgroup/[1-9]* > /dev/null 2>&1
+	umount cgroup/ > /dev/null 2>&1
+done
+
diff --git a/testcases/kernel/controllers/cgroup/cgroup_regress_test_6_2.c b/testcases/kernel/controllers/cgroup/cgroup_regress_test_6_2.c
new file mode 100644
index 000000000..e85d14636
--- /dev/null
+++ b/testcases/kernel/controllers/cgroup/cgroup_regress_test_6_2.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2009 FUJITSU LIMITED
+ *
+ * Author: Li Zefan <lizf@cn.fujitsu.com>
+ */
+
+#define _GNU_SOURCE
+
+#include <sched.h>
+#include <stdlib.h>
+#include <unistd.h>
+
+#define TST_NO_DEFAULT_MAIN
+#include "tst_test.h"
+
+#define DEFAULT_USEC	30000
+
+int foo(void __attribute__ ((unused)) * arg)
+{
+	return 0;
+}
+
+int main(int argc, char **argv)
+{
+	int usec;
+
+	if (argc == 2)
+		usec = atoi(argv[1]);
+	else
+		usec = DEFAULT_USEC;
+
+	while (1) {
+		usleep(usec);
+		ltp_clone_quick(CLONE_NEWNS, foo, NULL);
+	}
+
+	return 0;
+}
diff --git a/testcases/kernel/controllers/cgroup/cgroup_regress_test_9_1.sh b/testcases/kernel/controllers/cgroup/cgroup_regress_test_9_1.sh
new file mode 100755
index 000000000..4b6741a91
--- /dev/null
+++ b/testcases/kernel/controllers/cgroup/cgroup_regress_test_9_1.sh
@@ -0,0 +1,14 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2009 FUJITSU LIMITED
+# Author: Li Zefan <lizf@cn.fujitsu.com>
+
+trap exit USR1
+while true
+do
+#	mount -t cgroup -o debug xxx cgroup/ > /dev/null 2>&1
+	mount -t cgroup xxx cgroup/ > /dev/null 2>&1
+	cat cgroup/release_agent > /dev/null 2>&1
+	umount cgroup/ > /dev/null 2>&1
+done
+
diff --git a/testcases/kernel/controllers/cgroup/cgroup_regress_test_9_2.sh b/testcases/kernel/controllers/cgroup/cgroup_regress_test_9_2.sh
new file mode 100755
index 000000000..b9c05d032
--- /dev/null
+++ b/testcases/kernel/controllers/cgroup/cgroup_regress_test_9_2.sh
@@ -0,0 +1,13 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2009 FUJITSU LIMITED
+# Author: Li Zefan <lizf@cn.fujitsu.com>
+
+trap exit USR1
+while true
+do
+#	mount -t cgroup -o debug xxx cgroup/ > /dev/null 2>&1
+	mount -t cgroup xxx cgroup/ > /dev/null 2>&1
+	umount cgroup/ > /dev/null 2>&1
+done
+
diff --git a/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh b/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
index 6cfc63866..5167a99c8 100755
--- a/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
+++ b/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
@@ -1,92 +1,83 @@
-#! /bin/bash
-
-################################################################################
-##                                                                            ##
-## Copyright (c) 2009 FUJITSU LIMITED                                         ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-## Author: Li Zefan <lizf@cn.fujitsu.com>                                     ##
-##                                                                            ##
-################################################################################
-
-cd $LTPROOT/testcases/bin
-
-export TCID="cgroup_regression_test"
-export TST_TOTAL=10
-export TST_COUNT=1
-
-failed=0
-
-if tst_kvcmp -lt "2.6.29"; then
-	tst_brkm TCONF ignored "test must be run with kernel 2.6.29 or newer"
-	exit 32
-fi
-
-if [ ! -f /proc/cgroups ]; then
-	tst_brkm TCONF ignored "Kernel does not support for control groups; skipping testcases";
-	exit 32
-fi
-
-if [ "x$(id -ru)" != x0 ]; then
-	tst_brkm TCONF ignored "Test must be run as root"
-	exit 32
-fi
-
-dmesg -c > /dev/null
-nr_bug=`dmesg | grep -c "kernel BUG"`
-nr_null=`dmesg | grep -c "kernel NULL pointer dereference"`
-nr_warning=`dmesg | grep -c "^WARNING"`
-nr_lockdep=`dmesg | grep -c "possible recursive locking detected"`
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2009 FUJITSU LIMITED
+# Author: Li Zefan <lizf@cn.fujitsu.com>
+
+TST_TESTFUNC=test
+TST_SETUP=do_setup
+TST_CLEANUP=do_cleanup
+TST_CNT=10
+TST_NEEDS_ROOT=1
+TST_NEEDS_TMPDIR=1
+TST_NEEDS_CMDS="dmesg mountpoint mount umount cat kill find mkdir rmdir grep"
+
+. tst_test.sh
+. cgroup_lib.sh
+
+do_setup()
+{
+	mkdir cgroup/
+
+	if tst_kvcmp -lt "2.6.29"; then
+		tst_brk TCONF ignored "test must be run with kernel 2.6.29 or newer"
+	fi
+
+	if [ ! -f /proc/cgroups ]; then
+		tst_brk TCONF ignored "Kernel does not support for control groups; skipping testcases";
+	fi
+
+	dmesg -c > /dev/null
+	NR_BUG=`dmesg | grep -c "kernel BUG"`
+	NR_NULL=`dmesg | grep -c "kernel NULL pointer dereference"`
+	NR_WARNING=`dmesg | grep -c "^WARNING"`
+	NR_LOCKDEP=`dmesg | grep -c "possible recursive locking detected"`
+}
+
+do_cleanup()
+{
+	if mountpoint -q cgroup/
+	then
+		find cgroup/ -maxdepth 1 -depth -exec rmdir {} +
+		umount cgroup/
+		rmdir cgroup/
+	fi
+}
 
 # check_kernel_bug - check if some kind of kernel bug happened
 check_kernel_bug()
 {
-	new_bug=`dmesg | grep -c "kernel BUG"`
-	new_null=`dmesg | grep -c "kernel NULL pointer dereference"`
-	new_warning=`dmesg | grep -c "^WARNING"`
-	new_lockdep=`dmesg | grep -c "possible recursive locking detected"`
+	local new_bug=`dmesg | grep -c "kernel BUG"`
+	local new_null=`dmesg | grep -c "kernel NULL pointer dereference"`
+	local new_warning=`dmesg | grep -c "^WARNING"`
+	local new_lockdep=`dmesg | grep -c "possible recursive locking detected"`
 
 	# no kernel bug is detected
-	if [ $new_bug -eq $nr_bug -a $new_warning -eq $nr_warning -a \
-	     $new_null -eq $nr_null -a $new_lockdep -eq $nr_lockdep ]; then
+	if [ $new_bug -eq $NR_BUG -a $new_warning -eq $NR_WARNING -a \
+	     $new_null -eq $NR_NULL -a $new_lockdep -eq $NR_LOCKDEP ]; then
 		return 1
 	fi
 
 	# some kernel bug is detected
-	if [ $new_bug -gt $nr_bug ]; then
-		tst_resm TFAIL "kernel BUG was detected!"
+	if [ $new_bug -gt $NR_BUG ]; then
+		tst_res TFAIL "kernel BUG was detected!"
 	fi
-	if [ $new_warning -gt $nr_warning ]; then
-		tst_resm TFAIL "kernel WARNING was detected!"
+	if [ $new_warning -gt $NR_WARNING ]; then
+		tst_res TFAIL "kernel WARNING was detected!"
 	fi
-	if [ $new_null -gt $nr_null ]; then
-		tst_resm TFAIL "kernel NULL pointer dereference!"
+	if [ $new_null -gt $NR_NULL ]; then
+		tst_res TFAIL "kernel NULL pointer dereference!"
 	fi
-	if [ $new_lockdep -gt $nr_lockdep ]; then
-		tst_resm TFAIL "kernel lockdep warning was detected!"
+	if [ $new_lockdep -gt $NR_LOCKDEP ]; then
+		tst_res TFAIL "kernel lockdep warning was detected!"
 	fi
 
-	nr_bug=$new_bug
-	nr_null=$new_null
-	nr_warning=$new_warning
-	nr_lockdep=$new_lockdep
+	NR_BUG=$new_bug
+	NR_NULL=$new_null
+	NR_WARNING=$new_warning
+	NR_LOCKDEP=$new_lockdep
 
 	echo "check_kernel_bug found something!"
 	dmesg
-	failed=1
 	return 0
 }
 
@@ -100,26 +91,25 @@ check_kernel_bug()
 #         http://lkml.org/lkml/2008/4/16/493
 # Fix:    commit 0e04388f0189fa1f6812a8e1cb6172136eada87e
 #---------------------------------------------------------------------------
-test_1()
+test1()
 {
-	./fork_processes &
+	fork_processes &
 	sleep 1
 
 	mount -t cgroup -o none,name=foo cgroup cgroup/
 	if [ $? -ne 0 ]; then
-		tst_resm TFAIL "failed to mount cgroup filesystem"
-		failed=1
-		/bin/kill -SIGTERM $!
+		tst_res TFAIL "failed to mount cgroup filesystem"
+		kill -TERM $!
 		return
 	fi
 	cat cgroup/tasks > /dev/null
 
 	check_kernel_bug
 	if [ $? -eq 1 ]; then
-		tst_resm TPASS "no kernel bug was found"
+		tst_res TPASS "no kernel bug was found"
 	fi
 
-	/bin/kill -SIGTERM $!
+	kill -TERM $!
 	wait $!
 	umount cgroup/
 }
@@ -130,13 +120,15 @@ test_1()
 # Links:  http://lkml.org/lkml/2008/2/25/12
 # Fix:    commit bc231d2a048010d5e0b49ac7fddbfa822fc41109
 #---------------------------------------------------------------------------
-test_2()
+test2()
 {
+	local val1
+	local val2
+
 	mount -t cgroup -o none,name=foo cgroup cgroup/
 	if [ $? -ne 0 ]; then
-		tst_resm TFAIL "Failed to mount cgroup filesystem"
-		failed=1
-		return 1
+		tst_res TFAIL "Failed to mount cgroup filesystem"
+		return
 	fi
 
 	echo 0 > cgroup/notify_on_release
@@ -148,16 +140,15 @@ test_2()
 	val2=`cat cgroup/1/notify_on_release`
 
 	if [ $val1 -ne 0 -o $val2 -ne 1 ]; then
-		tst_resm TFAIL "wrong notify_on_release value"
-		failed=1
+		tst_res TFAIL "wrong notify_on_release value"
 	else
-		tst_resm TPASS "notify_on_release is inherited"
+		tst_res TPASS "notify_on_release is inherited"
 	fi
 
 	rmdir cgroup/0 cgroup/1
 	umount cgroup/
 
-	return $failed
+	return
 }
 
 #---------------------------------------------------------------------------
@@ -168,19 +159,19 @@ test_2()
 #         http://lkml.org/lkml/2008/12/16/481
 # Fix:    commit a47295e6bc42ad35f9c15ac66f598aa24debd4e2
 #---------------------------------------------------------------------------
-test_3()
+test3()
 {
 	local cpu_subsys_path
 
 	if [ ! -e /proc/sched_debug ]; then
-		tst_resm TCONF "CONFIG_SCHED_DEBUG is not enabled"
+		tst_res TCONF "CONFIG_SCHED_DEBUG is not enabled"
 		return
 	fi
 
 	if grep -q -w "cpu" /proc/cgroups ; then
-		cpu_subsys_path=$(grep -w cpu /proc/mounts | awk '{ print $2 }')
+		cpu_subsys_path=$(get_cgroup_mountpoint "cpu")
 	else
-		tst_resm TCONF "CONFIG_CGROUP_SCHED is not enabled"
+		tst_res TCONF "CONFIG_CGROUP_SCHED is not enabled"
 		return
 	fi
 
@@ -188,26 +179,25 @@ test_3()
 	if [ -z "$cpu_subsys_path" ]; then
 		mount -t cgroup -o cpu xxx cgroup/
 		if [ $? -ne 0 ]; then
-			tst_resm TFAIL "Failed to mount cpu subsys"
-			failed=1
+			tst_res TFAIL "Failed to mount cpu subsys"
 			return
 		fi
 		cpu_subsys_path=cgroup
 	fi
 
-	./test_3_1.sh $cpu_subsys_path &
+	cgroup_regress_test_3_1.sh $cpu_subsys_path &
 	pid1=$!
-	./test_3_2.sh &
+	cgroup_regress_test_3_2.sh &
 	pid2=$!
 
 	sleep 30
-	/bin/kill -SIGUSR1 $pid1 $pid2
+	kill -USR1 $pid1 $pid2
 	wait $pid1
 	wait $pid2
 
 	check_kernel_bug
 	if [ $? -eq 1 ]; then
-		tst_resm TPASS "no kernel bug was found"
+		tst_res TPASS "no kernel bug was found"
 	fi
 
 	rmdir $cpu_subsys_path/* 2> /dev/null
@@ -221,17 +211,19 @@ test_3()
 # Link:   http://lkml.org/lkml/2009/2/4/67
 # Fix:
 #---------------------------------------------------------------------------
-test_4()
+test4()
 {
+	local lines
+
 	if [ ! -e /proc/lockdep ]; then
-		tst_resm TCONF "CONFIG_LOCKDEP is not enabled"
+		tst_res TCONF "CONFIG_LOCKDEP is not enabled"
 		return
 	fi
 
 	# MAX_LOCKDEP_SUBCLASSES is 8, so number of subsys should be > 8
 	lines=`cat /proc/cgroups | wc -l`
 	if [ $lines -le 9 ]; then
-		tst_resm TCONF "require more than 8 cgroup subsystems"
+		tst_res TCONF "require more than 8 cgroup subsystems"
 		return
 	fi
 
@@ -242,11 +234,10 @@ test_4()
 
 	dmesg | grep -q "MAX_LOCKDEP_SUBCLASSES too low"
 	if [ $? -eq 0 ]; then
-		tst_resm TFAIL "lockdep BUG was found"
-		failed=1
+		tst_res TFAIL "lockdep BUG was found"
 		return
 	else
-		tst_resm TPASS "no lockdep BUG was found"
+		tst_res TPASS "no lockdep BUG was found"
 	fi
 }
 
@@ -258,20 +249,20 @@ test_4()
 #         http://lkml.org/lkml/2009/1/28/190
 # Fix:    commit 839ec5452ebfd5905b9c69b20ceb640903a8ea1a
 #---------------------------------------------------------------------------
-test_5()
+test5()
 {
 	local mounted
 	local failing
 	local mntpoint
 
-	lines=`cat /proc/cgroups | wc -l`
+	local lines=`cat /proc/cgroups | wc -l`
 	if [ $lines -le 2 ]; then
-		tst_resm TCONF "require at least 2 cgroup subsystems"
+		tst_res TCONF "require at least 2 cgroup subsystems"
 		return
 	fi
 
-	subsys1=`tail -n 1 /proc/cgroups | awk '{ print $1 }'`
-	subsys2=`tail -n 2 /proc/cgroups | head -1 | awk '{ print $1 }'`
+	local subsys1=`tail -n 1 /proc/cgroups | awk '{ print $1 }'`
+	local subsys2=`tail -n 2 /proc/cgroups | head -1 | awk '{ print $1 }'`
 
 	# Accounting here for the fact that the chosen subsystems could
 	# have been already previously mounted at boot time: in such a
@@ -280,32 +271,30 @@ test_5()
 	# $failing params to be used in the following expected-to-fail
 	# mount action. Note that the subsysN name itself will be listed
 	# amongst mounts options.
-	cat /proc/mounts | grep cgroup | grep -q $subsys1 && mounted=$subsys1
-	[ -z "$mounted" ] && cat /proc/mounts | grep cgroup | grep -q $subsys2 && mounted=$subsys2
+	get_cgroup_mountpoint $subsys1 >/dev/null && mounted=$subsys1
+	[ -z "$mounted" ] && get_cgroup_mountpoint $subsys2 >/dev/null && mounted=$subsys2
 	if [ -z "$mounted" ]; then
 		mntpoint=cgroup
 		failing=$subsys1
 		mount -t cgroup -o $subsys1,$subsys2 xxx $mntpoint/
 		if [ $? -ne 0 ]; then
-			tst_resm TFAIL "mount $subsys1 and $subsys2 failed"
-			failed=1
+			tst_res TFAIL "mount $subsys1 and $subsys2 failed"
 			return
 		fi
 	else
 		# Use the pre-esistent mountpoint as $mntpoint and use a
 		# co-mount with $failing: this way the 2nd mount will
 		# also fail (as expected) in this 'mirrored' configuration.
-		mntpoint=$(cat /proc/mounts | grep cgroup | grep $mounted | awk '{ print $2 }')
+		mntpoint=$(get_cgroup_mountpoint $mounted)
 		failing=$subsys1,$subsys2
 	fi
 
 	# This 2nd mount has been properly configured to fail
 	mount -t cgroup -o $failing xxx $mntpoint/ 2> /dev/null
 	if [ $? -eq 0 ]; then
-		tst_resm TFAIL "mount $failing should fail"
+		tst_res TFAIL "mount $failing should fail"
 		# Do NOT unmount pre-existent mountpoints...
-		[ -z "$mounted" ] && umount $mntpoint
-		failed=1
+		[ -z "$mounted" ] && umount $mntpoint/
 		return
 	fi
 
@@ -321,15 +310,15 @@ test_5()
 
 	check_kernel_bug
 	if [ $? -eq 1 ]; then
-		tst_resm TPASS "no kernel bug was found"
+		tst_res TPASS "no kernel bug was found"
 	fi
 
 	# clean up
-	/bin/kill -SIGTERM $! > /dev/null
+	kill -TERM $! > /dev/null
 	wait $!
 	rmdir $mntpoint/0
 	# Do NOT unmount pre-existent mountpoints...
-	[ -z "$mounted" ] && umount $mntpoint
+	[ -z "$mounted" ] && umount $mntpoint/
 }
 
 #---------------------------------------------------------------------------
@@ -338,29 +327,33 @@ test_5()
 # Links:  http://lkml.org/lkml/2008/12/24/124
 # Fix:    commit 7b574b7b0124ed344911f5d581e9bc2d83bbeb19
 #---------------------------------------------------------------------------
-test_6()
+test6()
 {
-	grep -q -w "ns" /proc/cgroups
-	if [ $? -ne 0 ]; then
-		tst_resm TCONF "CONFIG_CGROUP_NS"
+	if tst_kvcmp -ge "3.0"; then
+		tst_res TCONF "CONFIG_CGROUP_NS is NOT supported in Kernels >= 3.0"
+		return
+	fi
+
+	if ! grep -q -w "ns" /proc/cgroups; then
+		tst_res TCONF "CONFIG_CGROUP_NS is NOT enabled"
 		return
 	fi
 
 	# run the test for 30 secs
-	./test_6_1.sh &
-	pid1=$!
-	./test_6_2 &
-	pid2=$!
+	cgroup_regress_test_6_1.sh &
+	local pid1=$!
+	cgroup_regress_test_6_2 &
+	local pid2=$!
 
 	sleep 30
-	/bin/kill -SIGUSR1 $pid1
-	/bin/kill -SIGTERM $pid2
+	kill -USR1 $pid1
+	kill -TERM $pid2
 	wait $pid1
 	wait $pid2
 
 	check_kernel_bug
 	if [ $? -eq 1 ]; then
-		tst_resm TPASS "no kernel bug was found"
+		tst_res TPASS "no kernel bug was found"
 	fi
 
 	# clean up
@@ -379,12 +372,18 @@ test_6()
 #---------------------------------------------------------------------------
 test_7_1()
 {
-	subsys_path=$(grep -w $subsys /proc/mounts | cut -d ' ' -f 2)
+	local subsys=$1
+	# we should be careful to select a $subsys_path which is related to
+	# cgroup only: if cgroup debugging is enabled a 'debug' $subsys
+	# could be passed here as params and this will lead to ambiguity and
+	# errors when grepping simply for 'debug' in /proc/mounts since we'll
+	# find also /sys/kernel/debug. Helper takes care of this.
+	local subsys_path=$(get_cgroup_mountpoint $subsys)
+
 	if [ -z "$subsys_path" ]; then
 		mount -t cgroup -o $subsys xxx cgroup/
 		if [ $? -ne 0 ]; then
-			tst_resm TFAIL "failed to mount $subsys"
-			failed=1
+			tst_res TFAIL "failed to mount $subsys"
 			return
 		fi
 		subsys_path=cgroup
@@ -399,7 +398,7 @@ test_7_1()
 
 	if [ "$subsys_path" = "cgroup" ]; then
 		mount -t cgroup -o remount xxx cgroup/ 2> /dev/null
-		/bin/kill -SIGTERM $!
+		kill -TERM $!
 		wait $!
 		umount cgroup/
 	fi
@@ -407,10 +406,11 @@ test_7_1()
 
 test_7_2()
 {
+	local subsys=$1
+
 	mount -t cgroup -o none,name=foo cgroup cgroup/
 	if [ $? -ne 0 ]; then
-		tst_resm TFAIL "failed to mount cgroup"
-		failed=1
+		tst_res TFAIL "failed to mount cgroup"
 		return
 	fi
 
@@ -421,7 +421,7 @@ test_7_2()
 	# remount with some subsystems removed
 	# since 2.6.28, this remount will fail
 	mount -t cgroup -o remount,$subsys xxx cgroup/ 2> /dev/null
-	/bin/kill -SIGTERM $!
+	kill -TERM $!
 	wait $!
 	umount cgroup/
 
@@ -439,21 +439,21 @@ test_7_2()
 	done
 }
 
-test_7()
+test7()
 {
-	lines=`cat /proc/cgroups | wc -l`
+	local lines=`cat /proc/cgroups | wc -l`
 	if [ $lines -le 2 ]; then
-		tst_resm TCONF "require at least 2 cgroup subsystems"
+		tst_res TCONF "require at least 2 cgroup subsystems"
 		slt_result $SLT_Untested
 		return
 	fi
 
-	subsys=`tail -n 1 /proc/cgroups | awk '{ print $1 }'`
+	local subsys=`tail -n 1 /proc/cgroups | awk '{ print $1 }'`
 
 	# remount to add new subsystems to the hierarchy
-	i=1
+	local i=1
 	while [ $i -le 2 ] ; do
-		test_7_$i
+		test_7_$i $subsys
 		if [ $? -ne 0 ]; then
 			return
 		fi
@@ -465,7 +465,7 @@ test_7()
 		: $(( i += 1 ))
 	done
 
-	tst_resm TPASS "no kernel bug was found"
+	tst_res TPASS "no kernel bug was found"
 }
 
 #---------------------------------------------------------------------------
@@ -474,26 +474,24 @@ test_7()
 # Links:  http://lkml.org/lkml/2008/11/19/53
 # Fix:    commit 33d283bef23132c48195eafc21449f8ba88fce6b
 #---------------------------------------------------------------------------
-test_8()
+test8()
 {
 	mount -t cgroup -o none,name=foo cgroup cgroup/
 	if [ $? -ne 0 ]; then
-		tst_resm TFAIL "failed to mount cgroup filesystem"
-		failed=1
+		tst_res TFAIL "failed to mount cgroup filesystem"
 		return
 	fi
 
-	./getdelays -C cgroup/tasks > /dev/null 2>&1
+	getdelays -C cgroup/tasks > /dev/null 2>&1
 	if [ $? -eq 0 ]; then
-		tst_resm TFAIL "should have failed to get cgroupstat of tasks file"
+		tst_res TFAIL "should have failed to get cgroupstat of tasks file"
 		umount cgroup/
-		failed=1
 		return
 	fi
 
 	check_kernel_bug
 	if [ $? -eq 1 ]; then
-		tst_resm TPASS "no kernel bug was found"
+		tst_res TPASS "no kernel bug was found"
 	fi
 
 	umount cgroup/
@@ -507,15 +505,15 @@ test_8()
 # Links:  http://lkml.org/lkml/2009/1/4/352
 # Fix:    commit ada723dcd681e2dffd7d73345cc8fda0eb0df9bd
 #---------------------------------------------------------------------------
-test_9()
+test9()
 {
-	./test_9_1.sh &
-	pid1=$!
-	./test_9_2.sh &
-	pid2=$!
+	cgroup_regress_test_9_1.sh &
+	local pid1=$!
+	cgroup_regress_test_9_2.sh &
+	local pid2=$!
 
 	sleep 30
-	/bin/kill -SIGUSR1 $pid1 $pid2
+	kill -USR1 $pid1 $pid2
 	wait $pid1
 	wait $pid2
 
@@ -523,7 +521,7 @@ test_9()
 
 	check_kernel_bug
 	if [ $? -eq 1 ]; then
-		tst_resm TPASS "no kernel warning was found"
+		tst_res TPASS "no kernel warning was found"
 	fi
 }
 
@@ -534,15 +532,15 @@ test_9()
 # Links:  http://lkml.org/lkml/2009/1/4/354
 # Fix:    commit 1a88b5364b535edaa321d70a566e358390ff0872
 #---------------------------------------------------------------------------
-test_10()
+test10()
 {
-	./test_10_1.sh &
-	pid1=$!
-	./test_10_2.sh &
-	pid2=$!
+	cgroup_regress_test_10_1.sh &
+	local pid1=$!
+	cgroup_regress_test_10_2.sh &
+	local pid2=$!
 
 	sleep 30
-	/bin/kill -SIGUSR1 $pid1 $pid2
+	kill -USR1 $pid1 $pid2
 	wait $pid1
 	wait $pid2
 
@@ -552,21 +550,8 @@ test_10()
 
 	check_kernel_bug
 	if [ $? -eq 1 ]; then
-		tst_resm TPASS "no kernel warning was found"
+		tst_res TPASS "no kernel warning was found"
 	fi
 }
 
-# main
-
-mkdir cgroup/
-
-for ((cur = 1; cur <= $TST_TOTAL; cur++))
-{
-	export TST_COUNT=$cur
-
-	test_$cur
-}
-
-find cgroup/ -maxdepth 1 -depth -exec rmdir {} +
-
-exit $failed
+tst_run
diff --git a/testcases/kernel/controllers/cgroup/fork_processes.c b/testcases/kernel/controllers/cgroup/fork_processes.c
index b4bb77101..6f2498bb8 100644
--- a/testcases/kernel/controllers/cgroup/fork_processes.c
+++ b/testcases/kernel/controllers/cgroup/fork_processes.c
@@ -1,24 +1,9 @@
-/******************************************************************************/
-/*                                                                            */
-/* Copyright (c) 2009 FUJITSU LIMITED                                         */
-/*                                                                            */
-/* This program is free software;  you can redistribute it and/or modify      */
-/* it under the terms of the GNU General Public License as published by       */
-/* the Free Software Foundation; either version 2 of the License, or          */
-/* (at your option) any later version.                                        */
-/*                                                                            */
-/* This program is distributed in the hope that it will be useful,            */
-/* but WITHOUT ANY WARRANTY;  without even the implied warranty of            */
-/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                  */
-/* the GNU General Public License for more details.                           */
-/*                                                                            */
-/* You should have received a copy of the GNU General Public License          */
-/* along with this program;  if not, write to the Free Software               */
-/* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    */
-/*                                                                            */
-/* Author: Li Zefan <lizf@cn.fujitsu.com>                                     */
-/*                                                                            */
-/******************************************************************************/
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2009 FUJITSU LIMITED
+ *
+ * Author: Li Zefan <lizf@cn.fujitsu.com>
+ */
 
 #include <sys/types.h>
 #include <sys/wait.h>
diff --git a/testcases/kernel/controllers/cgroup/getdelays.c b/testcases/kernel/controllers/cgroup/getdelays.c
index 4e87a13ca..7a01d16bd 100644
--- a/testcases/kernel/controllers/cgroup/getdelays.c
+++ b/testcases/kernel/controllers/cgroup/getdelays.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /* getdelays.c
  *
  * Utility to get per-pid and per-tgid delay accounting statistics
@@ -7,8 +8,6 @@
  * Copyright (C) Balbir Singh, IBM Corp. 2006
  * Copyright (c) Jay Lan, SGI. 2006
  *
- * Compile with
- *	gcc -I/usr/src/linux/include getdelays.c -o getdelays
  */
 
 #include <stdio.h>
@@ -173,14 +172,14 @@ int get_family_id(int sd)
 		char buf[256];
 	} ans;
 
-	int id = 0, rc;
+	int id = 0;
 	struct nlattr *na;
 	int rep_len;
 
 	strcpy(name, TASKSTATS_GENL_NAME);
-	rc = send_cmd(sd, GENL_ID_CTRL, getpid(), CTRL_CMD_GETFAMILY,
-		      CTRL_ATTR_FAMILY_NAME, (void *)name,
-		      strlen(TASKSTATS_GENL_NAME) + 1);
+	send_cmd(sd, GENL_ID_CTRL, getpid(), CTRL_CMD_GETFAMILY,
+		 CTRL_ATTR_FAMILY_NAME, (void *)name,
+		 strlen(TASKSTATS_GENL_NAME) + 1);
 
 	rep_len = recv(sd, &ans, sizeof(ans), 0);
 	if (ans.n.nlmsg_type == NLMSG_ERROR ||
@@ -414,8 +413,6 @@ int main(int argc, char *argv[])
 	}
 
 	do {
-		int i;
-
 		rep_len = recv(nl_sd, &msg, sizeof(msg), 0);
 		PRINTF("received %d bytes\n", rep_len);
 
@@ -439,7 +436,6 @@ int main(int argc, char *argv[])
 
 		na = (struct nlattr *)GENLMSG_DATA(&msg);
 		len = 0;
-		i = 0;
 		while (len < rep_len) {
 			len += NLA_ALIGN(na->nla_len);
 			switch (na->nla_type) {
diff --git a/testcases/kernel/controllers/cgroup/test_10_1.sh b/testcases/kernel/controllers/cgroup/test_10_1.sh
deleted file mode 100755
index 2a7763b09..000000000
--- a/testcases/kernel/controllers/cgroup/test_10_1.sh
+++ /dev/null
@@ -1,33 +0,0 @@
-#! /bin/bash
-
-################################################################################
-##                                                                            ##
-## Copyright (c) 2009 FUJITSU LIMITED                                         ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-## Author: Li Zefan <lizf@cn.fujitsu.com>                                     ##
-##                                                                            ##
-################################################################################
-
-trap exit SIGUSR1
-for ((; ;))
-{
-	mount -t cgroup xxx cgroup/ > /dev/null 2>&1
-	mkdir cgroup/0 > /dev/null 2>&1
-	rmdir cgroup/0 > /dev/null 2>&1
-	umount cgroup/ > /dev/null 2>&1
-}
-
diff --git a/testcases/kernel/controllers/cgroup/test_10_2.sh b/testcases/kernel/controllers/cgroup/test_10_2.sh
deleted file mode 100755
index a6e50d883..000000000
--- a/testcases/kernel/controllers/cgroup/test_10_2.sh
+++ /dev/null
@@ -1,31 +0,0 @@
-#! /bin/bash
-
-################################################################################
-##                                                                            ##
-## Copyright (c) 2009 FUJITSU LIMITED                                         ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-## Author: Li Zefan <lizf@cn.fujitsu.com>                                     ##
-##                                                                            ##
-################################################################################
-
-trap exit SIGUSR1
-for ((; ;))
-{
-	mount -t cgroup xxx cgroup/ > /dev/null 2>&1
-	umount cgroup/ > /dev/null 2>&1
-}
-
diff --git a/testcases/kernel/controllers/cgroup/test_3_1.sh b/testcases/kernel/controllers/cgroup/test_3_1.sh
deleted file mode 100755
index dcc78a6b1..000000000
--- a/testcases/kernel/controllers/cgroup/test_3_1.sh
+++ /dev/null
@@ -1,33 +0,0 @@
-#! /bin/bash
-
-################################################################################
-##                                                                            ##
-## Copyright (c) 2009 FUJITSU LIMITED                                         ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-## Author: Li Zefan <lizf@cn.fujitsu.com>                                     ##
-##                                                                            ##
-################################################################################
-
-trap exit SIGUSR1
-
-path=$1
-
-for ((; ;))
-{
-	mkdir $path/0
-	rmdir $path/0
-}
diff --git a/testcases/kernel/controllers/cgroup/test_3_2.sh b/testcases/kernel/controllers/cgroup/test_3_2.sh
deleted file mode 100755
index 63bafaa46..000000000
--- a/testcases/kernel/controllers/cgroup/test_3_2.sh
+++ /dev/null
@@ -1,30 +0,0 @@
-#! /bin/bash
-
-################################################################################
-##                                                                            ##
-## Copyright (c) 2009 FUJITSU LIMITED                                         ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-## Author: Li Zefan <lizf@cn.fujitsu.com>                                     ##
-##                                                                            ##
-################################################################################
-
-trap exit SIGUSR1
-for ((; ;))
-{
-	cat /proc/sched_debug > /dev/null
-}
-
diff --git a/testcases/kernel/controllers/cgroup/test_6_1.sh b/testcases/kernel/controllers/cgroup/test_6_1.sh
deleted file mode 100755
index 4eb6b3293..000000000
--- a/testcases/kernel/controllers/cgroup/test_6_1.sh
+++ /dev/null
@@ -1,32 +0,0 @@
-#! /bin/bash
-
-################################################################################
-##                                                                            ##
-## Copyright (c) 2009 FUJITSU LIMITED                                         ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-## Author: Li Zefan <lizf@cn.fujitsu.com>                                     ##
-##                                                                            ##
-################################################################################
-
-trap exit SIGUSR1
-for ((; ;))
-{
-	mount -t cgroup -o ns xxx cgroup/ > /dev/null 2>&1
-	rmdir cgroup/[1-9]* > /dev/null 2>&1
-	umount cgroup/ > /dev/null 2>&1
-}
-
diff --git a/testcases/kernel/controllers/cgroup/test_6_2.c b/testcases/kernel/controllers/cgroup/test_6_2.c
deleted file mode 100644
index df85b1f91..000000000
--- a/testcases/kernel/controllers/cgroup/test_6_2.c
+++ /dev/null
@@ -1,52 +0,0 @@
-/******************************************************************************/
-/*                                                                            */
-/* Copyright (c) 2009 FUJITSU LIMITED                                         */
-/*                                                                            */
-/* This program is free software;  you can redistribute it and/or modify      */
-/* it under the terms of the GNU General Public License as published by       */
-/* the Free Software Foundation; either version 2 of the License, or          */
-/* (at your option) any later version.                                        */
-/*                                                                            */
-/* This program is distributed in the hope that it will be useful,            */
-/* but WITHOUT ANY WARRANTY;  without even the implied warranty of            */
-/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                  */
-/* the GNU General Public License for more details.                           */
-/*                                                                            */
-/* You should have received a copy of the GNU General Public License          */
-/* along with this program;  if not, write to the Free Software               */
-/* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    */
-/*                                                                            */
-/* Author: Li Zefan <lizf@cn.fujitsu.com>                                     */
-/*                                                                            */
-/******************************************************************************/
-
-#define _GNU_SOURCE
-
-#include <sched.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include "test.h"
-
-#define DEFAULT_USEC	30000
-
-int foo(void __attribute__ ((unused)) * arg)
-{
-	return 0;
-}
-
-int main(int argc, char **argv)
-{
-	int usec;
-
-	if (argc == 2)
-		usec = atoi(argv[1]);
-	else
-		usec = DEFAULT_USEC;
-
-	while (1) {
-		usleep(usec);
-		ltp_clone_quick(CLONE_NEWNS, foo, NULL);
-	}
-
-	tst_exit();
-}
diff --git a/testcases/kernel/controllers/cgroup/test_9_1.sh b/testcases/kernel/controllers/cgroup/test_9_1.sh
deleted file mode 100755
index b7c26a46c..000000000
--- a/testcases/kernel/controllers/cgroup/test_9_1.sh
+++ /dev/null
@@ -1,33 +0,0 @@
-#! /bin/bash
-
-################################################################################
-##                                                                            ##
-## Copyright (c) 2009 FUJITSU LIMITED                                         ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-## Author: Li Zefan <lizf@cn.fujitsu.com>                                     ##
-##                                                                            ##
-################################################################################
-
-trap exit SIGUSR1
-for ((; ;))
-{
-#	mount -t cgroup -o debug xxx cgroup/ > /dev/null 2>&1
-	mount -t cgroup xxx cgroup/ > /dev/null 2>&1
-	cat cgroup/release_agent > /dev/null 2>&1
-	umount cgroup/ > /dev/null 2>&1
-}
-
diff --git a/testcases/kernel/controllers/cgroup/test_9_2.sh b/testcases/kernel/controllers/cgroup/test_9_2.sh
deleted file mode 100755
index 2d7d38675..000000000
--- a/testcases/kernel/controllers/cgroup/test_9_2.sh
+++ /dev/null
@@ -1,32 +0,0 @@
-#! /bin/bash
-
-################################################################################
-##                                                                            ##
-## Copyright (c) 2009 FUJITSU LIMITED                                         ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-## Author: Li Zefan <lizf@cn.fujitsu.com>                                     ##
-##                                                                            ##
-################################################################################
-
-trap exit SIGUSR1
-for ((; ;))
-{
-#	mount -t cgroup -o debug xxx cgroup/ > /dev/null 2>&1
-	mount -t cgroup xxx cgroup/ > /dev/null 2>&1
-	umount cgroup/ > /dev/null 2>&1
-}
-
diff --git a/testcases/kernel/controllers/cgroup_lib.sh b/testcases/kernel/controllers/cgroup_lib.sh
new file mode 100644
index 000000000..5cdf55363
--- /dev/null
+++ b/testcases/kernel/controllers/cgroup_lib.sh
@@ -0,0 +1,33 @@
+#!/bin/sh
+
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2018-2019 ARM Ltd. All Rights Reserved.
+
+#
+# Helper to parse /proc/mounts to find the mountpoints (if any)
+# associated with the cgroup subsystem passed as param.
+#
+# It expects as single argument the cgroup subsytem for
+# which to search in /proc/mounts the mountpoint (if any).
+#
+# - returns true|false depending if any mountpoint has been found.
+# - echos back the mountpoint itself if any found
+#
+get_cgroup_mountpoint()
+{
+	local mntpoint
+	local line
+	local ret=1
+	local subsystem=$1
+
+	# fail straight away with no args
+	[ $# -eq 0 ] && return $ret
+
+	line=$(grep cgroup /proc/mounts | grep -w $subsystem)
+	ret=$?
+	# extract mountpoint if any exist
+	[ $ret = 0 ] && mntpoint=$(echo $line | awk '{ print $2 }') && echo $mntpoint
+
+	return $ret
+}
+
-- 
2.17.1

