From: Jinhui huang <huangjh.jy@cn.fujitsu.com>
Date: Thu, 14 Jun 2018 19:27:38 +0800
Subject: [LTP] [PATCH v2] SAFE_MACROS: Add SAFE_GETGRNAM()
In-Reply-To: <1521184376-3649-1-git-send-email-huangjh.jy@cn.fujitsu.com>
References: <1521184376-3649-1-git-send-email-huangjh.jy@cn.fujitsu.com>
Message-ID: <1528975658-10511-1-git-send-email-huangjh.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Jinhui Huang <huangjh.jy@cn.fujitsu.com>

Signed-off-by: Jinhui Huang <huangjh.jy@cn.fujitsu.com>
---
 include/safe_macros_fn.h  |  3 +++
 include/tst_safe_macros.h |  3 +++
 lib/safe_macros.c         | 15 +++++++++++++++
 3 files changed, 21 insertions(+)

diff --git a/include/safe_macros_fn.h b/include/safe_macros_fn.h
index 3df9528..74b3ec1 100644
--- a/include/safe_macros_fn.h
+++ b/include/safe_macros_fn.h
@@ -42,6 +42,9 @@ char* safe_dirname(const char *file, const int lineno,
 char* safe_getcwd(const char *file, const int lineno,
                   void (*cleanup_fn)(void), char *buf, size_t size);
 
+struct group *safe_getgrnam(const char *file, const int lineno,
+			    void (*cleanup_fn)(void), const char *name);
+
 struct passwd* safe_getpwnam(const char *file, const int lineno,
                              void (*cleanup_fn)(void), const char *name);
 
diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index 64cdbbf..a8c2393 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -69,6 +69,9 @@ static inline int safe_dup(const char *file, const int lineno,
 #define SAFE_GETCWD(buf, size) \
 	safe_getcwd(__FILE__, __LINE__, NULL, (buf), (size))
 
+#define SAFE_GETGRNAM(name) \
+	safe_getgrnam(__FILE__, __LINE__, NULL, (name))
+
 #define SAFE_GETPWNAM(name) \
 	safe_getpwnam(__FILE__, __LINE__, NULL, (name))
 
diff --git a/lib/safe_macros.c b/lib/safe_macros.c
index abdeca0..ea9e1f6 100644
--- a/lib/safe_macros.c
+++ b/lib/safe_macros.c
@@ -15,6 +15,7 @@
 #include <stdlib.h>
 #include <unistd.h>
 #include <malloc.h>
+#include <grp.h>
 #include "test.h"
 #include "safe_macros.h"
 
@@ -111,6 +112,20 @@ char *safe_getcwd(const char *file, const int lineno, void (*cleanup_fn) (void),
 	return rval;
 }
 
+struct group *safe_getgrnam(const char *file, const int lineno,
+			    void (*cleanup_fn) (void), const char *name)
+{
+	struct group *rval;
+
+	rval = getgrnam(name);
+	if (rval == NULL) {
+		tst_brkm(TBROK | TERRNO, cleanup_fn,
+			"%s:%d: getgrnam(%s) failed", file, lineno, name);
+	}
+
+	return rval;
+}
+
 struct passwd *safe_getpwnam(const char *file, const int lineno,
 			     void (*cleanup_fn) (void), const char *name)
 {
-- 
1.8.3.1



