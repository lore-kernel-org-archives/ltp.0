From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 11 Sep 2017 15:59:50 +0300
Subject: [LTP] [PATCH COMMITTED 1/2] tst_netload: set the same timeout as in
	safe_bind()
Message-ID: <1505134791-13246-1-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/lib/test_net.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/lib/test_net.sh b/testcases/lib/test_net.sh
index 417fb30..2ee2a8f 100644
--- a/testcases/lib/test_net.sh
+++ b/testcases/lib/test_net.sh
@@ -451,9 +451,9 @@ tst_netload()
 		sock_cmd="ss -ldutn | grep -q $port"
 	fi
 
-	for sec_waited in $(seq 1 600); do
+	for sec_waited in $(seq 1 1200); do
 		tst_rhost_run -c "$sock_cmd" && break
-		if [ $sec_waited -eq 600 ]; then
+		if [ $sec_waited -eq 1200 ]; then
 			tst_rhost_run -c "ss -dutnp | grep $port"
 			tst_brkm TFAIL "server not in LISTEN state"
 		fi
-- 
1.7.1

