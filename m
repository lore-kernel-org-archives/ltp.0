From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu,  6 Aug 2020 11:19:39 +0200
Subject: [LTP] [PATCH] [COMMITTED] safe_macros: Add SAFE_SIGPROCMASK() and
 SAFE_SIGWAIT()
Message-ID: <20200806091939.9394-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/tst_safe_macros.h | 10 ++++++++++
 lib/tst_safe_macros.c     | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index 79f11b5c6..45fd0500a 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -446,6 +446,16 @@ void safe_sigemptyset(const char *file, const int lineno,
 #define SAFE_SIGEMPTYSET(sigs) \
 	safe_sigemptyset(__FILE__, __LINE__, (sigs))
 
+void safe_sigprocmask(const char *file, const int lineno,
+                      int how, sigset_t *set, sigset_t *oldset);
+#define SAFE_SIGPROCMASK(how, set, oldset) \
+	safe_sigprocmask(__FILE__, __LINE__, (how), (set), (oldset))
+
+void safe_sigwait(const char *file, const int lineno,
+                  sigset_t *set, int *sig);
+#define SAFE_SIGWAIT(set, sig) \
+	safe_sigwait(__FILE__, __LINE__, (set), (sig))
+
 #define SAFE_EXECLP(file, arg, ...) do {                   \
 	execlp((file), (arg), ##__VA_ARGS__);              \
 	tst_brk_(__FILE__, __LINE__, TBROK | TERRNO,       \
diff --git a/lib/tst_safe_macros.c b/lib/tst_safe_macros.c
index 3b44eeafa..f18cb4625 100644
--- a/lib/tst_safe_macros.c
+++ b/lib/tst_safe_macros.c
@@ -166,6 +166,44 @@ void safe_sigemptyset(const char *file, const int lineno,
 		tst_brk_(file, lineno, TBROK | TERRNO, "sigemptyset() failed");
 }
 
+static const char *strhow(int how)
+{
+	switch (how) {
+	case SIG_BLOCK:
+		return "SIG_BLOCK";
+	case SIG_UNBLOCK:
+		return "SIG_UNBLOCK";
+	case SIG_SETMASK:
+		return "SIG_SETMASK";
+	default:
+		return "???";
+	}
+}
+
+void safe_sigprocmask(const char *file, const int lineno,
+                      int how, sigset_t *set, sigset_t *oldset)
+{
+	int rval;
+
+	rval = sigprocmask(how, set, oldset);
+	if (rval == -1) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+		         "sigprocmask(%s, %p, %p)", strhow(how), set, oldset);
+	}
+}
+
+void safe_sigwait(const char *file, const int lineno,
+                  sigset_t *set, int *sig)
+{
+	int rval;
+
+	rval = sigwait(set, sig);
+	if (rval != 0) {
+		errno = rval;
+		tst_brk_(file, lineno, TBROK, "sigwait(%p, %p)", set, sig);
+	}
+}
+
 struct group *safe_getgrnam(const char *file, const int lineno,
 			    const char *name)
 {
-- 
2.26.2

