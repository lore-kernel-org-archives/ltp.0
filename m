From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 16 Aug 2018 16:45:45 +0800
Subject: [LTP] [PATCH v2 2/4] lib/tst_test.c: add .needs_devfs flag
In-Reply-To: <1534409147-29519-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <20180815114220.GA26923@rei>
 <1534409147-29519-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <1534409147-29519-2-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

We add .needs_devfs flag to prepare a suitable filesystem to test
device special files and use ext2 instead of tmpfs(because tmpfs
doesn't support extended attributes) as default filesystem if
.dev_fs_type is not specified.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 include/tst_test.h |  1 +
 lib/tst_test.c     | 32 ++++++++++++++++++++++++++++++--
 2 files changed, 31 insertions(+), 2 deletions(-)

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
index 2f3d357..039c78f 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -724,6 +724,22 @@ static int prepare_and_mount_ro_fs(const char *dev,
 	return 0;
 }
 
+static void prepare_and_mount_dev_fs(const char *dev,
+				     const char *mntpoint,
+				     const char *fs_type)
+{
+	const char *flags[] = {"nodev", NULL};
+	char abs_path[PATH_MAX];
+
+	sprintf(abs_path, "%s/%s", tst_get_tmpdir(), mntpoint);
+
+	SAFE_MOUNT(dev, mntpoint, fs_type, MS_MGC_VAL, NULL);
+	mntpoint_mounted = 1;
+
+	if (tst_path_has_mnt_flags(NULL, abs_path, flags))
+		tst_brk(TBROK, "%s is mounted with nodev", fs_type);
+}
+
 static void prepare_device(void)
 {
 	if (tst_test->format_device) {
@@ -737,6 +753,12 @@ static void prepare_device(void)
 		return;
 	}
 
+	if (tst_test->needs_devfs) {
+		prepare_and_mount_dev_fs(tdev.dev, tst_test->mntpoint,
+					 tdev.fs_type);
+		return;
+	}
+
 	if (tst_test->mount_device) {
 		SAFE_MOUNT(tdev.dev, tst_test->mntpoint, tdev.fs_type,
 			   tst_test->mnt_flags, tst_test->mnt_data);
@@ -778,6 +800,11 @@ static void do_setup(int argc, char *argv[])
 	if (tst_test->all_filesystems)
 		tst_test->needs_device = 1;
 
+	if (tst_test->needs_devfs) {
+		tst_test->needs_device = 1;
+		tst_test->format_device = 1;
+	}
+
 	setup_ipc();
 
 	if (needs_tmpdir() && !tst_tmpdir_created())
@@ -786,8 +813,9 @@ static void do_setup(int argc, char *argv[])
 	if (tst_test->mntpoint)
 		SAFE_MKDIR(tst_test->mntpoint, 0777);
 
-	if ((tst_test->needs_rofs || tst_test->mount_device ||
-	     tst_test->all_filesystems) && !tst_test->mntpoint) {
+	if ((tst_test->needs_devfs || tst_test->needs_rofs ||
+	     tst_test->mount_device || tst_test->all_filesystems) &&
+	     !tst_test->mntpoint) {
 		tst_brk(TBROK, "tst_test->mntpoint must be set!");
 	}
 
-- 
1.8.3.1



