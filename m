From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 21 Apr 2020 09:49:59 +0300
Subject: [LTP] [PATCH 1/4] syscalls/fanotify09: Check merging of events on
 directories
In-Reply-To: <20200421065002.12417-1-amir73il@gmail.com>
References: <20200421065002.12417-1-amir73il@gmail.com>
Message-ID: <20200421065002.12417-2-amir73il@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

In a setup of mount mark and directory inode mark the FAN_ONDIR flag
set on one mark should not imply that all events in the other mark mask
are expected on directories as well.

Add a regression test case for commit 55bf882c7f13:
   fanotify: fix merging marks masks with FAN_ONDIR

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 .../kernel/syscalls/fanotify/fanotify09.c     | 46 +++++++++++++------
 1 file changed, 32 insertions(+), 14 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify09.c b/testcases/kernel/syscalls/fanotify/fanotify09.c
index 0f6a9e864..68a4e5081 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify09.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify09.c
@@ -15,6 +15,10 @@
  * Test case #2 is a regression test for commit b469e7e47c8a:
  *
  *      fanotify: fix handling of events on child sub-directory
+ *
+ * Test case #3 is a regression test for commit 55bf882c7f13:
+ *
+ *      fanotify: fix merging marks masks with FAN_ONDIR
  */
 #define _GNU_SOURCE
 #include "config.h"
@@ -57,16 +61,25 @@ static int mount_created;
 static struct tcase {
 	const char *tname;
 	unsigned int ondir;
+	const char *testdir;
 	int nevents;
 } tcases[] = {
 	{
 		"Events on children with both inode and mount marks",
 		0,
+		DIR_NAME,
 		1,
 	},
 	{
 		"Events on children and subdirs with both inode and mount marks",
 		FAN_ONDIR,
+		DIR_NAME,
+		2,
+	},
+	{
+		"Events on files and dirs with both inode and mount marks",
+		FAN_ONDIR,
+		".",
 		2,
 	},
 };
@@ -125,6 +138,20 @@ static void cleanup_fanotify_groups(void)
 	}
 }
 
+static void event_res(int ttype, int group,
+		      struct fanotify_event_metadata *event)
+{
+	int len;
+	sprintf(symlnk, "/proc/self/fd/%d", event->fd);
+	len = readlink(symlnk, fdpath, sizeof(fdpath));
+	if (len < 0)
+		len = 0;
+	fdpath[len] = 0;
+	tst_res(ttype, "group %d got event: mask %llx pid=%u fd=%d path=%s",
+		group, (unsigned long long)event->mask,
+		(unsigned)event->pid, event->fd, fdpath);
+}
+
 static void verify_event(int group, struct fanotify_event_metadata *event,
 			 uint32_t expect)
 {
@@ -139,15 +166,7 @@ static void verify_event(int group, struct fanotify_event_metadata *event,
 			(unsigned long long)event->mask, (unsigned)event->pid,
 			(unsigned)getpid(), event->fd);
 	} else {
-		int len;
-		sprintf(symlnk, "/proc/self/fd/%d", event->fd);
-		len = readlink(symlnk, fdpath, sizeof(fdpath));
-		if (len < 0)
-			len = 0;
-		fdpath[len] = 0;
-		tst_res(TPASS, "group %d got event: mask %llx pid=%u fd=%d path=%s",
-			group, (unsigned long long)event->mask,
-			(unsigned)event->pid, event->fd, fdpath);
+		event_res(TPASS, group, event);
 	}
 }
 
@@ -167,9 +186,9 @@ static void test_fanotify(unsigned int n)
 	 */
 	SAFE_FILE_PRINTF(fname, "1");
 	/*
-	 * generate FAN_CLOSE_NOWRITE event on a child subdir.
+	 * generate FAN_CLOSE_NOWRITE event on a testdir (subdir or ".")
 	 */
-	dirfd = SAFE_OPEN(DIR_NAME, O_RDONLY);
+	dirfd = SAFE_OPEN(tc->testdir, O_RDONLY);
 	if (dirfd >= 0)
 		SAFE_CLOSE(dirfd);
 
@@ -210,13 +229,12 @@ static void test_fanotify(unsigned int n)
 
 	/*
 	 * Then verify the rest of the groups did not get the MODIFY event and
-	 * did not get the FAN_CLOSE_NOWRITE event on subdir.
+	 * did not get the FAN_CLOSE_NOWRITE event on testdir.
 	 */
 	for (i = 1; i < NUM_GROUPS; i++) {
 		ret = read(fd_notify[i], event_buf, FAN_EVENT_METADATA_LEN);
 		if (ret > 0) {
-			tst_res(TFAIL, "group %d got event", i);
-			verify_event(i, event, FAN_CLOSE_NOWRITE);
+			event_res(TFAIL, i, event);
 			if (event->fd != FAN_NOFD)
 				SAFE_CLOSE(event->fd);
 			continue;
-- 
2.17.1

