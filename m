From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 14 Jun 2018 19:04:56 +0300
Subject: [LTP] [PATCH 3/4] network/busy_poll: convert to new API
In-Reply-To: <1528992297-23920-1-git-send-email-alexey.kodanev@oracle.com>
References: <1528992297-23920-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1528992297-23920-3-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/busy_poll/busy_poll01.sh   |   53 ++++++++++++-------------
 testcases/network/busy_poll/busy_poll02.sh   |   49 +++++++++++-------------
 testcases/network/busy_poll/busy_poll03.sh   |   35 +++++++----------
 testcases/network/busy_poll/busy_poll_lib.sh |   44 ++++++++++++----------
 4 files changed, 86 insertions(+), 95 deletions(-)

diff --git a/testcases/network/busy_poll/busy_poll01.sh b/testcases/network/busy_poll/busy_poll01.sh
index 5c59643..1749e52 100755
--- a/testcases/network/busy_poll/busy_poll01.sh
+++ b/testcases/network/busy_poll/busy_poll01.sh
@@ -4,18 +4,10 @@
 #
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 
-TST_TOTAL=1
-TCID="busy_poll01"
-TST_NEEDS_TMPDIR=1
-
-TST_USE_LEGACY_API=1
-. tst_net.sh
 . busy_poll_lib.sh
 
 cleanup()
 {
-	tst_rmdir
-
 	sysctl -q -w net.core.busy_read=$busy_read_old
 	sysctl -q -w net.core.busy_poll=$busy_poll_old
 
@@ -33,27 +25,32 @@ set_busy_poll()
 	tst_rhost_run -s -c "sysctl -q -w net.core.busy_poll=$value"
 }
 
-busy_read_old="$(cat /proc/sys/net/core/busy_read)"
-busy_poll_old="$(cat /proc/sys/net/core/busy_poll)"
-
-rbusy_read_old=$(tst_rhost_run -c 'cat /proc/sys/net/core/busy_read')
-rbusy_poll_old=$(tst_rhost_run -c 'cat /proc/sys/net/core/busy_poll')
-
-TST_CLEANUP="cleanup"
-trap "tst_brkm TBROK 'test interrupted'" INT
+setup()
+{
+	busy_poll_check_config
 
-for x in 50 0; do
-	tst_resm TINFO "set low latency busy poll to $x"
-	set_busy_poll $x
-	tst_netload -H $(tst_ipaddr rhost) -n 10 -N 10 -d res_$x
-done
+	busy_read_old="$(cat /proc/sys/net/core/busy_read)"
+	busy_poll_old="$(cat /proc/sys/net/core/busy_poll)"
 
-poll_cmp=$(( 100 - ($(cat res_50) * 100) / $(cat res_0) ))
+	rbusy_read_old=$(tst_rhost_run -c 'cat /proc/sys/net/core/busy_read')
+	rbusy_poll_old=$(tst_rhost_run -c 'cat /proc/sys/net/core/busy_poll')
+}
 
-if [ "$poll_cmp" -lt 1 ]; then
-	tst_resm TFAIL "busy poll result is '$poll_cmp' %"
-else
-	tst_resm TPASS "busy poll increased performance by '$poll_cmp' %"
-fi
+test()
+{
+	for x in 50 0; do
+		tst_res TINFO "set low latency busy poll to $x"
+		set_busy_poll $x
+		tst_netload -H $(tst_ipaddr rhost) -n 10 -N 10 -d res_$x
+	done
+
+	local poll_cmp=$(( 100 - ($(cat res_50) * 100) / $(cat res_0) ))
+
+	if [ "$poll_cmp" -lt 1 ]; then
+		tst_res TFAIL "busy poll result is '$poll_cmp' %"
+	else
+		tst_res TPASS "busy poll increased performance by '$poll_cmp' %"
+	fi
+}
 
-tst_exit
+tst_run
diff --git a/testcases/network/busy_poll/busy_poll02.sh b/testcases/network/busy_poll/busy_poll02.sh
index f0e4a0e..d0083c2 100755
--- a/testcases/network/busy_poll/busy_poll02.sh
+++ b/testcases/network/busy_poll/busy_poll02.sh
@@ -4,18 +4,10 @@
 #
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 
-TST_TOTAL=1
-TCID="busy_poll02"
-TST_NEEDS_TMPDIR=1
-
-TST_USE_LEGACY_API=1
-. tst_net.sh
 . busy_poll_lib.sh
 
 cleanup()
 {
-	tst_rmdir
-
 	sysctl -q -w net.core.busy_poll=$busy_poll_old
 	tst_rhost_run -c "sysctl -q -w net.core.busy_poll=$rbusy_poll_old"
 }
@@ -27,24 +19,29 @@ set_busy_poll()
 	tst_rhost_run -s -c "sysctl -q -w net.core.busy_poll=$value"
 }
 
-busy_poll_old="$(cat /proc/sys/net/core/busy_poll)"
-rbusy_poll_old=$(tst_rhost_run -c 'cat /proc/sys/net/core/busy_poll')
-
-TST_CLEANUP="cleanup"
-trap "tst_brkm TBROK 'test interrupted'" INT
-
-for x in 50 0; do
-	tst_resm TINFO "set low latency busy poll to $x per socket"
-	set_busy_poll $x
-	tst_netload -H $(tst_ipaddr rhost) -n 10 -N 10 -d res_$x -b $x
-done
+setup()
+{
+	busy_poll_check_config
 
-poll_cmp=$(( 100 - ($(cat res_50) * 100) / $(cat res_0) ))
+	busy_poll_old="$(cat /proc/sys/net/core/busy_poll)"
+	rbusy_poll_old=$(tst_rhost_run -c 'cat /proc/sys/net/core/busy_poll')
+}
 
-if [ "$poll_cmp" -lt 1 ]; then
-	tst_resm TFAIL "busy poll result is '$poll_cmp' %"
-else
-	tst_resm TPASS "busy poll increased performance by '$poll_cmp' %"
-fi
+test()
+{
+	for x in 50 0; do
+		tst_res TINFO "set low latency busy poll to $x per socket"
+		set_busy_poll $x
+		tst_netload -H $(tst_ipaddr rhost) -n 10 -N 10 -d res_$x -b $x
+	done
+
+	local poll_cmp=$(( 100 - ($(cat res_50) * 100) / $(cat res_0) ))
+
+	if [ "$poll_cmp" -lt 1 ]; then
+		tst_res TFAIL "busy poll result is '$poll_cmp' %"
+	else
+		tst_res TPASS "busy poll increased performance by '$poll_cmp' %"
+	fi
+}
 
-tst_exit
+tst_run
diff --git a/testcases/network/busy_poll/busy_poll03.sh b/testcases/network/busy_poll/busy_poll03.sh
index b5fb28e..b55e220 100755
--- a/testcases/network/busy_poll/busy_poll03.sh
+++ b/testcases/network/busy_poll/busy_poll03.sh
@@ -4,18 +4,12 @@
 #
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 
-TST_TOTAL=2
-TCID="busy_poll03"
-TST_NEEDS_TMPDIR=1
+TST_TEST_DATA="udp udp_lite"
 
-TST_USE_LEGACY_API=1
-. tst_net.sh
 . busy_poll_lib.sh
 
 cleanup()
 {
-	tst_rmdir
-
 	sysctl -q -w net.core.busy_poll=$busy_poll_old
 	tst_rhost_run -c "sysctl -q -w net.core.busy_poll=$rbusy_poll_old"
 }
@@ -27,31 +21,30 @@ set_busy_poll()
 	tst_rhost_run -s -c "sysctl -q -w net.core.busy_poll=$value"
 }
 
-busy_poll_old="$(cat /proc/sys/net/core/busy_poll)"
-rbusy_poll_old=$(tst_rhost_run -c 'cat /proc/sys/net/core/busy_poll')
+setup()
+{
+	busy_poll_check_config
 
-TST_CLEANUP="cleanup"
-trap "tst_brkm TBROK 'test interrupted'" INT
+	busy_poll_old="$(cat /proc/sys/net/core/busy_poll)"
+	rbusy_poll_old=$(tst_rhost_run -c 'cat /proc/sys/net/core/busy_poll')
+}
 
-do_test()
+test()
 {
 	for x in 50 0; do
-		tst_resm TINFO "set low latency busy poll to $x per $1 socket"
+		tst_res TINFO "set low latency busy poll to $x per $2 socket"
 		set_busy_poll $x
 		tst_netload -H $(tst_ipaddr rhost) -n 10 -N 10 -d res_$x \
-			    -b $x -T $1
+			    -b $x -T $2
 	done
 
-	poll_cmp=$(( 100 - ($(cat res_50) * 100) / $(cat res_0) ))
+	local poll_cmp=$(( 100 - ($(cat res_50) * 100) / $(cat res_0) ))
 
 	if [ "$poll_cmp" -lt 1 ]; then
-		tst_resm TFAIL "busy poll result is '$poll_cmp' %"
+		tst_res TFAIL "busy poll result is '$poll_cmp' %"
 	else
-		tst_resm TPASS "busy poll increased performance by '$poll_cmp' %"
+		tst_res TPASS "busy poll increased performance by '$poll_cmp' %"
 	fi
 }
 
-do_test udp
-do_test udp_lite
-
-tst_exit
+tst_run
diff --git a/testcases/network/busy_poll/busy_poll_lib.sh b/testcases/network/busy_poll/busy_poll_lib.sh
index 6b2de07..5270a1b 100755
--- a/testcases/network/busy_poll/busy_poll_lib.sh
+++ b/testcases/network/busy_poll/busy_poll_lib.sh
@@ -2,28 +2,32 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2016-2018 Oracle and/or its affiliates. All Rights Reserved.
 
+TST_SETUP="setup"
+TST_TESTFUNC="test"
+TST_CLEANUP="cleanup"
+TST_MIN_KVER="3.11"
+TST_NEEDS_TMPDIR=1
+TST_NEEDS_ROOT=1
+TST_NEEDS_CMDS="pkill sysctl ethtool"
 # for more stable results set to a single thread
 TST_NETLOAD_CLN_NUMBER=1
 
-if tst_kvcmp -lt "3.11"; then
-	tst_brkm TCONF "test must be run with kernel 3.11 or newer"
-fi
+. tst_net.sh
 
-if [ ! -f "/proc/sys/net/core/busy_read" -a \
-     ! -f "/proc/sys/net/core/busy_poll" ]; then
-	tst_brkm TCONF "busy poll not configured, CONFIG_NET_RX_BUSY_POLL"
-fi
+busy_poll_check_config()
+{
+	if [ ! -f "/proc/sys/net/core/busy_read" -a \
+	     ! -f "/proc/sys/net/core/busy_poll" ]; then
+		tst_brk TCONF "busy poll not configured, CONFIG_NET_RX_BUSY_POLL"
+	fi
 
-tst_check_cmds pkill sysctl ethtool
-
-if tst_kvcmp -lt "4.5"; then
-	ethtool --show-features $(tst_iface) | \
-		grep -q 'busy-poll.*on' || \
-		tst_brkm TCONF "busy poll not supported by driver"
-else
-	drvs="bnx2x|bnxt|cxgb4|enic|benet|ixgbe|ixgbevf|mlx4|mlx5|myri10ge|sfc|virtio"
-	ethtool -i $(tst_iface) | grep -qE "driver: ($drvs)" || \
-		tst_brkm TCONF "busy poll not supported"
-fi
-
-tst_require_root
+	if tst_kvcmp -lt "4.5"; then
+		ethtool --show-features $(tst_iface) | \
+			grep -q 'busy-poll.*on' || \
+			tst_brk TCONF "busy poll not supported by driver"
+	else
+		drvs="bnx2x|bnxt|cxgb4|enic|benet|ixgbe|ixgbevf|mlx4|mlx5|myri10ge|sfc|virtio"
+		ethtool -i $(tst_iface) | grep -qE "driver: ($drvs)" || \
+			tst_brk TCONF "busy poll not supported"
+	fi
+}
-- 
1.7.1

