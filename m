From: Martin Doucha <mdoucha@suse.cz>
Date: Thu, 23 Jan 2020 17:20:19 +0100
Subject: [LTP] [PATCH v3 3/3] Purge temp directory after each run of
 fallocate05
In-Reply-To: <20200123162019.18958-1-mdoucha@suse.cz>
References: <20200123162019.18958-1-mdoucha@suse.cz>
Message-ID: <20200123162019.18958-4-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The fallocate05 test fills the test device so iterating the test requires
purging the temp directory after each run.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 testcases/kernel/syscalls/fallocate/fallocate05.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/syscalls/fallocate/fallocate05.c b/testcases/kernel/syscalls/fallocate/fallocate05.c
index 00a1d3864..550d10258 100644
--- a/testcases/kernel/syscalls/fallocate/fallocate05.c
+++ b/testcases/kernel/syscalls/fallocate/fallocate05.c
@@ -30,13 +30,13 @@
 #define DEALLOCATE_BLOCKS 4
 #define TESTED_FLAGS "fallocate(FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE)"
 
-static int fd;
 static char *buf;
 static blksize_t blocksize;
 static long bufsize;
 
 static void setup(void)
 {
+	int fd;
 	struct stat statbuf;
 
 	fd = SAFE_OPEN(MNTPOINT "/test_file", O_WRONLY | O_CREAT);
@@ -49,12 +49,15 @@ static void setup(void)
 	blocksize = statbuf.st_blksize;
 	bufsize = FALLOCATE_BLOCKS * blocksize;
 	buf = SAFE_MALLOC(bufsize);
+	SAFE_CLOSE(fd);
 }
 
 static void run(void)
 {
+	int fd;
 	long extsize, tmp;
 
+	fd = SAFE_OPEN(MNTPOINT "/test_file", O_WRONLY | O_CREAT | O_TRUNC);
 	TEST(fallocate(fd, 0, 0, bufsize));
 
 	if (TST_RET) {
@@ -131,14 +134,12 @@ static void run(void)
 	else
 		tst_res(TPASS, "write()");
 
-	/* TODO: wipe the test device here to allow looping with -i/-I */
+	SAFE_CLOSE(fd);
+	tst_purge_dir(MNTPOINT);
 }
 
 static void cleanup(void)
 {
-	if (fd > 0)
-		SAFE_CLOSE(fd);
-
 	free(buf);
 }
 
-- 
2.24.1

