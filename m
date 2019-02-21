From: Sumit Garg <sumit.garg@linaro.org>
Date: Thu, 21 Feb 2019 14:30:08 +0530
Subject: [LTP] [PATCH v4 1/9] lib/tst_device: add new api
	tst_dev_bytes_written()
In-Reply-To: <1550739616-24054-1-git-send-email-sumit.garg@linaro.org>
References: <1550739616-24054-1-git-send-email-sumit.garg@linaro.org>
Message-ID: <1550739616-24054-2-git-send-email-sumit.garg@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This api reads test block device stat file and returns the bytes written
since the last invocation of this api.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 include/tst_device.h |  7 +++++++
 lib/tst_device.c     | 29 +++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/include/tst_device.h b/include/tst_device.h
index 7ac2883..61902b7 100644
--- a/include/tst_device.h
+++ b/include/tst_device.h
@@ -44,4 +44,11 @@ int tst_umount(const char *path);
  */
 int tst_clear_device(const char *dev);
 
+/*
+ * Reads test block device stat file and returns the bytes written since the
+ * last call of this function.
+ * @dev: test block device
+ */
+unsigned long tst_dev_bytes_written(const char *dev);
+
 #endif	/* TST_DEVICE_H__ */
diff --git a/lib/tst_device.c b/lib/tst_device.c
index fd4e277..65fcc13 100644
--- a/lib/tst_device.c
+++ b/lib/tst_device.c
@@ -45,6 +45,7 @@
 
 static char dev_path[1024];
 static int device_acquired;
+static unsigned long prev_dev_sec_write;
 
 static const char *dev_variants[] = {
 	"/dev/loop%i",
@@ -364,3 +365,31 @@ int tst_umount(const char *path)
 	errno = err;
 	return -1;
 }
+
+unsigned long tst_dev_bytes_written(const char *dev)
+{
+	struct stat st;
+	unsigned long dev_sec_write = 0, dev_bytes_written, io_ticks = 0;
+	char dev_stat_path[1024];
+
+	snprintf(dev_stat_path, sizeof(dev_stat_path), "/sys/block/%s/stat",
+		 strrchr(dev, '/') + 1);
+
+	if (stat(dev_stat_path, &st) != 0)
+		tst_brkm(TCONF, NULL, "Test device stat file: %s not found",
+			 dev_stat_path);
+
+	SAFE_FILE_SCANF(NULL, dev_stat_path,
+			"%*s %*s %*s %*s %*s %*s %lu %*s %*s %lu",
+			&dev_sec_write, &io_ticks);
+
+	if (!io_ticks)
+		tst_brkm(TCONF, NULL, "Test device stat file: %s broken",
+			 dev_stat_path);
+
+	dev_bytes_written = (dev_sec_write - prev_dev_sec_write) * 512;
+
+	prev_dev_sec_write = dev_sec_write;
+
+	return dev_bytes_written;
+}
-- 
2.7.4

