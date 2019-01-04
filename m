From: Cristian Marussi <cristian.marussi@arm.com>
Date: Fri,  4 Jan 2019 10:54:07 +0000
Subject: [LTP] [PATCH v3]  memcg_stress_test.sh: ported to newlib
In-Reply-To: <20190104105407.48123-1-cristian.marussi@arm.com>
References: <20190104105407.48123-1-cristian.marussi@arm.com>
Message-ID: <20190104105407.48123-2-cristian.marussi@arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Ported to newlib framework and general cleanup.
Moved an helper function out into cgroup_lib.sh.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 testcases/kernel/controllers/cgroup_lib.sh    |  16 +++
 .../kernel/controllers/memcg/stress/Makefile  |  21 +--
 .../memcg/stress/memcg_process_stress.c       |  34 ++---
 .../memcg/stress/memcg_stress_test.sh         | 135 ++++++++----------
 4 files changed, 92 insertions(+), 114 deletions(-)

diff --git a/testcases/kernel/controllers/cgroup_lib.sh b/testcases/kernel/controllers/cgroup_lib.sh
index 8c19c6c3e..dbf5199e6 100644
--- a/testcases/kernel/controllers/cgroup_lib.sh
+++ b/testcases/kernel/controllers/cgroup_lib.sh
@@ -21,3 +21,19 @@ get_cgroup_mountpoint()
 	echo $mntpoint
 	return 0
 }
+
+# Check if given subsystem is supported and enabled
+# is_cgroup_subsystem_available_and_enabled SUBSYSTEM
+# RETURN: 0 if subsystem supported and enabled, otherwise 1
+is_cgroup_subsystem_available_and_enabled()
+{
+	local val
+	local subsystem=$1
+
+	[ $# -eq 0 ] && tst_brk TBROK "is_cgroup_subsystem_available_and_enabled: subsystem not defined"
+
+	val=$(grep -w $subsystem /proc/cgroups | awk '{ print $4 }')
+	[ "x$val" = "x1" ] && return 0
+
+	return 1
+}
diff --git a/testcases/kernel/controllers/memcg/stress/Makefile b/testcases/kernel/controllers/memcg/stress/Makefile
index a0456ac5d..773363cfc 100644
--- a/testcases/kernel/controllers/memcg/stress/Makefile
+++ b/testcases/kernel/controllers/memcg/stress/Makefile
@@ -1,24 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2009, Cisco Systems Inc.
+# Author: Ngie Cooper, September 2009
 #
 #    kernel/controllers/memcg/stress testcase suite Makefile.
 #
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
 
 top_srcdir		?= ../../../../..
 
diff --git a/testcases/kernel/controllers/memcg/stress/memcg_process_stress.c b/testcases/kernel/controllers/memcg/stress/memcg_process_stress.c
index 870575c26..6af550012 100644
--- a/testcases/kernel/controllers/memcg/stress/memcg_process_stress.c
+++ b/testcases/kernel/controllers/memcg/stress/memcg_process_stress.c
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
 
 #include <sys/mman.h>
 #include <err.h>
@@ -91,14 +76,15 @@ int main(int argc, char *argv[])
 	if (interval <= 0)
 		interval = 1;
 
-	/* TODO (garrcoop): add error handling. */
 	memset(&sigint_action, 0, sizeof(sigint_action));
 	sigint_action.sa_handler = &sigint_handler;
-	sigaction(SIGINT, &sigint_action, NULL);
+	if (sigaction(SIGINT, &sigint_action, NULL))
+		err(1, "sigaction(%s) failed", "SIGINT");
 
 	memset(&sigusr_action, 0, sizeof(sigusr_action));
 	sigusr_action.sa_handler = &sigusr_handler;
-	sigaction(SIGUSR1, &sigusr_action, NULL);
+	if (sigaction(SIGUSR1, &sigusr_action, NULL))
+		err(1, "sigaction(%s) failed", "SIGUSR1");
 
 	while (!flag_exit) {
 		sleep(interval);
diff --git a/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh b/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
index af1a708a8..652d99e55 100755
--- a/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
+++ b/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
@@ -1,56 +1,56 @@
-#! /bin/sh
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
-## Restructure for LTP: Shi Weihua <shiwh@cn.fujitsu.com>                     ##
-## Added memcg enable/disable functinality: Rishikesh K Rajak                 ##
-##                                              <risrajak@linux.vnet.ibm.com  ##
-##                                                                            ##
-################################################################################
-
-cd $LTPROOT/testcases/bin
-export TCID="memcg_stress_test"
-export TST_TOTAL=2
-export TST_COUNT=0
-
-if [ "x$(grep -w memory /proc/cgroups | cut -f4)" != "x1" ]; then
-        echo "WARNING:";
-        echo "Either Kernel does not support for memory resource controller or feature not enabled";
-        echo "Skipping all memcgroup testcases....";
-        exit 0
-fi
-
-RUN_TIME=$(( 15 * 60 ))
-
-cleanup()
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2009 FUJITSU LIMITED
+# Copyright (c) 2018-2019 ARM Ltd. All Rights Reserved.
+#
+# Author: Li Zefan <lizf@cn.fujitsu.com>
+# Restructure for LTP: Shi Weihua <shiwh@cn.fujitsu.com>
+# Added memcg enable/disable functionality: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com
+
+TST_TESTFUNC=testcase_
+TST_SETUP=do_setup
+TST_CLEANUP=do_cleanup
+TST_CNT=2
+TST_NEEDS_ROOT=1
+TST_NEEDS_CMDS="mount umount cat kill mkdir rmdir grep awk cut"
+
+# Each test case runs for 900 secs when everything fine...
+# ...so the default 5mins timeout is not enough.
+LTP_TIMEOUT_MUL=7
+
+. tst_test.sh
+. cgroup_lib.sh
+
+do_setup()
 {
-	if [ -e /dev/memcg ]; then
-		umount /dev/memcg 2>/dev/null
-		rmdir /dev/memcg 2>/dev/null
+	if ! is_cgroup_subsystem_available_and_enabled "memory";then
+		tst_res TWARN "Either Kernel does not support MEMORY resource controller or feature not enabled"
+		tst_brk TCONF ignored "Skipping all memory cgroup testcases...."
 	fi
+
+	echo 3 > /proc/sys/vm/drop_caches
+	sleep 2
+	local mem_free=`cat /proc/meminfo | grep MemFree | awk '{ print $2 }'`
+	local swap_free=`cat /proc/meminfo | grep SwapFree | awk '{ print $2 }'`
+
+	MEM=$(( $mem_free + $swap_free / 2 ))
+	MEM=$(( $MEM / 1024 ))
+	RUN_TIME=$(( 15 * 60 ))
+
+	tst_res TINFO "Calculated available memory $MEM MB"
 }
 
+do_cleanup()
+{
+	if [ -e /dev/memcg ]; then
+		umount /dev/memcg 2> /dev/null
+		rmdir /dev/memcg 2> /dev/null
+	fi
+}
 
 do_mount()
 {
-	cleanup;
+	do_cleanup
 
 	mkdir /dev/memcg 2> /dev/null
 	mount -t cgroup -omemory memcg /dev/memcg
@@ -65,62 +65,53 @@ do_mount()
 # $4 - How long does this test run ? in second
 run_stress()
 {
-	do_mount;
+	local i
+
+	do_mount
 
 	for i in $(seq 0 $(($1-1)))
 	do
 		mkdir /dev/memcg/$i 2> /dev/null
-		./memcg_process_stress $2 $3 &
-		eval pid$i=$!
+		memcg_process_stress $2 $3 &
+		eval local pid$i=$!
 
 		eval echo \$pid$i > /dev/memcg/$i/tasks
 	done
 
 	for i in $(seq 0 $(($1-1)))
 	do
-		eval /bin/kill -s SIGUSR1 \$pid$i 2> /dev/null
+		eval kill -USR1 \$pid$i 2> /dev/null
 	done
 
 	sleep $4
 
 	for i in $(seq 0 $(($1-1)))
 	do
-		eval /bin/kill -s SIGKILL \$pid$i 2> /dev/null
+		eval kill -KILL \$pid$i 2> /dev/null
 		eval wait \$pid$i
 
 		rmdir /dev/memcg/$i 2> /dev/null
 	done
 
-	cleanup;
+	do_cleanup
 }
 
 testcase_1()
 {
-	run_stress 150 $(( ($mem-150) / 150 )) 5 $RUN_TIME
+	tst_res TINFO "testcase 1 started...it will run for $RUN_TIME secs"
+
+	run_stress 150 $(( ($MEM - 150) / 150 )) 5 $RUN_TIME
 
-	tst_resm TPASS "stress test 1 passed"
+	tst_res TPASS "stress test 1 passed"
 }
 
 testcase_2()
 {
-	run_stress 1 $mem 5 $RUN_TIME
+	tst_res TINFO "testcase 2 started...it will run for $RUN_TIME secs"
 
-	tst_resm TPASS "stress test 2 passed"
-}
-
-echo 3 > /proc/sys/vm/drop_caches
-sleep 2
-mem_free=`cat /proc/meminfo | grep MemFree | awk '{ print $2 }'`
-swap_free=`cat /proc/meminfo | grep SwapFree | awk '{ print $2 }'`
+	run_stress 1 $MEM 5 $RUN_TIME
 
-mem=$(( $mem_free + $swap_free / 2 ))
-mem=$(( mem / 1024 ))
-
-date
-export TST_COUNT=$(( $TST_COUNT + 1 ))
-testcase_1
-export TST_COUNT=$(( $TST_COUNT + 1 ))
-testcase_2
-date
+	tst_res TPASS "stress test 2 passed"
+}
 
-exit 0
+tst_run
-- 
2.17.1

