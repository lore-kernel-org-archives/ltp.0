From: Clemens Famulla-Conrad <cfamullaconrad@suse.de>
Date: Mon, 10 Sep 2018 11:11:24 +0200
Subject: [LTP] [PATCH v1 4/5] tst_safe_macros: add SAFE_GETGRNAM_FALLBACK()
In-Reply-To: <20180910090933.12080-1-cfamullaconrad@suse.de>
References: <20180910090933.12080-1-cfamullaconrad@suse.de>
Message-ID: <20180910091124.12256-1-cfamullaconrad@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This function retrieves the group by name. If not exists fall back
to the second name given. If the second group dosn't exists, exit
with TBROK.

Signed-off-by: Clemens Famulla-Conrad <cfamullaconrad@suse.de>
---
 include/tst_safe_macros.h |  5 +++++
 lib/tst_safe_macros.c     | 16 ++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index d457ae92a..e8b68ce9d 100644
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
index 2e041c460..614b6b4b5 100644
--- a/lib/tst_safe_macros.c
+++ b/lib/tst_safe_macros.c
@@ -153,6 +153,22 @@ struct group *safe_getgrnam(const char *file, const int lineno,
 	return rval;
 }
 
+struct group *safe_getgrnam_fallback(const char *file, const int lineno,
+			    const char *name, const char *fallback)
+{
+	struct group *rval;
+
+	rval = getgrnam(name);
+	if (rval == NULL) {
+		tst_res_(file, lineno, TINFO,
+			"getgrnam(%s) failed - try fallback %s",
+			name, fallback);
+		rval = safe_getgrnam(file, lineno, name);
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

