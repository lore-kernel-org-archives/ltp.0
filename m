From: Cedric Hnyda <chnyda@suse.com>
Date: Thu, 29 Oct 2015 17:55:57 +0100
Subject: [LTP]  [PATCH 2/3] diotest4.c: Fixed filesystem
In-Reply-To: <1446137758-27267-1-git-send-email-chnyda@suse.com>
References: <1446137758-27267-1-git-send-email-chnyda@suse.com>
Message-ID: <1446137758-27267-2-git-send-email-chnyda@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Test 3 & 14 were failing for BTRFS
so add TCONF for BTRFS

Signed-off-by: Cedric Hnyda <chnyda@suse.com>
---
 testcases/kernel/io/direct_io/diotest4.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/io/direct_io/diotest4.c b/testcases/kernel/io/direct_io/diotest4.c
index 3ccf49e..6badd93 100644
--- a/testcases/kernel/io/direct_io/diotest4.c
+++ b/testcases/kernel/io/direct_io/diotest4.c
@@ -68,7 +68,7 @@
 
 char *TCID = "diotest4";
 int TST_TOTAL = 17;
-int NO_NFS = 1;
+static long fs_type;
 
 #define BUFSIZE	4096
 #define TRUE	1
@@ -269,12 +269,12 @@ int main(int argc, char *argv[])
 	lseek(fd, offset, SEEK_SET);
 	if (write(fd, buf2, 4096) == -1)
 		tst_resm(TFAIL, "can't write to file %d", ret);
-	if (NO_NFS) {
+	if (fs_type != TST_NFS_MAGIC && fs_type != TST_BTRFS_MAGIC) {
 		ret = runtest_f(fd, buf2, offset, count, EINVAL, "odd count");
 		testcheck_end(ret, &failed, &fail_count,
 					"Odd count of read and write");
 	} else
-		tst_resm(TCONF, "NFS support odd count IO");
+		tst_resm(TCONF, "filesystem supports odd count IO");
 	total++;
 
 	/* Test-4: Read beyond the file size */
@@ -447,13 +447,13 @@ int main(int argc, char *argv[])
 		tst_brkm(TBROK, cleanup, "can't open %s: %s",
 			 filename, strerror(errno));
 	}
-	if (NO_NFS) {
+	if (fs_type != TST_NFS_MAGIC && fs_type != TST_BTRFS_MAGIC) {
 		ret = runtest_f(fd, buf2 + 1, offset, count, EINVAL,
 			" nonaligned buf");
 		testcheck_end(ret, &failed, &fail_count,
 				"read, write with non-aligned buffer");
 	} else
-		tst_resm(TCONF, "NFS support read, write with non-aligned buffer");
+		tst_resm(TCONF, "filesystem supports read, write with non-aligned buffer");
 	close(fd);
 	total++;
 
@@ -573,8 +573,7 @@ static void setup(void)
 
 	close(fd1);
 
-	if (tst_fs_type(cleanup, ".") == TST_NFS_MAGIC)
-		NO_NFS = 0;
+	fs_type = tst_fs_type(cleanup, ".");
 }
 
 static void cleanup(void)
-- 
2.1.4

