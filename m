From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 21 Nov 2018 19:20:55 +0200
Subject: [LTP] [PATCH v2] syscalls/fanotify03: add test for
	FAN_MARK_FILESYSTEM permission events
Message-ID: <20181121172055.13825-1-amir73il@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Changes from v1:
- Remove support_perm_events logic

 testcases/kernel/syscalls/fanotify/fanotify03.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify03.c b/testcases/kernel/syscalls/fanotify/fanotify03.c
index 19daf57ef..4991e1274 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify03.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify03.c
@@ -59,6 +59,10 @@ static struct tcase {
 		"mount mark permission events",
 		INIT_FANOTIFY_MARK_TYPE(MOUNT),
 	},
+	{
+		"filesystem mark permission events",
+		INIT_FANOTIFY_MARK_TYPE(FILESYSTEM),
+	},
 };
 
 static void generate_events(void)
@@ -134,7 +138,7 @@ static void check_child(void)
 		tst_res(TFAIL, "child %s", tst_strstatus(child_ret));
 }
 
-static void setup_mark(unsigned int n)
+static int setup_mark(unsigned int n)
 {
 	struct tcase *tc = &tcases[n];
 	struct fanotify_mark_type *mark = &tc->mark;
@@ -144,7 +148,11 @@ static void setup_mark(unsigned int n)
 	if (fanotify_mark(fd_notify, FAN_MARK_ADD | mark->flag,
 			  FAN_ACCESS_PERM | FAN_OPEN_PERM,
 			  AT_FDCWD, fname) < 0) {
-		if (errno == EINVAL) {
+		if (errno == EINVAL && mark->flag == FAN_MARK_FILESYSTEM) {
+			tst_res(TCONF,
+				"FAN_MARK_FILESYSTEM not supported in kernel?");
+			return -1;
+		} else if (errno == EINVAL) {
 			tst_brk(TCONF | TERRNO,
 				"CONFIG_FANOTIFY_ACCESS_PERMISSIONS not "
 				"configured in kernel?");
@@ -158,6 +166,7 @@ static void setup_mark(unsigned int n)
 	}
 
 	tst_res(TINFO, "Test #%d: %s", n, tc->tname);
+	return 0;
 }
 
 static void test_fanotify(unsigned int n)
@@ -165,7 +174,9 @@ static void test_fanotify(unsigned int n)
 	int tst_count;
 	int ret, len = 0, i = 0, test_num = 0;
 
-	setup_mark(n);
+	if (setup_mark(n) != 0)
+		return;
+
 	run_child();
 
 	tst_count = 0;
-- 
2.17.1

