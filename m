From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue,  6 Jun 2017 14:22:01 +0300
Subject: [LTP] [COMMITTED][PATCH 6/6] net/rpc_test.sh: check if server is
	ready with rpcinfo
In-Reply-To: <1496748121-10782-1-git-send-email-alexey.kodanev@oracle.com>
References: <1496748121-10782-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1496748121-10782-6-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

* remove 'sleep 1', usually server registered faster (<100ms)

* remove LTPROOT usage

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/rpc/rpc-tirpc/rpc_test.sh |   18 ++++++++++--------
 1 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/testcases/network/rpc/rpc-tirpc/rpc_test.sh b/testcases/network/rpc/rpc-tirpc/rpc_test.sh
index e265725..54ea4fd 100755
--- a/testcases/network/rpc/rpc-tirpc/rpc_test.sh
+++ b/testcases/network/rpc/rpc-tirpc/rpc_test.sh
@@ -26,7 +26,6 @@ CLIENT_EXTRA_OPTS=""
 CLEANER=""
 # Program number to register the services to rpcbind
 PROGNUMNOSVC=536875000
-SERVER_STARTUP_SLEEP=1
 
 cleanup()
 {
@@ -57,7 +56,7 @@ EOF
 
 while getopts s:c:e:h arg; do
 	case $arg in
-		s) SERVER="$LTPROOT/testcases/bin/$OPTARG" ;;
+		s) SERVER="$OPTARG" ;;
 		c) CLIENT="$OPTARG" ;;
 		e) CLIENT_EXTRA_OPTS="$OPTARG" ;;
 		h) usage ;;
@@ -66,9 +65,9 @@ done
 
 if [ ! -z "$SERVER" ]; then
 	if `echo "$SERVER" | grep -e '^tirpc'`; then
-		CLEANER="$LTPROOT/testcases/bin/tirpc_cleaner"
+		CLEANER="tirpc_cleaner"
 	else
-		CLEANER="$LTPROOT/testcases/bin/rpc_cleaner"
+		CLEANER="rpc_cleaner"
 	fi
 fi
 
@@ -87,11 +86,14 @@ TST_CLEANUP=cleanup
 
 if [ ! -z "$SERVER" ]; then
 	$SERVER $PROGNUMNOSVC &
-	sleep "$SERVER_STARTUP_SLEEP"
-fi
 
-tst_rhost_run -sc "$CLIENT $(tst_ipaddr) $PROGNUMNOSVC $CLIENT_EXTRA_OPTS"
+	for i in $(seq 1 10); do
+		rpcinfo -p localhost | grep -q $PROGNUMNOSVC && break
+		[ "$i" -eq 30 ] && tst_brkm TBROK "server not registered"
+		tst_sleep 100ms
+	done
+fi
 
-tst_resm TPASS "Test passed"
+EXPECT_RHOST_PASS $CLIENT $(tst_ipaddr) $PROGNUMNOSVC $CLIENT_EXTRA_OPTS
 
 tst_exit
-- 
1.7.1

