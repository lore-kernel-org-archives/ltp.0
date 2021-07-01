From: Li Wang <liwang@redhat.com>
Date: Thu,  1 Jul 2021 13:52:07 +0800
Subject: [LTP] [PATCH 1/2] lib: limit the size of tmpfs in LTP
Message-ID: <20210701055208.715395-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

LTP mount and make use of the whole tmpfs of the test system,
generally, it's fine. But if a test (e.g fallocate06) try to
fill full in the filesystem, it takes too long to complete
testing on a large memory system.

This patch adds a new function limit_tmpfs_mount_size with
appending '-o size=xxM' to the mount options in prepare_device()
which helps limit the tmpfs mount size.

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Li Wang <liwang@redhat.com>
---
 include/tst_device.h |  7 +++++++
 lib/tst_device.c     | 15 +++++++++++++++
 lib/tst_test.c       | 10 ++++++++++
 3 files changed, 32 insertions(+)

diff --git a/include/tst_device.h b/include/tst_device.h
index 1d1246e82..51bde4190 100644
--- a/include/tst_device.h
+++ b/include/tst_device.h
@@ -31,6 +31,13 @@ int tst_umount(const char *path);
 int tst_is_mounted(const char *path);
 int tst_is_mounted_at_tmpdir(const char *path);
 
+/*
+ * Limit the tmpfs mount size for LTP test
+ * @mnt_data: mount options from tst_test->mnt_data
+ * @size: tmpfs size to be mounted
+ */
+char *limit_tmpfs_mount_size(const char *mnt_data, unsigned int size);
+
 /*
  * Clears a first few blocks of the device. This is needed when device has
  * already been formatted with a filesystems, subset of mkfs.foo utils aborts
diff --git a/lib/tst_device.c b/lib/tst_device.c
index c096b418b..66a830b7b 100644
--- a/lib/tst_device.c
+++ b/lib/tst_device.c
@@ -45,6 +45,7 @@
 #define DEV_FILE "test_dev.img"
 #define DEV_SIZE_MB 256u
 
+static char tmpfs_buf[1024];
 static char dev_path[1024];
 static int device_acquired;
 static unsigned long prev_dev_sec_write;
@@ -368,6 +369,20 @@ int tst_clear_device(const char *dev)
 	return 0;
 }
 
+char *limit_tmpfs_mount_size(const char *mnt_data, unsigned int size)
+{
+	unsigned int dev_size = MAX(size, DEV_SIZE_MB);
+
+	if (mnt_data)
+		snprintf(tmpfs_buf, sizeof(tmpfs_buf), "%s,size=%uM", mnt_data, dev_size);
+	else
+		snprintf(tmpfs_buf, sizeof(tmpfs_buf), "size=%uM", dev_size);
+
+	tst_resm(TINFO, "Limiting tmpfs size to %uMB", dev_size);
+
+	return tmpfs_buf;
+}
+
 int tst_umount(const char *path)
 {
 	int err, ret, i;
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 55449c80b..27766fbfd 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -896,9 +896,19 @@ static void prepare_device(void)
 	}
 
 	if (tst_test->mount_device) {
+		char *mnt_data = tst_test->mnt_data;
+
+		if (!strcmp(tdev.fs_type, "tmpfs")) {
+			tst_test->mnt_data = limit_tmpfs_mount_size(tst_test->mnt_data,
+					tst_test->dev_min_size);
+		}
+
 		SAFE_MOUNT(tdev.dev, tst_test->mntpoint, tdev.fs_type,
 			   tst_test->mnt_flags, tst_test->mnt_data);
 		mntpoint_mounted = 1;
+
+		if (!strcmp(tdev.fs_type, "tmpfs"))
+			tst_test->mnt_data = mnt_data;
 	}
 }
 
-- 
2.31.1

