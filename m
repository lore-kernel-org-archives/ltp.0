From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 25 Jan 2017 17:21:40 +0300
Subject: [LTP] [PATCH 2/2] net: dctcp01: apply tst_set_sysctl()
In-Reply-To: <1485354100-24769-1-git-send-email-alexey.kodanev@oracle.com>
References: <1485354100-24769-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1485354100-24769-2-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/dctcp/dctcp01.sh |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/testcases/network/dctcp/dctcp01.sh b/testcases/network/dctcp/dctcp01.sh
index 5c401ce..ebb59f6 100755
--- a/testcases/network/dctcp/dctcp01.sh
+++ b/testcases/network/dctcp/dctcp01.sh
@@ -29,16 +29,13 @@ set_cong_alg()
 	local alg=$1
 	tst_resm TINFO "setting $alg"
 
-	ROD sysctl -q -w net.ipv4.tcp_congestion_control=$alg
-	tst_rhost_run -s -c "sysctl -q -w net.ipv4.tcp_congestion_control=$alg"
+	tst_set_sysctl net.ipv4.tcp_congestion_control $alg safe
 }
 
 cleanup()
 {
 	if [ "$prev_cong_ctl" ]; then
-		sysctl -q -w net.ipv4.tcp_congestion_control=$prev_alg
-		tst_rhost_run -c \
-			"sysctl -q -w net.ipv4.tcp_congestion_control=$prev_alg"
+		tst_set_sysctl net.ipv4.tcp_congestion_control $prev_alg
 	fi
 	tst_rmdir
 	tc qdisc del dev $(tst_iface) root netem loss 0.03% ecn
@@ -61,7 +58,7 @@ setup()
 
 	tst_tmpdir
 
-	prev_alg="$(cat /proc/sys/net/ipv4/tcp_congestion_control)"
+	prev_alg="$(sysctl -n net.ipv4.tcp_congestion_control)"
 }
 
 test_run()
-- 
1.7.1

