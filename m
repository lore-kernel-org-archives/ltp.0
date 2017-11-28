From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 28 Nov 2017 16:08:27 +0300
Subject: [LTP] [PATCH 5/6] sctp: fix tests when hosts have multi-paths with
	diff MTU
In-Reply-To: <1511874508-12360-1-git-send-email-alexey.kodanev@oracle.com>
References: <1511874508-12360-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1511874508-12360-5-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Setup source address in sctp tests and bind to it, which
allows to avoid sending additional host IP addresses in
INIT/INIT ACK packets (sctp sets min MTU b/w those paths),
and bind the traffic to one path.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/sctp/sctp01.sh                |    2 +-
 testcases/network/stress/sctp/sctp_ipsec.sh     |    2 +-
 testcases/network/stress/sctp/sctp_ipsec_vti.sh |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/testcases/network/sctp/sctp01.sh b/testcases/network/sctp/sctp01.sh
index 197c819..99dcce8 100755
--- a/testcases/network/sctp/sctp01.sh
+++ b/testcases/network/sctp/sctp01.sh
@@ -41,7 +41,7 @@ test_run()
 	tst_netload -H $(tst_ipaddr rhost) -T tcp
 	local res0="$(cat tst_netload.res)"
 
-	tst_netload -H $(tst_ipaddr rhost) -T sctp
+	tst_netload -S $(tst_ipaddr) -H $(tst_ipaddr rhost) -T sctp
 	local res1="$(cat tst_netload.res)"
 
 	local per=$(( $res0 * 100 / $res1 - 100 ))
diff --git a/testcases/network/stress/sctp/sctp_ipsec.sh b/testcases/network/stress/sctp/sctp_ipsec.sh
index 0b60238..677ccbf 100755
--- a/testcases/network/stress/sctp/sctp_ipsec.sh
+++ b/testcases/network/stress/sctp/sctp_ipsec.sh
@@ -36,7 +36,7 @@ do_test()
 {
 	for p in $IPSEC_SIZE_ARRAY; do
 		tst_netload -H $(tst_ipaddr rhost) -T sctp -n $p -N $p \
-			-r $IPSEC_REQUESTS
+			-r $IPSEC_REQUESTS -S $(tst_ipaddr)
 	done
 }
 
diff --git a/testcases/network/stress/sctp/sctp_ipsec_vti.sh b/testcases/network/stress/sctp/sctp_ipsec_vti.sh
index ddb4784..ab9ddc3 100755
--- a/testcases/network/stress/sctp/sctp_ipsec_vti.sh
+++ b/testcases/network/stress/sctp/sctp_ipsec_vti.sh
@@ -27,7 +27,7 @@ do_test()
 {
 	for p in $IPSEC_SIZE_ARRAY; do
 		tst_netload -H $ip_rmt_tun -T sctp -n $p -N $p \
-			-r $IPSEC_REQUESTS
+			-r $IPSEC_REQUESTS -S $ip_src_tun
 	done
 }
 
-- 
1.7.1

