From: Petr Vorel <pvorel@suse.cz>
Date: Tue,  1 Dec 2020 18:42:08 +0100
Subject: [LTP] [PATCH v5 04/10] fanotify: Add helper for FAN_REPORT_FID
 support on fs
In-Reply-To: <20201201174214.24625-1-pvorel@suse.cz>
References: <20201201174214.24625-1-pvorel@suse.cz>
Message-ID: <20201201174214.24625-5-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

and use it in relevant tests setup().
The purpose is to reduce checks (cleanup).

FAN_REPORT_FID can be unsupported in kernel entirely (detected in
fanotify_init()) or just missing for particular fs (detected in
fanotify_mark().

The check is related to kernel fix
a8b13aa20afb ("fanotify: enable FAN_REPORT_FID init flag")

NOTE: FAN_REPORT_FID is missing (at least) on exfat and ntfs over FUSE.
Original motivation for cleanup in this and previous commits was not
only to simplify the code but also check for unsupported filesystems
which was missing least for exfat on fanotify16, because filesystem can
be set via LTP_DEV_FS_TYPE environment variable on tests which don't
tests all filesystems.

Suggested-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes v4->v5:
* Fix issue with "fanotify: Add helper for FAN_REPORT_FID support on fs"
  on fanotify01 (unwanted skipping tests). FAN_REPORT_FID is now tested
  both for general support in kernel with fanotify_init() and support on
  tested filesystem in fanotify_mark().

 testcases/kernel/syscalls/fanotify/fanotify.h | 68 +++++++++++++++++++
 .../kernel/syscalls/fanotify/fanotify01.c     | 19 +++---
 .../kernel/syscalls/fanotify/fanotify13.c     | 23 +------
 .../kernel/syscalls/fanotify/fanotify15.c     | 21 +-----
 .../kernel/syscalls/fanotify/fanotify16.c     |  6 +-
 5 files changed, 82 insertions(+), 55 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
index 8c677643f..821e6cb29 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify.h
+++ b/testcases/kernel/syscalls/fanotify/fanotify.h
@@ -283,4 +283,72 @@ static inline int fanotify_events_supported_by_kernel(uint64_t mask)
 	return rval;
 }
 
+/*
+ * @return  0: fanotify supported both in kernel and on tested filesystem
+ * @return -1: FAN_REPORT_FID not supported in kernel
+ * @return -2: FAN_REPORT_FID not supported on tested filesystem
+ */
+static inline int fanotify_fan_report_fid_supported_on_fs(const char *fname)
+{
+	int fd;
+	int rval = 0;
+
+	fd = fanotify_init(FAN_CLASS_NOTIF | FAN_REPORT_FID, O_RDONLY);
+
+	if (fd < 0) {
+		if (errno == ENOSYS)
+			tst_brk(TCONF, "fanotify not configured in kernel");
+
+		if (errno == EINVAL)
+			return -1;
+
+		tst_brk(TBROK | TERRNO, "fanotify_init() failed");
+	}
+
+	if (fanotify_mark(fd, FAN_MARK_ADD, FAN_ACCESS, AT_FDCWD, fname) < 0) {
+		if (errno == ENODEV || errno == EOPNOTSUPP || errno == EXDEV) {
+			rval = -2;
+		} else {
+			tst_brk(TBROK | TERRNO,
+				"fanotify_mark (%d, FAN_MARK_ADD, ..., AT_FDCWD, \".\") failed", fd);
+		}
+	}
+
+	SAFE_CLOSE(fd);
+
+	return rval;
+}
+
+typedef void (*tst_res_func_t)(const char *file, const int lineno,
+		int ttype, const char *fmt, ...);
+
+static inline void fanotify_fan_report_fid_err_msg(const char *file,
+	const int lineno, tst_res_func_t res_func, int fail)
+{
+	if (fail == -1)
+		res_func(file, lineno, TCONF,
+			 "FAN_REPORT_FID not supported in kernel?");
+
+	if (fail == -2)
+		res_func(file, lineno, TCONF,
+			 "FAN_REPORT_FID not supported on %s filesystem",
+			 tst_device->fs_type);
+}
+
+#define FANOTIFY_FAN_REPORT_FID_ERR_MSG(fail) \
+	fanotify_fan_report_fid_err_msg(__FILE__, __LINE__, tst_res_, (fail))
+
+static inline void require_fanotify_fan_report_fid_supported_on_fs(const char *file,
+	const int lineno, const char *fname)
+{
+	int rval;
+
+	rval = fanotify_fan_report_fid_supported_on_fs(fname);
+	if (rval)
+		fanotify_fan_report_fid_err_msg(file, lineno, tst_brk_, rval);
+}
+
+#define REQUIRE_FANOTIFY_FAN_REPORT_FID_SUPPORTED_ON_FS(fname) \
+	require_fanotify_fan_report_fid_supported_on_fs(__FILE__, __LINE__, (fname))
+
 #endif /* __FANOTIFY_H__ */
diff --git a/testcases/kernel/syscalls/fanotify/fanotify01.c b/testcases/kernel/syscalls/fanotify/fanotify01.c
index 03e453f41..5f2544931 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify01.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify01.c
@@ -74,6 +74,7 @@ static struct tcase {
 static char fname[BUF_SIZE];
 static char buf[BUF_SIZE];
 static int fd_notify;
+static int fan_report_fid_unsupported;
 
 static unsigned long long event_set[EVENT_MAX];
 
@@ -88,19 +89,13 @@ static void test_fanotify(unsigned int n)
 
 	tst_res(TINFO, "Test #%d: %s", n, tc->tname);
 
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
+	if (fan_report_fid_unsupported && (tc->init_flags & FAN_REPORT_FID)) {
+		FANOTIFY_FAN_REPORT_FID_ERR_MSG(fan_report_fid_unsupported);
+		return;
 	}
 
+	fd_notify = SAFE_FANOTIFY_INIT(tc->init_flags, O_RDONLY);
+
 	if (fanotify_mark(fd_notify, FAN_MARK_ADD | mark->flag,
 			  FAN_ACCESS | FAN_MODIFY | FAN_CLOSE | FAN_OPEN,
 			  AT_FDCWD, fname) < 0) {
@@ -366,6 +361,8 @@ static void setup(void)
 
 	sprintf(fname, MOUNT_PATH"/tfile_%d", getpid());
 	SAFE_FILE_PRINTF(fname, "1");
+
+	fan_report_fid_unsupported = fanotify_fan_report_fid_supported_on_fs(fname);
 }
 
 static void cleanup(void)
diff --git a/testcases/kernel/syscalls/fanotify/fanotify13.c b/testcases/kernel/syscalls/fanotify/fanotify13.c
index c2a21bb66..81fe02db2 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify13.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify13.c
@@ -124,14 +124,6 @@ static int setup_marks(unsigned int fd, struct test_case_t *tc)
 					"FAN_MARK_FILESYSTEM not supported by "
 					"kernel");
 				return 1;
-			} else if (errno == ENODEV &&
-				   !objects[i].fid.fsid.val[0] &&
-				   !objects[i].fid.fsid.val[1]) {
-				tst_res(TCONF,
-					"FAN_REPORT_FID not supported on "
-					"filesystem type %s",
-					tst_device->fs_type);
-				return 1;
 			}
 			tst_brk(TBROK | TERRNO,
 				"fanotify_mark(%d, FAN_MARK_ADD, FAN_OPEN, "
@@ -162,17 +154,7 @@ static void do_test(unsigned int number)
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
@@ -281,7 +263,8 @@ out:
 
 static void do_setup(void)
 {
-	/* Check for kernel fanotify support */
+	REQUIRE_FANOTIFY_FAN_REPORT_FID_SUPPORTED_ON_FS(MOUNT_PATH);
+
 	nofid_fd = SAFE_FANOTIFY_INIT(FAN_CLASS_NOTIF, O_RDONLY);
 
 	/* Create file and directory objects for testing */
diff --git a/testcases/kernel/syscalls/fanotify/fanotify15.c b/testcases/kernel/syscalls/fanotify/fanotify15.c
index d787a08e3..2e3044ad7 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify15.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify15.c
@@ -89,10 +89,6 @@ static void do_test(unsigned int number)
 				FAN_CREATE | FAN_DELETE | FAN_MOVE |
 				FAN_MODIFY | FAN_ONDIR,
 				AT_FDCWD, TEST_DIR) == -1) {
-		if (errno == ENODEV || errno == EOPNOTSUPP || errno == EXDEV)
-			tst_brk(TCONF,
-				"FAN_REPORT_FID not supported on %s "
-				"filesystem", tst_device->fs_type);
 		tst_brk(TBROK | TERRNO,
 			"fanotify_mark(%d, FAN_MARK_ADD | %s, "
 			"FAN_CREATE | FAN_DELETE | FAN_MOVE | "
@@ -287,22 +283,9 @@ static void do_test(unsigned int number)
 
 static void do_setup(void)
 {
-	int fd;
-
-	/* Check kernel for fanotify support */
-	fd = SAFE_FANOTIFY_INIT(FAN_CLASS_NOTIF, O_RDONLY);
-	SAFE_CLOSE(fd);
-
-	fanotify_fd = fanotify_init(FAN_REPORT_FID, O_RDONLY);
-	if (fanotify_fd == -1) {
-		if (errno == EINVAL)
-			tst_brk(TCONF,
-				"FAN_REPORT_FID not supported in kernel");
-		tst_brk(TBROK | TERRNO,
-			"fanotify_init(FAN_REPORT_FID, O_RDONLY) failed");
-	}
-
 	SAFE_MKDIR(TEST_DIR, 0755);
+	REQUIRE_FANOTIFY_FAN_REPORT_FID_SUPPORTED_ON_FS(TEST_DIR);
+	fanotify_fd = SAFE_FANOTIFY_INIT(FAN_REPORT_FID, O_RDONLY);
 }
 
 static void do_cleanup(void)
diff --git a/testcases/kernel/syscalls/fanotify/fanotify16.c b/testcases/kernel/syscalls/fanotify/fanotify16.c
index 7995a1688..c02a57dcd 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify16.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify16.c
@@ -562,11 +562,7 @@ check_match:
 
 static void setup(void)
 {
-	int fd;
-
-	/* Check kernel for fanotify support */
-	fd = SAFE_FANOTIFY_INIT(FAN_CLASS_NOTIF, O_RDONLY);
-	SAFE_CLOSE(fd);
+	REQUIRE_FANOTIFY_FAN_REPORT_FID_SUPPORTED_ON_FS(MOUNT_PATH);
 
 	sprintf(dname1, "%s/%s", MOUNT_PATH, DIR_NAME1);
 	sprintf(dname2, "%s/%s", MOUNT_PATH, DIR_NAME2);
-- 
2.29.2

