From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue,  5 Mar 2019 12:44:25 +0530
Subject: [LTP] [PATCH v2 1/2] syscalls/sync_file_range: add partial file
	sync test-case
Message-ID: <1551770065-20444-1-git-send-email-sumit.garg@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add partial file sync test as part of sync_file_range02 test-case.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---

Changes in v2:
1. Do full file write instead of partial and test sync partial file.

 .../syscalls/sync_file_range/sync_file_range02.c   | 47 +++++++++++++++++++++-
 1 file changed, 45 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/sync_file_range/sync_file_range02.c b/testcases/kernel/syscalls/sync_file_range/sync_file_range02.c
index 82d77f7..2d2ed2f 100644
--- a/testcases/kernel/syscalls/sync_file_range/sync_file_range02.c
+++ b/testcases/kernel/syscalls/sync_file_range/sync_file_range02.c
@@ -27,7 +27,7 @@
 #define FILE_SIZE (FILE_SIZE_MB * TST_MB)
 #define MODE			0644
 
-static void verify_sync_file_range(void)
+static void verify_sync_full_file(void)
 {
 	int fd;
 	unsigned long written;
@@ -56,6 +56,48 @@ static void verify_sync_file_range(void)
 		tst_res(TFAIL, "Synced %li, expected %i", written, FILE_SIZE);
 }
 
+static void verify_sync_partial_file(void)
+{
+	int fd;
+	unsigned long written;
+
+	fd = SAFE_OPEN(FNAME, O_RDWR|O_CREAT, MODE);
+
+	tst_dev_bytes_written(tst_device->dev);
+
+	tst_fill_fd(fd, 0xff, TST_MB, FILE_SIZE_MB);
+
+	TEST(sync_file_range(fd, FILE_SIZE/4, FILE_SIZE/2,
+			     SYNC_FILE_RANGE_WAIT_BEFORE |
+			     SYNC_FILE_RANGE_WRITE |
+			     SYNC_FILE_RANGE_WAIT_AFTER));
+
+	if (TST_RET)
+		tst_brk(TFAIL | TTERRNO, "sync_file_range() failed");
+
+	written = tst_dev_bytes_written(tst_device->dev);
+
+	SAFE_CLOSE(fd);
+
+	if (written >= FILE_SIZE/2)
+		tst_res(TPASS, "Test file range synced to device");
+	else
+		tst_res(TFAIL, "Synced %li, expected %i", written,
+			FILE_SIZE/2);
+}
+
+static struct tcase {
+	void (*tfunc)(void);
+} tcases[] = {
+	{&verify_sync_full_file},
+	{&verify_sync_partial_file}
+};
+
+static void run(unsigned int i)
+{
+	tcases[i].tfunc();
+}
+
 static void setup(void)
 {
 	if (!check_sync_file_range())
@@ -63,10 +105,11 @@ static void setup(void)
 }
 
 static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tcases),
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

