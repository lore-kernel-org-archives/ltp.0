From: Martin Doucha <mdoucha@suse.cz>
Date: Mon, 26 Oct 2020 17:47:50 +0100
Subject: [LTP] [PATCH 13/19] Move executable code out of tst_safe_macros.h
In-Reply-To: <20201026164756.30556-1-mdoucha@suse.cz>
References: <20201026164756.30556-1-mdoucha@suse.cz>
Message-ID: <20201026164756.30556-14-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 include/tst_safe_macros.h | 44 +++++----------------------------------
 lib/tst_safe_macros.c     | 44 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+), 39 deletions(-)

diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index 42d923370..29ac72568 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -45,19 +45,8 @@ int safe_chroot(const char *file, const int lineno, const char *path);
 #define SAFE_DIRNAME(path) \
 	safe_dirname(__FILE__, __LINE__, NULL, (path))
 
-static inline int safe_dup(const char *file, const int lineno,
-			   int oldfd)
-{
-	int rval;
-
-	rval = dup(oldfd);
-	if (rval == -1) {
-		tst_brk_(file, lineno, TBROK | TERRNO,
-			 "dup(%i) failed", oldfd);
-	}
+int safe_dup(const char *file, const int lineno, int oldfd);
 
-	return rval;
-}
 #define SAFE_DUP(oldfd) \
 	safe_dup(__FILE__, __LINE__, (oldfd))
 
@@ -407,21 +396,8 @@ static inline int safe_setrlimit(const char *file, const int lineno,
 	safe_setrlimit(__FILE__, __LINE__, (resource), (rlim))
 
 typedef void (*sighandler_t)(int);
-static inline sighandler_t safe_signal(const char *file, const int lineno,
-				       int signum, sighandler_t handler)
-{
-	sighandler_t rval;
-
-	rval = signal(signum, handler);
-
-	if (rval == SIG_ERR) {
-		tst_brk_(file, lineno, TBROK | TERRNO,
-			"signal(%d,%p) failed",
-			signum, handler);
-	}
-
-	return rval;
-}
+sighandler_t safe_signal(const char *file, const int lineno,
+	int signum, sighandler_t handler);
 
 #define SAFE_SIGNAL(signum, handler) \
 	safe_signal(__FILE__, __LINE__, (signum), (handler))
@@ -569,19 +545,9 @@ int safe_unshare(const char *file, const int lineno, int flags);
 int safe_setns(const char *file, const int lineno, int fd, int nstype);
 #define SAFE_SETNS(fd, nstype) safe_setns(__FILE__, __LINE__, (fd), (nstype))
 
-static inline void safe_cmd(const char *file, const int lineno, const char *const argv[],
-				  const char *stdout_path, const char *stderr_path)
-{
-	int rval;
+void safe_cmd(const char *file, const int lineno, const char *const argv[],
+	const char *stdout_path, const char *stderr_path);
 
-	switch ((rval = tst_cmd(argv, stdout_path, stderr_path,
-				TST_CMD_PASS_RETVAL | TST_CMD_TCONF_ON_MISSING))) {
-	case 0:
-		break;
-	default:
-		tst_brk(TBROK, "%s:%d: %s failed (%d)", file, lineno, argv[0], rval);
-	}
-}
 #define SAFE_CMD(argv, stdout_path, stderr_path) \
 	safe_cmd(__FILE__, __LINE__, (argv), (stdout_path), (stderr_path))
 /*
diff --git a/lib/tst_safe_macros.c b/lib/tst_safe_macros.c
index dd7f604eb..5c51e0872 100644
--- a/lib/tst_safe_macros.c
+++ b/lib/tst_safe_macros.c
@@ -397,3 +397,47 @@ int safe_pipe2(const char *file, const int lineno, int fildes[2], int flags)
 
 	return ret;
 }
+
+int safe_dup(const char *file, const int lineno, int oldfd)
+{
+	int rval;
+
+	rval = dup(oldfd);
+	if (rval == -1) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			 "dup(%i) failed", oldfd);
+	}
+
+	return rval;
+}
+
+sighandler_t safe_signal(const char *file, const int lineno,
+	int signum, sighandler_t handler)
+{
+	sighandler_t rval;
+
+	rval = signal(signum, handler);
+
+	if (rval == SIG_ERR) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"signal(%d,%p) failed",
+			signum, handler);
+	}
+
+	return rval;
+}
+
+void safe_cmd(const char *file, const int lineno, const char *const argv[],
+	const char *stdout_path, const char *stderr_path)
+{
+	int rval;
+
+	switch ((rval = tst_cmd(argv, stdout_path, stderr_path,
+		TST_CMD_PASS_RETVAL | TST_CMD_TCONF_ON_MISSING))) {
+	case 0:
+		break;
+	default:
+		tst_brk(TBROK, "%s:%d: %s failed (%d)", file, lineno, argv[0],
+			rval);
+	}
+}
-- 
2.28.0

