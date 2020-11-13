From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 13 Nov 2020 17:49:43 +0100
Subject: [LTP] [PATCH v3 4/5] fanotify: Check FAN_REPORT_{FID, NAME} support
In-Reply-To: <20201113164944.26101-1-pvorel@suse.cz>
References: <20201113164944.26101-1-pvorel@suse.cz>
Message-ID: <20201113164944.26101-5-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

in safe_fanotify_init()

That require to move the definition after flags.

Suggested-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/syscalls/fanotify/fanotify.h | 65 +++++++++++--------
 1 file changed, 39 insertions(+), 26 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
index 18a2328cf..04b6699cf 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify.h
+++ b/testcases/kernel/syscalls/fanotify/fanotify.h
@@ -38,32 +38,6 @@ static long fanotify_mark(int fd, unsigned int flags, uint64_t mask,
 
 #endif /* HAVE_SYS_FANOTIFY_H */
 
-int safe_fanotify_init(const char *file, const int lineno,
-	unsigned int flags, unsigned int event_f_flags)
-{
-	int rval;
-
-#ifdef HAVE_SYS_FANOTIFY_H
-	rval = fanotify_init(flags, event_f_flags);
-
-	if (rval == -1) {
-		if (errno == ENOSYS) {
-			tst_brk(TCONF,
-				"fanotify is not configured in this kernel.");
-		}
-		tst_brk(TBROK | TERRNO,
-			"%s:%d: fanotify_init() failed", file, lineno);
-	}
-#else
-	tst_brk(TCONF, "Header <sys/fanotify.h> is not present");
-#endif /* HAVE_SYS_FANOTIFY_H */
-
-	return rval;
-}
-
-#define SAFE_FANOTIFY_INIT(fan, mode)  \
-	safe_fanotify_init(__FILE__, __LINE__, (fan), (mode))
-
 #ifndef FAN_REPORT_TID
 #define FAN_REPORT_TID		0x00000100
 #endif
@@ -190,6 +164,45 @@ struct fanotify_event_info_fid {
 #define MAX_HANDLE_SZ		128
 #endif
 
+int safe_fanotify_init(const char *file, const int lineno,
+	unsigned int flags, unsigned int event_f_flags)
+{
+	int rval;
+
+#ifdef HAVE_SYS_FANOTIFY_H
+	rval = fanotify_init(flags, event_f_flags);
+
+	if (rval == -1) {
+		if (errno == ENOSYS) {
+			tst_brk(TCONF, "%s:%d: fanotify is not configured in this kernel",
+				file, lineno);
+		}
+
+		if (errno == EINVAL) {
+			if (flags & FAN_REPORT_FID) {
+				tst_brk(TCONF, "%s:%d: FAN_REPORT_FID not supported by kernel?",
+					file, lineno);
+			}
+
+			if (flags & FAN_REPORT_NAME) {
+				tst_brk(TCONF, "%s:%d: FAN_REPORT_NAME not supported by kernel?",
+					file, lineno);
+			}
+		}
+
+		tst_brk(TBROK | TERRNO, "%s:%d: fanotify_init() failed",
+			file, lineno);
+	}
+#else
+	tst_brk(TCONF, "Header <sys/fanotify.h> is not present");
+#endif /* HAVE_SYS_FANOTIFY_H */
+
+	return rval;
+}
+
+#define SAFE_FANOTIFY_INIT(fan, mode)  \
+	safe_fanotify_init(__FILE__, __LINE__, (fan), (mode))
+
 static inline int safe_fanotify_mark(const char *file, const int lineno,
 			int fd, unsigned int flags, uint64_t mask,
 			int dfd, const char *pathname)
-- 
2.29.2

