From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 29 Jan 2018 14:41:15 +0300
Subject: [LTP] [PATCH 8/9] network: add new test-cases with UDP LITE protocol
In-Reply-To: <1517226076-26436-1-git-send-email-alexey.kodanev@oracle.com>
References: <1517226076-26436-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1517226076-26436-9-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Updated tests: busy_poll03, dccp01 and udp_ipsec.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/busy_poll/busy_poll03.sh    |   32 ++++++++++++++----------
 testcases/network/dccp/dccp01.sh              |   28 ++++++++++++++-------
 testcases/network/stress/udp/udp_ipsec.sh     |    7 +++--
 testcases/network/stress/udp/udp_ipsec_vti.sh |    7 +++--
 4 files changed, 45 insertions(+), 29 deletions(-)

diff --git a/testcases/network/busy_poll/busy_poll03.sh b/testcases/network/busy_poll/busy_poll03.sh
index 80e0de3..6ccbbd9 100755
--- a/testcases/network/busy_poll/busy_poll03.sh
+++ b/testcases/network/busy_poll/busy_poll03.sh
@@ -1,5 +1,5 @@
 #!/bin/sh
-# Copyright (c) 2016 Oracle and/or its affiliates. All Rights Reserved.
+# Copyright (c) 2016-2018 Oracle and/or its affiliates.
 #
 # This program is free software; you can redistribute it and/or
 # modify it under the terms of the GNU General Public License as
@@ -17,7 +17,7 @@
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 #
 
-TST_TOTAL=1
+TST_TOTAL=2
 TCID="busy_poll03"
 TST_NEEDS_TMPDIR=1
 
@@ -45,18 +45,24 @@ rbusy_poll_old=$(tst_rhost_run -c 'cat /proc/sys/net/core/busy_poll')
 TST_CLEANUP="cleanup"
 trap "tst_brkm TBROK 'test interrupted'" INT
 
-for x in 50 0; do
-	tst_resm TINFO "set low latency busy poll to $x per socket"
-	set_busy_poll $x
-	tst_netload -H $(tst_ipaddr rhost) -d res_$x -b $x -T udp
-done
+do_test()
+{
+	for x in 50 0; do
+		tst_resm TINFO "set low latency busy poll to $x per $1 socket"
+		set_busy_poll $x
+		tst_netload -H $(tst_ipaddr rhost) -d res_$x -b $x -T $1
+	done
+
+	poll_cmp=$(( 100 - ($(cat res_50) * 100) / $(cat res_0) ))
 
-poll_cmp=$(( 100 - ($(cat res_50) * 100) / $(cat res_0) ))
+	if [ "$poll_cmp" -lt 1 ]; then
+		tst_resm TFAIL "busy poll result is '$poll_cmp' %"
+	else
+		tst_resm TPASS "busy poll increased performance by '$poll_cmp' %"
+	fi
+}
 
-if [ "$poll_cmp" -lt 1 ]; then
-	tst_resm TFAIL "busy poll result is '$poll_cmp' %"
-else
-	tst_resm TPASS "busy poll increased performance by '$poll_cmp' %"
-fi
+do_test udp
+do_test udp_lite
 
 tst_exit
diff --git a/testcases/network/dccp/dccp01.sh b/testcases/network/dccp/dccp01.sh
index 0475588..9de7f92 100755
--- a/testcases/network/dccp/dccp01.sh
+++ b/testcases/network/dccp/dccp01.sh
@@ -33,23 +33,31 @@ setup()
 	tst_require_root
 }
 
+compare()
+{
+	local per=$(( $res0 * 100 / $res1 - 100 ))
+
+	if [ "$per" -gt "100" -o "$per" -lt "-100" ]; then
+		tst_resm TFAIL "$1 performance $per %"
+	else
+		tst_resm TPASS "$1 performance $per % in range -100 ... 100 %"
+	fi
+}
+
 test_run()
 {
-	tst_resm TINFO "compare UDP/DCCP performance"
+	tst_resm TINFO "compare UDP/DCCP/UDPLITE performance"
 
 	tst_netload -H $(tst_ipaddr rhost) -T udp
-	local res0="$(cat tst_netload.res)"
+	res0="$(cat tst_netload.res)"
 
 	tst_netload -H $(tst_ipaddr rhost) -T dccp
-	local res1="$(cat tst_netload.res)"
-
-	local per=$(( $res0 * 100 / $res1 - 100 ))
+	res1="$(cat tst_netload.res)"
+	compare dccp
 
-	if [ "$per" -gt "100" -o "$per" -lt "-100" ]; then
-		tst_resm TFAIL "dccp performance $per %"
-	else
-		tst_resm TPASS "dccp performance $per % in range -100 ... 100 %"
-	fi
+	tst_netload -H $(tst_ipaddr rhost) -T udp_lite
+	res1="$(cat tst_netload.res)"
+	compare udplite
 }
 
 setup
diff --git a/testcases/network/stress/udp/udp_ipsec.sh b/testcases/network/stress/udp/udp_ipsec.sh
index ef9c31e..4ebf087 100755
--- a/testcases/network/stress/udp/udp_ipsec.sh
+++ b/testcases/network/stress/udp/udp_ipsec.sh
@@ -17,7 +17,7 @@
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 
 TCID=udp_ipsec
-TST_TOTAL=3
+TST_TOTAL=6
 TST_NEEDS_TMPDIR=1
 TST_CLEANUP="tst_ipsec_cleanup"
 
@@ -35,13 +35,14 @@ do_setup()
 do_test()
 {
 	for p in $IPSEC_SIZE_ARRAY; do
-		tst_netload -H $(tst_ipaddr rhost) -T udp -n $p -N $p \
+		tst_netload -H $(tst_ipaddr rhost) -T $1 -n $p -N $p \
 			-r $IPSEC_REQUESTS
 	done
 }
 
 do_setup
 
-do_test
+do_test udp
+do_test udp_lite
 
 tst_exit
diff --git a/testcases/network/stress/udp/udp_ipsec_vti.sh b/testcases/network/stress/udp/udp_ipsec_vti.sh
index c6d76c1..36a50bb 100755
--- a/testcases/network/stress/udp/udp_ipsec_vti.sh
+++ b/testcases/network/stress/udp/udp_ipsec_vti.sh
@@ -17,7 +17,7 @@
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 
 TCID=udp_ipsec_vti
-TST_TOTAL=3
+TST_TOTAL=6
 TST_NEEDS_TMPDIR=1
 TST_CLEANUP="tst_ipsec_cleanup"
 
@@ -26,13 +26,14 @@ TST_CLEANUP="tst_ipsec_cleanup"
 do_test()
 {
 	for p in $IPSEC_SIZE_ARRAY; do
-		tst_netload -H $ip_rmt_tun -T udp -n $p -N $p \
+		tst_netload -H $ip_rmt_tun -T $1 -n $p -N $p \
 			-r $IPSEC_REQUESTS
 	done
 }
 
 tst_ipsec_setup_vti
 
-do_test
+do_test udp
+do_test udp_lite
 
 tst_exit
-- 
1.7.1

