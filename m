Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1ZTuHR-0001Ez-1i
	for ltp-list@lists.sourceforge.net; Mon, 24 Aug 2015 16:07:29 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZTuHO-0001fb-Ri
	for ltp-list@lists.sourceforge.net; Mon, 24 Aug 2015 16:07:29 +0000
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id t7OG7KOF031732
	(version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 24 Aug 2015 16:07:21 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
	by userv0021.oracle.com (8.13.8/8.13.8) with ESMTP id t7OG7KXI006835
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Mon, 24 Aug 2015 16:07:20 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
	by userv0121.oracle.com (8.13.8/8.13.8) with ESMTP id t7OG7KkE022135
	for <ltp-list@lists.sourceforge.net>; Mon, 24 Aug 2015 16:07:20 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 24 Aug 2015 19:10:41 +0300
Message-Id: <1440432641-18320-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH] network: add test for low latency busy poll
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

The test measures the performance of TCP client/server
with and without busy poll feature, then it compares results.

Enabling of busy poll is done globally via sysctl knobs,
values are set to recommended ones (according to Linux docs).

The feature was added in Linux 3.11.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 runtest/network_stress.features            |    3 +
 testcases/network/busy_poll/Makefile       |   22 +++++++
 testcases/network/busy_poll/busy_poll01.sh |   92 ++++++++++++++++++++++++++++
 3 files changed, 117 insertions(+), 0 deletions(-)
 create mode 100644 testcases/network/busy_poll/Makefile
 create mode 100755 testcases/network/busy_poll/busy_poll01.sh

diff --git a/runtest/network_stress.features b/runtest/network_stress.features
index f48f0a7..a94e13b 100644
--- a/runtest/network_stress.features
+++ b/runtest/network_stress.features
@@ -2,6 +2,9 @@
 # Stress tests for various network features
 #
 
+busy_poll01 busy_poll01.sh
+busy_poll01_ipv6 busy_poll01.sh -6
+
 tcp_fastopen tcp_fastopen_run.sh
 tcp_fastopen6 tcp_fastopen_run.sh -6
 
diff --git a/testcases/network/busy_poll/Makefile b/testcases/network/busy_poll/Makefile
new file mode 100644
index 0000000..8624fdf
--- /dev/null
+++ b/testcases/network/busy_poll/Makefile
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
+# along with this program. If not, see <http://www.gnu.org/licenses/>.
+
+top_srcdir		?= ../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+
+INSTALL_TARGETS		:= busy_poll01.sh
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/busy_poll/busy_poll01.sh b/testcases/network/busy_poll/busy_poll01.sh
new file mode 100755
index 0000000..ecb34d7
--- /dev/null
+++ b/testcases/network/busy_poll/busy_poll01.sh
@@ -0,0 +1,92 @@
+#!/bin/sh
+
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
+# along with this program. If not, see <http://www.gnu.org/licenses/>.
+#
+# Author: Alexey Kodanev <alexey.kodanev@oracle.com>
+#
+
+TST_TOTAL=1
+TCID="busy_poll01"
+
+clients_num=2
+client_requests=500000
+max_requests=3
+
+. test_net.sh
+
+cleanup()
+{
+	tst_rhost_run -c "pkill -9 tcp_fastopen\$"
+	tst_rmdir
+
+	sysctl -q -w net.core.busy_read=$busy_read_old
+	sysctl -q -w net.core.busy_poll=$busy_poll_old
+
+	tst_rhost_run -c "sysctl -q -w net.core.busy_read=$rbusy_read_old"
+	tst_rhost_run -c "sysctl -q -w net.core.busy_poll=$rbusy_poll_old"
+}
+
+
+tst_require_root
+
+tst_kvercmp 3 11 0
+[ $? -eq 0 ] && tst_brkm TCONF "test must be run with kernel 3.11 or newer"
+
+if [ ! -f "/proc/sys/net/core/busy_read" -a \
+     ! -f "/proc/sys/net/core/busy_poll" ]; then
+	tst_brkm TCONF "busy poll not configured, CONFIG_NET_RX_BUSY_POLL"
+fi
+
+set_busy_poll()
+{
+	local value=${1:-"0"}
+	ROD_SILENT sysctl -q -w net.core.busy_read=$value
+	ROD_SILENT sysctl -q -w net.core.busy_poll=$value
+
+	tst_rhost_run -s -c "sysctl -q -w net.core.busy_read=$value"
+	tst_rhost_run -s -c "sysctl -q -w net.core.busy_poll=$value"
+}
+
+tst_check_cmds pkill sysctl
+
+tst_tmpdir
+
+busy_read_old="$(cat /proc/sys/net/core/busy_read)"
+busy_poll_old="$(cat /proc/sys/net/core/busy_poll)"
+
+rbusy_read_old=$(tst_rhost_run -c 'cat /proc/sys/net/core/busy_read')
+rbusy_poll_old=$(tst_rhost_run -c 'cat /proc/sys/net/core/busy_poll')
+
+TST_CLEANUP="cleanup"
+trap "tst_brkm TBROK 'test interrupted'" INT
+
+for x in 50 0; do
+	tst_resm TINFO "set low latency busy poll to $x"
+	set_busy_poll $x
+	tst_netload $(tst_ipaddr rhost) res_$x TFO || \
+		tst_brkm TBROK "netload() failed"
+	tst_resm TINFO "time spent is '$(cat res_$x)' ms"
+done
+
+poll_cmp=$(( 100 - ($(cat res_50) * 100) / $(cat res_0) ))
+
+if [ "$poll_cmp" -lt 1 ]; then
+	tst_resm TFAIL "busy poll result is '$poll_cmp' %"
+else
+	tst_resm TPASS "busy poll increased performance by '$poll_cmp' %"
+fi
+
+tst_exit
-- 
1.7.1


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
