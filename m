From: Clemens Famulla-Conrad <cfamullaconrad@suse.de>
Date: Mon,  8 Oct 2018 09:16:50 +0200
Subject: [LTP] [PATCH v3 4/5] tst_safe_macros: add SAFE_GETGRNAM_FALLBACK()
In-Reply-To: <20181008071651.16384-1-cfamullaconrad@suse.de>
References: <20181008071651.16384-1-cfamullaconrad@suse.de>
Message-ID: <20181008071651.16384-3-cfamullaconrad@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This function retrieves the group by name. If the group doesn't
exists fall back to the second name given. If the second group
doesn't exists, exit with TBROK.

Signed-off-by: Clemens Famulla-Conrad <cfamullaconrad@suse.de>
---
 include/tst_safe_macros.h |  5 +++++
 lib/tst_safe_macros.c     | 16 ++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index 0e5a6d304..d31762f4a 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -441,6 +441,11 @@ struct group *safe_getgrnam(const char *file, const int lineno,
 #define SAFE_GETGRNAM(name) \
 	safe_getgrnam(__FILE__, __LINE__, (name))
 
+struct group *safe_getgrnam_fallback(const char *file, const int lineno,
+		const char *name, const char *fallback);
+#define SAFE_GETGRNAM_FALLBACK(name, fallback) \
+	safe_getgrnam_fallback(__FILE__, __LINE__, (name), (fallback))
+
 struct group *safe_getgrgid(const char *file, const int lineno, gid_t gid);
 #define SAFE_GETGRGID(gid) \
 	safe_getgrgid(__FILE__, __LINE__, (gid))
diff --git a/lib/tst_safe_macros.c b/lib/tst_safe_macros.c
index e1d4fd124..34f468492 100644
--- a/lib/tst_safe_macros.c
+++ b/lib/tst_safe_macros.c
@@ -154,6 +154,22 @@ struct group *safe_getgrnam(const char *file, const int lineno,
 	return rval;
 }
 
+struct group *safe_getgrnam_fallback(const char *file, const int lineno,
+				     const char *name, const char *fallback)
+{
+	struct group *rval;
+
+	rval = getgrnam(name);
+	if (rval == NULL) {
+		tst_res_(file, lineno, TINFO,
+			 "getgrnam(%s) failed - try fallback %s",
+			 name, fallback);
+		rval = safe_getgrnam(file, lineno, fallback);
+	}
+
+	return rval;
+}
+
 struct group *safe_getgrgid(const char *file, const int lineno, gid_t gid)
 {
 	struct group *rval;
-- 
2.16.4

