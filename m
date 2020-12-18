From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 18 Dec 2020 09:06:29 +0200
Subject: [LTP] [PATCH 1/3] syscalls/inotify10: Generalize for more test cases
In-Reply-To: <20201218070631.1182292-1-amir73il@gmail.com>
References: <20201218070631.1182292-1-amir73il@gmail.com>
Message-ID: <20201218070631.1182292-2-amir73il@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Generalize the parent and child watches test to allow adding new
parent and child watch related test cases.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 testcases/kernel/syscalls/inotify/inotify10.c | 81 +++++++++++++------
 1 file changed, 55 insertions(+), 26 deletions(-)

diff --git a/testcases/kernel/syscalls/inotify/inotify10.c b/testcases/kernel/syscalls/inotify/inotify10.c
index 1c43915a8..baa955a0a 100644
--- a/testcases/kernel/syscalls/inotify/inotify10.c
+++ b/testcases/kernel/syscalls/inotify/inotify10.c
@@ -5,7 +5,9 @@
  * Started by Amir Goldstein <amir73il@gmail.com>
  *
  * DESCRIPTION
- *     Check that event is reported to both watching parent and watching child
+ *     Check that event is reported to watching parent and watching child
+ *     based on their interest
+ *
  */
 
 #include "config.h"
@@ -37,48 +39,74 @@ struct event_t {
 #define	TEST_DIR	"test_dir"
 #define	TEST_FILE	"test_file"
 
+static struct tcase {
+	const char *tname;
+	unsigned int parent_mask;
+	unsigned int subdir_mask;
+	unsigned int child_mask;
+} tcases[] = {
+	{
+		"Group with parent and child watches",
+		IN_ATTRIB, IN_ATTRIB, IN_ATTRIB,
+	},
+};
+
 struct event_t event_set[EVENT_MAX];
 
 char event_buf[EVENT_BUF_LEN];
 
 int fd_notify;
 
-static void verify_inotify(void)
+static void verify_inotify(unsigned int n)
 {
+	struct tcase *tc = &tcases[n];
 	int i = 0, test_num = 0, len;
-	int wd_parent, wd_dir, wd_file;
+	int wd_parent = 0, wd_subdir = 0, wd_child = 0;
 	int test_cnt = 0;
 
+	tst_res(TINFO, "Test #%d: %s", n, tc->tname);
+
 	fd_notify = SAFE_MYINOTIFY_INIT();
 
-	/* Set watch on both parent dir and children */
-	wd_parent = SAFE_MYINOTIFY_ADD_WATCH(fd_notify, ".", IN_ATTRIB);
-	wd_dir = SAFE_MYINOTIFY_ADD_WATCH(fd_notify, TEST_DIR, IN_ATTRIB);
-	wd_file = SAFE_MYINOTIFY_ADD_WATCH(fd_notify, TEST_FILE, IN_ATTRIB);
+	/* Setup watches on parent dir and children */
+	if (tc->parent_mask)
+		wd_parent = SAFE_MYINOTIFY_ADD_WATCH(fd_notify, ".", tc->parent_mask);
+	if (tc->subdir_mask)
+		wd_subdir = SAFE_MYINOTIFY_ADD_WATCH(fd_notify, TEST_DIR, tc->subdir_mask);
+	if (tc->child_mask)
+		wd_child = SAFE_MYINOTIFY_ADD_WATCH(fd_notify, TEST_FILE, tc->child_mask);
 
 	/*
-	 * Generate events on file and subdir that should be reported to parent
-	 * dir with name and to children without name.
+	 * Generate IN_ATTRIB events on file and subdir that should be reported to parent
+	 * dir with name and to children without name if they have IN_ATTRIB in their mask.
 	 */
 	SAFE_CHMOD(TEST_DIR, 0755);
 	SAFE_CHMOD(TEST_FILE, 0644);
 
-	event_set[test_cnt].wd = wd_parent;
-	event_set[test_cnt].mask = IN_ATTRIB | IN_ISDIR;
-	strcpy(event_set[test_cnt].name, TEST_DIR);
-	test_cnt++;
-	event_set[test_cnt].wd = wd_dir;
-	event_set[test_cnt].mask = IN_ATTRIB | IN_ISDIR;
-	strcpy(event_set[test_cnt].name, "");
-	test_cnt++;
-	event_set[test_cnt].wd = wd_parent;
-	event_set[test_cnt].mask = IN_ATTRIB;
-	strcpy(event_set[test_cnt].name, TEST_FILE);
-	test_cnt++;
-	event_set[test_cnt].wd = wd_file;
-	event_set[test_cnt].mask = IN_ATTRIB;
-	strcpy(event_set[test_cnt].name, "");
-	test_cnt++;
+	if (wd_parent && (tc->parent_mask & IN_ATTRIB)) {
+		event_set[test_cnt].wd = wd_parent;
+		event_set[test_cnt].mask = tc->parent_mask | IN_ISDIR;
+		strcpy(event_set[test_cnt].name, TEST_DIR);
+		test_cnt++;
+	}
+	if (wd_subdir && (tc->subdir_mask & IN_ATTRIB)) {
+		event_set[test_cnt].wd = wd_subdir;
+		event_set[test_cnt].mask = tc->subdir_mask | IN_ISDIR;
+		strcpy(event_set[test_cnt].name, "");
+		test_cnt++;
+	}
+	if (wd_parent && (tc->parent_mask & IN_ATTRIB)) {
+		event_set[test_cnt].wd = wd_parent;
+		event_set[test_cnt].mask = tc->parent_mask;
+		strcpy(event_set[test_cnt].name, TEST_FILE);
+		test_cnt++;
+	}
+	if (wd_child && (tc->child_mask & IN_ATTRIB)) {
+		event_set[test_cnt].wd = wd_child;
+		event_set[test_cnt].mask = tc->child_mask;
+		strcpy(event_set[test_cnt].name, "");
+		test_cnt++;
+	}
 
 	len = read(fd_notify, event_buf, EVENT_BUF_LEN);
 	if (len == -1)
@@ -141,7 +169,8 @@ static struct tst_test test = {
 	.needs_tmpdir = 1,
 	.setup = setup,
 	.cleanup = cleanup,
-	.test_all = verify_inotify,
+	.test = verify_inotify,
+	.tcnt = ARRAY_SIZE(tcases),
 };
 
 #else
-- 
2.25.1

