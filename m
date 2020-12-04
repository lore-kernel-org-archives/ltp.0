From: Amir Goldstein <amir73il@gmail.com>
Date: Fri,  4 Dec 2020 11:59:29 +0200
Subject: [LTP] [PATCH 4/5] syscalls/fanotify09: Add test case with two
 non-dir children
In-Reply-To: <20201204095930.866421-1-amir73il@gmail.com>
References: <20201204095930.866421-1-amir73il@gmail.com>
Message-ID: <20201204095930.866421-5-amir73il@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The existing test cases generate FAN_MODIFY event on a non-dir child
and FAN_CLOSE_NOWRITE event the parent or sibling subdir.

Add a test case that generates FAN_CLOSE_NOWRITE on a sibling non-dir
child.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 .../kernel/syscalls/fanotify/fanotify09.c     | 38 ++++++++++++++-----
 1 file changed, 28 insertions(+), 10 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify09.c b/testcases/kernel/syscalls/fanotify/fanotify09.c
index 7bb901cf3..0f1923981 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify09.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify09.c
@@ -55,13 +55,14 @@ static char event_buf[EVENT_BUF_LEN];
 
 #define MOUNT_NAME "mntpoint"
 #define DIR_NAME "testdir"
+#define FILE2_NAME "testfile"
 static int mount_created;
 
 static struct tcase {
 	const char *tname;
 	struct fanotify_mark_type mark;
 	unsigned int ondir;
-	const char *testdir;
+	const char *close_nowrite;
 	int nevents;
 } tcases[] = {
 	{
@@ -92,6 +93,13 @@ static struct tcase {
 		DIR_NAME,
 		2,
 	},
+	{
+		"Events on non-dir children with both parent and mount marks",
+		INIT_FANOTIFY_MARK_TYPE(MOUNT),
+		0,
+		FILE2_NAME,
+		2,
+	},
 };
 
 static void create_fanotify_groups(struct tcase *tc)
@@ -112,7 +120,7 @@ static void create_fanotify_groups(struct tcase *tc)
 		SAFE_FANOTIFY_MARK(fd_notify[i],
 				    FAN_MARK_ADD | mark->flag,
 				    FAN_CLOSE_NOWRITE | onchild,
-				    AT_FDCWD, tc->testdir);
+				    AT_FDCWD, tc->close_nowrite);
 
 		/*
 		 * Add inode mark on parent for each group with MODIFY event,
@@ -216,9 +224,9 @@ static void test_fanotify(unsigned int n)
 	 */
 	SAFE_FILE_PRINTF(fname, "1");
 	/*
-	 * generate FAN_CLOSE_NOWRITE event on a testdir (subdir or ".")
+	 * generate FAN_CLOSE_NOWRITE event on a child, subdir or "."
 	 */
-	dirfd = SAFE_OPEN(tc->testdir, O_RDONLY);
+	dirfd = SAFE_OPEN(tc->close_nowrite, O_RDONLY);
 	if (dirfd >= 0)
 		SAFE_CLOSE(dirfd);
 
@@ -243,7 +251,7 @@ static void test_fanotify(unsigned int n)
 	event = (struct fanotify_event_metadata *)event_buf;
 	verify_event(0, event, FAN_MODIFY, "");
 	event = FAN_EVENT_NEXT(event, ret);
-	if (tc->ondir) {
+	if (tc->nevents > 1) {
 		verify_event(0, event, FAN_CLOSE_NOWRITE, "");
 		event = FAN_EVENT_NEXT(event, ret);
 	}
@@ -260,14 +268,23 @@ static void test_fanotify(unsigned int n)
 
 	/*
 	 * Then verify the rest of the groups did not get the MODIFY event and
-	 * did not get the FAN_CLOSE_NOWRITE event on testdir.
+	 * got the FAN_CLOSE_NOWRITE event only on a non-directory.
 	 */
 	for (i = 1; i < NUM_GROUPS; i++) {
-		ret = read(fd_notify[i], event_buf, FAN_EVENT_METADATA_LEN);
+		ret = read(fd_notify[i], event_buf, EVENT_BUF_LEN);
 		if (ret > 0) {
-			event_res(TFAIL, i, event, "");
-			if (event->fd != FAN_NOFD)
-				SAFE_CLOSE(event->fd);
+			uint32_t expect = 0;
+
+			if (tc->nevents > 1 && !tc->ondir)
+				expect = FAN_CLOSE_NOWRITE;
+
+			event = (struct fanotify_event_metadata *)event_buf;
+			verify_event(i, event, expect, "");
+
+			for (; FAN_EVENT_OK(event, ret); FAN_EVENT_NEXT(event, ret)) {
+				if (event->fd != FAN_NOFD)
+					SAFE_CLOSE(event->fd);
+			}
 			continue;
 		}
 
@@ -295,6 +312,7 @@ static void setup(void)
 
 	sprintf(fname, "tfile_%d", getpid());
 	SAFE_FILE_PRINTF(fname, "1");
+	SAFE_FILE_PRINTF(FILE2_NAME, "1");
 }
 
 static void cleanup(void)
-- 
2.25.1

