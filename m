From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 24 Jul 2020 11:05:00 +0200
Subject: [LTP] [PATCH] [COMMITTED] safe_macros: Move sig*set() functions to
 C file
Message-ID: <20200724090500.2958-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This fixes the compilation since the tst_strsig() is defined in
tst_test.h after we include tst_safe_macros.h.

Fixes my changes in: 719b8a5df410 (libs: sigwait: Add SAFE_SIG*() macros)

Sorry for the breakage.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/tst_safe_macros.h | 42 ++++++---------------------------------
 lib/tst_safe_macros.c     | 36 +++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 36 deletions(-)

diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index f3f83cddd..79f11b5c6 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -431,48 +431,18 @@ int safe_sigaction(const char *file, const int lineno,
 #define SAFE_SIGACTION(signum, act, oldact) \
 	safe_sigaction(__FILE__, __LINE__, (signum), (act), (oldact))
 
-static inline void safe_sigaddset(const char *file, const int lineno,
-				  sigset_t *sigs, int signo)
-{
-	int rval;
-
-	rval = sigaddset(sigs, signo);
-	if (rval == -1) {
-		tst_brk_(file, lineno, TBROK | TERRNO,
-		         "sigaddset() %s (%i) failed",
-			 tst_strsig(signo), signo);
-	}
-}
-
+void safe_sigaddset(const char *file, const int lineno,
+                    sigset_t *sigs, int signo);
 #define SAFE_SIGADDSET(sigs, signo) \
 	safe_sigaddset(__FILE__, __LINE__, (sigs), (signo))
 
-static inline void safe_sigdelset(const char *file, const int lineno,
-				  sigset_t *sigs, int signo)
-{
-	int rval;
-
-	rval = sigdelset(sigs, signo);
-	if (rval == -1) {
-		tst_brk_(file, lineno, TBROK | TERRNO,
-		         "sigdelset() %s (%i) failed",
-			 tst_strsig(signo), signo);
-	}
-}
-
+void safe_sigdelset(const char *file, const int lineno,
+                    sigset_t *sigs, int signo);
 #define SAFE_SIGDELSET(sigs, signo) \
 	safe_sigdelset(__FILE__, __LINE__, (sigs), (signo))
 
-static inline void safe_sigemptyset(const char *file, const int lineno,
-				    sigset_t *sigs)
-{
-	int rval;
-
-	rval = sigemptyset(sigs);
-	if (rval == -1)
-		tst_brk_(file, lineno, TBROK | TERRNO, "sigemptyset() failed");
-}
-
+void safe_sigemptyset(const char *file, const int lineno,
+                      sigset_t *sigs);
 #define SAFE_SIGEMPTYSET(sigs) \
 	safe_sigemptyset(__FILE__, __LINE__, (sigs))
 
diff --git a/lib/tst_safe_macros.c b/lib/tst_safe_macros.c
index dbdfcc5be..3b44eeafa 100644
--- a/lib/tst_safe_macros.c
+++ b/lib/tst_safe_macros.c
@@ -130,6 +130,42 @@ int safe_sigaction(const char *file, const int lineno,
 	return rval;
 }
 
+void safe_sigaddset(const char *file, const int lineno,
+                    sigset_t *sigs, int signo)
+{
+	int rval;
+
+	rval = sigaddset(sigs, signo);
+	if (rval == -1) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+		         "sigaddset() %s (%i) failed",
+			 tst_strsig(signo), signo);
+	}
+}
+
+void safe_sigdelset(const char *file, const int lineno,
+                    sigset_t *sigs, int signo)
+{
+	int rval;
+
+	rval = sigdelset(sigs, signo);
+	if (rval == -1) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+		         "sigdelset() %s (%i) failed",
+			 tst_strsig(signo), signo);
+	}
+}
+
+void safe_sigemptyset(const char *file, const int lineno,
+                      sigset_t *sigs)
+{
+	int rval;
+
+	rval = sigemptyset(sigs);
+	if (rval == -1)
+		tst_brk_(file, lineno, TBROK | TERRNO, "sigemptyset() failed");
+}
+
 struct group *safe_getgrnam(const char *file, const int lineno,
 			    const char *name)
 {
-- 
2.26.2

