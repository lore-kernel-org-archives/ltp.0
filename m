From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 16 Sep 2015 12:47:19 +0300
Subject: [LTP] [PATCH 4/4] network: add test for busy poll with setting it
	per socket
In-Reply-To: <1442396839-29900-1-git-send-email-alexey.kodanev@oracle.com>
References: <1442396839-29900-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1442396839-29900-4-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Test is very similar to busy_poll01. The difference is in setting
busy read value and enabling low latency busy poll feature.
'busy_read' is set per socket inside network load tool via
SO_BUSY_POLL option.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 runtest/network_stress.features            |    3 +
 testcases/network/busy_poll/Makefile       |    3 +-
 testcases/network/busy_poll/busy_poll02.sh |   78 ++++++++++++++++++++++++++++
 3 files changed, 83 insertions(+), 1 deletions(-)
 create mode 100755 testcases/network/busy_poll/busy_poll02.sh

diff --git a/runtest/network_stress.features b/runtest/network_stress.features
index a94e13b..668f3da 100644
--- a/runtest/network_stress.features
+++ b/runtest/network_stress.features
@@ -5,6 +5,9 @@
 busy_poll01 busy_poll01.sh
 busy_poll01_ipv6 busy_poll01.sh -6
 
+busy_poll02 busy_poll02.sh
+busy_poll02_ipv6 busy_poll02.sh -6
+
 tcp_fastopen tcp_fastopen_run.sh
 tcp_fastopen6 tcp_fastopen_run.sh -6
 
diff --git a/testcases/network/busy_poll/Makefile b/testcases/network/busy_poll/Makefile
index 8624fdf..4fad061 100644
--- a/testcases/network/busy_poll/Makefile
+++ b/testcases/network/busy_poll/Makefile
@@ -17,6 +17,7 @@ top_srcdir		?= ../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 
-INSTALL_TARGETS		:= busy_poll01.sh
+INSTALL_TARGETS		:= busy_poll01.sh \
+			   busy_poll02.sh
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/busy_poll/busy_poll02.sh b/testcases/network/busy_poll/busy_poll02.sh
new file mode 100755
index 0000000..d4dd052
--- /dev/null
+++ b/testcases/network/busy_poll/busy_poll02.sh
@@ -0,0 +1,78 @@
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
+TCID="busy_poll02"
+
+. test_net.sh
+
+cleanup()
+{
+	tst_rhost_run -c "pkill -9 tcp_fastopen\$"
+	tst_rmdir
+
+	sysctl -q -w net.core.busy_poll=$busy_poll_old
+	tst_rhost_run -c "sysctl -q -w net.core.busy_poll=$rbusy_poll_old"
+}
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
+	ROD_SILENT sysctl -q -w net.core.busy_poll=$value
+	tst_rhost_run -s -c "sysctl -q -w net.core.busy_poll=$value"
+}
+
+tst_check_cmds pkill sysctl
+
+tst_tmpdir
+
+busy_poll_old="$(cat /proc/sys/net/core/busy_poll)"
+rbusy_poll_old=$(tst_rhost_run -c 'cat /proc/sys/net/core/busy_poll')
+
+TST_CLEANUP="cleanup"
+trap "tst_brkm TBROK 'test interrupted'" INT
+
+for x in 50 0; do
+	tst_resm TINFO "set low latency busy poll to $x per socket"
+	set_busy_poll $x
+	tst_netload $(tst_ipaddr rhost) res_$x TFO -b $x || \
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

