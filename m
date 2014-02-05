Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1WB2fX-0001fQ-Jg
	for ltp-list@lists.sourceforge.net; Wed, 05 Feb 2014 13:37:35 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WB2fW-0007VG-Gx
	for ltp-list@lists.sourceforge.net; Wed, 05 Feb 2014 13:37:35 +0000
Received: from ucsinet21.oracle.com (ucsinet21.oracle.com [156.151.31.93])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s15DbRTC001812
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 5 Feb 2014 13:37:28 GMT
Received: from userz7021.oracle.com (userz7021.oracle.com [156.151.31.85])
	by ucsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s15DbRuZ000603
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Wed, 5 Feb 2014 13:37:27 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
	by userz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s15DbQQ7000592
	for <ltp-list@lists.sourceforge.net>; Wed, 5 Feb 2014 13:37:27 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed,  5 Feb 2014 17:37:18 +0400
Message-Id: <1391607438-529-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH] device-drivers/rcu: add wrapper script for rcutorture
	test
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: vasily.isaenko@oracle.com, Alexey Kodanev <alexey.kodanev@oracle.com>

One of the possible ways to test RCU is to use rcutorture kernel module.
The test requires that kernel configured with CONFIG_RCU_TORTURE_TEST.
It runs rcutorture module using particular options and then inspects
dmesg output for module's test results.
For more information, please read Linux Documentation: RCU/torture.txt

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 runtest/kernel_misc                                |    1 +
 testcases/kernel/device-drivers/Makefile           |    1 +
 testcases/kernel/device-drivers/rcu/Makefile       |   22 ++++
 testcases/kernel/device-drivers/rcu/rcu_torture.sh |  120 ++++++++++++++++++++
 4 files changed, 144 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/device-drivers/rcu/Makefile
 create mode 100755 testcases/kernel/device-drivers/rcu/rcu_torture.sh

diff --git a/runtest/kernel_misc b/runtest/kernel_misc
index c1826fb..8f37cc6 100644
--- a/runtest/kernel_misc
+++ b/runtest/kernel_misc
@@ -7,3 +7,4 @@ tbio tbio
 ltp_acpi ltp_acpi
 ltp_acpi_cpufreq ltp_acpi_cpufreq
 uaccess uaccess
+rcu_torture.sh rcu_torture.sh
diff --git a/testcases/kernel/device-drivers/Makefile b/testcases/kernel/device-drivers/Makefile
index d207736..37b6c64 100644
--- a/testcases/kernel/device-drivers/Makefile
+++ b/testcases/kernel/device-drivers/Makefile
@@ -21,6 +21,7 @@ include $(top_srcdir)/include/mk/env_pre.mk
 SUBDIRS		:= acpi \
 		   block \
 		   pci \
+		   rcu \
 		   rtc \
 		   tbio \
 		   uaccess
diff --git a/testcases/kernel/device-drivers/rcu/Makefile b/testcases/kernel/device-drivers/rcu/Makefile
new file mode 100644
index 0000000..96c6b5b
--- /dev/null
+++ b/testcases/kernel/device-drivers/rcu/Makefile
@@ -0,0 +1,22 @@
+# Copyright (c) 2014 Oracle and/or its affiliates. All Rights Reserved.
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation; either version 2 of
+# the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it would be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write the Free Software Foundation,
+# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+
+top_srcdir	?= ../../../..
+include $(top_srcdir)/include/mk/testcases.mk
+
+INSTALL_TARGETS		:= rcu_torture.sh
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/device-drivers/rcu/rcu_torture.sh b/testcases/kernel/device-drivers/rcu/rcu_torture.sh
new file mode 100755
index 0000000..c3db889
--- /dev/null
+++ b/testcases/kernel/device-drivers/rcu/rcu_torture.sh
@@ -0,0 +1,120 @@
+#!/bin/sh
+# Copyright (c) 2014 Oracle and/or its affiliates. All Rights Reserved.
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation; either version 2 of
+# the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it would be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write the Free Software Foundation,
+# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+#
+# Author: Alexey Kodanev <alexey.kodanev@oracle.com>
+#
+# One of the possible ways to test RCU is to use rcutorture kernel module.
+# The test requiers that kernel configured with CONFIG_RCU_TORTURE_TEST.
+# It runs rcutorture module using particular options and then inspects
+# dmesg output for module's test results.
+# For more information, please read Linux Documentation: RCU/torture.txt
+
+export RC=0
+export TST_TOTAL=14
+export TCID="rcu_torture"
+export TST_COUNT=0
+# default options
+test_time=60
+num_readers=10
+num_writers=5
+
+while getopts :ht:r:w: opt; do
+	case "$opt" in
+	h)
+		echo "Usage:"
+		echo "h        help"
+		echo "t x      time in seconds for each test-case"
+		echo "r x      number of readers"
+		echo "w x      number of writers"
+		exit 0
+	;;
+	t) test_time=$OPTARG ;;
+	r) num_readers=$OPTARG ;;
+	w) num_writers=$OPTARG ;;
+	*)
+		tst_brkm TBROK NULL "unknown option: $opt"
+		exit 2
+	;;
+	esac
+done
+
+cleanup()
+{
+	rmmod rcutorture > /dev/null 2>&1
+}
+
+if [ "`id -u`" -ne 0 ]; then
+	tst_brkm TCONF NULL "Test must be run as root"
+	exit 0
+fi
+
+# check if module is present
+modprobe rcutorture > /dev/null 2>&1
+if [ $? -ne 0 ]; then
+	tst_brkm TCONF NULL "Test requiers rcutorture module"
+	exit 0
+fi
+cleanup
+
+trap cleanup EXIT
+
+rcu_type="rcu rcu_sync rcu_expedited rcu_bh rcu_bh_sync rcu_bh_expedited \
+          srcu srcu_sync srcu_expedited srcu_raw srcu_raw_sync sched \
+          sched_sync sched_expedited"
+
+est_time=`echo "scale=2; $test_time * $TST_TOTAL / 60 " | bc`
+tst_resm TINFO "estimate time $est_time min"
+
+for type in $rcu_type; do
+
+	tst_resm TINFO "tc$TST_COUNT: $type running ($test_time sec)..."
+
+	modprobe rcutorture nreaders=$num_readers nfakewriters=$num_writers \
+	         stat_interval=60 test_no_idle_hz=1 shuffle_interval=3 \
+	         stutter=5 irqreader=1 fqs_duration=0 fqs_holdoff=0 \
+	         fqs_stutter=3 test_boost=1 test_boost_interval=7 \
+	         test_boost_duration=4 shutdown_secs=0 \
+	         stall_cpu=0 stall_cpu_holdoff=10 n_barrier_cbs=0 \
+	         onoff_interval=0 onoff_holdoff=0 torture_type=$type \
+	         > /dev/null 2>&1
+
+	if [ $? -ne 0 ]; then
+		tst_brkm TBROK NULL "failed to load module"
+		exit 2
+	fi
+
+	sleep $test_time
+
+	rmmod rcutorture > /dev/null 2>&1
+	if [ $? -ne 0 ]; then
+		tst_brkm TBROK NULL "failed to unload module"
+		exit 2
+	fi
+
+	# check module status in dmesg
+	result_str=`dmesg | tail -n 1`
+	echo "$result_str" | grep SUCCESS > /dev/null 2>&1
+	if [ $? -eq 0 ]; then
+		tst_resm TPASS "tc$TST_COUNT: completed"
+	else
+		tst_resm TFAIL "tc$TST_COUNT: failed, please check dmesg"
+		RC=1
+	fi
+	TST_COUNT=$(( $TST_COUNT + 1 ))
+done
+
+exit $RC
-- 
1.7.1


------------------------------------------------------------------------------
Managing the Performance of Cloud-Based Applications
Take advantage of what the Cloud has to offer - Avoid Common Pitfalls.
Read the Whitepaper.
http://pubads.g.doubleclick.net/gampad/clk?id=121051231&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
