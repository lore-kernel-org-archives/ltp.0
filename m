From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 11 Oct 2017 16:41:15 +0200
Subject: [LTP] [PATCH v3 01/16] lib/tst_mkfs: Clear first 512k of the device
Message-ID: <20171011144130.29728-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

If we cal tst_mkfs() from a test more than once we end up with the very
same bug we already fixed by clearing the device in
tst_acquire_device(), i.e. some mkfs programs will not format it when
there is a valid FS signature there. But we have to clear the device for
the shell tests as well.

So this commit adds tst_clear_device() function that is both called from
the tst_mkfs() and from the shell tst_device helper to clear up the
first 512k of the device.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/tst_device.h       | 10 ++++++++++
 lib/tst_device.c           | 19 +++++++++++--------
 lib/tst_mkfs.c             |  4 ++++
 testcases/lib/tst_device.c |  5 +++++
 4 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/include/tst_device.h b/include/tst_device.h
index 897696dd9..7ac288368 100644
--- a/include/tst_device.h
+++ b/include/tst_device.h
@@ -34,4 +34,14 @@ extern struct tst_device *tst_device;
  */
 int tst_umount(const char *path);
 
+/*
+ * Clears a first few blocks of the device. This is needed when device has
+ * already been formatted with a filesystems, subset of mkfs.foo utils aborts
+ * the operation if it finds a filesystem signature there.
+ *
+ * Note that this is called from tst_mkfs() automatically, so you probably will
+ * not need to use this from the test yourself.
+ */
+int tst_clear_device(const char *dev);
+
 #endif	/* TST_DEVICE_H__ */
diff --git a/lib/tst_device.c b/lib/tst_device.c
index 67432caf6..6ad6c47f6 100644
--- a/lib/tst_device.c
+++ b/lib/tst_device.c
@@ -245,15 +245,8 @@ const char *tst_acquire_device__(unsigned int size)
 
 		ltp_dev_size = ltp_dev_size/1024/1024;
 
-		if (acq_dev_size <= ltp_dev_size) {
-			if (tst_fill_file(dev, 0, 1024, 512)) {
-				tst_resm(TWARN | TERRNO,
-					 "Failed to clear the first 512k of %s",
-					 dev);
-			}
-
+		if (acq_dev_size <= ltp_dev_size)
 			return dev;
-		}
 
 		tst_resm(TINFO, "Skipping $LTP_DEV size %"PRIu64"MB, requested size %uMB",
 				ltp_dev_size, acq_dev_size);
@@ -319,6 +312,16 @@ int tst_release_device(const char *dev)
 	return ret;
 }
 
+int tst_clear_device(const char *dev)
+{
+	if (tst_fill_file(dev, 0, 1024, 512)) {
+		tst_resm(TWARN, "Failed to clear 512k block on %s", dev);
+		return 1;
+	}
+
+	return 0;
+}
+
 int tst_umount(const char *path)
 {
 	int err, ret, i;
diff --git a/lib/tst_mkfs.c b/lib/tst_mkfs.c
index f2e40ecd6..7385a939f 100644
--- a/lib/tst_mkfs.c
+++ b/lib/tst_mkfs.c
@@ -18,6 +18,7 @@
 #include "test.h"
 #include "ltp_priv.h"
 #include "tst_mkfs.h"
+#include "tst_device.h"
 
 #define OPTS_MAX 32
 
@@ -75,6 +76,9 @@ void tst_mkfs_(const char *file, const int lineno, void (cleanup_fn)(void),
 
 	argv[pos] = NULL;
 
+	if (tst_clear_device(dev))
+		tst_brkm(TBROK, cleanup_fn, "tst_clear_device() failed");
+
 	tst_resm(TINFO, "Formatting %s with %s opts='%s' extra opts='%s'",
 	         dev, fs_type, fs_opts_str, extra_opt ? extra_opt : "");
 	ret = tst_run_cmd(cleanup_fn, argv, "/dev/null", NULL, 1);
diff --git a/testcases/lib/tst_device.c b/testcases/lib/tst_device.c
index d33cac613..9afaeb1ef 100644
--- a/testcases/lib/tst_device.c
+++ b/testcases/lib/tst_device.c
@@ -59,6 +59,11 @@ static int acquire_device(int argc, char *argv[])
 	if (!device)
 		return 1;
 
+	if (tst_clear_device(device)) {
+		tst_release_device(device);
+		return 1;
+	}
+
 	printf("%s", device);
 
 	return 0;
-- 
2.13.5

