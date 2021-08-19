From: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Date: Thu, 19 Aug 2021 18:21:54 +0300
Subject: [LTP] [PATCH] lib/tst_test.sh: fix ROD_SILENT command return status
 check
Message-ID: <20210819152154.16185-1-aleksei.kodanev@bell-sw.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

"local tst_out=$(some_command)" always returns status 0, i.e.
not the return status of the command in the assignment, but the
status for 'local' builtin command, which creates a new local
variable inside the function.

As a result, the library calls and tests that invoke ROD_SILENT
don't actually check the return status of commands passed to it.

The old API library function is also fixed.

Signed-off-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
---
 testcases/lib/test.sh     | 4 +++-
 testcases/lib/tst_test.sh | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/testcases/lib/test.sh b/testcases/lib/test.sh
index 92278d7aa..8947f47c1 100644
--- a/testcases/lib/test.sh
+++ b/testcases/lib/test.sh
@@ -233,7 +233,9 @@ tst_timeout()
 
 ROD_SILENT()
 {
-	local tst_out="$($@ 2>&1)"
+	local tst_out
+
+	tst_out="$($@ 2>&1)"
 	if [ $? -ne 0 ]; then
 		echo "$tst_out"
 		tst_brkm TBROK "$@ failed"
diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index c6aa2c487..3710c857e 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -126,7 +126,9 @@ tst_brk()
 
 ROD_SILENT()
 {
-	local tst_out="$(tst_rod $@ 2>&1)"
+	local tst_out
+
+	tst_out="$(tst_rod $@ 2>&1)"
 	if [ $? -ne 0 ]; then
 		echo "$tst_out"
 		tst_brk TBROK "$@ failed"
-- 
2.25.1

