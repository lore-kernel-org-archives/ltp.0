From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 30 Mar 2020 14:43:37 +0200
Subject: [LTP] [PATCH v2 4/5] lib: Implement SAFE_CMD() macro (new API only)
In-Reply-To: <20200330124338.6764-1-pvorel@suse.cz>
References: <20200330124338.6764-1-pvorel@suse.cz>
Message-ID: <20200330124338.6764-5-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Reviewed-by: Li Wang <liwang@redhat.com>
Reviewed-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 doc/test-writing-guidelines.txt |  3 +++
 include/tst_safe_macros.h       | 18 ++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index 7069d3c8f..6f1eee490 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -1283,6 +1283,9 @@ return value is '255' if 'execvp()' failed with 'ENOENT' and '254' otherwise.
 'stdout_path' and 'stderr_path' determine where to redirect the program
 stdout and stderr I/O streams.
 
+The 'SAFE_CMD()' macro can be used automatic handling non zero exits (exits
+with 'TBROK') or 'ENOENT' (exits with 'TCONF').
+
 .Example
 [source,c]
 -------------------------------------------------------------------------------
diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index d95d26219..38eb67d1d 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -21,6 +21,7 @@
 #include <grp.h>
 
 #include "safe_macros_fn.h"
+#include "tst_cmd.h"
 
 #define SAFE_BASENAME(path) \
 	safe_basename(__FILE__, __LINE__, NULL, (path))
@@ -534,4 +535,21 @@ int safe_personality(const char *filename, unsigned int lineno,
 void safe_unshare(const char *file, const int lineno, int flags);
 #define SAFE_UNSHARE(flags) safe_unshare(__FILE__, __LINE__, (flags))
 
+void safe_cmd(const char *file, const int lineno, const char *const argv[],
+				  const char *stdout_path, const char *stderr_path)
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
+#define SAFE_CMD(argv, stdout_path, stderr_path) \
+	safe_cmd(__FILE__, __LINE__, (argv), (stdout_path), (stderr_path))
+
 #endif /* SAFE_MACROS_H__ */
-- 
2.26.0

