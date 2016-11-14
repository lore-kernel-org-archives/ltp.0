From: Dejan Jovicevic <dejan.jovicevic@rt-rk.com>
Date: Mon, 14 Nov 2016 13:13:30 +0100
Subject: [LTP]  [PATCH v4 1/5] safe_macros: add safe_setxattr(),
	safe_lsetxattr() and safe_fsetxattr()
In-Reply-To: <1479125614-24731-1-git-send-email-dejan.jovicevic@rt-rk.com>
References: <1479125614-24731-1-git-send-email-dejan.jovicevic@rt-rk.com>
Message-ID: <1479125614-24731-2-git-send-email-dejan.jovicevic@rt-rk.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Added SAFE_SETXATTR(), SAFE_LSETXATTR() and SAFE_FSETXATTR()
macros to simplify error checking in test preparation. Instead
of calling the system function, checking for their return value
and aborting the test if the operation has failed, just use
corresponding safe macro.

Signed-off-by: Dejan Jovicevic <dejan.jovicevic@rt-rk.com>
---
 include/tst_safe_macros.h | 15 +++++++++++
 lib/safe_macros.c         | 64 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+)

diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index 59cba1a..96bec5c 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -437,4 +437,19 @@ int safe_getpriority(const char *file, const int lineno, int which, id_t who);
 #define SAFE_GETPRIORITY(which, who) \
 	safe_getpriority(__FILE__, __LINE__, (which), (who))
 
+int safe_setxattr(const char *file, const int lineno, const char *path,
+            const char *name, const void *value, size_t size, int flags);
+#define SAFE_SETXATTR(path, name, value, size, flags) \
+	safe_setxattr(__FILE__, __LINE__, (path), (name), (value), (size), (flags))
+
+int safe_lsetxattr(const char *file, const int lineno, const char *path,
+            const char *name, const void *value, size_t size, int flags);
+#define SAFE_LSETXATTR(path, name, value, size, flags) \
+	safe_lsetxattr(__FILE__, __LINE__, (path), (name), (value), (size), (flags))
+
+int safe_fsetxattr(const char *file, const int lineno, int fd, const char *name,
+            const void *value, size_t size, int flags);
+#define SAFE_FSETXATTR(fd, name, value, size, flags) \
+	safe_fsetxattr(__FILE__, __LINE__, (fd), (name), (value), (size), (flags))
+
 #endif /* SAFE_MACROS_H__ */
diff --git a/lib/safe_macros.c b/lib/safe_macros.c
index b97f43d..4f91bc6 100644
--- a/lib/safe_macros.c
+++ b/lib/safe_macros.c
@@ -5,6 +5,7 @@
 #include <sys/stat.h>
 #include <sys/wait.h>
 #include <sys/mount.h>
+#include <sys/xattr.h>
 #include <errno.h>
 #include <fcntl.h>
 #include <libgen.h>
@@ -810,3 +811,66 @@ int safe_getpriority(const char *file, const int lineno, int which, id_t who)
 	errno = err;
 	return rval;
 }
+
+int safe_setxattr(const char *file, const int lineno, const char *path,
+				  const char *name, const void *value, size_t size, int flags)
+{
+	int rval;
+
+	rval = setxattr(path, name, value, size, flags);
+
+	if (rval) {
+		if (errno == ENOTSUP) {
+			tst_brkm(TCONF, NULL,
+				 "%s:%d: no xattr support in fs or mounted "
+				 "without user_xattr option", file, lineno);
+		}
+
+		tst_brkm(TBROK | TERRNO, NULL, "%s:%d: setxattr() failed",
+			     file, lineno);
+	}
+
+	return rval;
+}
+
+int safe_lsetxattr(const char *file, const int lineno, const char *path,
+				   const char *name, const void *value, size_t size, int flags)
+{
+	int rval;
+
+	rval = lsetxattr(path, name, value, size, flags);
+
+	if (rval) {
+		if (errno == ENOTSUP) {
+			tst_brkm(TCONF, NULL,
+				 "%s:%d: no xattr support in fs or mounted "
+				 "without user_xattr option", file, lineno);
+		}
+
+		tst_brkm(TBROK | TERRNO, NULL, "%s:%d: lsetxattr() failed",
+			     file, lineno);
+	}
+
+	return rval;
+}
+
+int safe_fsetxattr(const char *file, const int lineno, int fd, const char *name,
+				   const void *value, size_t size, int flags)
+{
+	int rval;
+
+	rval = fsetxattr(fd, name, value, size, flags);
+
+	if (rval) {
+		if (errno == ENOTSUP) {
+			tst_brkm(TCONF, NULL,
+				 "%s:%d: no xattr support in fs or mounted "
+				 "without user_xattr option", file, lineno);
+		}
+
+		tst_brkm(TBROK | TERRNO, NULL, "%s:%d: fsetxattr() failed",
+			     file, lineno);
+	}
+
+	return rval;
+}
-- 
1.9.1

