From: Martin Doucha <mdoucha@suse.cz>
Date: Mon, 15 Mar 2021 16:41:52 +0100
Subject: [LTP] [PATCH v2 2/3] Add FS quota availability check functions
In-Reply-To: <20210315154153.912-1-mdoucha@suse.cz>
References: <20210315154153.912-1-mdoucha@suse.cz>
Message-ID: <20210315154153.912-2-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

Changes since v1:
- Change quotafile argument from const char* to char*

 include/tst_fs.h             | 15 +++++++++++++++
 lib/tst_supported_fs_types.c | 31 +++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/include/tst_fs.h b/include/tst_fs.h
index 4f7dd68d2..cc5cc2c0c 100644
--- a/include/tst_fs.h
+++ b/include/tst_fs.h
@@ -180,6 +180,21 @@ int tst_fs_is_supported(const char *fs_type, int flags);
  */
 const char **tst_get_supported_fs_types(int flags);
 
+/*
+ * Check whether device supports FS quotas. Negative return value means that
+ * quotas appear to be broken.
+ */
+int tst_check_quota_support(const char *device, int format, char *quotafile);
+
+/*
+ * Check for quota support and terminate the test with appropriate exit status
+ * if quotas are not supported or broken.
+ */
+#define tst_require_quota_support(dev, fmt, qfile) \
+	tst_require_quota_support_(__FILE__, __LINE__, (dev), (fmt), (qfile))
+void tst_require_quota_support_(const char *file, const int lineno,
+	const char *device, int format, char *quotafile);
+
 /*
  * Creates and writes to files on given path until write fails with ENOSPC
  */
diff --git a/lib/tst_supported_fs_types.c b/lib/tst_supported_fs_types.c
index 00ede549d..fa9bc56ad 100644
--- a/lib/tst_supported_fs_types.c
+++ b/lib/tst_supported_fs_types.c
@@ -8,6 +8,7 @@
 #include <stdlib.h>
 #include <sys/mount.h>
 #include <sys/wait.h>
+#include <sys/quota.h>
 
 #define TST_NO_DEFAULT_MAIN
 #include "tst_test.h"
@@ -109,3 +110,33 @@ const char **tst_get_supported_fs_types(int flags)
 
 	return fs_types;
 }
+
+int tst_check_quota_support(const char *device, int format, char *quotafile)
+{
+	TEST(quotactl(QCMD(Q_QUOTAON, USRQUOTA), device, format, quotafile));
+
+	/* Not supported */
+	if (TST_RET == -1 && TST_ERR == ESRCH)
+		return 0;
+
+	/* Broken */
+	if (TST_RET)
+		return -1;
+
+	quotactl(QCMD(Q_QUOTAOFF, USRQUOTA), device, 0, 0);
+	return 1;
+}
+
+void tst_require_quota_support_(const char *file, const int lineno,
+	const char *device, int format, char *quotafile)
+{
+	int status = tst_check_quota_support(device, format, quotafile);
+
+	if (!status) {
+		tst_brk_(file, lineno, TCONF,
+			"Kernel or device does not support FS quotas");
+	}
+
+	if (status < 0)
+		tst_brk_(file, lineno, TBROK|TTERRNO, "FS quotas are broken");
+}
-- 
2.30.1

