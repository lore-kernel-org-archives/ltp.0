From: Li Wang <liwang@redhat.com>
Date: Fri,  9 Jul 2021 15:52:02 +0800
Subject: [LTP] [PATCH v3 1/3] lib: add new function tst_get_device_size
Message-ID: <20210709075204.999168-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Li Wang <liwang@redhat.com>
---
 doc/c-test-api.txt   | 10 ++++++
 include/tst_device.h |  7 ++++
 lib/tst_device.c     | 76 +++++++++++++++++++++++++-------------------
 3 files changed, 60 insertions(+), 33 deletions(-)

diff --git a/doc/c-test-api.txt b/doc/c-test-api.txt
index 4af1a9c97..e4ba858cf 100644
--- a/doc/c-test-api.txt
+++ b/doc/c-test-api.txt
@@ -979,6 +979,16 @@ This function finds the block dev that this path belongs to, it uses stat functi
 to get the major/minor number of the path. Then scan them in "/proc/self/mountinfo"
 and list 2th column value after ' - ' string as its block dev if match succeeds.
 
+[source,c]
+-------------------------------------------------------------------------------
+#include "tst_test.h"
+
+uint64_t tst_get_device_size(const char *dev_path);
+-------------------------------------------------------------------------------
+
+This function gets size of the given block device, it checks the dev_path is
+valid first, if yes, return the size in MB, otherwise return -1.
+
 1.16 Formatting a device with a filesystem
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/include/tst_device.h b/include/tst_device.h
index 1d1246e82..72c560c02 100644
--- a/include/tst_device.h
+++ b/include/tst_device.h
@@ -7,10 +7,12 @@
 #define TST_DEVICE_H__
 
 #include <unistd.h>
+#include <stdint.h>
 
 struct tst_device {
 	const char *dev;
 	const char *fs_type;
+	uint64_t size;
 };
 
 /*
@@ -57,6 +59,11 @@ int tst_find_free_loopdev(const char *path, size_t path_len);
  */
 int tst_attach_device(const char *dev_path, const char *file_path);
 
+/*
+ * Get size (in MB) of the given device
+ */
+uint64_t tst_get_device_size(const char *dev_path);
+
 /*
  * Detaches a file from a loop device fd.
  *
diff --git a/lib/tst_device.c b/lib/tst_device.c
index c096b418b..c91c6cd55 100644
--- a/lib/tst_device.c
+++ b/lib/tst_device.c
@@ -187,6 +187,48 @@ int tst_attach_device(const char *dev, const char *file)
 	return 0;
 }
 
+uint64_t tst_get_device_size(const char *dev_path)
+{
+	int fd;
+	uint64_t size;
+	struct stat st;
+
+	if (!dev_path)
+		tst_brkm(TBROK, NULL, "No block device path");
+
+	if (stat(dev_path, &st)) {
+		tst_resm(TWARN | TERRNO, "stat() failed");
+		return -1;
+	}
+
+	if (!S_ISBLK(st.st_mode)) {
+		tst_resm(TWARN, "%s is not a block device", dev_path);
+		return -1;
+	}
+
+	fd = open(dev_path, O_RDONLY);
+	if (fd < 0) {
+		tst_resm(TWARN | TERRNO,
+				"open(%s, O_RDONLY) failed", dev_path);
+		return -1;
+	}
+
+	if (ioctl(fd, BLKGETSIZE64, &size)) {
+		tst_resm(TWARN | TERRNO,
+				"ioctl(fd, BLKGETSIZE64, ...) failed");
+		close(fd);
+		return -1;
+	}
+
+	if (close(fd)) {
+		tst_resm(TWARN | TERRNO,
+				"close(fd) failed");
+		return -1;
+	}
+
+	return size/1024/1024;
+}
+
 int tst_detach_device_by_fd(const char *dev, int dev_fd)
 {
 	int ret, i;
@@ -254,9 +296,7 @@ const char *tst_acquire_loop_device(unsigned int size, const char *filename)
 
 const char *tst_acquire_device__(unsigned int size)
 {
-	int fd;
 	const char *dev;
-	struct stat st;
 	unsigned int acq_dev_size;
 	uint64_t ltp_dev_size;
 
@@ -267,37 +307,7 @@ const char *tst_acquire_device__(unsigned int size)
 	if (dev) {
 		tst_resm(TINFO, "Using test device LTP_DEV='%s'", dev);
 
-		if (stat(dev, &st)) {
-			tst_resm(TWARN | TERRNO, "stat() failed");
-			return NULL;
-		}
-
-		if (!S_ISBLK(st.st_mode)) {
-			tst_resm(TWARN, "%s is not a block device", dev);
-			return NULL;
-		}
-
-		fd = open(dev, O_RDONLY);
-		if (fd < 0) {
-			tst_resm(TWARN | TERRNO,
-				 "open(%s, O_RDONLY) failed", dev);
-			return NULL;
-		}
-
-		if (ioctl(fd, BLKGETSIZE64, &ltp_dev_size)) {
-			tst_resm(TWARN | TERRNO,
-				 "ioctl(fd, BLKGETSIZE64, ...) failed");
-			close(fd);
-			return NULL;
-		}
-
-		if (close(fd)) {
-			tst_resm(TWARN | TERRNO,
-				 "close(fd) failed");
-			return NULL;
-		}
-
-		ltp_dev_size = ltp_dev_size/1024/1024;
+		ltp_dev_size = tst_get_device_size(dev);
 
 		if (acq_dev_size <= ltp_dev_size)
 			return dev;
-- 
2.31.1

