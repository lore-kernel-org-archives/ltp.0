From: Murphy Zhou <xzhou@redhat.com>
Date: Thu, 30 May 2019 10:53:00 +0800
Subject: [LTP] [PATCH v6 1/2] OVL_MNT: add helpers to setup overlayfs
	mountpoint
In-Reply-To: <CAOQ4uxhYVDDh961PCBqikrO=QjPG-yUEUvwWn8hBCkB0ugMuzg@mail.gmail.com>
References: <CAOQ4uxhYVDDh961PCBqikrO=QjPG-yUEUvwWn8hBCkB0ugMuzg@mail.gmail.com>
Message-ID: <20190530025301.9616-1-xzhou@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Define constraints of needed overlayfs dirs;
create_overlay_dirs() to create lower/upper/work dirs;
mount_overlay() to mount overlayfs;
SAFE_MOUNT_OVERLAY macro to mount overlayfs safely, tst_brk TCONF
if mount fail with errno ENODEV;
TST_MOUNT_OVERLAY  macro to mount overlayfs and return 0 if succeeds;

Suggested-by: Petr Vorel <pvorel@suse.cz>
Suggested-by: Amir Goldstein <amir73il@gmail.com>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Murphy Zhou <xzhou@redhat.com>
---
v6:
  Return before close NULL dir in create_overlay_dirs
v5:
  Introduce tst_test->needs_overlay to mount and umount overlay
  Several other fixes suggested by Petr
  Update execveat03, inotify07/8 to use needs_overlay
v4:
  Update ENODEV handle logic
  Define TST_MOUNT_OVERLAY and SAFE_MOUNT_OVERLAY macros
  Change helper names
v3:
  Split setup to 2 parts: creating files and mounting.
  Use macro SAFE_MOUNT_OVERLAYFS.
  Handle ENODEV differently for 4 testcases we have modified.
v2:
  define constraints in header file.
  add a setup helper to create dirs and mount.

 include/safe_file_ops_fn.h  |  4 +++
 include/tst_fs.h            |  6 +++++
 include/tst_safe_file_ops.h |  6 +++++
 include/tst_test.h          |  1 +
 lib/tst_fs_setup.c          | 49 +++++++++++++++++++++++++++++++++++++
 lib/tst_test.c              | 15 ++++++++++++
 6 files changed, 81 insertions(+)
 create mode 100644 lib/tst_fs_setup.c

diff --git a/include/safe_file_ops_fn.h b/include/safe_file_ops_fn.h
index 35ec4fb1f..052fb1b9a 100644
--- a/include/safe_file_ops_fn.h
+++ b/include/safe_file_ops_fn.h
@@ -76,4 +76,8 @@ void safe_touch(const char *file, const int lineno,
 		const char *pathname,
 		mode_t mode, const struct timespec times[2]);
 
+/* helper functions to setup overlayfs mountpoint */
+void create_overlay_dirs(void);
+int mount_overlay(const char *file, const int lineno, int skip);
+
 #endif /* SAFE_FILE_OPS_FN */
diff --git a/include/tst_fs.h b/include/tst_fs.h
index b2b19ada6..ebca065c6 100644
--- a/include/tst_fs.h
+++ b/include/tst_fs.h
@@ -50,6 +50,12 @@ enum {
 	TST_GB = 1073741824,
 };
 
+#define OVL_BASE_MNTPOINT        "mntpoint"
+#define OVL_LOWER	OVL_BASE_MNTPOINT"/lower"
+#define OVL_UPPER	OVL_BASE_MNTPOINT"/upper"
+#define OVL_WORK	OVL_BASE_MNTPOINT"/work"
+#define OVL_MNT		OVL_BASE_MNTPOINT"/ovl"
+
 /*
  * @path: path is the pathname of any file within the mounted file system
  * @mult: mult should be TST_KB, TST_MB or TST_GB
diff --git a/include/tst_safe_file_ops.h b/include/tst_safe_file_ops.h
index 5c3fea4e2..b62a7447f 100644
--- a/include/tst_safe_file_ops.h
+++ b/include/tst_safe_file_ops.h
@@ -59,4 +59,10 @@
 	safe_touch(__FILE__, __LINE__, NULL, \
 			(pathname), (mode), (times))
 
+#define SAFE_MOUNT_OVERLAY() \
+	((void) mount_overlay(__FILE__, __LINE__, 1))
+
+#define TST_MOUNT_OVERLAY() \
+	(mount_overlay(__FILE__, __LINE__, 0) == 0)
+
 #endif /* TST_SAFE_FILE_OPS */
diff --git a/include/tst_test.h b/include/tst_test.h
index e4b935c45..f3b8901a2 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -121,6 +121,7 @@ struct tst_test {
 	int needs_root:1;
 	int forks_child:1;
 	int needs_device:1;
+	int needs_overlay:1;
 	int needs_checkpoints:1;
 	int format_device:1;
 	int mount_device:1;
diff --git a/lib/tst_fs_setup.c b/lib/tst_fs_setup.c
new file mode 100644
index 000000000..32a6218e3
--- /dev/null
+++ b/lib/tst_fs_setup.c
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <dirent.h>
+#include <errno.h>
+#include <sys/mount.h>
+
+#define TST_NO_DEFAULT_MAIN
+#include "tst_test.h"
+#include "tst_fs.h"
+
+#define TST_FS_SETUP_OVERLAYFS_MSG "overlayfs is not configured in this kernel"
+#define TST_FS_SETUP_OVERLAYFS_CONFIG "lowerdir="OVL_LOWER",upperdir="OVL_UPPER",workdir="OVL_WORK
+
+void create_overlay_dirs(void)
+{
+	DIR *dir = opendir(OVL_LOWER);
+	if (dir == NULL) {
+		SAFE_MKDIR(OVL_LOWER, 0755);
+		SAFE_MKDIR(OVL_UPPER, 0755);
+		SAFE_MKDIR(OVL_WORK, 0755);
+		SAFE_MKDIR(OVL_MNT, 0755);
+		return;
+	}
+	closedir(dir);
+}
+
+int mount_overlay(const char *file, const int lineno, int skip)
+{
+	int ret = 0;
+
+	create_overlay_dirs();
+	ret = mount("overlay", OVL_MNT, "overlay", 0,
+				TST_FS_SETUP_OVERLAYFS_CONFIG);
+	if (ret == 0)
+		return 0;
+
+	if (errno == ENODEV) {
+		if (skip) {
+			tst_brk(TCONF, "%s:%d: " TST_FS_SETUP_OVERLAYFS_MSG,
+				file, lineno);
+		} else {
+			tst_res(TINFO, "%s:%d: " TST_FS_SETUP_OVERLAYFS_MSG,
+				file, lineno);
+		}
+	} else {
+		tst_brk(TBROK | TERRNO, "overlayfs mount failed");
+	}
+	return ret;
+}
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 2d88adbd7..95f389d2e 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -50,6 +50,7 @@ static int iterations = 1;
 static float duration = -1;
 static pid_t main_pid, lib_pid;
 static int mntpoint_mounted;
+static int ovl_mounted;
 static struct timespec tst_start_time; /* valid only for test pid */
 
 struct results {
@@ -871,6 +872,17 @@ static void do_setup(int argc, char *argv[])
 			prepare_device();
 	}
 
+	if (tst_test->needs_overlay && !tst_test->mount_device) {
+		tst_brk(TBROK, "tst_test->mount_device must be set");
+	}
+	if (tst_test->needs_overlay && !mntpoint_mounted) {
+		tst_brk(TBROK, "tst_test->mntpoint must be mounted");
+	}
+	if (tst_test->needs_overlay && !ovl_mounted) {
+		SAFE_MOUNT_OVERLAY();
+		ovl_mounted = 1;
+	}
+
 	if (tst_test->resource_files)
 		copy_resources();
 
@@ -891,6 +903,9 @@ static void do_test_setup(void)
 
 static void do_cleanup(void)
 {
+	if (ovl_mounted)
+		SAFE_UMOUNT(OVL_MNT);
+
 	if (mntpoint_mounted)
 		tst_umount(tst_test->mntpoint);
 
-- 
2.21.0

