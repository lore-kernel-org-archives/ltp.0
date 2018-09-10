From: Clemens Famulla-Conrad <cfamullaconrad@suse.de>
Date: Mon, 10 Sep 2018 16:18:58 +0200
Subject: [LTP] [PATCH v2 2/5] tst_safe_macros: add SAFE_GETGRGID()
In-Reply-To: <20180910141901.20541-1-cfamullaconrad@suse.de>
References: <20180910141901.20541-1-cfamullaconrad@suse.de>
Message-ID: <20180910141901.20541-2-cfamullaconrad@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add tst safe wrapper for getgrgid() function.

Signed-off-by: Clemens Famulla-Conrad <cfamullaconrad@suse.de>
---
 include/tst_safe_macros.h |  4 ++++
 lib/tst_safe_macros.c     | 13 +++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index 03657a410..d457ae92a 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -441,6 +441,10 @@ struct group *safe_getgrnam(const char *file, const int lineno,
 #define SAFE_GETGRNAM(name) \
 	safe_getgrnam(__FILE__, __LINE__, (name))
 
+struct group *safe_getgrgid(const char *file, const int lineno, gid_t gid);
+#define SAFE_GETGRGID(gid) \
+	safe_getgrgid(__FILE__, __LINE__, (gid))
+
 int safe_setxattr(const char *file, const int lineno, const char *path,
             const char *name, const void *value, size_t size, int flags);
 #define SAFE_SETXATTR(path, name, value, size, flags) \
diff --git a/lib/tst_safe_macros.c b/lib/tst_safe_macros.c
index 17384f32c..2e041c460 100644
--- a/lib/tst_safe_macros.c
+++ b/lib/tst_safe_macros.c
@@ -153,6 +153,19 @@ struct group *safe_getgrnam(const char *file, const int lineno,
 	return rval;
 }
 
+struct group *safe_getgrgid(const char *file, const int lineno, gid_t gid)
+{
+	struct group *rval;
+
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

