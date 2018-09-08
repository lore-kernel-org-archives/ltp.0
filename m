From: Amir Goldstein <amir73il@gmail.com>
Date: Sat,  8 Sep 2018 17:24:52 +0300
Subject: [LTP] [PATCH] syscalls/fanotify: misc cleanups
Message-ID: <20180908142453.21532-1-amir73il@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

* Cleanup backup file descriptor in fanotify03

* Fix whitespace and indentation

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Hi Cyril,

I am working on some tests for a new fanotify feature, so went on
a cleaning spree before forking some tests.

Thanks,
Amir.

 .../kernel/syscalls/fanotify/fanotify01.c     | 118 +++++++++---------
 .../kernel/syscalls/fanotify/fanotify02.c     |  61 +++++----
 .../kernel/syscalls/fanotify/fanotify03.c     |  56 +++++----
 .../kernel/syscalls/fanotify/fanotify04.c     |  54 ++++----
 .../kernel/syscalls/fanotify/fanotify05.c     |  38 +++---
 .../kernel/syscalls/fanotify/fanotify06.c     |  58 ++++-----
 .../kernel/syscalls/fanotify/fanotify09.c     |  46 +++----
 7 files changed, 216 insertions(+), 215 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify01.c b/testcases/kernel/syscalls/fanotify/fanotify01.c
index ce08f3a58..cee9b34ea 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify01.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify01.c
@@ -65,11 +65,11 @@ void test01(void)
 	int tst_count = 0;
 
 	if (fanotify_mark(fd_notify, FAN_MARK_ADD, FAN_ACCESS | FAN_MODIFY |
-			    FAN_CLOSE | FAN_OPEN, AT_FDCWD, fname) < 0) {
+			  FAN_CLOSE | FAN_OPEN, AT_FDCWD, fname) < 0) {
 		tst_brk(TBROK | TERRNO,
-		    "fanotify_mark (%d, FAN_MARK_ADD, FAN_ACCESS | "
-		    "FAN_MODIFY | FAN_CLOSE | FAN_OPEN, AT_FDCWD, %s) "
-		    "failed", fd_notify, fname);
+			"fanotify_mark (%d, FAN_MARK_ADD, FAN_ACCESS | "
+			"FAN_MODIFY | FAN_CLOSE | FAN_OPEN, AT_FDCWD, %s) "
+			"failed", fd_notify, fname);
 	}
 
 	/*
@@ -119,12 +119,12 @@ void test01(void)
 
 	/* Ignore access events */
 	if (fanotify_mark(fd_notify,
-			    FAN_MARK_ADD | FAN_MARK_IGNORED_MASK,
-			    FAN_ACCESS, AT_FDCWD, fname) < 0) {
+			  FAN_MARK_ADD | FAN_MARK_IGNORED_MASK,
+			  FAN_ACCESS, AT_FDCWD, fname) < 0) {
 		tst_brk(TBROK | TERRNO,
-		     "fanotify_mark (%d, FAN_MARK_ADD | "
-		     "FAN_MARK_IGNORED_MASK, FAN_ACCESS, "
-		     "AT_FDCWD, %s) failed", fd_notify, fname);
+			"fanotify_mark (%d, FAN_MARK_ADD | "
+			"FAN_MARK_IGNORED_MASK, FAN_ACCESS, "
+			"AT_FDCWD, %s) failed", fd_notify, fname);
 	}
 
 	fd = SAFE_OPEN(fname, O_RDWR);
@@ -168,15 +168,15 @@ void test01(void)
 	 * Now ignore open & close events regardless of file
 	 * modifications
 	 */
-	if (fanotify_mark(fd_notify,
-			    FAN_MARK_ADD | FAN_MARK_IGNORED_MASK | FAN_MARK_IGNORED_SURV_MODIFY,
-			    FAN_OPEN | FAN_CLOSE, AT_FDCWD, fname) < 0) {
+	if (fanotify_mark(fd_notify, FAN_MARK_ADD |
+			  FAN_MARK_IGNORED_MASK | FAN_MARK_IGNORED_SURV_MODIFY,
+			  FAN_OPEN | FAN_CLOSE, AT_FDCWD, fname) < 0) {
 		tst_brk(TBROK | TERRNO,
-		     "fanotify_mark (%d, FAN_MARK_ADD | "
-		     "FAN_MARK_IGNORED_MASK | "
-		     "FAN_MARK_IGNORED_SURV_MODIFY, FAN_OPEN | "
-		     "FAN_CLOSE, AT_FDCWD, %s) failed", fd_notify,
-		     fname);
+			"fanotify_mark (%d, FAN_MARK_ADD | "
+			"FAN_MARK_IGNORED_MASK | "
+			"FAN_MARK_IGNORED_SURV_MODIFY, FAN_OPEN | "
+			"FAN_CLOSE, AT_FDCWD, %s) failed", fd_notify,
+			fname);
 	}
 
 	/* This event should be ignored */
@@ -199,13 +199,13 @@ void test01(void)
 
 	/* Now remove open and close from ignored mask */
 	if (fanotify_mark(fd_notify,
-			    FAN_MARK_REMOVE | FAN_MARK_IGNORED_MASK,
-			    FAN_OPEN | FAN_CLOSE, AT_FDCWD, fname) < 0) {
+			  FAN_MARK_REMOVE | FAN_MARK_IGNORED_MASK,
+			  FAN_OPEN | FAN_CLOSE, AT_FDCWD, fname) < 0) {
 		tst_brk(TBROK | TERRNO,
-		     "fanotify_mark (%d, FAN_MARK_REMOVE | "
-		     "FAN_MARK_IGNORED_MASK, FAN_OPEN | "
-		     "FAN_CLOSE, AT_FDCWD, %s) failed", fd_notify,
-		     fname);
+			"fanotify_mark (%d, FAN_MARK_REMOVE | "
+			"FAN_MARK_IGNORED_MASK, FAN_OPEN | "
+			"FAN_CLOSE, AT_FDCWD, %s) failed", fd_notify,
+			fname);
 	}
 
 	SAFE_CLOSE(fd);
@@ -219,8 +219,8 @@ void test01(void)
 
 	if (TST_TOTAL != tst_count) {
 		tst_brk(TBROK,
-			 "TST_TOTAL (%d) and tst_count (%d) are not "
-			 "equal", TST_TOTAL, tst_count);
+			"TST_TOTAL (%d) and tst_count (%d) are not "
+			"equal", TST_TOTAL, tst_count);
 	}
 	tst_count = 0;
 
@@ -233,51 +233,51 @@ void test01(void)
 		event = (struct fanotify_event_metadata *)&event_buf[i];
 		if (test_num >= TST_TOTAL) {
 			tst_res(TFAIL,
-				 "get unnecessary event: mask=%llx "
-				 "pid=%u fd=%u",
-				 (unsigned long long)event->mask,
-				 (unsigned)event->pid, event->fd);
+				"get unnecessary event: mask=%llx "
+				"pid=%u fd=%u",
+				(unsigned long long)event->mask,
+				(unsigned)event->pid, event->fd);
 		} else if (!(event->mask & event_set[test_num])) {
 			tst_res(TFAIL,
-				 "get event: mask=%llx (expected %llx) "
-				 "pid=%u fd=%u",
-				 (unsigned long long)event->mask,
-				 event_set[test_num],
-				 (unsigned)event->pid, event->fd);
+				"get event: mask=%llx (expected %llx) "
+				"pid=%u fd=%u",
+				(unsigned long long)event->mask,
+				event_set[test_num],
+				(unsigned)event->pid, event->fd);
 		} else if (event->pid != getpid()) {
 			tst_res(TFAIL,
-				 "get event: mask=%llx pid=%u "
-				 "(expected %u) fd=%u",
-				 (unsigned long long)event->mask,
-				 (unsigned)event->pid,
-				 (unsigned)getpid(),
-				 event->fd);
+				"get event: mask=%llx pid=%u "
+				"(expected %u) fd=%u",
+				(unsigned long long)event->mask,
+				(unsigned)event->pid,
+				(unsigned)getpid(),
+				event->fd);
 		} else {
 			if (event->fd == -2)
 				goto pass;
 			ret = read(event->fd, buf, BUF_SIZE);
 			if (ret != (int)strlen(fname)) {
 				tst_res(TFAIL,
-					 "cannot read from returned fd "
-					 "of event: mask=%llx pid=%u "
-					 "fd=%u ret=%d (errno=%d)",
-					 (unsigned long long)event->mask,
-					 (unsigned)event->pid,
-					 event->fd, ret, errno);
+					"cannot read from returned fd "
+					"of event: mask=%llx pid=%u "
+					"fd=%u ret=%d (errno=%d)",
+					(unsigned long long)event->mask,
+					(unsigned)event->pid,
+					event->fd, ret, errno);
 			} else if (memcmp(buf, fname, strlen(fname))) {
 				tst_res(TFAIL,
-					 "wrong data read from returned fd "
-					 "of event: mask=%llx pid=%u "
-					 "fd=%u",
-					 (unsigned long long)event->mask,
-					 (unsigned)event->pid,
-					 event->fd);
+					"wrong data read from returned fd "
+					"of event: mask=%llx pid=%u "
+					"fd=%u",
+					(unsigned long long)event->mask,
+					(unsigned)event->pid,
+					event->fd);
 			} else {
 pass:
 				tst_res(TPASS,
-				    "get event: mask=%llx pid=%u fd=%u",
-				    (unsigned long long)event->mask,
-				    (unsigned)event->pid, event->fd);
+					"get event: mask=%llx pid=%u fd=%u",
+					(unsigned long long)event->mask,
+					(unsigned)event->pid, event->fd);
 			}
 		}
 		/*
@@ -297,16 +297,16 @@ pass:
 	}
 	for (; test_num < TST_TOTAL; test_num++) {
 		tst_res(TFAIL, "didn't get event: mask=%llx",
-			 event_set[test_num]);
+			event_set[test_num]);
 
 	}
 	/* Remove mark to clear FAN_MARK_IGNORED_SURV_MODIFY */
 	if (fanotify_mark(fd_notify, FAN_MARK_REMOVE, FAN_ACCESS | FAN_MODIFY |
 			    FAN_CLOSE | FAN_OPEN, AT_FDCWD, fname) < 0) {
 		tst_brk(TBROK | TERRNO,
-		    "fanotify_mark (%d, FAN_MARK_REMOVE, FAN_ACCESS | "
-		    "FAN_MODIFY | FAN_CLOSE | FAN_OPEN, AT_FDCWD, %s) "
-		    "failed", fd_notify, fname);
+			"fanotify_mark (%d, FAN_MARK_REMOVE, FAN_ACCESS | "
+			"FAN_MODIFY | FAN_CLOSE | FAN_OPEN, AT_FDCWD, %s) "
+			"failed", fd_notify, fname);
 	}
 }
 
diff --git a/testcases/kernel/syscalls/fanotify/fanotify02.c b/testcases/kernel/syscalls/fanotify/fanotify02.c
index 215e33b9d..3c232739a 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify02.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify02.c
@@ -65,14 +65,14 @@ void test01(void)
 	int tst_count = 0;
 
 	if (fanotify_mark(fd_notify, FAN_MARK_ADD, FAN_ACCESS |
-			    FAN_MODIFY | FAN_CLOSE | FAN_OPEN |
-			    FAN_EVENT_ON_CHILD | FAN_ONDIR, AT_FDCWD,
+			  FAN_MODIFY | FAN_CLOSE | FAN_OPEN |
+			  FAN_EVENT_ON_CHILD | FAN_ONDIR, AT_FDCWD,
 			  ".") < 0) {
 		tst_brk(TBROK | TERRNO,
-		    "fanotify_mark (%d, FAN_MARK_ADD, FAN_ACCESS | "
-		    "FAN_MODIFY | FAN_CLOSE | FAN_OPEN | "
-		    "FAN_EVENT_ON_CHILD | FAN_ONDIR, AT_FDCWD, '.') "
-		    "failed", fd_notify);
+			"fanotify_mark (%d, FAN_MARK_ADD, FAN_ACCESS | "
+			"FAN_MODIFY | FAN_CLOSE | FAN_OPEN | "
+			"FAN_EVENT_ON_CHILD | FAN_ONDIR, AT_FDCWD, '.') "
+			"failed", fd_notify);
 	}
 
 	/*
@@ -121,11 +121,11 @@ void test01(void)
 	 * now remove child mark
 	 */
 	if (fanotify_mark(fd_notify, FAN_MARK_REMOVE,
-			    FAN_EVENT_ON_CHILD, AT_FDCWD, ".") < 0) {
+			  FAN_EVENT_ON_CHILD, AT_FDCWD, ".") < 0) {
 		tst_brk(TBROK | TERRNO,
-		    "fanotify_mark (%d, FAN_MARK REMOVE, "
-		    "FAN_EVENT_ON_CHILD, AT_FDCWD, '.') failed",
-		    fd_notify);
+			"fanotify_mark (%d, FAN_MARK REMOVE, "
+			"FAN_EVENT_ON_CHILD, AT_FDCWD, '.') failed",
+			fd_notify);
 	}
 
 	/*
@@ -151,8 +151,7 @@ void test01(void)
 	len += ret;
 
 	if (TST_TOTAL != tst_count) {
-		tst_brk(TBROK,
-			 "TST_TOTAL and tst_count are not equal");
+		tst_brk(TBROK, "TST_TOTAL and tst_count are not equal");
 	}
 	tst_count = 0;
 
@@ -165,30 +164,30 @@ void test01(void)
 		event = (struct fanotify_event_metadata *)&event_buf[i];
 		if (test_num >= TST_TOTAL) {
 			tst_res(TFAIL,
-				 "get unnecessary event: mask=%llx "
-				 "pid=%u fd=%u",
-				 (unsigned long long)event->mask,
-				 (unsigned)event->pid, event->fd);
+				"get unnecessary event: mask=%llx "
+				"pid=%u fd=%u",
+				(unsigned long long)event->mask,
+				(unsigned)event->pid, event->fd);
 		} else if (!(event->mask & event_set[test_num])) {
 			tst_res(TFAIL,
-				 "get event: mask=%llx (expected %llx) "
-				 "pid=%u fd=%u",
-				 (unsigned long long)event->mask,
-				 event_set[test_num],
-				 (unsigned)event->pid, event->fd);
+				"get event: mask=%llx (expected %llx) "
+				"pid=%u fd=%u",
+				(unsigned long long)event->mask,
+				event_set[test_num],
+				(unsigned)event->pid, event->fd);
 		} else if (event->pid != getpid()) {
 			tst_res(TFAIL,
-				 "get event: mask=%llx pid=%u "
-				 "(expected %u) fd=%u",
-				 (unsigned long long)event->mask,
-				 (unsigned)event->pid,
-				 (unsigned)getpid(),
-				 event->fd);
+				"get event: mask=%llx pid=%u "
+				"(expected %u) fd=%u",
+				(unsigned long long)event->mask,
+				(unsigned)event->pid,
+				(unsigned)getpid(),
+				event->fd);
 		} else {
 			tst_res(TPASS,
-				    "get event: mask=%llx pid=%u fd=%u",
-				    (unsigned long long)event->mask,
-				    (unsigned)event->pid, event->fd);
+				"get event: mask=%llx pid=%u fd=%u",
+				(unsigned long long)event->mask,
+				(unsigned)event->pid, event->fd);
 		}
 		event->mask &= ~event_set[test_num];
 		/* No events left in current mask? Go for next event */
@@ -201,7 +200,7 @@ void test01(void)
 	}
 	for (; test_num < TST_TOTAL; test_num++) {
 		tst_res(TFAIL, "didn't get event: mask=%llx",
-			 event_set[test_num]);
+			event_set[test_num]);
 
 	}
 }
diff --git a/testcases/kernel/syscalls/fanotify/fanotify03.c b/testcases/kernel/syscalls/fanotify/fanotify03.c
index 83cd26640..a37fb750b 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify03.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify03.c
@@ -57,6 +57,7 @@
 static char fname[BUF_SIZE];
 static char buf[BUF_SIZE];
 static volatile int fd_notify;
+static int fd_notify_backup = -1;
 
 static pid_t child_pid;
 
@@ -106,7 +107,7 @@ static void run_child(void)
 
 	if (sigaction(SIGCHLD, &child_action, NULL) < 0) {
 		tst_brk(TBROK | TERRNO,
-			 "sigaction(SIGCHLD, &child_action, NULL) failed");
+			"sigaction(SIGCHLD, &child_action, NULL) failed");
 	}
 
 	child_pid = SAFE_FORK();
@@ -128,7 +129,7 @@ static void check_child(void)
 	child_action.sa_flags = SA_NOCLDSTOP;
 	if (sigaction(SIGCHLD, &child_action, NULL) < 0) {
 		tst_brk(TBROK | TERRNO,
-			 "sigaction(SIGCHLD, &child_action, NULL) failed");
+			"sigaction(SIGCHLD, &child_action, NULL) failed");
 	}
 	SAFE_WAITPID(-1, &child_ret, 0);
 
@@ -140,7 +141,7 @@ static void check_child(void)
 
 void test01(void)
 {
-	int tst_count, fd_notify_backup = -1;
+	int tst_count;
 
 	int ret, len = 0, i = 0, test_num = 0;
 
@@ -158,8 +159,7 @@ void test01(void)
 
 	/* tst_count + 1 is for checking child return value */
 	if (TST_TOTAL != tst_count + 1) {
-		tst_brk(TBROK,
-			 "TST_TOTAL and tst_count do not match");
+		tst_brk(TBROK, "TST_TOTAL and tst_count do not match");
 	}
 	tst_count = 0;
 
@@ -177,8 +177,8 @@ void test01(void)
 				break;
 			if (ret < 0) {
 				tst_brk(TBROK,
-					 "read(%d, buf, %zu) failed",
-					 fd_notify, EVENT_BUF_LEN);
+					"read(%d, buf, %zu) failed",
+					fd_notify, EVENT_BUF_LEN);
 			}
 			len += ret;
 		}
@@ -186,24 +186,24 @@ void test01(void)
 		event = (struct fanotify_event_metadata *)&event_buf[i];
 		if (!(event->mask & event_set[test_num])) {
 			tst_res(TFAIL,
-				 "get event: mask=%llx (expected %llx) "
-				 "pid=%u fd=%u",
-				 (unsigned long long)event->mask,
-				 event_set[test_num],
-				 (unsigned)event->pid, event->fd);
+				"get event: mask=%llx (expected %llx) "
+				"pid=%u fd=%u",
+				(unsigned long long)event->mask,
+				event_set[test_num],
+				(unsigned)event->pid, event->fd);
 		} else if (event->pid != child_pid) {
 			tst_res(TFAIL,
-				 "get event: mask=%llx pid=%u "
-				 "(expected %u) fd=%u",
-				 (unsigned long long)event->mask,
-				 (unsigned)event->pid,
-				 (unsigned)child_pid,
-				 event->fd);
+				"get event: mask=%llx pid=%u "
+				"(expected %u) fd=%u",
+				(unsigned long long)event->mask,
+				(unsigned)event->pid,
+				(unsigned)child_pid,
+				event->fd);
 		} else {
 			tst_res(TPASS,
-				    "get event: mask=%llx pid=%u fd=%u",
-				    (unsigned long long)event->mask,
-				    (unsigned)event->pid, event->fd);
+				"get event: mask=%llx pid=%u fd=%u",
+				(unsigned long long)event->mask,
+				(unsigned)event->pid, event->fd);
 		}
 		/* Write response to permission event */
 		if (event_set[test_num] & FAN_ALL_PERM_EVENTS) {
@@ -225,7 +225,7 @@ void test01(void)
 	}
 	for (; test_num < TST_TOTAL - 1; test_num++) {
 		tst_res(TFAIL, "didn't get event: mask=%llx",
-			 event_set[test_num]);
+			event_set[test_num]);
 
 	}
 	check_child();
@@ -244,15 +244,15 @@ static void setup(void)
 	fd_notify = SAFE_FANOTIFY_INIT(FAN_CLASS_CONTENT, O_RDONLY);
 
 	if (fanotify_mark(fd_notify, FAN_MARK_ADD, FAN_ACCESS_PERM |
-			    FAN_OPEN_PERM, AT_FDCWD, fname) < 0) {
+			  FAN_OPEN_PERM, AT_FDCWD, fname) < 0) {
 		if (errno == EINVAL) {
 			tst_brk(TCONF | TERRNO,
-				 "CONFIG_FANOTIFY_ACCESS_PERMISSIONS not "
-				 "configured in kernel?");
+				"CONFIG_FANOTIFY_ACCESS_PERMISSIONS not "
+				"configured in kernel?");
 		} else {
 			tst_brk(TBROK | TERRNO,
-				 "fanotify_mark (%d, FAN_MARK_ADD, FAN_ACCESS_PERM | "
-				 "FAN_OPEN_PERM, AT_FDCWD, %s) failed.", fd_notify, fname);
+				"fanotify_mark (%d, FAN_MARK_ADD, FAN_ACCESS_PERM | "
+				"FAN_OPEN_PERM, AT_FDCWD, %s) failed.", fd_notify, fname);
 		}
 	}
 
@@ -262,6 +262,8 @@ static void cleanup(void)
 {
 	if (fd_notify > 0)
 		SAFE_CLOSE(fd_notify);
+	if (fd_notify_backup > 0)
+		SAFE_CLOSE(fd_notify_backup);
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/syscalls/fanotify/fanotify04.c b/testcases/kernel/syscalls/fanotify/fanotify04.c
index 6713ff609..fb932aeb1 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify04.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify04.c
@@ -77,14 +77,14 @@ static void check_mark(char *file, unsigned long long flag, char *flagstr,
 		       int expect, void (*test_event)(char *))
 {
 	if (fanotify_mark(fd_notify, FAN_MARK_ADD | flag, FAN_OPEN, AT_FDCWD,
-			    file) != expect) {
-		tst_res(TFAIL,
-		    "fanotify_mark (%d, FAN_MARK_ADD | %s, FAN_OPEN, AT_FDCWD, "
-		    "'%s') %s", fd_notify, flagstr, file, expect_str_fail(expect));
+			  file) != expect) {
+		tst_res(TFAIL, "fanotify_mark (%d, FAN_MARK_ADD | %s, "
+			"FAN_OPEN, AT_FDCWD, '%s') %s",
+			fd_notify, flagstr, file, expect_str_fail(expect));
 	} else {
-		tst_res(TPASS,
-		    "fanotify_mark (%d, FAN_MARK_ADD | %s, FAN_OPEN, AT_FDCWD, "
-		    "'%s') %s", fd_notify, flagstr, file, expect_str_pass(expect));
+		tst_res(TPASS, "fanotify_mark (%d, FAN_MARK_ADD | %s, "
+			"FAN_OPEN, AT_FDCWD, '%s') %s",
+			fd_notify, flagstr, file, expect_str_pass(expect));
 
 		/* If we expected failure there's nothing to clean up */
 		if (expect == -1)
@@ -94,11 +94,11 @@ static void check_mark(char *file, unsigned long long flag, char *flagstr,
 			test_event(file);
 
 		if (fanotify_mark(fd_notify, FAN_MARK_REMOVE | flag,
-				    FAN_OPEN, AT_FDCWD, file) < 0) {
+				  FAN_OPEN, AT_FDCWD, file) < 0) {
 			tst_brk(TBROK | TERRNO,
-			    "fanotify_mark (%d, FAN_MARK_REMOVE | %s, "
-			    "FAN_OPEN, AT_FDCWD, '%s') failed",
-			    fd_notify, flagstr, file);
+				"fanotify_mark (%d, FAN_MARK_REMOVE | %s, "
+				"FAN_OPEN, AT_FDCWD, '%s') failed",
+				fd_notify, flagstr, file);
 		}
 	}
 }
@@ -137,13 +137,13 @@ static void verify_event(int mask)
 
 	if (event->mask != FAN_OPEN) {
 		tst_res(TFAIL, "got unexpected event %llx",
-			 (unsigned long long)event->mask);
+			(unsigned long long)event->mask);
 	} else if (fstat(event->fd, &st) < 0) {
 		tst_res(TFAIL, "failed to stat event->fd (%s)",
-			 strerror(errno));
+			strerror(errno));
 	} else if ((int)(st.st_mode & S_IFMT) != mask) {
 		tst_res(TFAIL, "event->fd points to object of different type "
-			 "(%o != %o)", st.st_mode & S_IFMT, mask);
+			"(%o != %o)", st.st_mode & S_IFMT, mask);
 	} else {
 		tst_res(TPASS, "event generated properly for type %o", mask);
 	}
@@ -173,13 +173,13 @@ static void verify_no_event(void)
 
 		event = (struct fanotify_event_metadata *)&event_buf[len];
 		tst_res(TFAIL, "seen unexpected event (mask %llx)",
-			 (unsigned long long)event->mask);
+			(unsigned long long)event->mask);
 		/* Cleanup fd from the event */
 		if (event->fd != FAN_NOFD)
 			SAFE_CLOSE(event->fd);
 	} else if (errno != EAGAIN) {
 		tst_res(TFAIL | TERRNO, "read(%d, buf, %zu) failed", fd_notify,
-			 EVENT_BUF_LEN);
+			EVENT_BUF_LEN);
 	} else {
 		tst_res(TPASS, "No event as expected");
 	}
@@ -208,27 +208,27 @@ void test01(void)
 
 	/* Verify FAN_MARK_FLUSH destroys all inode marks */
 	if (fanotify_mark(fd_notify, FAN_MARK_ADD,
-			    FAN_OPEN, AT_FDCWD, fname) < 0) {
+			  FAN_OPEN, AT_FDCWD, fname) < 0) {
 		tst_brk(TBROK | TERRNO,
-		    "fanotify_mark (%d, FAN_MARK_ADD, FAN_OPEN, "
-		    "AT_FDCWD, '%s') failed", fd_notify, fname);
+			"fanotify_mark (%d, FAN_MARK_ADD, FAN_OPEN, "
+			"AT_FDCWD, '%s') failed", fd_notify, fname);
 	}
 	if (fanotify_mark(fd_notify, FAN_MARK_ADD,
-			    FAN_OPEN | FAN_ONDIR, AT_FDCWD, dir) < 0) {
+			  FAN_OPEN | FAN_ONDIR, AT_FDCWD, dir) < 0) {
 		tst_brk(TBROK | TERRNO,
-		    "fanotify_mark (%d, FAN_MARK_ADD, FAN_OPEN | "
-		    "FAN_ONDIR, AT_FDCWD, '%s') failed", fd_notify,
-		    dir);
+			"fanotify_mark (%d, FAN_MARK_ADD, FAN_OPEN | "
+			"FAN_ONDIR, AT_FDCWD, '%s') failed", fd_notify,
+			dir);
 	}
 	open_file(fname);
 	verify_event(S_IFREG);
 	open_dir(dir);
 	verify_event(S_IFDIR);
 	if (fanotify_mark(fd_notify, FAN_MARK_FLUSH,
-			    0, AT_FDCWD, ".") < 0) {
+			  0, AT_FDCWD, ".") < 0) {
 		tst_brk(TBROK | TERRNO,
-		    "fanotify_mark (%d, FAN_MARK_FLUSH, 0, "
-		    "AT_FDCWD, '.') failed", fd_notify);
+			"fanotify_mark (%d, FAN_MARK_FLUSH, 0, "
+			"AT_FDCWD, '.') failed", fd_notify);
 	}
 
 	open_dir(dir);
@@ -250,7 +250,7 @@ static void setup(void)
 	SAFE_MKDIR(dir, 0755);
 
 	fd_notify = SAFE_FANOTIFY_INIT(FAN_CLASS_NOTIF | FAN_NONBLOCK,
-			O_RDONLY);
+					O_RDONLY);
 }
 
 static void cleanup(void)
diff --git a/testcases/kernel/syscalls/fanotify/fanotify05.c b/testcases/kernel/syscalls/fanotify/fanotify05.c
index ec615e6d8..a2296cc5e 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify05.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify05.c
@@ -71,11 +71,11 @@ void test01(void)
 		if (len < 0) {
 			if (errno == -EAGAIN) {
 				tst_res(TFAIL, "Overflow event not "
-					 "generated!\n");
+					"generated!\n");
 				break;
 			}
 			tst_brk(TBROK | TERRNO,
-				 "read of notification event failed");
+				"read of notification event failed");
 			break;
 		}
 		if (event.fd != FAN_NOFD)
@@ -87,27 +87,27 @@ void test01(void)
 		if (event.mask != FAN_OPEN &&
 		    event.mask != FAN_Q_OVERFLOW) {
 			tst_res(TFAIL,
-				 "get event: mask=%llx (expected %llx)"
-				 "pid=%u fd=%d",
-				 (unsigned long long)event.mask,
-				 (unsigned long long)FAN_OPEN,
-				 (unsigned)event.pid, event.fd);
+				"get event: mask=%llx (expected %llx)"
+				"pid=%u fd=%d",
+				(unsigned long long)event.mask,
+				(unsigned long long)FAN_OPEN,
+				(unsigned)event.pid, event.fd);
 			break;
 		}
 		if (event.mask == FAN_Q_OVERFLOW) {
 			if (event.fd != FAN_NOFD) {
 				tst_res(TFAIL,
-					 "invalid overflow event: "
-					 "mask=%llx pid=%u fd=%d",
-					 (unsigned long long)event.mask,
-					 (unsigned)event.pid,
-					 event.fd);
+					"invalid overflow event: "
+					"mask=%llx pid=%u fd=%d",
+					(unsigned long long)event.mask,
+					(unsigned)event.pid,
+					event.fd);
 				break;
 			}
 			tst_res(TPASS,
-				 "get event: mask=%llx pid=%u fd=%d",
-				 (unsigned long long)event.mask,
-				 (unsigned)event.pid, event.fd);
+				"get event: mask=%llx pid=%u fd=%d",
+				(unsigned long long)event.mask,
+				(unsigned)event.pid, event.fd);
 				break;
 		}
 	}
@@ -119,11 +119,11 @@ static void setup(void)
 			O_RDONLY);
 
 	if (fanotify_mark(fd_notify, FAN_MARK_MOUNT | FAN_MARK_ADD, FAN_OPEN,
-			    AT_FDCWD, ".") < 0) {
+			  AT_FDCWD, ".") < 0) {
 		tst_brk(TBROK | TERRNO,
-			 "fanotify_mark (%d, FAN_MARK_MOUNT | FAN_MARK_ADD, "
-			 "FAN_OPEN, AT_FDCWD, \".\") failed",
-			 fd_notify);
+			"fanotify_mark (%d, FAN_MARK_MOUNT | FAN_MARK_ADD, "
+			"FAN_OPEN, AT_FDCWD, \".\") failed",
+			fd_notify);
 	}
 }
 
diff --git a/testcases/kernel/syscalls/fanotify/fanotify06.c b/testcases/kernel/syscalls/fanotify/fanotify06.c
index 988296a7e..bf95b2d7c 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify06.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify06.c
@@ -83,8 +83,8 @@ static void create_fanotify_groups(void)
 	for (p = 0; p < FANOTIFY_PRIORITIES; p++) {
 		for (i = 0; i < GROUPS_PER_PRIO; i++) {
 			fd_notify[p][i] = SAFE_FANOTIFY_INIT(fanotify_prio[p] |
-							FAN_NONBLOCK,
-							O_RDONLY);
+							     FAN_NONBLOCK,
+							     O_RDONLY);
 
 			/* Add mount mark for each group */
 			ret = fanotify_mark(fd_notify[p][i],
@@ -93,9 +93,9 @@ static void create_fanotify_groups(void)
 					    AT_FDCWD, ".");
 			if (ret < 0) {
 				tst_brk(TBROK | TERRNO,
-					 "fanotify_mark(%d, FAN_MARK_ADD | "
-					 "FAN_MARK_MOUNT, FAN_MODIFY, AT_FDCWD,"
-					 " '.') failed", fd_notify[p][i]);
+					"fanotify_mark(%d, FAN_MARK_ADD | "
+					"FAN_MARK_MOUNT, FAN_MODIFY, AT_FDCWD,"
+					" '.') failed", fd_notify[p][i]);
 			}
 			/* Add ignore mark for groups with higher priority */
 			if (p == 0)
@@ -107,11 +107,11 @@ static void create_fanotify_groups(void)
 					    FAN_MODIFY, AT_FDCWD, fname);
 			if (ret < 0) {
 				tst_brk(TBROK | TERRNO,
-					 "fanotify_mark(%d, FAN_MARK_ADD | "
-					 "FAN_MARK_IGNORED_MASK | "
-					 "FAN_MARK_IGNORED_SURV_MODIFY, "
-					 "FAN_MODIFY, AT_FDCWD, %s) failed",
-					 fd_notify[p][i], fname);
+					"fanotify_mark(%d, FAN_MARK_ADD | "
+					"FAN_MARK_IGNORED_MASK | "
+					"FAN_MARK_IGNORED_SURV_MODIFY, "
+					"FAN_MODIFY, AT_FDCWD, %s) failed",
+					fd_notify[p][i], fname);
 			}
 		}
 	}
@@ -133,18 +133,18 @@ static void verify_event(int group, struct fanotify_event_metadata *event)
 {
 	if (event->mask != FAN_MODIFY) {
 		tst_res(TFAIL, "group %d get event: mask %llx (expected %llx) "
-			 "pid=%u fd=%u", group, (unsigned long long)event->mask,
-			 (unsigned long long)FAN_MODIFY,
-			 (unsigned)event->pid, event->fd);
+			"pid=%u fd=%u", group, (unsigned long long)event->mask,
+			(unsigned long long)FAN_MODIFY,
+			(unsigned)event->pid, event->fd);
 	} else if (event->pid != getpid()) {
 		tst_res(TFAIL, "group %d get event: mask %llx pid=%u "
-			 "(expected %u) fd=%u", group,
-			 (unsigned long long)event->mask, (unsigned)event->pid,
-			 (unsigned)getpid(), event->fd);
+			"(expected %u) fd=%u", group,
+			(unsigned long long)event->mask, (unsigned)event->pid,
+			(unsigned)getpid(), event->fd);
 	} else {
 		tst_res(TPASS, "group %d get event: mask %llx pid=%u fd=%u",
-			 group, (unsigned long long)event->mask,
-			 (unsigned)event->pid, event->fd);
+			group, (unsigned long long)event->mask,
+			(unsigned)event->pid, event->fd);
 	}
 }
 
@@ -167,22 +167,22 @@ void test01(void)
 		if (ret < 0) {
 			if (errno == EAGAIN) {
 				tst_res(TFAIL, "group %d did not get "
-					 "event", i);
+					"event", i);
 			}
 			tst_brk(TBROK | TERRNO,
-				 "reading fanotify events failed");
+				"reading fanotify events failed");
 		}
 		if (ret < (int)FAN_EVENT_METADATA_LEN) {
 			tst_brk(TBROK,
-				 "short read when reading fanotify "
-				 "events (%d < %d)", ret,
-				 (int)EVENT_BUF_LEN);
+				"short read when reading fanotify "
+				"events (%d < %d)", ret,
+				(int)EVENT_BUF_LEN);
 		}
 		event = (struct fanotify_event_metadata *)event_buf;
 		if (ret > (int)event->event_len) {
 			tst_res(TFAIL, "group %d got more than one "
-				 "event (%d > %d)", i, ret,
-				 event->event_len);
+				"event (%d > %d)", i, ret,
+				event->event_len);
 		} else {
 			verify_event(i, event);
 		}
@@ -194,18 +194,18 @@ void test01(void)
 			ret = read(fd_notify[p][i], event_buf, EVENT_BUF_LEN);
 			if (ret > 0) {
 				tst_res(TFAIL, "group %d got event",
-					 p*GROUPS_PER_PRIO + i);
+					p*GROUPS_PER_PRIO + i);
 				if (event->fd != FAN_NOFD)
 					SAFE_CLOSE(event->fd);
 			} else if (ret == 0) {
 				tst_brk(TBROK, "zero length "
-					 "read from fanotify fd");
+					"read from fanotify fd");
 			} else if (errno != EAGAIN) {
 				tst_brk(TBROK | TERRNO,
-					 "reading fanotify events failed");
+					"reading fanotify events failed");
 			} else {
 				tst_res(TPASS, "group %d got no event",
-					 p*GROUPS_PER_PRIO + i);
+					p*GROUPS_PER_PRIO + i);
 			}
 		}
 	}
diff --git a/testcases/kernel/syscalls/fanotify/fanotify09.c b/testcases/kernel/syscalls/fanotify/fanotify09.c
index 56be851ab..ebfbcb090 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify09.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify09.c
@@ -71,8 +71,8 @@ static void create_fanotify_groups(void)
 
 	for (i = 0; i < NUM_GROUPS; i++) {
 		fd_notify[i] = SAFE_FANOTIFY_INIT(FAN_CLASS_NOTIF |
-						FAN_NONBLOCK,
-						O_RDONLY);
+						  FAN_NONBLOCK,
+						  O_RDONLY);
 
 		/* Add mount mark for each group without MODIFY event */
 		ret = fanotify_mark(fd_notify[i],
@@ -81,9 +81,9 @@ static void create_fanotify_groups(void)
 				    AT_FDCWD, ".");
 		if (ret < 0) {
 			tst_brk(TBROK | TERRNO,
-				 "fanotify_mark(%d, FAN_MARK_ADD | "
-				 "FAN_MARK_MOUNT, FAN_MODIFY, AT_FDCWD,"
-				 " '.') failed", fd_notify[i]);
+				"fanotify_mark(%d, FAN_MARK_ADD | "
+				"FAN_MARK_MOUNT, FAN_MODIFY, AT_FDCWD,"
+				" '.') failed", fd_notify[i]);
 		}
 		/*
 		 * Add inode mark on parent for each group with MODIFY
@@ -98,10 +98,10 @@ static void create_fanotify_groups(void)
 				    FAN_MODIFY | onchild, AT_FDCWD, ".");
 		if (ret < 0) {
 			tst_brk(TBROK | TERRNO,
-				 "fanotify_mark(%d, FAN_MARK_ADD, "
-				 "FAN_MODIFY%s, AT_FDCWD, '.') failed",
-				 fd_notify[i],
-				 onchild ? " | FAN_EVENT_ON_CHILD" : "");
+				"fanotify_mark(%d, FAN_MARK_ADD, "
+				"FAN_MODIFY%s, AT_FDCWD, '.') failed",
+				fd_notify[i],
+				onchild ? " | FAN_EVENT_ON_CHILD" : "");
 		}
 	}
 }
@@ -120,18 +120,18 @@ static void verify_event(int group, struct fanotify_event_metadata *event)
 {
 	if (event->mask != FAN_MODIFY) {
 		tst_res(TFAIL, "group %d get event: mask %llx (expected %llx) "
-			 "pid=%u fd=%u", group, (unsigned long long)event->mask,
-			 (unsigned long long)FAN_MODIFY,
-			 (unsigned)event->pid, event->fd);
+			"pid=%u fd=%u", group, (unsigned long long)event->mask,
+			(unsigned long long)FAN_MODIFY,
+			(unsigned)event->pid, event->fd);
 	} else if (event->pid != getpid()) {
 		tst_res(TFAIL, "group %d get event: mask %llx pid=%u "
-			 "(expected %u) fd=%u", group,
-			 (unsigned long long)event->mask, (unsigned)event->pid,
-			 (unsigned)getpid(), event->fd);
+			"(expected %u) fd=%u", group,
+			(unsigned long long)event->mask, (unsigned)event->pid,
+			(unsigned)getpid(), event->fd);
 	} else {
 		tst_res(TPASS, "group %d get event: mask %llx pid=%u fd=%u",
-			 group, (unsigned long long)event->mask,
-			 (unsigned)event->pid, event->fd);
+			group, (unsigned long long)event->mask,
+			(unsigned)event->pid, event->fd);
 	}
 }
 
@@ -155,20 +155,20 @@ void test01(void)
 			tst_res(TFAIL, "first group did not get event");
 		} else {
 			tst_brk(TBROK | TERRNO,
-				 "reading fanotify events failed");
+				"reading fanotify events failed");
 		}
 	}
 	if (ret < (int)FAN_EVENT_METADATA_LEN) {
 		tst_brk(TBROK,
-			 "short read when reading fanotify "
-			 "events (%d < %d)", ret,
-			 (int)EVENT_BUF_LEN);
+			"short read when reading fanotify "
+			"events (%d < %d)", ret,
+			(int)EVENT_BUF_LEN);
 	}
 	event = (struct fanotify_event_metadata *)event_buf;
 	if (ret > (int)event->event_len) {
 		tst_res(TFAIL, "first group got more than one "
-			 "event (%d > %d)", ret,
-			 event->event_len);
+			"event (%d > %d)", ret,
+			event->event_len);
 	} else {
 		verify_event(0, event);
 	}
-- 
2.17.1

