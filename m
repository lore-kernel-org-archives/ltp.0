From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu,  5 Apr 2018 14:05:54 +0300
Subject: [LTP] [PATCH 1/2] lib/test_net.sh: lower default test parameters
Message-ID: <1522926355-18029-1-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Default scenario should not take hours to complete.

Also export TST_NETLOAD_CLN_REQUESTS which is used by all
tst_netload tests and can control the test execution time.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/lib/test_net.sh |   15 ++++++++-------
 1 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/testcases/lib/test_net.sh b/testcases/lib/test_net.sh
index 203464f..2f7668f 100644
--- a/testcases/lib/test_net.sh
+++ b/testcases/lib/test_net.sh
@@ -651,20 +651,21 @@ if [ -z "$TST_PARSE_VARIABLES" ]; then
 	export TST_PARSE_VARIABLES="yes"
 fi
 
+export TST_NETLOAD_CLN_REQUESTS="${TST_NETLOAD_CLN_REQUESTS:-10000}"
 export HTTP_DOWNLOAD_DIR="${HTTP_DOWNLOAD_DIR:-/var/www/html}"
 export FTP_DOWNLOAD_DIR="${FTP_DOWNLOAD_DIR:-/var/ftp}"
 export FTP_UPLOAD_DIR="${FTP_UPLOAD_DIR:-/var/ftp/pub}"
 export FTP_UPLOAD_URLDIR="${FTP_UPLOAD_URLDIR:-pub}"
 
 # network/stress tests require additional parameters
-export NS_DURATION="${NS_DURATION:-720}"
-export NS_TIMES="${NS_TIMES:-2000}"
-export CONNECTION_TOTAL="${CONNECTION_TOTAL:-4000}"
-export IP_TOTAL="${IP_TOTAL:-2000}"
+export NS_DURATION="${NS_DURATION:-10}"
+export NS_TIMES="${NS_TIMES:-10}"
+export CONNECTION_TOTAL="${CONNECTION_TOTAL:-10}"
+export IP_TOTAL="${IP_TOTAL:-100}"
 export IP_TOTAL_FOR_TCPIP="${IP_TOTAL_FOR_TCPIP:-100}"
-export ROUTE_TOTAL="${ROUTE_TOTAL:-2000}"
-export MTU_CHANGE_TIMES="${MTU_CHANGE_TIMES:-1000}"
-export IF_UPDOWN_TIMES="${IF_UPDOWN_TIMES:-2000}"
+export ROUTE_TOTAL="${ROUTE_TOTAL:-100}"
+export MTU_CHANGE_TIMES="${MTU_CHANGE_TIMES:-100}"
+export IF_UPDOWN_TIMES="${IF_UPDOWN_TIMES:-100}"
 export DOWNLOAD_BIGFILESIZE="${DOWNLOAD_BIGFILESIZE:-2147483647}"
 export DOWNLOAD_REGFILESIZE="${DOWNLOAD_REGFILESIZE:-1048576}"
 export UPLOAD_BIGFILESIZE="${UPLOAD_BIGFILESIZE:-2147483647}"
-- 
1.7.1

