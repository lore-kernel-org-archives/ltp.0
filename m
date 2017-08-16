From: Xiong Zhou <xzhou@redhat.com>
Date: Wed, 16 Aug 2017 15:15:36 +0800
Subject: [LTP] [PATCH v4 2/3] fanotify: rewrite old cases with new lib
In-Reply-To: <1502867737-26158-1-git-send-email-xzhou@redhat.com>
References: <20170815133616.GD30800@rei>
 <1502867737-26158-1-git-send-email-xzhou@redhat.com>
Message-ID: <1502867737-26158-3-git-send-email-xzhou@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

To use SAFE_FANOTIFY_INIT helper.

Signed-off-by: Xiong Zhou <xzhou@redhat.com>
---
 testcases/kernel/syscalls/fanotify/fanotify01.c | 526 +++++++++++-------------
 testcases/kernel/syscalls/fanotify/fanotify02.c | 326 +++++++--------
 testcases/kernel/syscalls/fanotify/fanotify03.c | 254 +++++-------
 testcases/kernel/syscalls/fanotify/fanotify04.c | 165 +++-----
 testcases/kernel/syscalls/fanotify/fanotify05.c | 155 +++----
 testcases/kernel/syscalls/fanotify/fanotify06.c | 193 ++++-----
 testcases/kernel/syscalls/fanotify/fanotify07.c |   9 +-
 7 files changed, 720 insertions(+), 908 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify01.c b/testcases/kernel/syscalls/fanotify/fanotify01.c
index 4799d54..205a999 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify01.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify01.c
@@ -35,13 +35,8 @@
 #include <errno.h>
 #include <string.h>
 #include <sys/syscall.h>
-#include "test.h"
-#include "lapi/syscalls.h"
+#include "tst_test.h"
 #include "fanotify.h"
-#include "safe_macros.h"
-
-char *TCID = "fanotify01";
-int TST_TOTAL = 12;
 
 #if defined(HAVE_SYS_FANOTIFY_H)
 #include <sys/fanotify.h>
@@ -52,10 +47,9 @@ int TST_TOTAL = 12;
 /* reasonable guess as to size of 1024 events */
 #define EVENT_BUF_LEN        (EVENT_MAX * EVENT_SIZE)
 
-static void setup(void);
-static void cleanup(void);
-
 #define BUF_SIZE 256
+#define TST_TOTAL 12
+
 static char fname[BUF_SIZE];
 static char buf[BUF_SIZE];
 static int fd, fd_notify;
@@ -64,308 +58,282 @@ static unsigned long long event_set[EVENT_MAX];
 
 static char event_buf[EVENT_BUF_LEN];
 
-int main(int ac, char **av)
+void test01(void)
 {
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		int ret, len, i = 0, test_num = 0;
-
-		tst_count = 0;
-
-		if (fanotify_mark(fd_notify, FAN_MARK_ADD, FAN_ACCESS | FAN_MODIFY |
-				    FAN_CLOSE | FAN_OPEN, AT_FDCWD, fname) < 0) {
-			tst_brkm(TBROK | TERRNO, cleanup,
-			    "fanotify_mark (%d, FAN_MARK_ADD, FAN_ACCESS | "
-			    "FAN_MODIFY | FAN_CLOSE | FAN_OPEN, AT_FDCWD, %s) "
-			    "failed", fd_notify, fname);
-		}
-
-		/*
-		 * generate sequence of events
-		 */
-		fd = SAFE_OPEN(cleanup, fname, O_RDONLY);
-		event_set[tst_count] = FAN_OPEN;
-		tst_count++;
-
-		SAFE_READ(cleanup, 0, fd, buf, BUF_SIZE);
-		event_set[tst_count] = FAN_ACCESS;
-		tst_count++;
-
-		SAFE_CLOSE(cleanup, fd);
-		event_set[tst_count] = FAN_CLOSE_NOWRITE;
-		tst_count++;
-
-		/*
-		 * Get list of events so far. We get events here to avoid
-		 * merging of following events with the previous ones.
-		 */
-		ret = SAFE_READ(cleanup, 0, fd_notify, event_buf, EVENT_BUF_LEN);
-		len = ret;
-
-		fd = SAFE_OPEN(cleanup, fname, O_RDWR | O_CREAT, 0700);
-		event_set[tst_count] = FAN_OPEN;
-		tst_count++;
-
-		SAFE_WRITE(cleanup, 1, fd, fname, strlen(fname));
-		event_set[tst_count] = FAN_MODIFY;
-		tst_count++;
-
-		SAFE_CLOSE(cleanup, fd);
-		event_set[tst_count] = FAN_CLOSE_WRITE;
-		tst_count++;
-
-		/*
-		 * get another list of events
-		 */
-		ret = SAFE_READ(cleanup, 0, fd_notify, event_buf + len,
-				EVENT_BUF_LEN - len);
-		len += ret;
-
-		/*
-		 * Ignore mask testing
-		 */
-
-		/* Ignore access events */
-		if (fanotify_mark(fd_notify,
-				    FAN_MARK_ADD | FAN_MARK_IGNORED_MASK,
-				    FAN_ACCESS, AT_FDCWD, fname) < 0) {
-			tst_brkm(TBROK | TERRNO, cleanup,
-			     "fanotify_mark (%d, FAN_MARK_ADD | "
-			     "FAN_MARK_IGNORED_MASK, FAN_ACCESS, "
-			     "AT_FDCWD, %s) failed", fd_notify, fname);
-		}
-
-		fd = SAFE_OPEN(cleanup, fname, O_RDWR);
-		event_set[tst_count] = FAN_OPEN;
-		tst_count++;
-
-		/* This event should be ignored */
-		SAFE_READ(cleanup, 0, fd, buf, BUF_SIZE);
-
-		/*
-		 * get another list of events to verify the last one got ignored
-		 */
-		ret = SAFE_READ(cleanup, 0, fd_notify, event_buf + len,
-				EVENT_BUF_LEN - len);
-		len += ret;
-
-		lseek(fd, 0, SEEK_SET);
-		/* Generate modify event to clear ignore mask */
-		SAFE_WRITE(cleanup, 1, fd, fname, 1);
-		event_set[tst_count] = FAN_MODIFY;
-		tst_count++;
-
-		/*
-		 * This event shouldn't be ignored because previous modification
-		 * should have removed the ignore mask
-		 */
-		SAFE_READ(cleanup, 0, fd, buf, BUF_SIZE);
-		event_set[tst_count] = FAN_ACCESS;
-		tst_count++;
+	int ret, len, i = 0, test_num = 0;
 
-		SAFE_CLOSE(cleanup, fd);
-		event_set[tst_count] = FAN_CLOSE_WRITE;
-		tst_count++;
+	int tst_count = 0;
 
-		/* Read events to verify previous access was properly generated */
-		ret = SAFE_READ(cleanup, 0, fd_notify, event_buf + len,
-				EVENT_BUF_LEN - len);
-		len += ret;
+	if (fanotify_mark(fd_notify, FAN_MARK_ADD, FAN_ACCESS | FAN_MODIFY |
+			    FAN_CLOSE | FAN_OPEN, AT_FDCWD, fname) < 0) {
+		tst_brk(TBROK | TERRNO,
+		    "fanotify_mark (%d, FAN_MARK_ADD, FAN_ACCESS | "
+		    "FAN_MODIFY | FAN_CLOSE | FAN_OPEN, AT_FDCWD, %s) "
+		    "failed", fd_notify, fname);
+	}
 
-		/*
-		 * Now ignore open & close events regardless of file
-		 * modifications
-		 */
-		if (fanotify_mark(fd_notify,
-				    FAN_MARK_ADD | FAN_MARK_IGNORED_MASK | FAN_MARK_IGNORED_SURV_MODIFY,
-				    FAN_OPEN | FAN_CLOSE, AT_FDCWD, fname) < 0) {
-			tst_brkm(TBROK | TERRNO, cleanup,
-			     "fanotify_mark (%d, FAN_MARK_ADD | "
-			     "FAN_MARK_IGNORED_MASK | "
-			     "FAN_MARK_IGNORED_SURV_MODIFY, FAN_OPEN | "
-			     "FAN_CLOSE, AT_FDCWD, %s) failed", fd_notify,
-			     fname);
-		}
+	/*
+	 * generate sequence of events
+	 */
+	fd = SAFE_OPEN(fname, O_RDONLY);
+	event_set[tst_count] = FAN_OPEN;
+	tst_count++;
+
+	SAFE_READ(0, fd, buf, BUF_SIZE);
+	event_set[tst_count] = FAN_ACCESS;
+	tst_count++;
+
+	SAFE_CLOSE(fd);
+	event_set[tst_count] = FAN_CLOSE_NOWRITE;
+	tst_count++;
+
+	/*
+	 * Get list of events so far. We get events here to avoid
+	 * merging of following events with the previous ones.
+	 */
+	ret = SAFE_READ(0, fd_notify, event_buf, EVENT_BUF_LEN);
+	len = ret;
+
+	fd = SAFE_OPEN(fname, O_RDWR | O_CREAT, 0700);
+	event_set[tst_count] = FAN_OPEN;
+	tst_count++;
+
+	SAFE_WRITE(1, fd, fname, strlen(fname));
+	event_set[tst_count] = FAN_MODIFY;
+	tst_count++;
+
+	SAFE_CLOSE(fd);
+	event_set[tst_count] = FAN_CLOSE_WRITE;
+	tst_count++;
+
+	/*
+	 * get another list of events
+	 */
+	ret = SAFE_READ(0, fd_notify, event_buf + len,
+			EVENT_BUF_LEN - len);
+	len += ret;
+
+	/*
+	 * Ignore mask testing
+	 */
+
+	/* Ignore access events */
+	if (fanotify_mark(fd_notify,
+			    FAN_MARK_ADD | FAN_MARK_IGNORED_MASK,
+			    FAN_ACCESS, AT_FDCWD, fname) < 0) {
+		tst_brk(TBROK | TERRNO,
+		     "fanotify_mark (%d, FAN_MARK_ADD | "
+		     "FAN_MARK_IGNORED_MASK, FAN_ACCESS, "
+		     "AT_FDCWD, %s) failed", fd_notify, fname);
+	}
 
-		/* This event should be ignored */
-		fd = SAFE_OPEN(cleanup, fname, O_RDWR);
-
-		SAFE_WRITE(cleanup, 1, fd, fname, 1);
-		event_set[tst_count] = FAN_MODIFY;
-		tst_count++;
-
-		/* This event should be still ignored */
-		SAFE_CLOSE(cleanup, fd);
-
-		/* This event should still be ignored */
-		fd = SAFE_OPEN(cleanup, fname, O_RDWR);
-
-		/* Read events to verify open & close were ignored */
-		ret = SAFE_READ(cleanup, 0, fd_notify, event_buf + len,
-				EVENT_BUF_LEN - len);
-		len += ret;
-
-		/* Now remove open and close from ignored mask */
-		if (fanotify_mark(fd_notify,
-				    FAN_MARK_REMOVE | FAN_MARK_IGNORED_MASK,
-				    FAN_OPEN | FAN_CLOSE, AT_FDCWD, fname) < 0) {
-			tst_brkm(TBROK | TERRNO, cleanup,
-			     "fanotify_mark (%d, FAN_MARK_REMOVE | "
-			     "FAN_MARK_IGNORED_MASK, FAN_OPEN | "
-			     "FAN_CLOSE, AT_FDCWD, %s) failed", fd_notify,
-			     fname);
-		}
+	fd = SAFE_OPEN(fname, O_RDWR);
+	event_set[tst_count] = FAN_OPEN;
+	tst_count++;
+
+	/* This event should be ignored */
+	SAFE_READ(0, fd, buf, BUF_SIZE);
+
+	/*
+	 * get another list of events to verify the last one got ignored
+	 */
+	ret = SAFE_READ(0, fd_notify, event_buf + len,
+			EVENT_BUF_LEN - len);
+	len += ret;
+
+	lseek(fd, 0, SEEK_SET);
+	/* Generate modify event to clear ignore mask */
+	SAFE_WRITE(1, fd, fname, 1);
+	event_set[tst_count] = FAN_MODIFY;
+	tst_count++;
+
+	/*
+	 * This event shouldn't be ignored because previous modification
+	 * should have removed the ignore mask
+	 */
+	SAFE_READ(0, fd, buf, BUF_SIZE);
+	event_set[tst_count] = FAN_ACCESS;
+	tst_count++;
+
+	SAFE_CLOSE(fd);
+	event_set[tst_count] = FAN_CLOSE_WRITE;
+	tst_count++;
+
+	/* Read events to verify previous access was properly generated */
+	ret = SAFE_READ(0, fd_notify, event_buf + len,
+			EVENT_BUF_LEN - len);
+	len += ret;
+
+	/*
+	 * Now ignore open & close events regardless of file
+	 * modifications
+	 */
+	if (fanotify_mark(fd_notify,
+			    FAN_MARK_ADD | FAN_MARK_IGNORED_MASK | FAN_MARK_IGNORED_SURV_MODIFY,
+			    FAN_OPEN | FAN_CLOSE, AT_FDCWD, fname) < 0) {
+		tst_brk(TBROK | TERRNO,
+		     "fanotify_mark (%d, FAN_MARK_ADD | "
+		     "FAN_MARK_IGNORED_MASK | "
+		     "FAN_MARK_IGNORED_SURV_MODIFY, FAN_OPEN | "
+		     "FAN_CLOSE, AT_FDCWD, %s) failed", fd_notify,
+		     fname);
+	}
 
-		SAFE_CLOSE(cleanup, fd);
-		event_set[tst_count] = FAN_CLOSE_WRITE;
-		tst_count++;
+	/* This event should be ignored */
+	fd = SAFE_OPEN(fname, O_RDWR);
+
+	SAFE_WRITE(1, fd, fname, 1);
+	event_set[tst_count] = FAN_MODIFY;
+	tst_count++;
+
+	/* This event should be still ignored */
+	SAFE_CLOSE(fd);
+
+	/* This event should still be ignored */
+	fd = SAFE_OPEN(fname, O_RDWR);
+
+	/* Read events to verify open & close were ignored */
+	ret = SAFE_READ(0, fd_notify, event_buf + len,
+			EVENT_BUF_LEN - len);
+	len += ret;
+
+	/* Now remove open and close from ignored mask */
+	if (fanotify_mark(fd_notify,
+			    FAN_MARK_REMOVE | FAN_MARK_IGNORED_MASK,
+			    FAN_OPEN | FAN_CLOSE, AT_FDCWD, fname) < 0) {
+		tst_brk(TBROK | TERRNO,
+		     "fanotify_mark (%d, FAN_MARK_REMOVE | "
+		     "FAN_MARK_IGNORED_MASK, FAN_OPEN | "
+		     "FAN_CLOSE, AT_FDCWD, %s) failed", fd_notify,
+		     fname);
+	}
 
-		/* Read events to verify close was generated */
-		ret = SAFE_READ(cleanup, 0, fd_notify, event_buf + len,
-				EVENT_BUF_LEN - len);
-		len += ret;
+	SAFE_CLOSE(fd);
+	event_set[tst_count] = FAN_CLOSE_WRITE;
+	tst_count++;
 
-		if (TST_TOTAL != tst_count) {
-			tst_brkm(TBROK, cleanup,
-				 "TST_TOTAL (%d) and tst_count (%d) are not "
-				 "equal", TST_TOTAL, tst_count);
-		}
-		tst_count = 0;
+	/* Read events to verify close was generated */
+	ret = SAFE_READ(0, fd_notify, event_buf + len,
+			EVENT_BUF_LEN - len);
+	len += ret;
 
-		/*
-		 * check events
-		 */
-		while (i < len) {
-			struct fanotify_event_metadata *event;
-
-			event = (struct fanotify_event_metadata *)&event_buf[i];
-			if (test_num >= TST_TOTAL) {
-				tst_resm(TFAIL,
-					 "get unnecessary event: mask=%llx "
-					 "pid=%u fd=%u",
-					 (unsigned long long)event->mask,
-					 (unsigned)event->pid, event->fd);
-			} else if (!(event->mask & event_set[test_num])) {
-				tst_resm(TFAIL,
-					 "get event: mask=%llx (expected %llx) "
-					 "pid=%u fd=%u",
+	if (TST_TOTAL != tst_count) {
+		tst_brk(TBROK,
+			 "TST_TOTAL (%d) and tst_count (%d) are not "
+			 "equal", TST_TOTAL, tst_count);
+	}
+	tst_count = 0;
+
+	/*
+	 * check events
+	 */
+	while (i < len) {
+		struct fanotify_event_metadata *event;
+
+		event = (struct fanotify_event_metadata *)&event_buf[i];
+		if (test_num >= TST_TOTAL) {
+			tst_res(TFAIL,
+				 "get unnecessary event: mask=%llx "
+				 "pid=%u fd=%u",
+				 (unsigned long long)event->mask,
+				 (unsigned)event->pid, event->fd);
+		} else if (!(event->mask & event_set[test_num])) {
+			tst_res(TFAIL,
+				 "get event: mask=%llx (expected %llx) "
+				 "pid=%u fd=%u",
+				 (unsigned long long)event->mask,
+				 event_set[test_num],
+				 (unsigned)event->pid, event->fd);
+		} else if (event->pid != getpid()) {
+			tst_res(TFAIL,
+				 "get event: mask=%llx pid=%u "
+				 "(expected %u) fd=%u",
+				 (unsigned long long)event->mask,
+				 (unsigned)event->pid,
+				 (unsigned)getpid(),
+				 event->fd);
+		} else {
+			if (event->fd == -2)
+				goto pass;
+			ret = read(event->fd, buf, BUF_SIZE);
+			if (ret != strlen(fname)) {
+				tst_res(TFAIL,
+					 "cannot read from returned fd "
+					 "of event: mask=%llx pid=%u "
+					 "fd=%u ret=%d (errno=%d)",
 					 (unsigned long long)event->mask,
-					 event_set[test_num],
-					 (unsigned)event->pid, event->fd);
-			} else if (event->pid != getpid()) {
-				tst_resm(TFAIL,
-					 "get event: mask=%llx pid=%u "
-					 "(expected %u) fd=%u",
+					 (unsigned)event->pid,
+					 event->fd, ret, errno);
+			} else if (memcmp(buf, fname, strlen(fname))) {
+				tst_res(TFAIL,
+					 "wrong data read from returned fd "
+					 "of event: mask=%llx pid=%u "
+					 "fd=%u",
 					 (unsigned long long)event->mask,
 					 (unsigned)event->pid,
-					 (unsigned)getpid(),
 					 event->fd);
 			} else {
-				if (event->fd == -2)
-					goto pass;
-				ret = read(event->fd, buf, BUF_SIZE);
-				if (ret != strlen(fname)) {
-					tst_resm(TFAIL,
-						 "cannot read from returned fd "
-						 "of event: mask=%llx pid=%u "
-						 "fd=%u ret=%d (errno=%d)",
-						 (unsigned long long)event->mask,
-						 (unsigned)event->pid,
-						 event->fd, ret, errno);
-				} else if (memcmp(buf, fname, strlen(fname))) {
-					tst_resm(TFAIL,
-						 "wrong data read from returned fd "
-						 "of event: mask=%llx pid=%u "
-						 "fd=%u",
-						 (unsigned long long)event->mask,
-						 (unsigned)event->pid,
-						 event->fd);
-				} else {
 pass:
-					tst_resm(TPASS,
-					    "get event: mask=%llx pid=%u fd=%u",
-					    (unsigned long long)event->mask,
-					    (unsigned)event->pid, event->fd);
-				}
-			}
-			/*
-			 * We have verified the data now so close fd and
-			 * invalidate it so that we don't check it again
-			 * unnecessarily
-			 */
-			close(event->fd);
-			event->fd = -2;
-			event->mask &= ~event_set[test_num];
-			/* No events left in current mask? Go for next event */
-			if (event->mask == 0) {
-				i += event->event_len;
+				tst_res(TPASS,
+				    "get event: mask=%llx pid=%u fd=%u",
+				    (unsigned long long)event->mask,
+				    (unsigned)event->pid, event->fd);
 			}
-			test_num++;
-		}
-		for (; test_num < TST_TOTAL; test_num++) {
-			tst_resm(TFAIL, "didn't get event: mask=%llx",
-				 event_set[test_num]);
-
 		}
-		/* Remove mark to clear FAN_MARK_IGNORED_SURV_MODIFY */
-		if (fanotify_mark(fd_notify, FAN_MARK_REMOVE, FAN_ACCESS | FAN_MODIFY |
-				    FAN_CLOSE | FAN_OPEN, AT_FDCWD, fname) < 0) {
-			tst_brkm(TBROK | TERRNO, cleanup,
-			    "fanotify_mark (%d, FAN_MARK_REMOVE, FAN_ACCESS | "
-			    "FAN_MODIFY | FAN_CLOSE | FAN_OPEN, AT_FDCWD, %s) "
-			    "failed", fd_notify, fname);
+		/*
+		 * We have verified the data now so close fd and
+		 * invalidate it so that we don't check it again
+		 * unnecessarily
+		 */
+		close(event->fd);
+		event->fd = -2;
+		event->mask &= ~event_set[test_num];
+		/* No events left in current mask? Go for next event */
+		if (event->mask == 0) {
+			i += event->event_len;
 		}
-
+		test_num++;
 	}
+	for (; test_num < TST_TOTAL; test_num++) {
+		tst_res(TFAIL, "didn't get event: mask=%llx",
+			 event_set[test_num]);
 
-	cleanup();
-	tst_exit();
+	}
+	/* Remove mark to clear FAN_MARK_IGNORED_SURV_MODIFY */
+	if (fanotify_mark(fd_notify, FAN_MARK_REMOVE, FAN_ACCESS | FAN_MODIFY |
+			    FAN_CLOSE | FAN_OPEN, AT_FDCWD, fname) < 0) {
+		tst_brk(TBROK | TERRNO,
+		    "fanotify_mark (%d, FAN_MARK_REMOVE, FAN_ACCESS | "
+		    "FAN_MODIFY | FAN_CLOSE | FAN_OPEN, AT_FDCWD, %s) "
+		    "failed", fd_notify, fname);
+	}
 }
 
 static void setup(void)
 {
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
 	sprintf(fname, "tfile_%d", getpid());
-	fd = SAFE_OPEN(cleanup, fname, O_RDWR | O_CREAT, 0700);
-	SAFE_WRITE(cleanup, 1, fd, fname, 1);
-
+	fd = SAFE_OPEN(fname, O_RDWR | O_CREAT, 0700);
+	SAFE_WRITE(1, fd, fname, 1);
 	/* close the file we have open */
-	SAFE_CLOSE(cleanup, fd);
+	SAFE_CLOSE(fd);
 
-	if ((fd_notify = fanotify_init(FAN_CLASS_NOTIF, O_RDONLY)) < 0) {
-		if (errno == ENOSYS) {
-			tst_brkm(TCONF, cleanup,
-				 "fanotify is not configured in this kernel.");
-		} else {
-			tst_brkm(TBROK | TERRNO, cleanup,
-				 "fanotify_init failed");
-		}
-	}
+	fd_notify = SAFE_FANOTIFY_INIT(FAN_CLASS_NOTIF, O_RDONLY);
 }
 
 static void cleanup(void)
 {
-	if (fd_notify > 0 && close(fd_notify))
-		tst_resm(TWARN | TERRNO, "close(%d) failed", fd_notify);
-
-	tst_rmdir();
+	if (fd_notify > 0)
+		SAFE_CLOSE(fd_notify);
 }
 
-#else
-
-int main(void)
-{
-	tst_brkm(TCONF, NULL, "system doesn't have required fanotify support");
-}
+static struct tst_test test = {
+	.test_all = test01,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_tmpdir = 1,
+	.needs_root = 1
+};
 
+#else
+	TST_TEST_TCONF("system doesn't have required fanotify support");
 #endif
diff --git a/testcases/kernel/syscalls/fanotify/fanotify02.c b/testcases/kernel/syscalls/fanotify/fanotify02.c
index 29dbe4f..5aae777 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify02.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify02.c
@@ -35,13 +35,8 @@
 #include <errno.h>
 #include <string.h>
 #include <sys/syscall.h>
-#include "test.h"
-#include "lapi/syscalls.h"
+#include "tst_test.h"
 #include "fanotify.h"
-#include "safe_macros.h"
-
-char *TCID = "fanotify02";
-int TST_TOTAL = 8;
 
 #if defined(HAVE_SYS_FANOTIFY_H)
 #include <sys/fanotify.h>
@@ -52,10 +47,9 @@ int TST_TOTAL = 8;
 /* reasonable guess as to size of 1024 events */
 #define EVENT_BUF_LEN        (EVENT_MAX * EVENT_SIZE)
 
-static void setup(void);
-static void cleanup(void);
-
 #define BUF_SIZE 256
+#define TST_TOTAL 8
+
 static char fname[BUF_SIZE];
 static char buf[BUF_SIZE];
 static int fd, fd_notify;
@@ -64,197 +58,173 @@ static unsigned long long event_set[EVENT_MAX];
 
 static char event_buf[EVENT_BUF_LEN];
 
-int main(int ac, char **av)
+void test01(void)
 {
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		int ret, len, i = 0, test_num = 0;
-
-		tst_count = 0;
-
-		if (fanotify_mark(fd_notify, FAN_MARK_ADD, FAN_ACCESS |
-				    FAN_MODIFY | FAN_CLOSE | FAN_OPEN |
-				    FAN_EVENT_ON_CHILD | FAN_ONDIR, AT_FDCWD,
-				  ".") < 0) {
-			tst_brkm(TBROK | TERRNO, cleanup,
-			    "fanotify_mark (%d, FAN_MARK_ADD, FAN_ACCESS | "
-			    "FAN_MODIFY | FAN_CLOSE | FAN_OPEN | "
-			    "FAN_EVENT_ON_CHILD | FAN_ONDIR, AT_FDCWD, '.') "
-			    "failed", fd_notify);
-		}
+	int ret, len, i = 0, test_num = 0;
+
+	int tst_count = 0;
+
+	if (fanotify_mark(fd_notify, FAN_MARK_ADD, FAN_ACCESS |
+			    FAN_MODIFY | FAN_CLOSE | FAN_OPEN |
+			    FAN_EVENT_ON_CHILD | FAN_ONDIR, AT_FDCWD,
+			  ".") < 0) {
+		tst_brk(TBROK | TERRNO,
+		    "fanotify_mark (%d, FAN_MARK_ADD, FAN_ACCESS | "
+		    "FAN_MODIFY | FAN_CLOSE | FAN_OPEN | "
+		    "FAN_EVENT_ON_CHILD | FAN_ONDIR, AT_FDCWD, '.') "
+		    "failed", fd_notify);
+	}
 
-		/*
-		 * generate sequence of events
-		 */
-		fd = SAFE_OPEN(cleanup, fname, O_RDWR | O_CREAT, 0700);
-		event_set[tst_count] = FAN_OPEN;
-		tst_count++;
-
-		SAFE_WRITE(cleanup, 1, fd, fname, strlen(fname));
-		event_set[tst_count] = FAN_MODIFY;
-		tst_count++;
-
-		SAFE_CLOSE(cleanup, fd);
-		event_set[tst_count] = FAN_CLOSE_WRITE;
-		tst_count++;
-
-		/*
-		 * Get list of events so far. We get events here to avoid
-		 * merging of following events with the previous ones.
-		 */
-		ret = SAFE_READ(cleanup, 0, fd_notify, event_buf,
-				EVENT_BUF_LEN);
-		len = ret;
-
-		fd = SAFE_OPEN(cleanup, fname, O_RDONLY);
-		event_set[tst_count] = FAN_OPEN;
-		tst_count++;
-
-		SAFE_READ(cleanup, 0, fd, buf, BUF_SIZE);
-		event_set[tst_count] = FAN_ACCESS;
-		tst_count++;
-
-		SAFE_CLOSE(cleanup, fd);
-		event_set[tst_count] = FAN_CLOSE_NOWRITE;
-		tst_count++;
-
-		/*
-		 * get next events
-		 */
-		ret = SAFE_READ(cleanup, 0, fd_notify, event_buf + len,
-				EVENT_BUF_LEN - len);
-		len += ret;
-
-		/*
-		 * now remove child mark
-		 */
-		if (fanotify_mark(fd_notify, FAN_MARK_REMOVE,
-				    FAN_EVENT_ON_CHILD, AT_FDCWD, ".") < 0) {
-			tst_brkm(TBROK | TERRNO, cleanup,
-			    "fanotify_mark (%d, FAN_MARK REMOVE, "
-			    "FAN_EVENT_ON_CHILD, AT_FDCWD, '.') failed",
-			    fd_notify);
-		}
+	/*
+	 * generate sequence of events
+	 */
+	fd = SAFE_OPEN(fname, O_RDWR | O_CREAT, 0700);
+	event_set[tst_count] = FAN_OPEN;
+	tst_count++;
+
+	SAFE_WRITE(1, fd, fname, strlen(fname));
+	event_set[tst_count] = FAN_MODIFY;
+	tst_count++;
+
+	SAFE_CLOSE(fd);
+	event_set[tst_count] = FAN_CLOSE_WRITE;
+	tst_count++;
+
+	/*
+	 * Get list of events so far. We get events here to avoid
+	 * merging of following events with the previous ones.
+	 */
+	ret = SAFE_READ(0, fd_notify, event_buf,
+			EVENT_BUF_LEN);
+	len = ret;
+
+	fd = SAFE_OPEN(fname, O_RDONLY);
+	event_set[tst_count] = FAN_OPEN;
+	tst_count++;
+
+	SAFE_READ(0, fd, buf, BUF_SIZE);
+	event_set[tst_count] = FAN_ACCESS;
+	tst_count++;
+
+	SAFE_CLOSE(fd);
+	event_set[tst_count] = FAN_CLOSE_NOWRITE;
+	tst_count++;
+
+	/*
+	 * get next events
+	 */
+	ret = SAFE_READ(0, fd_notify, event_buf + len,
+			EVENT_BUF_LEN - len);
+	len += ret;
+
+	/*
+	 * now remove child mark
+	 */
+	if (fanotify_mark(fd_notify, FAN_MARK_REMOVE,
+			    FAN_EVENT_ON_CHILD, AT_FDCWD, ".") < 0) {
+		tst_brk(TBROK | TERRNO,
+		    "fanotify_mark (%d, FAN_MARK REMOVE, "
+		    "FAN_EVENT_ON_CHILD, AT_FDCWD, '.') failed",
+		    fd_notify);
+	}
 
-		/*
-		 * Do something to verify events didn't get generated
-		 */
-		fd = SAFE_OPEN(cleanup, fname, O_RDONLY);
+	/*
+	 * Do something to verify events didn't get generated
+	 */
+	fd = SAFE_OPEN(fname, O_RDONLY);
 
-		SAFE_CLOSE(cleanup, fd);
+	SAFE_CLOSE(fd);
 
-		fd = SAFE_OPEN(cleanup, ".", O_RDONLY | O_DIRECTORY);
-		event_set[tst_count] = FAN_OPEN;
-		tst_count++;
+	fd = SAFE_OPEN(".", O_RDONLY | O_DIRECTORY);
+	event_set[tst_count] = FAN_OPEN;
+	tst_count++;
 
-		SAFE_CLOSE(cleanup, fd);
-		event_set[tst_count] = FAN_CLOSE_NOWRITE;
-		tst_count++;
+	SAFE_CLOSE(fd);
+	event_set[tst_count] = FAN_CLOSE_NOWRITE;
+	tst_count++;
 
-		/*
-		 * Check events got generated only for the directory
-		 */
-		ret = SAFE_READ(cleanup, 0, fd_notify, event_buf + len,
-				EVENT_BUF_LEN - len);
-		len += ret;
+	/*
+	 * Check events got generated only for the directory
+	 */
+	ret = SAFE_READ(0, fd_notify, event_buf + len,
+			EVENT_BUF_LEN - len);
+	len += ret;
 
-		if (TST_TOTAL != tst_count) {
-			tst_brkm(TBROK, cleanup,
-				 "TST_TOTAL and tst_count are not equal");
+	if (TST_TOTAL != tst_count) {
+		tst_brk(TBROK,
+			 "TST_TOTAL and tst_count are not equal");
+	}
+	tst_count = 0;
+
+	/*
+	 * check events
+	 */
+	while (i < len) {
+		struct fanotify_event_metadata *event;
+
+		event = (struct fanotify_event_metadata *)&event_buf[i];
+		if (test_num >= TST_TOTAL) {
+			tst_res(TFAIL,
+				 "get unnecessary event: mask=%llx "
+				 "pid=%u fd=%u",
+				 (unsigned long long)event->mask,
+				 (unsigned)event->pid, event->fd);
+		} else if (!(event->mask & event_set[test_num])) {
+			tst_res(TFAIL,
+				 "get event: mask=%llx (expected %llx) "
+				 "pid=%u fd=%u",
+				 (unsigned long long)event->mask,
+				 event_set[test_num],
+				 (unsigned)event->pid, event->fd);
+		} else if (event->pid != getpid()) {
+			tst_res(TFAIL,
+				 "get event: mask=%llx pid=%u "
+				 "(expected %u) fd=%u",
+				 (unsigned long long)event->mask,
+				 (unsigned)event->pid,
+				 (unsigned)getpid(),
+				 event->fd);
+		} else {
+			tst_res(TPASS,
+				    "get event: mask=%llx pid=%u fd=%u",
+				    (unsigned long long)event->mask,
+				    (unsigned)event->pid, event->fd);
 		}
-		tst_count = 0;
-
-		/*
-		 * check events
-		 */
-		while (i < len) {
-			struct fanotify_event_metadata *event;
-
-			event = (struct fanotify_event_metadata *)&event_buf[i];
-			if (test_num >= TST_TOTAL) {
-				tst_resm(TFAIL,
-					 "get unnecessary event: mask=%llx "
-					 "pid=%u fd=%u",
-					 (unsigned long long)event->mask,
-					 (unsigned)event->pid, event->fd);
-			} else if (!(event->mask & event_set[test_num])) {
-				tst_resm(TFAIL,
-					 "get event: mask=%llx (expected %llx) "
-					 "pid=%u fd=%u",
-					 (unsigned long long)event->mask,
-					 event_set[test_num],
-					 (unsigned)event->pid, event->fd);
-			} else if (event->pid != getpid()) {
-				tst_resm(TFAIL,
-					 "get event: mask=%llx pid=%u "
-					 "(expected %u) fd=%u",
-					 (unsigned long long)event->mask,
-					 (unsigned)event->pid,
-					 (unsigned)getpid(),
-					 event->fd);
-			} else {
-				tst_resm(TPASS,
-					    "get event: mask=%llx pid=%u fd=%u",
-					    (unsigned long long)event->mask,
-					    (unsigned)event->pid, event->fd);
-			}
-			event->mask &= ~event_set[test_num];
-			/* No events left in current mask? Go for next event */
-			if (event->mask == 0) {
-				i += event->event_len;
-				close(event->fd);
-			}
-			test_num++;
-		}
-		for (; test_num < TST_TOTAL; test_num++) {
-			tst_resm(TFAIL, "didn't get event: mask=%llx",
-				 event_set[test_num]);
-
+		event->mask &= ~event_set[test_num];
+		/* No events left in current mask? Go for next event */
+		if (event->mask == 0) {
+			i += event->event_len;
+			close(event->fd);
 		}
+		test_num++;
 	}
+	for (; test_num < TST_TOTAL; test_num++) {
+		tst_res(TFAIL, "didn't get event: mask=%llx",
+			 event_set[test_num]);
 
-	cleanup();
-	tst_exit();
+	}
 }
 
 static void setup(void)
 {
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
 	sprintf(fname, "fname_%d", getpid());
-
-	if ((fd_notify = fanotify_init(FAN_CLASS_NOTIF, O_RDONLY)) < 0) {
-		if (errno == ENOSYS) {
-			tst_brkm(TCONF, cleanup,
-				 "fanotify is not configured in this kernel.");
-		} else {
-			tst_brkm(TBROK | TERRNO, cleanup,
-				 "fanotify_init failed");
-		}
-	}
+	fd_notify = SAFE_FANOTIFY_INIT(FAN_CLASS_NOTIF, O_RDONLY);
 }
 
 static void cleanup(void)
 {
-	if (fd_notify > 0 && close(fd_notify))
-		tst_resm(TWARN | TERRNO, "close(%d) failed", fd_notify);
-
-	tst_rmdir();
+	if (fd_notify > 0)
+		SAFE_CLOSE(fd_notify);
 }
 
-#else
-
-int main(void)
-{
-	tst_brkm(TCONF, NULL, "system doesn't have required fanotify support");
-}
+static struct tst_test test = {
+	.test_all = test01,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_tmpdir = 1,
+	.needs_root = 1
+};
 
+#else
+	TST_TEST_TCONF("system doesn't have required fanotify support");
 #endif
diff --git a/testcases/kernel/syscalls/fanotify/fanotify03.c b/testcases/kernel/syscalls/fanotify/fanotify03.c
index 2aca2e1..ce35661 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify03.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify03.c
@@ -38,13 +38,8 @@
 #include <string.h>
 #include <signal.h>
 #include <sys/syscall.h>
-#include "test.h"
-#include "lapi/syscalls.h"
+#include "tst_test.h"
 #include "fanotify.h"
-#include "safe_macros.h"
-
-char *TCID = "fanotify03";
-int TST_TOTAL = 3;
 
 #if defined(HAVE_SYS_FANOTIFY_H)
 #include <sys/fanotify.h>
@@ -55,10 +50,9 @@ int TST_TOTAL = 3;
 /* reasonable guess as to size of 1024 events */
 #define EVENT_BUF_LEN        (EVENT_MAX * EVENT_SIZE)
 
-static void setup(void);
-static void cleanup(void);
-
 #define BUF_SIZE 256
+#define TST_TOTAL 3
+
 static char fname[BUF_SIZE];
 static char buf[BUF_SIZE];
 static volatile int fd_notify;
@@ -109,7 +103,7 @@ static void run_child(void)
 	child_action.sa_flags = SA_NOCLDSTOP;
 
 	if (sigaction(SIGCHLD, &child_action, NULL) < 0) {
-		tst_brkm(TBROK | TERRNO, cleanup,
+		tst_brk(TBROK | TERRNO,
 			 "sigaction(SIGCHLD, &child_action, NULL) failed");
 	}
 
@@ -120,7 +114,7 @@ static void run_child(void)
 		generate_events();
 		exit(0);
 	case -1:
-		tst_brkm(TBROK | TERRNO, cleanup, "fork() failed");
+		tst_brk(TBROK | TERRNO, "fork() failed");
 	}
 }
 
@@ -133,171 +127,148 @@ static void check_child(void)
 	sigemptyset(&child_action.sa_mask);
 	child_action.sa_flags = SA_NOCLDSTOP;
 	if (sigaction(SIGCHLD, &child_action, NULL) < 0) {
-		tst_brkm(TBROK | TERRNO, cleanup,
+		tst_brk(TBROK | TERRNO,
 			 "sigaction(SIGCHLD, &child_action, NULL) failed");
 	}
 	if (waitpid(-1, &child_ret, 0) < 0) {
-		tst_brkm(TBROK | TERRNO, cleanup,
+		tst_brk(TBROK | TERRNO,
 				 "waitpid(-1, &child_ret, 0) failed");
 	}
 
 	if (WIFSIGNALED(child_ret)) {
-		tst_resm(TFAIL, "child exited due to signal %d",
+		tst_res(TFAIL, "child exited due to signal %d",
 			 WTERMSIG(child_ret));
 	} else if (WIFEXITED(child_ret)) {
 		if (WEXITSTATUS(child_ret) == 0)
-			tst_resm(TPASS, "child exited correctly");
+			tst_res(TPASS, "child exited correctly");
 		else
-			tst_resm(TFAIL, "child exited with status %d",
+			tst_res(TFAIL, "child exited with status %d",
 				 WEXITSTATUS(child_ret));
 	} else {
-		tst_resm(TFAIL, "child exited for unknown reason (status %d)",
+		tst_res(TFAIL, "child exited for unknown reason (status %d)",
 			 child_ret);
 	}
 }
 
-int main(int ac, char **av)
+void test01(void)
 {
-	int lc;
-	int fd_notify_backup = -1;
-
-	tst_parse_opts(ac, av, NULL, NULL);
+	int tst_count, fd_notify_backup = -1;
 
-	setup();
+	int ret, len = 0, i = 0, test_num = 0;
 
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		int ret, len = 0, i = 0, test_num = 0;
-
-		if (fd_notify_backup == -1) {
-			fd_notify_backup = dup(fd_notify);
-			if (fd_notify_backup < 0)
-				tst_brkm(TBROK | TERRNO, cleanup,
-					 "dup(%d) failed", fd_notify);
-		}
-		run_child();
+	if (fd_notify_backup == -1) {
+		fd_notify_backup = dup(fd_notify);
+		if (fd_notify_backup < 0)
+			tst_brk(TBROK | TERRNO,
+				 "dup(%d) failed", fd_notify);
+	}
+	run_child();
 
-		tst_count = 0;
+	tst_count = 0;
 
-		event_set[tst_count] = FAN_OPEN_PERM;
-		event_resp[tst_count++] = FAN_ALLOW;
-		event_set[tst_count] = FAN_ACCESS_PERM;
-		event_resp[tst_count++] = FAN_DENY;
+	event_set[tst_count] = FAN_OPEN_PERM;
+	event_resp[tst_count++] = FAN_ALLOW;
+	event_set[tst_count] = FAN_ACCESS_PERM;
+	event_resp[tst_count++] = FAN_DENY;
 
-		/* tst_count + 1 is for checking child return value */
-		if (TST_TOTAL != tst_count + 1) {
-			tst_brkm(TBROK, cleanup,
-				 "TST_TOTAL and tst_count do not match");
-		}
-		tst_count = 0;
-
-		/*
-		 * check events
-		 */
-		while (test_num < TST_TOTAL && fd_notify != -1) {
-			struct fanotify_event_metadata *event;
-
-			if (i == len) {
-				/* Get more events */
-				ret = read(fd_notify, event_buf + len,
-					   EVENT_BUF_LEN - len);
-				if (fd_notify == -1)
-					break;
-				if (ret < 0) {
-					tst_brkm(TBROK, cleanup,
-						 "read(%d, buf, %zu) failed",
-						 fd_notify, EVENT_BUF_LEN);
-				}
-				len += ret;
-			}
+	/* tst_count + 1 is for checking child return value */
+	if (TST_TOTAL != tst_count + 1) {
+		tst_brk(TBROK,
+			 "TST_TOTAL and tst_count do not match");
+	}
+	tst_count = 0;
 
-			event = (struct fanotify_event_metadata *)&event_buf[i];
-			if (!(event->mask & event_set[test_num])) {
-				tst_resm(TFAIL,
-					 "get event: mask=%llx (expected %llx) "
-					 "pid=%u fd=%u",
-					 (unsigned long long)event->mask,
-					 event_set[test_num],
-					 (unsigned)event->pid, event->fd);
-			} else if (event->pid != child_pid) {
-				tst_resm(TFAIL,
-					 "get event: mask=%llx pid=%u "
-					 "(expected %u) fd=%u",
-					 (unsigned long long)event->mask,
-					 (unsigned)event->pid,
-					 (unsigned)child_pid,
-					 event->fd);
-			} else {
-				tst_resm(TPASS,
-					    "get event: mask=%llx pid=%u fd=%u",
-					    (unsigned long long)event->mask,
-					    (unsigned)event->pid, event->fd);
-			}
-			/* Write response to permission event */
-			if (event_set[test_num] & FAN_ALL_PERM_EVENTS) {
-				struct fanotify_response resp;
-
-				resp.fd = event->fd;
-				resp.response = event_resp[test_num];
-				SAFE_WRITE(cleanup, 1, fd_notify, &resp,
-					   sizeof(resp));
-			}
-			event->mask &= ~event_set[test_num];
-			/* No events left in current mask? Go for next event */
-			if (event->mask == 0) {
-				i += event->event_len;
-				close(event->fd);
+	/*
+	 * check events
+	 */
+	while (test_num < TST_TOTAL && fd_notify != -1) {
+		struct fanotify_event_metadata *event;
+
+		if (i == len) {
+			/* Get more events */
+			ret = read(fd_notify, event_buf + len,
+				   EVENT_BUF_LEN - len);
+			if (fd_notify == -1)
+				break;
+			if (ret < 0) {
+				tst_brk(TBROK,
+					 "read(%d, buf, %zu) failed",
+					 fd_notify, EVENT_BUF_LEN);
 			}
-			test_num++;
+			len += ret;
 		}
-		for (; test_num < TST_TOTAL - 1; test_num++) {
-			tst_resm(TFAIL, "didn't get event: mask=%llx",
-				 event_set[test_num]);
 
+		event = (struct fanotify_event_metadata *)&event_buf[i];
+		if (!(event->mask & event_set[test_num])) {
+			tst_res(TFAIL,
+				 "get event: mask=%llx (expected %llx) "
+				 "pid=%u fd=%u",
+				 (unsigned long long)event->mask,
+				 event_set[test_num],
+				 (unsigned)event->pid, event->fd);
+		} else if (event->pid != child_pid) {
+			tst_res(TFAIL,
+				 "get event: mask=%llx pid=%u "
+				 "(expected %u) fd=%u",
+				 (unsigned long long)event->mask,
+				 (unsigned)event->pid,
+				 (unsigned)child_pid,
+				 event->fd);
+		} else {
+			tst_res(TPASS,
+				    "get event: mask=%llx pid=%u fd=%u",
+				    (unsigned long long)event->mask,
+				    (unsigned)event->pid, event->fd);
 		}
-		check_child();
-		/* We got SIGCHLD while running, resetup fd_notify */
-		if (fd_notify == -1) {
-			fd_notify = fd_notify_backup;
-			fd_notify_backup = -1;
+		/* Write response to permission event */
+		if (event_set[test_num] & FAN_ALL_PERM_EVENTS) {
+			struct fanotify_response resp;
+
+			resp.fd = event->fd;
+			resp.response = event_resp[test_num];
+			SAFE_WRITE(1, fd_notify, &resp,
+				   sizeof(resp));
 		}
+		event->mask &= ~event_set[test_num];
+		/* No events left in current mask? Go for next event */
+		if (event->mask == 0) {
+			i += event->event_len;
+			close(event->fd);
+		}
+		test_num++;
 	}
+	for (; test_num < TST_TOTAL - 1; test_num++) {
+		tst_res(TFAIL, "didn't get event: mask=%llx",
+			 event_set[test_num]);
 
-	cleanup();
-	tst_exit();
+	}
+	check_child();
+	/* We got SIGCHLD while running, resetup fd_notify */
+	if (fd_notify == -1) {
+		fd_notify = fd_notify_backup;
+		fd_notify_backup = -1;
+	}
 }
 
 static void setup(void)
 {
 	int fd;
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
 	sprintf(fname, "fname_%d", getpid());
-	fd = SAFE_OPEN(cleanup, fname, O_CREAT | O_RDWR, 0644);
-	SAFE_WRITE(cleanup, 1, fd, fname, 1);
-	SAFE_CLOSE(cleanup, fd);
-
-	if ((fd_notify = fanotify_init(FAN_CLASS_CONTENT, O_RDONLY)) < 0) {
-		if (errno == ENOSYS) {
-			tst_brkm(TCONF, cleanup,
-				 "fanotify is not configured in this kernel.");
-		} else {
-			tst_brkm(TBROK | TERRNO, cleanup,
-				 "fanotify_init failed");
-		}
-	}
+	fd = SAFE_OPEN(fname, O_CREAT | O_RDWR, 0644);
+	SAFE_WRITE(1, fd, fname, 1);
+	SAFE_CLOSE(fd);
+
+	fd_notify = SAFE_FANOTIFY_INIT(FAN_CLASS_CONTENT, O_RDONLY);
 
 	if (fanotify_mark(fd_notify, FAN_MARK_ADD, FAN_ACCESS_PERM |
 			    FAN_OPEN_PERM, AT_FDCWD, fname) < 0) {
 		if (errno == EINVAL) {
-			tst_brkm(TCONF | TERRNO, cleanup,
+			tst_brk(TCONF | TERRNO,
 				 "CONFIG_FANOTIFY_ACCESS_PERMISSIONS not "
 				 "configured in kernel?");
 		} else {
-			tst_brkm(TBROK | TERRNO, cleanup,
+			tst_brk(TBROK | TERRNO,
 				 "fanotify_mark (%d, FAN_MARK_ADD, FAN_ACCESS_PERM | "
 				 "FAN_OPEN_PERM, AT_FDCWD, %s) failed.", fd_notify, fname);
 		}
@@ -307,17 +278,18 @@ static void setup(void)
 
 static void cleanup(void)
 {
-	if (fd_notify > 0 && close(fd_notify))
-		tst_resm(TWARN | TERRNO, "close(%d) failed", fd_notify);
-
-	tst_rmdir();
+	if (fd_notify > 0)
+		SAFE_CLOSE(fd_notify);
 }
 
-#else
-
-int main(void)
-{
-	tst_brkm(TCONF, NULL, "system doesn't have required fanotify support");
-}
+static struct tst_test test = {
+	.test_all = test01,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_tmpdir = 1,
+	.needs_root = 1
+};
 
+#else
+	TST_TEST_TCONF("system doesn't have required fanotify support");
 #endif
diff --git a/testcases/kernel/syscalls/fanotify/fanotify04.c b/testcases/kernel/syscalls/fanotify/fanotify04.c
index dca52f0..302f124 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify04.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify04.c
@@ -36,13 +36,8 @@
 #include <errno.h>
 #include <string.h>
 #include <sys/syscall.h>
-#include "test.h"
-#include "lapi/syscalls.h"
+#include "tst_test.h"
 #include "fanotify.h"
-#include "safe_macros.h"
-
-char *TCID = "fanotify04";
-int TST_TOTAL = 9;
 
 #if defined(HAVE_SYS_FANOTIFY_H)
 #include <sys/fanotify.h>
@@ -53,10 +48,9 @@ int TST_TOTAL = 9;
 /* reasonable guess as to size of 1024 events */
 #define EVENT_BUF_LEN        (EVENT_MAX * EVENT_SIZE)
 
-static void setup(void);
-static void cleanup(void);
-
 #define BUF_SIZE 256
+#define TST_TOTAL 9
+
 static char fname[BUF_SIZE];
 static char sname[BUF_SIZE];
 static char dir[BUF_SIZE];
@@ -84,11 +78,11 @@ static void check_mark(char *file, unsigned long long flag, char *flagstr,
 {
 	if (fanotify_mark(fd_notify, FAN_MARK_ADD | flag, FAN_OPEN, AT_FDCWD,
 			    file) != expect) {
-		tst_resm(TFAIL,
+		tst_res(TFAIL,
 		    "fanotify_mark (%d, FAN_MARK_ADD | %s, FAN_OPEN, AT_FDCWD, "
 		    "'%s') %s", fd_notify, flagstr, file, expect_str_fail(expect));
 	} else {
-		tst_resm(TPASS,
+		tst_res(TPASS,
 		    "fanotify_mark (%d, FAN_MARK_ADD | %s, FAN_OPEN, AT_FDCWD, "
 		    "'%s') %s", fd_notify, flagstr, file, expect_str_pass(expect));
 
@@ -101,7 +95,7 @@ static void check_mark(char *file, unsigned long long flag, char *flagstr,
 
 		if (fanotify_mark(fd_notify, FAN_MARK_REMOVE | flag,
 				    FAN_OPEN, AT_FDCWD, file) < 0) {
-			tst_brkm(TBROK | TERRNO, cleanup,
+			tst_brk(TBROK | TERRNO,
 			    "fanotify_mark (%d, FAN_MARK_REMOVE | %s, "
 			    "FAN_OPEN, AT_FDCWD, '%s') failed",
 			    fd_notify, flagstr, file);
@@ -115,8 +109,8 @@ static void do_open(char *file, int flag, char *flagstr)
 {
 	int fd;
 
-	fd = SAFE_OPEN(cleanup, file, O_RDONLY | flag);
-	SAFE_CLOSE(cleanup, fd);
+	fd = SAFE_OPEN(file, O_RDONLY | flag);
+	SAFE_CLOSE(fd);
 }
 
 #define DO_OPEN(file, flag) do_open(file, flag, #flag)
@@ -138,22 +132,22 @@ static void verify_event(int mask)
 	struct stat st;
 
 	/* Read the event */
-	ret = SAFE_READ(cleanup, 0, fd_notify, event_buf + len,
+	ret = SAFE_READ(0, fd_notify, event_buf + len,
 			EVENT_BUF_LEN - len);
 	event = (struct fanotify_event_metadata *)&event_buf[len];
 	len += ret;
 
 	if (event->mask != FAN_OPEN) {
-		tst_resm(TFAIL, "got unexpected event %llx",
+		tst_res(TFAIL, "got unexpected event %llx",
 			 (unsigned long long)event->mask);
 	} else if (fstat(event->fd, &st) < 0) {
-		tst_resm(TFAIL, "failed to stat event->fd (%s)",
+		tst_res(TFAIL, "failed to stat event->fd (%s)",
 			 strerror(errno));
 	} else if ((st.st_mode & S_IFMT) != mask) {
-		tst_resm(TFAIL, "event->fd points to object of different type "
+		tst_res(TFAIL, "event->fd points to object of different type "
 			 "(%o != %o)", st.st_mode & S_IFMT, mask);
 	} else {
-		tst_resm(TPASS, "event generated properly for type %o", mask);
+		tst_res(TPASS, "event generated properly for type %o", mask);
 	}
 	close(event->fd);
 }
@@ -181,15 +175,15 @@ static void verify_no_event(void)
 		struct fanotify_event_metadata *event;
 
 		event = (struct fanotify_event_metadata *)&event_buf[len];
-		tst_resm(TFAIL, "seen unexpected event (mask %llx)",
+		tst_res(TFAIL, "seen unexpected event (mask %llx)",
 			 (unsigned long long)event->mask);
 		/* Cleanup fd from the event */
 		close(event->fd);
 	} else if (errno != EAGAIN) {
-		tst_resm(TFAIL | TERRNO, "read(%d, buf, %zu) failed", fd_notify,
+		tst_res(TFAIL | TERRNO, "read(%d, buf, %zu) failed", fd_notify,
 			 EVENT_BUF_LEN);
 	} else {
-		tst_resm(TPASS, "No event as expected");
+		tst_res(TPASS, "No event as expected");
 	}
 }
 
@@ -200,104 +194,81 @@ static void test_open_symlink(char *file)
 	verify_no_event();
 }
 
-int main(int ac, char **av)
+void test01(void)
 {
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* Check ONLYDIR on a directory */
-		CHECK_MARK(".", FAN_MARK_ONLYDIR, 0, NULL);
+	/* Check ONLYDIR on a directory */
+	CHECK_MARK(".", FAN_MARK_ONLYDIR, 0, NULL);
 
-		/* Check ONLYDIR without a directory */
-		CHECK_MARK(fname, FAN_MARK_ONLYDIR, -1, NULL);
+	/* Check ONLYDIR without a directory */
+	CHECK_MARK(fname, FAN_MARK_ONLYDIR, -1, NULL);
 
-		/* Check DONT_FOLLOW for a symlink */
-		CHECK_MARK(sname, FAN_MARK_DONT_FOLLOW, 0, test_open_symlink);
+	/* Check DONT_FOLLOW for a symlink */
+	CHECK_MARK(sname, FAN_MARK_DONT_FOLLOW, 0, test_open_symlink);
 
-		/* Check without DONT_FOLLOW for a symlink */
-		CHECK_MARK(sname, 0, 0, test_open_file);
+	/* Check without DONT_FOLLOW for a symlink */
+	CHECK_MARK(sname, 0, 0, test_open_file);
 
-		/* Verify FAN_MARK_FLUSH destroys all inode marks */
-		if (fanotify_mark(fd_notify, FAN_MARK_ADD,
-				    FAN_OPEN, AT_FDCWD, fname) < 0) {
-			tst_brkm(TBROK | TERRNO, cleanup,
-			    "fanotify_mark (%d, FAN_MARK_ADD, FAN_OPEN, "
-			    "AT_FDCWD, '%s') failed", fd_notify, fname);
-		}
-		if (fanotify_mark(fd_notify, FAN_MARK_ADD,
-				    FAN_OPEN | FAN_ONDIR, AT_FDCWD, dir) < 0) {
-			tst_brkm(TBROK | TERRNO, cleanup,
-			    "fanotify_mark (%d, FAN_MARK_ADD, FAN_OPEN | "
-			    "FAN_ONDIR, AT_FDCWD, '%s') failed", fd_notify,
-			    dir);
-		}
-		open_file(fname);
-		verify_event(S_IFREG);
-		open_dir(dir);
-		verify_event(S_IFDIR);
-		if (fanotify_mark(fd_notify, FAN_MARK_FLUSH,
-				    0, AT_FDCWD, ".") < 0) {
-			tst_brkm(TBROK | TERRNO, cleanup,
-			    "fanotify_mark (%d, FAN_MARK_FLUSH, 0, "
-			    "AT_FDCWD, '.') failed", fd_notify);
-		}
-
-		open_dir(dir);
-		verify_no_event();
+	/* Verify FAN_MARK_FLUSH destroys all inode marks */
+	if (fanotify_mark(fd_notify, FAN_MARK_ADD,
+			    FAN_OPEN, AT_FDCWD, fname) < 0) {
+		tst_brk(TBROK | TERRNO,
+		    "fanotify_mark (%d, FAN_MARK_ADD, FAN_OPEN, "
+		    "AT_FDCWD, '%s') failed", fd_notify, fname);
+	}
+	if (fanotify_mark(fd_notify, FAN_MARK_ADD,
+			    FAN_OPEN | FAN_ONDIR, AT_FDCWD, dir) < 0) {
+		tst_brk(TBROK | TERRNO,
+		    "fanotify_mark (%d, FAN_MARK_ADD, FAN_OPEN | "
+		    "FAN_ONDIR, AT_FDCWD, '%s') failed", fd_notify,
+		    dir);
+	}
+	open_file(fname);
+	verify_event(S_IFREG);
+	open_dir(dir);
+	verify_event(S_IFDIR);
+	if (fanotify_mark(fd_notify, FAN_MARK_FLUSH,
+			    0, AT_FDCWD, ".") < 0) {
+		tst_brk(TBROK | TERRNO,
+		    "fanotify_mark (%d, FAN_MARK_FLUSH, 0, "
+		    "AT_FDCWD, '.') failed", fd_notify);
 	}
 
-	cleanup();
-	tst_exit();
+	open_dir(dir);
+	verify_no_event();
 }
 
 static void setup(void)
 {
 	int fd;
 
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
 	sprintf(fname, "fname_%d", getpid());
-	fd = SAFE_OPEN(cleanup, fname, O_RDWR | O_CREAT, 0644);
-	SAFE_CLOSE(cleanup, fd);
+	fd = SAFE_OPEN(fname, O_RDWR | O_CREAT, 0644);
+	SAFE_CLOSE(fd);
 
 	sprintf(sname, "symlink_%d", getpid());
-	SAFE_SYMLINK(cleanup, fname, sname);
+	SAFE_SYMLINK(fname, sname);
 
 	sprintf(dir, "dir_%d", getpid());
-	SAFE_MKDIR(cleanup, dir, 0755);
-
-	if ((fd_notify = fanotify_init(FAN_CLASS_NOTIF | FAN_NONBLOCK,
-					 O_RDONLY)) < 0) {
-		if (errno == ENOSYS) {
-			tst_brkm(TCONF, cleanup,
-				 "fanotify is not configured in this kernel.");
-		} else {
-			tst_brkm(TBROK | TERRNO, cleanup,
-				 "fanotify_init failed");
-		}
-	}
+	SAFE_MKDIR(dir, 0755);
+
+	fd_notify = SAFE_FANOTIFY_INIT(FAN_CLASS_NOTIF | FAN_NONBLOCK,
+			O_RDONLY);
 }
 
 static void cleanup(void)
 {
-	if (fd_notify > 0 && close(fd_notify))
-		tst_resm(TWARN | TERRNO, "close(%d) failed", fd_notify);
-
-	tst_rmdir();
+	if (fd_notify > 0)
+		SAFE_CLOSE(fd_notify);
 }
 
-#else
-
-int main(void)
-{
-	tst_brkm(TCONF, NULL, "system doesn't have required fanotify support");
-}
+static struct tst_test test = {
+	.test_all = test01,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_tmpdir = 1,
+	.needs_root = 1
+};
 
+#else
+	TST_TEST_TCONF("system doesn't have required fanotify support");
 #endif
diff --git a/testcases/kernel/syscalls/fanotify/fanotify05.c b/testcases/kernel/syscalls/fanotify/fanotify05.c
index 6063764..ec615e6 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify05.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify05.c
@@ -34,13 +34,8 @@
 #include <errno.h>
 #include <string.h>
 #include <sys/syscall.h>
-#include "test.h"
-#include "lapi/syscalls.h"
+#include "tst_test.h"
 #include "fanotify.h"
-#include "safe_macros.h"
-
-char *TCID = "fanotify05";
-int TST_TOTAL = 1;
 
 #if defined(HAVE_SYS_FANOTIFY_H)
 #include <sys/fanotify.h>
@@ -48,110 +43,84 @@ int TST_TOTAL = 1;
 /* Currently this is fixed in kernel... */
 #define MAX_EVENTS 16384
 
-static void setup(void);
-static void cleanup(void);
-
 #define BUF_SIZE 256
 static char fname[BUF_SIZE];
 static int fd, fd_notify;
 
 struct fanotify_event_metadata event;
 
-int main(int ac, char **av)
+void test01(void)
 {
-	int lc, i;
+	int i;
 	int len;
 
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
+	/*
+	 * generate events
+	 */
+	for (i = 0; i < MAX_EVENTS + 1; i++) {
+		sprintf(fname, "fname_%d", i);
+		fd = SAFE_OPEN(fname, O_RDWR | O_CREAT, 0644);
+		SAFE_CLOSE(fd);
+	}
 
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
+	while (1) {
 		/*
-		 * generate events
+		 * get list on events
 		 */
-		for (i = 0; i < MAX_EVENTS + 1; i++) {
-			sprintf(fname, "fname_%d", i);
-			fd = SAFE_OPEN(cleanup, fname, O_RDWR | O_CREAT, 0644);
-			SAFE_CLOSE(cleanup, fd);
-		}
-
-		while (1) {
-			/*
-			 * get list on events
-			 */
-			len = read(fd_notify, &event, sizeof(event));
-			if (len < 0) {
-				if (errno == -EAGAIN) {
-					tst_resm(TFAIL, "Overflow event not "
-						 "generated!\n");
-					break;
-				}
-				tst_brkm(TBROK | TERRNO, cleanup,
-					 "read of notification event failed");
+		len = read(fd_notify, &event, sizeof(event));
+		if (len < 0) {
+			if (errno == -EAGAIN) {
+				tst_res(TFAIL, "Overflow event not "
+					 "generated!\n");
 				break;
 			}
-			if (event.fd != FAN_NOFD)
-				close(event.fd);
+			tst_brk(TBROK | TERRNO,
+				 "read of notification event failed");
+			break;
+		}
+		if (event.fd != FAN_NOFD)
+			close(event.fd);
 
-			/*
-			 * check events
-			 */
-			if (event.mask != FAN_OPEN &&
-			    event.mask != FAN_Q_OVERFLOW) {
-				tst_resm(TFAIL,
-					 "get event: mask=%llx (expected %llx)"
-					 "pid=%u fd=%d",
+		/*
+		 * check events
+		 */
+		if (event.mask != FAN_OPEN &&
+		    event.mask != FAN_Q_OVERFLOW) {
+			tst_res(TFAIL,
+				 "get event: mask=%llx (expected %llx)"
+				 "pid=%u fd=%d",
+				 (unsigned long long)event.mask,
+				 (unsigned long long)FAN_OPEN,
+				 (unsigned)event.pid, event.fd);
+			break;
+		}
+		if (event.mask == FAN_Q_OVERFLOW) {
+			if (event.fd != FAN_NOFD) {
+				tst_res(TFAIL,
+					 "invalid overflow event: "
+					 "mask=%llx pid=%u fd=%d",
 					 (unsigned long long)event.mask,
-					 (unsigned long long)FAN_OPEN,
-					 (unsigned)event.pid, event.fd);
+					 (unsigned)event.pid,
+					 event.fd);
 				break;
 			}
-			if (event.mask == FAN_Q_OVERFLOW) {
-				if (event.fd != FAN_NOFD) {
-					tst_resm(TFAIL,
-						 "invalid overflow event: "
-						 "mask=%llx pid=%u fd=%d",
-						 (unsigned long long)event.mask,
-						 (unsigned)event.pid,
-						 event.fd);
-					break;
-				}
-				tst_resm(TPASS,
-					 "get event: mask=%llx pid=%u fd=%d",
-					 (unsigned long long)event.mask,
-					 (unsigned)event.pid, event.fd);
-					break;
-			}
+			tst_res(TPASS,
+				 "get event: mask=%llx pid=%u fd=%d",
+				 (unsigned long long)event.mask,
+				 (unsigned)event.pid, event.fd);
+				break;
 		}
 	}
-
-	cleanup();
-	tst_exit();
 }
 
 static void setup(void)
 {
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
-	fd_notify = fanotify_init(FAN_CLASS_NOTIF | FAN_NONBLOCK, O_RDONLY);
-	if (fd_notify < 0) {
-		if (errno == ENOSYS) {
-			tst_brkm(TCONF, cleanup,
-				 "fanotify is not configured in this kernel.");
-		} else {
-			tst_brkm(TBROK | TERRNO, cleanup,
-				 "fanotify_init failed");
-		}
-	}
+	fd_notify = SAFE_FANOTIFY_INIT(FAN_CLASS_NOTIF | FAN_NONBLOCK,
+			O_RDONLY);
 
 	if (fanotify_mark(fd_notify, FAN_MARK_MOUNT | FAN_MARK_ADD, FAN_OPEN,
 			    AT_FDCWD, ".") < 0) {
-		tst_brkm(TBROK | TERRNO, cleanup,
+		tst_brk(TBROK | TERRNO,
 			 "fanotify_mark (%d, FAN_MARK_MOUNT | FAN_MARK_ADD, "
 			 "FAN_OPEN, AT_FDCWD, \".\") failed",
 			 fd_notify);
@@ -160,17 +129,17 @@ static void setup(void)
 
 static void cleanup(void)
 {
-	if (fd_notify > 0 && close(fd_notify))
-		tst_resm(TWARN | TERRNO, "close(%d) failed", fd_notify);
-
-	tst_rmdir();
+	if (fd_notify > 0)
+		SAFE_CLOSE(fd_notify);
 }
 
+static struct tst_test test = {
+	.test_all = test01,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+};
 #else
-
-int main(void)
-{
-	tst_brkm(TCONF, NULL, "system doesn't have required fanotify support");
-}
-
+	TST_TEST_TCONF("system doesn't have required fanotify support");
 #endif
diff --git a/testcases/kernel/syscalls/fanotify/fanotify06.c b/testcases/kernel/syscalls/fanotify/fanotify06.c
index d7fef6d..7b9d632 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify06.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify06.c
@@ -34,6 +34,7 @@
  *
  *      fanotify: fix notification of groups with inode & mount marks
  */
+#define _GNU_SOURCE
 #include "config.h"
 
 #include <stdio.h>
@@ -44,12 +45,8 @@
 #include <string.h>
 #include <sys/mount.h>
 #include <sys/syscall.h>
-#include "test.h"
-#include "lapi/syscalls.h"
+#include "tst_test.h"
 #include "fanotify.h"
-#include "safe_macros.h"
-
-char *TCID = "fanotify06";
 
 #if defined(HAVE_SYS_FANOTIFY_H)
 #include <sys/fanotify.h>
@@ -72,8 +69,6 @@ unsigned int fanotify_prio[] = {
 
 #define GROUPS_PER_PRIO 3
 
-int TST_TOTAL = GROUPS_PER_PRIO * FANOTIFY_PRIORITIES;
-
 #define BUF_SIZE 256
 static char fname[BUF_SIZE];
 static int fd;
@@ -91,26 +86,17 @@ static void create_fanotify_groups(void)
 
 	for (p = 0; p < FANOTIFY_PRIORITIES; p++) {
 		for (i = 0; i < GROUPS_PER_PRIO; i++) {
-			fd_notify[p][i] = fanotify_init(fanotify_prio[p] |
+			fd_notify[p][i] = SAFE_FANOTIFY_INIT(fanotify_prio[p] |
 							FAN_NONBLOCK,
 							O_RDONLY);
-			if (fd_notify[p][i] < 0) {
-				if (errno == ENOSYS) {
-					tst_brkm(TCONF, cleanup,
-						 "fanotify is not configured in"
-						 " this kernel.");
-				} else {
-					tst_brkm(TBROK | TERRNO, cleanup,
-						 "fanotify_init failed");
-				}
-			}
+
 			/* Add mount mark for each group */
 			ret = fanotify_mark(fd_notify[p][i],
 					    FAN_MARK_ADD | FAN_MARK_MOUNT,
 					    FAN_MODIFY,
 					    AT_FDCWD, ".");
 			if (ret < 0) {
-				tst_brkm(TBROK | TERRNO, cleanup,
+				tst_brk(TBROK | TERRNO,
 					 "fanotify_mark(%d, FAN_MARK_ADD | "
 					 "FAN_MARK_MOUNT, FAN_MODIFY, AT_FDCWD,"
 					 " '.') failed", fd_notify[p][i]);
@@ -124,7 +110,7 @@ static void create_fanotify_groups(void)
 					    FAN_MARK_IGNORED_SURV_MODIFY,
 					    FAN_MODIFY, AT_FDCWD, fname);
 			if (ret < 0) {
-				tst_brkm(TBROK | TERRNO, cleanup,
+				tst_brk(TBROK | TERRNO,
 					 "fanotify_mark(%d, FAN_MARK_ADD | "
 					 "FAN_MARK_IGNORED_MASK | "
 					 "FAN_MARK_IGNORED_SURV_MODIFY, "
@@ -143,7 +129,7 @@ static void cleanup_fanotify_groups(void)
 		for (i = 0; i < GROUPS_PER_PRIO; i++) {
 			if (fd_notify[p][i] && fd_notify[p][i] != -1) {
 				if (close(fd_notify[p][i]) == -1)
-					tst_resm(TWARN, "close(%d) failed",
+					tst_res(TWARN, "close(%d) failed",
 						 fd_notify[p][i]);
 				fd_notify[p][i] = 0;
 			}
@@ -154,115 +140,97 @@ static void cleanup_fanotify_groups(void)
 static void verify_event(int group, struct fanotify_event_metadata *event)
 {
 	if (event->mask != FAN_MODIFY) {
-		tst_resm(TFAIL, "group %d get event: mask %llx (expected %llx) "
+		tst_res(TFAIL, "group %d get event: mask %llx (expected %llx) "
 			 "pid=%u fd=%u", group, (unsigned long long)event->mask,
 			 (unsigned long long)FAN_MODIFY,
 			 (unsigned)event->pid, event->fd);
 	} else if (event->pid != getpid()) {
-		tst_resm(TFAIL, "group %d get event: mask %llx pid=%u "
+		tst_res(TFAIL, "group %d get event: mask %llx pid=%u "
 			 "(expected %u) fd=%u", group,
 			 (unsigned long long)event->mask, (unsigned)event->pid,
 			 (unsigned)getpid(), event->fd);
 	} else {
-		tst_resm(TPASS, "group %d get event: mask %llx pid=%u fd=%u",
+		tst_res(TPASS, "group %d get event: mask %llx pid=%u fd=%u",
 			 group, (unsigned long long)event->mask,
 			 (unsigned)event->pid, event->fd);
 	}
 }
 
-int main(int ac, char **av)
+void test01(void)
 {
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		int ret;
-		unsigned int p, i;
-		struct fanotify_event_metadata *event;
-
-		create_fanotify_groups();
-
-		/*
-		 * generate sequence of events
-		 */
-		fd = SAFE_OPEN(cleanup, fname, O_RDWR);
-		SAFE_WRITE(cleanup, 1, fd, fname, strlen(fname));
-		SAFE_CLOSE(cleanup, fd);
-
-		/* First verify all groups without ignore mask got the event */
-		for (i = 0; i < GROUPS_PER_PRIO; i++) {
-			ret = read(fd_notify[0][i], event_buf, EVENT_BUF_LEN);
-			if (ret < 0) {
-				if (errno == EAGAIN) {
-					tst_resm(TFAIL, "group %d did not get "
-						 "event", i);
-				}
-				tst_brkm(TBROK | TERRNO, cleanup,
-					 "reading fanotify events failed");
-			}
-			if (ret < (int)FAN_EVENT_METADATA_LEN) {
-				tst_brkm(TBROK, cleanup,
-					 "short read when reading fanotify "
-					 "events (%d < %d)", ret,
-					 (int)EVENT_BUF_LEN);
+	int ret;
+	unsigned int p, i;
+	struct fanotify_event_metadata *event;
+
+	create_fanotify_groups();
+
+	/*
+	 * generate sequence of events
+	 */
+	fd = SAFE_OPEN(fname, O_RDWR);
+	SAFE_WRITE(1, fd, fname, strlen(fname));
+	SAFE_CLOSE(fd);
+
+	/* First verify all groups without ignore mask got the event */
+	for (i = 0; i < GROUPS_PER_PRIO; i++) {
+		ret = read(fd_notify[0][i], event_buf, EVENT_BUF_LEN);
+		if (ret < 0) {
+			if (errno == EAGAIN) {
+				tst_res(TFAIL, "group %d did not get "
+					 "event", i);
 			}
-			event = (struct fanotify_event_metadata *)event_buf;
-			if (ret > (int)event->event_len) {
-				tst_resm(TFAIL, "group %d got more than one "
-					 "event (%d > %d)", i, ret,
-					 event->event_len);
-			} else
-				verify_event(i, event);
-			close(event->fd);
+			tst_brk(TBROK | TERRNO,
+				 "reading fanotify events failed");
 		}
-		for (p = 1; p < FANOTIFY_PRIORITIES; p++) {
-			for (i = 0; i < GROUPS_PER_PRIO; i++) {
-				ret = read(fd_notify[p][i], event_buf, EVENT_BUF_LEN);
-				if (ret > 0) {
-					tst_resm(TFAIL, "group %d got event",
-						 p*GROUPS_PER_PRIO + i);
-				} else if (ret == 0) {
-					tst_brkm(TBROK, cleanup, "zero length "
-						 "read from fanotify fd");
-				} else if (errno != EAGAIN) {
-					tst_brkm(TBROK | TERRNO, cleanup,
-						 "reading fanotify events failed");
-				} else {
-					tst_resm(TPASS, "group %d got no event",
-						 p*GROUPS_PER_PRIO + i);
-				}
+		if (ret < (int)FAN_EVENT_METADATA_LEN) {
+			tst_brk(TBROK,
+				 "short read when reading fanotify "
+				 "events (%d < %d)", ret,
+				 (int)EVENT_BUF_LEN);
+		}
+		event = (struct fanotify_event_metadata *)event_buf;
+		if (ret > (int)event->event_len) {
+			tst_res(TFAIL, "group %d got more than one "
+				 "event (%d > %d)", i, ret,
+				 event->event_len);
+		} else
+			verify_event(i, event);
+		close(event->fd);
+	}
+	for (p = 1; p < FANOTIFY_PRIORITIES; p++) {
+		for (i = 0; i < GROUPS_PER_PRIO; i++) {
+			ret = read(fd_notify[p][i], event_buf, EVENT_BUF_LEN);
+			if (ret > 0) {
+				tst_res(TFAIL, "group %d got event",
+					 p*GROUPS_PER_PRIO + i);
+			} else if (ret == 0) {
+				tst_brk(TBROK, "zero length "
+					 "read from fanotify fd");
+			} else if (errno != EAGAIN) {
+				tst_brk(TBROK | TERRNO,
+					 "reading fanotify events failed");
+			} else {
+				tst_res(TPASS, "group %d got no event",
+					 p*GROUPS_PER_PRIO + i);
 			}
 		}
-		cleanup_fanotify_groups();
 	}
-
-	cleanup();
-	tst_exit();
+	cleanup_fanotify_groups();
 }
 
 static void setup(void)
 {
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_require_root();
-	tst_tmpdir();
-
-	SAFE_MKDIR(cleanup, MOUNT_NAME, 0755);
-	SAFE_MOUNT(cleanup, MOUNT_NAME, MOUNT_NAME, NULL, MS_BIND, NULL);
+	SAFE_MKDIR(MOUNT_NAME, 0755);
+	SAFE_MOUNT(MOUNT_NAME, MOUNT_NAME, NULL, MS_BIND, NULL);
 	mount_created = 1;
-	SAFE_CHDIR(cleanup, MOUNT_NAME);
+	SAFE_CHDIR(MOUNT_NAME);
 
 	sprintf(fname, "tfile_%d", getpid());
-	fd = SAFE_OPEN(cleanup, fname, O_RDWR | O_CREAT, 0700);
-	SAFE_WRITE(cleanup, 1, fd, fname, 1);
+	fd = SAFE_OPEN(fname, O_RDWR | O_CREAT, 0700);
+	SAFE_WRITE(1, fd, fname, 1);
 
 	/* close the file we have open */
-	SAFE_CLOSE(cleanup, fd);
+	SAFE_CLOSE(fd);
 }
 
 static void cleanup(void)
@@ -270,19 +238,20 @@ static void cleanup(void)
 	cleanup_fanotify_groups();
 
 	if (chdir(tst_get_tmpdir()) < 0)
-		tst_brkm(TBROK, NULL, "chdir(tmpdir) failed");
+		tst_brk(TBROK, "chdir(tmpdir) failed");
 
 	if (mount_created && tst_umount(MOUNT_NAME) < 0)
-		tst_brkm(TBROK | TERRNO, NULL, "umount failed");
-
-	tst_rmdir();
+		tst_brk(TBROK | TERRNO, "umount failed");
 }
 
-#else
-
-int main(void)
-{
-	tst_brkm(TCONF, NULL, "system doesn't have required fanotify support");
-}
+static struct tst_test test = {
+	.test_all = test01,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_tmpdir = 1,
+	.needs_root = 1
+};
 
+#else
+	TST_TEST_TCONF("system doesn't have required fanotify support");
 #endif
diff --git a/testcases/kernel/syscalls/fanotify/fanotify07.c b/testcases/kernel/syscalls/fanotify/fanotify07.c
index 54e5a1f..af95c39 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify07.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify07.c
@@ -119,14 +119,7 @@ static int setup_instance(void)
 {
 	int fd;
 
-	if ((fd = fanotify_init(FAN_CLASS_CONTENT, O_RDONLY)) < 0) {
-		if (errno == ENOSYS) {
-			tst_brk(TCONF,
-				"fanotify is not configured in this kernel.");
-		} else {
-			tst_brk(TBROK | TERRNO, "fanotify_init failed");
-		}
-	}
+	fd = SAFE_FANOTIFY_INIT(FAN_CLASS_CONTENT, O_RDONLY);
 
 	if (fanotify_mark(fd, FAN_MARK_ADD, FAN_ACCESS_PERM, AT_FDCWD,
 			  fname) < 0) {
-- 
1.8.3.1

