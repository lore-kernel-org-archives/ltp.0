From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 27 Mar 2020 22:39:23 +0100
Subject: [LTP] [PATCH 5/6] lib: Implement SAFE_RUN_CMD() macro (new API only)
In-Reply-To: <20200327213924.18816-1-pvorel@suse.cz>
References: <20200327213924.18816-1-pvorel@suse.cz>
Message-ID: <20200327213924.18816-6-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Reviewed-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Reviewed-by: Li Wang <liwang@redhat.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Renamed: s/SAFE_RUNCMD()/SAFE_RUN_CMD()/

 doc/test-writing-guidelines.txt |  3 +++
 include/tst_safe_macros.h       | 20 ++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index 51eba6e39..4b195a002 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -1283,6 +1283,9 @@ return value is '255' if 'execvp()' failed with 'ENOENT' and '254' otherwise.
 'stdout_path' and 'stderr_path' determine where to redirect the program
 stdout and stderr I/O streams.
 
+The 'SAFE_RUN_CMD()' macro can be used automatic handling non zero exits (exits
+with 'TBROK') or 'ENOENT' (exits with 'TCONF').
+
 .Example
 [source,c]
 -------------------------------------------------------------------------------
diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index d95d26219..af45bc51d 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -21,6 +21,7 @@
 #include <grp.h>
 
 #include "safe_macros_fn.h"
+#include "tst_cmd.h"
 
 #define SAFE_BASENAME(path) \
 	safe_basename(__FILE__, __LINE__, NULL, (path))
@@ -534,4 +535,23 @@ int safe_personality(const char *filename, unsigned int lineno,
 void safe_unshare(const char *file, const int lineno, int flags);
 #define SAFE_UNSHARE(flags) safe_unshare(__FILE__, __LINE__, (flags))
 
+static inline void safe_run_cmd(const char *file, const int lineno,
+							   const char *const argv[],
+			      const char *stdout_path,
+			      const char *stderr_path)
+{
+	int rval;
+
+	switch ((rval = tst_run_cmd(argv, stdout_path, stderr_path,
+				    TST_RUN_CMD_PASS_EXIT_VAL |
+				    TST_RUN_CMD_CHECK_CMD))) {
+	case 0:
+		break;
+	default:
+		tst_brk(TBROK, "%s:%d: %s failed (%d)", file, lineno, argv[0], rval);
+	}
+}
+#define SAFE_RUN_CMD(argv, stdout_path, stderr_path) \
+	safe_run_cmd(__FILE__, __LINE__, (argv), (stdout_path), (stderr_path))
+
 #endif /* SAFE_MACROS_H__ */
-- 
2.25.1

