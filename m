From: Amir Goldstein <amir73il@gmail.com>
Date: Fri,  9 Nov 2018 13:15:20 +0200
Subject: [LTP] [PATCH v2] fanotify09: check merging of events on child subdir
Message-ID: <20181109111520.27473-1-amir73il@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

In a setup of mount mark and directory inode mark on children
mount mark should not be getting double events "on child" and "on self"
for the same action.

Add a regression test case for b469e7e47c8a ("fanotify: fix handling of
events on child sub-directory").

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Cyril,

FYI, kernel commit b469e7e47c8a ("fanotify: fix handling of events on child
sub-directory") has been queued by Jan.

This patch adds a test case to fanotify09 which exercises another corner
case of merging inode and mount marks.

The new test case fails on current master and passes on Jan's for_next
branch. The existing test case passes on both.

Thanks,
Amir.

Changes since v1:
- Add test case instead of changing existing test
- Record expected upsteam commit id

 .../kernel/syscalls/fanotify/fanotify09.c     | 124 +++++++++++++-----
 1 file changed, 90 insertions(+), 34 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify09.c b/testcases/kernel/syscalls/fanotify/fanotify09.c
index 511ccc0e0..1814ae6b0 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify09.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify09.c
@@ -11,6 +11,10 @@
  * This is a regression test for commit 54a307ba8d3c:
  *
  *      fanotify: fix logic of events on child
+ *
+ * Test case #2 is a regression test for commit b469e7e47c8a:
+ *
+ *      fanotify: fix handling of events on child sub-directory
  */
 #define _GNU_SOURCE
 #include "config.h"
@@ -39,14 +43,34 @@
 
 #define BUF_SIZE 256
 static char fname[BUF_SIZE];
+static char symlnk[BUF_SIZE];
+static char fdpath[BUF_SIZE];
 static int fd_notify[NUM_GROUPS];
 
 static char event_buf[EVENT_BUF_LEN];
 
 #define MOUNT_NAME "mntpoint"
+#define DIR_NAME "testdir"
 static int mount_created;
 
-static void create_fanotify_groups(void)
+static struct tcase {
+	const char *tname;
+	unsigned int ondir;
+	int nevents;
+} tcases[] = {
+	{
+		"Events on children with both inode and mount marks",
+		0,
+		1,
+	},
+	{
+		"Events on children and subdirs with both inode and mount marks",
+		FAN_ONDIR,
+		2,
+	},
+};
+
+static void create_fanotify_groups(unsigned int ondir)
 {
 	unsigned int i, onchild;
 	int ret;
@@ -57,15 +81,17 @@ static void create_fanotify_groups(void)
 						  O_RDONLY);
 
 		/* Add mount mark for each group without MODIFY event */
+		onchild = (i == 0) ? FAN_EVENT_ON_CHILD | ondir : 0;
 		ret = fanotify_mark(fd_notify[i],
 				    FAN_MARK_ADD | FAN_MARK_MOUNT,
-				    FAN_CLOSE_NOWRITE,
+				    FAN_CLOSE_NOWRITE | onchild,
 				    AT_FDCWD, ".");
 		if (ret < 0) {
 			tst_brk(TBROK | TERRNO,
 				"fanotify_mark(%d, FAN_MARK_ADD | "
-				"FAN_MARK_MOUNT, FAN_MODIFY, AT_FDCWD,"
-				" '.') failed", fd_notify[i]);
+				"FAN_MARK_MOUNT, FAN_MODIFY%s, AT_FDCWD,"
+				" '.') failed", fd_notify[i],
+				ondir ? " | FAN_ONDIR" : "");
 		}
 		/*
 		 * Add inode mark on parent for each group with MODIFY
@@ -74,15 +100,15 @@ static void create_fanotify_groups(void)
 		 * setting the DCACHE_FSNOTIFY_PARENT_WATCHED dentry
 		 * flag.
 		 */
-		onchild = (i == 0) ? FAN_EVENT_ON_CHILD : 0;
-		ret = fanotify_mark(fd_notify[i],
-				    FAN_MARK_ADD,
-				    FAN_MODIFY | onchild, AT_FDCWD, ".");
+		ret = fanotify_mark(fd_notify[i], FAN_MARK_ADD,
+				    FAN_MODIFY | ondir | onchild,
+				    AT_FDCWD, ".");
 		if (ret < 0) {
 			tst_brk(TBROK | TERRNO,
 				"fanotify_mark(%d, FAN_MARK_ADD, "
-				"FAN_MODIFY%s, AT_FDCWD, '.') failed",
+				"FAN_MODIFY%s%s, AT_FDCWD, '.') failed",
 				fd_notify[i],
+				ondir ? " | FAN_ONDIR" : "",
 				onchild ? " | FAN_EVENT_ON_CHILD" : "");
 		}
 	}
@@ -98,12 +124,13 @@ static void cleanup_fanotify_groups(void)
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
@@ -111,26 +138,44 @@ static void verify_event(int group, struct fanotify_event_metadata *event)
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
 
-void test01(void)
+static void test_fanotify(unsigned int n)
 {
-	int ret;
+	int ret, dirfd;
 	unsigned int i;
-	struct fanotify_event_metadata *event;
+	struct fanotify_event_metadata *event, *ev;
+	struct tcase *tc = &tcases[n];
+
+	tst_res(TINFO, "Test #%d: %s", n, tc->tname);
 
-	create_fanotify_groups();
+	create_fanotify_groups(tc->ondir);
 
 	/*
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
@@ -140,28 +185,37 @@ void test01(void)
 				"reading fanotify events failed");
 		}
 	}
-	if (ret < (int)FAN_EVENT_METADATA_LEN) {
+	if (ret < tc->nevents * (int)FAN_EVENT_METADATA_LEN) {
 		tst_brk(TBROK,
-			"short read when reading fanotify "
-			"events (%d < %d)", ret,
-			(int)EVENT_BUF_LEN);
+			"short read when reading fanotify events (%d < %d)",
+			ret, tc->nevents * (int)FAN_EVENT_METADATA_LEN);
 	}
 	event = (struct fanotify_event_metadata *)event_buf;
-	if (ret > (int)event->event_len) {
-		tst_res(TFAIL, "first group got more than one "
-			"event (%d > %d)", ret,
-			event->event_len);
-	} else {
-		verify_event(0, event);
+	verify_event(0, event, FAN_MODIFY);
+	if (tc->ondir)
+		verify_event(0, event + 1, FAN_CLOSE_NOWRITE);
+	if (ret > tc->nevents * (int)FAN_EVENT_METADATA_LEN) {
+		tst_res(TFAIL,
+			"first group got more than %d events (%d > %d)",
+			tc->nevents, ret,
+			tc->nevents * (int)FAN_EVENT_METADATA_LEN);
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
+			verify_event(0, event, FAN_CLOSE_NOWRITE);
 			if (event->fd != FAN_NOFD)
 				SAFE_CLOSE(event->fd);
 			continue;
@@ -187,6 +241,7 @@ static void setup(void)
 	SAFE_MOUNT(MOUNT_NAME, MOUNT_NAME, "none", MS_BIND, NULL);
 	mount_created = 1;
 	SAFE_CHDIR(MOUNT_NAME);
+	SAFE_MKDIR(DIR_NAME, 0755);
 
 	sprintf(fname, "tfile_%d", getpid());
 	SAFE_FILE_PRINTF(fname, "1");
@@ -203,7 +258,8 @@ static void cleanup(void)
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

