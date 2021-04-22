From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 22 Apr 2021 16:16:28 +0300
Subject: [LTP] [PATCH 1/3] lib/tst_test.sh: add TST_IPV6_FLAG ('-6')
In-Reply-To: <20210422131630.28565-1-alexey.kodanev@oracle.com>
References: <20210422131630.28565-1-alexey.kodanev@oracle.com>
Message-ID: <20210422131630.28565-2-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Move the flag from route_lib.sh, it will also be used in
the other net tests.

It's set to blank for IPv4 and to '-6' for IPv6.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/lib/tst_net.sh                    |  4 +++-
 testcases/lib/tst_test.sh                   |  2 +-
 testcases/network/stress/route/route-lib.sh | 15 +++++++--------
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
index ee35bdd5c..fc5719057 100644
--- a/testcases/lib/tst_net.sh
+++ b/testcases/lib/tst_net.sh
@@ -18,11 +18,13 @@ TST_SETUP="tst_net_setup"
 # Blank for an IPV4 test; 6 for an IPV6 test.
 TST_IPV6=${TST_IPV6:-}
 TST_IPVER=${TST_IPV6:-4}
+# Blank for IPv4, '-6' for IPv6 test.
+TST_IPV6_FLAG=${TST_IPV6_FLAG:-}
 
 tst_net_parse_args()
 {
 	case $1 in
-	6) TST_IPV6=6 TST_IPVER=6;;
+	6) TST_IPV6=6 TST_IPVER=6 TST_IPV6_FLAG="-6";;
 	*) [ "$TST_PARSE_ARGS_CALLER" ] && $TST_PARSE_ARGS_CALLER "$1" "$2";;
 	esac
 }
diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index a6a8e9579..dcd470dfc 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -540,7 +540,7 @@ tst_run()
 			NEEDS_ROOT|NEEDS_TMPDIR|TMPDIR|NEEDS_DEVICE|DEVICE);;
 			NEEDS_CMDS|NEEDS_MODULE|MODPATH|DATAROOT);;
 			NEEDS_DRIVERS|FS_TYPE|MNTPOINT|MNT_PARAMS);;
-			IPV6|IPVER|TEST_DATA|TEST_DATA_IFS);;
+			IPV6|IPV6_FLAG|IPVER|TEST_DATA|TEST_DATA_IFS);;
 			RETRY_FUNC|RETRY_FN_EXP_BACKOFF|TIMEOUT);;
 			NET_DATAROOT|NET_MAX_PKT|NET_RHOST_RUN_DEBUG|NETLOAD_CLN_NUMBER);;
 			*) tst_res TWARN "Reserved variable TST_$_tst_i used!";;
diff --git a/testcases/network/stress/route/route-lib.sh b/testcases/network/stress/route/route-lib.sh
index a5bb96c12..194bd40cc 100644
--- a/testcases/network/stress/route/route-lib.sh
+++ b/testcases/network/stress/route/route-lib.sh
@@ -91,20 +91,19 @@ setup_if()
 
 test_netlink()
 {
+	local opt="-c $ROUTE_CHANGE_NETLINK $TST_IPV6_FLAG -p $ROUTE_RHOST_PORT $ROUTE_CHANGE_NETLINK_PARAMS"
+	local cmd="route-change-netlink"
 	local ret=0
-	local cmd ip_flag
-	[ "$TST_IPV6" ] && ip_flag="-6"
 
-	cmd="route-change-netlink -c $ROUTE_CHANGE_NETLINK $ip_flag -p $ROUTE_RHOST_PORT $ROUTE_CHANGE_NETLINK_PARAMS"
-	tst_res TINFO "running $cmd"
-	$cmd || ret=$?
+	tst_res TINFO "running $cmd $opt"
+	$cmd $opt || ret=$?
 	if [ "$ret" -ne 0 ]; then
 		[ $((ret & 3)) -ne 0 ] && \
-			tst_brk TFAIL "route-change-netlink failed"
+			tst_brk TFAIL "$cmd failed"
 		[ $((ret & 32)) -ne 0 ] && \
 			tst_brk TCONF "not supported configuration"
 		[ $((ret & 4)) -ne 0 ] && \
-			tst_res TWARN "route-change-netlink has warnings"
+			tst_res TWARN "$cmd has warnings"
 	fi
-	tst_res TPASS "route-change-netlink passed"
+	tst_res TPASS "$cmd passed"
 }
-- 
2.25.1

