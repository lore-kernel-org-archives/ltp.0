From: Amir Goldstein <amir73il@gmail.com>
Date: Mon,  8 Jun 2020 09:43:29 +0300
Subject: [LTP] [PATCH] syscalls/fanotify10: Add a test case for ignore mask
 and events on child
Message-ID: <20200608064329.26243-1-amir73il@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add a regression test case for kernel commit 2f02fd3fa13e:

    fanotify: fix ignore mask logic for events on child and on dir

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 .../kernel/syscalls/fanotify/fanotify10.c     | 23 ++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify10.c b/testcases/kernel/syscalls/fanotify/fanotify10.c
index ef0807761..3cdb25a73 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify10.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify10.c
@@ -15,6 +15,10 @@
  * This is a regression test for commit:
  *
  *     9bdda4e9cf2d fsnotify: fix ignore mask logic in fsnotify()
+ *
+ * Test case #16 is a regression test for commit:
+ *
+ *     2f02fd3fa13e fanotify: fix ignore mask logic for events on child...
  */
 #define _GNU_SOURCE
 #include "config.h"
@@ -193,7 +197,13 @@ static struct tcase {
 		MNT2_PATH, FANOTIFY_MOUNT,
 		FILE_EXEC_PATH, FAN_OPEN | FAN_OPEN_EXEC,
 		FAN_OPEN | FAN_OPEN_EXEC
-	}
+	},
+	{
+		"ignore child exec events created on a specific mount point",
+		MOUNT_PATH, FANOTIFY_INODE,
+		MOUNT_PATH, FANOTIFY_MOUNT,
+		FILE_EXEC_PATH, FAN_OPEN_EXEC, FAN_OPEN | FAN_OPEN_EXEC
+	},
 };
 
 static int create_fanotify_groups(unsigned int n)
@@ -212,10 +222,16 @@ static int create_fanotify_groups(unsigned int n)
 							     FAN_NONBLOCK,
 							     O_RDONLY);
 
-			/* Add mark for each group */
+			/*
+			 * Add mark for each group.
+			 *
+			 * FAN_EVENT_ON_CHILD has no effect on filesystem/mount
+			 * or inode mark on non-directory.
+			 */
 			ret = fanotify_mark(fd_notify[p][i],
 					    FAN_MARK_ADD | mark->flag,
-					    tc->expected_mask_without_ignore,
+					    tc->expected_mask_without_ignore |
+					    FAN_EVENT_ON_CHILD,
 					    AT_FDCWD, tc->mark_path);
 			if (ret < 0) {
 				if (errno == EINVAL &&
@@ -445,6 +461,7 @@ static struct tst_test test = {
 	.resource_files = resource_files,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "9bdda4e9cf2d"},
+		{"linux-git", "2f02fd3fa13e"},
 		{}
 	}
 };
-- 
2.17.1

