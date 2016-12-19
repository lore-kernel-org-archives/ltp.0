From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 19 Dec 2016 16:41:20 +0300
Subject: [LTP] [PATCH] cleanup shell test only if TST_NO_CLEANUP is not
	defined
Message-ID: <1482154880-4760-1-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Could be useful to debug a single test so it leaves the setup
on the machine intact.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/lib/test.sh     |    2 +-
 testcases/lib/tst_test.sh |    3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/testcases/lib/test.sh b/testcases/lib/test.sh
index 76b7062..0876df3 100644
--- a/testcases/lib/test.sh
+++ b/testcases/lib/test.sh
@@ -96,7 +96,7 @@ tst_require_root()
 
 tst_exit()
 {
-	if [ -n "$TST_CLEANUP" ]; then
+	if [ -n "$TST_CLEANUP" -a -z "$TST_NO_CLEANUP" ]; then
 		$TST_CLEANUP
 	fi
 
diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index b54bbbf..c6a85f3 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -33,7 +33,8 @@ tst_do_exit()
 {
 	local ret=0
 
-	if [ -n "$TST_SETUP_STARTED" -a -n "$TST_CLEANUP" ]; then
+	if [ -n "$TST_SETUP_STARTED" -a -n "$TST_CLEANUP" -a \
+	     -z "$TST_NO_CLEANUP" ]; then
 		$TST_CLEANUP
 	fi
 
-- 
1.7.1

