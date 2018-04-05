From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu,  5 Apr 2018 16:01:48 +0200
Subject: [LTP] [RFC PATCH 2/8] lib/tst_test: Populate the read-only fs
In-Reply-To: <20180405140154.6218-1-chrubis@suse.cz>
References: <20180405140154.6218-1-chrubis@suse.cz>
Message-ID: <20180405140154.6218-3-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Populate the read only filesystem with a file and a directory.

This is needed for a testing syscalls such as unlink() or rmdir() for
EROFS error.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 lib/tst_test.c | 45 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 36 insertions(+), 9 deletions(-)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index 5e10460b0..3b9014487 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -695,6 +695,32 @@ static void assert_test_fn(void)
 		tst_brk(TBROK, "You can define tcnt only for test()");
 }
 
+static int prepare_and_mount_ro_fs(const char *dev,
+                                   const char *mntpoint,
+                                   const char *fs_type)
+{
+	char buf[PATH_MAX];
+
+	if (mount(dev, mntpoint, fs_type, 0, NULL)) {
+		tst_res(TINFO | TERRNO, "Can't mount %s at %s (%s)",
+			dev, mntpoint, fs_type);
+		return 1;
+	}
+
+	mntpoint_mounted = 1;
+
+	snprintf(buf, sizeof(buf), "%s/dir/", mntpoint);
+	SAFE_MKDIR(buf, 0777);
+
+	snprintf(buf, sizeof(buf), "%s/file", mntpoint);
+	SAFE_FILE_PRINTF(buf, "file content");
+	SAFE_CHMOD(buf, 0777);
+
+	SAFE_MOUNT(dev, mntpoint, fs_type, MS_REMOUNT | MS_RDONLY, NULL);
+
+	return 0;
+}
+
 static void prepare_device(void)
 {
 	if (tst_test->format_device) {
@@ -702,6 +728,12 @@ static void prepare_device(void)
 			  tst_test->dev_extra_opt);
 	}
 
+	if (tst_test->needs_rofs) {
+		prepare_and_mount_ro_fs(tdev.dev, tst_test->mntpoint,
+		                        tdev.fs_type);
+		return;
+	}
+
 	if (tst_test->mount_device) {
 		SAFE_MOUNT(tdev.dev, tst_test->mntpoint, tdev.fs_type,
 			   tst_test->mnt_flags, tst_test->mnt_data);
@@ -761,18 +793,13 @@ static void do_setup(int argc, char *argv[])
 
 	if (tst_test->needs_rofs) {
 		/* If we failed to mount read-only tmpfs. Fallback to
-		 * using a device with empty read-only filesystem.
+		 * using a device with read-only filesystem.
 		 */
-		if (mount(NULL, tst_test->mntpoint, "tmpfs", MS_RDONLY, NULL)) {
-			tst_res(TINFO | TERRNO, "Can't mount tmpfs read-only"
-				" at %s, setting up a device instead\n",
-				tst_test->mntpoint);
-			tst_test->mount_device = 1;
+		if (prepare_and_mount_ro_fs(NULL, tst_test->mntpoint, "tmpfs")) {
+			tst_res(TINFO, "Can't mount tmpfs read-only, "
+			        "falling back to block device...");
 			tst_test->needs_device = 1;
 			tst_test->format_device = 1;
-			tst_test->mnt_flags = MS_RDONLY;
-		} else {
-			mntpoint_mounted = 1;
 		}
 	}
 
-- 
2.13.6

