From: Sandeep Patil <sspatil@google.com>
Date: Mon, 28 Aug 2017 17:11:25 -0700
Subject: [LTP] [RFC][PATCH 1/2] libltp: add support to mount tmpfs
In-Reply-To: <20170829001126.142076-1-sspatil@google.com>
References: <20170829001126.142076-1-sspatil@google.com>
Message-ID: <20170829001126.142076-2-sspatil@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Some tests go through losetup, create, format and mount
filesystems only to run tests for 'EROFS' return value from
system calls. The tests end up being flaky depending on the tools
available on the platform. e.g. mkfs.<filesystem> tool is required for
mounting a device with filesystem.

If the test is only to check for EROFS, this can be achieved by simply
doing a 'tmpfs' read-only mount in $tmpdir.

Example of tests that can benefit from this are:
  access04, mkdirat02, mknodat02, acct01, fchown04, mknod07 etc.

This also allows for these tests to successfully run on Android.

Signed-off-by: Sandeep Patil <sspatil@google.com>
---
 include/tst_test.h |  6 ++++++
 lib/tst_test.c     | 17 +++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/tst_test.h b/include/tst_test.h
index e90312ae3..abd787bd2 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -124,6 +124,7 @@ struct tst_test {
 	int needs_checkpoints:1;
 	int format_device:1;
 	int mount_device:1;
+	int mount_tmpfs:1;
 
 	/* Minimal device size in megabytes */
 	unsigned int dev_min_size;
@@ -140,6 +141,11 @@ struct tst_test {
 	unsigned int mnt_flags;
 	void *mnt_data;
 
+	/* tmpfs mount options, used if mount_tmpfs is set */
+	const char *tmpfs_mntpoint;
+	unsigned int tmpfs_flags;
+	void *tmpfs_data;
+
 	/* override default timeout per test run, disabled == -1 */
 	int timeout;
 
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 4c30edab5..4404b27e0 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -42,6 +42,7 @@ static int iterations = 1;
 static float duration = -1;
 static pid_t main_pid, lib_pid;
 static int device_mounted;
+static int tmpfs_mounted;
 
 struct results {
 	int passed;
@@ -734,6 +735,19 @@ static void do_setup(int argc, char *argv[])
 		}
 	}
 
+	if (tst_test->mount_tmpfs) {
+		if (!tst_test->tmpfs_mntpoint) {
+			tst_brk(TBROK,
+				"tst_test->tmpfs_mntpoint must be set!");
+		}
+
+		SAFE_MKDIR(tst_test->tmpfs_mntpoint, 0777);
+		SAFE_MOUNT("none", tst_test->tmpfs_mntpoint, "tmpfs",
+			   tst_test->tmpfs_flags, tst_test->tmpfs_data);
+
+		tmpfs_mounted = 1;
+	}
+
 	if (tst_test->resource_files)
 		copy_resources();
 }
@@ -751,6 +765,9 @@ static void do_test_setup(void)
 
 static void do_cleanup(void)
 {
+	if (tmpfs_mounted)
+		tst_umount(tst_test->tmpfs_mntpoint);
+
 	if (device_mounted)
 		tst_umount(tst_test->mntpoint);
 
-- 
2.14.1.342.g6490525c54-goog

