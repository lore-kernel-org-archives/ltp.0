From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 16 May 2018 18:18:20 +0200
Subject: [LTP] [RFC PATCH v2 2/2] net/{stress,
	virt}: Use TST_TEST_DATA and TST_TEST_DATA_IFS
In-Reply-To: <20180516161820.3077-1-pvorel@suse.cz>
References: <20180516161820.3077-1-pvorel@suse.cz>
Message-ID: <20180516161820.3077-3-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 lib/newlib_tests/Makefile                       | 19 -------------------
 testcases/network/stress/dccp/dccp_ipsec.sh     |  5 +----
 testcases/network/stress/dccp/dccp_ipsec_vti.sh |  5 +----
 testcases/network/stress/ipsec/ipsec_lib.sh     |  3 ++-
 testcases/network/stress/sctp/sctp_ipsec.sh     |  6 ++----
 testcases/network/stress/sctp/sctp_ipsec_vti.sh |  7 ++-----
 testcases/network/stress/tcp/tcp_ipsec.sh       |  6 ++----
 testcases/network/stress/tcp/tcp_ipsec_vti.sh   |  5 +----
 testcases/network/stress/udp/udp_ipsec.sh       |  7 ++-----
 testcases/network/stress/udp/udp_ipsec_vti.sh   |  7 ++-----
 10 files changed, 15 insertions(+), 55 deletions(-)
 delete mode 100644 lib/newlib_tests/Makefile

diff --git a/lib/newlib_tests/Makefile b/lib/newlib_tests/Makefile
deleted file mode 100644
index afa09373e..000000000
--- a/lib/newlib_tests/Makefile
+++ /dev/null
@@ -1,19 +0,0 @@
-top_srcdir		?= ../..
-
-include $(top_srcdir)/include/mk/env_pre.mk
-
-CFLAGS			+= -W -Wall
-LDLIBS			+= -lltp
-
-test08: CFLAGS+=-pthread
-test09: CFLAGS+=-pthread
-test15: CFLAGS+=-pthread
-test16: CFLAGS+=-pthread
-test16: LDLIBS+=-lrt
-
-ifeq ($(ANDROID),1)
-FILTER_OUT_MAKE_TARGETS	+= test08
-endif
-
-
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/stress/dccp/dccp_ipsec.sh b/testcases/network/stress/dccp/dccp_ipsec.sh
index dae530fa3..edd1917bb 100755
--- a/testcases/network/stress/dccp/dccp_ipsec.sh
+++ b/testcases/network/stress/dccp/dccp_ipsec.sh
@@ -21,10 +21,7 @@ do_setup()
 
 do_test()
 {
-	for p in $IPSEC_SIZE_ARRAY; do
-		tst_netload -H $(tst_ipaddr rhost) -T dccp -n $p -N $p \
-			-r $IPSEC_REQUESTS
-	done
+	tst_netload -H $(tst_ipaddr rhost) -T dccp -n $2 -N $2 -r $IPSEC_REQUESTS
 }
 
 tst_run
diff --git a/testcases/network/stress/dccp/dccp_ipsec_vti.sh b/testcases/network/stress/dccp/dccp_ipsec_vti.sh
index 787460aab..ee2b0d4ca 100755
--- a/testcases/network/stress/dccp/dccp_ipsec_vti.sh
+++ b/testcases/network/stress/dccp/dccp_ipsec_vti.sh
@@ -12,10 +12,7 @@ TST_CLEANUP=tst_ipsec_cleanup
 
 do_test()
 {
-	for p in $IPSEC_SIZE_ARRAY; do
-		tst_netload -H $ip_rmt_tun -T dccp -n $p -N $p \
-			-r $IPSEC_REQUESTS
-	done
+	tst_netload -H $ip_rmt_tun -T dccp -n $2 -N $2 -r $IPSEC_REQUESTS
 }
 
 tst_run
diff --git a/testcases/network/stress/ipsec/ipsec_lib.sh b/testcases/network/stress/ipsec/ipsec_lib.sh
index bfb022bd0..5e6c68278 100644
--- a/testcases/network/stress/ipsec/ipsec_lib.sh
+++ b/testcases/network/stress/ipsec/ipsec_lib.sh
@@ -48,7 +48,8 @@ ipsec_lib_parse_args()
 	r) IPSEC_REQUESTS="$2" ;;
 	esac
 
-	IPSEC_SIZE_ARRAY="$(echo $IPSEC_SIZE_ARRAY | sed 's/:/ /g')"
+	TST_TEST_DATA="$IPSEC_SIZE_ARRAY"
+	TST_TEST_DATA_IFS=":"
 }
 
 TST_OPTS="l:m:p:s:S:k:A:e:a:c:r:"
diff --git a/testcases/network/stress/sctp/sctp_ipsec.sh b/testcases/network/stress/sctp/sctp_ipsec.sh
index 2dc025352..46f43ea9d 100755
--- a/testcases/network/stress/sctp/sctp_ipsec.sh
+++ b/testcases/network/stress/sctp/sctp_ipsec.sh
@@ -21,10 +21,8 @@ do_setup()
 
 do_test()
 {
-	for p in $IPSEC_SIZE_ARRAY; do
-		tst_netload -H $(tst_ipaddr rhost) -T sctp -n $p -N $p \
-			-r $IPSEC_REQUESTS -S $(tst_ipaddr)
-	done
+	tst_netload -H $(tst_ipaddr rhost) -T sctp -n $2 -N $2 \
+		-r $IPSEC_REQUESTS -S $(tst_ipaddr)
 }
 
 tst_run
diff --git a/testcases/network/stress/sctp/sctp_ipsec_vti.sh b/testcases/network/stress/sctp/sctp_ipsec_vti.sh
index 160b618e7..d0f24c727 100755
--- a/testcases/network/stress/sctp/sctp_ipsec_vti.sh
+++ b/testcases/network/stress/sctp/sctp_ipsec_vti.sh
@@ -7,16 +7,13 @@
 TST_NEEDS_TMPDIR=1
 TST_SETUP=tst_ipsec_setup_vti
 TST_CLEANUP=tst_ipsec_cleanup
-
 TST_TESTFUNC=do_test
 . ipsec_lib.sh
 
 do_test()
 {
-	for p in $IPSEC_SIZE_ARRAY; do
-		tst_netload -H $ip_rmt_tun -T sctp -n $p -N $p \
-			-r $IPSEC_REQUESTS -S $ip_loc_tun
-	done
+	tst_netload -H $ip_rmt_tun -T sctp -n $2 -N $2 -r $IPSEC_REQUESTS \
+		-S $ip_loc_tun
 }
 
 tst_run
diff --git a/testcases/network/stress/tcp/tcp_ipsec.sh b/testcases/network/stress/tcp/tcp_ipsec.sh
index edea89361..d5254c394 100755
--- a/testcases/network/stress/tcp/tcp_ipsec.sh
+++ b/testcases/network/stress/tcp/tcp_ipsec.sh
@@ -23,10 +23,8 @@ do_setup()
 
 do_test()
 {
-	for p in $IPSEC_SIZE_ARRAY; do
-		tst_netload -H $(tst_ipaddr rhost) -n $p -N $p \
-			-r $IPSEC_REQUESTS -R $max_requests
-	done
+	tst_netload -H $(tst_ipaddr rhost) -n $2 -N $2 -r $IPSEC_REQUESTS \
+		-R $max_requests
 }
 
 tst_run
diff --git a/testcases/network/stress/tcp/tcp_ipsec_vti.sh b/testcases/network/stress/tcp/tcp_ipsec_vti.sh
index 78329f995..2172662eb 100755
--- a/testcases/network/stress/tcp/tcp_ipsec_vti.sh
+++ b/testcases/network/stress/tcp/tcp_ipsec_vti.sh
@@ -14,10 +14,7 @@ max_requests=10
 
 do_test()
 {
-	for p in $IPSEC_SIZE_ARRAY; do
-		tst_netload -H $ip_rmt_tun -n $p -N $p \
-			-r $IPSEC_REQUESTS -R $max_requests
-	done
+	tst_netload -H $ip_rmt_tun -n $2 -N $2 -r $IPSEC_REQUESTS -R $max_requests
 }
 
 tst_run
diff --git a/testcases/network/stress/udp/udp_ipsec.sh b/testcases/network/stress/udp/udp_ipsec.sh
index 063a18705..2a0dee4cd 100755
--- a/testcases/network/stress/udp/udp_ipsec.sh
+++ b/testcases/network/stress/udp/udp_ipsec.sh
@@ -22,12 +22,9 @@ do_setup()
 do_test()
 {
 	local type="udp"
-	[ $1 -gt 3 ] && type="udp_lite"
+	[ $2 -gt 3 ] && type="udp_lite"
 
-	for p in $IPSEC_SIZE_ARRAY; do
-		tst_netload -H $(tst_ipaddr rhost) -T $type -n $p -N $p \
-			-r $IPSEC_REQUESTS
-	done
+	tst_netload -H $(tst_ipaddr rhost) -T $type -n $2 -N $2 -r $IPSEC_REQUESTS
 }
 
 tst_run
diff --git a/testcases/network/stress/udp/udp_ipsec_vti.sh b/testcases/network/stress/udp/udp_ipsec_vti.sh
index a0a8e03fc..7de8761d7 100755
--- a/testcases/network/stress/udp/udp_ipsec_vti.sh
+++ b/testcases/network/stress/udp/udp_ipsec_vti.sh
@@ -13,12 +13,9 @@ TST_CLEANUP=tst_ipsec_setup_vti
 do_test()
 {
 	local type="udp"
-	[ $1 -gt 3 ] && type="udp_lite"
+	[ $2 -gt 3 ] && type="udp_lite"
 
-	for p in $IPSEC_SIZE_ARRAY; do
-		tst_netload -H $ip_rmt_tun -T $type -n $p -N $p \
-			-r $IPSEC_REQUESTS
-	done
+	tst_netload -H $ip_rmt_tun -T $type -n $2 -N $2 -r $IPSEC_REQUESTS
 }
 
 tst_run
-- 
2.16.3

