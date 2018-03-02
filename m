From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri,  2 Mar 2018 16:48:35 +0100
Subject: [LTP] [COMMITTED] [PATCH 1/7] syscalls/inotify01: Cleanup
Message-ID: <20180302154841.4093-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

* Align the test messages for better readability

* Make use of SAFE_MACROS() even in cleanup since we are using newlib

* Get rid of TST_TOTAL, use test_cnt instead

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/inotify/inotify01.c | 72 +++++++++++----------------
 1 file changed, 28 insertions(+), 44 deletions(-)

diff --git a/testcases/kernel/syscalls/inotify/inotify01.c b/testcases/kernel/syscalls/inotify/inotify01.c
index d3153ac5a..f0cf51297 100644
--- a/testcases/kernel/syscalls/inotify/inotify01.c
+++ b/testcases/kernel/syscalls/inotify/inotify01.c
@@ -43,8 +43,6 @@
 #if defined(HAVE_SYS_INOTIFY_H)
 #include <sys/inotify.h>
 
-#define TST_TOTAL 7
-
 #define EVENT_MAX 1024
 /* size of the event structure, not counting name */
 #define EVENT_SIZE  (sizeof (struct inotify_event))
@@ -52,6 +50,7 @@
 #define EVENT_BUF_LEN        (EVENT_MAX * (EVENT_SIZE + 16))
 
 #define BUF_SIZE 256
+
 static char fname[BUF_SIZE];
 static char buf[BUF_SIZE];
 static int fd, fd_notify;
@@ -63,59 +62,53 @@ static char event_buf[EVENT_BUF_LEN];
 
 void verify_inotify(void)
 {
-	int tst_count = 0;
+	int test_cnt = 0;
 
 	/*
 	 * generate sequence of events
 	 */
 	SAFE_CHMOD(fname, 0755);
-	event_set[tst_count] = IN_ATTRIB;
-	tst_count++;
+	event_set[test_cnt] = IN_ATTRIB;
+	test_cnt++;
 
 	if ((fd = open(fname, O_RDONLY)) == -1) {
 		tst_brk(TBROK | TERRNO,
 			"open(%s, O_RDWR|O_CREAT,0700) failed", fname);
 	}
-	event_set[tst_count] = IN_OPEN;
-	tst_count++;
+	event_set[test_cnt] = IN_OPEN;
+	test_cnt++;
 
 	if (read(fd, buf, BUF_SIZE) == -1) {
 		tst_brk(TBROK | TERRNO,
 			"read(%d, buf, %d) failed", fd, BUF_SIZE);
 	}
-	event_set[tst_count] = IN_ACCESS;
-	tst_count++;
+	event_set[test_cnt] = IN_ACCESS;
+	test_cnt++;
 
 	SAFE_CLOSE(fd);
-	event_set[tst_count] = IN_CLOSE_NOWRITE;
-	tst_count++;
+	event_set[test_cnt] = IN_CLOSE_NOWRITE;
+	test_cnt++;
 
 	if ((fd = open(fname, O_RDWR | O_CREAT, 0700)) == -1) {
 		tst_brk(TBROK,
 			"open(%s, O_RDWR|O_CREAT,0700) failed", fname);
 	}
-	event_set[tst_count] = IN_OPEN;
-	tst_count++;
+	event_set[test_cnt] = IN_OPEN;
+	test_cnt++;
 
 	if (write(fd, buf, BUF_SIZE) == -1) {
 		tst_brk(TBROK,
 			"write(%d, %s, 1) failed", fd, fname);
 	}
-	event_set[tst_count] = IN_MODIFY;
-	tst_count++;
+	event_set[test_cnt] = IN_MODIFY;
+	test_cnt++;
 
 	SAFE_CLOSE(fd);
-	event_set[tst_count] = IN_CLOSE_WRITE;
-	tst_count++;
-
-	if (TST_TOTAL != tst_count) {
-		tst_brk(TBROK,
-			"TST_TOTAL and tst_count are not equal");
-	}
-	tst_count = 0;
+	event_set[test_cnt] = IN_CLOSE_WRITE;
+	test_cnt++;
 
 	/*
-	 * get list on events
+	 * get list of events
 	 */
 	int len, i = 0, test_num = 0;
 	if ((len = read(fd_notify, event_buf, EVENT_BUF_LEN)) < 0) {
@@ -131,28 +124,28 @@ void verify_inotify(void)
 	while (i < len) {
 		struct inotify_event *event;
 		event = (struct inotify_event *)&event_buf[i];
-		if (test_num >= TST_TOTAL) {
+		if (test_num >= test_cnt) {
 			tst_res(TFAIL,
-				"get unnecessary event: wd=%d mask=%x "
+				"get unnecessary event: wd=%d mask=%02x "
 				"cookie=%u len=%u",
 				event->wd, event->mask,
 				event->cookie, event->len);
 		} else if (event_set[test_num] == event->mask) {
 			if (event->cookie != 0) {
 				tst_res(TFAIL,
-					"get event: wd=%d mask=%x "
+					"get event: wd=%d mask=%02x "
 					"cookie=%u (expected 0) len=%u",
 					event->wd, event->mask,
 					event->cookie, event->len);
 			} else {
 				tst_res(TPASS, "get event: wd=%d "
-					"mask=%x cookie=%u len=%u",
+					"mask=%02x cookie=%u len=%u",
 					event->wd, event->mask,
 					event->cookie, event->len);
 			}
 
 		} else {
-			tst_res(TFAIL, "get event: wd=%d mask=%x "
+			tst_res(TFAIL, "get event: wd=%d mask=%02x "
 				"(expected %x) cookie=%u len=%u",
 				event->wd, event->mask,
 				event_set[test_num],
@@ -161,8 +154,8 @@ void verify_inotify(void)
 		test_num++;
 		i += EVENT_SIZE + event->len;
 	}
-	for (; test_num < TST_TOTAL; test_num++) {
-		tst_res(TFAIL, "didn't get event: mask=%x",
+	for (; test_num < test_cnt; test_num++) {
+		tst_res(TFAIL, "didn't get event: mask=%02x",
 			event_set[test_num]);
 
 	}
@@ -171,17 +164,9 @@ void verify_inotify(void)
 static void setup(void)
 {
 	sprintf(fname, "tfile_%d", getpid());
-	if ((fd = open(fname, O_RDWR | O_CREAT, 0700)) == -1) {
-		tst_brk(TBROK | TERRNO,
-			"open(%s, O_RDWR|O_CREAT,0700) failed", fname);
-	}
-	if ((write(fd, fname, 1)) == -1) {
-		tst_brk(TBROK | TERRNO, "write(%d, %s, 1) failed",
-			fd, fname);
-	}
 
-	/* close the file we have open */
-	SAFE_CLOSE(fd);
+	SAFE_FILE_PRINTF(fname, "%s", fname);
+
 	if ((fd_notify = myinotify_init()) < 0) {
 		if (errno == ENOSYS) {
 			tst_brk(TCONF,
@@ -206,11 +191,10 @@ static void cleanup(void)
 	if (reap_wd && myinotify_rm_watch(fd_notify, wd) < 0) {
 		tst_res(TWARN | TERRNO, "inotify_rm_watch (%d, %d) failed",
 			fd_notify, wd);
-
 	}
 
-	if (fd_notify > 0 && close(fd_notify))
-		tst_res(TWARN, "close(%d) failed", fd_notify);
+	if (fd_notify > 0)
+		SAFE_CLOSE(fd_notify);
 }
 
 static struct tst_test test = {
-- 
2.13.6

