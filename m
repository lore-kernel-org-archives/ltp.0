From: Clemens Famulla-Conrad <cfamullaconrad@suse.de>
Date: Mon,  8 Oct 2018 09:16:48 +0200
Subject: [LTP] [PATCH v3 2/5] tst_safe_macros: add SAFE_GETGRGID()
Message-ID: <20181008071651.16384-1-cfamullaconrad@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add tst safe wrapper for getgrgid() function.

Zero errno before calling getgrnam() or getgrgid() to get the
correct errno printed in tst_brk_(TERRNO).

Signed-off-by: Clemens Famulla-Conrad <cfamullaconrad@suse.de>
---
 include/tst_safe_macros.h |  4 ++++
 lib/tst_safe_macros.c     | 15 +++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index 413226eaf..0e5a6d304 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -441,6 +441,10 @@ struct group *safe_getgrnam(const char *file, const int lineno,
 #define SAFE_GETGRNAM(name) \
 	safe_getgrnam(__FILE__, __LINE__, (name))
 
+struct group *safe_getgrgid(const char *file, const int lineno, gid_t gid);
+#define SAFE_GETGRGID(gid) \
+	safe_getgrgid(__FILE__, __LINE__, (gid))
+
 ssize_t safe_getxattr(const char *file, const int lineno, const char *path,
 	const char *name, void *value, size_t size);
 #define SAFE_GETXATTR(path, name, value, size) \
diff --git a/lib/tst_safe_macros.c b/lib/tst_safe_macros.c
index 17384f32c..e1d4fd124 100644
--- a/lib/tst_safe_macros.c
+++ b/lib/tst_safe_macros.c
@@ -144,6 +144,7 @@ struct group *safe_getgrnam(const char *file, const int lineno,
 {
 	struct group *rval;
 
+	errno = 0;
 	rval = getgrnam(name);
 	if (rval == NULL) {
 		tst_brk_(file, lineno, TBROK | TERRNO,
@@ -153,6 +154,20 @@ struct group *safe_getgrnam(const char *file, const int lineno,
 	return rval;
 }
 
+struct group *safe_getgrgid(const char *file, const int lineno, gid_t gid)
+{
+	struct group *rval;
+
+	errno = 0;
+	rval = getgrgid(gid);
+	if (rval == NULL) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"getgrgid(%li) failed", (long)gid);
+	}
+
+	return rval;
+}
+
 int safe_chroot(const char *file, const int lineno, const char *path)
 {
 	int rval;
-- 
2.16.4

