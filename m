From: Amir Goldstein <amir73il@gmail.com>
Date: Wed,  9 Sep 2020 20:57:07 +0300
Subject: [LTP] [PATCH 10/10] syscalls/fanotify10: Add test cases for merge
 with ignored mask on directory
In-Reply-To: <20200909175707.10670-1-amir73il@gmail.com>
References: <20200909175707.10670-1-amir73il@gmail.com>
Message-ID: <20200909175707.10670-11-amir73il@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Pre kernel v5.9, a child mark with ignored mask would not prevent the
delivery of events to a watching parent of that child.

This was fixed by kernel commit eca4784cbb18 ("fsnotify: send event to
parent and child with single callback").

We add test cases for combination of mark of a directory with ignored
mask either watching children or not.

Verified that existing test cases still fail on old kernels without the
relevant fix commits.

In current kernel, there is a limitation that requires setting the event
also in the parent's mask for ignore mask to be correctly merged with
other marks. This is a temporary workaround that could be removed in
the future when the correct behavior could be tested.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 .../kernel/syscalls/fanotify/fanotify10.c     | 109 ++++++++++++++++--
 1 file changed, 99 insertions(+), 10 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify10.c b/testcases/kernel/syscalls/fanotify/fanotify10.c
index 9ebb6d68f..17d2f7578 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify10.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify10.c
@@ -19,6 +19,10 @@
  * Test case #16 is a regression test for commit:
  *
  *     2f02fd3fa13e fanotify: fix ignore mask logic for events on child...
+ *
+ * Test cases #17-#23 are regression tests for commit:
+ *
+ *     eca4784cbb18 fsnotify: send event to parent and child with single...
  */
 #define _GNU_SOURCE
 #include "config.h"
@@ -97,6 +101,7 @@ static struct tcase {
 	int mark_type;
 	const char *ignore_path;
 	int ignore_mark_type;
+	unsigned int ignored_onchild;
 	const char *event_path;
 	unsigned long long expected_mask_with_ignore;
 	unsigned long long expected_mask_without_ignore;
@@ -105,24 +110,28 @@ static struct tcase {
 		"ignore mount events created on a specific file",
 		MOUNT_PATH, FANOTIFY_MOUNT,
 		FILE_MNT2, FANOTIFY_INODE,
+		0,
 		FILE_PATH, 0, FAN_OPEN
 	},
 	{
 		"ignore exec mount events created on a specific file",
 		MOUNT_PATH, FANOTIFY_MOUNT,
 		FILE_EXEC_PATH2, FANOTIFY_INODE,
+		0,
 		FILE_EXEC_PATH, FAN_OPEN_EXEC, FAN_OPEN | FAN_OPEN_EXEC
 	},
 	{
 		"don't ignore mount events created on another file",
 		MOUNT_PATH, FANOTIFY_MOUNT,
 		FILE_PATH, FANOTIFY_INODE,
+		0,
 		FILE2_PATH, FAN_OPEN, FAN_OPEN
 	},
 	{
 		"don't ignore exec mount events created on another file",
 		MOUNT_PATH, FANOTIFY_MOUNT,
 		FILE_EXEC_PATH, FANOTIFY_INODE,
+		0,
 		FILE2_EXEC_PATH, FAN_OPEN | FAN_OPEN_EXEC,
 		FAN_OPEN | FAN_OPEN_EXEC
 	},
@@ -130,24 +139,28 @@ static struct tcase {
 		"ignore inode events created on a specific mount point",
 		FILE_PATH, FANOTIFY_INODE,
 		MNT2_PATH, FANOTIFY_MOUNT,
+		0,
 		FILE_MNT2, 0, FAN_OPEN
 	},
 	{
 		"ignore exec inode events created on a specific mount point",
 		FILE_EXEC_PATH, FANOTIFY_INODE,
 		MNT2_PATH, FANOTIFY_MOUNT,
+		0,
 		FILE_EXEC_PATH2, FAN_OPEN_EXEC, FAN_OPEN | FAN_OPEN_EXEC
 	},
 	{
 		"don't ignore inode events created on another mount point",
 		FILE_MNT2, FANOTIFY_INODE,
 		MNT2_PATH, FANOTIFY_MOUNT,
+		0,
 		FILE_PATH, FAN_OPEN, FAN_OPEN
 	},
 	{
 		"don't ignore exec inode events created on another mount point",
 		FILE_EXEC_PATH2, FANOTIFY_INODE,
 		MNT2_PATH, FANOTIFY_MOUNT,
+		0,
 		FILE_EXEC_PATH, FAN_OPEN | FAN_OPEN_EXEC,
 		FAN_OPEN | FAN_OPEN_EXEC
 	},
@@ -155,24 +168,28 @@ static struct tcase {
 		"ignore fs events created on a specific file",
 		MOUNT_PATH, FANOTIFY_FILESYSTEM,
 		FILE_PATH, FANOTIFY_INODE,
+		0,
 		FILE_PATH, 0, FAN_OPEN
 	},
 	{
 		"ignore exec fs events created on a specific file",
 		MOUNT_PATH, FANOTIFY_FILESYSTEM,
 		FILE_EXEC_PATH, FANOTIFY_INODE,
+		0,
 		FILE_EXEC_PATH, FAN_OPEN_EXEC, FAN_OPEN | FAN_OPEN_EXEC
 	},
 	{
 		"don't ignore mount events created on another file",
 		MOUNT_PATH, FANOTIFY_FILESYSTEM,
 		FILE_PATH, FANOTIFY_INODE,
+		0,
 		FILE2_PATH, FAN_OPEN, FAN_OPEN
 	},
 	{
 		"don't ignore exec mount events created on another file",
 		MOUNT_PATH, FANOTIFY_FILESYSTEM,
 		FILE_EXEC_PATH, FANOTIFY_INODE,
+		0,
 		FILE2_EXEC_PATH, FAN_OPEN | FAN_OPEN_EXEC,
 		FAN_OPEN | FAN_OPEN_EXEC
 	},
@@ -180,24 +197,28 @@ static struct tcase {
 		"ignore fs events created on a specific mount point",
 		MOUNT_PATH, FANOTIFY_FILESYSTEM,
 		MNT2_PATH, FANOTIFY_MOUNT,
+		0,
 		FILE_MNT2, 0, FAN_OPEN
 	},
 	{
 		"ignore exec fs events created on a specific mount point",
 		MOUNT_PATH, FANOTIFY_FILESYSTEM,
 		MNT2_PATH, FANOTIFY_MOUNT,
+		0,
 		FILE_EXEC_PATH2, FAN_OPEN_EXEC, FAN_OPEN | FAN_OPEN_EXEC
 	},
 	{
 		"don't ignore fs events created on another mount point",
 		MOUNT_PATH, FANOTIFY_FILESYSTEM,
 		MNT2_PATH, FANOTIFY_MOUNT,
+		0,
 		FILE_PATH, FAN_OPEN, FAN_OPEN
 	},
 	{
 		"don't ignore exec fs events created on another mount point",
 		MOUNT_PATH, FANOTIFY_FILESYSTEM,
 		MNT2_PATH, FANOTIFY_MOUNT,
+		0,
 		FILE_EXEC_PATH, FAN_OPEN | FAN_OPEN_EXEC,
 		FAN_OPEN | FAN_OPEN_EXEC
 	},
@@ -205,14 +226,65 @@ static struct tcase {
 		"ignore child exec events created on a specific mount point",
 		MOUNT_PATH, FANOTIFY_INODE,
 		MOUNT_PATH, FANOTIFY_MOUNT,
+		0,
 		FILE_EXEC_PATH, FAN_OPEN_EXEC, FAN_OPEN | FAN_OPEN_EXEC
 	},
+	{
+		"ignore events on children of directory created on a specific file",
+		MNT2_PATH, FANOTIFY_INODE,
+		FILE_PATH, FANOTIFY_INODE,
+		FAN_EVENT_ON_CHILD,
+		FILE_PATH, 0, FAN_OPEN
+	},
+	{
+		"ignore events on file created inside a parent watching children",
+		FILE_PATH, FANOTIFY_INODE,
+		MNT2_PATH, FANOTIFY_INODE,
+		FAN_EVENT_ON_CHILD,
+		FILE_PATH, 0, FAN_OPEN
+	},
+	{
+		"don't ignore events on file created inside a parent not watching children",
+		FILE_PATH, FANOTIFY_INODE,
+		MNT2_PATH, FANOTIFY_INODE,
+		0,
+		FILE_PATH, FAN_OPEN, FAN_OPEN
+	},
+	{
+		"ignore mount events created inside a parent watching children",
+		FILE_PATH, FANOTIFY_MOUNT,
+		MNT2_PATH, FANOTIFY_INODE,
+		FAN_EVENT_ON_CHILD,
+		FILE_PATH, 0, FAN_OPEN
+	},
+	{
+		"don't ignore mount events created inside a parent not watching children",
+		FILE_PATH, FANOTIFY_MOUNT,
+		MNT2_PATH, FANOTIFY_INODE,
+		0,
+		FILE_PATH, FAN_OPEN, FAN_OPEN
+	},
+	{
+		"ignore fs events created inside a parent watching children",
+		FILE_PATH, FANOTIFY_FILESYSTEM,
+		MNT2_PATH, FANOTIFY_INODE,
+		FAN_EVENT_ON_CHILD,
+		FILE_PATH, 0, FAN_OPEN
+	},
+	{
+		"don't ignore fs events created inside a parent not watching children",
+		FILE_PATH, FANOTIFY_FILESYSTEM,
+		MNT2_PATH, FANOTIFY_INODE,
+		0,
+		FILE_PATH, FAN_OPEN, FAN_OPEN
+	},
 };
 
 static int create_fanotify_groups(unsigned int n)
 {
 	struct tcase *tc = &tcases[n];
 	struct fanotify_mark_type *mark, *ignore_mark;
+	unsigned int mark_ignored, mask;
 	unsigned int p, i;
 	int ret;
 
@@ -272,20 +344,36 @@ static int create_fanotify_groups(unsigned int n)
 			/* Add ignore mark for groups with higher priority */
 			if (p == 0)
 				continue;
+
+			mask = FAN_OPEN;
+			mark_ignored = FAN_MARK_IGNORED_MASK |
+					FAN_MARK_IGNORED_SURV_MODIFY;
+add_mark:
 			ret = fanotify_mark(fd_notify[p][i],
-					    FAN_MARK_ADD | ignore_mark->flag |
-					    FAN_MARK_IGNORED_MASK |
-					    FAN_MARK_IGNORED_SURV_MODIFY,
-					    FAN_OPEN, AT_FDCWD,
-					    tc->ignore_path);
+					    FAN_MARK_ADD | ignore_mark->flag | mark_ignored,
+					    mask, AT_FDCWD, tc->ignore_path);
 			if (ret < 0) {
 				tst_brk(TBROK | TERRNO,
-					"fanotify_mark(%d, FAN_MARK_ADD | %s | "
-					"FAN_MARK_IGNORED_MASK | "
-					"FAN_MARK_IGNORED_SURV_MODIFY, "
-					"FAN_OPEN, AT_FDCWD, %s) failed",
+					"fanotify_mark(%d, FAN_MARK_ADD | %s | %s, "
+					"%x, AT_FDCWD, %s) failed",
 					fd_notify[p][i], ignore_mark->name,
-					tc->ignore_path);
+					mark_ignored ? "FAN_MARK_IGNORED_MASK | "
+					"FAN_MARK_IGNORED_SURV_MODIFY" : "",
+					mask, tc->ignore_path);
+			}
+
+			/*
+			 * If ignored mask is on a parent watching children,
+			 * also set the flag FAN_EVENT_ON_CHILD in mark mask.
+			 * This is needed to indicate that parent ignored mask
+			 * should be applied to events on children.
+			 */
+			if (tc->ignored_onchild && mark_ignored) {
+				mask = tc->ignored_onchild;
+				/* XXX: temporary hack may be removed in the future */
+				mask |= FAN_OPEN;
+				mark_ignored = 0;
+				goto add_mark;
 			}
 		}
 	}
@@ -478,6 +566,7 @@ static struct tst_test test = {
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "9bdda4e9cf2d"},
 		{"linux-git", "2f02fd3fa13e"},
+		{"linux-git", "eca4784cbb18"},
 		{}
 	}
 };
-- 
2.17.1

