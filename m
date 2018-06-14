From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 14 Jun 2018 15:15:56 +0200
Subject: [LTP] [PATCH 1/3] net: Create tst_ipsec_setup to remove duplicity
Message-ID: <20180614131558.18707-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Same as in v1.
---
 testcases/network/stress/dccp/dccp_ipsec.sh     | 11 +----------
 testcases/network/stress/icmp/icmp-uni-basic.sh | 10 ++--------
 testcases/network/stress/ipsec/ipsec_lib.sh     |  9 +++++++++
 testcases/network/stress/sctp/sctp_ipsec.sh     | 11 +----------
 testcases/network/stress/tcp/tcp_ipsec.sh       | 11 +----------
 testcases/network/stress/udp/udp_ipsec.sh       | 11 +----------
 6 files changed, 15 insertions(+), 48 deletions(-)

diff --git a/testcases/network/stress/dccp/dccp_ipsec.sh b/testcases/network/stress/dccp/dccp_ipsec.sh
index 6c39fa39d..624f8e0af 100755
--- a/testcases/network/stress/dccp/dccp_ipsec.sh
+++ b/testcases/network/stress/dccp/dccp_ipsec.sh
@@ -23,15 +23,6 @@ TST_CLEANUP="tst_ipsec_cleanup"
 
 . ipsec_lib.sh
 
-do_setup()
-{
-	# Configure SAD/SPD
-	if [ -n "$IPSEC_MODE" -a -n "$IPSEC_PROTO" ]; then
-		tst_ipsec lhost $(tst_ipaddr) $(tst_ipaddr rhost)
-		tst_ipsec rhost $(tst_ipaddr rhost) $(tst_ipaddr)
-	fi
-}
-
 do_test()
 {
 	for p in $IPSEC_SIZE_ARRAY; do
@@ -40,7 +31,7 @@ do_test()
 	done
 }
 
-do_setup
+tst_ipsec_setup
 
 do_test
 
diff --git a/testcases/network/stress/icmp/icmp-uni-basic.sh b/testcases/network/stress/icmp/icmp-uni-basic.sh
index 78017ee7a..5fe6b9b13 100755
--- a/testcases/network/stress/icmp/icmp-uni-basic.sh
+++ b/testcases/network/stress/icmp/icmp-uni-basic.sh
@@ -26,15 +26,13 @@ TST_CLEANUP="tst_ipsec_cleanup"
 . ipsec_lib.sh
 
 LINK_NUM=${LINK_NUM:-0}
-DO_IPSEC=${DO_IPSEC:-false}
-[ -n "$IPSEC_MODE" -a -n "$IPSEC_PROTO" ] && DO_IPSEC=true || DO_IPSEC=false
 
 # Test description
 tst_resm TINFO "Sending ICMP messages with the following conditions"
 tst_resm TINFO "- Version of IP is IPv${TST_IPV6:-4}"
 tst_resm TINFO "- Size of packets are ( $IPSEC_SIZE_ARRAY )"
 
-if $DO_IPSEC; then
+if [ -n "$IPSEC_MODE" -a -n "$IPSEC_PROTO" ]; then
 	case $IPSEC_PROTO in
 	ah)	tst_resm TINFO "- IPsec [ AH / $IPSEC_MODE ]" ;;
 	esp)	tst_resm TINFO "- IPsec [ ESP / $IPSEC_MODE ]" ;;
@@ -49,11 +47,7 @@ rhost_ifname=$(tst_iface rhost $LINK_NUM)
 lhost_addr=$(tst_ipaddr)
 rhost_addr=$(tst_ipaddr rhost)
 
-# Configure SAD/SPD
-if $DO_IPSEC ; then
-	tst_ipsec lhost $lhost_addr $rhost_addr
-	tst_ipsec rhost $rhost_addr $lhost_addr
-fi
+tst_ipsec_setup
 
 PING_MAX="$IPSEC_REQUESTS"
 
diff --git a/testcases/network/stress/ipsec/ipsec_lib.sh b/testcases/network/stress/ipsec/ipsec_lib.sh
index 480fe064a..2e001c718 100644
--- a/testcases/network/stress/ipsec/ipsec_lib.sh
+++ b/testcases/network/stress/ipsec/ipsec_lib.sh
@@ -111,6 +111,15 @@ cleanup_vti=
 ALG=
 ALGR=
 
+tst_ipsec_setup()
+{
+	# Configure SAD/SPD
+	if [ -n "$IPSEC_MODE" -a -n "$IPSEC_PROTO" ]; then
+		tst_ipsec lhost $(tst_ipaddr) $(tst_ipaddr rhost)
+		tst_ipsec rhost $(tst_ipaddr rhost) $(tst_ipaddr)
+	fi
+}
+
 # tst_ipsec_cleanup: flush ipsec state and policy rules
 tst_ipsec_cleanup()
 {
diff --git a/testcases/network/stress/sctp/sctp_ipsec.sh b/testcases/network/stress/sctp/sctp_ipsec.sh
index 677ccbfed..5f99bc7df 100755
--- a/testcases/network/stress/sctp/sctp_ipsec.sh
+++ b/testcases/network/stress/sctp/sctp_ipsec.sh
@@ -23,15 +23,6 @@ TST_CLEANUP="tst_ipsec_cleanup"
 
 . ipsec_lib.sh
 
-do_setup()
-{
-	# Configure SAD/SPD
-	if [ -n "$IPSEC_MODE" -a -n "$IPSEC_PROTO" ]; then
-		tst_ipsec lhost $(tst_ipaddr) $(tst_ipaddr rhost)
-		tst_ipsec rhost $(tst_ipaddr rhost) $(tst_ipaddr)
-	fi
-}
-
 do_test()
 {
 	for p in $IPSEC_SIZE_ARRAY; do
@@ -40,7 +31,7 @@ do_test()
 	done
 }
 
-do_setup
+tst_ipsec_setup
 
 do_test
 
diff --git a/testcases/network/stress/tcp/tcp_ipsec.sh b/testcases/network/stress/tcp/tcp_ipsec.sh
index aeb33d663..86f455532 100755
--- a/testcases/network/stress/tcp/tcp_ipsec.sh
+++ b/testcases/network/stress/tcp/tcp_ipsec.sh
@@ -25,15 +25,6 @@ max_requests=10
 
 . ipsec_lib.sh
 
-do_setup()
-{
-	# Configure SAD/SPD
-	if [ -n "$IPSEC_MODE" -a -n "$IPSEC_PROTO" ]; then
-		tst_ipsec lhost $(tst_ipaddr) $(tst_ipaddr rhost)
-		tst_ipsec rhost $(tst_ipaddr rhost) $(tst_ipaddr)
-	fi
-}
-
 do_test()
 {
 	for p in $IPSEC_SIZE_ARRAY; do
@@ -42,7 +33,7 @@ do_test()
 	done
 }
 
-do_setup
+tst_ipsec_setup
 
 do_test
 
diff --git a/testcases/network/stress/udp/udp_ipsec.sh b/testcases/network/stress/udp/udp_ipsec.sh
index 4ebf087a6..9b5ac07b2 100755
--- a/testcases/network/stress/udp/udp_ipsec.sh
+++ b/testcases/network/stress/udp/udp_ipsec.sh
@@ -23,15 +23,6 @@ TST_CLEANUP="tst_ipsec_cleanup"
 
 . ipsec_lib.sh
 
-do_setup()
-{
-	# Configure SAD/SPD
-	if [ -n "$IPSEC_MODE" -a -n "$IPSEC_PROTO" ]; then
-		tst_ipsec lhost $(tst_ipaddr) $(tst_ipaddr rhost)
-		tst_ipsec rhost $(tst_ipaddr rhost) $(tst_ipaddr)
-	fi
-}
-
 do_test()
 {
 	for p in $IPSEC_SIZE_ARRAY; do
@@ -40,7 +31,7 @@ do_test()
 	done
 }
 
-do_setup
+tst_ipsec_setup
 
 do_test udp
 do_test udp_lite
-- 
2.17.1

