From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 28 Apr 2020 13:35:01 +0200
Subject: [LTP] [PATCH 2/2] fanotify: Test with tst_variant both raw syscall
 and libc
In-Reply-To: <20200428113501.24711-1-pvorel@suse.cz>
References: <20200428113501.24711-1-pvorel@suse.cz>
Message-ID: <20200428113501.24711-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

patchset is based on Amir's patchset [1], which I'd prefer to have
merged before.

libc wrappers for fanotify_init() and fanotify_mark() are trivial, so it
might not make sense to test both variants. WDYT?

Kind regards,
Petr

[1] https://patchwork.ozlabs.org/project/ltp/list/?series=171631&state=*

 testcases/kernel/syscalls/fanotify/fanotify.h | 55 ++++++++++---------
 .../kernel/syscalls/fanotify/fanotify01.c     | 27 +++++----
 .../kernel/syscalls/fanotify/fanotify02.c     | 13 +++--
 .../kernel/syscalls/fanotify/fanotify03.c     |  7 ++-
 .../kernel/syscalls/fanotify/fanotify04.c     | 27 +++++----
 .../kernel/syscalls/fanotify/fanotify05.c     |  7 ++-
 .../kernel/syscalls/fanotify/fanotify06.c     |  7 ++-
 .../kernel/syscalls/fanotify/fanotify07.c     |  7 ++-
 .../kernel/syscalls/fanotify/fanotify08.c     |  7 +++
 .../kernel/syscalls/fanotify/fanotify09.c     | 17 ++++--
 .../kernel/syscalls/fanotify/fanotify10.c     |  7 ++-
 .../kernel/syscalls/fanotify/fanotify11.c     |  7 ++-
 .../kernel/syscalls/fanotify/fanotify12.c     | 11 ++--
 .../kernel/syscalls/fanotify/fanotify13.c     |  9 ++-
 .../kernel/syscalls/fanotify/fanotify14.c     |  7 ++-
 .../kernel/syscalls/fanotify/fanotify15.c     |  5 +-
 .../kernel/syscalls/fanotify/fanotify16.c     | 15 +++--
 17 files changed, 147 insertions(+), 88 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
index f74171c15..18a5ca1a2 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify.h
+++ b/testcases/kernel/syscalls/fanotify/fanotify.h
@@ -8,55 +8,60 @@
 #define	__FANOTIFY_H__
 
 #include "config.h"
-#include <sys/statfs.h>
-#include <sys/types.h>
-#include <sys/stat.h>
 #include <errno.h>
 #include <fcntl.h>
-
-#if defined(HAVE_SYS_FANOTIFY_H)
-
 #include <sys/fanotify.h>
-
-#else /* HAVE_SYS_FANOTIFY_H */
-
-/* fanotify(7) wrappers */
-
+#include <sys/stat.h>
+#include <sys/statfs.h>
+#include <sys/types.h>
 #include <stdint.h>
 #include "lapi/syscalls.h"
 
-static int fanotify_init(unsigned int flags, unsigned int event_f_flags)
+#define TEST_VARIANTS 2
+
+static const char *variant_desc[] = {
+	"libc fanotify",
+	"fanotify syscall"
+};
+
+static inline int do_fanotify_init(unsigned int flags, unsigned int event_f_flags)
 {
-	return syscall(__NR_fanotify_init, flags, event_f_flags);
+	switch (tst_variant) {
+	case 0:
+		return fanotify_init(flags, event_f_flags);
+	case 1:
+		return syscall(__NR_fanotify_init, flags, event_f_flags);
+	}
+	return -1;
 }
 
-static long fanotify_mark(int fd, unsigned int flags, uint64_t mask,
+static inline long do_fanotify_mark(int fd, unsigned int flags, uint64_t mask,
                      int dfd, const char *pathname)
 {
-	return syscall(__NR_fanotify_mark, fd, flags, mask, dfd, pathname);
+	switch (tst_variant) {
+	case 0:
+		return fanotify_mark(fd, flags, mask, dfd, pathname);
+	case 1:
+		return syscall(__NR_fanotify_mark, fd, flags, mask, dfd, pathname);
+	}
+	return -1;
 }
 
-#endif /* HAVE_SYS_FANOTIFY_H */
-
 int safe_fanotify_init(const char *file, const int lineno,
 	unsigned int flags, unsigned int event_f_flags)
 {
 	int rval;
 
-#ifdef HAVE_SYS_FANOTIFY_H
-	rval = fanotify_init(flags, event_f_flags);
+	rval = do_fanotify_init(flags, event_f_flags);
 
 	if (rval == -1) {
-		if (errno == ENOSYS) {
+		if (errno == ENOSYS)
 			tst_brk(TCONF,
-				"fanotify is not configured in this kernel.");
-		}
+				"fanotify is not configured in this kernel");
+
 		tst_brk(TBROK | TERRNO,
 			"%s:%d: fanotify_init() failed", file, lineno);
 	}
-#else
-	tst_brk(TCONF, "Header <sys/fanotify.h> is not present");
-#endif /* HAVE_SYS_FANOTIFY_H */
 
 	return rval;
 }
diff --git a/testcases/kernel/syscalls/fanotify/fanotify01.c b/testcases/kernel/syscalls/fanotify/fanotify01.c
index 03e453f41..77c18e67f 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify01.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify01.c
@@ -88,7 +88,7 @@ static void test_fanotify(unsigned int n)
 
 	tst_res(TINFO, "Test #%d: %s", n, tc->tname);
 
-	fd_notify = fanotify_init(tc->init_flags, O_RDONLY);
+	fd_notify = do_fanotify_init(tc->init_flags, O_RDONLY);
 	if (fd_notify < 0) {
 		if (errno == EINVAL &&
 		    (tc->init_flags & FAN_REPORT_FID)) {
@@ -97,11 +97,11 @@ static void test_fanotify(unsigned int n)
 			return;
 		}
 		tst_brk(TBROK | TERRNO,
-			"fanotify_init (0x%x, O_RDONLY) "
+			"fanotify_init(0x%x, O_RDONLY) "
 			"failed", tc->init_flags);
 	}
 
-	if (fanotify_mark(fd_notify, FAN_MARK_ADD | mark->flag,
+	if (do_fanotify_mark(fd_notify, FAN_MARK_ADD | mark->flag,
 			  FAN_ACCESS | FAN_MODIFY | FAN_CLOSE | FAN_OPEN,
 			  AT_FDCWD, fname) < 0) {
 		if (errno == EINVAL && mark->flag == FAN_MARK_FILESYSTEM) {
@@ -110,7 +110,7 @@ static void test_fanotify(unsigned int n)
 			return;
 		}
 		tst_brk(TBROK | TERRNO,
-			"fanotify_mark (%d, FAN_MARK_ADD, FAN_ACCESS | %s | "
+			"fanotify_mark(%d, FAN_MARK_ADD, FAN_ACCESS | %s | "
 			"FAN_MODIFY | FAN_CLOSE | FAN_OPEN, AT_FDCWD, %s) "
 			"failed", fd_notify, mark->name, fname);
 	}
@@ -161,11 +161,11 @@ static void test_fanotify(unsigned int n)
 	 */
 
 	/* Ignore access events */
-	if (fanotify_mark(fd_notify,
+	if (do_fanotify_mark(fd_notify,
 			  FAN_MARK_ADD | mark->flag | FAN_MARK_IGNORED_MASK,
 			  FAN_ACCESS, AT_FDCWD, fname) < 0) {
 		tst_brk(TBROK | TERRNO,
-			"fanotify_mark (%d, FAN_MARK_ADD | %s | "
+			"fanotify_mark(%d, FAN_MARK_ADD | %s | "
 			"FAN_MARK_IGNORED_MASK, FAN_ACCESS, AT_FDCWD, %s) "
 			"failed", fd_notify, mark->name, fname);
 	}
@@ -211,11 +211,11 @@ static void test_fanotify(unsigned int n)
 	 * Now ignore open & close events regardless of file
 	 * modifications
 	 */
-	if (fanotify_mark(fd_notify, FAN_MARK_ADD | mark->flag |
+	if (do_fanotify_mark(fd_notify, FAN_MARK_ADD | mark->flag |
 			  FAN_MARK_IGNORED_MASK | FAN_MARK_IGNORED_SURV_MODIFY,
 			  FAN_OPEN | FAN_CLOSE, AT_FDCWD, fname) < 0) {
 		tst_brk(TBROK | TERRNO,
-			"fanotify_mark (%d, FAN_MARK_ADD | %s | "
+			"fanotify_mark(%d, FAN_MARK_ADD | %s | "
 			"FAN_MARK_IGNORED_MASK | FAN_MARK_IGNORED_SURV_MODIFY, "
 			"FAN_OPEN | FAN_CLOSE, AT_FDCWD, %s) failed",
 			fd_notify, mark->name, fname);
@@ -240,11 +240,11 @@ static void test_fanotify(unsigned int n)
 	len += ret;
 
 	/* Now remove open and close from ignored mask */
-	if (fanotify_mark(fd_notify,
+	if (do_fanotify_mark(fd_notify,
 			  FAN_MARK_REMOVE | mark->flag | FAN_MARK_IGNORED_MASK,
 			  FAN_OPEN | FAN_CLOSE, AT_FDCWD, fname) < 0) {
 		tst_brk(TBROK | TERRNO,
-			"fanotify_mark (%d, FAN_MARK_REMOVE | %s | "
+			"fanotify_mark(%d, FAN_MARK_REMOVE | %s | "
 			"FAN_MARK_IGNORED_MASK, FAN_OPEN | FAN_CLOSE, "
 			"AT_FDCWD, %s) failed", fd_notify,
 			mark->name, fname);
@@ -344,11 +344,11 @@ pass:
 
 	}
 	/* Remove mark to clear FAN_MARK_IGNORED_SURV_MODIFY */
-	if (fanotify_mark(fd_notify, FAN_MARK_REMOVE | mark->flag,
+	if (do_fanotify_mark(fd_notify, FAN_MARK_REMOVE | mark->flag,
 			  FAN_ACCESS | FAN_MODIFY | FAN_CLOSE | FAN_OPEN,
 			  AT_FDCWD, fname) < 0) {
 		tst_brk(TBROK | TERRNO,
-			"fanotify_mark (%d, FAN_MARK_REMOVE | %s, FAN_ACCESS | "
+			"fanotify_mark(%d, FAN_MARK_REMOVE | %s, FAN_ACCESS | "
 			"FAN_MODIFY | FAN_CLOSE | FAN_OPEN, AT_FDCWD, %s) "
 			"failed", fd_notify, mark->name, fname);
 	}
@@ -360,6 +360,8 @@ static void setup(void)
 {
 	int fd;
 
+	tst_res(TINFO, "Testing variant: %s", variant_desc[tst_variant]);
+
 	/* Check for kernel fanotify support */
 	fd = SAFE_FANOTIFY_INIT(FAN_CLASS_NOTIF, O_RDONLY);
 	SAFE_CLOSE(fd);
@@ -382,6 +384,7 @@ static struct tst_test test = {
 	.needs_root = 1,
 	.mount_device = 1,
 	.mntpoint = MOUNT_PATH,
+	.test_variants = TEST_VARIANTS,
 };
 
 #else
diff --git a/testcases/kernel/syscalls/fanotify/fanotify02.c b/testcases/kernel/syscalls/fanotify/fanotify02.c
index c578e0ae8..32c842804 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify02.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify02.c
@@ -46,12 +46,12 @@ void test01(void)
 
 	int tst_count = 0;
 
-	if (fanotify_mark(fd_notify, FAN_MARK_ADD, FAN_ACCESS |
+	if (do_fanotify_mark(fd_notify, FAN_MARK_ADD, FAN_ACCESS |
 			  FAN_MODIFY | FAN_CLOSE | FAN_OPEN |
 			  FAN_EVENT_ON_CHILD | FAN_ONDIR, AT_FDCWD,
 			  ".") < 0) {
 		tst_brk(TBROK | TERRNO,
-			"fanotify_mark (%d, FAN_MARK_ADD, FAN_ACCESS | "
+			"fanotify_mark(%d, FAN_MARK_ADD, FAN_ACCESS | "
 			"FAN_MODIFY | FAN_CLOSE | FAN_OPEN | "
 			"FAN_EVENT_ON_CHILD | FAN_ONDIR, AT_FDCWD, '.') "
 			"failed", fd_notify);
@@ -102,10 +102,10 @@ void test01(void)
 	/*
 	 * now remove child mark
 	 */
-	if (fanotify_mark(fd_notify, FAN_MARK_REMOVE,
+	if (do_fanotify_mark(fd_notify, FAN_MARK_REMOVE,
 			  FAN_EVENT_ON_CHILD, AT_FDCWD, ".") < 0) {
 		tst_brk(TBROK | TERRNO,
-			"fanotify_mark (%d, FAN_MARK REMOVE, "
+			"fanotify_mark(%d, FAN_MARK REMOVE, "
 			"FAN_EVENT_ON_CHILD, AT_FDCWD, '.') failed",
 			fd_notify);
 	}
@@ -190,6 +190,8 @@ void test01(void)
 
 static void setup(void)
 {
+	tst_res(TINFO, "Testing variant: %s", variant_desc[tst_variant]);
+
 	sprintf(fname, "fname_%d", getpid());
 	fd_notify = SAFE_FANOTIFY_INIT(FAN_CLASS_NOTIF, O_RDONLY);
 }
@@ -205,7 +207,8 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.needs_tmpdir = 1,
-	.needs_root = 1
+	.needs_root = 1,
+	.test_variants = TEST_VARIANTS,
 };
 
 #else
diff --git a/testcases/kernel/syscalls/fanotify/fanotify03.c b/testcases/kernel/syscalls/fanotify/fanotify03.c
index 1ef1c206b..fdb0d0f58 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify03.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify03.c
@@ -215,7 +215,7 @@ static int setup_mark(unsigned int n)
 	fd_notify = SAFE_FANOTIFY_INIT(FAN_CLASS_CONTENT, O_RDONLY);
 
 	for (; i < ARRAY_SIZE(files); i++) {
-		if (fanotify_mark(fd_notify, FAN_MARK_ADD | mark->flag,
+		if (do_fanotify_mark(fd_notify, FAN_MARK_ADD | mark->flag,
 				  tc->mask, AT_FDCWD, files[i]) < 0) {
 			if (errno == EINVAL &&
 				(tc->mask & FAN_OPEN_EXEC_PERM &&
@@ -347,6 +347,8 @@ static void test_fanotify(unsigned int n)
 
 static void setup(void)
 {
+	tst_res(TINFO, "Testing variant: %s", variant_desc[tst_variant]);
+
 	sprintf(fname, MOUNT_PATH"/fname_%d", getpid());
 	SAFE_FILE_PRINTF(fname, "1");
 
@@ -373,7 +375,8 @@ static struct tst_test test = {
 	.needs_root = 1,
 	.mount_device = 1,
 	.mntpoint = MOUNT_PATH,
-	.resource_files = resource_files
+	.resource_files = resource_files,
+	.test_variants = TEST_VARIANTS,
 };
 
 #else
diff --git a/testcases/kernel/syscalls/fanotify/fanotify04.c b/testcases/kernel/syscalls/fanotify/fanotify04.c
index 722ad5d41..8b738b3ae 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify04.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify04.c
@@ -58,15 +58,15 @@ static char *expect_str_pass(int expect)
 static void check_mark(char *file, unsigned long long flag, char *flagstr,
 		       int expect, void (*test_event)(char *))
 {
-	if (fanotify_mark(fd_notify, FAN_MARK_ADD | flag, FAN_OPEN, AT_FDCWD,
+	if (do_fanotify_mark(fd_notify, FAN_MARK_ADD | flag, FAN_OPEN, AT_FDCWD,
 			  file) != expect) {
 		tst_res(TFAIL,
-			"fanotify_mark (%d, FAN_MARK_ADD | %s, FAN_OPEN, "
+			"fanotify_mark(%d, FAN_MARK_ADD | %s, FAN_OPEN, "
 			"AT_FDCWD, '%s') %s", fd_notify, flagstr, file,
 			expect_str_fail(expect));
 	} else {
 		tst_res(TPASS,
-			"fanotify_mark (%d, FAN_MARK_ADD | %s, FAN_OPEN, "
+			"fanotify_mark(%d, FAN_MARK_ADD | %s, FAN_OPEN, "
 			"AT_FDCWD, '%s') %s", fd_notify, flagstr, file,
 			expect_str_pass(expect));
 
@@ -77,10 +77,10 @@ static void check_mark(char *file, unsigned long long flag, char *flagstr,
 		if (test_event)
 			test_event(file);
 
-		if (fanotify_mark(fd_notify, FAN_MARK_REMOVE | flag,
+		if (do_fanotify_mark(fd_notify, FAN_MARK_REMOVE | flag,
 				  FAN_OPEN, AT_FDCWD, file) < 0) {
 			tst_brk(TBROK | TERRNO,
-				"fanotify_mark (%d, FAN_MARK_REMOVE | %s, "
+				"fanotify_mark(%d, FAN_MARK_REMOVE | %s, "
 				"FAN_OPEN, AT_FDCWD, '%s') failed",
 				fd_notify, flagstr, file);
 		}
@@ -191,16 +191,16 @@ void test01(void)
 	CHECK_MARK(sname, 0, 0, test_open_file);
 
 	/* Verify FAN_MARK_FLUSH destroys all inode marks */
-	if (fanotify_mark(fd_notify, FAN_MARK_ADD,
+	if (do_fanotify_mark(fd_notify, FAN_MARK_ADD,
 			  FAN_OPEN, AT_FDCWD, fname) < 0) {
 		tst_brk(TBROK | TERRNO,
-			"fanotify_mark (%d, FAN_MARK_ADD, FAN_OPEN, "
+			"fanotify_mark(%d, FAN_MARK_ADD, FAN_OPEN, "
 			"AT_FDCWD, '%s') failed", fd_notify, fname);
 	}
-	if (fanotify_mark(fd_notify, FAN_MARK_ADD,
+	if (do_fanotify_mark(fd_notify, FAN_MARK_ADD,
 			  FAN_OPEN | FAN_ONDIR, AT_FDCWD, dir) < 0) {
 		tst_brk(TBROK | TERRNO,
-			"fanotify_mark (%d, FAN_MARK_ADD, FAN_OPEN | "
+			"fanotify_mark(%d, FAN_MARK_ADD, FAN_OPEN | "
 			"FAN_ONDIR, AT_FDCWD, '%s') failed", fd_notify,
 			dir);
 	}
@@ -208,10 +208,10 @@ void test01(void)
 	verify_event(S_IFREG);
 	open_dir(dir);
 	verify_event(S_IFDIR);
-	if (fanotify_mark(fd_notify, FAN_MARK_FLUSH,
+	if (do_fanotify_mark(fd_notify, FAN_MARK_FLUSH,
 			  0, AT_FDCWD, ".") < 0) {
 		tst_brk(TBROK | TERRNO,
-			"fanotify_mark (%d, FAN_MARK_FLUSH, 0, "
+			"fanotify_mark(%d, FAN_MARK_FLUSH, 0, "
 			"AT_FDCWD, '.') failed", fd_notify);
 	}
 
@@ -223,6 +223,8 @@ static void setup(void)
 {
 	int fd;
 
+	tst_res(TINFO, "Testing variant: %s", variant_desc[tst_variant]);
+
 	sprintf(fname, "fname_%d", getpid());
 	fd = SAFE_OPEN(fname, O_RDWR | O_CREAT, 0644);
 	SAFE_CLOSE(fd);
@@ -248,7 +250,8 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.needs_tmpdir = 1,
-	.needs_root = 1
+	.needs_root = 1,
+	.test_variants = TEST_VARIANTS,
 };
 
 #else
diff --git a/testcases/kernel/syscalls/fanotify/fanotify05.c b/testcases/kernel/syscalls/fanotify/fanotify05.c
index e53cc333a..24edec19c 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify05.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify05.c
@@ -104,13 +104,15 @@ void test01(void)
 
 static void setup(void)
 {
+	tst_res(TINFO, "Testing variant: %s", variant_desc[tst_variant]);
+
 	fd_notify = SAFE_FANOTIFY_INIT(FAN_CLASS_NOTIF | FAN_NONBLOCK,
 			O_RDONLY);
 
-	if (fanotify_mark(fd_notify, FAN_MARK_MOUNT | FAN_MARK_ADD, FAN_OPEN,
+	if (do_fanotify_mark(fd_notify, FAN_MARK_MOUNT | FAN_MARK_ADD, FAN_OPEN,
 			  AT_FDCWD, MOUNT_PATH) < 0) {
 		tst_brk(TBROK | TERRNO,
-			"fanotify_mark (%d, FAN_MARK_MOUNT | FAN_MARK_ADD, "
+			"fanotify_mark(%d, FAN_MARK_MOUNT | FAN_MARK_ADD, "
 			"FAN_OPEN, AT_FDCWD, \".\") failed",
 			fd_notify);
 	}
@@ -129,6 +131,7 @@ static struct tst_test test = {
 	.needs_root = 1,
 	.mount_device = 1,
 	.mntpoint = MOUNT_PATH,
+	.test_variants = TEST_VARIANTS,
 };
 #else
 	TST_TEST_TCONF("system doesn't have required fanotify support");
diff --git a/testcases/kernel/syscalls/fanotify/fanotify06.c b/testcases/kernel/syscalls/fanotify/fanotify06.c
index 99e312a4f..85dbe5b82 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify06.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify06.c
@@ -87,7 +87,7 @@ static void create_fanotify_groups(void)
 							     O_RDONLY);
 
 			/* Add mount mark for each group */
-			ret = fanotify_mark(fd_notify[p][i],
+			ret = do_fanotify_mark(fd_notify[p][i],
 					    FAN_MARK_ADD | FAN_MARK_MOUNT,
 					    FAN_MODIFY,
 					    AT_FDCWD, fname);
@@ -100,7 +100,7 @@ static void create_fanotify_groups(void)
 			/* Add ignore mark for groups with higher priority */
 			if (p == 0)
 				continue;
-			ret = fanotify_mark(fd_notify[p][i],
+			ret = do_fanotify_mark(fd_notify[p][i],
 					    FAN_MARK_ADD |
 					    FAN_MARK_IGNORED_MASK |
 					    FAN_MARK_IGNORED_SURV_MODIFY,
@@ -236,6 +236,8 @@ void test_fanotify(unsigned int n)
 
 static void setup(void)
 {
+	tst_res(TINFO, "Testing variant: %s", variant_desc[tst_variant]);
+
 	ovl_mounted = TST_MOUNT_OVERLAY();
 }
 
@@ -255,6 +257,7 @@ static struct tst_test test = {
 	.needs_root = 1,
 	.mount_device = 1,
 	.mntpoint = mntpoint,
+	.test_variants = TEST_VARIANTS,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "8edc6e1688fc"},
 		{"linux-git", "d989903058a8"},
diff --git a/testcases/kernel/syscalls/fanotify/fanotify07.c b/testcases/kernel/syscalls/fanotify/fanotify07.c
index c2e185710..be42d1a0b 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify07.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify07.c
@@ -103,7 +103,7 @@ static int setup_instance(void)
 
 	fd = SAFE_FANOTIFY_INIT(FAN_CLASS_CONTENT, O_RDONLY);
 
-	if (fanotify_mark(fd, FAN_MARK_ADD, FAN_ACCESS_PERM, AT_FDCWD,
+	if (do_fanotify_mark(fd, FAN_MARK_ADD, FAN_ACCESS_PERM, AT_FDCWD,
 			  fname) < 0) {
 		close(fd);
 		if (errno == EINVAL) {
@@ -112,7 +112,7 @@ static int setup_instance(void)
 				"configured in kernel?");
 		} else {
 			tst_brk(TBROK | TERRNO,
-				"fanotify_mark (%d, FAN_MARK_ADD, FAN_ACCESS_PERM, "
+				"fanotify_mark(%d, FAN_MARK_ADD, FAN_ACCESS_PERM, "
 				"AT_FDCWD, %s) failed.", fd, fname);
 		}
 	}
@@ -195,6 +195,8 @@ static void test_fanotify(void)
 
 static void setup(void)
 {
+	tst_res(TINFO, "Testing variant: %s", variant_desc[tst_variant]);
+
 	sprintf(fname, "fname_%d", getpid());
 	SAFE_FILE_PRINTF(fname, "%s", fname);
 }
@@ -212,6 +214,7 @@ static struct tst_test test = {
 	.needs_tmpdir = 1,
 	.forks_child = 1,
 	.needs_root = 1,
+	.test_variants = TEST_VARIANTS,
 };
 
 #else
diff --git a/testcases/kernel/syscalls/fanotify/fanotify08.c b/testcases/kernel/syscalls/fanotify/fanotify08.c
index a4031b4ad..b61a5509a 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify08.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify08.c
@@ -43,6 +43,11 @@ static void test_init_bit(unsigned int fan_bit,
 	SAFE_CLOSE(fd_notify);
 }
 
+static void setup(void)
+{
+	tst_res(TINFO, "Testing variant: %s", variant_desc[tst_variant]);
+}
+
 static void run(unsigned int i)
 {
 	switch (i) {
@@ -64,8 +69,10 @@ static void cleanup(void)
 static struct tst_test test = {
 	.test = run,
 	.tcnt = 2,
+	.setup = setup,
 	.cleanup = cleanup,
 	.needs_root = 1,
+	.test_variants = TEST_VARIANTS,
 };
 
 #else
diff --git a/testcases/kernel/syscalls/fanotify/fanotify09.c b/testcases/kernel/syscalls/fanotify/fanotify09.c
index 4336f498f..a023cd8f6 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify09.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify09.c
@@ -50,6 +50,7 @@
 static char fname[BUF_SIZE];
 static char symlnk[BUF_SIZE];
 static char fdpath[BUF_SIZE];
+static char mntpoint[BUF_SIZE];
 static int fd_notify[NUM_GROUPS];
 
 static char event_buf[EVENT_BUF_LEN];
@@ -96,7 +97,7 @@ static void create_fanotify_groups(unsigned int ondir)
 
 		/* Add mount mark for each group without MODIFY event */
 		onchild = (i == 0) ? FAN_EVENT_ON_CHILD | ondir : 0;
-		ret = fanotify_mark(fd_notify[i],
+		ret = do_fanotify_mark(fd_notify[i],
 				    FAN_MARK_ADD | FAN_MARK_MOUNT,
 				    FAN_CLOSE_NOWRITE | onchild,
 				    AT_FDCWD, ".");
@@ -114,7 +115,7 @@ static void create_fanotify_groups(unsigned int ondir)
 		 * setting the DCACHE_FSNOTIFY_PARENT_WATCHED dentry
 		 * flag.
 		 */
-		ret = fanotify_mark(fd_notify[i], FAN_MARK_ADD,
+		ret = do_fanotify_mark(fd_notify[i], FAN_MARK_ADD,
 				    FAN_MODIFY | ondir | onchild,
 				    AT_FDCWD, ".");
 		if (ret < 0) {
@@ -256,10 +257,13 @@ static void test_fanotify(unsigned int n)
 
 static void setup(void)
 {
-	SAFE_MKDIR(MOUNT_NAME, 0755);
-	SAFE_MOUNT(MOUNT_NAME, MOUNT_NAME, "none", MS_BIND, NULL);
+	tst_res(TINFO, "Testing variant: %s", variant_desc[tst_variant]);
+
+	sprintf(mntpoint, "%s_%d", MOUNT_NAME, tst_variant);
+	SAFE_MKDIR(mntpoint, 0755);
+	SAFE_MOUNT(mntpoint, mntpoint, "none", MS_BIND, NULL);
 	mount_created = 1;
-	SAFE_CHDIR(MOUNT_NAME);
+	SAFE_CHDIR(mntpoint);
 	SAFE_MKDIR(DIR_NAME, 0755);
 
 	sprintf(fname, "tfile_%d", getpid());
@@ -272,7 +276,7 @@ static void cleanup(void)
 
 	SAFE_CHDIR("../");
 
-	if (mount_created && tst_umount(MOUNT_NAME) < 0)
+	if (mount_created && tst_umount(mntpoint) < 0)
 		tst_brk(TBROK | TERRNO, "umount failed");
 }
 
@@ -283,6 +287,7 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.needs_tmpdir = 1,
 	.needs_root = 1,
+	.test_variants = TEST_VARIANTS,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "54a307ba8d3c"},
 		{"linux-git", "b469e7e47c8a"},
diff --git a/testcases/kernel/syscalls/fanotify/fanotify10.c b/testcases/kernel/syscalls/fanotify/fanotify10.c
index ef0807761..eb7e4efcf 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify10.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify10.c
@@ -213,7 +213,7 @@ static int create_fanotify_groups(unsigned int n)
 							     O_RDONLY);
 
 			/* Add mark for each group */
-			ret = fanotify_mark(fd_notify[p][i],
+			ret = do_fanotify_mark(fd_notify[p][i],
 					    FAN_MARK_ADD | mark->flag,
 					    tc->expected_mask_without_ignore,
 					    AT_FDCWD, tc->mark_path);
@@ -241,7 +241,7 @@ static int create_fanotify_groups(unsigned int n)
 			/* Add ignore mark for groups with higher priority */
 			if (p == 0)
 				continue;
-			ret = fanotify_mark(fd_notify[p][i],
+			ret = do_fanotify_mark(fd_notify[p][i],
 					    FAN_MARK_ADD | ignore_mark->flag |
 					    FAN_MARK_IGNORED_MASK |
 					    FAN_MARK_IGNORED_SURV_MODIFY,
@@ -408,6 +408,8 @@ cleanup:
 
 static void setup(void)
 {
+	tst_res(TINFO, "Testing variant: %s", variant_desc[tst_variant]);
+
 	/* Create another bind mount at another path for generating events */
 	SAFE_MKDIR(MNT2_PATH, 0755);
 	SAFE_MOUNT(MOUNT_PATH, MNT2_PATH, "none", MS_BIND, NULL);
@@ -443,6 +445,7 @@ static struct tst_test test = {
 	.needs_root = 1,
 	.forks_child = 1,
 	.resource_files = resource_files,
+	.test_variants = TEST_VARIANTS,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "9bdda4e9cf2d"},
 		{}
diff --git a/testcases/kernel/syscalls/fanotify/fanotify11.c b/testcases/kernel/syscalls/fanotify/fanotify11.c
index 9e8606c72..b8da46eff 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify11.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify11.c
@@ -65,7 +65,7 @@ void test01(unsigned int i)
 			i, (tcases[i] & FAN_REPORT_TID) ? "with" : "without",
 			tgid, tid, event.pid);
 
-	fd_notify = fanotify_init(tcases[i], 0);
+	fd_notify = do_fanotify_init(tcases[i], 0);
 	if (fd_notify < 0) {
 		if (errno == EINVAL && (tcases[i] & FAN_REPORT_TID)) {
 			tst_res(TCONF,
@@ -76,7 +76,7 @@ void test01(unsigned int i)
 				tcases[i]);
 	}
 
-	ret = fanotify_mark(fd_notify, FAN_MARK_ADD,
+	ret = do_fanotify_mark(fd_notify, FAN_MARK_ADD,
 			FAN_ALL_EVENTS | FAN_EVENT_ON_CHILD, AT_FDCWD, ".");
 	if (ret != 0)
 		tst_brk(TBROK, "fanotify_mark FAN_MARK_ADD fail ret=%d", ret);
@@ -102,6 +102,8 @@ static void setup(void)
 {
 	int fd;
 
+	tst_res(TINFO, "Testing variant: %s", variant_desc[tst_variant]);
+
 	fd = SAFE_FANOTIFY_INIT(FAN_CLASS_NOTIF, O_RDONLY);
 	SAFE_CLOSE(fd);
 }
@@ -112,6 +114,7 @@ static struct tst_test test = {
 	.tcnt =  ARRAY_SIZE(tcases),
 	.needs_tmpdir = 1,
 	.needs_root = 1,
+	.test_variants = TEST_VARIANTS,
 };
 
 #else
diff --git a/testcases/kernel/syscalls/fanotify/fanotify12.c b/testcases/kernel/syscalls/fanotify/fanotify12.c
index fcb7ec0d3..24fb712d4 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify12.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify12.c
@@ -139,7 +139,7 @@ static int setup_mark(unsigned int n)
 
 	for (; i < ARRAY_SIZE(files); i++) {
 		/* Setup normal mark on object */
-		if (fanotify_mark(fd_notify, FAN_MARK_ADD | mark->flag,
+		if (do_fanotify_mark(fd_notify, FAN_MARK_ADD | mark->flag,
 					tc->mask, AT_FDCWD, files[i]) < 0) {
 			if (errno == EINVAL && tc->mask & FAN_OPEN_EXEC) {
 				tst_res(TCONF,
@@ -163,7 +163,7 @@ static int setup_mark(unsigned int n)
 
 		/* Setup ignore mark on object */
 		if (tc->ignore_mask) {
-			if (fanotify_mark(fd_notify, FAN_MARK_ADD | mark->flag
+			if (do_fanotify_mark(fd_notify, FAN_MARK_ADD | mark->flag
 						| FAN_MARK_IGNORED_MASK,
 						tc->ignore_mask, AT_FDCWD,
 						files[i]) < 0) {
@@ -180,7 +180,7 @@ static int setup_mark(unsigned int n)
 						"kernel?");
 				} else {
 					tst_brk(TBROK | TERRNO,
-						"fanotify_mark (%d, "
+						"fanotify_mark(%d, "
 						"FAN_MARK_ADD | %s "
 						"| FAN_MARK_IGNORED_MASK, "
 						"%llx, AT_FDCWD, %s) failed",
@@ -253,6 +253,8 @@ cleanup:
 
 static void do_setup(void)
 {
+	tst_res(TINFO, "Testing variant: %s", variant_desc[tst_variant]);
+
 	sprintf(fname, "fname_%d", getpid());
 	SAFE_FILE_PRINTF(fname, "1");
 }
@@ -275,7 +277,8 @@ static struct tst_test test = {
 	.cleanup = do_cleanup,
 	.forks_child = 1,
 	.needs_root = 1,
-	.resource_files = resource_files
+	.resource_files = resource_files,
+	.test_variants = TEST_VARIANTS,
 };
 #else
 	TST_TEST_TCONF("System does not contain required fanotify support");
diff --git a/testcases/kernel/syscalls/fanotify/fanotify13.c b/testcases/kernel/syscalls/fanotify/fanotify13.c
index 3d8de6009..065aac646 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify13.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify13.c
@@ -121,7 +121,7 @@ static int setup_marks(unsigned int fd, struct test_case_t *tc)
 	struct fanotify_mark_type *mark = &tc->mark;
 
 	for (i = 0; i < ARRAY_SIZE(objects); i++) {
-		if (fanotify_mark(fd, FAN_MARK_ADD | mark->flag, tc->mask,
+		if (do_fanotify_mark(fd, FAN_MARK_ADD | mark->flag, tc->mask,
 					AT_FDCWD, objects[i].path) == -1) {
 			if (errno == EINVAL &&
 				mark->flag & FAN_MARK_FILESYSTEM) {
@@ -167,7 +167,7 @@ static void do_test(unsigned int number)
 		"Test #%d: FAN_REPORT_FID with mark flag: %s",
 		number, mark->name);
 
-	fanotify_fd = fanotify_init(FAN_CLASS_NOTIF | FAN_REPORT_FID, O_RDONLY);
+	fanotify_fd = do_fanotify_init(FAN_CLASS_NOTIF | FAN_REPORT_FID, O_RDONLY);
 	if (fanotify_fd == -1) {
 		if (errno == EINVAL) {
 			tst_res(TCONF,
@@ -285,6 +285,8 @@ out:
 
 static void do_setup(void)
 {
+	tst_res(TINFO, "Testing variant: %s", variant_desc[tst_variant]);
+
 	/* Check for kernel fanotify support */
 	nofid_fd = SAFE_FANOTIFY_INIT(FAN_CLASS_NOTIF, O_RDONLY);
 
@@ -296,7 +298,7 @@ static void do_setup(void)
 	 * uninitialized connector->fsid cache. This mark remains for all test
 	 * cases and is not expected to get any events (no writes in this test).
 	 */
-	if (fanotify_mark(nofid_fd, FAN_MARK_ADD, FAN_CLOSE_WRITE, AT_FDCWD,
+	if (do_fanotify_mark(nofid_fd, FAN_MARK_ADD, FAN_CLOSE_WRITE, AT_FDCWD,
 			  FILE_PATH_ONE) == -1) {
 		tst_brk(TBROK | TERRNO,
 			"fanotify_mark(%d, FAN_MARK_ADD, FAN_CLOSE_WRITE, "
@@ -325,6 +327,7 @@ static struct tst_test test = {
 	.mount_device = 1,
 	.mntpoint = MOUNT_PATH,
 	.all_filesystems = 1,
+	.test_variants = TEST_VARIANTS,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "c285a2f01d69"},
 		{}
diff --git a/testcases/kernel/syscalls/fanotify/fanotify14.c b/testcases/kernel/syscalls/fanotify/fanotify14.c
index 3ca38d1e7..d78c3f3ca 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify14.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify14.c
@@ -96,7 +96,7 @@ static void do_test(unsigned int number)
 		goto out;
 	}
 
-	ret = fanotify_mark(fanotify_fd, FAN_MARK_ADD | tc->mark_flags,
+	ret = do_fanotify_mark(fanotify_fd, FAN_MARK_ADD | tc->mark_flags,
 				tc->mask, AT_FDCWD, FILE1);
 	if (ret < 0) {
 		/*
@@ -146,6 +146,8 @@ static void do_setup(void)
 {
 	int fd;
 
+	tst_res(TINFO, "Testing variant: %s", variant_desc[tst_variant]);
+
 	/* Check for kernel fanotify support */
 	fd = SAFE_FANOTIFY_INIT(FAN_CLASS_NOTIF, O_RDONLY);
 	SAFE_CLOSE(fd);
@@ -168,7 +170,8 @@ static struct tst_test test = {
 	.cleanup = do_cleanup,
 	.mount_device = 1,
 	.mntpoint = MNTPOINT,
-	.all_filesystems = 1
+	.all_filesystems = 1,
+	.test_variants = TEST_VARIANTS,
 };
 
 #else
diff --git a/testcases/kernel/syscalls/fanotify/fanotify15.c b/testcases/kernel/syscalls/fanotify/fanotify15.c
index c95c1ec15..7aebe19c7 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify15.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify15.c
@@ -88,7 +88,7 @@ static void do_test(unsigned int number)
 		number, mark->name);
 
 
-	if (fanotify_mark(fanotify_fd, FAN_MARK_ADD | mark->flag, tc->mask |
+	if (do_fanotify_mark(fanotify_fd, FAN_MARK_ADD | mark->flag, tc->mask |
 				FAN_CREATE | FAN_DELETE | FAN_MOVE |
 				FAN_MODIFY | FAN_ONDIR,
 				AT_FDCWD, TEST_DIR) == -1) {
@@ -296,6 +296,8 @@ static void do_setup(void)
 {
 	int fd;
 
+	tst_res(TINFO, "Testing variant: %s", variant_desc[tst_variant]);
+
 	/* Check kernel for fanotify support */
 	fd = SAFE_FANOTIFY_INIT(FAN_CLASS_NOTIF, O_RDONLY);
 	SAFE_CLOSE(fd);
@@ -327,6 +329,7 @@ static struct tst_test test = {
 	.tcnt = ARRAY_SIZE(test_cases),
 	.setup = do_setup,
 	.cleanup = do_cleanup,
+	.test_variants = TEST_VARIANTS,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "f367a62a7cad"},
 		{}
diff --git a/testcases/kernel/syscalls/fanotify/fanotify16.c b/testcases/kernel/syscalls/fanotify/fanotify16.c
index 7c29d256a..35729aa7b 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify16.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify16.c
@@ -114,7 +114,7 @@ static void do_test(unsigned int number)
 		number, mark->name);
 
 
-	fd_notify = fanotify_init(FAN_REPORT_FID, 0);
+	fd_notify = do_fanotify_init(FAN_REPORT_FID, 0);
 	if (fd_notify == -1) {
 		if (errno == EINVAL)
 			tst_brk(TCONF,
@@ -127,14 +127,14 @@ static void do_test(unsigned int number)
 	/*
 	 * Watch dir modify events with name in filesystem/dir
 	 */
-	if (fanotify_mark(fd_notify, FAN_MARK_ADD | mark->flag, tc->mask,
+	if (do_fanotify_mark(fd_notify, FAN_MARK_ADD | mark->flag, tc->mask,
 			  AT_FDCWD, MOUNT_PATH) < 0) {
 		if (errno == EINVAL)
 			tst_brk(TCONF,
 				"FAN_DIR_MODIFY not supported by kernel");
 
 		tst_brk(TBROK | TERRNO,
-		    "fanotify_mark (%d, FAN_MARK_ADD | %s, "
+		    "fanotify_mark(%d, FAN_MARK_ADD | %s, "
 		    "FAN_DIR_MODIFY, AT_FDCWD, '"MOUNT_PATH"') "
 		    "failed", fd_notify, mark->name);
 	}
@@ -154,10 +154,10 @@ static void do_test(unsigned int number)
 	save_fid(dname1, &dir_fid);
 
 	if (tc->sub_mask &&
-	    fanotify_mark(fd_notify, FAN_MARK_ADD | sub_mark->flag, tc->sub_mask,
+	    do_fanotify_mark(fd_notify, FAN_MARK_ADD | sub_mark->flag, tc->sub_mask,
 			  AT_FDCWD, dname1) < 0) {
 		tst_brk(TBROK | TERRNO,
-		    "fanotify_mark (%d, FAN_MARK_ADD | %s, "
+		    "fanotify_mark(%d, FAN_MARK_ADD | %s, "
 		    "FAN_DIR_MODIFY | FAN_DELETE_SELF | FAN_ONDIR, "
 		    "AT_FDCWD, '%s') "
 		    "failed", fd_notify, sub_mark->name, dname1);
@@ -411,6 +411,8 @@ static void do_test(unsigned int number)
 
 static void setup(void)
 {
+	tst_res(TINFO, "Testing variant: %s", variant_desc[tst_variant]);
+
 	sprintf(dname1, "%s/%s", MOUNT_PATH, DIR_NAME1);
 	sprintf(dname2, "%s/%s", MOUNT_PATH, DIR_NAME2);
 	sprintf(fname1, "%s/%s", dname1, FILE_NAME1);
@@ -433,7 +435,8 @@ static struct tst_test test = {
 	.mntpoint = MOUNT_PATH,
 	.all_filesystems = 1,
 	.needs_tmpdir = 1,
-	.needs_root = 1
+	.needs_root = 1,
+	.test_variants = TEST_VARIANTS,
 };
 
 #else
-- 
2.26.2

