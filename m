From: Amir Goldstein <amir73il@gmail.com>
Date: Mon,  5 Nov 2018 12:07:22 +0200
Subject: [LTP] [PATCH] fanotify09: check merging of events on child subdir
Message-ID: <20181105100722.1812-1-amir73il@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

In a setup of mount mark and directory inode mark on children
mount mark should not be getting double events "on child" and "on self"
for the same action.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Jan,

FYI, this patch improves fanotify09 to cover the bug fixed by
kernel patch "fanotify: fix handling of events on child sub-directory".
Note that this patch is based on a cleanup patch available at [1].

Thanks,
Amir.

[1] https://github.com/amir73il/ltp/commits/fanotify_cleanup

 .../kernel/syscalls/fanotify/fanotify09.c     | 104 ++++++++++++------
 1 file changed, 68 insertions(+), 36 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify09.c b/testcases/kernel/syscalls/fanotify/fanotify09.c
index 511ccc0e0..ef948c8a9 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify09.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify09.c
@@ -39,16 +39,20 @@
 
 #define BUF_SIZE 256
 static char fname[BUF_SIZE];
+static char symlnk[BUF_SIZE];
+static char fdpath[BUF_SIZE];
 static int fd_notify[NUM_GROUPS];
 
 static char event_buf[EVENT_BUF_LEN];
 
 #define MOUNT_NAME "mntpoint"
+#define DIR_NAME "testdir"
 static int mount_created;
 
 static void create_fanotify_groups(void)
 {
 	unsigned int i, onchild;
+	const char *onchildstr;
 	int ret;
 
 	for (i = 0; i < NUM_GROUPS; i++) {
@@ -56,34 +60,39 @@ static void create_fanotify_groups(void)
 						  FAN_NONBLOCK,
 						  O_RDONLY);
 
-		/* Add mount mark for each group without MODIFY event */
-		ret = fanotify_mark(fd_notify[i],
-				    FAN_MARK_ADD | FAN_MARK_MOUNT,
-				    FAN_CLOSE_NOWRITE,
+		onchild = i == 0 ? FAN_EVENT_ON_CHILD | FAN_ONDIR : 0;
+		onchildstr = i == 0 ? " | FAN_EVENT_ON_CHILD  | FAN_ONDIR" : "";
+
+		/*
+		 * Add mount mark for each group without MODIFY event.
+		 * The first group only gets events on directories - the request
+		 * for events on child for mount mark is ignored.
+		 */
+		ret = fanotify_mark(fd_notify[i], FAN_MARK_ADD | FAN_MARK_MOUNT,
+				    FAN_CLOSE_NOWRITE | onchild,
 				    AT_FDCWD, ".");
 		if (ret < 0) {
 			tst_brk(TBROK | TERRNO,
 				"fanotify_mark(%d, FAN_MARK_ADD | "
-				"FAN_MARK_MOUNT, FAN_MODIFY, AT_FDCWD,"
-				" '.') failed", fd_notify[i]);
+				"FAN_MARK_MOUNT, FAN_CLOSE_NOWRITE%s"
+				", AT_FDCWD, '.') failed",
+				fd_notify[i], onchildstr);
 		}
 		/*
-		 * Add inode mark on parent for each group with MODIFY
-		 * event, but only one group requests events on child.
+		 * Add inode mark on parent for each group with MODIFY event,
+		 * but only one group requests events on child (and subdirs).
 		 * The one mark with FAN_EVENT_ON_CHILD is needed for
 		 * setting the DCACHE_FSNOTIFY_PARENT_WATCHED dentry
 		 * flag.
 		 */
-		onchild = (i == 0) ? FAN_EVENT_ON_CHILD : 0;
-		ret = fanotify_mark(fd_notify[i],
-				    FAN_MARK_ADD,
-				    FAN_MODIFY | onchild, AT_FDCWD, ".");
+		ret = fanotify_mark(fd_notify[i], FAN_MARK_ADD,
+				    FAN_MODIFY | onchild,
+				    AT_FDCWD, ".");
 		if (ret < 0) {
 			tst_brk(TBROK | TERRNO,
 				"fanotify_mark(%d, FAN_MARK_ADD, "
 				"FAN_MODIFY%s, AT_FDCWD, '.') failed",
-				fd_notify[i],
-				onchild ? " | FAN_EVENT_ON_CHILD" : "");
+				fd_notify[i], onchildstr);
 		}
 	}
 }
@@ -98,12 +107,13 @@ static void cleanup_fanotify_groups(void)
 	}
 }
 
-static void verify_event(int group, struct fanotify_event_metadata *event)
+static void verify_event(int group, struct fanotify_event_metadata *event,
+			 __u32 expect)
 {
-	if (event->mask != FAN_MODIFY) {
+	if (event->mask != expect) {
 		tst_res(TFAIL, "group %d got event: mask %llx (expected %llx) "
 			"pid=%u fd=%d", group, (unsigned long long)event->mask,
-			(unsigned long long)FAN_MODIFY,
+			(unsigned long long)expect,
 			(unsigned)event->pid, event->fd);
 	} else if (event->pid != getpid()) {
 		tst_res(TFAIL, "group %d got event: mask %llx pid=%u "
@@ -111,17 +121,23 @@ static void verify_event(int group, struct fanotify_event_metadata *event)
 			(unsigned long long)event->mask, (unsigned)event->pid,
 			(unsigned)getpid(), event->fd);
 	} else {
-		tst_res(TPASS, "group %d got event: mask %llx pid=%u fd=%d",
+		int len;
+		sprintf(symlnk, "/proc/self/fd/%d", event->fd);
+		len = readlink(symlnk, fdpath, sizeof(fdpath));
+		if (len < 0)
+			len = 0;
+		fdpath[len] = 0;
+		tst_res(TPASS, "group %d got event: mask %llx pid=%u fd=%d path=%s",
 			group, (unsigned long long)event->mask,
-			(unsigned)event->pid, event->fd);
+			(unsigned)event->pid, event->fd, fdpath);
 	}
 }
 
 void test01(void)
 {
-	int ret;
+	int ret, dirfd;
 	unsigned int i;
-	struct fanotify_event_metadata *event;
+	struct fanotify_event_metadata *event, *ev;
 
 	create_fanotify_groups();
 
@@ -129,8 +145,17 @@ void test01(void)
 	 * generate MODIFY event and no FAN_CLOSE_NOWRITE event.
 	 */
 	SAFE_FILE_PRINTF(fname, "1");
+	/*
+	 * generate FAN_CLOSE_NOWRITE event on a child subdir.
+	 */
+	dirfd = SAFE_OPEN(DIR_NAME, O_RDONLY);
+	if (dirfd >= 0)
+		SAFE_CLOSE(dirfd);
 
-	/* First verify the first group got the MODIFY event */
+	/*
+	 * First verify the first group got the file MODIFY event and got just
+	 * one FAN_CLOSE_NOWRITE event.
+	 */
 	ret = read(fd_notify[0], event_buf, EVENT_BUF_LEN);
 	if (ret < 0) {
 		if (errno == EAGAIN) {
@@ -140,26 +165,32 @@ void test01(void)
 				"reading fanotify events failed");
 		}
 	}
-	if (ret < (int)FAN_EVENT_METADATA_LEN) {
+	if (ret < 2 * (int)FAN_EVENT_METADATA_LEN) {
 		tst_brk(TBROK,
-			"short read when reading fanotify "
-			"events (%d < %d)", ret,
-			(int)EVENT_BUF_LEN);
+			"short read when reading fanotify events (%d < %d)",
+			ret, 2 * (int)FAN_EVENT_METADATA_LEN);
 	}
 	event = (struct fanotify_event_metadata *)event_buf;
-	if (ret > (int)event->event_len) {
-		tst_res(TFAIL, "first group got more than one "
-			"event (%d > %d)", ret,
-			event->event_len);
-	} else {
-		verify_event(0, event);
+	verify_event(0, event, FAN_MODIFY);
+	verify_event(0, event + 1, FAN_CLOSE_NOWRITE);
+	if (ret > 2 * (int)FAN_EVENT_METADATA_LEN) {
+		tst_res(TFAIL,
+			"first group got more than two events (%d > %d)",
+			ret, 2 * (int)FAN_EVENT_METADATA_LEN);
+	}
+	/* Close all file descriptors of read events */
+	for (ev = event; ret >= (int)FAN_EVENT_METADATA_LEN; ev++) {
+		if (ev->fd != FAN_NOFD)
+			SAFE_CLOSE(ev->fd);
+		ret -= (int)FAN_EVENT_METADATA_LEN;
 	}
-	if (event->fd != FAN_NOFD)
-		SAFE_CLOSE(event->fd);
 
-	/* Then verify the rest of the groups did not get the MODIFY event */
+	/*
+	 * Then verify the rest of the groups did not get the MODIFY event and
+	 * did not get the FAN_CLOSE_NOWRITE event on subdir.
+	 */
 	for (i = 1; i < NUM_GROUPS; i++) {
-		ret = read(fd_notify[i], event_buf, EVENT_BUF_LEN);
+		ret = read(fd_notify[i], event_buf, FAN_EVENT_METADATA_LEN);
 		if (ret > 0) {
 			tst_res(TFAIL, "group %d got event", i);
 			if (event->fd != FAN_NOFD)
@@ -187,6 +218,7 @@ static void setup(void)
 	SAFE_MOUNT(MOUNT_NAME, MOUNT_NAME, "none", MS_BIND, NULL);
 	mount_created = 1;
 	SAFE_CHDIR(MOUNT_NAME);
+	SAFE_MKDIR(DIR_NAME, 0755);
 
 	sprintf(fname, "tfile_%d", getpid());
 	SAFE_FILE_PRINTF(fname, "1");
-- 
2.17.1

