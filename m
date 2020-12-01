From: Petr Vorel <pvorel@suse.cz>
Date: Tue,  1 Dec 2020 18:42:10 +0100
Subject: [LTP] [PATCH v5 06/10] fanotify: Add helper for mark support check
In-Reply-To: <20201201174214.24625-1-pvorel@suse.cz>
References: <20201201174214.24625-1-pvorel@suse.cz>
Message-ID: <20201201174214.24625-7-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

i.e. FAN_MARK_FILESYSTEM and use it in relevant tests setup().
The purpose is to reduce checks (cleanup).

NOTE: all tests check only for FAN_MARK_FILESYSTEM, but keep helper
generic for future use.

Suggested-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
New in v5.

 testcases/kernel/syscalls/fanotify/fanotify.h | 21 ++++++++++++++++
 .../kernel/syscalls/fanotify/fanotify01.c     | 12 +++++----
 .../kernel/syscalls/fanotify/fanotify03.c     | 25 +++++++++----------
 .../kernel/syscalls/fanotify/fanotify10.c     | 14 +++++------
 .../kernel/syscalls/fanotify/fanotify13.c     | 15 +++++------
 5 files changed, 55 insertions(+), 32 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
index 821e6cb29..2275a1da3 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify.h
+++ b/testcases/kernel/syscalls/fanotify/fanotify.h
@@ -351,4 +351,25 @@ static inline void require_fanotify_fan_report_fid_supported_on_fs(const char *f
 #define REQUIRE_FANOTIFY_FAN_REPORT_FID_SUPPORTED_ON_FS(fname) \
 	require_fanotify_fan_report_fid_supported_on_fs(__FILE__, __LINE__, (fname))
 
+static inline int fanotify_mark_supported_by_kernel(uint64_t flag)
+{
+	int fd;
+	int rval = 0;
+
+	fd = SAFE_FANOTIFY_INIT(FAN_CLASS_CONTENT, O_RDONLY);
+
+	if (fanotify_mark(fd, FAN_MARK_ADD | flag, FAN_ACCESS_PERM, AT_FDCWD, ".") < 0) {
+		if (errno == EINVAL) {
+			rval = -1;
+		} else {
+			tst_brk(TBROK | TERRNO,
+				"fanotify_mark (%d, FAN_MARK_ADD, ..., FAN_ACCESS_PERM, AT_FDCWD, \".\") failed", fd);
+		}
+	}
+
+	SAFE_CLOSE(fd);
+
+	return rval;
+}
+
 #endif /* __FANOTIFY_H__ */
diff --git a/testcases/kernel/syscalls/fanotify/fanotify01.c b/testcases/kernel/syscalls/fanotify/fanotify01.c
index 5f2544931..c8ab41695 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify01.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify01.c
@@ -75,6 +75,7 @@ static char fname[BUF_SIZE];
 static char buf[BUF_SIZE];
 static int fd_notify;
 static int fan_report_fid_unsupported;
+static int filesystem_mark_unsupported;
 
 static unsigned long long event_set[EVENT_MAX];
 
@@ -94,16 +95,16 @@ static void test_fanotify(unsigned int n)
 		return;
 	}
 
+	if (filesystem_mark_unsupported && mark->flag == FAN_MARK_FILESYSTEM) {
+		tst_res(TCONF, "FAN_MARK_FILESYSTEM not supported in kernel?");
+		return;
+	}
+
 	fd_notify = SAFE_FANOTIFY_INIT(tc->init_flags, O_RDONLY);
 
 	if (fanotify_mark(fd_notify, FAN_MARK_ADD | mark->flag,
 			  FAN_ACCESS | FAN_MODIFY | FAN_CLOSE | FAN_OPEN,
 			  AT_FDCWD, fname) < 0) {
-		if (errno == EINVAL && mark->flag == FAN_MARK_FILESYSTEM) {
-			tst_res(TCONF,
-				"FAN_MARK_FILESYSTEM not supported in kernel?");
-			return;
-		}
 		tst_brk(TBROK | TERRNO,
 			"fanotify_mark (%d, FAN_MARK_ADD, FAN_ACCESS | %s | "
 			"FAN_MODIFY | FAN_CLOSE | FAN_OPEN, AT_FDCWD, %s) "
@@ -363,6 +364,7 @@ static void setup(void)
 	SAFE_FILE_PRINTF(fname, "1");
 
 	fan_report_fid_unsupported = fanotify_fan_report_fid_supported_on_fs(fname);
+	filesystem_mark_unsupported = fanotify_mark_supported_by_kernel(FAN_MARK_FILESYSTEM);
 }
 
 static void cleanup(void)
diff --git a/testcases/kernel/syscalls/fanotify/fanotify03.c b/testcases/kernel/syscalls/fanotify/fanotify03.c
index 75e5b852d..8b54e42c4 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify03.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify03.c
@@ -49,6 +49,7 @@ static pid_t child_pid;
 
 static char event_buf[EVENT_BUF_LEN];
 static int exec_events_unsupported;
+static int filesystem_mark_unsupported;
 
 struct event {
 	unsigned long long mask;
@@ -213,24 +214,21 @@ static int setup_mark(unsigned int n)
 		return -1;
 	}
 
+	if (filesystem_mark_unsupported && mark->flag == FAN_MARK_FILESYSTEM) {
+		tst_res(TCONF, "FAN_MARK_FILESYSTEM not supported in kernel?");
+		return -1;
+	}
+
 	fd_notify = SAFE_FANOTIFY_INIT(FAN_CLASS_CONTENT, O_RDONLY);
 
 	for (; i < ARRAY_SIZE(files); i++) {
 		if (fanotify_mark(fd_notify, FAN_MARK_ADD | mark->flag,
 				  tc->mask, AT_FDCWD, files[i]) < 0) {
-			if (errno == EINVAL &&
-					mark->flag == FAN_MARK_FILESYSTEM) {
-				tst_res(TCONF,
-					"FAN_MARK_FILESYSTEM not supported in "
-					"kernel?");
-				return -1;
-			} else {
-				tst_brk(TBROK | TERRNO,
-					"fanotify_mark(%d, FAN_MARK_ADD | %s, "
-					"FAN_ACCESS_PERM | FAN_OPEN_PERM, "
-					"AT_FDCWD, %s) failed.",
-					fd_notify, mark->name, fname);
-			}
+			tst_brk(TBROK | TERRNO,
+				"fanotify_mark(%d, FAN_MARK_ADD | %s, "
+				"FAN_ACCESS_PERM | FAN_OPEN_PERM, "
+				"AT_FDCWD, %s) failed.",
+				fd_notify, mark->name, fname);
 		}
 	}
 
@@ -331,6 +329,7 @@ static void setup(void)
 {
 	require_fanotify_access_permissions_supported_by_kernel();
 
+	filesystem_mark_unsupported = fanotify_mark_supported_by_kernel(FAN_MARK_FILESYSTEM);
 	exec_events_unsupported = fanotify_events_supported_by_kernel(FAN_OPEN_EXEC_PERM);
 
 	sprintf(fname, MOUNT_PATH"/fname_%d", getpid());
diff --git a/testcases/kernel/syscalls/fanotify/fanotify10.c b/testcases/kernel/syscalls/fanotify/fanotify10.c
index 73702285c..6d048958c 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify10.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify10.c
@@ -65,6 +65,7 @@ static int fd_notify[NUM_CLASSES][GROUPS_PER_PRIO];
 
 static char event_buf[EVENT_BUF_LEN];
 static int exec_events_unsupported;
+static int filesystem_mark_unsupported;
 
 #define MOUNT_PATH "fs_mnt"
 #define MNT2_PATH "mntpoint"
@@ -323,13 +324,6 @@ static int create_fanotify_groups(unsigned int n)
 					    FAN_EVENT_ON_CHILD,
 					    AT_FDCWD, tc->mark_path);
 			if (ret < 0) {
-				if (errno == EINVAL &&
-					tc->mark_type == FANOTIFY_FILESYSTEM) {
-					tst_res(TCONF,
-						"FAN_MARK_FILESYSTEM not "
-						"supported in kernel?");
-					return -1;
-				}
 				tst_brk(TBROK | TERRNO,
 					"fanotify_mark(%d, FAN_MARK_ADD | %s,"
 					"FAN_OPEN, AT_FDCWD, %s) failed",
@@ -450,6 +444,11 @@ static void test_fanotify(unsigned int n)
 		return;
 	}
 
+	if (filesystem_mark_unsupported && tc->mark_type == FANOTIFY_FILESYSTEM) {
+		tst_res(TCONF, "FAN_MARK_FILESYSTEM not supported in kernel?");
+		return;
+	}
+
 	if (tc->ignored_onchild && tst_kvercmp(5, 9, 0) < 0) {
 		tst_res(TCONF, "ignored mask in combination with flag FAN_EVENT_ON_CHILD"
 				" has undefined behavior on kernel < 5.9");
@@ -535,6 +534,7 @@ cleanup:
 static void setup(void)
 {
 	exec_events_unsupported = fanotify_events_supported_by_kernel(FAN_OPEN_EXEC);
+	filesystem_mark_unsupported = fanotify_mark_supported_by_kernel(FAN_MARK_FILESYSTEM);
 
 	/* Create another bind mount@another path for generating events */
 	SAFE_MKDIR(MNT2_PATH, 0755);
diff --git a/testcases/kernel/syscalls/fanotify/fanotify13.c b/testcases/kernel/syscalls/fanotify/fanotify13.c
index 81fe02db2..33989d902 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify13.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify13.c
@@ -88,6 +88,7 @@ static struct test_case_t {
 
 static int nofid_fd;
 static int fanotify_fd;
+static int filesystem_mark_unsupported;
 static char events_buf[BUF_SIZE];
 static struct event_t event_set[EVENT_MAX];
 
@@ -118,13 +119,6 @@ static int setup_marks(unsigned int fd, struct test_case_t *tc)
 	for (i = 0; i < ARRAY_SIZE(objects); i++) {
 		if (fanotify_mark(fd, FAN_MARK_ADD | mark->flag, tc->mask,
 					AT_FDCWD, objects[i].path) == -1) {
-			if (errno == EINVAL &&
-				mark->flag & FAN_MARK_FILESYSTEM) {
-				tst_res(TCONF,
-					"FAN_MARK_FILESYSTEM not supported by "
-					"kernel");
-				return 1;
-			}
 			tst_brk(TBROK | TERRNO,
 				"fanotify_mark(%d, FAN_MARK_ADD, FAN_OPEN, "
 				"AT_FDCWD, %s) failed",
@@ -154,6 +148,11 @@ static void do_test(unsigned int number)
 		"Test #%d: FAN_REPORT_FID with mark flag: %s",
 		number, mark->name);
 
+	if (filesystem_mark_unsupported && mark->flag & FAN_MARK_FILESYSTEM) {
+		tst_res(TCONF, "FAN_MARK_FILESYSTEM not supported in kernel?");
+		return;
+	}
+
 	fanotify_fd = SAFE_FANOTIFY_INIT(FAN_CLASS_NOTIF | FAN_REPORT_FID, O_RDONLY);
 
 	/*
@@ -265,6 +264,8 @@ static void do_setup(void)
 {
 	REQUIRE_FANOTIFY_FAN_REPORT_FID_SUPPORTED_ON_FS(MOUNT_PATH);
 
+	filesystem_mark_unsupported = fanotify_mark_supported_by_kernel(FAN_MARK_FILESYSTEM);
+
 	nofid_fd = SAFE_FANOTIFY_INIT(FAN_CLASS_NOTIF, O_RDONLY);
 
 	/* Create file and directory objects for testing */
-- 
2.29.2

