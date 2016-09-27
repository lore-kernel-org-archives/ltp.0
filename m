From: Li Wang <liwang@redhat.com>
Date: Tue, 27 Sep 2016 14:51:23 +0800
Subject: [LTP] [PATCH v6] lib: make the loop device size can be increased
Message-ID: <1474959083-26677-1-git-send-email-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

For the purpose of satisfying specific requirements, here rename function
tst_acqurire_device() to tst_acqurie_device_(), then add parameter '@size'
to tst_acquire_device_() to make the test device can be increased according
to real need.

This change gives a flexibility to ltp test device, you can customize its
size by passing 'tst_test->device_min_size' to your cases. But it's limited
that at least 150MB for the device generation.

Also, add tst_device.c tests, updating test-writing-guidelines.txt documents.

Signed-off-by: Li Wang <liwang@redhat.com>
---
 doc/test-writing-guidelines.txt | 12 ++++++----
 include/old/old_device.h        |  7 +++++-
 include/tst_test.h              |  2 ++
 lib/newlib_tests/.gitignore     |  1 +
 lib/newlib_tests/tst_device.c   | 49 +++++++++++++++++++++++++++++++++++++++++
 lib/tst_device.c                | 27 ++++++++++++++++++-----
 lib/tst_test.c                  |  2 +-
 testcases/lib/test.sh           |  8 +++++--
 8 files changed, 94 insertions(+), 14 deletions(-)
 create mode 100644 lib/newlib_tests/tst_device.c

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index f927fc6..9c412be 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -1323,12 +1323,16 @@ Following functions similar to the LTP C interface are available.
 * tst_rmdir()
 * tst_fs_has_free()
 * tst_mkfs()
-* tst_acquire_device()
 * tst_release_device()
 
-There is one more function called 'tst_check_cmds()' that gets unspecified
-number of parameters and asserts that each parameter is a name of an
-executable in '$PATH' and exits the test with 'TCONF' on first missing.
+One more function called 'tst_check_cmds()' that gets unspecified number
+of parameters and asserts that each parameter is a name of an executable
+in '$PATH' and exits the test with 'TCONF' on first missing.
+
+Another one is 'tst_acquire_device()' that looks for LTP_DEV env variable
+first (which may be passed by the test driver or by a user) and returns while
+it's value greater than 150MB. It also does clear first sectors of $LTP_DEV
+and makes the block device size can be increased according to real need.
 
 tst_sleep
 +++++++++
diff --git a/include/old/old_device.h b/include/old/old_device.h
index 4dae05e..aabc617 100644
--- a/include/old/old_device.h
+++ b/include/old/old_device.h
@@ -42,7 +42,12 @@ const char *tst_dev_fs_type(void);
  *
  * Returns path to the device or NULL if it cannot be created.
  */
-const char *tst_acquire_device(void (cleanup_fn)(void));
+const char *tst_acquire_device_(void (cleanup_fn)(void), unsigned int size);
+
+static inline const char *tst_acquire_device(void (cleanup_fn)(void))
+{
+	return tst_acquire_device_(cleanup_fn, 0);
+}
 
 /*
  * @dev: device path returned by the tst_acquire_device()
diff --git a/include/tst_test.h b/include/tst_test.h
index 4c30134..3f7123e 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -106,6 +106,8 @@ struct tst_test {
 	int needs_device:1;
 	int needs_checkpoints:1;
 
+	unsigned int device_min_size;
+
 	/* override default timeout per test run */
 	unsigned int timeout;
 
diff --git a/lib/newlib_tests/.gitignore b/lib/newlib_tests/.gitignore
index c5b643f..1b83738 100644
--- a/lib/newlib_tests/.gitignore
+++ b/lib/newlib_tests/.gitignore
@@ -12,3 +12,4 @@ test11
 test12
 test13
 tst_safe_fileops
+tst_device
diff --git a/lib/newlib_tests/tst_device.c b/lib/newlib_tests/tst_device.c
new file mode 100644
index 0000000..d656904
--- /dev/null
+++ b/lib/newlib_tests/tst_device.c
@@ -0,0 +1,49 @@
+/*
+ * Copyright (c) 2016 Linux Test Project
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <stdlib.h>
+#include <sys/mount.h>
+
+#include "tst_test.h"
+
+static void do_test(void)
+{
+	int fd;
+	const char *dev;
+	unsigned int ltp_dev_size;
+
+	dev = tst_device->dev;
+	if (!dev)
+		tst_brk(TCONF, "Failed to acquire test device");
+
+	SAFE_MKFS(dev, "ext2", NULL, NULL);
+
+	fd = SAFE_OPEN(dev, O_RDONLY);
+	SAFE_IOCTL(fd, BLKGETSIZE64, &ltp_dev_size);
+	SAFE_CLOSE(fd);
+
+	if (ltp_dev_size/1024/1024 == 160)
+		tst_res(TPASS, "PASSED LTP Device Test");
+}
+
+static struct tst_test test = {
+	.tid = "tst_device",
+	.needs_tmpdir = 1,
+	.needs_device = 1,
+	.device_min_size = 160,
+	.test_all = do_test,
+};
diff --git a/lib/tst_device.c b/lib/tst_device.c
index 30b1be2..f02d1c6 100644
--- a/lib/tst_device.c
+++ b/lib/tst_device.c
@@ -182,10 +182,15 @@ static void detach_device(const char *dev)
 		"ioctl(%s, LOOP_CLR_FD, 0) no ENXIO for too long", dev);
 }
 
-const char *tst_acquire_device(void (cleanup_fn)(void))
+const char *tst_acquire_device_(void (cleanup_fn)(void), unsigned int size)
 {
+	int fd;
 	char *dev;
 	struct stat st;
+	unsigned int acq_dev_size;
+	unsigned int ltp_dev_size;
+
+	acq_dev_size = size > 150 ? size : 150;
 
 	if (device_acquired)
 		tst_brkm(TBROK, cleanup_fn, "Device allready acquired");
@@ -207,15 +212,25 @@ const char *tst_acquire_device(void (cleanup_fn)(void))
 			         "%s is not a block device", dev);
 		}
 
-		if (tst_fill_file(dev, 0, 1024, 512)) {
-			tst_brkm(TBROK | TERRNO, cleanup_fn,
-				 "Failed to clear the first 512k of %s", dev);
+		fd = SAFE_OPEN(cleanup_fn, dev, O_RDONLY);
+		SAFE_IOCTL(cleanup_fn, fd, BLKGETSIZE64, &ltp_dev_size);
+		SAFE_CLOSE(cleanup_fn, fd);
+		ltp_dev_size = ltp_dev_size/1024/1024;
+
+		if (acq_dev_size <= ltp_dev_size) {
+			if (tst_fill_file(dev, 0, 1024, 512)) {
+				tst_brkm(TBROK | TERRNO, cleanup_fn,
+					"Failed to clear the first 512k of %s", dev);
+			}
+
+			return dev;
 		}
 
-		return dev;
+		tst_resm(TINFO, "Skipping $LTP_DEV size %luMB, requested size %luMB",
+				ltp_dev_size, acq_dev_size);
 	}
 
-	if (tst_fill_file(DEV_FILE, 0, 1024, 153600)) {
+	if (tst_fill_file(DEV_FILE, 0, 1024, 1024 * acq_dev_size)) {
 		tst_brkm(TBROK | TERRNO, cleanup_fn,
 		         "Failed to create " DEV_FILE);
 
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 12ca051..06f0339 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -596,7 +596,7 @@ static void do_setup(int argc, char *argv[])
 	}
 
 	if (tst_test->needs_device) {
-		tdev.dev = tst_acquire_device(NULL);
+		tdev.dev = tst_acquire_device_(NULL, tst_test->device_min_size);
 		tdev.fs_type = tst_dev_fs_type();
 
 		if (!tdev.dev)
diff --git a/testcases/lib/test.sh b/testcases/lib/test.sh
index a1fa2d9..76b7062 100644
--- a/testcases/lib/test.sh
+++ b/testcases/lib/test.sh
@@ -283,11 +283,15 @@ EXPECT_FAIL()
 
 tst_acquire_device()
 {
+	local acq_dev_size=${1:-150}
+
 	if [ -z ${TST_TMPDIR} ]; then
 		tst_brkm "Use 'tst_tmpdir' before 'tst_acquire_device'"
 	fi
 
-	if [ -n "${LTP_DEV}" ]; then
+	ltp_dev_size=$((`blockdev --getsize64 $LTP_DEV`/1024/1024))
+
+	if [ -n "${LTP_DEV}" ] && [ ${acq_dev_size} -le ${ltp_dev_size} ]; then
 		tst_resm TINFO "Using test device LTP_DEV='${LTP_DEV}'"
 		if [ ! -b ${LTP_DEV} ]; then
 			tst_brkm TBROK "${LTP_DEV} is not a block device"
@@ -300,7 +304,7 @@ tst_acquire_device()
 		return
 	fi
 
-	ROD_SILENT dd if=/dev/zero of=test_dev.img bs=1024 count=153600
+	ROD_SILENT dd if=/dev/zero of=test_dev.img bs=1024 count=$((1024*$acq_dev_size))
 
 	TST_DEVICE=$(losetup -f)
 	if [ $? -ne 0 ]; then
-- 
1.8.3.1

