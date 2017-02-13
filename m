From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 13 Feb 2017 17:35:46 +0100
Subject: [LTP] [COMMITTED] [PATCH 2/6] tst_device: Split the
	tst_acquire_device code again
In-Reply-To: <20170213163550.10967-1-chrubis@suse.cz>
References: <20170213163550.10967-1-chrubis@suse.cz>
Message-ID: <20170213163550.10967-2-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This splits the tst_acquire_device code into two parts so that the
function with two underscores returns exit value rather than calling
tst_brkm() with a cleanup pointer.

Once this is done we can reuse the code in shell helper binary so that
we have all the device related code in a single place.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
Acked-by: Jan Stancek <jstancek@redhat.com>
---
 include/old/old_device.h |   4 +-
 lib/tst_device.c         | 121 +++++++++++++++++++++++++++++++++--------------
 2 files changed, 88 insertions(+), 37 deletions(-)

diff --git a/include/old/old_device.h b/include/old/old_device.h
index aabc617..4dbb3ff 100644
--- a/include/old/old_device.h
+++ b/include/old/old_device.h
@@ -44,6 +44,8 @@ const char *tst_dev_fs_type(void);
  */
 const char *tst_acquire_device_(void (cleanup_fn)(void), unsigned int size);
 
+const char *tst_acquire_device__(unsigned int size);
+
 static inline const char *tst_acquire_device(void (cleanup_fn)(void))
 {
 	return tst_acquire_device_(cleanup_fn, 0);
@@ -52,7 +54,7 @@ static inline const char *tst_acquire_device(void (cleanup_fn)(void))
 /*
  * @dev: device path returned by the tst_acquire_device()
  */
-void tst_release_device(const char *dev);
+int tst_release_device(const char *dev);
 
 /*
  * Just like umount() but retries several times on failure.
diff --git a/lib/tst_device.c b/lib/tst_device.c
index 3c62df0..24e8c6f 100644
--- a/lib/tst_device.c
+++ b/lib/tst_device.c
@@ -129,35 +129,44 @@ static int find_free_loopdev(void)
 	return 1;
 }
 
-static void attach_device(void (*cleanup_fn)(void),
-                          const char *dev, const char *file)
+static int attach_device(const char *dev, const char *file)
 {
-	int dev_fd, file_fd, err;
+	int dev_fd, file_fd;
 
-	dev_fd = SAFE_OPEN(cleanup_fn, dev, O_RDWR);
-	file_fd = SAFE_OPEN(cleanup_fn, file, O_RDWR);
+	dev_fd = open(dev, O_RDWR);
+	if (dev_fd < 0) {
+		tst_resm(TWARN | TERRNO, "open('%s', O_RDWR) failed", dev);
+		return 1;
+	}
+
+	file_fd = open(file, O_RDWR);
+	if (file_fd < 0) {
+		tst_resm(TWARN | TERRNO, "open('%s', O_RDWR) failed", file);
+		close(dev_fd);
+		return 1;
+	}
 
 	if (ioctl(dev_fd, LOOP_SET_FD, file_fd) < 0) {
-		err = errno;
 		close(dev_fd);
 		close(file_fd);
-		tst_brkm(TBROK, cleanup_fn,
-		         "ioctl(%s, LOOP_SET_FD, %s) failed: %s",
-			 dev, file, tst_strerrno(err));
+		tst_resm(TWARN | TERRNO, "ioctl(%s, LOOP_SET_FD, %s) failed",
+			 dev, file);
+		return 1;
 	}
 
 	close(dev_fd);
 	close(file_fd);
+	return 0;
 }
 
-static void detach_device(const char *dev)
+static int detach_device(const char *dev)
 {
 	int dev_fd, ret, i;
 
 	dev_fd = open(dev, O_RDONLY);
 	if (dev_fd < 0) {
 		tst_resm(TWARN | TERRNO, "open(%s) failed", dev);
-		return;
+		return 1;
 	}
 
 	/* keep trying to clear LOOPDEV until we get ENXIO, a quick succession
@@ -167,13 +176,15 @@ static void detach_device(const char *dev)
 
 		if (ret && (errno == ENXIO)) {
 			close(dev_fd);
-			return;
+			return 0;
 		}
 
 		if (ret && (errno != EBUSY)) {
 			tst_resm(TWARN,
 				 "ioctl(%s, LOOP_CLR_FD, 0) unexpectedly failed with: %s",
 				 dev, tst_strerrno(errno));
+			close(dev_fd);
+			return 1;
 		}
 
 		usleep(50000);
@@ -182,9 +193,10 @@ static void detach_device(const char *dev)
 	close(dev_fd);
 	tst_resm(TWARN,
 		"ioctl(%s, LOOP_CLR_FD, 0) no ENXIO for too long", dev);
+	return 1;
 }
 
-const char *tst_acquire_device_(void (cleanup_fn)(void), unsigned int size)
+const char *tst_acquire_device__(unsigned int size)
 {
 	int fd;
 	char *dev;
@@ -194,35 +206,48 @@ const char *tst_acquire_device_(void (cleanup_fn)(void), unsigned int size)
 
 	acq_dev_size = size > 150 ? size : 150;
 
-	if (device_acquired)
-		tst_brkm(TBROK, cleanup_fn, "Device allready acquired");
-
-	if (!tst_tmpdir_created()) {
-		tst_brkm(TBROK, cleanup_fn,
-		         "Cannot acquire device without tmpdir() created");
-	}
-
 	dev = getenv("LTP_DEV");
 
 	if (dev) {
 		tst_resm(TINFO, "Using test device LTP_DEV='%s'", dev);
 
-		SAFE_STAT(cleanup_fn, dev, &st);
+		if (stat(dev, &st)) {
+			tst_resm(TWARN | TERRNO, "stat() failed");
+			return NULL;
+		}
 
 		if (!S_ISBLK(st.st_mode)) {
-			tst_brkm(TBROK, cleanup_fn,
-			         "%s is not a block device", dev);
+			tst_resm(TWARN, "%s is not a block device", dev);
+			return NULL;
+		}
+
+		fd = open(dev, O_RDONLY);
+		if (fd < 0) {
+			tst_resm(TWARN | TERRNO,
+				 "open(%s, O_RDONLY) failed", dev);
+			return NULL;
+		}
+
+		if (ioctl(fd, BLKGETSIZE64, &ltp_dev_size)) {
+			tst_resm(TWARN | TERRNO,
+				 "ioctl(fd, BLKGETSIZE64, ...) failed");
+			close(fd);
+			return NULL;
+		}
+
+		if (close(fd)) {
+			tst_resm(TWARN | TERRNO,
+				 "close(fd) failed");
+			return NULL;
 		}
 
-		fd = SAFE_OPEN(cleanup_fn, dev, O_RDONLY);
-		SAFE_IOCTL(cleanup_fn, fd, BLKGETSIZE64, &ltp_dev_size);
-		SAFE_CLOSE(cleanup_fn, fd);
 		ltp_dev_size = ltp_dev_size/1024/1024;
 
 		if (acq_dev_size <= ltp_dev_size) {
 			if (tst_fill_file(dev, 0, 1024, 512)) {
-				tst_brkm(TBROK | TERRNO, cleanup_fn,
-					"Failed to clear the first 512k of %s", dev);
+				tst_resm(TWARN | TERRNO,
+					 "Failed to clear the first 512k of %s",
+					 dev);
 			}
 
 			return dev;
@@ -233,34 +258,58 @@ const char *tst_acquire_device_(void (cleanup_fn)(void), unsigned int size)
 	}
 
 	if (tst_fill_file(DEV_FILE, 0, 1024, 1024 * acq_dev_size)) {
-		tst_brkm(TBROK | TERRNO, cleanup_fn,
-		         "Failed to create " DEV_FILE);
-
+		tst_resm(TWARN | TERRNO, "Failed to create " DEV_FILE);
+		return NULL;
 	}
 
 	if (find_free_loopdev())
 		return NULL;
 
-	attach_device(cleanup_fn, dev_path, DEV_FILE);
+	if (attach_device(dev_path, DEV_FILE))
+		return NULL;
 
 	device_acquired = 1;
 
 	return dev_path;
 }
 
-void tst_release_device(const char *dev)
+const char *tst_acquire_device_(void (cleanup_fn)(void), unsigned int size)
+{
+	const char *device;
+
+	if (device_acquired)
+		tst_brkm(TBROK, cleanup_fn, "Device allready acquired");
+
+	if (!tst_tmpdir_created()) {
+		tst_brkm(TBROK, cleanup_fn,
+		         "Cannot acquire device without tmpdir() created");
+	}
+
+	device = tst_acquire_device__(size);
+
+	if (!device)
+		tst_brkm(TBROK, cleanup_fn, "Failed to acquire device");
+
+	return device;
+}
+
+int tst_release_device(const char *dev)
 {
+	int ret;
+
 	if (getenv("LTP_DEV"))
-		return;
+		return 0;
 
 	/*
 	 * Loop device was created -> we need to deatch it.
 	 *
 	 * The file image is deleted in tst_rmdir();
 	 */
-	detach_device(dev);
+	ret = detach_device(dev);
 
 	device_acquired = 0;
+
+	return ret;
 }
 
 int tst_umount(const char *path)
-- 
2.10.2

