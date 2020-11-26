From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 26 Nov 2020 22:41:20 +0100
Subject: [LTP] [PATCH v4 5/6] fanotify: Check FAN_REPORT_{FID, NAME} support
In-Reply-To: <20201126214121.6836-1-pvorel@suse.cz>
References: <20201126214121.6836-1-pvorel@suse.cz>
Message-ID: <20201126214121.6836-6-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

in safe_fanotify_init()

That require to move the definition after flags.

Also use tst_res_()/tst_brk_() instead of tst_res()/tst_brk() in
safe_fanotify_init() (synchronize with safe_fanotify_mark()).

Make use of this simplification in fanotify15.c.

Suggested-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes v3->v4:
* use tst_res_() and tst_brk_() for safe_*() functions

 testcases/kernel/syscalls/fanotify/fanotify.h | 64 +++++++++++--------
 .../kernel/syscalls/fanotify/fanotify01.c     | 13 +---
 .../kernel/syscalls/fanotify/fanotify13.c     | 12 +---
 .../kernel/syscalls/fanotify/fanotify15.c     |  9 +--
 4 files changed, 41 insertions(+), 57 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
index 2a5280636..4b725f334 100644
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
@@ -190,6 +164,44 @@ struct fanotify_event_info_fid {
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
+			tst_brk_(file, lineno, TCONF,
+				 "fanotify not configured in kernel");
+		}
+
+		if (errno == EINVAL) {
+			if (flags & FAN_REPORT_FID) {
+				tst_brk_(file, lineno, TCONF,
+					 "FAN_REPORT_FID not supported in kernel?");
+			}
+
+			if (flags & FAN_REPORT_NAME) {
+				tst_brk_(file, lineno, TCONF,
+					 "FAN_REPORT_NAME not supported in kernel?");
+			}
+		}
+
+		tst_brk_(file, lineno, TBROK | TERRNO, "fanotify_init() failed");
+	}
+#else
+	tst_brk_(file, lineno, TCONF, "Header <sys/fanotify.h> is not present");
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
diff --git a/testcases/kernel/syscalls/fanotify/fanotify01.c b/testcases/kernel/syscalls/fanotify/fanotify01.c
index 170428eba..cd571e002 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify01.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify01.c
@@ -95,18 +95,7 @@ static void test_fanotify(unsigned int n)
 		return;
 	}
 
-	fd_notify = fanotify_init(tc->init_flags, O_RDONLY);
-	if (fd_notify < 0) {
-		if (errno == EINVAL &&
-		    (tc->init_flags & FAN_REPORT_FID)) {
-			tst_res(TCONF,
-				"FAN_REPORT_FID not supported in kernel?");
-			return;
-		}
-		tst_brk(TBROK | TERRNO,
-			"fanotify_init (0x%x, O_RDONLY) "
-			"failed", tc->init_flags);
-	}
+	fd_notify = SAFE_FANOTIFY_INIT(tc->init_flags, O_RDONLY);
 
 	SAFE_FANOTIFY_MARK(fd_notify, FAN_MARK_ADD | mark->flag,
 			  FAN_ACCESS | FAN_MODIFY | FAN_CLOSE | FAN_OPEN, AT_FDCWD, fname);
diff --git a/testcases/kernel/syscalls/fanotify/fanotify13.c b/testcases/kernel/syscalls/fanotify/fanotify13.c
index 2c1dc4624..3d5cfc13b 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify13.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify13.c
@@ -142,17 +142,7 @@ static void do_test(unsigned int number)
 		"Test #%d: FAN_REPORT_FID with mark flag: %s",
 		number, mark->name);
 
-	fanotify_fd = fanotify_init(FAN_CLASS_NOTIF | FAN_REPORT_FID, O_RDONLY);
-	if (fanotify_fd == -1) {
-		if (errno == EINVAL) {
-			tst_res(TCONF,
-				"FAN_REPORT_FID not supported by kernel");
-			return;
-		}
-		tst_brk(TBROK | TERRNO,
-			"fanotify_init(FAN_CLASS_NOTIF | FAN_REPORT_FID, "
-			"O_RDONLY) failed");
-	}
+	fanotify_fd = SAFE_FANOTIFY_INIT(FAN_CLASS_NOTIF | FAN_REPORT_FID, O_RDONLY);
 
 	/*
 	 * Place marks on a set of objects and setup the expected masks
diff --git a/testcases/kernel/syscalls/fanotify/fanotify15.c b/testcases/kernel/syscalls/fanotify/fanotify15.c
index 6121ef211..8bf8f2045 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify15.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify15.c
@@ -277,14 +277,7 @@ static void do_setup(void)
 	fd = SAFE_FANOTIFY_INIT(FAN_CLASS_NOTIF, O_RDONLY);
 	SAFE_CLOSE(fd);
 
-	fanotify_fd = fanotify_init(FAN_REPORT_FID, O_RDONLY);
-	if (fanotify_fd == -1) {
-		if (errno == EINVAL)
-			tst_brk(TCONF,
-				"FAN_REPORT_FID not supported in kernel");
-		tst_brk(TBROK | TERRNO,
-			"fanotify_init(FAN_REPORT_FID, O_RDONLY) failed");
-	}
+	fanotify_fd = SAFE_FANOTIFY_INIT(FAN_REPORT_FID, O_RDONLY);
 
 	SAFE_MKDIR(TEST_DIR, 0755);
 
-- 
2.29.2

