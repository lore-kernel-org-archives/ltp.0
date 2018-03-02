From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri,  2 Mar 2018 16:48:37 +0100
Subject: [LTP] [COMMITTED] [PATCH 3/7] syscalls/inotify03: Fix && cleanup.
In-Reply-To: <20180302154841.4093-1-chrubis@suse.cz>
References: <20180302154841.4093-1-chrubis@suse.cz>
Message-ID: <20180302154841.4093-3-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

* We umount the device in the test hence we have to mount it there as
  well otherwise this will break the -i looping option

* Make use of SAFE_MACROS() even in cleanup since we are using newlib

* Get rid of TST_TOTAL, use test_cnt instead

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/inotify/inotify03.c | 46 +++++++++++++--------------
 1 file changed, 22 insertions(+), 24 deletions(-)

diff --git a/testcases/kernel/syscalls/inotify/inotify03.c b/testcases/kernel/syscalls/inotify/inotify03.c
index 8077976b6..6bc5e7424 100644
--- a/testcases/kernel/syscalls/inotify/inotify03.c
+++ b/testcases/kernel/syscalls/inotify/inotify03.c
@@ -47,8 +47,6 @@
 #if defined(HAVE_SYS_INOTIFY_H)
 #include <sys/inotify.h>
 
-#define TST_TOTAL 3
-
 #define EVENT_MAX 1024
 /* size of the event structure, not counting name */
 #define EVENT_SIZE (sizeof(struct inotify_event))
@@ -74,21 +72,25 @@ void verify_inotify(void)
 	int ret;
 	int len, i, test_num;
 
-	int tst_count = 0;
-
-	event_set[tst_count] = IN_UNMOUNT;
-	tst_count++;
-	event_set[tst_count] = IN_IGNORED;
-	tst_count++;
+	int test_cnt = 0;
 
-	/*check exit code from inotify_rm_watch */
-	tst_count++;
+	SAFE_MOUNT(tst_device->dev, mntpoint, tst_device->fs_type, 0, NULL);
+	mount_flag = 1;
 
-	if (TST_TOTAL != tst_count) {
-		tst_brk(TBROK,
-			"TST_TOTAL and tst_count are not equal");
+	wd = myinotify_add_watch(fd_notify, fname, IN_ALL_EVENTS);
+	if (wd < 0) {
+		tst_brk(TBROK | TERRNO,
+			"inotify_add_watch (%d, %s, IN_ALL_EVENTS) failed.",
+			fd_notify, fname);
 	}
-	tst_count = 0;
+
+	event_set[test_cnt] = IN_UNMOUNT;
+	test_cnt++;
+	event_set[test_cnt] = IN_IGNORED;
+	test_cnt++;
+
+	/*check exit code from inotify_rm_watch */
+	test_cnt++;
 
 	tst_res(TINFO, "umount %s", tst_device->dev);
 	TEST(tst_umount(mntpoint));
@@ -111,7 +113,7 @@ void verify_inotify(void)
 	while (i < len) {
 		struct inotify_event *event;
 		event = (struct inotify_event *)&event_buf[i];
-		if (test_num >= (TST_TOTAL - 1)) {
+		if (test_num >= (test_cnt - 1)) {
 			tst_res(TFAIL,
 				"get unnecessary event: wd=%d mask=%x "
 				"cookie=%u len=%u",
@@ -133,7 +135,7 @@ void verify_inotify(void)
 		test_num++;
 		i += EVENT_SIZE + event->len;
 	}
-	for (; test_num < TST_TOTAL - 1; test_num++) {
+	for (; test_num < test_cnt - 1; test_num++) {
 		tst_res(TFAIL, "don't get event: mask=%x ",
 			event_set[test_num]);
 
@@ -170,7 +172,6 @@ static void setup(void)
 	SAFE_CLOSE(fd);
 
 	fd_notify = myinotify_init();
-
 	if (fd_notify < 0) {
 		if (errno == ENOSYS)
 			tst_brk(TCONF,
@@ -180,17 +181,14 @@ static void setup(void)
 				"inotify_init failed");
 	}
 
-	wd = myinotify_add_watch(fd_notify, fname, IN_ALL_EVENTS);
-	if (wd < 0)
-		tst_brk(TBROK | TERRNO,
-			"inotify_add_watch (%d, %s, IN_ALL_EVENTS) failed.",
-			fd_notify, fname);
+	tst_umount(mntpoint);
+	mount_flag = 0;
 }
 
 static void cleanup(void)
 {
-	if (fd_notify > 0 && close(fd_notify) == -1)
-		tst_res(TWARN | TERRNO, "close(%d) failed", fd_notify);
+	if (fd_notify > 0)
+		SAFE_CLOSE(fd_notify);
 
 	if (mount_flag) {
 		TEST(tst_umount(mntpoint));
-- 
2.13.6

