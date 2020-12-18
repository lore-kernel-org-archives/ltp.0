From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 18 Dec 2020 09:06:30 +0200
Subject: [LTP] [PATCH 2/3] syscalls/inotify10: Add test cases with two groups
In-Reply-To: <20201218070631.1182292-1-amir73il@gmail.com>
References: <20201218070631.1182292-1-amir73il@gmail.com>
Message-ID: <20201218070631.1182292-3-amir73il@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 testcases/kernel/syscalls/inotify/inotify10.c | 30 ++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/inotify/inotify10.c b/testcases/kernel/syscalls/inotify/inotify10.c
index baa955a0a..17aafc773 100644
--- a/testcases/kernel/syscalls/inotify/inotify10.c
+++ b/testcases/kernel/syscalls/inotify/inotify10.c
@@ -44,10 +44,24 @@ static struct tcase {
 	unsigned int parent_mask;
 	unsigned int subdir_mask;
 	unsigned int child_mask;
+	unsigned int parent_mask_other;
+	unsigned int subdir_mask_other;
+	unsigned int child_mask_other;
 } tcases[] = {
 	{
 		"Group with parent and child watches",
 		IN_ATTRIB, IN_ATTRIB, IN_ATTRIB,
+		0, 0, 0,
+	},
+	{
+		"Group with child watches and other group with parent watch",
+		0, IN_ATTRIB, IN_ATTRIB,
+		IN_ATTRIB, 0, 0,
+	},
+	{
+		"Group with parent watch and other group with child watches",
+		IN_ATTRIB, 0, 0,
+		0, IN_ATTRIB, IN_ATTRIB,
 	},
 };
 
@@ -55,7 +69,7 @@ struct event_t event_set[EVENT_MAX];
 
 char event_buf[EVENT_BUF_LEN];
 
-int fd_notify;
+int fd_notify, fd_notify_other;
 
 static void verify_inotify(unsigned int n)
 {
@@ -67,6 +81,7 @@ static void verify_inotify(unsigned int n)
 	tst_res(TINFO, "Test #%d: %s", n, tc->tname);
 
 	fd_notify = SAFE_MYINOTIFY_INIT();
+	fd_notify_other = SAFE_MYINOTIFY_INIT();
 
 	/* Setup watches on parent dir and children */
 	if (tc->parent_mask)
@@ -75,6 +90,16 @@ static void verify_inotify(unsigned int n)
 		wd_subdir = SAFE_MYINOTIFY_ADD_WATCH(fd_notify, TEST_DIR, tc->subdir_mask);
 	if (tc->child_mask)
 		wd_child = SAFE_MYINOTIFY_ADD_WATCH(fd_notify, TEST_FILE, tc->child_mask);
+	/*
+	 * Setup watches on "other" group to verify no intereferecne with our group.
+	 * We do not check events reported to the "other" group.
+	 */
+	if (tc->parent_mask_other)
+		SAFE_MYINOTIFY_ADD_WATCH(fd_notify_other, ".", tc->parent_mask_other);
+	if (tc->subdir_mask_other)
+		SAFE_MYINOTIFY_ADD_WATCH(fd_notify_other, TEST_DIR, tc->subdir_mask_other);
+	if (tc->child_mask_other)
+		SAFE_MYINOTIFY_ADD_WATCH(fd_notify_other, TEST_FILE, tc->child_mask_other);
 
 	/*
 	 * Generate IN_ATTRIB events on file and subdir that should be reported to parent
@@ -151,6 +176,7 @@ static void verify_inotify(unsigned int n)
 	}
 
 	SAFE_CLOSE(fd_notify);
+	SAFE_CLOSE(fd_notify_other);
 }
 
 static void setup(void)
@@ -163,6 +189,8 @@ static void cleanup(void)
 {
 	if (fd_notify > 0)
 		SAFE_CLOSE(fd_notify);
+	if (fd_notify_other > 0)
+		SAFE_CLOSE(fd_notify_other);
 }
 
 static struct tst_test test = {
-- 
2.25.1

