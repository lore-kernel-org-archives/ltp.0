From: Radoslav Kolev <radoslav.kolev@suse.com>
Date: Mon, 21 Dec 2020 13:01:20 +0200
Subject: [LTP] [PATCH] cpio_tests.sh: Fix failure with BusyBox cpio
Message-ID: <20201221110120.26165-1-radoslav.kolev@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

A very limited BusyBox cpio requires the archive format to be
explicitly set to newc when creating an archive.

Signed-off-by: Radoslav Kolev <radoslav.kolev@suse.com>
---
 testcases/commands/cpio/cpio_tests.sh | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/testcases/commands/cpio/cpio_tests.sh b/testcases/commands/cpio/cpio_tests.sh
index a1469d873..57b6d983c 100755
--- a/testcases/commands/cpio/cpio_tests.sh
+++ b/testcases/commands/cpio/cpio_tests.sh
@@ -8,6 +8,12 @@ TST_NEEDS_TMPDIR=1
 TST_NEEDS_CMDS="cpio"
 . tst_test.sh
 
+ARCHIVE_FORMAT=""
+
+if cpio 2>&1 | grep -q '\-o\sCreate (requires -H newc)'; then
+	ARCHIVE_FORMAT="-H newc"
+fi
+
 cpio_test()
 {
 	ROD mkdir "dir"
@@ -16,7 +22,7 @@ cpio_test()
 	done
 
 	ROD find dir -type f > filelist
-	EXPECT_PASS cpio -o \> cpio.out \< filelist
+	EXPECT_PASS cpio -o $ARCHIVE_FORMAT \> cpio.out \< filelist
 	ROD mv "dir" "dir_orig"
 	ROD mkdir "dir"
 	EXPECT_PASS cpio -i \< cpio.out
-- 
2.26.2

