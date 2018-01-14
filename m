From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 14 Jan 2018 17:12:57 +0200
Subject: [LTP] [PATCH 2/3] inotify: rewrite old cases with new lib
In-Reply-To: <1515942778-12633-1-git-send-email-amir73il@gmail.com>
References: <1515942778-12633-1-git-send-email-amir73il@gmail.com>
Message-ID: <1515942778-12633-3-git-send-email-amir73il@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 testcases/kernel/syscalls/inotify/inotify.h   |  10 +-
 testcases/kernel/syscalls/inotify/inotify01.c | 258 ++++++++----------
 testcases/kernel/syscalls/inotify/inotify02.c | 366 ++++++++++++--------------
 testcases/kernel/syscalls/inotify/inotify03.c | 156 +++++------
 testcases/kernel/syscalls/inotify/inotify04.c | 161 +++++------
 testcases/kernel/syscalls/inotify/inotify05.c | 193 ++++++--------
 testcases/kernel/syscalls/inotify/inotify06.c |  61 ++---
 7 files changed, 524 insertions(+), 681 deletions(-)

diff --git a/testcases/kernel/syscalls/inotify/inotify.h b/testcases/kernel/syscalls/inotify/inotify.h
index a364e14..ba8ab12 100644
--- a/testcases/kernel/syscalls/inotify/inotify.h
+++ b/testcases/kernel/syscalls/inotify/inotify.h
@@ -28,20 +28,22 @@
 #ifndef	_INOTIFY_H
 #define	_INOTIFY_H
 
+#include "lapi/syscalls.h"
+
 /* inotify(7) wrappers */
 
 #if __NR_inotify_init != __LTP__NR_INVALID_SYSCALL
 #define	myinotify_init() \
-	ltp_syscall(__NR_inotify_init)
+	tst_syscall(__NR_inotify_init)
 #else
 #define	myinotify_init() \
-	ltp_syscall(__NR_inotify_init1, 0)
+	tst_syscall(__NR_inotify_init1, 0)
 #endif
 
 #define	myinotify_add_watch(fd, pathname, mask)	\
-	ltp_syscall(__NR_inotify_add_watch, fd, pathname, mask)
+	tst_syscall(__NR_inotify_add_watch, fd, pathname, mask)
 
 #define	myinotify_rm_watch(fd, wd) \
-	ltp_syscall(__NR_inotify_rm_watch, fd, wd)
+	tst_syscall(__NR_inotify_rm_watch, fd, wd)
 
 #endif /* _INOTIFY_H */
diff --git a/testcases/kernel/syscalls/inotify/inotify01.c b/testcases/kernel/syscalls/inotify/inotify01.c
index 5ea9271..d3153ac 100644
--- a/testcases/kernel/syscalls/inotify/inotify01.c
+++ b/testcases/kernel/syscalls/inotify/inotify01.c
@@ -37,26 +37,20 @@
 #include <errno.h>
 #include <string.h>
 #include <sys/syscall.h>
-#include "test.h"
-#include "safe_macros.h"
-#include "lapi/syscalls.h"
+#include "tst_test.h"
 #include "inotify.h"
 
 #if defined(HAVE_SYS_INOTIFY_H)
 #include <sys/inotify.h>
 
+#define TST_TOTAL 7
+
 #define EVENT_MAX 1024
 /* size of the event structure, not counting name */
 #define EVENT_SIZE  (sizeof (struct inotify_event))
 /* reasonable guess as to size of 1024 events */
 #define EVENT_BUF_LEN        (EVENT_MAX * (EVENT_SIZE + 16))
 
-char *TCID = "inotify01";
-int TST_TOTAL = 7;
-
-static void setup(void);
-static void cleanup(void);
-
 #define BUF_SIZE 256
 static char fname[BUF_SIZE];
 static char buf[BUF_SIZE];
@@ -67,160 +61,141 @@ static unsigned int event_set[EVENT_MAX];
 
 static char event_buf[EVENT_BUF_LEN];
 
-int main(int ac, char **av)
+void verify_inotify(void)
 {
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		/*
-		 * generate sequence of events
-		 */
-		SAFE_CHMOD(cleanup, fname, 0755);
-		event_set[tst_count] = IN_ATTRIB;
-		tst_count++;
-
-		if ((fd = open(fname, O_RDONLY)) == -1) {
-			tst_brkm(TBROK | TERRNO, cleanup,
-				 "open(%s, O_RDWR|O_CREAT,0700) failed", fname);
-		}
-		event_set[tst_count] = IN_OPEN;
-		tst_count++;
-
-		if (read(fd, buf, BUF_SIZE) == -1) {
-			tst_brkm(TBROK | TERRNO, cleanup,
-				 "read(%d, buf, %d) failed", fd, BUF_SIZE);
-		}
-		event_set[tst_count] = IN_ACCESS;
-		tst_count++;
+	int tst_count = 0;
+
+	/*
+	 * generate sequence of events
+	 */
+	SAFE_CHMOD(fname, 0755);
+	event_set[tst_count] = IN_ATTRIB;
+	tst_count++;
+
+	if ((fd = open(fname, O_RDONLY)) == -1) {
+		tst_brk(TBROK | TERRNO,
+			"open(%s, O_RDWR|O_CREAT,0700) failed", fname);
+	}
+	event_set[tst_count] = IN_OPEN;
+	tst_count++;
 
-		SAFE_CLOSE(cleanup, fd);
-		event_set[tst_count] = IN_CLOSE_NOWRITE;
-		tst_count++;
+	if (read(fd, buf, BUF_SIZE) == -1) {
+		tst_brk(TBROK | TERRNO,
+			"read(%d, buf, %d) failed", fd, BUF_SIZE);
+	}
+	event_set[tst_count] = IN_ACCESS;
+	tst_count++;
 
-		if ((fd = open(fname, O_RDWR | O_CREAT, 0700)) == -1) {
-			tst_brkm(TBROK, cleanup,
-				 "open(%s, O_RDWR|O_CREAT,0700) failed", fname);
-		}
-		event_set[tst_count] = IN_OPEN;
-		tst_count++;
+	SAFE_CLOSE(fd);
+	event_set[tst_count] = IN_CLOSE_NOWRITE;
+	tst_count++;
 
-		if (write(fd, buf, BUF_SIZE) == -1) {
-			tst_brkm(TBROK, cleanup,
-				 "write(%d, %s, 1) failed", fd, fname);
-		}
-		event_set[tst_count] = IN_MODIFY;
-		tst_count++;
+	if ((fd = open(fname, O_RDWR | O_CREAT, 0700)) == -1) {
+		tst_brk(TBROK,
+			"open(%s, O_RDWR|O_CREAT,0700) failed", fname);
+	}
+	event_set[tst_count] = IN_OPEN;
+	tst_count++;
 
-		SAFE_CLOSE(cleanup, fd);
-		event_set[tst_count] = IN_CLOSE_WRITE;
-		tst_count++;
+	if (write(fd, buf, BUF_SIZE) == -1) {
+		tst_brk(TBROK,
+			"write(%d, %s, 1) failed", fd, fname);
+	}
+	event_set[tst_count] = IN_MODIFY;
+	tst_count++;
 
-		if (TST_TOTAL != tst_count) {
-			tst_brkm(TBROK, cleanup,
-				 "TST_TOTAL and tst_count are not equal");
-		}
-		tst_count = 0;
+	SAFE_CLOSE(fd);
+	event_set[tst_count] = IN_CLOSE_WRITE;
+	tst_count++;
 
-		/*
-		 * get list on events
-		 */
-		int len, i = 0, test_num = 0;
-		if ((len = read(fd_notify, event_buf, EVENT_BUF_LEN)) < 0) {
-			tst_brkm(TBROK, cleanup,
-				 "read(%d, buf, %zu) failed",
-				 fd_notify, EVENT_BUF_LEN);
+	if (TST_TOTAL != tst_count) {
+		tst_brk(TBROK,
+			"TST_TOTAL and tst_count are not equal");
+	}
+	tst_count = 0;
 
-		}
+	/*
+	 * get list on events
+	 */
+	int len, i = 0, test_num = 0;
+	if ((len = read(fd_notify, event_buf, EVENT_BUF_LEN)) < 0) {
+		tst_brk(TBROK,
+			"read(%d, buf, %zu) failed",
+			fd_notify, EVENT_BUF_LEN);
 
-		/*
-		 * check events
-		 */
-		while (i < len) {
-			struct inotify_event *event;
-			event = (struct inotify_event *)&event_buf[i];
-			if (test_num >= TST_TOTAL) {
-				tst_resm(TFAIL,
-					 "get unnecessary event: wd=%d mask=%x "
-					 "cookie=%u len=%u",
-					 event->wd, event->mask,
-					 event->cookie, event->len);
-			} else if (event_set[test_num] == event->mask) {
-				if (event->cookie != 0) {
-					tst_resm(TFAIL,
-						 "get event: wd=%d mask=%x "
-						 "cookie=%u (expected 0) len=%u",
-						 event->wd, event->mask,
-						 event->cookie, event->len);
-				} else {
-					tst_resm(TPASS, "get event: wd=%d "
-						 "mask=%x cookie=%u len=%u",
-						 event->wd, event->mask,
-						 event->cookie, event->len);
-				}
+	}
 
+	/*
+	 * check events
+	 */
+	while (i < len) {
+		struct inotify_event *event;
+		event = (struct inotify_event *)&event_buf[i];
+		if (test_num >= TST_TOTAL) {
+			tst_res(TFAIL,
+				"get unnecessary event: wd=%d mask=%x "
+				"cookie=%u len=%u",
+				event->wd, event->mask,
+				event->cookie, event->len);
+		} else if (event_set[test_num] == event->mask) {
+			if (event->cookie != 0) {
+				tst_res(TFAIL,
+					"get event: wd=%d mask=%x "
+					"cookie=%u (expected 0) len=%u",
+					event->wd, event->mask,
+					event->cookie, event->len);
 			} else {
-				tst_resm(TFAIL, "get event: wd=%d mask=%x "
-					 "(expected %x) cookie=%u len=%u",
-					 event->wd, event->mask,
-					 event_set[test_num],
-					 event->cookie, event->len);
+				tst_res(TPASS, "get event: wd=%d "
+					"mask=%x cookie=%u len=%u",
+					event->wd, event->mask,
+					event->cookie, event->len);
 			}
-			test_num++;
-			i += EVENT_SIZE + event->len;
-		}
-		for (; test_num < TST_TOTAL; test_num++) {
-			tst_resm(TFAIL, "didn't get event: mask=%x",
-				 event_set[test_num]);
 
+		} else {
+			tst_res(TFAIL, "get event: wd=%d mask=%x "
+				"(expected %x) cookie=%u len=%u",
+				event->wd, event->mask,
+				event_set[test_num],
+				event->cookie, event->len);
 		}
-
+		test_num++;
+		i += EVENT_SIZE + event->len;
 	}
+	for (; test_num < TST_TOTAL; test_num++) {
+		tst_res(TFAIL, "didn't get event: mask=%x",
+			event_set[test_num]);
 
-	cleanup();
-	tst_exit();
+	}
 }
 
 static void setup(void)
 {
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
 	sprintf(fname, "tfile_%d", getpid());
 	if ((fd = open(fname, O_RDWR | O_CREAT, 0700)) == -1) {
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "open(%s, O_RDWR|O_CREAT,0700) failed", fname);
+		tst_brk(TBROK | TERRNO,
+			"open(%s, O_RDWR|O_CREAT,0700) failed", fname);
 	}
 	if ((write(fd, fname, 1)) == -1) {
-		tst_brkm(TBROK | TERRNO, cleanup, "write(%d, %s, 1) failed",
-			 fd, fname);
+		tst_brk(TBROK | TERRNO, "write(%d, %s, 1) failed",
+			fd, fname);
 	}
 
 	/* close the file we have open */
-	SAFE_CLOSE(cleanup, fd);
+	SAFE_CLOSE(fd);
 	if ((fd_notify = myinotify_init()) < 0) {
 		if (errno == ENOSYS) {
-			tst_brkm(TCONF, cleanup,
-				 "inotify is not configured in this kernel.");
+			tst_brk(TCONF,
+				"inotify is not configured in this kernel.");
 		} else {
-			tst_brkm(TBROK | TERRNO, cleanup,
-				 "inotify_init failed");
+			tst_brk(TBROK | TERRNO,
+				"inotify_init failed");
 		}
 	}
 
 	if ((wd = myinotify_add_watch(fd_notify, fname, IN_ALL_EVENTS)) < 0) {
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "inotify_add_watch (%d, %s, IN_ALL_EVENTS) failed",
-			 fd_notify, fname);
+		tst_brk(TBROK | TERRNO,
+			"inotify_add_watch (%d, %s, IN_ALL_EVENTS) failed",
+			fd_notify, fname);
 		reap_wd = 1;
 	};
 
@@ -229,25 +204,22 @@ static void setup(void)
 static void cleanup(void)
 {
 	if (reap_wd && myinotify_rm_watch(fd_notify, wd) < 0) {
-		tst_resm(TWARN | TERRNO, "inotify_rm_watch (%d, %d) failed",
-			 fd_notify, wd);
+		tst_res(TWARN | TERRNO, "inotify_rm_watch (%d, %d) failed",
+			fd_notify, wd);
 
 	}
 
 	if (fd_notify > 0 && close(fd_notify))
-		tst_resm(TWARN, "close(%d) failed", fd_notify);
-
-	tst_rmdir();
+		tst_res(TWARN, "close(%d) failed", fd_notify);
 }
 
-#else
-
-char *TCID = "inotify01";
-int TST_TOTAL = 0;
-
-int main(void)
-{
-	tst_brkm(TCONF, NULL, "system doesn't have required inotify support");
-}
+static struct tst_test test = {
+	.needs_tmpdir = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = verify_inotify,
+};
 
+#else
+	TST_TEST_TCONF("system doesn't have required inotify support");
 #endif
diff --git a/testcases/kernel/syscalls/inotify/inotify02.c b/testcases/kernel/syscalls/inotify/inotify02.c
index 4a1036a..4741910 100644
--- a/testcases/kernel/syscalls/inotify/inotify02.c
+++ b/testcases/kernel/syscalls/inotify/inotify02.c
@@ -39,14 +39,14 @@
 #include <string.h>
 #include <sys/syscall.h>
 #include <limits.h>
-#include "test.h"
-#include "safe_macros.h"
-#include "lapi/syscalls.h"
+#include "tst_test.h"
 #include "inotify.h"
 
 #if defined(HAVE_SYS_INOTIFY_H)
 #include <sys/inotify.h>
 
+#define TST_TOTAL 9
+
 #ifndef IN_MOVE_SELF
 #define IN_MOVE_SELF            0x00000800
 #endif
@@ -57,12 +57,6 @@
 /* reasonable guess as to size of 1024 events */
 #define EVENT_BUF_LEN        (EVENT_MAX * (EVENT_SIZE + 16))
 
-static void setup(void);
-static void cleanup(void);
-
-char *TCID = "inotify02";
-int TST_TOTAL = 9;
-
 #define BUF_SIZE 256
 static char fname1[BUF_SIZE], fname2[BUF_SIZE], fname3[BUF_SIZE];
 static int fd, fd_notify, reap_wd;
@@ -79,235 +73,213 @@ static struct event_t event_set[EVENT_MAX];
 
 static char event_buf[EVENT_BUF_LEN];
 
-int main(int ac, char **av)
+void verify_inotify(void)
 {
-	int lc;
 	unsigned int stored_cookie = UINT_MAX;
 
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
+	int tst_count = 0;
 
-		tst_count = 0;
+	/*
+	 * generate sequence of events
+	 */
+	SAFE_CHMOD(".", 0755);
+	event_set[tst_count].mask = IN_ISDIR | IN_ATTRIB;
+	strcpy(event_set[tst_count].name, "");
+	tst_count++;
 
-		/*
-		 * generate sequence of events
-		 */
-		SAFE_CHMOD(cleanup, ".", 0755);
-		event_set[tst_count].mask = IN_ISDIR | IN_ATTRIB;
-		strcpy(event_set[tst_count].name, "");
-		tst_count++;
-
-		if ((fd = creat(FILE_NAME1, 0755)) == -1) {
-			tst_brkm(TBROK | TERRNO, cleanup,
-				 "creat(\"%s\", 755) failed", FILE_NAME1);
-		}
+	if ((fd = creat(FILE_NAME1, 0755)) == -1) {
+		tst_brk(TBROK | TERRNO,
+			"creat(\"%s\", 755) failed", FILE_NAME1);
+	}
 
-		event_set[tst_count].mask = IN_CREATE;
-		strcpy(event_set[tst_count].name, FILE_NAME1);
-		tst_count++;
-		event_set[tst_count].mask = IN_OPEN;
-		strcpy(event_set[tst_count].name, FILE_NAME1);
-		tst_count++;
-
-		SAFE_CLOSE(cleanup, fd);
-		event_set[tst_count].mask = IN_CLOSE_WRITE;
-		strcpy(event_set[tst_count].name, FILE_NAME1);
-		tst_count++;
-
-		SAFE_RENAME(cleanup, FILE_NAME1, FILE_NAME2);
-		event_set[tst_count].mask = IN_MOVED_FROM;
-		strcpy(event_set[tst_count].name, FILE_NAME1);
-		tst_count++;
-		event_set[tst_count].mask = IN_MOVED_TO;
-		strcpy(event_set[tst_count].name, FILE_NAME2);
-		tst_count++;
-
-		if (getcwd(fname1, BUF_SIZE) == NULL) {
-			tst_brkm(TBROK | TERRNO, cleanup,
-				 "getcwd(%p, %d) failed", fname1, BUF_SIZE);
-		}
+	event_set[tst_count].mask = IN_CREATE;
+	strcpy(event_set[tst_count].name, FILE_NAME1);
+	tst_count++;
+	event_set[tst_count].mask = IN_OPEN;
+	strcpy(event_set[tst_count].name, FILE_NAME1);
+	tst_count++;
+
+	SAFE_CLOSE(fd);
+	event_set[tst_count].mask = IN_CLOSE_WRITE;
+	strcpy(event_set[tst_count].name, FILE_NAME1);
+	tst_count++;
+
+	SAFE_RENAME(FILE_NAME1, FILE_NAME2);
+	event_set[tst_count].mask = IN_MOVED_FROM;
+	strcpy(event_set[tst_count].name, FILE_NAME1);
+	tst_count++;
+	event_set[tst_count].mask = IN_MOVED_TO;
+	strcpy(event_set[tst_count].name, FILE_NAME2);
+	tst_count++;
+
+	if (getcwd(fname1, BUF_SIZE) == NULL) {
+		tst_brk(TBROK | TERRNO,
+			"getcwd(%p, %d) failed", fname1, BUF_SIZE);
+	}
 
-		snprintf(fname2, BUF_SIZE, "%s.rename1", fname1);
-		SAFE_RENAME(cleanup, fname1, fname2);
-		event_set[tst_count].mask = IN_MOVE_SELF;
-		strcpy(event_set[tst_count].name, "");
-		tst_count++;
-
-		SAFE_UNLINK(cleanup, FILE_NAME2);
-		event_set[tst_count].mask = IN_DELETE;
-		strcpy(event_set[tst_count].name, FILE_NAME2);
-		tst_count++;
-
-		/*
-		 * test that duplicate events will be coalesced into
-		 * a single event. This test case should be last, that
-		 * we can correct determine kernel bug which exist before
-		 * 2.6.25. See comment below.
-		 */
-		snprintf(fname3, BUF_SIZE, "%s.rename2", fname1);
-		SAFE_RENAME(cleanup, fname2, fname3);
-
-		SAFE_RENAME(cleanup, fname3, fname1);
-		event_set[tst_count].mask = IN_MOVE_SELF;
-		strcpy(event_set[tst_count].name, "");
-		tst_count++;
-
-		if (tst_count != TST_TOTAL) {
-			tst_brkm(TBROK, cleanup,
-				 "tst_count and TST_TOTAL are not equal");
-		}
+	snprintf(fname2, BUF_SIZE, "%s.rename1", fname1);
+	SAFE_RENAME(fname1, fname2);
+	event_set[tst_count].mask = IN_MOVE_SELF;
+	strcpy(event_set[tst_count].name, "");
+	tst_count++;
+
+	SAFE_UNLINK(FILE_NAME2);
+	event_set[tst_count].mask = IN_DELETE;
+	strcpy(event_set[tst_count].name, FILE_NAME2);
+	tst_count++;
+
+	/*
+	 * test that duplicate events will be coalesced into
+	 * a single event. This test case should be last, that
+	 * we can correct determine kernel bug which exist before
+	 * 2.6.25. See comment below.
+	 */
+	snprintf(fname3, BUF_SIZE, "%s.rename2", fname1);
+	SAFE_RENAME(fname2, fname3);
+
+	SAFE_RENAME(fname3, fname1);
+	event_set[tst_count].mask = IN_MOVE_SELF;
+	strcpy(event_set[tst_count].name, "");
+	tst_count++;
+
+	if (tst_count != TST_TOTAL) {
+		tst_brk(TBROK,
+			"tst_count and TST_TOTAL are not equal");
+	}
 
-		tst_count = 0;
+	tst_count = 0;
 
-		int len, i = 0, test_num = 0;
-		if ((len = read(fd_notify, event_buf, EVENT_BUF_LEN)) == -1) {
-			tst_brkm(TBROK | TERRNO, cleanup,
-				 "read(%d, buf, %zu) failed",
-				 fd_notify, EVENT_BUF_LEN);
+	int len, i = 0, test_num = 0;
+	if ((len = read(fd_notify, event_buf, EVENT_BUF_LEN)) == -1) {
+		tst_brk(TBROK | TERRNO,
+			"read(%d, buf, %zu) failed",
+			fd_notify, EVENT_BUF_LEN);
 
-		}
+	}
 
-		while (i < len) {
-			struct inotify_event *event;
-			event = (struct inotify_event *)&event_buf[i];
-			if (test_num >= TST_TOTAL) {
-				if (tst_kvercmp(2, 6, 25) < 0
-				    && event_set[TST_TOTAL - 1].mask ==
-				    event->mask)
-					tst_resm(TWARN,
-						 "This may be kernel bug. "
-						 "Before kernel 2.6.25, a kernel bug "
-						 "meant that the kernel code that was "
-						 "intended to coalesce successive identical "
-						 "events (i.e., the two most recent "
-						 "events could potentially be coalesced "
-						 "if the older had not yet been read) "
-						 "instead checked if the most recent event "
-						 "could be coalesced with the oldest "
-						 "unread event. This has been fixed by commit"
-						 "1c17d18e3775485bf1e0ce79575eb637a94494a2.");
-				tst_resm(TFAIL,
-					 "get unnecessary event: "
-					 "wd=%d mask=%x cookie=%u len=%u"
-					 "name=\"%.*s\"", event->wd, event->mask,
-					 event->cookie, event->len, event->len,
-					 event->name);
-
-			} else if ((event_set[test_num].mask == event->mask)
-				   &&
-				   (!strncmp
-				    (event_set[test_num].name, event->name,
-				     event->len))) {
-				int fail = 0;
-
-				if (event->mask == IN_MOVED_FROM) {
-					if (event->cookie == 0)
-						fail = 1;
-					else
-						stored_cookie = event->cookie;
-				} else if (event->mask == IN_MOVED_TO) {
-					if (event->cookie != stored_cookie)
-						fail = 1;
-					else
-						stored_cookie = UINT_MAX;
-				} else {
-					if (event->cookie != 0)
-						fail = 1;
-				}
-				if (!fail) {
-					tst_resm(TPASS,
-						 "get event: wd=%d mask=%x "
-						 "cookie=%u len=%u name=\"%.*s\"",
-						 event->wd, event->mask,
-						 event->cookie, event->len,
-						 event->len, event->name);
-				} else {
-					tst_resm(TFAIL,
-						 "get event: wd=%d mask=%x "
-						 "cookie=%u (wrong) len=%u "
-						 "name=\"%s\"",
-						 event->wd, event->mask,
-						 event->cookie, event->len,
-						 event->name);
-				}
+	while (i < len) {
+		struct inotify_event *event;
+		event = (struct inotify_event *)&event_buf[i];
+		if (test_num >= TST_TOTAL) {
+			if (tst_kvercmp(2, 6, 25) < 0
+					&& event_set[TST_TOTAL - 1].mask ==
+					event->mask)
+				tst_res(TWARN,
+					"This may be kernel bug. "
+					"Before kernel 2.6.25, a kernel bug "
+					"meant that the kernel code that was "
+					"intended to coalesce successive identical "
+					"events (i.e., the two most recent "
+					"events could potentially be coalesced "
+					"if the older had not yet been read) "
+					"instead checked if the most recent event "
+					"could be coalesced with the oldest "
+					"unread event. This has been fixed by commit"
+					"1c17d18e3775485bf1e0ce79575eb637a94494a2.");
+			tst_res(TFAIL,
+				"get unnecessary event: "
+				"wd=%d mask=%x cookie=%u len=%u"
+				"name=\"%.*s\"", event->wd, event->mask,
+				event->cookie, event->len, event->len,
+				event->name);
+
+		} else if ((event_set[test_num].mask == event->mask)
+				&&
+				(!strncmp
+				 (event_set[test_num].name, event->name,
+				  event->len))) {
+			int fail = 0;
+
+			if (event->mask == IN_MOVED_FROM) {
+				if (event->cookie == 0)
+					fail = 1;
+				else
+					stored_cookie = event->cookie;
+			} else if (event->mask == IN_MOVED_TO) {
+				if (event->cookie != stored_cookie)
+					fail = 1;
+				else
+					stored_cookie = UINT_MAX;
 			} else {
-				tst_resm(TFAIL, "get event: wd=%d mask=%x "
-					 "(expected %x) cookie=%u len=%u "
-					 "name=\"%s\" (expected \"%s\") %d",
-					 event->wd, event->mask,
-					 event_set[test_num].mask,
-					 event->cookie, event->len, event->name,
-					 event_set[test_num].name,
-					 strcmp(event_set[test_num].name,
-						event->name));
+				if (event->cookie != 0)
+					fail = 1;
 			}
-			test_num++;
-			i += EVENT_SIZE + event->len;
-		}
-
-		for (; test_num < TST_TOTAL; test_num++) {
-			tst_resm(TFAIL, "didn't get event: mask=%x ",
-				 event_set[test_num].mask);
+			if (!fail) {
+				tst_res(TPASS,
+					"get event: wd=%d mask=%x "
+					"cookie=%u len=%u name=\"%.*s\"",
+					event->wd, event->mask,
+					event->cookie, event->len,
+					event->len, event->name);
+			} else {
+				tst_res(TFAIL,
+					"get event: wd=%d mask=%x "
+					"cookie=%u (wrong) len=%u "
+					"name=\"%s\"",
+					event->wd, event->mask,
+					event->cookie, event->len,
+					event->name);
+			}
+		} else {
+			tst_res(TFAIL, "get event: wd=%d mask=%x "
+				"(expected %x) cookie=%u len=%u "
+				"name=\"%s\" (expected \"%s\") %d",
+				event->wd, event->mask,
+				event_set[test_num].mask,
+				event->cookie, event->len, event->name,
+				event_set[test_num].name,
+				strcmp(event_set[test_num].name,
+					event->name));
 		}
+		test_num++;
+		i += EVENT_SIZE + event->len;
 	}
 
-	cleanup();
-	tst_exit();
+	for (; test_num < TST_TOTAL; test_num++) {
+		tst_res(TFAIL, "didn't get event: mask=%x ",
+			event_set[test_num].mask);
+	}
 }
 
 static void setup(void)
 {
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
 	if ((fd_notify = myinotify_init()) < 0) {
 		if (errno == ENOSYS) {
-			tst_brkm(TCONF, cleanup,
-				 "inotify is not configured in this kernel.");
+			tst_brk(TCONF,
+				"inotify is not configured in this kernel.");
 		} else {
-			tst_brkm(TBROK | TERRNO, cleanup,
-				 "inotify_init () failed");
+			tst_brk(TBROK | TERRNO,
+				"inotify_init () failed");
 		}
 	}
 
 	if ((wd = myinotify_add_watch(fd_notify, ".", IN_ALL_EVENTS)) < 0) {
-		tst_brkm(TBROK | TERRNO, cleanup,
+		tst_brk(TBROK | TERRNO,
 			 "inotify_add_watch (%d, \".\", IN_ALL_EVENTS) failed",
 			 fd_notify);
 		reap_wd = 1;
 	};
-
 }
 
 static void cleanup(void)
 {
 	if (reap_wd && myinotify_rm_watch(fd_notify, wd) < 0) {
-		tst_resm(TWARN,
-			 "inotify_rm_watch (%d, %d) failed,", fd_notify, wd);
+		tst_res(TWARN,
+			"inotify_rm_watch (%d, %d) failed,", fd_notify, wd);
 
 	}
 
 	if (fd_notify > 0 && close(fd_notify))
-		tst_resm(TWARN, "close(%d) failed", fd_notify);
-
-	tst_rmdir();
+		tst_res(TWARN, "close(%d) failed", fd_notify);
 }
 
-#else
-
-char *TCID = "inotify02";
-int TST_TOTAL = 0;
-
-int main(void)
-{
-	tst_brkm(TCONF, NULL, "system doesn't have required inotify support");
-}
+static struct tst_test test = {
+	.needs_tmpdir = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = verify_inotify,
+};
 
+#else
+	TST_TEST_TCONF("system doesn't have required inotify support");
 #endif
diff --git a/testcases/kernel/syscalls/inotify/inotify03.c b/testcases/kernel/syscalls/inotify/inotify03.c
index 8460376..8077976 100644
--- a/testcases/kernel/syscalls/inotify/inotify03.c
+++ b/testcases/kernel/syscalls/inotify/inotify03.c
@@ -41,26 +41,20 @@
 #include <string.h>
 #include <sys/syscall.h>
 #include <signal.h>
-#include "test.h"
-#include "safe_macros.h"
-#include "lapi/syscalls.h"
+#include "tst_test.h"
 #include "inotify.h"
 
-char *TCID = "inotify03";
-int TST_TOTAL = 3;
-
 #if defined(HAVE_SYS_INOTIFY_H)
 #include <sys/inotify.h>
 
+#define TST_TOTAL 3
+
 #define EVENT_MAX 1024
 /* size of the event structure, not counting name */
 #define EVENT_SIZE (sizeof(struct inotify_event))
 /* reasonable guess as to size of 1024 events */
 #define EVENT_BUF_LEN		(EVENT_MAX * (EVENT_SIZE + 16))
 
-static void setup(void);
-static void cleanup(void);
-
 #define BUF_SIZE 1024
 static char fname[BUF_SIZE];
 static int fd, fd_notify;
@@ -74,19 +68,13 @@ static char event_buf[EVENT_BUF_LEN];
 
 static char *mntpoint = "mntpoint";
 static int mount_flag;
-static const char *device;
-static const char *fs_type;
 
-int main(int argc, char *argv[])
+void verify_inotify(void)
 {
 	int ret;
 	int len, i, test_num;
 
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	setup();
-
-	tst_count = 0;
+	int tst_count = 0;
 
 	event_set[tst_count] = IN_UNMOUNT;
 	tst_count++;
@@ -97,24 +85,24 @@ int main(int argc, char *argv[])
 	tst_count++;
 
 	if (TST_TOTAL != tst_count) {
-		tst_brkm(TBROK, cleanup,
-			 "TST_TOTAL and tst_count are not equal");
+		tst_brk(TBROK,
+			"TST_TOTAL and tst_count are not equal");
 	}
 	tst_count = 0;
 
-	tst_resm(TINFO, "umount %s", device);
+	tst_res(TINFO, "umount %s", tst_device->dev);
 	TEST(tst_umount(mntpoint));
 	if (TEST_RETURN != 0) {
-		tst_brkm(TBROK, cleanup, "umount(2) Failed "
-			 "while unmounting errno = %d : %s",
-			 TEST_ERRNO, strerror(TEST_ERRNO));
+		tst_brk(TBROK, "umount(2) Failed "
+			"while unmounting errno = %d : %s",
+			TEST_ERRNO, strerror(TEST_ERRNO));
 	}
 	mount_flag = 0;
 
 	len = read(fd_notify, event_buf, EVENT_BUF_LEN);
 	if (len < 0) {
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "read(%d, buf, %zu) failed", fd_notify, EVENT_BUF_LEN);
+		tst_brk(TBROK | TERRNO,
+			"read(%d, buf, %zu) failed", fd_notify, EVENT_BUF_LEN);
 	}
 
 	/* check events */
@@ -124,129 +112,103 @@ int main(int argc, char *argv[])
 		struct inotify_event *event;
 		event = (struct inotify_event *)&event_buf[i];
 		if (test_num >= (TST_TOTAL - 1)) {
-			tst_resm(TFAIL,
-				 "get unnecessary event: wd=%d mask=%x "
-				 "cookie=%u len=%u",
-				 event->wd, event->mask,
-				 event->cookie, event->len);
+			tst_res(TFAIL,
+				"get unnecessary event: wd=%d mask=%x "
+				"cookie=%u len=%u",
+				event->wd, event->mask,
+				event->cookie, event->len);
 		} else if (event_set[test_num] == event->mask) {
-			tst_resm(TPASS, "get event: wd=%d mask=%x"
-				 " cookie=%u len=%u",
-				 event->wd, event->mask,
-				 event->cookie, event->len);
+			tst_res(TPASS, "get event: wd=%d mask=%x"
+				" cookie=%u len=%u",
+				event->wd, event->mask,
+				event->cookie, event->len);
 
 		} else {
-			tst_resm(TFAIL, "get event: wd=%d mask=%x "
-				 "(expected %x) cookie=%u len=%u",
-				 event->wd, event->mask,
-				 event_set[test_num],
-				 event->cookie, event->len);
+			tst_res(TFAIL, "get event: wd=%d mask=%x "
+				"(expected %x) cookie=%u len=%u",
+				event->wd, event->mask,
+				event_set[test_num],
+				event->cookie, event->len);
 		}
 		test_num++;
 		i += EVENT_SIZE + event->len;
 	}
 	for (; test_num < TST_TOTAL - 1; test_num++) {
-		tst_resm(TFAIL, "don't get event: mask=%x ",
-			 event_set[test_num]);
+		tst_res(TFAIL, "don't get event: mask=%x ",
+			event_set[test_num]);
 
 	}
 	ret = myinotify_rm_watch(fd_notify, wd);
 	if (ret != -1 || errno != EINVAL)
-		tst_resm(TFAIL | TERRNO,
-			 "inotify_rm_watch (%d, %d) didn't return EINVAL",
-			 fd_notify, wd);
+		tst_res(TFAIL | TERRNO,
+			"inotify_rm_watch (%d, %d) didn't return EINVAL",
+			fd_notify, wd);
 	else
-		tst_resm(TPASS, "inotify_rm_watch (%d, %d) returned EINVAL",
-			 fd_notify, wd);
-
-	cleanup();
-	tst_exit();
+		tst_res(TPASS, "inotify_rm_watch (%d, %d) returned EINVAL",
+			fd_notify, wd);
 }
 
 static void setup(void)
 {
 	int ret;
 
-	tst_require_root();
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	fs_type = tst_dev_fs_type();
-
-	tst_tmpdir();
-
-	device = tst_acquire_device(cleanup);
-	if (!device)
-		tst_brkm(TCONF, cleanup, "Failed to obtain block device");
+	SAFE_MKDIR(mntpoint, DIR_MODE);
 
-	tst_mkfs(cleanup, device, fs_type, NULL, NULL);
-
-	SAFE_MKDIR(cleanup, mntpoint, DIR_MODE);
-
-	/* Call mount(2) */
-	tst_resm(TINFO, "mount %s to %s fs_type=%s", device, mntpoint, fs_type);
-	TEST(mount(device, mntpoint, fs_type, 0, NULL));
-
-	/* check return code */
-	if (TEST_RETURN != 0) {
-		tst_brkm(TBROK | TTERRNO, cleanup, "mount(2) failed");
-	}
+	SAFE_MOUNT(tst_device->dev, mntpoint, tst_device->fs_type, 0, NULL);
 	mount_flag = 1;
 
 	sprintf(fname, "%s/tfile_%d", mntpoint, getpid());
-	fd = SAFE_OPEN(cleanup, fname, O_RDWR | O_CREAT, 0700);
+	fd = SAFE_OPEN(fname, O_RDWR | O_CREAT, 0700);
 
 	ret = write(fd, fname, 1);
 	if (ret == -1) {
-		tst_brkm(TBROK | TERRNO, cleanup,
+		tst_brk(TBROK | TERRNO,
 			 "write(%d, %s, 1) failed", fd, fname);
 	}
 
 	/* close the file we have open */
-	SAFE_CLOSE(cleanup, fd);
+	SAFE_CLOSE(fd);
 
 	fd_notify = myinotify_init();
 
 	if (fd_notify < 0) {
 		if (errno == ENOSYS)
-			tst_brkm(TCONF, cleanup,
-				 "inotify is not configured in this kernel.");
+			tst_brk(TCONF,
+				"inotify is not configured in this kernel.");
 		else
-			tst_brkm(TBROK | TERRNO, cleanup,
-				 "inotify_init failed");
+			tst_brk(TBROK | TERRNO,
+				"inotify_init failed");
 	}
 
 	wd = myinotify_add_watch(fd_notify, fname, IN_ALL_EVENTS);
 	if (wd < 0)
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "inotify_add_watch (%d, %s, IN_ALL_EVENTS) failed.",
-			 fd_notify, fname);
+		tst_brk(TBROK | TERRNO,
+			"inotify_add_watch (%d, %s, IN_ALL_EVENTS) failed.",
+			fd_notify, fname);
 }
 
 static void cleanup(void)
 {
 	if (fd_notify > 0 && close(fd_notify) == -1)
-		tst_resm(TWARN | TERRNO, "close(%d) failed", fd_notify);
+		tst_res(TWARN | TERRNO, "close(%d) failed", fd_notify);
 
 	if (mount_flag) {
 		TEST(tst_umount(mntpoint));
 		if (TEST_RETURN != 0)
-			tst_resm(TWARN | TTERRNO, "umount(%s) failed",
-				 mntpoint);
+			tst_res(TWARN | TTERRNO, "umount(%s) failed",
+				mntpoint);
 	}
-
-	tst_release_device(device);
-
-	tst_rmdir();
 }
 
-#else
-
-int main(void)
-{
-	tst_brkm(TCONF, NULL, "system doesn't have required inotify support");
-}
+static struct tst_test test = {
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+	.format_device = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = verify_inotify,
+};
 
+#else
+	TST_TEST_TCONF("system doesn't have required inotify support");
 #endif
diff --git a/testcases/kernel/syscalls/inotify/inotify04.c b/testcases/kernel/syscalls/inotify/inotify04.c
index 87ef9c3..b78277c 100644
--- a/testcases/kernel/syscalls/inotify/inotify04.c
+++ b/testcases/kernel/syscalls/inotify/inotify04.c
@@ -44,16 +44,13 @@
 #endif
 #include <errno.h>
 #include <string.h>
-#include "test.h"
-#include "lapi/syscalls.h"
+#include "tst_test.h"
 #include "inotify.h"
-#include "safe_macros.h"
-
-char *TCID = "inotify04";
-int TST_TOTAL = 4;
 
 #if defined(HAVE_SYS_INOTIFY_H)
 
+int TST_TOTAL = 4;
+
 #define EVENT_MAX 1024
 /* size of the event structure, not counting name */
 #define EVENT_SIZE  (sizeof(struct inotify_event))
@@ -86,79 +83,63 @@ static void cleanup(void)
 {
 
 	if (reap_wd_dir && myinotify_rm_watch(fd_notify, wd_dir) == -1)
-		tst_resm(TWARN,
-			 "inotify_rm_watch(%d, %d) [1] failed", fd_notify,
-			 wd_dir);
+		tst_res(TWARN,
+			"inotify_rm_watch(%d, %d) [1] failed", fd_notify,
+			wd_dir);
 
 	if (reap_wd_file && myinotify_rm_watch(fd_notify, wd_file) == -1)
-		tst_resm(TWARN,
-			 "inotify_rm_watch(%d, %d) [2] failed", fd_notify,
-			 wd_file);
+		tst_res(TWARN,
+			"inotify_rm_watch(%d, %d) [2] failed", fd_notify,
+			wd_file);
 
 	if (fd_notify > 0 && close(fd_notify))
-		tst_resm(TWARN, "close(%d) [1] failed", fd_notify);
+		tst_res(TWARN, "close(%d) [1] failed", fd_notify);
 
 	if (wd_dir > 0 && close(wd_dir))
-		tst_resm(TWARN, "close(%d) [2] failed", wd_dir);
+		tst_res(TWARN, "close(%d) [2] failed", wd_dir);
 
 	if (wd_file > 0 && close(wd_file))
-		tst_resm(TWARN, "close(%d) [3] failed", wd_file);
-
-	tst_rmdir();
+		tst_res(TWARN, "close(%d) [3] failed", wd_file);
 }
 
 static void setup(void)
 {
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
 	fd_notify = myinotify_init();
 	if (fd_notify == -1) {
 		if (errno == ENOSYS) {
-			tst_brkm(TCONF, cleanup,
-				 "inotify is not configured in this kernel.");
+			tst_brk(TCONF,
+				"inotify is not configured in this kernel.");
 		} else {
-			tst_brkm(TBROK | TERRNO, cleanup,
-				 "inotify_init failed");
+			tst_brk(TBROK | TERRNO,
+				"inotify_init failed");
 		}
 	}
 
-	SAFE_MKDIR(cleanup, TEST_DIR, 00700);
+	SAFE_MKDIR(TEST_DIR, 00700);
 
-	close(SAFE_CREAT(cleanup, TEST_FILE, 00600));
+	close(SAFE_CREAT(TEST_FILE, 00600));
 
 	wd_dir = myinotify_add_watch(fd_notify, TEST_DIR, IN_ALL_EVENTS);
 	if (wd_dir == -1) {
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "inotify_add_watch(%d, \"%s\", IN_ALL_EVENTS) [1] failed",
-			 fd_notify, TEST_DIR);
+		tst_brk(TBROK | TERRNO,
+			"inotify_add_watch(%d, \"%s\", IN_ALL_EVENTS) [1] failed",
+			fd_notify, TEST_DIR);
 	}
 	reap_wd_dir = 1;
 
 	wd_file = myinotify_add_watch(fd_notify, TEST_FILE, IN_ALL_EVENTS);
 	if (wd_file == -1)
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "inotify_add_watch(%d, \"%s\", IN_ALL_EVENTS) [2] failed",
-			 fd_notify, TEST_FILE);
+		tst_brk(TBROK | TERRNO,
+			"inotify_add_watch(%d, \"%s\", IN_ALL_EVENTS) [2] failed",
+			fd_notify, TEST_FILE);
 	reap_wd_file = 1;
 }
 
-int main(int argc, char **argv)
+void verify_inotify(void)
 {
-	int i, test_num, len;
-
-	i = 0;
-	test_num = 0;
+	int i = 0, test_num = 0, len;
 
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	setup();
-
-	tst_count = 0;
+	int tst_count = 0;
 
 	rmdir(TEST_DIR);
 	event_set[tst_count].mask = IN_DELETE_SELF;
@@ -190,14 +171,14 @@ int main(int argc, char **argv)
 	tst_count++;
 
 	if (tst_count != TST_TOTAL)
-		tst_brkm(TBROK, cleanup,
-			 "tst_count and TST_TOTAL are not equal");
+		tst_brk(TBROK,
+			"tst_count and TST_TOTAL are not equal");
 
 	tst_count = 0;
 
 	len = read(fd_notify, event_buf, EVENT_BUF_LEN);
 	if (len == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "read failed");
+		tst_brk(TBROK | TERRNO, "read failed");
 
 	reap_wd_dir = 0;
 	reap_wd_file = 0;
@@ -208,61 +189,63 @@ int main(int argc, char **argv)
 		if (test_num >= TST_TOTAL) {
 			if (tst_kvercmp(2, 6, 25) < 0
 			    && event_set[TST_TOTAL - 1].mask == event->mask)
-				tst_resm(TWARN,
-					 "This may be kernel bug. "
-					 "Before kernel 2.6.25, a kernel bug "
-					 "meant that the kernel code that was "
-					 "intended to coalesce successive identical "
-					 "events (i.e., the two most recent "
-					 "events could potentially be coalesced "
-					 "if the older had not yet been read) "
-					 "instead checked if the most recent event "
-					 "could be coalesced with the oldest "
-					 "unread event. This has been fixed by commit"
-					 "1c17d18e3775485bf1e0ce79575eb637a94494a2.");
-			tst_resm(TFAIL,
-				 "got unnecessary event: "
-				 "wd=%d mask=%x cookie=%u len=%u "
-				 "name=\"%.*s\"", event->wd, event->mask,
-				 event->cookie, event->len, event->len, event->name);
+				tst_res(TWARN,
+					"This may be kernel bug. "
+					"Before kernel 2.6.25, a kernel bug "
+					"meant that the kernel code that was "
+					"intended to coalesce successive identical "
+					"events (i.e., the two most recent "
+					"events could potentially be coalesced "
+					"if the older had not yet been read) "
+					"instead checked if the most recent event "
+					"could be coalesced with the oldest "
+					"unread event. This has been fixed by commit"
+					"1c17d18e3775485bf1e0ce79575eb637a94494a2.");
+			tst_res(TFAIL,
+				"got unnecessary event: "
+				"wd=%d mask=%x cookie=%u len=%u "
+				"name=\"%.*s\"", event->wd, event->mask,
+				event->cookie, event->len, event->len, event->name);
 
 		} else if ((event_set[test_num].mask == event->mask)
 			   &&
 			   (!strncmp
 			    (event_set[test_num].name, event->name,
 			     event->len))) {
-			tst_resm(TPASS,
-				 "got event: wd=%d mask=%x "
-				 "cookie=%u len=%u name=\"%.*s\"",
-				 event->wd, event->mask, event->cookie,
-				 event->len, event->len, event->name);
+			tst_res(TPASS,
+				"got event: wd=%d mask=%x "
+				"cookie=%u len=%u name=\"%.*s\"",
+				event->wd, event->mask, event->cookie,
+				event->len, event->len, event->name);
 
 		} else {
-			tst_resm(TFAIL, "got event: wd=%d mask=%x "
-				 "(expected %x) cookie=%u len=%u "
-				 "name=\"%.*s\" (expected \"%s\") %d",
-				 event->wd, event->mask,
-				 event_set[test_num].mask,
-				 event->cookie, event->len,
-				 event->len, event->name,
-				 event_set[test_num].name,
-				 strncmp(event_set[test_num].name, event->name, event->len));
+			tst_res(TFAIL, "got event: wd=%d mask=%x "
+				"(expected %x) cookie=%u len=%u "
+				"name=\"%.*s\" (expected \"%s\") %d",
+				event->wd, event->mask,
+				event_set[test_num].mask,
+				event->cookie, event->len,
+				event->len, event->name,
+				event_set[test_num].name,
+				strncmp(event_set[test_num].name, event->name, event->len));
 		}
 		test_num++;
 		i += EVENT_SIZE + event->len;
 	}
 
 	for (; test_num < TST_TOTAL; test_num++) {
-		tst_resm(TFAIL, "didn't get event: mask=%x ",
-			 event_set[test_num].mask);
+		tst_res(TFAIL, "didn't get event: mask=%x ",
+			event_set[test_num].mask);
 	}
-
-	cleanup();
-	tst_exit();
 }
+
+static struct tst_test test = {
+	.needs_tmpdir = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = verify_inotify,
+};
+
 #else
-int main(void)
-{
-	tst_brkm(TCONF, NULL, "system doesn't have required inotify support");
-}
+	TST_TEST_TCONF("system doesn't have required inotify support");
 #endif /* defined(HAVE_SYS_INOTIFY_H) */
diff --git a/testcases/kernel/syscalls/inotify/inotify05.c b/testcases/kernel/syscalls/inotify/inotify05.c
index b526521..a582dba 100644
--- a/testcases/kernel/syscalls/inotify/inotify05.c
+++ b/testcases/kernel/syscalls/inotify/inotify05.c
@@ -34,13 +34,8 @@
 #include <errno.h>
 #include <string.h>
 #include <sys/syscall.h>
-#include "test.h"
-#include "lapi/syscalls.h"
+#include "tst_test.h"
 #include "inotify.h"
-#include "safe_macros.h"
-
-char *TCID = "inotify05";
-int TST_TOTAL = 1;
 
 #if defined(HAVE_SYS_INOTIFY_H)
 #include <sys/inotify.h>
@@ -49,9 +44,6 @@ int TST_TOTAL = 1;
 #define EVENT_SIZE  (sizeof(struct inotify_event))
 #define EVENT_BUF_LEN (EVENT_SIZE * 16)
 
-static void setup(void);
-static void cleanup(void);
-
 #define BUF_SIZE 256
 static char fname[BUF_SIZE];
 static char buf[BUF_SIZE];
@@ -61,152 +53,137 @@ static int max_events;
 
 static char event_buf[EVENT_BUF_LEN];
 
-int main(int ac, char **av)
+void verify_inotify(void)
 {
-	int lc, i;
+	int i;
 	int len, stop;
 
-	tst_parse_opts(ac, av, NULL, NULL);
+	/*
+	 * generate events
+	 */
+	fd = SAFE_OPEN(fname, O_RDWR);
 
-	setup();
+	for (i = 0; i < max_events; i++) {
+		SAFE_LSEEK(fd, 0, SEEK_SET);
+		SAFE_READ(1, fd, buf, BUF_SIZE);
+		SAFE_LSEEK(fd, 0, SEEK_SET);
+		SAFE_WRITE(1, fd, buf, BUF_SIZE);
+	}
 
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
+	SAFE_CLOSE(fd);
+
+	stop = 0;
+	while (!stop) {
 		/*
-		 * generate events
+		 * get list on events
 		 */
-		fd = SAFE_OPEN(cleanup, fname, O_RDWR);
-
-		for (i = 0; i < max_events; i++) {
-			SAFE_LSEEK(cleanup, fd, 0, SEEK_SET);
-			SAFE_READ(cleanup, 1, fd, buf, BUF_SIZE);
-			SAFE_LSEEK(cleanup, fd, 0, SEEK_SET);
-			SAFE_WRITE(cleanup, 1, fd, buf, BUF_SIZE);
+		len = read(fd_notify, event_buf, EVENT_BUF_LEN);
+		if (len < 0) {
+			tst_brk(TBROK | TERRNO,
+				"read(%d, buf, %zu) failed",
+				fd_notify, EVENT_BUF_LEN);
 		}
 
-		SAFE_CLOSE(cleanup, fd);
-
-		stop = 0;
-		while (!stop) {
-			/*
-			 * get list on events
-			 */
-			len = read(fd_notify, event_buf, EVENT_BUF_LEN);
-			if (len < 0) {
-				tst_brkm(TBROK | TERRNO, cleanup,
-					 "read(%d, buf, %zu) failed",
-					 fd_notify, EVENT_BUF_LEN);
+		/*
+		 * check events
+		 */
+		i = 0;
+		while (i < len) {
+			struct inotify_event *event;
+
+			event = (struct inotify_event *)&event_buf[i];
+			if (event->mask != IN_ACCESS &&
+					event->mask != IN_MODIFY &&
+					event->mask != IN_OPEN &&
+					event->mask != IN_Q_OVERFLOW) {
+				tst_res(TFAIL,
+					"get event: wd=%d mask=%x "
+					"cookie=%u (expected 0) len=%u",
+					event->wd, event->mask,
+					event->cookie, event->len);
+				stop = 1;
+				break;
 			}
-
-			/*
-			 * check events
-			 */
-			i = 0;
-			while (i < len) {
-				struct inotify_event *event;
-
-				event = (struct inotify_event *)&event_buf[i];
-				if (event->mask != IN_ACCESS &&
-				    event->mask != IN_MODIFY &&
-				    event->mask != IN_OPEN &&
-				    event->mask != IN_Q_OVERFLOW) {
-					tst_resm(TFAIL,
-						 "get event: wd=%d mask=%x "
-						 "cookie=%u (expected 0) len=%u",
-						 event->wd, event->mask,
-						 event->cookie, event->len);
+			if (event->mask == IN_Q_OVERFLOW) {
+				if (event->len != 0 ||
+						event->cookie != 0 ||
+						event->wd != -1) {
+					tst_res(TFAIL,
+						"invalid overflow event: "
+						"wd=%d mask=%x "
+						"cookie=%u len=%u",
+						event->wd, event->mask,
+						event->cookie,
+						event->len);
 					stop = 1;
 					break;
 				}
-				if (event->mask == IN_Q_OVERFLOW) {
-					if (event->len != 0 ||
-					    event->cookie != 0 ||
-					    event->wd != -1) {
-						tst_resm(TFAIL,
-							 "invalid overflow event: "
-							 "wd=%d mask=%x "
-							 "cookie=%u len=%u",
-							 event->wd, event->mask,
-							 event->cookie,
-							 event->len);
-						stop = 1;
-						break;
-					}
-					if ((int)(i + EVENT_SIZE) != len) {
-						tst_resm(TFAIL,
-							 "overflow event is not last");
-						stop = 1;
-						break;
-					}
-					tst_resm(TPASS, "get event: wd=%d "
-						 "mask=%x cookie=%u len=%u",
-						 event->wd, event->mask,
-						 event->cookie, event->len);
+				if ((int)(i + EVENT_SIZE) != len) {
+					tst_res(TFAIL,
+						"overflow event is not last");
 					stop = 1;
 					break;
 				}
-				i += EVENT_SIZE + event->len;
+				tst_res(TPASS, "get event: wd=%d "
+					"mask=%x cookie=%u len=%u",
+					event->wd, event->mask,
+					event->cookie, event->len);
+				stop = 1;
+				break;
 			}
+			i += EVENT_SIZE + event->len;
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
 	sprintf(fname, "tfile_%d", getpid());
-	fd = SAFE_OPEN(cleanup, fname, O_RDWR | O_CREAT, 0700);
-	SAFE_WRITE(cleanup, 1, fd, buf, BUF_SIZE);
-	SAFE_CLOSE(cleanup, fd);
+	fd = SAFE_OPEN(fname, O_RDWR | O_CREAT, 0700);
+	SAFE_WRITE(1, fd, buf, BUF_SIZE);
+	SAFE_CLOSE(fd);
 
 	fd_notify = syscall(__NR_inotify_init1, O_NONBLOCK);
 	if (fd_notify < 0) {
 		if (errno == ENOSYS) {
-			tst_brkm(TCONF, cleanup,
-				 "inotify is not configured in this kernel.");
+			tst_brk(TCONF,
+				"inotify is not configured in this kernel.");
 		} else {
-			tst_brkm(TBROK | TERRNO, cleanup,
-				 "inotify_init failed");
+			tst_brk(TBROK | TERRNO,
+				"inotify_init failed");
 		}
 	}
 
 	wd = myinotify_add_watch(fd_notify, fname, IN_ALL_EVENTS);
 	if (wd < 0) {
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "inotify_add_watch (%d, %s, IN_ALL_EVENTS) failed",
-			 fd_notify, fname);
+		tst_brk(TBROK | TERRNO,
+			"inotify_add_watch (%d, %s, IN_ALL_EVENTS) failed",
+			fd_notify, fname);
 	};
 
-	SAFE_FILE_SCANF(cleanup, "/proc/sys/fs/inotify/max_queued_events",
+	SAFE_FILE_SCANF("/proc/sys/fs/inotify/max_queued_events",
 			"%d", &max_events);
 }
 
 static void cleanup(void)
 {
 	if (fd_notify > 0 && myinotify_rm_watch(fd_notify, wd) == -1) {
-		tst_resm(TWARN | TERRNO, "inotify_rm_watch (%d, %d) failed",
-			 fd_notify, wd);
+		tst_res(TWARN | TERRNO, "inotify_rm_watch (%d, %d) failed",
+			fd_notify, wd);
 
 	}
 
 	if (fd_notify > 0 && close(fd_notify) == -1)
-		tst_resm(TWARN, "close(%d) failed", fd_notify);
-
-	tst_rmdir();
+		tst_res(TWARN, "close(%d) failed", fd_notify);
 }
 
-#else
-
-int main(void)
-{
-	tst_brkm(TCONF, NULL, "system doesn't have required inotify support");
-}
+static struct tst_test test = {
+	.needs_tmpdir = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = verify_inotify,
+};
 
+#else
+	TST_TEST_TCONF("system doesn't have required inotify support");
 #endif
diff --git a/testcases/kernel/syscalls/inotify/inotify06.c b/testcases/kernel/syscalls/inotify/inotify06.c
index 7ac5794..bb45a53 100644
--- a/testcases/kernel/syscalls/inotify/inotify06.c
+++ b/testcases/kernel/syscalls/inotify/inotify06.c
@@ -41,13 +41,8 @@
 #include <sys/wait.h>
 #include <sys/syscall.h>
 
-#include "test.h"
-#include "lapi/syscalls.h"
+#include "tst_test.h"
 #include "inotify.h"
-#include "safe_macros.h"
-
-char *TCID = "inotify06";
-int TST_TOTAL = 1;
 
 #if defined(HAVE_SYS_INOTIFY_H)
 #include <sys/inotify.h>
@@ -62,19 +57,12 @@ char names[FILES][PATH_MAX];
 
 static void cleanup(void)
 {
-	tst_rmdir();
 }
 
 static void setup(void)
 {
 	int i;
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
 	for (i = 0; i < FILES; i++)
 		sprintf(names[i], "fname_%d", i);
 }
@@ -85,23 +73,22 @@ static void verify_inotify(void)
 	pid_t pid;
 	int i, tests;
 
-	pid = tst_fork();
+	pid = SAFE_FORK();
 	if (pid == 0) {
 		while (1) {
 			for (i = 0; i < FILES; i++) {
-				fd = SAFE_OPEN(NULL, names[i], O_CREAT | O_RDWR, 0600);
-				SAFE_CLOSE(NULL, fd);
+				fd = SAFE_OPEN(names[i], O_CREAT | O_RDWR, 0600);
+				SAFE_CLOSE(fd);
 			}
 			for (i = 0; i < FILES; i++)
-				SAFE_UNLINK(NULL, names[i]);
+				SAFE_UNLINK(names[i]);
 		}
-	} else if (pid == -1)
-			tst_brkm(TBROK | TERRNO, cleanup, "fork() failed");
+	}
 
 	for (tests = 0; tests < TEARDOWNS; tests++) {
-		inotify_fd = ltp_syscall(__NR_inotify_init1, O_NONBLOCK);
+		inotify_fd = tst_syscall(__NR_inotify_init1, O_NONBLOCK);
 		if (inotify_fd < 0)
-			tst_brkm(TBROK | TERRNO, cleanup, "inotify_init failed");
+			tst_brk(TBROK | TERRNO, "inotify_init failed");
 
 		for (i = 0; i < FILES; i++) {
 			/*
@@ -112,36 +99,24 @@ static void verify_inotify(void)
 			 */
 			myinotify_add_watch(inotify_fd, names[i], IN_MODIFY);
 		}
-		SAFE_CLOSE(cleanup, inotify_fd);
+		SAFE_CLOSE(inotify_fd);
 	}
 	/* We survived for given time - test succeeded */
-	tst_resm(TPASS, "kernel survived inotify beating");
+	tst_res(TPASS, "kernel survived inotify beating");
 
 	/* Kill the child creating / deleting files and wait for it */
 	kill(pid, SIGKILL);
 	wait(NULL);
 }
 
-int main(int ac, char **av)
-{
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++)
-		verify_inotify();
-
-	cleanup();
-	tst_exit();
-}
+static struct tst_test test = {
+	.needs_tmpdir = 1,
+	.forks_child = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = verify_inotify,
+};
 
 #else
-
-int main(void)
-{
-	tst_brkm(TCONF, NULL, "system doesn't have required inotify support");
-}
-
+	TST_TEST_TCONF("system doesn't have required inotify support");
 #endif
-- 
2.7.4

