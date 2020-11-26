From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 26 Nov 2020 22:41:18 +0100
Subject: [LTP] [PATCH v4 3/6] fanotify: Check for FAN_REPORT_FID support on
 fs
In-Reply-To: <20201126214121.6836-1-pvorel@suse.cz>
References: <20201126214121.6836-1-pvorel@suse.cz>
Message-ID: <20201126214121.6836-4-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This is related to kernel fix
a8b13aa20afb ("fanotify: enable FAN_REPORT_FID init flag")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
New in v4.
Maybe it'd deserve better commit message.

There might be even more cleanup: not sure if nofid_fd in fanotify13.c
is required. According to the description is probably required:

static void do_setup(void)
{
	require_fanotify_fan_report_fid_supported_on_fs(MOUNT_PATH);

	nofid_fd = SAFE_FANOTIFY_INIT(FAN_CLASS_NOTIF, O_RDONLY);

	/* Create file and directory objects for testing */
	create_objects();

	/*
	 * Create a mark on first inode without FAN_REPORT_FID, to test
	 * uninitialized connector->fsid cache. This mark remains for all test
	 * cases and is not expected to get any events (no writes in this test).
	 */
	SAFE_FANOTIFY_MARK(nofid_fd, FAN_MARK_ADD, FAN_CLOSE_WRITE, AT_FDCWD,
			  FILE_PATH_ONE);

	/* Get the filesystem fsid and file handle for each created object */
	get_object_stats();

 testcases/kernel/syscalls/fanotify/fanotify.h | 31 +++++++++++++++++++
 .../kernel/syscalls/fanotify/fanotify01.c     |  9 +++++-
 .../kernel/syscalls/fanotify/fanotify13.c     |  4 ++-
 .../kernel/syscalls/fanotify/fanotify15.c     |  6 ++--
 .../kernel/syscalls/fanotify/fanotify16.c     |  6 +---
 5 files changed, 45 insertions(+), 11 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
index 413034336..c690b82d3 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify.h
+++ b/testcases/kernel/syscalls/fanotify/fanotify.h
@@ -283,4 +283,35 @@ static inline int fanotify_exec_events_supported_by_kernel(uint64_t mask)
 	return rval;
 }
 
+static inline int fanotify_fan_report_fid_supported_on_fs(const char *fname)
+{
+	int fd;
+	int rval = 0;
+
+	fd = SAFE_FANOTIFY_INIT(FAN_CLASS_NOTIF | FAN_REPORT_FID, O_RDONLY);
+
+	if (fanotify_mark(fd, FAN_MARK_ADD | FAN_MARK_FILESYSTEM,
+			  FAN_ACCESS | FAN_MODIFY | FAN_CLOSE | FAN_OPEN,
+			  AT_FDCWD, fname) < 0) {
+		if (errno == ENODEV || errno == EOPNOTSUPP || errno == EXDEV) {
+			rval = -1;
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
+static inline void require_fanotify_fan_report_fid_supported_on_fs(const char *fname)
+{
+	if (fanotify_fan_report_fid_supported_on_fs(fname) != 0) {
+		tst_brk(TCONF, "FAN_REPORT_FID not supported on %s filesystem",
+			tst_device->fs_type);
+	}
+}
+
 #endif /* __FANOTIFY_H__ */
diff --git a/testcases/kernel/syscalls/fanotify/fanotify01.c b/testcases/kernel/syscalls/fanotify/fanotify01.c
index 03e453f41..1e99a5dc7 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify01.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify01.c
@@ -74,6 +74,7 @@ static struct tcase {
 static char fname[BUF_SIZE];
 static char buf[BUF_SIZE];
 static int fd_notify;
+static int fan_report_fid_unsupported;
 
 static unsigned long long event_set[EVENT_MAX];
 
@@ -88,6 +89,12 @@ static void test_fanotify(unsigned int n)
 
 	tst_res(TINFO, "Test #%d: %s", n, tc->tname);
 
+	if (fan_report_fid_unsupported && (tc->init_flags & FAN_REPORT_FID)) {
+		tst_res(TCONF | TERRNO, "FAN_REPORT_FID not supported on %s filesystem",
+			tst_device->fs_type);
+		return;
+	}
+
 	fd_notify = fanotify_init(tc->init_flags, O_RDONLY);
 	if (fd_notify < 0) {
 		if (errno == EINVAL &&
@@ -363,9 +370,9 @@ static void setup(void)
 	/* Check for kernel fanotify support */
 	fd = SAFE_FANOTIFY_INIT(FAN_CLASS_NOTIF, O_RDONLY);
 	SAFE_CLOSE(fd);
-
 	sprintf(fname, MOUNT_PATH"/tfile_%d", getpid());
 	SAFE_FILE_PRINTF(fname, "1");
+	fan_report_fid_unsupported = fanotify_fan_report_fid_supported_on_fs(fname);
 }
 
 static void cleanup(void)
diff --git a/testcases/kernel/syscalls/fanotify/fanotify13.c b/testcases/kernel/syscalls/fanotify/fanotify13.c
index c2a21bb66..39caea41e 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify13.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify13.c
@@ -281,7 +281,9 @@ out:
 
 static void do_setup(void)
 {
-	/* Check for kernel fanotify support */
+
+	require_fanotify_fan_report_fid_supported_on_fs(MOUNT_PATH);
+
 	nofid_fd = SAFE_FANOTIFY_INIT(FAN_CLASS_NOTIF, O_RDONLY);
 
 	/* Create file and directory objects for testing */
diff --git a/testcases/kernel/syscalls/fanotify/fanotify15.c b/testcases/kernel/syscalls/fanotify/fanotify15.c
index d787a08e3..c3fc4f8ab 100644
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
@@ -303,6 +299,8 @@ static void do_setup(void)
 	}
 
 	SAFE_MKDIR(TEST_DIR, 0755);
+
+	require_fanotify_fan_report_fid_supported_on_fs(TEST_DIR);
 }
 
 static void do_cleanup(void)
diff --git a/testcases/kernel/syscalls/fanotify/fanotify16.c b/testcases/kernel/syscalls/fanotify/fanotify16.c
index 7995a1688..e2a1509b0 100644
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
+	require_fanotify_fan_report_fid_supported_on_fs(MOUNT_PATH);
 
 	sprintf(dname1, "%s/%s", MOUNT_PATH, DIR_NAME1);
 	sprintf(dname2, "%s/%s", MOUNT_PATH, DIR_NAME2);
-- 
2.29.2

