From: Martin Doucha <mdoucha@suse.cz>
Date: Wed, 29 Jan 2020 15:49:12 +0100
Subject: [LTP] [PATCH 2/3] Allow acquiring multiple loop devices
In-Reply-To: <20200129144913.9889-1-mdoucha@suse.cz>
References: <20200129144913.9889-1-mdoucha@suse.cz>
Message-ID: <20200129144913.9889-3-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

tst_acquire_device__() currently uses a hardcoded filename so only one loop
device can be used at a time. Allow setting arbitrary temp filename so that
multiple different loop devices can be acquired.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 include/old/old_device.h   | 15 ++++++++++++++-
 lib/tst_device.c           | 36 +++++++++++++++++++++++-------------
 testcases/lib/tst_device.c | 14 +++++++++-----
 3 files changed, 46 insertions(+), 19 deletions(-)

diff --git a/include/old/old_device.h b/include/old/old_device.h
index d2f1ecde5..a6e9fea86 100644
--- a/include/old/old_device.h
+++ b/include/old/old_device.h
@@ -52,13 +52,26 @@ static inline const char *tst_acquire_device(void (cleanup_fn)(void))
 	return tst_acquire_device_(cleanup_fn, 0);
 }
 
+/*
+ * Acquire a loop device with specified temp filename. This function allows
+ * you to acquire multiple devices at the same time. LTP_DEV is ignored.
+ * If you call this function directly, use tst_detach_device() to release
+ * the devices. tst_release_device() will not work correctly.
+ *
+ * The return value points to a static buffer and additional calls of
+ * tst_acquire_loop_device() or tst_acquire_device() will overwrite it.
+ */
+const char *tst_acquire_loop_device(unsigned int size, const char *filename);
+
 /*
  * @dev: device path returned by the tst_acquire_device()
  */
 int tst_release_device(const char *dev);
 
 /*
- * @dev: device path returned by the tst_acquire_device()
+ * Cleanup function for tst_acquire_loop_device(). If you have acquired
+ * a device using tst_acquire_device(), use tst_release_device() instead.
+ * @dev: device path returned by the tst_acquire_loop_device()
  */
 int tst_detach_device(const char *dev);
 
diff --git a/lib/tst_device.c b/lib/tst_device.c
index 89b9c96de..ac6806e43 100644
--- a/lib/tst_device.c
+++ b/lib/tst_device.c
@@ -228,10 +228,28 @@ int tst_dev_sync(int fd)
 	return syscall(__NR_syncfs, fd);
 }
 
+const char *tst_acquire_loop_device(unsigned int size, const char *filename)
+{
+	unsigned int acq_dev_size = MAX(size, DEV_SIZE_MB);
+
+	if (tst_fill_file(filename, 0, 1024 * 1024, acq_dev_size)) {
+		tst_resm(TWARN | TERRNO, "Failed to create %s", filename);
+		return NULL;
+	}
+
+	if (tst_find_free_loopdev(dev_path, sizeof(dev_path)) == -1)
+		return NULL;
+
+	if (tst_attach_device(dev_path, filename))
+		return NULL;
+
+	return dev_path;
+}
+
 const char *tst_acquire_device__(unsigned int size)
 {
 	int fd;
-	char *dev;
+	const char *dev;
 	struct stat st;
 	unsigned int acq_dev_size;
 	uint64_t ltp_dev_size;
@@ -282,20 +300,12 @@ const char *tst_acquire_device__(unsigned int size)
 				ltp_dev_size, acq_dev_size);
 	}
 
-	if (tst_fill_file(DEV_FILE, 0, 1024 * 1024, acq_dev_size)) {
-		tst_resm(TWARN | TERRNO, "Failed to create " DEV_FILE);
-		return NULL;
-	}
-
-	if (tst_find_free_loopdev(dev_path, sizeof(dev_path)) == -1)
-		return NULL;
+	dev = tst_acquire_loop_device(acq_dev_size, DEV_FILE);
 
-	if (tst_attach_device(dev_path, DEV_FILE))
-		return NULL;
+	if (dev)
+		device_acquired = 1;
 
-	device_acquired = 1;
-
-	return dev_path;
+	return dev;
 }
 
 const char *tst_acquire_device_(void (cleanup_fn)(void), unsigned int size)
diff --git a/testcases/lib/tst_device.c b/testcases/lib/tst_device.c
index a657db30b..2a3ab1222 100644
--- a/testcases/lib/tst_device.c
+++ b/testcases/lib/tst_device.c
@@ -18,7 +18,7 @@ static struct tst_test test = {
 
 static void print_help(void)
 {
-	fprintf(stderr, "\nUsage: tst_device acquire [size]\n");
+	fprintf(stderr, "\nUsage: tst_device acquire [size [filename]]\n");
 	fprintf(stderr, "   or: tst_device release /path/to/device\n\n");
 }
 
@@ -27,10 +27,10 @@ static int acquire_device(int argc, char *argv[])
 	unsigned int size = 0;
 	const char *device;
 
-	if (argc > 3)
+	if (argc > 4)
 		return 1;
 
-	if (argc == 3) {
+	if (argc >= 3) {
 		size = atoi(argv[2]);
 
 		if (!size) {
@@ -40,7 +40,11 @@ static int acquire_device(int argc, char *argv[])
 		}
 	}
 
-	device = tst_acquire_device__(size);
+	if (argc >= 4) {
+		device = tst_acquire_loop_device(size, argv[3]);
+	} else {
+		device = tst_acquire_device__(size);
+	}
 
 	if (!device)
 		return 1;
@@ -61,7 +65,7 @@ static int release_device(int argc, char *argv[])
 		return 1;
 
 	/*
-	 * tst_acquire_device() was called in a different process.
+	 * tst_acquire_[loop_]device() was called in a different process.
 	 * tst_release_device() would think that no device was acquired yet
 	 * and do nothing. Call tst_detach_device() directly to bypass
 	 * the check.
-- 
2.24.1

