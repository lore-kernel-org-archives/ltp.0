Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1YxAgS-0004Yj-JT
	for ltp-list@lists.sourceforge.net; Tue, 26 May 2015 08:58:00 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YxAgQ-0005EM-Q2
	for ltp-list@lists.sourceforge.net; Tue, 26 May 2015 08:58:00 +0000
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t4Q8uQ8g002943
	for <ltp-list@lists.sourceforge.net>; Tue, 26 May 2015 16:56:26 +0800
Message-ID: <1432630734.31833.5.camel@G08FNSTD140232>
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Tue, 26 May 2015 16:58:54 +0800
MIME-Version: 1.0
Subject: [LTP] [PATCH] cpuset: regression test for "system crash if
 cpuset_cpumask_can_shrink() is passed an empty cpumask"
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
To: ltp-list <ltp-list@lists.sourceforge.net>

This fixed by:
commit bb2bc55a694d45cdeda91b6f28ab2adec28125ef
Author: Mike Galbraith <umgwanakikbuti@gmail.com>
Date:   Wed Jan 28 04:53:55 2015 +0100

    sched: Fix crash if cpuset_cpumask_can_shrink() is passed an empty cpumask

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 .../controllers/cpuset/cpuset_regression_test.sh   | 146 +++++++++++++++++++++
 1 file changed, 146 insertions(+)
 create mode 100755 testcases/kernel/controllers/cpuset/cpuset_regression_test.sh

diff --git a/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh b/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh
new file mode 100755
index 0000000..fa06326
--- /dev/null
+++ b/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh
@@ -0,0 +1,146 @@
+#!/bin/sh
+#
+# Copyright (c) 2015 Fujitsu Ltd.
+# Author: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write to the Free Software
+# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+#
+# This is a regression test for commit:
+# http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/
+# ?id=bb2bc55
+#
+
+TCID=cpuset_regression_test
+TST_TOTAL=1
+. test.sh
+
+setup()
+{
+	tst_require_root
+
+	tst_kvercmp 3 18 0
+	if [ $? -eq 0 ]; then
+		tst_brkm TCONF "Test must be run with kernel 3.18.0 or newer"
+	fi
+
+	local cpu_num=$(grep processor /proc/cpuinfo | wc -l)
+	if [ $cpu_num -lt 2 ]; then
+		tst_brkm TCONF "We need 2 cpus at least to have test"
+	fi
+
+	tst_tmpdir
+}
+
+setup1()
+{
+	# We need to mount cpuset if it is not found.
+	mount_flag=0
+	mount | grep -w cpuset > tmpfile
+	if [ $? -eq 0 ]; then
+		root_cpuset_dir=$(cat tmpfile | awk '{print $3}')
+		rm -rf tmpfile
+	else
+		root_cpuset_dir="cpuset_test"
+
+		ROD_SILENT mkdir -p ${root_cpuset_dir}
+
+		ROD_SILENT mount -t cpuset cpuset ${root_cpuset_dir}
+
+		mount_flag=1
+	fi
+
+	if [ -f ${root_cpuset_dir}/cpuset.cpu_exclusive ]; then
+		cpu_exclusive=cpuset.cpu_exclusive
+		cpus=cpuset.cpus
+	elif [ -f ${root_cpuset_dir}/cpu_exclusive ]; then
+		cpu_exclusive=cpu_exclusive
+		cpus=cpus
+	else
+		tst_brkm TBROK "Both cpuset.cpu_exclusive and cpu_exclusive" \
+			       "do not exist."
+	fi
+
+	local cpu_exclusive_value=$(cat ${root_cpuset_dir}/${cpu_exclusive})
+	if [ "${cpu_exclusive_value}" != "1" ];then
+		echo 1 > ${root_cpuset_dir}/${cpu_exclusive}
+		if [ $? -ne 0 ]; then
+			tst_brkm TBROK "'echo 1 >" \
+				       "${root_cpuset_dir}/${cpu_exclusive}'" \
+				       "failed"
+		fi
+	fi
+}
+
+cleanup()
+{
+	if [ -d "${root_cpuset_dir}/testdir" ]; then
+		rmdir ${root_cpuset_dir}/testdir
+	fi
+
+	if [ "${mount_flag}" == "1" ]; then
+		umount ${root_cpuset_dir}
+		if [ $? -ne 0 ]; then
+			tst_resm TWARN "umount ${root_cpuset_dir} failed"
+		fi
+
+		if [ -d "${root_cpuset_dir}" ]; then
+			rmdir ${root_cpuset_dir}
+		fi
+	fi
+
+	tst_rmdir
+}
+
+cpuset_test()
+{
+	ROD_SILENT mkdir ${root_cpuset_dir}/testdir
+
+	# Creat an exclusive cpuset.
+	echo 1 > ${root_cpuset_dir}/testdir/${cpu_exclusive}
+	if [ $? -ne 0 ]; then
+		tst_brkm TFAIL "'echo 1 >" \
+			       "${root_cpuset_dir}/testdir/${cpu_exclusive}'" \
+			       "failed"
+	fi
+
+	local cpu_exclusive_value=$(cat \
+				    ${root_cpuset_dir}/testdir/${cpu_exclusive})
+	if [ "${cpu_exclusive_value}" != "1" ]; then
+		tst_brkm TFAIL "${cpu_exclusive} is '${cpu_exclusive_value}'," \
+			       "expected '1'"
+	fi
+
+	# ${cpus} is empty at the begin, that maybe make the system *crash*.
+	echo 0-1 > ${root_cpuset_dir}/testdir/${cpus}
+	if [ $? -ne 0 ]; then
+		tst_brkm TFAIL "'echo 0-1 >" \
+			       "${root_cpuset_dir}/testdir/${cpus}' failed"
+	fi
+
+	local cpus_value=$(cat ${root_cpuset_dir}/testdir/${cpus})
+	if [ "${cpus_value}" != "0-1" ]; then
+		tst_brkm TFAIL "${cpus} is '${cpus_value}', expected '0-1'"
+	fi
+
+	tst_resm TPASS "Bug is not reproduced"
+}
+
+setup
+TST_CLEANUP=cleanup
+
+setup1
+cpuset_test
+
+tst_exit
-- 
1.8.3.1




------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
