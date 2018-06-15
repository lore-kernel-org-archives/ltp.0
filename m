From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 15 Jun 2018 16:44:36 +0200
Subject: [LTP] [PATCH v2] SAFE_MACROS: Add SAFE_GETGRNAM()
In-Reply-To: <1528975658-10511-1-git-send-email-huangjh.jy@cn.fujitsu.com>
References: <1521184376-3649-1-git-send-email-huangjh.jy@cn.fujitsu.com>
 <1528975658-10511-1-git-send-email-huangjh.jy@cn.fujitsu.com>
Message-ID: <20180615144436.7s6iw53lqcozzu5c@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Jinhui,

> From: Jinhui Huang <huangjh.jy@cn.fujitsu.com>

> Signed-off-by: Jinhui Huang <huangjh.jy@cn.fujitsu.com>
> ---

I accepted your patch, but had to adjusted it for use in new API only.
See following diff, hope you don't mind (removing cleanup parameter and moving
code into new API only functions).

Kind regards,
Petr

diff --git include/safe_macros_fn.h include/safe_macros_fn.h
index 74b3ec192..3df952811 100644
--- include/safe_macros_fn.h
+++ include/safe_macros_fn.h
@@ -42,9 +42,6 @@ char* safe_dirname(const char *file, const int lineno,
 char* safe_getcwd(const char *file, const int lineno,
                   void (*cleanup_fn)(void), char *buf, size_t size);
 
-struct group *safe_getgrnam(const char *file, const int lineno,
-			    void (*cleanup_fn)(void), const char *name);
-
 struct passwd* safe_getpwnam(const char *file, const int lineno,
                              void (*cleanup_fn)(void), const char *name);
 
diff --git include/tst_safe_macros.h include/tst_safe_macros.h
index a8c23934d..75c2a0803 100644
--- include/tst_safe_macros.h
+++ include/tst_safe_macros.h
@@ -30,6 +30,7 @@
 #include <stdarg.h>
 #include <unistd.h>
 #include <dirent.h>
+#include <grp.h>
 
 #include "safe_macros_fn.h"
 
@@ -69,9 +70,6 @@ static inline int safe_dup(const char *file, const int lineno,
 #define SAFE_GETCWD(buf, size) \
 	safe_getcwd(__FILE__, __LINE__, NULL, (buf), (size))
 
-#define SAFE_GETGRNAM(name) \
-	safe_getgrnam(__FILE__, __LINE__, NULL, (name))
-
 #define SAFE_GETPWNAM(name) \
 	safe_getpwnam(__FILE__, __LINE__, NULL, (name))
 
@@ -434,6 +432,11 @@ int safe_getpriority(const char *file, const int lineno, int which, id_t who);
 #define SAFE_GETPRIORITY(which, who) \
 	safe_getpriority(__FILE__, __LINE__, (which), (who))
 
+struct group *safe_getgrnam(const char *file, const int lineno,
+			    const char *name);
+#define SAFE_GETGRNAM(name) \
+	safe_getgrnam(__FILE__, __LINE__, (name))
+
 int safe_setxattr(const char *file, const int lineno, const char *path,
             const char *name, const void *value, size_t size, int flags);
 #define SAFE_SETXATTR(path, name, value, size, flags) \
diff --git lib/safe_macros.c lib/safe_macros.c
index ea9e1f63c..abdeca013 100644
--- lib/safe_macros.c
+++ lib/safe_macros.c
@@ -15,7 +15,6 @@
 #include <stdlib.h>
 #include <unistd.h>
 #include <malloc.h>
-#include <grp.h>
 #include "test.h"
 #include "safe_macros.h"
 
@@ -112,20 +111,6 @@ char *safe_getcwd(const char *file, const int lineno, void (*cleanup_fn) (void),
 	return rval;
 }
 
-struct group *safe_getgrnam(const char *file, const int lineno,
-			    void (*cleanup_fn) (void), const char *name)
-{
-	struct group *rval;
-
-	rval = getgrnam(name);
-	if (rval == NULL) {
-		tst_brkm(TBROK | TERRNO, cleanup_fn,
-			"%s:%d: getgrnam(%s) failed", file, lineno, name);
-	}
-
-	return rval;
-}
-
 struct passwd *safe_getpwnam(const char *file, const int lineno,
 			     void (*cleanup_fn) (void), const char *name)
 {
diff --git lib/tst_safe_macros.c lib/tst_safe_macros.c
index 034f91751..e152bff7f 100644
--- lib/tst_safe_macros.c
+++ lib/tst_safe_macros.c
@@ -138,3 +138,17 @@ int safe_sigaction(const char *file, const int lineno,
 
 	return rval;
 }
+
+struct group *safe_getgrnam(const char *file, const int lineno,
+			    const char *name)
+{
+	struct group *rval;
+
+	rval = getgrnam(name);
+	if (rval == NULL) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"getgrnam(%s) failed", name);
+	}
+
+	return rval;
+}
