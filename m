From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 13 Feb 2018 16:12:50 +0100
Subject: [LTP] [COMMITTED PATCH] dynamic_debug01: fix cleanup on older
	kernels
Message-ID: <11510e85ebeb8c6df2db478722f398b72e36cdcc.1518534470.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

setup() hits TCONF, but cleanup() still runs and tries
to umount non-existend directory, which eventually
reports a failure:
 1 TCONF: Dynamic debug is available since version 2.6.30
 awk: cmd. line:1: fatal: cannot open file `./debug_statements' for reading (No such file or directory)
 Cannot umount ""
 1 TINFO: umount() failed, try 1 ...
 1 TINFO: Likely gvfsd-trash is probing newly mounted  fs, kill it to speed up tests.
 Cannot umount ""
 ...

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/tracing/dynamic_debug/dynamic_debug01.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/tracing/dynamic_debug/dynamic_debug01.sh b/testcases/kernel/tracing/dynamic_debug/dynamic_debug01.sh
index ec58c69c5c28..4cd43baf297f 100755
--- a/testcases/kernel/tracing/dynamic_debug/dynamic_debug01.sh
+++ b/testcases/kernel/tracing/dynamic_debug/dynamic_debug01.sh
@@ -153,7 +153,9 @@ ddebug_test()
 
 cleanup()
 {
-	FLAGS_SET=$(awk -v emp="$EMPTY_FLAG" '$3 != emp' $DYNDEBUG_STATEMENTS)
+	if [ -e "$DYNDEBUG_STATEMENTS" ]; then
+		FLAGS_SET=$(awk -v emp="$EMPTY_FLAG" '$3 != emp' $DYNDEBUG_STATEMENTS)
+	fi
 	if [ "$FLAGS_SET" ] ; then
 		FLAG_PREFIX=$([ $NEW_INTERFACE -eq 1 ] && echo "" || echo "+")
 		/bin/echo "$FLAGS_SET" | while read -r FLAG_LINE ; do
@@ -163,7 +165,7 @@ cleanup()
 				> "$DEBUGFS_CONTROL"
 		done
 	fi
-	if [ $DEBUGFS_WAS_MOUNTED -eq 0 ] ; then
+	if [ $DEBUGFS_WAS_MOUNTED -eq 0 -a -n "$DEBUGFS_PATH" ] ; then
 		tst_umount "$DEBUGFS_PATH"
 	fi
 }
-- 
1.8.3.1

