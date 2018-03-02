From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri,  2 Mar 2018 16:48:41 +0100
Subject: [LTP] [COMMITTED] [PATCH 7/7] syscalls/inotify04: Fix & Cleanups.
In-Reply-To: <20180302154841.4093-1-chrubis@suse.cz>
References: <20180302154841.4093-1-chrubis@suse.cz>
Message-ID: <20180302154841.4093-7-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

* Move file/directory creation from setup to
  the test fuction, we remove these in the test
  fucntion hence we have to create them on each
  iteration as well for the -i option

* Get rid of TST_TOTAL, use test_cnt instead
  as a side effect this fixes the -i option

* Make use of SAFE_MACROS() in cleanup

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/inotify/inotify04.c | 80 ++++++++++++---------------
 1 file changed, 36 insertions(+), 44 deletions(-)

diff --git a/testcases/kernel/syscalls/inotify/inotify04.c b/testcases/kernel/syscalls/inotify/inotify04.c
index e7f862026..36673d6eb 100644
--- a/testcases/kernel/syscalls/inotify/inotify04.c
+++ b/testcases/kernel/syscalls/inotify/inotify04.c
@@ -40,7 +40,7 @@
 #include "config.h"
 
 #if defined(HAVE_SYS_INOTIFY_H)
-#include <sys/inotify.h>
+# include <sys/inotify.h>
 #endif
 #include <errno.h>
 #include <string.h>
@@ -49,8 +49,6 @@
 
 #if defined(HAVE_SYS_INOTIFY_H)
 
-int TST_TOTAL = 4;
-
 #define EVENT_MAX 1024
 /* size of the event structure, not counting name */
 #define EVENT_SIZE  (sizeof(struct inotify_event))
@@ -91,8 +89,8 @@ static void cleanup(void)
 			"inotify_rm_watch(%d, %d) [2] failed", fd_notify,
 			wd_file);
 
-	if (fd_notify > 0 && close(fd_notify))
-		tst_res(TWARN, "close(%d) [1] failed", fd_notify);
+	if (fd_notify > 0)
+		SAFE_CLOSE(fd_notify);
 }
 
 static void setup(void)
@@ -107,9 +105,14 @@ static void setup(void)
 				"inotify_init failed");
 		}
 	}
+}
 
-	SAFE_MKDIR(TEST_DIR, 00700);
+void verify_inotify(void)
+{
+	int i = 0, test_num = 0, len;
+	int test_cnt = 0;
 
+	SAFE_MKDIR(TEST_DIR, 00700);
 	close(SAFE_CREAT(TEST_FILE, 00600));
 
 	wd_dir = myinotify_add_watch(fd_notify, TEST_DIR, IN_ALL_EVENTS);
@@ -126,23 +129,20 @@ static void setup(void)
 			"inotify_add_watch(%d, \"%s\", IN_ALL_EVENTS) [2] failed",
 			fd_notify, TEST_FILE);
 	reap_wd_file = 1;
-}
 
-void verify_inotify(void)
-{
-	int i = 0, test_num = 0, len;
+	SAFE_RMDIR(TEST_DIR);
+	reap_wd_dir = 0;
 
-	int tst_count = 0;
+	event_set[test_cnt].mask = IN_DELETE_SELF;
+	strcpy(event_set[test_cnt].name, "");
+	test_cnt++;
+	event_set[test_cnt].mask = IN_IGNORED;
+	strcpy(event_set[test_cnt].name, "");
+	test_cnt++;
 
-	rmdir(TEST_DIR);
-	event_set[tst_count].mask = IN_DELETE_SELF;
-	strcpy(event_set[tst_count].name, "");
-	tst_count++;
-	event_set[tst_count].mask = IN_IGNORED;
-	strcpy(event_set[tst_count].name, "");
-	tst_count++;
+	SAFE_UNLINK(TEST_FILE);
+	reap_wd_file = 0;
 
-	unlink(TEST_FILE);
 	/*
 	 * When a file is unlinked, the link count is reduced by 1, and when it
 	 * hits 0 the file is removed.
@@ -151,37 +151,28 @@ void verify_inotify(void)
 	 * understand how Unix works.
 	 */
 	if (tst_kvercmp2(2, 6, 25, kvers) >= 0) {
-		event_set[tst_count].mask = IN_ATTRIB;
-		strcpy(event_set[tst_count].name, "");
-		tst_count++;
-		TST_TOTAL++;
+		event_set[test_cnt].mask = IN_ATTRIB;
+		strcpy(event_set[test_cnt].name, "");
+		test_cnt++;
 	}
-	event_set[tst_count].mask = IN_DELETE_SELF;
-	strcpy(event_set[tst_count].name, TEST_FILE);
-	tst_count++;
-	event_set[tst_count].mask = IN_IGNORED;
-	strcpy(event_set[tst_count].name, "");
-	tst_count++;
-
-	if (tst_count != TST_TOTAL)
-		tst_brk(TBROK,
-			"tst_count and TST_TOTAL are not equal");
 
-	tst_count = 0;
+	event_set[test_cnt].mask = IN_DELETE_SELF;
+	strcpy(event_set[test_cnt].name, TEST_FILE);
+	test_cnt++;
+	event_set[test_cnt].mask = IN_IGNORED;
+	strcpy(event_set[test_cnt].name, "");
+	test_cnt++;
 
 	len = read(fd_notify, event_buf, EVENT_BUF_LEN);
 	if (len == -1)
 		tst_brk(TBROK | TERRNO, "read failed");
 
-	reap_wd_dir = 0;
-	reap_wd_file = 0;
-
 	while (i < len) {
 		struct inotify_event *event;
 		event = (struct inotify_event *)&event_buf[i];
-		if (test_num >= TST_TOTAL) {
+		if (test_num >= test_cnt) {
 			if (tst_kvercmp(2, 6, 25) < 0
-			    && event_set[TST_TOTAL - 1].mask == event->mask)
+			    && event_set[test_cnt - 1].mask == event->mask)
 				tst_res(TWARN,
 					"This may be kernel bug. "
 					"Before kernel 2.6.25, a kernel bug "
@@ -196,7 +187,7 @@ void verify_inotify(void)
 					"1c17d18e3775485bf1e0ce79575eb637a94494a2.");
 			tst_res(TFAIL,
 				"got unnecessary event: "
-				"wd=%d mask=%x cookie=%u len=%u "
+				"wd=%d mask=%04x cookie=%u len=%u "
 				"name=\"%.*s\"", event->wd, event->mask,
 				event->cookie, event->len, event->len, event->name);
 
@@ -206,13 +197,13 @@ void verify_inotify(void)
 			    (event_set[test_num].name, event->name,
 			     event->len))) {
 			tst_res(TPASS,
-				"got event: wd=%d mask=%x "
+				"got event: wd=%d mask=%04x "
 				"cookie=%u len=%u name=\"%.*s\"",
 				event->wd, event->mask, event->cookie,
 				event->len, event->len, event->name);
 
 		} else {
-			tst_res(TFAIL, "got event: wd=%d mask=%x "
+			tst_res(TFAIL, "got event: wd=%d mask=%04x "
 				"(expected %x) cookie=%u len=%u "
 				"name=\"%.*s\" (expected \"%s\") %d",
 				event->wd, event->mask,
@@ -226,10 +217,11 @@ void verify_inotify(void)
 		i += EVENT_SIZE + event->len;
 	}
 
-	for (; test_num < TST_TOTAL; test_num++) {
-		tst_res(TFAIL, "didn't get event: mask=%x ",
+	for (; test_num < test_cnt; test_num++) {
+		tst_res(TFAIL, "didn't get event: mask=%04x ",
 			event_set[test_num].mask);
 	}
+
 }
 
 static struct tst_test test = {
-- 
2.13.6

