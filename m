From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 20 Mar 2020 14:49:36 +0100
Subject: [LTP] [PATCH 1/2] lib: Implement SAFE_RUN() macro (new API only)
Message-ID: <20200320134937.16616-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 doc/test-writing-guidelines.txt |  3 +++
 include/tst_safe_macros.h       | 20 ++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index b56f1a0f2..b8330801b 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -1282,6 +1282,9 @@ return value is '255' if 'execvp()' failed with 'ENOENT' and '254' otherwise.
 'stdout_path' and 'stderr_path' determine where to redirect the program
 stdout and stderr I/O streams.
 
+The 'SAFE_RUNCMD()' macro can be used automatic handling non zero exits (exits
+with 'TBROK') or 'ENOENT' (exits with 'TCONF').
+
 .Example
 [source,c]
 -------------------------------------------------------------------------------
diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index 80c4d9cb9..d701a003f 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -547,4 +547,24 @@ int safe_personality(const char *filename, unsigned int lineno,
 void safe_unshare(const char *file, const int lineno, int flags);
 #define SAFE_UNSHARE(flags) safe_unshare(__FILE__, __LINE__, (flags))
 
+static inline void safe_run_cmd(const char *file, const int lineno,
+							   const char *const argv[],
+			      const char *stdout_path,
+			      const char *stderr_path)
+{
+	int rval;
+
+	switch ((rval = tst_run_cmd(argv, stdout_path, stderr_path, 1))) {
+	case 0:
+		break;
+	case 255:
+		tst_brk(TCONF, "%s:%d: %s not found in $PATH", file, lineno, argv[0]);
+		break;
+	default:
+		tst_brk(TBROK, "%s:%d: %s failed (%d)", file, lineno, rc);
+	}
+}
+#define SAFE_RUNCMD(argv, stdout_path, stderr_path) \
+	safe_run_cmd(__FILE__, __LINE__, NULL, (argv), (stdout_path), (stderr_path))
+
 #endif /* SAFE_MACROS_H__ */
-- 
2.25.1

