From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 16 Nov 2018 08:51:15 +0200
Subject: [LTP] [PATCH 1/5] syscalls/fanotify01: check events also on
	mountpoint mark
In-Reply-To: <20181116065119.6912-1-amir73il@gmail.com>
References: <20181116065119.6912-1-amir73il@gmail.com>
Message-ID: <20181116065119.6912-2-amir73il@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add index to test and repeat it for mark types inode and mountpoint.
Move fanotify_init() into the test to simplify setup/cleanup.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 .../kernel/syscalls/fanotify/fanotify01.c     | 83 ++++++++++++-------
 1 file changed, 51 insertions(+), 32 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify01.c b/testcases/kernel/syscalls/fanotify/fanotify01.c
index e1210134b..5dfb67b61 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify01.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify01.c
@@ -32,26 +32,46 @@
 #define BUF_SIZE 256
 #define TST_TOTAL 12
 
+static struct tcase {
+	const char *tname;
+	struct fanotify_mark_type mark;
+} tcases[] = {
+	{
+		"inode mark events",
+		INIT_FANOTIFY_MARK_TYPE(INODE),
+	},
+	{
+		"mount mark events",
+		INIT_FANOTIFY_MARK_TYPE(MOUNT),
+	},
+};
+
 static char fname[BUF_SIZE];
 static char buf[BUF_SIZE];
-static int fd, fd_notify;
+static int fd_notify;
 
 static unsigned long long event_set[EVENT_MAX];
 
 static char event_buf[EVENT_BUF_LEN];
 
-void test01(void)
+static void test_fanotify(unsigned int n)
 {
-	int ret, len, i = 0, test_num = 0;
-
+	struct tcase *tc = &tcases[n];
+	struct fanotify_mark_type *mark = &tc->mark;
+	int fd, ret, len, i = 0, test_num = 0;
 	int tst_count = 0;
 
-	if (fanotify_mark(fd_notify, FAN_MARK_ADD, FAN_ACCESS | FAN_MODIFY |
-			    FAN_CLOSE | FAN_OPEN, AT_FDCWD, fname) < 0) {
+	tst_res(TINFO, "Test #%d: %s", n, tc->tname);
+
+	fd_notify = SAFE_FANOTIFY_INIT(FAN_CLASS_NOTIF, O_RDONLY);
+
+	if (fanotify_mark(fd_notify, FAN_MARK_ADD | mark->flag,
+			  FAN_ACCESS | FAN_MODIFY | FAN_CLOSE | FAN_OPEN,
+			  AT_FDCWD, fname) < 0) {
 		tst_brk(TBROK | TERRNO,
-			"fanotify_mark (%d, FAN_MARK_ADD, FAN_ACCESS | "
+			"fanotify_mark (%d, FAN_MARK_ADD, FAN_ACCESS | %s | "
 			"FAN_MODIFY | FAN_CLOSE | FAN_OPEN, AT_FDCWD, %s) "
-			"failed", fd_notify, fname);
+			"failed", fd_notify, mark->name, fname);
 	}
 
 	/*
@@ -101,12 +121,12 @@ void test01(void)
 
 	/* Ignore access events */
 	if (fanotify_mark(fd_notify,
-			  FAN_MARK_ADD | FAN_MARK_IGNORED_MASK,
+			  FAN_MARK_ADD | mark->flag | FAN_MARK_IGNORED_MASK,
 			  FAN_ACCESS, AT_FDCWD, fname) < 0) {
 		tst_brk(TBROK | TERRNO,
-			"fanotify_mark (%d, FAN_MARK_ADD | "
-			"FAN_MARK_IGNORED_MASK, FAN_ACCESS, "
-			"AT_FDCWD, %s) failed", fd_notify, fname);
+			"fanotify_mark (%d, FAN_MARK_ADD | %s | "
+			"FAN_MARK_IGNORED_MASK, FAN_ACCESS, AT_FDCWD, %s) "
+			"failed", fd_notify, mark->name, fname);
 	}
 
 	fd = SAFE_OPEN(fname, O_RDWR);
@@ -150,15 +170,14 @@ void test01(void)
 	 * Now ignore open & close events regardless of file
 	 * modifications
 	 */
-	if (fanotify_mark(fd_notify,
-			    FAN_MARK_ADD | FAN_MARK_IGNORED_MASK | FAN_MARK_IGNORED_SURV_MODIFY,
-			    FAN_OPEN | FAN_CLOSE, AT_FDCWD, fname) < 0) {
+	if (fanotify_mark(fd_notify, FAN_MARK_ADD | mark->flag |
+			  FAN_MARK_IGNORED_MASK | FAN_MARK_IGNORED_SURV_MODIFY,
+			  FAN_OPEN | FAN_CLOSE, AT_FDCWD, fname) < 0) {
 		tst_brk(TBROK | TERRNO,
-			"fanotify_mark (%d, FAN_MARK_ADD | "
-			"FAN_MARK_IGNORED_MASK | "
-			"FAN_MARK_IGNORED_SURV_MODIFY, FAN_OPEN | "
-			"FAN_CLOSE, AT_FDCWD, %s) failed", fd_notify,
-			fname);
+			"fanotify_mark (%d, FAN_MARK_ADD | %s | "
+			"FAN_MARK_IGNORED_MASK | FAN_MARK_IGNORED_SURV_MODIFY, "
+			"FAN_OPEN | FAN_CLOSE, AT_FDCWD, %s) failed",
+			fd_notify, mark->name, fname);
 	}
 
 	/* This event should be ignored */
@@ -181,13 +200,13 @@ void test01(void)
 
 	/* Now remove open and close from ignored mask */
 	if (fanotify_mark(fd_notify,
-			  FAN_MARK_REMOVE | FAN_MARK_IGNORED_MASK,
+			  FAN_MARK_REMOVE | mark->flag | FAN_MARK_IGNORED_MASK,
 			  FAN_OPEN | FAN_CLOSE, AT_FDCWD, fname) < 0) {
 		tst_brk(TBROK | TERRNO,
-			"fanotify_mark (%d, FAN_MARK_REMOVE | "
-			"FAN_MARK_IGNORED_MASK, FAN_OPEN | "
-			"FAN_CLOSE, AT_FDCWD, %s) failed", fd_notify,
-			fname);
+			"fanotify_mark (%d, FAN_MARK_REMOVE | %s | "
+			"FAN_MARK_IGNORED_MASK, FAN_OPEN | FAN_CLOSE, "
+			"AT_FDCWD, %s) failed", fd_notify,
+			mark->name, fname);
 	}
 
 	SAFE_CLOSE(fd);
@@ -283,12 +302,13 @@ pass:
 
 	}
 	/* Remove mark to clear FAN_MARK_IGNORED_SURV_MODIFY */
-	if (fanotify_mark(fd_notify, FAN_MARK_REMOVE, FAN_ACCESS | FAN_MODIFY |
-			    FAN_CLOSE | FAN_OPEN, AT_FDCWD, fname) < 0) {
+	if (fanotify_mark(fd_notify, FAN_MARK_REMOVE | mark->flag,
+			  FAN_ACCESS | FAN_MODIFY | FAN_CLOSE | FAN_OPEN,
+			  AT_FDCWD, fname) < 0) {
 		tst_brk(TBROK | TERRNO,
-			"fanotify_mark (%d, FAN_MARK_REMOVE, FAN_ACCESS | "
+			"fanotify_mark (%d, FAN_MARK_REMOVE | %s, FAN_ACCESS | "
 			"FAN_MODIFY | FAN_CLOSE | FAN_OPEN, AT_FDCWD, %s) "
-			"failed", fd_notify, fname);
+			"failed", fd_notify, mark->name, fname);
 	}
 }
 
@@ -296,8 +316,6 @@ static void setup(void)
 {
 	sprintf(fname, "tfile_%d", getpid());
 	SAFE_FILE_PRINTF(fname, "1");
-
-	fd_notify = SAFE_FANOTIFY_INIT(FAN_CLASS_NOTIF, O_RDONLY);
 }
 
 static void cleanup(void)
@@ -307,7 +325,8 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
-	.test_all = test01,
+	.test = test_fanotify,
+	.tcnt = ARRAY_SIZE(tcases),
 	.setup = setup,
 	.cleanup = cleanup,
 	.needs_tmpdir = 1,
-- 
2.17.1

