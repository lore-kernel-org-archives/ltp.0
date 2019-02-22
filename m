From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 22 Feb 2019 10:01:09 +0100
Subject: [LTP] [PATCH 1/1] net/virt: Introduce MIN_VIRT_PERF_THRESHOLD
	variable
Message-ID: <20190222090109.19824-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

to reduce duplicity in VIRT_PERF_THRESHOLD checks

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/virt/geneve01.sh   | 4 +---
 testcases/network/virt/geneve02.sh   | 4 +---
 testcases/network/virt/macsec_lib.sh | 2 +-
 testcases/network/virt/virt_lib.sh   | 6 +++++-
 testcases/network/virt/vxlan03.sh    | 4 +---
 testcases/network/virt/vxlan04.sh    | 4 +---
 6 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/testcases/network/virt/geneve01.sh b/testcases/network/virt/geneve01.sh
index a5cdd0788..5d557d1d3 100755
--- a/testcases/network/virt/geneve01.sh
+++ b/testcases/network/virt/geneve01.sh
@@ -18,11 +18,9 @@ vxlan_dst_addr="uni"
 
 TST_TESTFUNC=do_test
 TST_CLEANUP=virt_cleanup
-VIRT_PERF_THRESHOLD=${VIRT_PERF_THRESHOLD:-160}
+MIN_VIRT_PERF_THRESHOLD=160
 . virt_lib.sh
 
-[ "$VIRT_PERF_THRESHOLD" -lt 160 ] && VIRT_PERF_THRESHOLD=160
-
 do_test()
 {
 	if [ -z $ip_local -o -z $ip_remote ]; then
diff --git a/testcases/network/virt/geneve02.sh b/testcases/network/virt/geneve02.sh
index ba0fc351f..b79f9b67f 100755
--- a/testcases/network/virt/geneve02.sh
+++ b/testcases/network/virt/geneve02.sh
@@ -17,11 +17,9 @@ TST_TESTFUNC=do_test
 TST_CLEANUP=virt_cleanup
 TST_TEST_DATA="noudpcsum udp6zerocsumtx udp6zerocsumrx, udpcsum"
 TST_TEST_DATA_IFS=","
-VIRT_PERF_THRESHOLD=${VIRT_PERF_THRESHOLD:-160}
+MIN_VIRT_PERF_THRESHOLD=160
 . virt_lib.sh
 
-[ "$VIRT_PERF_THRESHOLD" -lt 160 ] && VIRT_PERF_THRESHOLD=160
-
 do_test()
 {
 	virt_check_cmd virt_add ltp_v0 id 1 $2 remote \
diff --git a/testcases/network/virt/macsec_lib.sh b/testcases/network/virt/macsec_lib.sh
index 6e112de20..7290693de 100755
--- a/testcases/network/virt/macsec_lib.sh
+++ b/testcases/network/virt/macsec_lib.sh
@@ -5,7 +5,7 @@
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 
 virt_type="macsec"
-VIRT_PERF_THRESHOLD=${VIRT_PERF_THRESHOLD:-100}
+MIN_VIRT_PERF_THRESHOLD=100
 IPSEC_MODE="transport"
 
 TST_NEEDS_TMPDIR=1
diff --git a/testcases/network/virt/virt_lib.sh b/testcases/network/virt/virt_lib.sh
index 12512db62..6aebdaf30 100644
--- a/testcases/network/virt/virt_lib.sh
+++ b/testcases/network/virt/virt_lib.sh
@@ -69,9 +69,13 @@ ip_remote=$(tst_ipaddr rhost)
 ip_virt_remote="$(TST_IPV6= tst_ipaddr_un rhost)"
 ip6_virt_remote="$(TST_IPV6=6 tst_ipaddr_un rhost)"
 
+vxlan_dstport=0
+
 # Max performance loss (%) for virtual devices during network load
 VIRT_PERF_THRESHOLD=${VIRT_PERF_THRESHOLD:-80}
-vxlan_dstport=0
+if [ -n "$MIN_VIRT_PERF_THRESHOLD" ] && [ "$VIRT_PERF_THRESHOLD" -lt $MIN_VIRT_PERF_THRESHOLD ]; then
+	 VIRT_PERF_THRESHOLD="$MIN_VIRT_PERF_THRESHOLD"
+fi
 
 cleanup_vifaces()
 {
diff --git a/testcases/network/virt/vxlan03.sh b/testcases/network/virt/vxlan03.sh
index 9708e8e5d..d8ced5fda 100755
--- a/testcases/network/virt/vxlan03.sh
+++ b/testcases/network/virt/vxlan03.sh
@@ -31,11 +31,9 @@ TST_CLEANUP=virt_cleanup
 # by 10-30%. If hosts are too close to each other, e.g. connected to the same
 # switch, VxLAN can be much slower when comparing to the performance without
 # any encapsulation.
-VIRT_PERF_THRESHOLD=${VIRT_PERF_THRESHOLD:-160}
+MIN_VIRT_PERF_THRESHOLD=160
 . virt_lib.sh
 
-[ "$VIRT_PERF_THRESHOLD" -lt 160 ] && VIRT_PERF_THRESHOLD=160
-
 do_test()
 {
 	if [ -z $ip_local -o -z $ip_remote ]; then
diff --git a/testcases/network/virt/vxlan04.sh b/testcases/network/virt/vxlan04.sh
index cfff8b2a6..042ff5f12 100755
--- a/testcases/network/virt/vxlan04.sh
+++ b/testcases/network/virt/vxlan04.sh
@@ -15,11 +15,9 @@ TST_TEST_DATA_IFS=","
 virt_type="vxlan"
 start_id=16700000
 vxlan_dst_addr="uni"
-VIRT_PERF_THRESHOLD=${VIRT_PERF_THRESHOLD:-160}
+MIN_VIRT_PERF_THRESHOLD=160
 . virt_lib.sh
 
-[ "$VIRT_PERF_THRESHOLD" -lt 160 ] && VIRT_PERF_THRESHOLD=160
-
 do_test()
 {
 	if [ -z $ip_local -o -z $ip_remote ]; then
-- 
2.20.1

