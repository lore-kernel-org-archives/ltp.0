From: Petr Vorel <pvorel@suse.cz>
Date: Wed,  5 Jun 2019 09:21:26 +0200
Subject: [LTP] [PATCH 2/2] inotify: Add SAFE_MYINOTIFY_ADD_WATCH() helper
In-Reply-To: <20190605072126.19856-1-pvorel@suse.cz>
References: <20190605072126.19856-1-pvorel@suse.cz>
Message-ID: <20190605072126.19856-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

with reap_wd defined in inotify.h there could be also SAFE_MYINOTIFY_RM_WATCH().

Kind regards,
Petr
---
 testcases/kernel/syscalls/inotify/inotify.h   | 13 +++++++++++++
 testcases/kernel/syscalls/inotify/inotify01.c |  9 ++-------
 testcases/kernel/syscalls/inotify/inotify02.c |  9 ++-------
 testcases/kernel/syscalls/inotify/inotify03.c |  7 +------
 testcases/kernel/syscalls/inotify/inotify04.c | 13 ++-----------
 testcases/kernel/syscalls/inotify/inotify05.c |  8 +-------
 testcases/kernel/syscalls/inotify/inotify07.c |  8 ++------
 testcases/kernel/syscalls/inotify/inotify08.c | 11 +++--------
 testcases/kernel/syscalls/inotify/inotify09.c |  4 +---
 9 files changed, 27 insertions(+), 55 deletions(-)

diff --git a/testcases/kernel/syscalls/inotify/inotify.h b/testcases/kernel/syscalls/inotify/inotify.h
index c82a7e75e..57669bc15 100644
--- a/testcases/kernel/syscalls/inotify/inotify.h
+++ b/testcases/kernel/syscalls/inotify/inotify.h
@@ -50,4 +50,17 @@ static inline int safe_myinotify_init(const char *file, const int lineno, int fd
 #define SAFE_MYINOTIFY_INIT1(flags) \
 	safe_myinotify_init(__FILE__, __LINE__, myinotify_init1(flags))
 
+static inline int safe_myinotify_watch(const char *file, const int lineno, int wd, int fd, const char* fname, const char* mask)
+{
+	if (wd < 0) {
+		tst_brk(TBROK | TERRNO,
+			"%s:%d: inotify_add_watch (%d, %s, %s) failed.",
+			file, lineno, fd, fname, mask);
+	}
+	return wd;
+}
+
+#define SAFE_MYINOTIFY_ADD_WATCH(fd, pathname, mask)	\
+	safe_myinotify_watch(__FILE__, __LINE__, myinotify_add_watch(fd, pathname, mask), fd, pathname, #mask)
+
 #endif /* _INOTIFY_H */
diff --git a/testcases/kernel/syscalls/inotify/inotify01.c b/testcases/kernel/syscalls/inotify/inotify01.c
index f08a75dcf..eee98b4fa 100644
--- a/testcases/kernel/syscalls/inotify/inotify01.c
+++ b/testcases/kernel/syscalls/inotify/inotify01.c
@@ -169,13 +169,8 @@ static void setup(void)
 
 	fd_notify = SAFE_MYINOTIFY_INIT();
 
-	if ((wd = myinotify_add_watch(fd_notify, fname, IN_ALL_EVENTS)) < 0) {
-		tst_brk(TBROK | TERRNO,
-			"inotify_add_watch (%d, %s, IN_ALL_EVENTS) failed",
-			fd_notify, fname);
-		reap_wd = 1;
-	};
-
+	wd = SAFE_MYINOTIFY_ADD_WATCH(fd_notify, fname, IN_ALL_EVENTS);
+	reap_wd = 1;
 }
 
 static void cleanup(void)
diff --git a/testcases/kernel/syscalls/inotify/inotify02.c b/testcases/kernel/syscalls/inotify/inotify02.c
index ca70b4e9e..21e7fb3e8 100644
--- a/testcases/kernel/syscalls/inotify/inotify02.c
+++ b/testcases/kernel/syscalls/inotify/inotify02.c
@@ -236,12 +236,8 @@ static void setup(void)
 {
 	fd_notify = SAFE_MYINOTIFY_INIT();
 
-	if ((wd = myinotify_add_watch(fd_notify, ".", IN_ALL_EVENTS)) < 0) {
-		tst_brk(TBROK | TERRNO,
-			 "inotify_add_watch (%d, \".\", IN_ALL_EVENTS) failed",
-			 fd_notify);
-		reap_wd = 1;
-	};
+	wd = SAFE_MYINOTIFY_ADD_WATCH(fd_notify, ".", IN_ALL_EVENTS);
+	reap_wd = 1;
 }
 
 static void cleanup(void)
@@ -249,7 +245,6 @@ static void cleanup(void)
 	if (reap_wd && myinotify_rm_watch(fd_notify, wd) < 0) {
 		tst_res(TWARN,
 			"inotify_rm_watch (%d, %d) failed,", fd_notify, wd);
-
 	}
 
 	if (fd_notify > 0)
diff --git a/testcases/kernel/syscalls/inotify/inotify03.c b/testcases/kernel/syscalls/inotify/inotify03.c
index 772623125..7363df01b 100644
--- a/testcases/kernel/syscalls/inotify/inotify03.c
+++ b/testcases/kernel/syscalls/inotify/inotify03.c
@@ -77,12 +77,7 @@ void verify_inotify(void)
 	SAFE_MOUNT(tst_device->dev, mntpoint, tst_device->fs_type, 0, NULL);
 	mount_flag = 1;
 
-	wd = myinotify_add_watch(fd_notify, fname, IN_ALL_EVENTS);
-	if (wd < 0) {
-		tst_brk(TBROK | TERRNO,
-			"inotify_add_watch (%d, %s, IN_ALL_EVENTS) failed.",
-			fd_notify, fname);
-	}
+	wd = SAFE_MYINOTIFY_ADD_WATCH(fd_notify, fname, IN_ALL_EVENTS);
 
 	event_set[test_cnt] = IN_UNMOUNT;
 	test_cnt++;
diff --git a/testcases/kernel/syscalls/inotify/inotify04.c b/testcases/kernel/syscalls/inotify/inotify04.c
index 6adb41701..2cc20fb61 100644
--- a/testcases/kernel/syscalls/inotify/inotify04.c
+++ b/testcases/kernel/syscalls/inotify/inotify04.c
@@ -106,19 +106,10 @@ void verify_inotify(void)
 	SAFE_MKDIR(TEST_DIR, 00700);
 	close(SAFE_CREAT(TEST_FILE, 00600));
 
-	wd_dir = myinotify_add_watch(fd_notify, TEST_DIR, IN_ALL_EVENTS);
-	if (wd_dir == -1) {
-		tst_brk(TBROK | TERRNO,
-			"inotify_add_watch(%d, \"%s\", IN_ALL_EVENTS) [1] failed",
-			fd_notify, TEST_DIR);
-	}
+	wd_dir = SAFE_MYINOTIFY_ADD_WATCH(fd_notify, TEST_DIR, IN_ALL_EVENTS);
 	reap_wd_dir = 1;
 
-	wd_file = myinotify_add_watch(fd_notify, TEST_FILE, IN_ALL_EVENTS);
-	if (wd_file == -1)
-		tst_brk(TBROK | TERRNO,
-			"inotify_add_watch(%d, \"%s\", IN_ALL_EVENTS) [2] failed",
-			fd_notify, TEST_FILE);
+	wd_file = SAFE_MYINOTIFY_ADD_WATCH(fd_notify, TEST_FILE, IN_ALL_EVENTS);
 	reap_wd_file = 1;
 
 	SAFE_RMDIR(TEST_DIR);
diff --git a/testcases/kernel/syscalls/inotify/inotify05.c b/testcases/kernel/syscalls/inotify/inotify05.c
index b5813b25b..fa45d09bf 100644
--- a/testcases/kernel/syscalls/inotify/inotify05.c
+++ b/testcases/kernel/syscalls/inotify/inotify05.c
@@ -145,12 +145,7 @@ static void setup(void)
 
 	fd_notify = SAFE_MYINOTIFY_INIT1(O_NONBLOCK);
 
-	wd = myinotify_add_watch(fd_notify, fname, IN_ALL_EVENTS);
-	if (wd < 0) {
-		tst_brk(TBROK | TERRNO,
-			"inotify_add_watch (%d, %s, IN_ALL_EVENTS) failed",
-			fd_notify, fname);
-	};
+	wd = SAFE_MYINOTIFY_ADD_WATCH(fd_notify, fname, IN_ALL_EVENTS);
 
 	SAFE_FILE_SCANF("/proc/sys/fs/inotify/max_queued_events",
 			"%d", &max_events);
@@ -161,7 +156,6 @@ static void cleanup(void)
 	if (fd_notify > 0 && myinotify_rm_watch(fd_notify, wd) == -1) {
 		tst_res(TWARN | TERRNO, "inotify_rm_watch (%d, %d) failed",
 			fd_notify, wd);
-
 	}
 
 	if (fd_notify > 0)
diff --git a/testcases/kernel/syscalls/inotify/inotify07.c b/testcases/kernel/syscalls/inotify/inotify07.c
index 1111b43bf..7099e8dbf 100644
--- a/testcases/kernel/syscalls/inotify/inotify07.c
+++ b/testcases/kernel/syscalls/inotify/inotify07.c
@@ -168,12 +168,8 @@ static void setup(void)
 	fd_notify = SAFE_MYINOTIFY_INIT1(O_NONBLOCK);
 
 	/* Setup a watch on an overlayfs lower directory */
-	if ((wd = myinotify_add_watch(fd_notify, DIR_PATH, IN_ALL_EVENTS)) < 0) {
-		tst_brk(TBROK | TERRNO,
-			"inotify_add_watch (%d, " DIR_PATH ", IN_ALL_EVENTS) failed",
-			fd_notify);
-		reap_wd = 1;
-	};
+	wd = SAFE_MYINOTIFY_ADD_WATCH(fd_notify, DIR_PATH, IN_ALL_EVENTS);
+	reap_wd = 1;
 
 	SAFE_STAT(DIR_PATH, &buf);
 	tst_res(TINFO, DIR_PATH " ino=%lu", buf.st_ino);
diff --git a/testcases/kernel/syscalls/inotify/inotify08.c b/testcases/kernel/syscalls/inotify/inotify08.c
index ee8e44fe1..73fdf497f 100644
--- a/testcases/kernel/syscalls/inotify/inotify08.c
+++ b/testcases/kernel/syscalls/inotify/inotify08.c
@@ -160,14 +160,9 @@ static void setup(void)
 	fd_notify = SAFE_MYINOTIFY_INIT1(O_NONBLOCK);
 
 	/* Setup a watch on an overlayfs lower file */
-	if ((wd = myinotify_add_watch(fd_notify, FILE_PATH,
-				IN_ATTRIB | IN_OPEN | IN_CLOSE_WRITE)) < 0) {
-		tst_brk(TBROK | TERRNO,
-			"inotify_add_watch (%d, " FILE_PATH ", "
-			"IN_ATTRIB | IN_OPEN | IN_CLOSE_WRITE) failed",
-			fd_notify);
-		reap_wd = 1;
-	};
+	wd = SAFE_MYINOTIFY_ADD_WATCH(fd_notify, FILE_PATH,
+				IN_ATTRIB | IN_OPEN | IN_CLOSE_WRITE);
+	reap_wd = 1;
 
 	SAFE_STAT(FILE_PATH, &buf);
 	tst_res(TINFO, FILE_PATH " ino=%lu, dev=%u:%u", buf.st_ino,
diff --git a/testcases/kernel/syscalls/inotify/inotify09.c b/testcases/kernel/syscalls/inotify/inotify09.c
index cf2d38f27..e6fed7d9d 100644
--- a/testcases/kernel/syscalls/inotify/inotify09.c
+++ b/testcases/kernel/syscalls/inotify/inotify09.c
@@ -89,9 +89,7 @@ static void verify_inotify(void)
 
 	tst_fzsync_pair_reset(&fzsync_pair, write_seek);
 	while (tst_fzsync_run_a(&fzsync_pair)) {
-		wd = myinotify_add_watch(inotify_fd, FNAME, IN_MODIFY);
-		if (wd < 0)
-			tst_brk(TBROK | TERRNO, "inotify_add_watch() failed.");
+		wd = SAFE_MYINOTIFY_ADD_WATCH(inotify_fd, FNAME, IN_MODIFY);
 
 		tst_fzsync_start_race_a(&fzsync_pair);
 		wd = myinotify_rm_watch(inotify_fd, wd);
-- 
2.21.0

