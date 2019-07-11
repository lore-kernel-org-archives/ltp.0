From: Xiao Yang <ice_yangxiao@163.com>
Date: Thu, 11 Jul 2019 19:10:29 +0800
Subject: [LTP] [PATCH v4] rcu/rcu_torture.sh: Rewrite test
Message-ID: <1562843429-4633-1-git-send-email-ice_yangxiao@163.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1) Cleanup and convert to new API
2) Update valid rcutorture types(rcu, srcu, srcud, tasks)

Note:
Exclude valid busted* types(busted, busted_srcud) that check
the test itself and expect failures, suggested by:
https://www.spinics.net/lists/kernel/msg3045252.html

Reviewed-by: Alexey Kodanev <alexey.kodanev@oracle.com>
Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Acked-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Xiao Yang <ice_yangxiao@163.com>
---
 testcases/kernel/device-drivers/rcu/rcu_torture.sh | 140 +++++++++------------
 1 file changed, 62 insertions(+), 78 deletions(-)

diff --git a/testcases/kernel/device-drivers/rcu/rcu_torture.sh b/testcases/kernel/device-drivers/rcu/rcu_torture.sh
index c3739f9..bca1530 100755
--- a/testcases/kernel/device-drivers/rcu/rcu_torture.sh
+++ b/testcases/kernel/device-drivers/rcu/rcu_torture.sh
@@ -1,20 +1,7 @@
 #!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2014-2015 Oracle and/or its affiliates. All Rights Reserved.
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of
-# the License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it would be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write the Free Software Foundation,
-# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# Copyright (C) 2019 Xiao Yang <ice_yangxiao@163.com>
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 #
 # One of the possible ways to test RCU is to use rcutorture kernel module.
@@ -23,89 +10,86 @@
 # dmesg output for module's test results.
 # For more information, please read Linux Documentation: RCU/torture.txt
 
-TCID="rcu_torture"
-TST_TOTAL=14
-TST_CLEANUP=cleanup
+TST_CNT=4
+TST_SETUP=rcutorture_setup
+TST_TESTFUNC=do_test
+TST_NEEDS_ROOT=1
+TST_NEEDS_CMDS="modprobe dmesg sed tail"
+TST_OPTS="t:w:"
+TST_USAGE=rcutorture_usage
+TST_PARSE_ARGS=rcutorture_parse_args
 
-. test.sh
+. tst_test.sh
 
 # default options
-test_time=60
+test_time=30
 num_writers=5
 
-while getopts :ht:w: opt; do
-	case "$opt" in
-	h)
-		echo "Usage:"
-		echo "h        help"
-		echo "t x      time in seconds for each test-case"
-		echo "w x      number of writers"
-		exit 0
-	;;
-	t) test_time=$OPTARG ;;
-	w) num_writers=$OPTARG ;;
-	*)
-		tst_brkm TBROK "unknown option: $opt"
-	;;
-	esac
-done
-
-cleanup()
+rcutorture_usage()
 {
-	tst_resm TINFO "cleanup"
-	rmmod rcutorture > /dev/null 2>&1
+	echo "Usage:"
+	echo "-t x    time in seconds for each test-case"
+	echo "-w x    number of writers"
 }
 
-tst_require_root
-
-# check if module is present
-modprobe rcutorture > /dev/null 2>&1 || \
-	tst_brkm TCONF "Test requires rcutorture module"
-rmmod rcutorture > /dev/null 2>&1
-
-trap cleanup INT
-
-rcu_type="rcu rcu_bh srcu sched"
-
-if tst_kvcmp -lt "3.12"; then
-	rcu_type="$rcu_type rcu_sync rcu_expedited rcu_bh_sync rcu_bh_expedited \
-	          srcu_sync srcu_expedited sched_sync sched_expedited"
+rcutorture_parse_args()
+{
+	case $1 in
+	t) test_time=$2 ;;
+	w) num_writers=$2 ;;
+	esac
+}
 
-	if tst_kvcmp -lt "3.11"; then
-		rcu_type="$rcu_type srcu_raw srcu_raw_sync"
-	fi
-fi
+rcutorture_setup()
+{
+	local module=1
 
-TST_TOTAL=$(echo "$rcu_type" | wc -w)
+	# check if rcutorture is built as a kernel module by inserting
+	# and then removing it
+	modprobe -q rcutorture ||  module=
+	modprobe -qr rcutorture || module=
 
-est_time=`echo "scale=2; $test_time * $TST_TOTAL / 60 " | bc`
-tst_resm TINFO "estimate time $est_time min"
+	[ -z "$module" ] && \
+		tst_brk TCONF "rcutorture is built-in, non-existent or in use"
+}
 
-for type in $rcu_type; do
+rcutorture_test()
+{
+	local rcu_type=$1
 
-	tst_resm TINFO "$type: running $test_time sec..."
+	tst_res TINFO "$rcu_type-torture: running $test_time sec..."
 
 	modprobe rcutorture nfakewriters=$num_writers \
-	         stat_interval=60 test_no_idle_hz=1 shuffle_interval=3 \
-	         stutter=5 irqreader=1 fqs_duration=0 fqs_holdoff=0 \
-	         fqs_stutter=3 test_boost=1 test_boost_interval=7 \
-	         test_boost_duration=4 shutdown_secs=0 \
-	         stall_cpu=0 stall_cpu_holdoff=10 n_barrier_cbs=0 \
-	         onoff_interval=0 onoff_holdoff=0 torture_type=$type \
-	         > /dev/null 2>&1 || tst_brkm TBROK "failed to load module"
+		torture_type=$rcu_type >/dev/null
+	if [ $? -ne 0 ]; then
+		dmesg | grep -q "invalid torture type: \"$rcu_type\"" && \
+			tst_brk TCONF "invalid $rcu_type type"
+
+		tst_brk TBROK "failed to load module"
+	fi
 
 	sleep $test_time
 
-	rmmod rcutorture > /dev/null 2>&1 || \
-		tst_brkm TBROK "failed to unload module"
+	modprobe -r rcutorture >/dev/null || \
+		tst_brk TBROK "failed to unload module"
 
 	# check module status in dmesg
-	result_str=`dmesg | sed -nE '$s/.*End of test: ([A-Z]+):.*/\1/p'`
-	if [ "$result_str" = "SUCCESS" ]; then
-		tst_resm TPASS "$type: completed"
+	local res=$(dmesg | sed -nE "s/.* $rcu_type-torture:.* End of test: (.*): .*/\1/p" | tail -n1)
+	if [ "$res" = "SUCCESS" ]; then
+		tst_res TPASS "$rcu_type-torture: $res"
 	else
-		tst_resm TFAIL "$type: $result_str, see dmesg"
+		tst_res TFAIL "$rcu_type-torture: $res, see dmesg"
 	fi
-done
+}
+
+do_test()
+{
+	case $1 in
+	1) rcutorture_test rcu;;
+	2) rcutorture_test srcu;;
+	3) rcutorture_test srcud;;
+	4) rcutorture_test tasks;;
+	esac
+}
 
-tst_exit
+tst_run
-- 
1.8.3.1

