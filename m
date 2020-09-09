From: Amir Goldstein <amir73il@gmail.com>
Date: Wed,  9 Sep 2020 20:57:05 +0300
Subject: [LTP] [PATCH 08/10] syscalls/fanotify09: Add test case with parent
 and subdir marks
In-Reply-To: <20200909175707.10670-1-amir73il@gmail.com>
References: <20200909175707.10670-1-amir73il@gmail.com>
Message-ID: <20200909175707.10670-9-amir73il@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This test checks handling of events with both parent and mount marks.
Generalize the test, and add test case of both parent and subdir marks.

Verified that existing test cases still fail on old kernels without the
relevant fix commits.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 .../kernel/syscalls/fanotify/fanotify09.c     | 57 ++++++++++++-------
 1 file changed, 35 insertions(+), 22 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify09.c b/testcases/kernel/syscalls/fanotify/fanotify09.c
index 4336f498f..83210bc1c 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify09.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify09.c
@@ -6,17 +6,17 @@
  *
  * DESCRIPTION
  *     Check that fanotify handles events on children correctly when
- *     both inode and mountpoint marks exist.
+ *     both parent and subdir or mountpoint marks exist.
  *
  * This is a regression test for commit 54a307ba8d3c:
  *
  *      fanotify: fix logic of events on child
  *
- * Test case #2 is a regression test for commit b469e7e47c8a:
+ * Test case #1 is a regression test for commit b469e7e47c8a:
  *
  *      fanotify: fix handling of events on child sub-directory
  *
- * Test case #3 is a regression test for commit 55bf882c7f13:
+ * Test case #2 is a regression test for commit 55bf882c7f13:
  *
  *      fanotify: fix merging marks masks with FAN_ONDIR
  */
@@ -60,33 +60,45 @@ static int mount_created;
 
 static struct tcase {
 	const char *tname;
+	struct fanotify_mark_type mark;
 	unsigned int ondir;
 	const char *testdir;
 	int nevents;
 } tcases[] = {
 	{
-		"Events on children with both inode and mount marks",
+		"Events on non-dir child with both parent and mount marks",
+		INIT_FANOTIFY_MARK_TYPE(MOUNT),
 		0,
 		DIR_NAME,
 		1,
 	},
 	{
-		"Events on children and subdirs with both inode and mount marks",
+		"Events on non-dir child and subdir with both parent and mount marks",
+		INIT_FANOTIFY_MARK_TYPE(MOUNT),
 		FAN_ONDIR,
 		DIR_NAME,
 		2,
 	},
 	{
-		"Events on files and dirs with both inode and mount marks",
+		"Events on non-dir child and parent with both parent and mount marks",
+		INIT_FANOTIFY_MARK_TYPE(MOUNT),
 		FAN_ONDIR,
 		".",
 		2,
 	},
+	{
+		"Events on non-dir child and subdir with both parent and subdir marks",
+		INIT_FANOTIFY_MARK_TYPE(INODE),
+		FAN_ONDIR,
+		DIR_NAME,
+		2,
+	},
 };
 
-static void create_fanotify_groups(unsigned int ondir)
+static void create_fanotify_groups(struct tcase *tc)
 {
-	unsigned int i, onchild;
+	struct fanotify_mark_type *mark = &tc->mark;
+	unsigned int i, onchild, ondir = tc->ondir;
 	int ret;
 
 	for (i = 0; i < NUM_GROUPS; i++) {
@@ -94,22 +106,25 @@ static void create_fanotify_groups(unsigned int ondir)
 						  FAN_NONBLOCK,
 						  O_RDONLY);
 
-		/* Add mount mark for each group without MODIFY event */
+		/*
+		 * Add subdir or mount mark for each group with CLOSE event,
+		 * but only the first group requests events on dir.
+		 */
 		onchild = (i == 0) ? FAN_EVENT_ON_CHILD | ondir : 0;
 		ret = fanotify_mark(fd_notify[i],
-				    FAN_MARK_ADD | FAN_MARK_MOUNT,
+				    FAN_MARK_ADD | mark->flag,
 				    FAN_CLOSE_NOWRITE | onchild,
-				    AT_FDCWD, ".");
+				    AT_FDCWD, tc->testdir);
 		if (ret < 0) {
 			tst_brk(TBROK | TERRNO,
-				"fanotify_mark(%d, FAN_MARK_ADD | "
-				"FAN_MARK_MOUNT, FAN_MODIFY%s, AT_FDCWD,"
-				" '.') failed", fd_notify[i],
-				ondir ? " | FAN_ONDIR" : "");
+				"fanotify_mark(%d, FAN_MARK_ADD | %s, "
+				"%x, AT_FDCWD, '%s') failed",
+				fd_notify[i], mark->name,
+				FAN_CLOSE_NOWRITE | ondir, tc->testdir);
 		}
 		/*
-		 * Add inode mark on parent for each group with MODIFY
-		 * event, but only one group requests events on child.
+		 * Add inode mark on parent for each group with MODIFY event,
+		 * but only the first group requests events on child.
 		 * The one mark with FAN_EVENT_ON_CHILD is needed for
 		 * setting the DCACHE_FSNOTIFY_PARENT_WATCHED dentry
 		 * flag.
@@ -120,10 +135,8 @@ static void create_fanotify_groups(unsigned int ondir)
 		if (ret < 0) {
 			tst_brk(TBROK | TERRNO,
 				"fanotify_mark(%d, FAN_MARK_ADD, "
-				"FAN_MODIFY%s%s, AT_FDCWD, '.') failed",
-				fd_notify[i],
-				ondir ? " | FAN_ONDIR" : "",
-				onchild ? " | FAN_EVENT_ON_CHILD" : "");
+				"%x, AT_FDCWD, '.') failed",
+				fd_notify[i], FAN_MODIFY | ondir | onchild);
 		}
 	}
 }
@@ -179,7 +192,7 @@ static void test_fanotify(unsigned int n)
 
 	tst_res(TINFO, "Test #%d: %s", n, tc->tname);
 
-	create_fanotify_groups(tc->ondir);
+	create_fanotify_groups(tc);
 
 	/*
 	 * generate MODIFY event and no FAN_CLOSE_NOWRITE event.
-- 
2.17.1

