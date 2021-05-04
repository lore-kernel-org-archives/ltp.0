From: Martin Doucha <mdoucha@suse.cz>
Date: Tue,  4 May 2021 17:48:30 +0200
Subject: [LTP] [PATCH v2 1/6] Add SAFE_REALLOC() helper function to LTP
 library
Message-ID: <20210504154835.24881-1-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
---

Changes since v1: None

 include/tst_safe_macros.h |  5 +++++
 lib/tst_safe_macros.c     | 15 +++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index b9d9baa1a..d6f32ef4c 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -67,6 +67,11 @@ int safe_dup2(const char *file, const int lineno, int oldfd, int newfd);
 #define SAFE_MALLOC(size) \
 	safe_malloc(__FILE__, __LINE__, NULL, (size))
 
+void *safe_realloc(const char *file, const int lineno, void *ptr, size_t size);
+
+#define SAFE_REALLOC(ptr, size) \
+	safe_realloc(__FILE__, __LINE__, (ptr), (size))
+
 #define SAFE_MKDIR(pathname, mode) \
 	safe_mkdir(__FILE__, __LINE__, NULL, (pathname), (mode))
 
diff --git a/lib/tst_safe_macros.c b/lib/tst_safe_macros.c
index 182b690bb..fd5f1704b 100644
--- a/lib/tst_safe_macros.c
+++ b/lib/tst_safe_macros.c
@@ -5,6 +5,7 @@
 
 #define _GNU_SOURCE
 #include <unistd.h>
+#include <stdlib.h>
 #include <errno.h>
 #include <sched.h>
 #include <sys/ptrace.h>
@@ -433,6 +434,20 @@ int safe_dup2(const char *file, const int lineno, int oldfd, int newfd)
 	return rval;
 }
 
+void *safe_realloc(const char *file, const int lineno, void *ptr, size_t size)
+{
+	void *ret;
+
+	ret = realloc(ptr, size);
+
+	if (!ret) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"realloc(%p, %zu) failed", ptr, size);
+	}
+
+	return ret;
+}
+
 sighandler_t safe_signal(const char *file, const int lineno,
 	int signum, sighandler_t handler)
 {
-- 
2.31.1

