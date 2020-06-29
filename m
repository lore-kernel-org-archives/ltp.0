From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Mon, 29 Jun 2020 19:41:22 +0800
Subject: [LTP] [PATCH v5 1/2] tst_device: Add new api
 tst_find_backing_dev(path, dev)
In-Reply-To: <1904309747.19085433.1593428894028.JavaMail.zimbra@redhat.com>
References: <1904309747.19085433.1593428894028.JavaMail.zimbra@redhat.com>
Message-ID: <1593430883-6131-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This api uses stat() to get major/minor devnumber of the path, assign the
10th column value to dev when match succeeds in "/proc/self/mountinfo".

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 doc/test-writing-guidelines.txt | 11 +++++++++++
 include/tst_device.h            |  7 +++++++
 lib/newlib_tests/tst_device.c   |  8 ++++++++
 lib/tst_device.c                | 21 +++++++++++++++++++++
 4 files changed, 47 insertions(+)

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index 6e466ed0f..58116a40e 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -1089,6 +1089,17 @@ FS deferred IO metadata/cache interference, we suggest doing "syncfs" before the
 tst_dev_bytes_written first invocation. And an inline function named tst_dev_sync
 is created for that intention.
 
+[source,c]
+-------------------------------------------------------------------------------
+#include "tst_test.h"
+
+voud tst_find_backing_dev(const char *path, char *dev);
+-------------------------------------------------------------------------------
+
+This function finds the block dev that this path belongs to, it uses stat function
+to get the major/minor number of the path. Then scan them in "/proc/self/mountinfo"
+and list 10th column value as its block dev if match succeeds.
+
 2.2.16 Formatting a device with a filesystem
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
diff --git a/include/tst_device.h b/include/tst_device.h
index 950cfe1ed..6a1fc5186 100644
--- a/include/tst_device.h
+++ b/include/tst_device.h
@@ -84,4 +84,11 @@ unsigned long tst_dev_bytes_written(const char *dev);
  */
 void tst_purge_dir(const char *path);
 
+/*
+ * Find the file or path belongs to which block dev
+ * @path  Path to find the backing dev
+ * @dev   The block dev
+ */
+void tst_find_backing_dev(const char *path, char *dev);
+
 #endif	/* TST_DEVICE_H__ */
diff --git a/lib/newlib_tests/tst_device.c b/lib/newlib_tests/tst_device.c
index 1344495b3..ad077affd 100644
--- a/lib/newlib_tests/tst_device.c
+++ b/lib/newlib_tests/tst_device.c
@@ -13,6 +13,7 @@ static void do_test(void)
 {
 	int fd;
 	const char *dev;
+	char block_dev[100];
 	uint64_t ltp_dev_size;
 
 	dev = tst_device->dev;
@@ -29,6 +30,13 @@ static void do_test(void)
 		tst_res(TPASS, "Got expected device size");
 	else
 		tst_res(TFAIL, "Got unexpected device size");
+
+	tst_find_backing_dev("/boot", block_dev);
+	tst_res(TPASS, "/boot belongs to %s block dev", block_dev);
+	tst_find_backing_dev("/", block_dev);
+	tst_res(TPASS, "/ belongs to %s block dev", block_dev);
+	tst_find_backing_dev("/tmp", block_dev);
+	tst_find_backing_dev("/boot/xuyang", block_dev);
 }
 
 static struct tst_test test = {
diff --git a/lib/tst_device.c b/lib/tst_device.c
index 67fe90ed6..842bb7ca7 100644
--- a/lib/tst_device.c
+++ b/lib/tst_device.c
@@ -31,6 +31,7 @@
 #include <linux/loop.h>
 #include <stdint.h>
 #include <inttypes.h>
+#include <sys/sysmacros.h>
 #include "lapi/syscalls.h"
 #include "test.h"
 #include "safe_macros.h"
@@ -488,3 +489,23 @@ unsigned long tst_dev_bytes_written(const char *dev)
 
 	return dev_bytes_written;
 }
+
+void tst_find_backing_dev(const char *path, char *dev)
+{
+	char fmt[1024];
+	struct stat buf;
+
+	if (stat(path, &buf) < 0)
+		 tst_brkm(TWARN | TERRNO, NULL, "stat() failed");
+
+	snprintf(fmt, sizeof(fmt), "%%*i %%*i %u:%u %%*s %%*s %%*s %%*s %%*s %%*s %%s %%*s",
+			major(buf.st_dev), minor(buf.st_dev));
+
+	SAFE_FILE_LINES_SCANF(NULL, "/proc/self/mountinfo", fmt, dev);
+
+	if (stat(dev, &buf) < 0)
+		 tst_brkm(TWARN | TERRNO, NULL, "stat(%s) failed", dev);
+
+	if (S_ISBLK(buf.st_mode) != 1)
+		tst_brkm(TCONF, NULL, "dev(%s) isn't a block dev", dev);
+}
-- 
2.23.0



