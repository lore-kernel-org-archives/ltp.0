From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Sat, 1 Sep 2018 12:07:41 +0800
Subject: [LTP] [PATCH v4 2/2] lib/tst_test.c: Add .needs_devfs flag
In-Reply-To: <20180830144943.GA20702@rei.lan>
References: <20180830144943.GA20702@rei.lan>
Message-ID: <1535774861-27429-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

We add .needs_devfs flag to prepare a suitable directory for creating devices.
1) If tst_test->needs_devfs is set, tst_test->mntpoint must be set as well.
2) If tst_test->needs_devfs is set and the temporary directory is mounted
   with nodev, we try to mount tmpfs without nodev on tst_test->mntpoint.
3) If tst_test->needs_devfs is set and the temporary directory is mounted
   without nodev, we just create devices on unmounted tst_test->mntpoint.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 include/tst_test.h |  1 +
 lib/tst_test.c     | 28 ++++++++++++++++++++++++++--
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/include/tst_test.h b/include/tst_test.h
index f7d109a..4cc6202 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -129,6 +129,7 @@ struct tst_test {
 	int mount_device:1;
 	int needs_rofs:1;
 	int child_needs_reinit:1;
+	int needs_devfs:1;
 	/*
 	 * If set the test function will be executed for all available
 	 * filesystems and the current filesytem type would be set in the
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 2f3d357..36eb8d5 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -724,6 +724,20 @@ static int prepare_and_mount_ro_fs(const char *dev,
 	return 0;
 }
 
+static void prepare_and_mount_dev_fs(const char *mntpoint)
+{
+	const char *flags[] = {"nodev", NULL};
+	int mounted_nodev;
+
+	mounted_nodev = tst_path_has_mnt_flags(NULL, NULL, flags);
+	if (mounted_nodev) {
+		tst_res(TINFO, "tmpdir isn't suitable for creating devices, "
+			"so mount tmpfs without nodev on %s", mntpoint);
+		SAFE_MOUNT(NULL, mntpoint, "tmpfs", 0, NULL);
+		mntpoint_mounted = 1;
+	}
+}
+
 static void prepare_device(void)
 {
 	if (tst_test->format_device) {
@@ -786,11 +800,21 @@ static void do_setup(int argc, char *argv[])
 	if (tst_test->mntpoint)
 		SAFE_MKDIR(tst_test->mntpoint, 0777);
 
-	if ((tst_test->needs_rofs || tst_test->mount_device ||
-	     tst_test->all_filesystems) && !tst_test->mntpoint) {
+	if ((tst_test->needs_devfs || tst_test->needs_rofs ||
+	     tst_test->mount_device || tst_test->all_filesystems) &&
+	     !tst_test->mntpoint) {
 		tst_brk(TBROK, "tst_test->mntpoint must be set!");
 	}
 
+	if (!!tst_test->needs_rofs + !!tst_test->needs_devfs +
+	    !!tst_test->needs_device > 1) {
+		tst_brk(TBROK,
+			"Two or more of needs_{rofs, devfs, device} are set");
+	}
+
+	if (tst_test->needs_devfs)
+		prepare_and_mount_dev_fs(tst_test->mntpoint);
+
 	if (tst_test->needs_rofs) {
 		/* If we failed to mount read-only tmpfs. Fallback to
 		 * using a device with read-only filesystem.
-- 
1.8.3.1



