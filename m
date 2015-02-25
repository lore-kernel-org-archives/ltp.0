Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1YQXzS-0005FC-Hb
	for ltp-list@lists.sourceforge.net; Wed, 25 Feb 2015 09:10:46 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YQXzQ-0005H7-Ty
	for ltp-list@lists.sourceforge.net; Wed, 25 Feb 2015 09:10:46 +0000
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id t1P9Advf015993
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 25 Feb 2015 09:10:39 GMT
Received: from userz7022.oracle.com (userz7022.oracle.com [156.151.31.86])
	by aserv0022.oracle.com (8.13.8/8.13.8) with ESMTP id t1P9AcQY016800
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Wed, 25 Feb 2015 09:10:38 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
	by userz7022.oracle.com (8.14.5+Sun/8.14.4) with ESMTP id
	t1P9AbXx004761
	for <ltp-list@lists.sourceforge.net>; Wed, 25 Feb 2015 09:10:38 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 25 Feb 2015 12:13:04 +0300
Message-Id: <1424855586-9818-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH 1/3] device-drivers/locking: add wrapper for
	locktorture kernel module
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
Cc: vasily.isaenko@oracle.com

This is a wrapper for locktorture kernel module (added in Linux 3.18).
The test requiers that kernel configured with CONFIG_LOCK_TORTURE_TEST.
It runs locktorture module using particular options and then inspects dmesg
output for module's test results. For more information, please read Linux
Documentation: locking/locktorture.txt

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/kernel/device-drivers/Makefile           |    1 +
 testcases/kernel/device-drivers/locking/Makefile   |   22 +++++
 .../kernel/device-drivers/locking/lock_torture.sh  |   93 ++++++++++++++++++++
 3 files changed, 116 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/device-drivers/locking/Makefile
 create mode 100755 testcases/kernel/device-drivers/locking/lock_torture.sh

diff --git a/testcases/kernel/device-drivers/Makefile b/testcases/kernel/device-drivers/Makefile
index a5a1745..551d137 100644
--- a/testcases/kernel/device-drivers/Makefile
+++ b/testcases/kernel/device-drivers/Makefile
@@ -21,6 +21,7 @@ include $(top_srcdir)/include/mk/env_pre.mk
 SUBDIRS		:= acpi \
 		   block \
 		   cpufreq \
+		   locking \
 		   pci \
 		   rcu \
 		   rtc \
diff --git a/testcases/kernel/device-drivers/locking/Makefile b/testcases/kernel/device-drivers/locking/Makefile
new file mode 100644
index 0000000..9aabff3
--- /dev/null
+++ b/testcases/kernel/device-drivers/locking/Makefile
@@ -0,0 +1,22 @@
+# Copyright (c) 2015 Oracle and/or its affiliates. All Rights Reserved.
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
+INSTALL_TARGETS		:= lock_torture.sh
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/device-drivers/locking/lock_torture.sh b/testcases/kernel/device-drivers/locking/lock_torture.sh
new file mode 100755
index 0000000..e2722dd
--- /dev/null
+++ b/testcases/kernel/device-drivers/locking/lock_torture.sh
@@ -0,0 +1,93 @@
+#!/bin/sh
+# Copyright (c) 2015 Oracle and/or its affiliates. All Rights Reserved.
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
+# This is a wrapper for locktorture kernel module. The test requiers
+# that kernel configured with CONFIG_LOCK_TORTURE_TEST. It runs locktorture
+# module using particular options and then inspects dmesg output for module's
+# test results. For more information, please read Linux Documentation:
+# locking/locktorture.txt
+
+TCID="lock_torture"
+TST_TOTAL=5
+TST_CLEANUP=cleanup
+. test.sh
+
+# default options
+test_time=60
+
+while getopts :ht: opt; do
+	case "$opt" in
+	h)
+		echo "Usage:"
+		echo "h        help"
+		echo "t x      time in seconds for each test-case"
+		exit 0
+	;;
+	t) test_time=$OPTARG ;;
+	*)
+		tst_brkm TBROK "unknown option: $opt"
+	;;
+	esac
+done
+
+cleanup()
+{
+	tst_resm TINFO "cleanup"
+	rmmod locktorture > /dev/null 2>&1
+}
+
+tst_kvercmp 3 18 0 && \
+	tst_brkm TCONF "test must be run with kernel 3.18 or newer"
+
+tst_require_root
+
+# check if module is present
+modprobe locktorture > /dev/null 2>&1 || \
+	tst_brkm TCONF "Test requires locktorture module"
+rmmod locktorture > /dev/null 2>&1
+
+trap cleanup INT
+
+lock_type="spin_lock spin_lock_irq rw_lock mutex_lock rwsem_lock"
+
+est_time=$(echo "scale=2; $test_time * $TST_TOTAL / 60 " | bc)
+tst_resm TINFO "estimate time $est_time min"
+
+for type in $lock_type; do
+
+	tst_resm TINFO "$type: running $test_time sec..."
+
+	modprobe locktorture torture_type=$type \
+	         > /dev/null 2>&1 || tst_brkm TBROK "failed to load module"
+
+	sleep $test_time
+
+	rmmod locktorture > /dev/null 2>&1 || \
+		tst_brkm TBROK "failed to unload module"
+
+	# check module status in dmesg
+	result_str=`dmesg | sed -nE '$s/.*End of test: ([A-Z]+):.*/\1/p'`
+	if [ "$result_str" = "SUCCESS" ]; then
+		tst_resm TPASS "$type: completed"
+	else
+		tst_resm TFAIL "$type: $result_str, see dmesg"
+	fi
+done
+
+tst_exit
-- 
1.7.1


------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
