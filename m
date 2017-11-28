From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 28 Nov 2017 16:08:23 +0300
Subject: [LTP] [PATCH 1/6] network/sctp: use TST_NETLOAD_* parameters
Message-ID: <1511874508-12360-1-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/sctp/sctp01.sh |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/testcases/network/sctp/sctp01.sh b/testcases/network/sctp/sctp01.sh
index 68a872a..197c819 100755
--- a/testcases/network/sctp/sctp01.sh
+++ b/testcases/network/sctp/sctp01.sh
@@ -31,16 +31,17 @@ cleanup()
 setup()
 {
 	tst_require_root
+	TST_NETLOAD_MAX_SRV_REPLIES=3
 }
 
 test_run()
 {
 	tst_resm TINFO "compare TCP/SCTP performance"
 
-	tst_netload -H $(tst_ipaddr rhost) -a 3 -R 3 -T tcp
+	tst_netload -H $(tst_ipaddr rhost) -T tcp
 	local res0="$(cat tst_netload.res)"
 
-	tst_netload -H $(tst_ipaddr rhost) -a 3 -R 3 -T sctp
+	tst_netload -H $(tst_ipaddr rhost) -T sctp
 	local res1="$(cat tst_netload.res)"
 
 	local per=$(( $res0 * 100 / $res1 - 100 ))
-- 
1.7.1

