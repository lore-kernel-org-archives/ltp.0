From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 14 Feb 2017 16:26:37 +0100
Subject: [LTP] [PATCH 1/3] tst_test: Handle device mkfs/mount int the library
Message-ID: <20170214152639.11603-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This commit adds functionality to format and then mount the test device
to the test library which:

* Saves a few setup steps in most of the testcases that use test device

* The device is umounted in the test library process now -> it will be
  umounted even if the test process has segfaulted.

+ docs

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 doc/test-writing-guidelines.txt | 14 ++++++++++++--
 include/tst_test.h              | 18 +++++++++++++++++-
 lib/newlib_tests/tst_device.c   |  4 ++--
 lib/tst_test.c                  | 39 +++++++++++++++++++++++++++++++++++++--
 4 files changed, 68 insertions(+), 7 deletions(-)

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index a33efb1..4256427 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -911,8 +911,18 @@ structure is initialized with a path to a test device and default filesystem
 to be used.
 
 You can also request minimal device size in megabytes by setting
-'.device_min_size' in the 'struct tst_test' structure. The device is
-guaranteed to have at least the requested size then.
+'.dev_min_size' the device is guaranteed to have at least the requested size
+then.
+
+If '.format_device' flag is set the device is formatted with a filesystem as
+well. You can use '.dev_fs_type' to override the default filesystem type if
+needed and pass additional options to mkfs via '.dev_fs_opts' and
+'.dev_extra_opt' pointers.
+
+If '.mount_device' is set, the device is mounted at '.mntpoint' which is used
+to pass a directory name that will be created and used as mount destination.
+You can pass additional flags and data to the mount command via '.mnt_flags'
+and '.mnt_data' pointers.
 
 [source,c]
 -------------------------------------------------------------------------------
diff --git a/include/tst_test.h b/include/tst_test.h
index 1ed39db..b196a7d 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -117,8 +117,24 @@ struct tst_test {
 	int forks_child:1;
 	int needs_device:1;
 	int needs_checkpoints:1;
+	int format_device:1;
+	int mount_device:1;
 
-	unsigned int device_min_size;
+	/* Minimal device size in bytes */
+	unsigned int dev_min_size;
+
+	/* Device filesystem type override NULL == default */
+	const char *dev_fs_type;
+
+	/* Options passed to SAFE_MKFS() when format_device is set */
+	struct tst_dev_opts *dev_opts;
+	const char *const *dev_fs_opts;
+	const char *dev_extra_opt;
+
+	/* Device mount options, used if mount_device is set */
+	const char *mntpoint;
+	unsigned int mnt_flags;
+	void *mnt_data;
 
 	/* override default timeout per test run */
 	unsigned int timeout;
diff --git a/lib/newlib_tests/tst_device.c b/lib/newlib_tests/tst_device.c
index 72c2033..9bcdce1 100644
--- a/lib/newlib_tests/tst_device.c
+++ b/lib/newlib_tests/tst_device.c
@@ -37,7 +37,7 @@ static void do_test(void)
 	SAFE_IOCTL(fd, BLKGETSIZE64, &ltp_dev_size);
 	SAFE_CLOSE(fd);
 
-	if (ltp_dev_size/1024/1024 == 160)
+	if (ltp_dev_size/1024/1024 == 300)
 		tst_res(TPASS, "Got expected device size");
 	else
 		tst_res(TFAIL, "Got unexpected device size");
@@ -47,6 +47,6 @@ static struct tst_test test = {
 	.tid = "tst_device",
 	.needs_tmpdir = 1,
 	.needs_device = 1,
-	.device_min_size = 160,
+	.dev_min_size = 300,
 	.test_all = do_test,
 };
diff --git a/lib/tst_test.c b/lib/tst_test.c
index f19f763..f87d9a9 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -40,6 +40,7 @@ struct tst_test *tst_test;
 static int iterations = 1;
 static float duration = -1;
 static pid_t main_pid, lib_pid;
+static int device_mounted;
 
 struct results {
 	int passed;
@@ -644,6 +645,14 @@ static void do_setup(int argc, char *argv[])
 	if (tst_test->min_kver)
 		check_kver();
 
+	if (tst_test->format_device)
+		tst_test->needs_device = 1;
+
+	if (tst_test->mount_device) {
+		tst_test->needs_device = 1;
+		tst_test->format_device = 1;
+	}
+
 	parse_opts(argc, argv);
 
 	setup_ipc();
@@ -652,13 +661,36 @@ static void do_setup(int argc, char *argv[])
 		tst_tmpdir();
 
 	if (tst_test->needs_device) {
-		tdev.dev = tst_acquire_device_(NULL, tst_test->device_min_size);
-		tdev.fs_type = tst_dev_fs_type();
+		tdev.dev = tst_acquire_device_(NULL, tst_test->dev_min_size);
 
 		if (!tdev.dev)
 			tst_brk(TCONF, "Failed to acquire device");
 
 		tst_device = &tdev;
+
+		if (tst_test->dev_fs_type)
+			tdev.fs_type = tst_test->dev_fs_type;
+		else
+			tdev.fs_type = tst_dev_fs_type();
+
+		if (tst_test->format_device) {
+			SAFE_MKFS(tdev.dev, tdev.fs_type,
+			          tst_test->dev_fs_opts,
+				  tst_test->dev_extra_opt);
+		}
+
+		if (tst_test->mount_device) {
+
+			if (!tst_test->mntpoint) {
+				tst_brk(TBROK,
+					"tst_test->mntpoint must be set!");
+			}
+
+			SAFE_MKDIR(tst_test->mntpoint, 0777);
+			SAFE_MOUNT(tdev.dev, tst_test->mntpoint, tdev.fs_type,
+				   tst_test->mnt_flags, tst_test->mnt_data);
+			device_mounted = 1;
+		}
 	}
 
 	if (tst_test->resource_files)
@@ -678,6 +710,9 @@ static void do_test_setup(void)
 
 static void do_cleanup(void)
 {
+	if (device_mounted)
+		tst_umount(tst_test->mntpoint);
+
 	if (tst_test->needs_device && tdev.dev)
 		tst_release_device(tdev.dev);
 
-- 
2.10.2

