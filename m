From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 21 Apr 2020 09:50:01 +0300
Subject: [LTP] [PATCH 3/4] syscalls/fanotify15: Add a test case for inode
 marks
In-Reply-To: <20200421065002.12417-1-amir73il@gmail.com>
References: <20200421065002.12417-1-amir73il@gmail.com>
Message-ID: <20200421065002.12417-4-amir73il@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Test reporting events with fid also with recusrive inode marks:
- Test events "on self" (FAN_DELETE_SELF) on file and dir
- Test events "on child" (FAN_MODIFY) on file

With recursive inode marks, verify that the FAN_MODIFY event reported
to parent "on child" is merged with the FAN_MODIFY event reported to
child.

The new test case is a regression test for commit f367a62a7cad:

    fanotify: merge duplicate events on parent and child

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 .../kernel/syscalls/fanotify/fanotify15.c     | 76 +++++++++++++++++--
 1 file changed, 69 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify15.c b/testcases/kernel/syscalls/fanotify/fanotify15.c
index 454441bfe..bb1069139 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify15.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify15.c
@@ -9,6 +9,10 @@
  *	Test file that has been purposely designed to verify
  *	FAN_REPORT_FID functionality while using newly defined dirent
  *	events.
+ *
+ * Test case #1 is a regression test for commit f367a62a7cad:
+ *
+ *      fanotify: merge duplicate events on parent and child
  */
 #define _GNU_SOURCE
 #include "config.h"
@@ -53,29 +57,51 @@ static int fanotify_fd;
 static char events_buf[EVENT_BUF_LEN];
 static struct event_t event_set[EVENT_MAX];
 
-static void do_test(void)
+static struct test_case_t {
+	struct fanotify_mark_type mark;
+	unsigned long mask;
+} test_cases[] = {
+	{
+		/* Watch filesystem including events "on self" */
+		INIT_FANOTIFY_MARK_TYPE(FILESYSTEM),
+		FAN_DELETE_SELF,
+	},
+	{
+		/* Watch directory including events "on children" */
+		INIT_FANOTIFY_MARK_TYPE(INODE),
+		FAN_EVENT_ON_CHILD,
+	},
+};
+
+static void do_test(unsigned int number)
 {
 	int i, fd, len, count = 0;
 
 	struct file_handle *event_file_handle;
 	struct fanotify_event_metadata *metadata;
 	struct fanotify_event_info_fid *event_fid;
+	struct test_case_t *tc = &test_cases[number];
+	struct fanotify_mark_type *mark = &tc->mark;
 
+	tst_res(TINFO,
+		"Test #%d: FAN_REPORT_FID with mark type: %s",
+		number, mark->name);
 
-	if (fanotify_mark(fanotify_fd, FAN_MARK_ADD | FAN_MARK_FILESYSTEM,
+
+	if (fanotify_mark(fanotify_fd, FAN_MARK_ADD | mark->flag, tc->mask |
 				FAN_CREATE | FAN_DELETE | FAN_MOVE |
-				FAN_MODIFY | FAN_DELETE_SELF | FAN_ONDIR,
+				FAN_MODIFY | FAN_ONDIR,
 				AT_FDCWD, TEST_DIR) == -1) {
 		if (errno == ENODEV)
 			tst_brk(TCONF,
 				"FAN_REPORT_FID not supported on %s "
 				"filesystem", tst_device->fs_type);
 		tst_brk(TBROK | TERRNO,
-			"fanotify_mark(%d, FAN_MARK_ADD | FAN_MARK_FILESYSTEM, "
+			"fanotify_mark(%d, FAN_MARK_ADD | %s, "
 			"FAN_CREATE | FAN_DELETE | FAN_MOVE | "
-			"FAN_MODIFY | FAN_DELETE_SELF | FAN_ONDIR, "
+			"FAN_MODIFY | FAN_ONDIR, "
 			"AT_FDCWD, %s) failed",
-			fanotify_fd, TEST_DIR);
+			fanotify_fd, mark->name, TEST_DIR);
 	}
 
 	/* All dirent events on testdir are merged */
@@ -89,8 +115,21 @@ static void do_test(void)
 	fd = SAFE_CREAT(FILE1, 0644);
 	SAFE_CLOSE(fd);
 
+	/* Recursive watch file for events "on self" */
+	if (mark->flag == FAN_MARK_INODE &&
+	    fanotify_mark(fanotify_fd, FAN_MARK_ADD | mark->flag,
+			  FAN_MODIFY | FAN_DELETE_SELF,
+			  AT_FDCWD, FILE1) == -1) {
+		tst_brk(TBROK | TERRNO,
+			"fanotify_mark(%d, FAN_MARK_ADD | %s, "
+			"FAN_DELETE_SELF, AT_FDCWD, %s) failed",
+			fanotify_fd, mark->name, FILE1);
+	}
+
 	/*
 	 * Event on child file is not merged with dirent events.
+	 * FAN_MODIFY event reported on file mark should be merged with the
+	 * FAN_MODIFY event reported on parent directory watch.
 	 */
 	event_set[count].mask = FAN_MODIFY;
 	event_set[count].handle.handle_bytes = MAX_HANDLE_SZ;
@@ -131,6 +170,17 @@ static void do_test(void)
 
 	SAFE_MKDIR(DIR1, 0755);
 
+	/* Recursive watch subdir for events "on self" */
+	if (mark->flag == FAN_MARK_INODE &&
+	    fanotify_mark(fanotify_fd, FAN_MARK_ADD | mark->flag,
+			  FAN_DELETE_SELF | FAN_ONDIR,
+			  AT_FDCWD, DIR1) == -1) {
+		tst_brk(TBROK | TERRNO,
+			"fanotify_mark(%d, FAN_MARK_ADD | %s,"
+			"FAN_DELETE_SELF | FAN_ONDIR, AT_FDCWD, %s) failed",
+			fanotify_fd, mark->name, DIR1);
+	}
+
 	SAFE_RENAME(DIR1, DIR2);
 
 	event_set[count].mask = FAN_ONDIR | FAN_DELETE_SELF;
@@ -144,6 +194,17 @@ static void do_test(void)
 	/* Read dir events from the event queue */
 	len += SAFE_READ(0, fanotify_fd, events_buf + len, EVENT_BUF_LEN - len);
 
+	/*
+	 * Cleanup the mark
+	 */
+	if (fanotify_mark(fanotify_fd, FAN_MARK_FLUSH | mark->flag, 0,
+			  AT_FDCWD, TEST_DIR) < 0) {
+		tst_brk(TBROK | TERRNO,
+			"fanotify_mark (%d, FAN_MARK_FLUSH | %s, 0,"
+			"AT_FDCWD, '"TEST_DIR"') failed",
+			fanotify_fd, mark->name);
+	}
+
 	/* Process each event in buffer */
 	for (i = 0, metadata = (struct fanotify_event_metadata *) events_buf;
 		FAN_EVENT_OK(metadata, len); i++) {
@@ -262,7 +323,8 @@ static struct tst_test test = {
 	.mount_device = 1,
 	.mntpoint = MOUNT_POINT,
 	.all_filesystems = 1,
-	.test_all = do_test,
+	.test = do_test,
+	.tcnt = ARRAY_SIZE(test_cases),
 	.setup = do_setup,
 	.cleanup = do_cleanup
 };
-- 
2.17.1

