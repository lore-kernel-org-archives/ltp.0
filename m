From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 17 Oct 2018 18:21:25 +0800
Subject: [LTP] [PATCH] fs/growfiles.c: Fix the max size of every growing file
Message-ID: <1539771685-28323-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

If -i option is set to zero, some growfiles tests (e.g. gf01,
gf[10-11], gf[14-15], gf18) will grow every file size to 2G
before stopping test.  On less 2G free space, these growfiles
tests fails with ENOSPC early because they cannot grow size to
2G for every file.

We try to compare actual max size of every growing file with
default size(i.e. 2G) and use the samller one as the limit, so
that growing size for every file doesn't fail with ENOSPC on
less 2G free space.

Note:
-T/-U option will truncate or remove some files within specified
interval, but we still give enough space for every file to grow.
we still restrict the max size of every growing file to less than 2G.

Fix: #389

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/fs/doio/growfiles.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/fs/doio/growfiles.c b/testcases/kernel/fs/doio/growfiles.c
index 02df1b28c..eb58ce0cd 100644
--- a/testcases/kernel/fs/doio/growfiles.c
+++ b/testcases/kernel/fs/doio/growfiles.c
@@ -78,6 +78,8 @@
 #include <sys/time.h>
 #include <sys/param.h>
 #include <sys/signal.h>
+#include <sys/statfs.h>
+#include <sys/vfs.h>
 #include <fcntl.h>
 #include <errno.h>
 #include <string.h>
@@ -367,7 +369,8 @@ int main(int argc, char **argv)
 	int stop = 0;		/* loop stopper if set */
 
 	unsigned long curr_size = 0;	/* BUG:14136 (keep track of file size) */
-	const unsigned long ext2_limit = 2147483647;	/* BUG:14136 (2GB ext2 filesize limit) */
+	unsigned long fs_limit = 2147483647; /* BUG:14136 (filesystem size limit is 2G by default) */
+	struct statfs fsbuf;
 
 	int tmp;
 	char chr;
@@ -1360,6 +1363,16 @@ no whole file checking will be performed!\n", Progname, TagName,
 #endif
 	}
 
+	if (statfs(auto_dir, &fsbuf) == -1) {
+		fprintf(stderr, "%s%s: Unable to get the info of mounted "
+			"filesystem that includes dir %s\n",
+			Progname, TagName, auto_dir);
+		exit(1);
+	}
+
+	/* Compare two values and use the smaller one as limit */
+	fs_limit = MIN(fsbuf.f_bsize * fsbuf.f_bavail / num_files, fs_limit);
+
 	/*
 	 * This is the main iteration loop.
 	 * Each iteration, all files can  be opened, written to,
@@ -1476,14 +1489,14 @@ no whole file checking will be performed!\n", Progname, TagName,
 			 * if we are dealing with a FIFO file.
 			 */
 
-			/* BUG:14136 (don't go past ext2's filesize limit) */
+			/* BUG:14136 (don't go past filesystem size limit) */
 			curr_size = file_size(fd);
-			if (curr_size + grow_incr >= ext2_limit) {
+			if (curr_size + grow_incr >= fs_limit) {
 				lkfile(fd, LOCK_UN, LKLVL1);	/* release lock */
 				close(fd);
 				sprintf(reason,
 					"Reached %ld filesize which is almost %ld limit.",
-					curr_size, ext2_limit);
+					curr_size, fs_limit);
 				stop = 1;
 				continue;
 			}
-- 
2.17.0



