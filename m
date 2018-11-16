From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 16 Nov 2018 08:51:16 +0200
Subject: [LTP] [PATCH 2/5] syscalls/fanotify03: check permission events also
	on mountpoint mark
In-Reply-To: <20181116065119.6912-1-amir73il@gmail.com>
References: <20181116065119.6912-1-amir73il@gmail.com>
Message-ID: <20181116065119.6912-3-amir73il@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add index to test and repeat it for mark types inode and mountpoint.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 .../kernel/syscalls/fanotify/fanotify03.c     | 34 +++++++++++++++----
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify03.c b/testcases/kernel/syscalls/fanotify/fanotify03.c
index 42aac813e..19daf57ef 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify03.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify03.c
@@ -47,6 +47,20 @@ static unsigned int event_resp[EVENT_MAX];
 
 static char event_buf[EVENT_BUF_LEN];
 
+static struct tcase {
+	const char *tname;
+	struct fanotify_mark_type mark;
+} tcases[] = {
+	{
+		"inode mark permission events",
+		INIT_FANOTIFY_MARK_TYPE(INODE),
+	},
+	{
+		"mount mark permission events",
+		INIT_FANOTIFY_MARK_TYPE(MOUNT),
+	},
+};
+
 static void generate_events(void)
 {
 	int fd;
@@ -120,11 +134,14 @@ static void check_child(void)
 		tst_res(TFAIL, "child %s", tst_strstatus(child_ret));
 }
 
-static void setup_mark(void)
+static void setup_mark(unsigned int n)
 {
+	struct tcase *tc = &tcases[n];
+	struct fanotify_mark_type *mark = &tc->mark;
+
 	fd_notify = SAFE_FANOTIFY_INIT(FAN_CLASS_CONTENT, O_RDONLY);
 
-	if (fanotify_mark(fd_notify, FAN_MARK_ADD,
+	if (fanotify_mark(fd_notify, FAN_MARK_ADD | mark->flag,
 			  FAN_ACCESS_PERM | FAN_OPEN_PERM,
 			  AT_FDCWD, fname) < 0) {
 		if (errno == EINVAL) {
@@ -133,20 +150,22 @@ static void setup_mark(void)
 				"configured in kernel?");
 		} else {
 			tst_brk(TBROK | TERRNO,
-				"fanotify_mark (%d, FAN_MARK_ADD, "
+				"fanotify_mark (%d, FAN_MARK_ADD | %s, "
 				"FAN_ACCESS_PERM | FAN_OPEN_PERM, "
 				"AT_FDCWD, %s) failed.",
-				fd_notify, fname);
+				fd_notify, mark->name, fname);
 		}
 	}
+
+	tst_res(TINFO, "Test #%d: %s", n, tc->tname);
 }
 
-void test01(void)
+static void test_fanotify(unsigned int n)
 {
 	int tst_count;
 	int ret, len = 0, i = 0, test_num = 0;
 
-	setup_mark();
+	setup_mark(n);
 	run_child();
 
 	tst_count = 0;
@@ -247,7 +266,8 @@ static void cleanup(void)
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

