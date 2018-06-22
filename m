From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 22 Jun 2018 17:10:40 +0200
Subject: [LTP] [PATCH v2 1/8] net/ipsec: Improve log info messages
In-Reply-To: <20180622151047.13002-1-pvorel@suse.cz>
References: <20180622151047.13002-1-pvorel@suse.cz>
Message-ID: <20180622151047.13002-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

* Log all IPsec tst_ipsec_setup calls.
* Remove redundant log output from icmp-uni-basic.sh to make it similar
to icmp-uni-vti.sh.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/stress/icmp/icmp-uni-basic.sh | 14 +-------------
 testcases/network/stress/icmp/icmp-uni-vti.sh   |  2 +-
 testcases/network/stress/ipsec/ipsec_lib.sh     |  1 +
 3 files changed, 3 insertions(+), 14 deletions(-)

diff --git a/testcases/network/stress/icmp/icmp-uni-basic.sh b/testcases/network/stress/icmp/icmp-uni-basic.sh
index fc84899dd..3099b6caa 100755
--- a/testcases/network/stress/icmp/icmp-uni-basic.sh
+++ b/testcases/network/stress/icmp/icmp-uni-basic.sh
@@ -25,23 +25,11 @@ TST_CLEANUP="tst_ipsec_cleanup"
 
 . ipsec_lib.sh
 
-# Test description
-tst_resm TINFO "Sending ICMP messages with the following conditions"
-tst_resm TINFO "- Version of IP is IPv${TST_IPV6:-4}"
-tst_resm TINFO "- Size of packets are ( $IPSEC_SIZE_ARRAY )"
-
-if [ -n "$IPSEC_MODE" -a -n "$IPSEC_PROTO" ]; then
-	case $IPSEC_PROTO in
-	ah)	tst_resm TINFO "- IPsec [ AH / $IPSEC_MODE ]" ;;
-	esp)	tst_resm TINFO "- IPsec [ ESP / $IPSEC_MODE ]" ;;
-	comp)	tst_resm TINFO "- IPcomp [ $IPSEC_MODE ]" ;;
-	esac
-fi
-
 tst_ipsec_setup
 
 PING_MAX="$IPSEC_REQUESTS"
 
+tst_resm TINFO "Sending ICMP messages"
 tst_ping $(tst_iface) $(tst_ipaddr rhost) $IPSEC_SIZE_ARRAY
 
 tst_exit
diff --git a/testcases/network/stress/icmp/icmp-uni-vti.sh b/testcases/network/stress/icmp/icmp-uni-vti.sh
index 7fa211d7f..ea8b5c828 100755
--- a/testcases/network/stress/icmp/icmp-uni-vti.sh
+++ b/testcases/network/stress/icmp/icmp-uni-vti.sh
@@ -26,7 +26,7 @@ do_test()
 {
 	PING_MAX="$IPSEC_REQUESTS"
 
-	tst_resm TINFO "Sending ICMP messages..."
+	tst_resm TINFO "Sending ICMP messages"
 	tst_ping $tst_vti $ip_rmt_tun $IPSEC_SIZE_ARRAY
 }
 
diff --git a/testcases/network/stress/ipsec/ipsec_lib.sh b/testcases/network/stress/ipsec/ipsec_lib.sh
index 2e001c718..9c293ca3e 100644
--- a/testcases/network/stress/ipsec/ipsec_lib.sh
+++ b/testcases/network/stress/ipsec/ipsec_lib.sh
@@ -115,6 +115,7 @@ tst_ipsec_setup()
 {
 	# Configure SAD/SPD
 	if [ -n "$IPSEC_MODE" -a -n "$IPSEC_PROTO" ]; then
+		tst_resm TINFO "IPsec[$IPSEC_PROTO/$IPSEC_MODE]"
 		tst_ipsec lhost $(tst_ipaddr) $(tst_ipaddr rhost)
 		tst_ipsec rhost $(tst_ipaddr rhost) $(tst_ipaddr)
 	fi
-- 
2.17.1

