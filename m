From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 12 Jul 2019 16:15:29 +0200
Subject: [LTP] [PATCH 1/2] safe_macros: Add SAFE_STATFS()
In-Reply-To: <20190712141530.22195-1-chrubis@suse.cz>
References: <20190712141530.22195-1-chrubis@suse.cz>
Message-ID: <20190712141530.22195-2-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/tst_safe_macros.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index 53a888c80..80c4d9cb9 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -24,6 +24,7 @@
 #include <sys/time.h>
 #include <sys/resource.h>
 #include <sys/stat.h>
+#include <sys/vfs.h>
 #include <fcntl.h>
 #include <libgen.h>
 #include <signal.h>
@@ -340,6 +341,23 @@ static inline int safe_lstat(const char *file, const int lineno,
 #define SAFE_LSTAT(path, buf) \
 	safe_lstat(__FILE__, __LINE__, (path), (buf))
 
+static inline int safe_statfs(const char *file, const int lineno,
+                              const char *path, struct statfs *buf)
+{
+	int rval;
+
+	rval = statfs(path, buf);
+
+	if (rval == -1) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+		         "statfs(%s,%p) failed", path, buf);
+	}
+
+	return rval;
+}
+#define SAFE_STATFS(path, buf) \
+        safe_statfs(__FILE__, __LINE__, (path), (buf))
+
 static inline off_t safe_lseek(const char *file, const int lineno,
                                int fd, off_t offset, int whence)
 {
-- 
2.21.0

