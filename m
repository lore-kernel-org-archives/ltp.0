From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 28 Nov 2017 16:08:28 +0300
Subject: [LTP] [PATCH 6/6] sctp: add test-case with random payload
In-Reply-To: <1511874508-12360-1-git-send-email-alexey.kodanev@oracle.com>
References: <1511874508-12360-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1511874508-12360-6-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/sctp/sctp01.sh |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/testcases/network/sctp/sctp01.sh b/testcases/network/sctp/sctp01.sh
index 99dcce8..51de2b1 100755
--- a/testcases/network/sctp/sctp01.sh
+++ b/testcases/network/sctp/sctp01.sh
@@ -17,7 +17,7 @@
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 
 TCID=sctp01
-TST_TOTAL=3
+TST_TOTAL=4
 TST_CLEANUP="cleanup"
 TST_NEEDS_TMPDIR=1
 
@@ -36,12 +36,14 @@ setup()
 
 test_run()
 {
+	local opt="$@"
+
 	tst_resm TINFO "compare TCP/SCTP performance"
 
-	tst_netload -H $(tst_ipaddr rhost) -T tcp
+	tst_netload -H $(tst_ipaddr rhost) -T tcp $opt
 	local res0="$(cat tst_netload.res)"
 
-	tst_netload -S $(tst_ipaddr) -H $(tst_ipaddr rhost) -T sctp
+	tst_netload -S $(tst_ipaddr) -H $(tst_ipaddr rhost) -T sctp $opt
 	local res1="$(cat tst_netload.res)"
 
 	local per=$(( $res0 * 100 / $res1 - 100 ))
@@ -55,5 +57,6 @@ test_run()
 
 setup
 test_run
+test_run -A 65000
 
 tst_exit
-- 
1.7.1

