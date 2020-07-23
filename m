From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Thu, 23 Jul 2020 16:30:00 +0800
Subject: [LTP] [PATCH v1 1/2] Allow detach file from loop device with
 opening dev_fd
Message-ID: <1595493001-15724-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Before this api, it will report the following error when using
tst_attach_device with opening device fd because the device was
opened twice at this point.

tst_device.c:223: WARN: ioctl(/dev/loop0, LOOP_CLR_FD, 0) no ENXIO for
>> too long

Add a tst_detach_device_by_fd() and change the library so that
tst_detach_device() opens/close the dev_path and calls tst_detach_device_by_fd()
internally.

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 include/tst_device.h | 11 +++++++++++
 lib/tst_device.c     | 31 ++++++++++++++++++-------------
 2 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/include/tst_device.h b/include/tst_device.h
index 6a1fc5186..59cc5b96c 100644
--- a/include/tst_device.h
+++ b/include/tst_device.h
@@ -57,11 +57,22 @@ int tst_find_free_loopdev(const char *path, size_t path_len);
  */
 int tst_attach_device(const char *dev_path, const char *file_path);
 
+/*
+ * Detaches a file from a loop device fd.
+ *
+ * @dev_path Path to the loop device e.g. /dev/loop0
+ * @dev_fd a open fd for the loop device
+ * @return Zero on succes, non-zero otherwise.
+ * */
+
+int tst_detach_device_by_fd(const char *dev_path, int dev_fd);
+
 /*
  * Detaches a file from a loop device.
  *
  * @dev_path Path to the loop device e.g. /dev/loop0
  * @return Zero on succes, non-zero otherwise.
+ * In internal, call tst_detach_device_by_fd api.
  */
 int tst_detach_device(const char *dev_path);
 
diff --git a/lib/tst_device.c b/lib/tst_device.c
index 131a223be..8d8bc5b40 100644
--- a/lib/tst_device.c
+++ b/lib/tst_device.c
@@ -187,43 +187,48 @@ int tst_attach_device(const char *dev, const char *file)
 	return 0;
 }
 
-int tst_detach_device(const char *dev)
+int tst_detach_device_by_fd(const char *dev, int dev_fd)
 {
-	int dev_fd, ret, i;
-
-	dev_fd = open(dev, O_RDONLY);
-	if (dev_fd < 0) {
-		tst_resm(TWARN | TERRNO, "open(%s) failed", dev);
-		return 1;
-	}
+	int ret, i;
 
 	/* keep trying to clear LOOPDEV until we get ENXIO, a quick succession
 	 * of attach/detach might not give udev enough time to complete */
 	for (i = 0; i < 40; i++) {
 		ret = ioctl(dev_fd, LOOP_CLR_FD, 0);
 
-		if (ret && (errno == ENXIO)) {
-			close(dev_fd);
+		if (ret && (errno == ENXIO))
 			return 0;
-		}
 
 		if (ret && (errno != EBUSY)) {
 			tst_resm(TWARN,
 				 "ioctl(%s, LOOP_CLR_FD, 0) unexpectedly failed with: %s",
 				 dev, tst_strerrno(errno));
-			close(dev_fd);
 			return 1;
 		}
 
 		usleep(50000);
 	}
 
-	close(dev_fd);
 	tst_resm(TWARN,
 		"ioctl(%s, LOOP_CLR_FD, 0) no ENXIO for too long", dev);
 	return 1;
 }
 
+int tst_detach_device(const char *dev)
+{
+	int dev_fd, ret;
+
+	dev_fd = open(dev, O_RDONLY);
+	if (dev_fd < 0) {
+		tst_resm(TWARN | TERRNO, "open(%s) failed", dev);
+		return 1;
+	}
+
+	ret = tst_detach_device_by_fd(dev, dev_fd);
+	close(dev_fd);
+	return ret;
+}
+
 int tst_dev_sync(int fd)
 {
 	return syscall(__NR_syncfs, fd);
-- 
2.23.0



