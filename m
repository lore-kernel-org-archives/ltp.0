From: Murphy Zhou <xzhou@redhat.com>
Date: Fri, 24 May 2019 17:04:40 +0800
Subject: [LTP] [PATCH v3 1/2] OVL_MNT: add helpers to setup overlayfs
	mountpoint
In-Reply-To: <20190524073045.GA29592@dell5510>
References: <20190524073045.GA29592@dell5510>
Message-ID: <20190524090441.21586-1-xzhou@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Also defined constraints of needed overlayfs dirs.
setup_overlayfs_files() to create lower/upper/work dirs.
safe_mount_overlayfs() to mount overlayfs.

Signed-off-by: Murphy Zhou <xzhou@redhat.com>
---
v3:
  Split setup to 2 parts: creating files and mounting.
  Use macro SAFE_MOUNT_OVERLAYFS.
  Handle ENODEV differently for 4 testcases we have modified.
v2:
  define constraints in header file.
  add a setup helper to create dirs and mount.

 include/safe_file_ops_fn.h  |  5 ++++
 include/tst_fs.h            |  6 ++++
 include/tst_safe_file_ops.h |  3 ++
 lib/tst_fs_setup.c          | 56 +++++++++++++++++++++++++++++++++++++
 4 files changed, 70 insertions(+)
 create mode 100644 lib/tst_fs_setup.c

diff --git a/include/safe_file_ops_fn.h b/include/safe_file_ops_fn.h
index 35ec4fb1f..2491fa40c 100644
--- a/include/safe_file_ops_fn.h
+++ b/include/safe_file_ops_fn.h
@@ -76,4 +76,9 @@ void safe_touch(const char *file, const int lineno,
 		const char *pathname,
 		mode_t mode, const struct timespec times[2]);
 
+/* helper functions to setup overlayfs mountpoint */
+void setup_overlayfs_files(void);
+
+int safe_mount_overlayfs(const char *file, const int lineno,
+		void (cleanup_fn)(void), int infoflag);
 #endif /* SAFE_FILE_OPS_FN */
diff --git a/include/tst_fs.h b/include/tst_fs.h
index 423ca82ec..ce110b723 100644
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
index 5c3fea4e2..d211b40ff 100644
--- a/include/tst_safe_file_ops.h
+++ b/include/tst_safe_file_ops.h
@@ -59,4 +59,7 @@
 	safe_touch(__FILE__, __LINE__, NULL, \
 			(pathname), (mode), (times))
 
+#define SAFE_MOUNT_OVERLAYFS(flag) \
+	safe_mount_overlayfs(__FILE__, __LINE__, NULL, (flag))
+
 #endif /* TST_SAFE_FILE_OPS */
diff --git a/lib/tst_fs_setup.c b/lib/tst_fs_setup.c
new file mode 100644
index 000000000..0f28beb61
--- /dev/null
+++ b/lib/tst_fs_setup.c
@@ -0,0 +1,56 @@
+/*
+ * DESCRIPTION
+ *	A place for setup filesystem helpers.
+ */
+
+#include <stdint.h>
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/vfs.h>
+#include <sys/mount.h>
+
+#define TST_NO_DEFAULT_MAIN
+#include "tst_test.h"
+#include "tst_fs.h"
+
+void setup_overlayfs_files(void)
+{
+	SAFE_MKDIR(OVL_LOWER, 0755);
+	SAFE_MKDIR(OVL_UPPER, 0755);
+	SAFE_MKDIR(OVL_WORK, 0755);
+	SAFE_MKDIR(OVL_MNT, 0755);
+}
+
+int safe_mount_overlayfs(const char *file, const int lineno,
+		void (cleanup_fn)(void), int infoflag)
+{
+	int ret = 0;
+	char *cfgmsg = "overlayfs is not configured in this kernel.";
+
+	ret = mount("overlay", OVL_MNT, "overlay", 0, "lowerdir="OVL_LOWER
+		    ",upperdir="OVL_UPPER",workdir="OVL_WORK);
+	if (ret < 0) {
+		if (errno == ENODEV) {
+			/* To keep the original test logic of testcases, use
+			   infoflag to handle ENODEV differently. Like
+			   execveat03 inotify0{7,8} readahead02. */
+			switch (infoflag) {
+			case 1:
+				tst_res(TINFO, cfgmsg);
+				return 1;
+			case 2:
+				tst_brk(TCONF, cfgmsg);
+				break;
+			case 3:
+				tst_brk(TCONF, cfgmsg);
+			default:
+				tst_brk(TBROK | TERRNO, "overlayfs mount failed");
+				break;
+			}
+		} else {
+			tst_brk(TBROK | TERRNO, "overlayfs mount failed");
+		}
+	}
+	return 0;
+}
-- 
2.21.0

