From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 19 Feb 2019 17:47:52 +0300
Subject: [LTP] [PATCH 3/4] network: use TST_NET_MAX_PKT
In-Reply-To: <1550587673-7995-1-git-send-email-alexey.kodanev@oracle.com>
References: <1550587673-7995-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1550587673-7995-4-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/lib/tst_test.sh              |    1 +
 testcases/network/mpls/mpls02.sh       |    2 +-
 testcases/network/mpls/mpls_lib.sh     |    2 +-
 testcases/network/tcp_cc/tcp_cc_lib.sh |    4 ++--
 testcases/network/virt/virt_lib.sh     |    2 +-
 5 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 3d2f5af..f36051f 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -404,6 +404,7 @@ tst_run()
 			NEEDS_DRIVERS);;
 			IPV6|IPVER|TEST_DATA|TEST_DATA_IFS);;
 			RETRY_FUNC|RETRY_FN_EXP_BACKOFF);;
+			NET_MAX_PKT);;
 			*) tst_res TWARN "Reserved variable TST_$_tst_i used!";;
 			esac
 		done
diff --git a/testcases/network/mpls/mpls02.sh b/testcases/network/mpls/mpls02.sh
index 745a414..c263f8a 100755
--- a/testcases/network/mpls/mpls02.sh
+++ b/testcases/network/mpls/mpls02.sh
@@ -40,7 +40,7 @@ setup()
 do_test()
 {
 	local type=$2
-	local max_size=10000
+	local max_size=$TST_NET_MAX_PKT
 
 	if [ "$type" = "icmp" ]; then
 		tst_ping $ip_loc $ip_rmt 10 100 1000 2000 $max_size
diff --git a/testcases/network/mpls/mpls_lib.sh b/testcases/network/mpls/mpls_lib.sh
index c64b46c..84b3236 100755
--- a/testcases/network/mpls/mpls_lib.sh
+++ b/testcases/network/mpls/mpls_lib.sh
@@ -84,7 +84,7 @@ mpls_virt_setup()
 mpls_virt_test()
 {
 	local type=$2
-	local max_size=10000
+	local max_size=$TST_NET_MAX_PKT
 
 	if [ "$type" = "icmp" ]; then
 		tst_ping $ip_virt_local $ip_virt_remote 10 100 1000 2000 $max_size
diff --git a/testcases/network/tcp_cc/tcp_cc_lib.sh b/testcases/network/tcp_cc/tcp_cc_lib.sh
index 6d41bcf..163ac02 100755
--- a/testcases/network/tcp_cc/tcp_cc_lib.sh
+++ b/testcases/network/tcp_cc/tcp_cc_lib.sh
@@ -92,12 +92,12 @@ tcp_cc_test01()
 
 	set_cong_alg "$def_alg"
 
-	tst_netload -H $(tst_ipaddr rhost) -A 15000
+	tst_netload -H $(tst_ipaddr rhost) -A $TST_NET_MAX_PKT
 	local res0="$(cat tst_netload.res)"
 
 	set_cong_alg "$alg"
 
-	tst_netload -H $(tst_ipaddr rhost) -A 15000
+	tst_netload -H $(tst_ipaddr rhost) -A $TST_NET_MAX_PKT
 	local res1="$(cat tst_netload.res)"
 
 	local per=$(( $res0 * 100 / $res1 - 100 ))
diff --git a/testcases/network/virt/virt_lib.sh b/testcases/network/virt/virt_lib.sh
index eb9d052..92942d3 100644
--- a/testcases/network/virt/virt_lib.sh
+++ b/testcases/network/virt/virt_lib.sh
@@ -327,7 +327,7 @@ virt_check_cmd()
 
 virt_netperf_msg_sizes()
 {
-	local sizes="100 1000 2000 10000"
+	local sizes="100 1000 2000 $TST_NET_MAX_PKT"
 	local s
 
 	for s in $sizes; do
-- 
1.7.1

