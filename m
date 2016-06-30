From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 30 Jun 2016 19:03:01 +0300
Subject: [LTP] [PATCH 2/2] network/busy_poll: test UDP socket
In-Reply-To: <1467302581-24491-1-git-send-email-alexey.kodanev@oracle.com>
References: <1467302581-24491-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1467302581-24491-2-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 runtest/net.features                       |    3 +
 testcases/lib/test_net.sh                  |    2 +-
 testcases/network/busy_poll/Makefile       |    5 +-
 testcases/network/busy_poll/busy_poll03.sh |   78 ++++++++++++++++++++++++++++
 4 files changed, 85 insertions(+), 3 deletions(-)
 create mode 100755 testcases/network/busy_poll/busy_poll03.sh

diff --git a/runtest/net.features b/runtest/net.features
index bb907e5..a64028b 100644
--- a/runtest/net.features
+++ b/runtest/net.features
@@ -8,6 +8,9 @@ busy_poll01_ipv6 busy_poll01.sh -6
 busy_poll02 busy_poll02.sh
 busy_poll02_ipv6 busy_poll02.sh -6
 
+busy_poll03 busy_poll03.sh
+busy_poll03_ipv6 busy_poll03.sh -6
+
 tcp_fastopen tcp_fastopen_run.sh
 tcp_fastopen6 tcp_fastopen_run.sh -6
 
diff --git a/testcases/lib/test_net.sh b/testcases/lib/test_net.sh
index 2e34626..5b79076 100644
--- a/testcases/lib/test_net.sh
+++ b/testcases/lib/test_net.sh
@@ -291,7 +291,7 @@ tst_netload()
 		# check that tcp_fastopen on rhost in 'Listening' state
 		local sec_waited=
 		for sec_waited in $(seq 1 60); do
-			tst_rhost_run -c "ss -ltn | grep -q $port" && break
+			tst_rhost_run -c "ss -lutn | grep -q $port" && break
 			if [ $sec_waited -eq 60 ]; then
 				tst_resm TINFO "rhost not in LISTEN state"
 				return 1
diff --git a/testcases/network/busy_poll/Makefile b/testcases/network/busy_poll/Makefile
index 4fad061..79aaf30 100644
--- a/testcases/network/busy_poll/Makefile
+++ b/testcases/network/busy_poll/Makefile
@@ -1,4 +1,4 @@
-# Copyright (c) 2015 Oracle and/or its affiliates. All Rights Reserved.
+# Copyright (c) 2015-2016 Oracle and/or its affiliates. All Rights Reserved.
 #
 # This program is free software; you can redistribute it and/or
 # modify it under the terms of the GNU General Public License as
@@ -18,6 +18,7 @@ top_srcdir		?= ../../..
 include $(top_srcdir)/include/mk/testcases.mk
 
 INSTALL_TARGETS		:= busy_poll01.sh \
-			   busy_poll02.sh
+			   busy_poll02.sh \
+			   busy_poll03.sh
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/busy_poll/busy_poll03.sh b/testcases/network/busy_poll/busy_poll03.sh
new file mode 100755
index 0000000..6102e98
--- /dev/null
+++ b/testcases/network/busy_poll/busy_poll03.sh
@@ -0,0 +1,78 @@
+#!/bin/sh
+
+# Copyright (c) 2016 Oracle and/or its affiliates. All Rights Reserved.
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
+TCID="busy_poll03"
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
+	tst_netload $(tst_ipaddr rhost) res_$x TFO -b $x -U || \
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

