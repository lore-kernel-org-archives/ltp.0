From: Murphy Zhou <xzhou@redhat.com>
Date: Sat, 25 May 2019 19:51:11 +0800
Subject: [LTP] [PATCH v4 1/2] OVL_MNT: add helpers to setup overlayfs
	mountpoint
In-Reply-To: <20190524122357.GA28108@dell5510>
References: <20190524122357.GA28108@dell5510>
Message-ID: <20190525115112.15399-1-xzhou@redhat.com>
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
Signed-off-by: Murphy Zhou <xzhou@redhat.com>
---
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

 include/safe_file_ops_fn.h  |  4 ++++
 include/tst_fs.h            |  6 +++++
 include/tst_safe_file_ops.h |  6 +++++
 lib/tst_fs_setup.c          | 46 +++++++++++++++++++++++++++++++++++++
 4 files changed, 62 insertions(+)
 create mode 100644 lib/tst_fs_setup.c

diff --git a/include/safe_file_ops_fn.h b/include/safe_file_ops_fn.h
index 35ec4fb1f..526454da7 100644
--- a/include/safe_file_ops_fn.h
+++ b/include/safe_file_ops_fn.h
@@ -76,4 +76,8 @@ void safe_touch(const char *file, const int lineno,
 		const char *pathname,
 		mode_t mode, const struct timespec times[2]);
 
+/* helper functions to setup overlayfs mountpoint */
+void create_overlay_dirs(void);
+int mount_overlay(const char *file, const int lineno, int safe);
+
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
diff --git a/lib/tst_fs_setup.c b/lib/tst_fs_setup.c
new file mode 100644
index 000000000..de09c7135
--- /dev/null
+++ b/lib/tst_fs_setup.c
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
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
+void create_overlay_dirs(void)
+{
+	SAFE_MKDIR(OVL_LOWER, 0755);
+	SAFE_MKDIR(OVL_UPPER, 0755);
+	SAFE_MKDIR(OVL_WORK, 0755);
+	SAFE_MKDIR(OVL_MNT, 0755);
+}
+
+int mount_overlay(const char *file, const int lineno, int safe)
+{
+	int ret = 0;
+	char *cfgmsg = "overlayfs is not configured in this kernel.";
+
+	ret = mount("overlay", OVL_MNT, "overlay", 0, "lowerdir="OVL_LOWER
+		    ",upperdir="OVL_UPPER",workdir="OVL_WORK);
+	if (ret < 0) {
+		if (errno == ENODEV) {
+			if (safe) {
+				tst_brk(TCONF, cfgmsg);
+			} else {
+				tst_res(TINFO, cfgmsg);
+				return 1;
+			}
+		} else {
+			tst_brk(TBROK | TERRNO, "overlayfs mount failed");
+		}
+	}
+	return 0;
+}
-- 
2.21.0

