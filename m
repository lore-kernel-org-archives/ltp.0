From: Murphy Zhou <xzhou@redhat.com>
Date: Wed, 15 May 2019 17:21:28 +0800
Subject: [LTP] [PATCH v2 1/2] OVL_MNT: add setup_overlay helper
In-Reply-To: <20190503210005.GA18171@x230>
References: <20190503210005.GA18171@x230>
Message-ID: <20190515092129.26336-1-xzhou@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

To create overlayfs dirs, and mount overlayfs if needed.

Signed-off-by: Murphy Zhou <xzhou@redhat.com>
---
v2:
  define constraints in header file
  add a setup helper to create dirs and mount

 include/tst_fs.h   | 12 ++++++++++++
 lib/tst_fs_setup.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)
 create mode 100644 lib/tst_fs_setup.c

diff --git a/include/tst_fs.h b/include/tst_fs.h
index 423ca82ec..750bb1a91 100644
--- a/include/tst_fs.h
+++ b/include/tst_fs.h
@@ -50,6 +50,18 @@ enum {
 	TST_GB = 1073741824,
 };
 
+#define OVL_BASE_MNTPOINT        "mntpoint"
+#define OVL_LOWER	OVL_BASE_MNTPOINT"/lower"
+#define OVL_UPPER	OVL_BASE_MNTPOINT"/upper"
+#define OVL_WORK	OVL_BASE_MNTPOINT"/work"
+#define OVL_MNT		OVL_BASE_MNTPOINT"/ovl"
+
+/*
+ * Create above overlayfs constraints, if mount == 1,
+ * mount overlayfs
+ */
+int setup_overlay(int mount);
+
 /*
  * @path: path is the pathname of any file within the mounted file system
  * @mult: mult should be TST_KB, TST_MB or TST_GB
diff --git a/lib/tst_fs_setup.c b/lib/tst_fs_setup.c
new file mode 100644
index 000000000..b1880ee11
--- /dev/null
+++ b/lib/tst_fs_setup.c
@@ -0,0 +1,42 @@
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
+int setup_overlay(int mountovl)
+{
+	int ret;
+
+	/* Setup an overlay mount with lower dir and file */
+	SAFE_MKDIR(OVL_LOWER, 0755);
+	SAFE_MKDIR(OVL_UPPER, 0755);
+	SAFE_MKDIR(OVL_WORK, 0755);
+	SAFE_MKDIR(OVL_MNT, 0755);
+
+	/* Only create dirs, do not mount */
+	if (mountovl == 0)
+		return 0;
+
+	ret = mount("overlay", OVL_MNT, "overlay", 0, "lowerdir="OVL_LOWER
+		    ",upperdir="OVL_UPPER",workdir="OVL_WORK);
+	if (ret < 0) {
+		if (errno == ENODEV) {
+			tst_res(TINFO,
+				"overlayfs is not configured in this kernel.");
+			return 1;
+		}
+		tst_brk(TBROK | TERRNO, "overlayfs mount failed");
+	}
+	return 0;
+}
-- 
2.21.0

