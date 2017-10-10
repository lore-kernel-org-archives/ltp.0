From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 10 Oct 2017 14:32:04 +0200
Subject: [LTP] [PATCH v2 14/15] syscalls/fsync01: Run test for all
	filesystems.
In-Reply-To: <20171010123205.20147-1-chrubis@suse.cz>
References: <20171010123205.20147-1-chrubis@suse.cz>
Message-ID: <20171010123205.20147-14-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

+ do write() + fsync() 10 times

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/fsync/fsync01.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/syscalls/fsync/fsync01.c b/testcases/kernel/syscalls/fsync/fsync01.c
index af35902bd..c93b131f2 100644
--- a/testcases/kernel/syscalls/fsync/fsync01.c
+++ b/testcases/kernel/syscalls/fsync/fsync01.c
@@ -45,19 +45,23 @@ static int fd;
 
 static void verify_fsync(void)
 {
-	SAFE_WRITE(1, fd, BUF, sizeof(BUF));
+	unsigned int i;
 
-	TEST(fsync(fd));
+	for (i = 0; i < 10; i++) {
+		SAFE_WRITE(1, fd, BUF, sizeof(BUF));
 
-	if (TEST_RETURN == -1)
-		tst_res(TFAIL | TTERRNO, "fsync failed");
-	else
-		tst_res(TPASS, "fsync() returned %ld", TEST_RETURN);
+		TEST(fsync(fd));
+
+		if (TEST_RETURN == -1)
+			tst_res(TFAIL | TTERRNO, "fsync failed");
+		else
+			tst_res(TPASS, "fsync() returned %ld", TEST_RETURN);
+	}
 }
 
 static void setup(void)
 {
-	sprintf(fname, "tfile_%d", getpid());
+	sprintf(fname, "mntpoint/tfile_%d", getpid());
 	fd = SAFE_OPEN(fname, O_RDWR | O_CREAT, 0700);
 }
 
@@ -72,4 +76,8 @@ static struct tst_test test = {
 	.setup = setup,
 	.test_all = verify_fsync,
 	.needs_tmpdir = 1,
+	.needs_root = 1,
+	.mount_device = 1,
+	.mntpoint = "mntpoint",
+	.all_filesystems = 1,
 };
-- 
2.13.5

