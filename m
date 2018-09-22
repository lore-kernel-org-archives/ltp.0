From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Sat, 22 Sep 2018 17:30:43 +0800
Subject: [LTP] [PATCH 1/2] safe_macros: Add SAFE_GETXATTR() macro
Message-ID: <1537608644-14994-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 include/tst_safe_macros.h |  5 +++++
 lib/safe_macros.c         | 21 +++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index 03657a4..413226e 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -441,6 +441,11 @@ struct group *safe_getgrnam(const char *file, const int lineno,
 #define SAFE_GETGRNAM(name) \
 	safe_getgrnam(__FILE__, __LINE__, (name))
 
+ssize_t safe_getxattr(const char *file, const int lineno, const char *path,
+	const char *name, void *value, size_t size);
+#define SAFE_GETXATTR(path, name, value, size) \
+	safe_getxattr(__FILE__, __LINE__, (path), (name), (value), (size))
+
 int safe_setxattr(const char *file, const int lineno, const char *path,
             const char *name, const void *value, size_t size, int flags);
 #define SAFE_SETXATTR(path, name, value, size, flags) \
diff --git a/lib/safe_macros.c b/lib/safe_macros.c
index 5cc80d0..9588ef5 100644
--- a/lib/safe_macros.c
+++ b/lib/safe_macros.c
@@ -840,6 +840,27 @@ int safe_getpriority(const char *file, const int lineno, int which, id_t who)
 	return rval;
 }
 
+ssize_t safe_getxattr(const char *file, const int lineno, const char *path,
+		      const char *name, void *value, size_t size)
+{
+	ssize_t rval;
+
+	rval = getxattr(path, name, value, size);
+
+	if (rval == -1) {
+		if (errno == ENOTSUP) {
+			tst_brkm(TCONF, NULL,
+				 "%s:%d: no xattr support in fs or mounted "
+				 "without user_xattr option", file, lineno);
+		}
+
+		tst_brkm(TBROK | TERRNO, NULL, "%s:%d: getxattr() failed",
+			 file, lineno);
+	}
+
+	return rval;
+}
+
 int safe_setxattr(const char *file, const int lineno, const char *path,
 		  const char *name, const void *value, size_t size, int flags)
 {
-- 
1.8.3.1



