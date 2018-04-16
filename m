From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 16 Apr 2018 14:17:10 +0300
Subject: [LTP] [PATCH] lib/tst_test.sh: add TST_MIN_KVER variable check
Message-ID: <1523877430-15821-1-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add the same behavior as in LTP C library with 'min_kver'.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/lib/tst_test.sh |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index b7aa4a7..4ac09ef 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -251,7 +251,7 @@ tst_run()
 	if [ -n "$TST_TEST_PATH" ]; then
 		for tst_i in $(grep TST_ "$TST_TEST_PATH" | sed 's/.*TST_//; s/[="} \t\/:`].*//'); do
 			case "$tst_i" in
-			SETUP|CLEANUP|TESTFUNC|ID|CNT);;
+			SETUP|CLEANUP|TESTFUNC|ID|CNT|MIN_KVER);;
 			OPTS|USAGE|PARSE_ARGS|POS_ARGS);;
 			NEEDS_ROOT|NEEDS_TMPDIR|NEEDS_DEVICE|DEVICE);;
 			NEEDS_CMDS|NEEDS_MODULE|MODPATH|DATAROOT);;
@@ -290,6 +290,11 @@ tst_run()
 
 	tst_check_cmds $TST_NEEDS_CMDS
 
+	if [ -n "$TST_MIN_KVER" ]; then
+		tst_kvcmp -lt "$TST_MIN_KVER" && \
+			tst_brk TCONF "test requires kernel $TST_MIN_KVER+"
+	fi
+
 	if [ "$TST_NEEDS_TMPDIR" = 1 ]; then
 		if [ -z "$TMPDIR" ]; then
 			export TMPDIR="/tmp"
-- 
1.7.1

