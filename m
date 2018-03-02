From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri,  2 Mar 2018 16:48:36 +0100
Subject: [LTP] [COMMITTED] [PATCH 2/7] syscalls/inotify02: Cleanup
In-Reply-To: <20180302154841.4093-1-chrubis@suse.cz>
References: <20180302154841.4093-1-chrubis@suse.cz>
Message-ID: <20180302154841.4093-2-chrubis@suse.cz>
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
 testcases/kernel/syscalls/inotify/inotify02.c | 91 ++++++++++++---------------
 1 file changed, 41 insertions(+), 50 deletions(-)

diff --git a/testcases/kernel/syscalls/inotify/inotify02.c b/testcases/kernel/syscalls/inotify/inotify02.c
index 47419102a..02eb85764 100644
--- a/testcases/kernel/syscalls/inotify/inotify02.c
+++ b/testcases/kernel/syscalls/inotify/inotify02.c
@@ -45,8 +45,6 @@
 #if defined(HAVE_SYS_INOTIFY_H)
 #include <sys/inotify.h>
 
-#define TST_TOTAL 9
-
 #ifndef IN_MOVE_SELF
 #define IN_MOVE_SELF            0x00000800
 #endif
@@ -77,40 +75,40 @@ void verify_inotify(void)
 {
 	unsigned int stored_cookie = UINT_MAX;
 
-	int tst_count = 0;
+	int test_cnt = 0;
 
 	/*
 	 * generate sequence of events
 	 */
 	SAFE_CHMOD(".", 0755);
-	event_set[tst_count].mask = IN_ISDIR | IN_ATTRIB;
-	strcpy(event_set[tst_count].name, "");
-	tst_count++;
+	event_set[test_cnt].mask = IN_ISDIR | IN_ATTRIB;
+	strcpy(event_set[test_cnt].name, "");
+	test_cnt++;
 
 	if ((fd = creat(FILE_NAME1, 0755)) == -1) {
 		tst_brk(TBROK | TERRNO,
 			"creat(\"%s\", 755) failed", FILE_NAME1);
 	}
 
-	event_set[tst_count].mask = IN_CREATE;
-	strcpy(event_set[tst_count].name, FILE_NAME1);
-	tst_count++;
-	event_set[tst_count].mask = IN_OPEN;
-	strcpy(event_set[tst_count].name, FILE_NAME1);
-	tst_count++;
+	event_set[test_cnt].mask = IN_CREATE;
+	strcpy(event_set[test_cnt].name, FILE_NAME1);
+	test_cnt++;
+	event_set[test_cnt].mask = IN_OPEN;
+	strcpy(event_set[test_cnt].name, FILE_NAME1);
+	test_cnt++;
 
 	SAFE_CLOSE(fd);
-	event_set[tst_count].mask = IN_CLOSE_WRITE;
-	strcpy(event_set[tst_count].name, FILE_NAME1);
-	tst_count++;
+	event_set[test_cnt].mask = IN_CLOSE_WRITE;
+	strcpy(event_set[test_cnt].name, FILE_NAME1);
+	test_cnt++;
 
 	SAFE_RENAME(FILE_NAME1, FILE_NAME2);
-	event_set[tst_count].mask = IN_MOVED_FROM;
-	strcpy(event_set[tst_count].name, FILE_NAME1);
-	tst_count++;
-	event_set[tst_count].mask = IN_MOVED_TO;
-	strcpy(event_set[tst_count].name, FILE_NAME2);
-	tst_count++;
+	event_set[test_cnt].mask = IN_MOVED_FROM;
+	strcpy(event_set[test_cnt].name, FILE_NAME1);
+	test_cnt++;
+	event_set[test_cnt].mask = IN_MOVED_TO;
+	strcpy(event_set[test_cnt].name, FILE_NAME2);
+	test_cnt++;
 
 	if (getcwd(fname1, BUF_SIZE) == NULL) {
 		tst_brk(TBROK | TERRNO,
@@ -119,14 +117,14 @@ void verify_inotify(void)
 
 	snprintf(fname2, BUF_SIZE, "%s.rename1", fname1);
 	SAFE_RENAME(fname1, fname2);
-	event_set[tst_count].mask = IN_MOVE_SELF;
-	strcpy(event_set[tst_count].name, "");
-	tst_count++;
+	event_set[test_cnt].mask = IN_MOVE_SELF;
+	strcpy(event_set[test_cnt].name, "");
+	test_cnt++;
 
 	SAFE_UNLINK(FILE_NAME2);
-	event_set[tst_count].mask = IN_DELETE;
-	strcpy(event_set[tst_count].name, FILE_NAME2);
-	tst_count++;
+	event_set[test_cnt].mask = IN_DELETE;
+	strcpy(event_set[test_cnt].name, FILE_NAME2);
+	test_cnt++;
 
 	/*
 	 * test that duplicate events will be coalesced into
@@ -138,16 +136,9 @@ void verify_inotify(void)
 	SAFE_RENAME(fname2, fname3);
 
 	SAFE_RENAME(fname3, fname1);
-	event_set[tst_count].mask = IN_MOVE_SELF;
-	strcpy(event_set[tst_count].name, "");
-	tst_count++;
-
-	if (tst_count != TST_TOTAL) {
-		tst_brk(TBROK,
-			"tst_count and TST_TOTAL are not equal");
-	}
-
-	tst_count = 0;
+	event_set[test_cnt].mask = IN_MOVE_SELF;
+	strcpy(event_set[test_cnt].name, "");
+	test_cnt++;
 
 	int len, i = 0, test_num = 0;
 	if ((len = read(fd_notify, event_buf, EVENT_BUF_LEN)) == -1) {
@@ -160,9 +151,9 @@ void verify_inotify(void)
 	while (i < len) {
 		struct inotify_event *event;
 		event = (struct inotify_event *)&event_buf[i];
-		if (test_num >= TST_TOTAL) {
+		if (test_num >= test_cnt) {
 			if (tst_kvercmp(2, 6, 25) < 0
-					&& event_set[TST_TOTAL - 1].mask ==
+					&& event_set[test_cnt - 1].mask ==
 					event->mask)
 				tst_res(TWARN,
 					"This may be kernel bug. "
@@ -178,7 +169,7 @@ void verify_inotify(void)
 					"1c17d18e3775485bf1e0ce79575eb637a94494a2.");
 			tst_res(TFAIL,
 				"get unnecessary event: "
-				"wd=%d mask=%x cookie=%u len=%u"
+				"wd=%d mask=%08x cookie=%-5u len=%-2u"
 				"name=\"%.*s\"", event->wd, event->mask,
 				event->cookie, event->len, event->len,
 				event->name);
@@ -206,23 +197,23 @@ void verify_inotify(void)
 			}
 			if (!fail) {
 				tst_res(TPASS,
-					"get event: wd=%d mask=%x "
-					"cookie=%u len=%u name=\"%.*s\"",
+					"get event: wd=%d mask=%08x "
+					"cookie=%-5u len=%-2u name=\"%.*s\"",
 					event->wd, event->mask,
 					event->cookie, event->len,
 					event->len, event->name);
 			} else {
 				tst_res(TFAIL,
-					"get event: wd=%d mask=%x "
-					"cookie=%u (wrong) len=%u "
+					"get event: wd=%d mask=%08x "
+					"cookie=%-5u (wrong) len=%-2u "
 					"name=\"%s\"",
 					event->wd, event->mask,
 					event->cookie, event->len,
 					event->name);
 			}
 		} else {
-			tst_res(TFAIL, "get event: wd=%d mask=%x "
-				"(expected %x) cookie=%u len=%u "
+			tst_res(TFAIL, "get event: wd=%d mask=%08x "
+				"(expected %x) cookie=%-5u len=%-2u "
 				"name=\"%s\" (expected \"%s\") %d",
 				event->wd, event->mask,
 				event_set[test_num].mask,
@@ -235,8 +226,8 @@ void verify_inotify(void)
 		i += EVENT_SIZE + event->len;
 	}
 
-	for (; test_num < TST_TOTAL; test_num++) {
-		tst_res(TFAIL, "didn't get event: mask=%x ",
+	for (; test_num < test_cnt; test_num++) {
+		tst_res(TFAIL, "didn't get event: mask=%08x ",
 			event_set[test_num].mask);
 	}
 }
@@ -269,8 +260,8 @@ static void cleanup(void)
 
 	}
 
-	if (fd_notify > 0 && close(fd_notify))
-		tst_res(TWARN, "close(%d) failed", fd_notify);
+	if (fd_notify > 0)
+		SAFE_CLOSE(fd_notify);
 }
 
 static struct tst_test test = {
-- 
2.13.6

