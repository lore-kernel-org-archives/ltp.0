From: Sumit Garg <sumit.garg@linaro.org>
Date: Mon, 10 Jun 2019 15:43:16 +0530
Subject: [LTP] [PATCH v4] syscalls/sync_file_range: add partial file sync
	test-cases
Message-ID: <1560161596-30156-1-git-send-email-sumit.garg@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add partial file sync tests as part of sync_file_range02 test-case.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---

Changes in v4:
vfat FS doesn't support sparse files. So handle this via pre-filling the
test file in case of "test3".

Changes in v3:
1. Add upper bound check for synced size to device.
2. Refactor tests for more code reuse.
3. Add another test to check sync over partial write.

Changes in v2:
1. Do full file write instead of partial and test sync partial file.

 .../syscalls/sync_file_range/sync_file_range02.c   | 53 ++++++++++++++++++----
 1 file changed, 43 insertions(+), 10 deletions(-)

diff --git a/testcases/kernel/syscalls/sync_file_range/sync_file_range02.c b/testcases/kernel/syscalls/sync_file_range/sync_file_range02.c
index 82d77f7..9454a56 100644
--- a/testcases/kernel/syscalls/sync_file_range/sync_file_range02.c
+++ b/testcases/kernel/syscalls/sync_file_range/sync_file_range02.c
@@ -22,23 +22,36 @@
 #include "check_sync_file_range.h"
 
 #define MNTPOINT		"mnt_point"
-#define FNAME		MNTPOINT"/test"
-#define FILE_SIZE_MB	32
-#define FILE_SIZE (FILE_SIZE_MB * TST_MB)
+#define FNAME1			MNTPOINT"/test1"
+#define FNAME2			MNTPOINT"/test2"
+#define FNAME3			MNTPOINT"/test3"
+#define FILE_SZ_MB		32
+#define FILE_SZ			(FILE_SZ_MB * TST_MB)
 #define MODE			0644
 
-static void verify_sync_file_range(void)
+struct testcase {
+	char *fname;
+	off64_t sync_off;
+	off64_t sync_size;
+	size_t exp_sync_size;
+	off64_t write_off;
+	size_t write_size_mb;
+};
+
+static void verify_sync_file_range(struct testcase *tc)
 {
 	int fd;
 	unsigned long written;
 
-	fd = SAFE_OPEN(FNAME, O_RDWR|O_CREAT, MODE);
+	fd = SAFE_OPEN(tc->fname, O_RDWR|O_CREAT, MODE);
+
+	lseek(fd, tc->write_off, SEEK_SET);
 
 	tst_dev_bytes_written(tst_device->dev);
 
-	tst_fill_fd(fd, 0, TST_MB, FILE_SIZE_MB);
+	tst_fill_fd(fd, 0, TST_MB, tc->write_size_mb);
 
-	TEST(sync_file_range(fd, 0, FILE_SIZE,
+	TEST(sync_file_range(fd, tc->sync_off, tc->sync_size,
 			     SYNC_FILE_RANGE_WAIT_BEFORE |
 			     SYNC_FILE_RANGE_WRITE |
 			     SYNC_FILE_RANGE_WAIT_AFTER));
@@ -50,23 +63,43 @@ static void verify_sync_file_range(void)
 
 	SAFE_CLOSE(fd);
 
-	if (written >= FILE_SIZE)
+	if ((written >= tc->exp_sync_size) &&
+	    (written <= (tc->exp_sync_size + tc->exp_sync_size/10)))
 		tst_res(TPASS, "Test file range synced to device");
 	else
-		tst_res(TFAIL, "Synced %li, expected %i", written, FILE_SIZE);
+		tst_res(TFAIL, "Synced %li, expected %li", written,
+			tc->exp_sync_size);
+}
+
+static struct testcase testcases[] = {
+	{ FNAME1, 0, FILE_SZ, FILE_SZ, 0, FILE_SZ_MB },
+	{ FNAME2, FILE_SZ/4, FILE_SZ/2, FILE_SZ/2, 0, FILE_SZ_MB },
+	{ FNAME3, FILE_SZ/4, FILE_SZ/2, FILE_SZ/4, FILE_SZ/2, FILE_SZ_MB/4 },
+};
+
+static void run(unsigned int i)
+{
+	verify_sync_file_range(&testcases[i]);
 }
 
 static void setup(void)
 {
 	if (!check_sync_file_range())
 		tst_brk(TCONF, "sync_file_range() not supported");
+
+	if (!strcmp(tst_device->fs_type, "vfat")) {
+		tst_res(TINFO, "Pre-filling file");
+		tst_fill_file(FNAME3, 0, TST_MB, FILE_SZ_MB);
+		sync();
+	}
 }
 
 static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(testcases),
 	.needs_root = 1,
 	.mount_device = 1,
 	.all_filesystems = 1,
 	.mntpoint = MNTPOINT,
 	.setup = setup,
-	.test_all = verify_sync_file_range,
+	.test = run,
 };
-- 
2.7.4

