From: Amir Goldstein <amir73il@gmail.com>
Date: Fri,  4 Dec 2020 11:59:26 +0200
Subject: [LTP] [PATCH 1/5] syscalls/fanotify: Generalize check for
 FAN_REPORT_FID support
In-Reply-To: <20201204095930.866421-1-amir73il@gmail.com>
References: <20201204095930.866421-1-amir73il@gmail.com>
Message-ID: <20201204095930.866421-2-amir73il@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Generalize the helpers to be able to check any fanotify_init() flags
and pass FAN_REPORT_FID as argument in call sites.

Add helper fanotify_init_flags_supported_by_kernel() to check for
kernel support for fanotify_init flags without checking fs support
for those flags.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 testcases/kernel/syscalls/fanotify/fanotify.h | 46 ++++++++++++-------
 .../kernel/syscalls/fanotify/fanotify01.c     |  4 +-
 .../kernel/syscalls/fanotify/fanotify13.c     |  2 +-
 .../kernel/syscalls/fanotify/fanotify15.c     |  2 +-
 .../kernel/syscalls/fanotify/fanotify16.c     |  2 +-
 5 files changed, 34 insertions(+), 22 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
index 82e03db26..8907db052 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify.h
+++ b/testcases/kernel/syscalls/fanotify/fanotify.h
@@ -286,15 +286,15 @@ static inline int fanotify_events_supported_by_kernel(uint64_t mask)
 
 /*
  * @return  0: fanotify supported both in kernel and on tested filesystem
- * @return -1: FAN_REPORT_FID not supported in kernel
- * @return -2: FAN_REPORT_FID not supported on tested filesystem
+ * @return -1: @flags not supported in kernel
+ * @return -2: @flags not supported on tested filesystem (tested if @fname is not NULL)
  */
-static inline int fanotify_fan_report_fid_supported_on_fs(const char *fname)
+static inline int fanotify_init_flags_supported_on_fs(unsigned int flags, const char *fname)
 {
 	int fd;
 	int rval = 0;
 
-	fd = fanotify_init(FAN_CLASS_NOTIF | FAN_REPORT_FID, O_RDONLY);
+	fd = fanotify_init(flags, O_RDONLY);
 
 	if (fd < 0) {
 		if (errno == ENOSYS)
@@ -306,7 +306,7 @@ static inline int fanotify_fan_report_fid_supported_on_fs(const char *fname)
 		tst_brk(TBROK | TERRNO, "fanotify_init() failed");
 	}
 
-	if (fanotify_mark(fd, FAN_MARK_ADD, FAN_ACCESS, AT_FDCWD, fname) < 0) {
+	if (fname && fanotify_mark(fd, FAN_MARK_ADD, FAN_ACCESS, AT_FDCWD, fname) < 0) {
 		if (errno == ENODEV || errno == EOPNOTSUPP || errno == EXDEV) {
 			rval = -2;
 		} else {
@@ -321,20 +321,32 @@ static inline int fanotify_fan_report_fid_supported_on_fs(const char *fname)
 	return rval;
 }
 
-#define FANOTIFY_FAN_REPORT_FID_ERR_MSG_(res_func, fail) do { \
-	if (fail == -1) \
-		res_func(TCONF, "FAN_REPORT_FID not supported in kernel?"); \
-	if (fail == -2) \
-		res_func(TCONF, "FAN_REPORT_FID not supported on %s filesystem", \
-			tst_device->fs_type); \
-	} while (0)
+static inline int fanotify_init_flags_supported_by_kernel(unsigned int flags)
+{
+	return fanotify_init_flags_supported_on_fs(flags, NULL);
+}
+
+typedef void (*tst_res_func_t)(const char *file, const int lineno,
+			       int ttype, const char *fmt, ...);
+
+static inline void fanotify_init_flags_err_msg(const char *flags_str,
+	const char *file, const int lineno, tst_res_func_t res_func, int fail)
+{
+	if (fail == -1)
+		res_func(file, lineno, TCONF,
+			 "%s not supported in kernel?", flags_str);
+	if (fail == -2)
+		res_func(file, lineno, TCONF,
+			 "%s not supported on %s filesystem",
+			 flags_str, tst_device->fs_type);
+}
 
-#define FANOTIFY_FAN_REPORT_FID_ERR_MSG(fail) \
-	FANOTIFY_FAN_REPORT_FID_ERR_MSG_(tst_res, (fail))
+#define FANOTIFY_INIT_FLAGS_ERR_MSG(flags, fail) \
+	fanotify_init_flags_err_msg(#flags, __FILE__, __LINE__, tst_res_, (fail))
 
-#define REQUIRE_FANOTIFY_FAN_REPORT_FID_SUPPORTED_ON_FS(fname) do { \
-	FANOTIFY_FAN_REPORT_FID_ERR_MSG_(tst_brk, \
-		fanotify_fan_report_fid_supported_on_fs(fname)); \
+#define REQUIRE_FANOTIFY_INIT_FLAGS_SUPPORTED_ON_FS(flags, fname) do { \
+	fanotify_init_flags_err_msg(#flags, __FILE__, __LINE__, tst_brk_, \
+		fanotify_init_flags_supported_on_fs(flags, fname)); \
 	} while (0)
 
 static inline int fanotify_mark_supported_by_kernel(uint64_t flag)
diff --git a/testcases/kernel/syscalls/fanotify/fanotify01.c b/testcases/kernel/syscalls/fanotify/fanotify01.c
index d6d72dad9..cdb01730f 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify01.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify01.c
@@ -90,7 +90,7 @@ static void test_fanotify(unsigned int n)
 	tst_res(TINFO, "Test #%d: %s", n, tc->tname);
 
 	if (fan_report_fid_unsupported && (tc->init_flags & FAN_REPORT_FID)) {
-		FANOTIFY_FAN_REPORT_FID_ERR_MSG(fan_report_fid_unsupported);
+		FANOTIFY_INIT_FLAGS_ERR_MSG(FAN_REPORT_FID, fan_report_fid_unsupported);
 		return;
 	}
 
@@ -334,7 +334,7 @@ static void setup(void)
 	sprintf(fname, MOUNT_PATH"/tfile_%d", getpid());
 	SAFE_FILE_PRINTF(fname, "1");
 
-	fan_report_fid_unsupported = fanotify_fan_report_fid_supported_on_fs(fname);
+	fan_report_fid_unsupported = fanotify_init_flags_supported_on_fs(FAN_REPORT_FID, fname);
 	filesystem_mark_unsupported = fanotify_mark_supported_by_kernel(FAN_MARK_FILESYSTEM);
 }
 
diff --git a/testcases/kernel/syscalls/fanotify/fanotify13.c b/testcases/kernel/syscalls/fanotify/fanotify13.c
index a402cdb13..c9cf10555 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify13.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify13.c
@@ -256,7 +256,7 @@ out:
 
 static void do_setup(void)
 {
-	REQUIRE_FANOTIFY_FAN_REPORT_FID_SUPPORTED_ON_FS(MOUNT_PATH);
+	REQUIRE_FANOTIFY_INIT_FLAGS_SUPPORTED_ON_FS(FAN_REPORT_FID, MOUNT_PATH);
 
 	filesystem_mark_unsupported = fanotify_mark_supported_by_kernel(FAN_MARK_FILESYSTEM);
 
diff --git a/testcases/kernel/syscalls/fanotify/fanotify15.c b/testcases/kernel/syscalls/fanotify/fanotify15.c
index 9e3748bc2..ba8259c7c 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify15.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify15.c
@@ -270,7 +270,7 @@ static void do_test(unsigned int number)
 static void do_setup(void)
 {
 	SAFE_MKDIR(TEST_DIR, 0755);
-	REQUIRE_FANOTIFY_FAN_REPORT_FID_SUPPORTED_ON_FS(TEST_DIR);
+	REQUIRE_FANOTIFY_INIT_FLAGS_SUPPORTED_ON_FS(FAN_REPORT_FID, TEST_DIR);
 	fanotify_fd = SAFE_FANOTIFY_INIT(FAN_REPORT_FID, O_RDONLY);
 }
 
diff --git a/testcases/kernel/syscalls/fanotify/fanotify16.c b/testcases/kernel/syscalls/fanotify/fanotify16.c
index a554c7d39..a4409df14 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify16.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify16.c
@@ -551,7 +551,7 @@ check_match:
 
 static void setup(void)
 {
-	REQUIRE_FANOTIFY_FAN_REPORT_FID_SUPPORTED_ON_FS(MOUNT_PATH);
+	REQUIRE_FANOTIFY_INIT_FLAGS_SUPPORTED_ON_FS(FAN_REPORT_FID, MOUNT_PATH);
 
 	sprintf(dname1, "%s/%s", MOUNT_PATH, DIR_NAME1);
 	sprintf(dname2, "%s/%s", MOUNT_PATH, DIR_NAME2);
-- 
2.25.1

