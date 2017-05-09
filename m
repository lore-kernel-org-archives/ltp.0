From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Tue, 9 May 2017 18:05:36 +0800
Subject: [LTP] [PATCH 1/2] SAFE_MACROS: Add SAFE_UNAME()
Message-ID: <1494324337-10706-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
---
 include/tst_safe_macros.h |  4 ++++
 lib/safe_macros.c         | 15 +++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index a25a4f0..c6530e0 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -24,6 +24,7 @@
 #include <sys/time.h>
 #include <sys/resource.h>
 #include <sys/stat.h>
+#include <sys/utsname.h>
 #include <fcntl.h>
 #include <libgen.h>
 #include <signal.h>
@@ -430,4 +431,7 @@ int safe_removexattr(const char *file, const int lineno, const char *path,
 int safe_fsync(const char *file, const int lineno, int fd);
 #define SAFE_FSYNC(fd) safe_fsync(__FILE__, __LINE__, (fd))
 
+int safe_uname(const char *file, const int lineno, struct utsname *buf);
+#define SAFE_UNAME(buf) safe_uname(__FILE__, __LINE__, (buf))
+
 #endif /* SAFE_MACROS_H__ */
diff --git a/lib/safe_macros.c b/lib/safe_macros.c
index bffc5a1..aec0195 100644
--- a/lib/safe_macros.c
+++ b/lib/safe_macros.c
@@ -6,6 +6,7 @@
 #include <sys/wait.h>
 #include <sys/mount.h>
 #include <sys/xattr.h>
+#include <sys/utsname.h>
 #include <errno.h>
 #include <fcntl.h>
 #include <libgen.h>
@@ -888,3 +889,17 @@ int safe_fsync(const char *file, const int lineno, int fd)
 
 	return rval;
 }
+
+int safe_uname(const char *file, const int lineno, struct utsname *buf)
+{
+	int rval;
+
+	rval = uname(buf);
+
+	if (rval) {
+		tst_brkm(TBROK | TERRNO, NULL,
+			 "%s:%d: uname(%p) failed", file, lineno, buf);
+	}
+
+	return rval;
+}
-- 
1.8.4.2



