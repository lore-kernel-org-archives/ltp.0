From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 21 May 2018 14:48:27 +0300
Subject: [LTP] [PATCH 3/6] network/tcp_cc/dctcp01: increase packet loss for
	dctcp
In-Reply-To: <1526903310-2833-1-git-send-email-alexey.kodanev@oracle.com>
References: <1526903310-2833-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1526903310-2833-4-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Avoid false positive failures for this test-case.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/tcp_cc/dctcp01.sh |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/testcases/network/tcp_cc/dctcp01.sh b/testcases/network/tcp_cc/dctcp01.sh
index 02b27cf..3562f5a 100755
--- a/testcases/network/tcp_cc/dctcp01.sh
+++ b/testcases/network/tcp_cc/dctcp01.sh
@@ -13,7 +13,7 @@ TST_MIN_KVER="3.18"
 
 cleanup()
 {
-	tc qdisc del dev $(tst_iface) root netem loss 0.03% ecn
+	tc qdisc del dev $(tst_iface) root netem loss 0.5% ecn
 
 	tcp_cc_cleanup
 }
@@ -22,8 +22,9 @@ setup()
 {
 	tcp_cc_setup
 
-	tst_res TINFO "emulate congestion with packet loss 0.03% and ECN"
-	tc qdisc add dev $(tst_iface) root netem loss 0.03% ecn > /dev/null 2>&1
+	tst_res TINFO "emulate congestion with packet loss 0.5% and ECN"
+	tc qdisc add dev $(tst_iface) root netem loss 0.5% ecn > /dev/null 2>&1
+
 	if [ $? -ne 0 ]; then
 		tst_brkm TCONF "netem doesn't support ECN"
 	fi
-- 
1.7.1

