From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 24 May 2017 11:40:30 +0300
Subject: [LTP] [PATCH 4/4] lib/test: run ROD_BASE() & tst_rod() with
	'timeout' cmd
In-Reply-To: <1495615230-29045-1-git-send-email-alexey.kodanev@oracle.com>
References: <1495615230-29045-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1495615230-29045-5-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/lib/test.sh     |    7 +++++--
 testcases/lib/tst_test.sh |   11 +++++++----
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/testcases/lib/test.sh b/testcases/lib/test.sh
index 2e4d868..5247873 100644
--- a/testcases/lib/test.sh
+++ b/testcases/lib/test.sh
@@ -253,9 +253,9 @@ ROD_BASE()
 	done
 
 	if [ -n "$flag" ]; then
-		$cmd > $file
+		$TST_TIMECMD $cmd > $file
 	else
-		$@
+		$TST_TIMECMD $@
 	fi
 }
 
@@ -425,3 +425,6 @@ if [ "$TST_NEEDS_CHECKPOINTS" = "1" ]; then
 	ROD_SILENT chmod 600 "$LTP_IPC_PATH"
 	export LTP_IPC_PATH
 fi
+
+command -v timeout > /dev/null 2>&1 && \
+	TST_TIMECMD="timeout -s 9 $((300 * ${LTP_TIMEOUT_MUL:-1}))s"
diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 087adda..c4fbe86 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -116,7 +116,7 @@ tst_brk()
 
 ROD_SILENT()
 {
-	tst_rod $@ > /dev/null 2>&1
+	$TST_TIMECMD tst_rod $@ > /dev/null 2>&1
 	if [ $? -ne 0 ]; then
 		tst_brk TBROK "$@ failed"
 	fi
@@ -124,7 +124,7 @@ ROD_SILENT()
 
 ROD()
 {
-	tst_rod "$@"
+	$TST_TIMECMD tst_rod "$@"
 	if [ $? -ne 0 ]; then
 		tst_brk TBROK "$@ failed"
 	fi
@@ -132,7 +132,7 @@ ROD()
 
 EXPECT_PASS()
 {
-	tst_rod "$@"
+	$TST_TIMECMD tst_rod "$@"
 	if [ $? -eq 0 ]; then
 		tst_res TPASS "$@ passed as expected"
 	else
@@ -143,7 +143,7 @@ EXPECT_PASS()
 EXPECT_FAIL()
 {
 	# redirect stderr since we expect the command to fail
-	tst_rod "$@" 2> /dev/null
+	$TST_TIMECMD tst_rod "$@" 2> /dev/null
 	if [ $? -ne 0 ]; then
 		tst_res TPASS "$@ failed as expected"
 	else
@@ -430,3 +430,6 @@ else
 		tst_brk TBROK "Unexpected positional arguments '$@'"
 	fi
 fi
+
+command -v timeout > /dev/null 2>&1 && \
+	TST_TIMECMD="timeout -s 9 $((300 * ${LTP_TIMEOUT_MUL:-1}))s"
-- 
1.7.1

