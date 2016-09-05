From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon,  5 Sep 2016 17:24:13 +0200
Subject: [LTP] [PATCH V2 4/6] memcg_function_test.sh: Split
In-Reply-To: <1473089055-17782-1-git-send-email-chrubis@suse.cz>
References: <1473089055-17782-1-git-send-email-chrubis@suse.cz>
Message-ID: <1473089055-17782-4-git-send-email-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Split the memcg_function_test.sh into five tests based on what is
tested.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 runtest/controllers                                |   6 +-
 .../controllers/memcg/functional/memcg_failcnt.sh  |  58 +++++
 .../memcg/functional/memcg_force_empty.sh          |  90 +++++++
 .../memcg/functional/memcg_function_test.sh        | 286 ---------------------
 .../controllers/memcg/functional/memcg_lib.sh      |  15 ++
 .../memcg/functional/memcg_limit_in_bytes.sh       | 127 +++++++++
 .../controllers/memcg/functional/memcg_stat_rss.sh |  89 +++++++
 .../memcg/functional/memcg_subgroup_charge.sh      |  50 ++++
 8 files changed, 434 insertions(+), 287 deletions(-)
 create mode 100755 testcases/kernel/controllers/memcg/functional/memcg_failcnt.sh
 create mode 100755 testcases/kernel/controllers/memcg/functional/memcg_force_empty.sh
 delete mode 100755 testcases/kernel/controllers/memcg/functional/memcg_function_test.sh
 create mode 100755 testcases/kernel/controllers/memcg/functional/memcg_limit_in_bytes.sh
 create mode 100755 testcases/kernel/controllers/memcg/functional/memcg_stat_rss.sh
 create mode 100755 testcases/kernel/controllers/memcg/functional/memcg_subgroup_charge.sh

diff --git a/runtest/controllers b/runtest/controllers
index bec883b..d14d81e 100644
--- a/runtest/controllers
+++ b/runtest/controllers
@@ -1,7 +1,11 @@
 #DESCRIPTION:Resource Management testing
 cgroup		cgroup_regression_test.sh
 memcg_regression	memcg_regression_test.sh
-memcg_function		memcg_function_test.sh
+memcg_failcnt memcg_failcnt.sh
+memcg_force_empty memcg_force_empty.sh
+memcg_limit_in_bytes memcg_limit_in_bytes.sh
+memcg_stat_rss memcg_stat_rss.sh
+memcg_subgroup_charge memcg_subgroup_charge.sh
 memcg_max_usage_in_bytes	memcg_max_usage_in_bytes_test.sh
 memcg_move_charge_at_immigrate	memcg_move_charge_at_immigrate_test.sh
 memcg_memsw_limit_in_bytes	memcg_memsw_limit_in_bytes_test.sh
diff --git a/testcases/kernel/controllers/memcg/functional/memcg_failcnt.sh b/testcases/kernel/controllers/memcg/functional/memcg_failcnt.sh
new file mode 100755
index 0000000..d5034a5
--- /dev/null
+++ b/testcases/kernel/controllers/memcg/functional/memcg_failcnt.sh
@@ -0,0 +1,58 @@
+#!/bin/sh
+
+################################################################################
+##                                                                            ##
+## Copyright (c) 2009 FUJITSU LIMITED                                         ##
+##                                                                            ##
+## This program is free software;  you can redistribute it and#or modify      ##
+## it under the terms of the GNU General Public License as published by       ##
+## the Free Software Foundation; either version 2 of the License, or          ##
+## (at your option) any later version.                                        ##
+##                                                                            ##
+## This program is distributed in the hope that it will be useful, but        ##
+## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
+## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
+## for more details.                                                          ##
+##                                                                            ##
+## You should have received a copy of the GNU General Public License          ##
+## along with this program;  if not, write to the Free Software Foundation,   ##
+## Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA           ##
+##                                                                            ##
+## Author: Li Zefan <lizf@cn.fujitsu.com>                                     ##
+## Restructure for LTP: Shi Weihua <shiwh@cn.fujitsu.com>                     ##
+## Added memcg enable/disable functinality: Rishikesh K Rajak		      ##
+##						<risrajak@linux.vnet.ibm.com  ##
+##                                                                            ##
+################################################################################
+
+TCID="memcg_failcnt"
+TST_TOTAL=3
+
+. memcg_lib.sh
+
+# Test memory.failcnt
+testcase_1()
+{
+	echo $PAGESIZE > memory.limit_in_bytes
+	malloc_free_memory "--mmap-anon" $(($PAGESIZE*2))
+	test_failcnt "memory.failcnt"
+}
+
+testcase_2()
+{
+	echo $PAGESIZE > memory.limit_in_bytes
+	malloc_free_memory "--mmap-file" $(($PAGESIZE*2))
+	test_failcnt "memory.failcnt"
+}
+
+testcase_3()
+{
+	echo $PAGESIZE > memory.limit_in_bytes
+	malloc_free_memory "--shm" $(($PAGESIZE*2))
+	test_failcnt "memory.failcnt"
+}
+
+shmmax_setup
+LOCAL_CLEANUP=shmmax_cleanup
+run_tests
+tst_exit
diff --git a/testcases/kernel/controllers/memcg/functional/memcg_force_empty.sh b/testcases/kernel/controllers/memcg/functional/memcg_force_empty.sh
new file mode 100755
index 0000000..59cb0b5
--- /dev/null
+++ b/testcases/kernel/controllers/memcg/functional/memcg_force_empty.sh
@@ -0,0 +1,90 @@
+#!/bin/sh
+
+################################################################################
+##                                                                            ##
+## Copyright (c) 2009 FUJITSU LIMITED                                         ##
+##                                                                            ##
+## This program is free software;  you can redistribute it and#or modify      ##
+## it under the terms of the GNU General Public License as published by       ##
+## the Free Software Foundation; either version 2 of the License, or          ##
+## (at your option) any later version.                                        ##
+##                                                                            ##
+## This program is distributed in the hope that it will be useful, but        ##
+## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
+## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
+## for more details.                                                          ##
+##                                                                            ##
+## You should have received a copy of the GNU General Public License          ##
+## along with this program;  if not, write to the Free Software Foundation,   ##
+## Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA           ##
+##                                                                            ##
+## Author: Li Zefan <lizf@cn.fujitsu.com>                                     ##
+## Restructure for LTP: Shi Weihua <shiwh@cn.fujitsu.com>                     ##
+## Added memcg enable/disable functinality: Rishikesh K Rajak		      ##
+##						<risrajak@linux.vnet.ibm.com  ##
+##                                                                            ##
+################################################################################
+
+TCID="memcg_force_empty"
+TST_TOTAL=6
+
+. memcg_lib.sh
+
+# Test memory.force_empty
+testcase_1()
+{
+	memcg_process --mmap-anon -s $PAGESIZE &
+	pid=$!
+	TST_CHECKPOINT_WAIT 0
+	echo $pid > tasks
+	signal_memcg_process $pid $PAGESIZE
+	echo $pid > ../tasks
+
+	# This expects that there is swap configured
+	EXPECT_PASS echo 1 \> memory.force_empty
+
+	stop_memcg_process $pid
+}
+
+testcase_2()
+{
+	memcg_process --mmap-lock2 -s $PAGESIZE &
+	pid=$!
+	TST_CHECKPOINT_WAIT 0
+	echo $pid > tasks
+	signal_memcg_process $pid $PAGESIZE
+
+	EXPECT_FAIL echo 1 \> memory.force_empty
+
+	stop_memcg_process $pid
+}
+
+testcase_3()
+{
+	EXPECT_PASS echo 0 \> memory.force_empty
+}
+
+testcase_4()
+{
+	EXPECT_PASS echo 1.0 \> memory.force_empty
+}
+
+testcase_4()
+{
+	EXPECT_PASS echo 1xx \> memory.force_empty
+}
+
+testcase_5()
+{
+	EXPECT_PASS echo xx \> memory.force_empty
+}
+
+testcase_6()
+{
+	# writing to non-empty top mem cgroup's force_empty
+	# should return failure
+	EXPECT_FAIL echo 1 \> /dev/memcg/memory.force_empty
+}
+
+run_tests
+tst_exit
diff --git a/testcases/kernel/controllers/memcg/functional/memcg_function_test.sh b/testcases/kernel/controllers/memcg/functional/memcg_function_test.sh
deleted file mode 100755
index fadbcea..0000000
--- a/testcases/kernel/controllers/memcg/functional/memcg_function_test.sh
+++ /dev/null
@@ -1,286 +0,0 @@
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
-## Added memcg enable/disable functinality: Rishikesh K Rajak		      ##
-##						<risrajak@linux.vnet.ibm.com  ##
-##                                                                            ##
-################################################################################
-
-TCID="memcg_function_test"
-TST_TOTAL=38
-
-shmmax_cleanup()
-{
-	if [ -n "$shmmax" ]; then
-		echo "$shmmax" > /proc/sys/kernel/shmmax
-	fi
-}
-LOCAL_CLEANUP=shmmax_cleanup
-
-. memcg_lib.sh
-
-# Case 1 - 10: Test the management and counting of memory
-testcase_1()
-{
-	test_mem_stat "--mmap-anon" $PAGESIZE $PAGESIZE "rss" $PAGESIZE false
-}
-
-testcase_2()
-{
-	test_mem_stat "--mmap-file" $PAGESIZE $PAGESIZE "rss" 0 false
-}
-
-testcase_3()
-{
-	test_mem_stat "--shm -k 3" $PAGESIZE $PAGESIZE "rss" 0 false
-}
-
-testcase_4()
-{
-	test_mem_stat "--mmap-anon --mmap-file --shm" \
-		$PAGESIZE $((PAGESIZE*3)) "rss" $PAGESIZE false
-}
-
-testcase_5()
-{
-	test_mem_stat "--mmap-lock1" $PAGESIZE $PAGESIZE "rss" $PAGESIZE false
-}
-
-testcase_6()
-{
-	test_mem_stat "--mmap-anon" $PAGESIZE $PAGESIZE "rss" $PAGESIZE true
-}
-
-testcase_7()
-{
-	test_mem_stat "--mmap-file" $PAGESIZE $PAGESIZE "rss" 0 true
-}
-
-testcase_8()
-{
-	test_mem_stat "--shm -k 8" $PAGESIZE $PAGESIZE "rss" 0 true
-}
-
-testcase_9()
-{
-	test_mem_stat "--mmap-anon --mmap-file --shm" \
-		$PAGESIZE $((PAGESIZE*3)) "rss" $PAGESIZE true
-}
-
-testcase_10()
-{
-	test_mem_stat "--mmap-lock1" $PAGESIZE $PAGESIZE "rss" $PAGESIZE true
-}
-
-# Case 11 - 13: Test memory.failcnt
-testcase_11()
-{
-	echo $PAGESIZE > memory.limit_in_bytes
-	malloc_free_memory "--mmap-anon" $(($PAGESIZE*2))
-	test_failcnt "memory.failcnt"
-}
-
-testcase_12()
-{
-	echo $PAGESIZE > memory.limit_in_bytes
-	malloc_free_memory "--mmap-file" $(($PAGESIZE*2))
-	test_failcnt "memory.failcnt"
-}
-
-testcase_13()
-{
-	echo $PAGESIZE > memory.limit_in_bytes
-	malloc_free_memory "--shm" $(($PAGESIZE*2))
-	test_failcnt "memory.failcnt"
-}
-
-# Case 14 - 15: Test mmap(locked) + alloc_mem > limit_in_bytes
-testcase_14()
-{
-	test_proc_kill $PAGESIZE "--mmap-lock1" $((PAGESIZE*2)) 0
-}
-
-testcase_15()
-{
-	test_proc_kill $PAGESIZE "--mmap-lock2" $((PAGESIZE*2)) 0
-}
-
-# Case 16 - 18: Test swapoff + alloc_mem > limi_in_bytes
-testcase_16()
-{
-	swapoff -a
-	test_proc_kill $PAGESIZE "--mmap-anon" $((PAGESIZE*2)) 0
-	swapon -a
-}
-
-testcase_17()
-{
-	swapoff -a
-	test_proc_kill $PAGESIZE "--mmap-file" $((PAGESIZE*2)) 0
-	swapon -a
-}
-
-testcase_18()
-{
-	swapoff -a
-	test_proc_kill $PAGESIZE "--shm -k 18" $((PAGESIZE*2)) 0
-	swapon -a
-}
-
-# Case 19 - 21: Test limit_in_bytes == 0
-testcase_19()
-{
-	test_proc_kill 0 "--mmap-anon" $PAGESIZE 0
-}
-
-testcase_20()
-{
-	test_proc_kill 0 "--mmap-file" $PAGESIZE 0
-}
-
-testcase_21()
-{
-	test_proc_kill 0 "--shm -k 21" $PAGESIZE 0
-}
-
-# Case 22 - 24: Test limit_in_bytes will be aligned to PAGESIZE
-testcase_22()
-{
-	test_limit_in_bytes $((PAGESIZE-1)) 0
-}
-
-testcase_23()
-{
-	test_limit_in_bytes $((PAGESIZE+1)) 0
-}
-
-testcase_24()
-{
-	test_limit_in_bytes 1 0
-}
-
-# Case 25 - 28: Test invaild memory.limit_in_bytes
-testcase_25()
-{
-	tst_kvercmp 2 6 31
-	if [ $? -eq 0 ]; then
-		EXPECT_FAIL echo -1 \> memory.limit_in_bytes
-	else
-		EXPECT_PASS echo -1 \> memory.limit_in_bytes
-	fi
-}
-
-testcase_26()
-{
-	EXPECT_FAIL echo 1.0 \> memory.limit_in_bytes
-}
-
-testcase_27()
-{
-	EXPECT_FAIL echo 1xx \> memory.limit_in_bytes
-}
-
-testcase_28()
-{
-	EXPECT_FAIL echo xx \> memory.limit_in_bytes
-}
-
-# Case 29 - 35: Test memory.force_empty
-testcase_29()
-{
-	memcg_process --mmap-anon -s $PAGESIZE &
-	pid=$!
-	TST_CHECKPOINT_WAIT 0
-	echo $pid > tasks
-	signal_memcg_process $pid $PAGESIZE
-	echo $pid > ../tasks
-
-	# This expects that there is swap configured
-	EXPECT_PASS echo 1 \> memory.force_empty
-
-	stop_memcg_process $pid
-}
-
-testcase_30()
-{
-	memcg_process --mmap-lock2 -s $PAGESIZE &
-	pid=$!
-	TST_CHECKPOINT_WAIT 0
-	echo $pid > tasks
-	signal_memcg_process $pid $PAGESIZE
-
-	EXPECT_FAIL echo 1 \> memory.force_empty
-
-	stop_memcg_process $pid
-}
-
-testcase_31()
-{
-	EXPECT_PASS echo 0 \> memory.force_empty
-}
-
-testcase_32()
-{
-	EXPECT_PASS echo 1.0 \> memory.force_empty
-}
-
-testcase_33()
-{
-	EXPECT_PASS echo 1xx \> memory.force_empty
-}
-
-testcase_34()
-{
-	EXPECT_PASS echo xx \> memory.force_empty
-}
-
-testcase_35()
-{
-	# writing to non-empty top mem cgroup's force_empty
-	# should return failure
-	EXPECT_FAIL echo 1 \> /dev/memcg/memory.force_empty
-}
-
-# Case 36 - 38: Test that group and subgroup have no relationship
-testcase_36()
-{
-	test_subgroup $PAGESIZE $((2*PAGESIZE))
-}
-
-testcase_37()
-{
-	test_subgroup $PAGESIZE $PAGESIZE
-}
-
-testcase_38()
-{
-	test_subgroup $PAGESIZE 0
-}
-
-shmmax=`cat /proc/sys/kernel/shmmax`
-if [ $shmmax -lt $HUGEPAGESIZE ]; then
-	ROD echo "$HUGEPAGESIZE" \> /proc/sys/kernel/shmmax
-fi
-
-run_tests
-
-tst_exit
diff --git a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
index c34198a..1bf0143 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
@@ -69,6 +69,21 @@ cleanup()
 }
 TST_CLEANUP=cleanup
 
+shmmax_setup()
+{
+	shmmax=`cat /proc/sys/kernel/shmmax`
+	if [ $shmmax -lt $HUGEPAGESIZE ]; then
+		ROD echo "$HUGEPAGESIZE" \> /proc/sys/kernel/shmmax
+	fi
+}
+
+shmmax_cleanup()
+{
+	if [ -n "$shmmax" ]; then
+		echo "$shmmax" > /proc/sys/kernel/shmmax
+	fi
+}
+
 # Check size in memcg
 # $1 - Item name
 # $2 - Expected size
diff --git a/testcases/kernel/controllers/memcg/functional/memcg_limit_in_bytes.sh b/testcases/kernel/controllers/memcg/functional/memcg_limit_in_bytes.sh
new file mode 100755
index 0000000..8ada7d1
--- /dev/null
+++ b/testcases/kernel/controllers/memcg/functional/memcg_limit_in_bytes.sh
@@ -0,0 +1,127 @@
+#!/bin/sh
+
+################################################################################
+##                                                                            ##
+## Copyright (c) 2009 FUJITSU LIMITED                                         ##
+##                                                                            ##
+## This program is free software;  you can redistribute it and#or modify      ##
+## it under the terms of the GNU General Public License as published by       ##
+## the Free Software Foundation; either version 2 of the License, or          ##
+## (at your option) any later version.                                        ##
+##                                                                            ##
+## This program is distributed in the hope that it will be useful, but        ##
+## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
+## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
+## for more details.                                                          ##
+##                                                                            ##
+## You should have received a copy of the GNU General Public License          ##
+## along with this program;  if not, write to the Free Software Foundation,   ##
+## Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA           ##
+##                                                                            ##
+## Author: Li Zefan <lizf@cn.fujitsu.com>                                     ##
+## Restructure for LTP: Shi Weihua <shiwh@cn.fujitsu.com>                     ##
+## Added memcg enable/disable functinality: Rishikesh K Rajak		      ##
+##						<risrajak@linux.vnet.ibm.com  ##
+##                                                                            ##
+################################################################################
+
+TCID="memcg_limit_in_bytes"
+TST_TOTAL=15
+
+. memcg_lib.sh
+
+# Test mmap(locked) + alloc_mem > limit_in_bytes
+testcase_1()
+{
+	test_proc_kill $PAGESIZE "--mmap-lock1" $((PAGESIZE*2)) 0
+}
+
+testcase_2()
+{
+	test_proc_kill $PAGESIZE "--mmap-lock2" $((PAGESIZE*2)) 0
+}
+
+# Test swapoff + alloc_mem > limit_in_bytes
+testcase_3()
+{
+	swapoff -a
+	test_proc_kill $PAGESIZE "--mmap-anon" $((PAGESIZE*2)) 0
+	swapon -a
+}
+
+testcase_4()
+{
+	swapoff -a
+	test_proc_kill $PAGESIZE "--mmap-file" $((PAGESIZE*2)) 0
+	swapon -a
+}
+
+testcase_5()
+{
+	swapoff -a
+	test_proc_kill $PAGESIZE "--shm -k 18" $((PAGESIZE*2)) 0
+	swapon -a
+}
+
+# Test limit_in_bytes == 0
+testcase_6()
+{
+	test_proc_kill 0 "--mmap-anon" $PAGESIZE 0
+}
+
+testcase_7()
+{
+	test_proc_kill 0 "--mmap-file" $PAGESIZE 0
+}
+
+testcase_8()
+{
+	test_proc_kill 0 "--shm -k 21" $PAGESIZE 0
+}
+
+# Test limit_in_bytes will be aligned to PAGESIZE
+testcase_9()
+{
+	test_limit_in_bytes $((PAGESIZE-1)) 0
+}
+
+testcase_10()
+{
+	test_limit_in_bytes $((PAGESIZE+1)) 0
+}
+
+testcase_11()
+{
+	test_limit_in_bytes 1 0
+}
+
+# Test invalid memory.limit_in_bytes
+testcase_12()
+{
+	tst_kvercmp 2 6 31
+	if [ $? -eq 0 ]; then
+		EXPECT_FAIL echo -1 \> memory.limit_in_bytes
+	else
+		EXPECT_PASS echo -1 \> memory.limit_in_bytes
+	fi
+}
+
+testcase_13()
+{
+	EXPECT_FAIL echo 1.0 \> memory.limit_in_bytes
+}
+
+testcase_14()
+{
+	EXPECT_FAIL echo 1xx \> memory.limit_in_bytes
+}
+
+testcase_15()
+{
+	EXPECT_FAIL echo xx \> memory.limit_in_bytes
+}
+
+shmmax_setup
+LOCAL_CLEANUP=shmmax_cleanup
+run_tests
+tst_exit
diff --git a/testcases/kernel/controllers/memcg/functional/memcg_stat_rss.sh b/testcases/kernel/controllers/memcg/functional/memcg_stat_rss.sh
new file mode 100755
index 0000000..a41e157
--- /dev/null
+++ b/testcases/kernel/controllers/memcg/functional/memcg_stat_rss.sh
@@ -0,0 +1,89 @@
+#!/bin/sh
+
+################################################################################
+##                                                                            ##
+## Copyright (c) 2009 FUJITSU LIMITED                                         ##
+##                                                                            ##
+## This program is free software;  you can redistribute it and#or modify      ##
+## it under the terms of the GNU General Public License as published by       ##
+## the Free Software Foundation; either version 2 of the License, or          ##
+## (at your option) any later version.                                        ##
+##                                                                            ##
+## This program is distributed in the hope that it will be useful, but        ##
+## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
+## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
+## for more details.                                                          ##
+##                                                                            ##
+## You should have received a copy of the GNU General Public License          ##
+## along with this program;  if not, write to the Free Software Foundation,   ##
+## Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA           ##
+##                                                                            ##
+## Author: Li Zefan <lizf@cn.fujitsu.com>                                     ##
+## Restructure for LTP: Shi Weihua <shiwh@cn.fujitsu.com>                     ##
+## Added memcg enable/disable functinality: Rishikesh K Rajak		      ##
+##						<risrajak@linux.vnet.ibm.com  ##
+##                                                                            ##
+################################################################################
+
+TCID="memcg_stat_rss"
+TST_TOTAL=10
+
+. memcg_lib.sh
+
+# Test the management and counting of memory
+testcase_1()
+{
+	test_mem_stat "--mmap-anon" $PAGESIZE $PAGESIZE "rss" $PAGESIZE false
+}
+
+testcase_2()
+{
+	test_mem_stat "--mmap-file" $PAGESIZE $PAGESIZE "rss" 0 false
+}
+
+testcase_3()
+{
+	test_mem_stat "--shm -k 3" $PAGESIZE $PAGESIZE "rss" 0 false
+}
+
+testcase_4()
+{
+	test_mem_stat "--mmap-anon --mmap-file --shm" \
+		$PAGESIZE $((PAGESIZE*3)) "rss" $PAGESIZE false
+}
+
+testcase_5()
+{
+	test_mem_stat "--mmap-lock1" $PAGESIZE $PAGESIZE "rss" $PAGESIZE false
+}
+
+testcase_6()
+{
+	test_mem_stat "--mmap-anon" $PAGESIZE $PAGESIZE "rss" $PAGESIZE true
+}
+
+testcase_7()
+{
+	test_mem_stat "--mmap-file" $PAGESIZE $PAGESIZE "rss" 0 true
+}
+
+testcase_8()
+{
+	test_mem_stat "--shm -k 8" $PAGESIZE $PAGESIZE "rss" 0 true
+}
+
+testcase_9()
+{
+	test_mem_stat "--mmap-anon --mmap-file --shm" \
+		$PAGESIZE $((PAGESIZE*3)) "rss" $PAGESIZE true
+}
+
+testcase_10()
+{
+	test_mem_stat "--mmap-lock1" $PAGESIZE $PAGESIZE "rss" $PAGESIZE true
+}
+
+shmmax_setup
+LOCAL_CLEANUP=shmmax_cleanup
+run_tests
+tst_exit
diff --git a/testcases/kernel/controllers/memcg/functional/memcg_subgroup_charge.sh b/testcases/kernel/controllers/memcg/functional/memcg_subgroup_charge.sh
new file mode 100755
index 0000000..2efe291
--- /dev/null
+++ b/testcases/kernel/controllers/memcg/functional/memcg_subgroup_charge.sh
@@ -0,0 +1,50 @@
+#!/bin/sh
+
+################################################################################
+##                                                                            ##
+## Copyright (c) 2009 FUJITSU LIMITED                                         ##
+##                                                                            ##
+## This program is free software;  you can redistribute it and#or modify      ##
+## it under the terms of the GNU General Public License as published by       ##
+## the Free Software Foundation; either version 2 of the License, or          ##
+## (at your option) any later version.                                        ##
+##                                                                            ##
+## This program is distributed in the hope that it will be useful, but        ##
+## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
+## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
+## for more details.                                                          ##
+##                                                                            ##
+## You should have received a copy of the GNU General Public License          ##
+## along with this program;  if not, write to the Free Software Foundation,   ##
+## Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA           ##
+##                                                                            ##
+## Author: Li Zefan <lizf@cn.fujitsu.com>                                     ##
+## Restructure for LTP: Shi Weihua <shiwh@cn.fujitsu.com>                     ##
+## Added memcg enable/disable functinality: Rishikesh K Rajak		      ##
+##						<risrajak@linux.vnet.ibm.com  ##
+##                                                                            ##
+################################################################################
+
+TCID="memcg_subgroup_charge"
+TST_TOTAL=3
+
+. memcg_lib.sh
+
+# Case 36 - 38: Test that group and subgroup have no relationship
+testcase_36()
+{
+	test_subgroup $PAGESIZE $((2*PAGESIZE))
+}
+
+testcase_37()
+{
+	test_subgroup $PAGESIZE $PAGESIZE
+}
+
+testcase_38()
+{
+	test_subgroup $PAGESIZE 0
+}
+
+run_tests
+tst_exit
-- 
2.7.3

