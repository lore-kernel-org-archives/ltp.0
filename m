From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 16 Nov 2018 08:51:18 +0200
Subject: [LTP] [PATCH 4/5] syscalls/fanotify03: add test for
	FAN_MARK_FILESYSTEM permission events
In-Reply-To: <20181116065119.6912-1-amir73il@gmail.com>
References: <20181116065119.6912-1-amir73il@gmail.com>
Message-ID: <20181116065119.6912-5-amir73il@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 .../kernel/syscalls/fanotify/fanotify03.c     | 25 ++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify03.c b/testcases/kernel/syscalls/fanotify/fanotify03.c
index 19daf57ef..5c105ed32 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify03.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify03.c
@@ -46,6 +46,7 @@ static unsigned long long event_set[EVENT_MAX];
 static unsigned int event_resp[EVENT_MAX];
 
 static char event_buf[EVENT_BUF_LEN];
+static int support_perm_events;
 
 static struct tcase {
 	const char *tname;
@@ -59,6 +60,10 @@ static struct tcase {
 		"mount mark permission events",
 		INIT_FANOTIFY_MARK_TYPE(MOUNT),
 	},
+	{
+		"filesystem mark permission events",
+		INIT_FANOTIFY_MARK_TYPE(FILESYSTEM),
+	},
 };
 
 static void generate_events(void)
@@ -134,7 +139,7 @@ static void check_child(void)
 		tst_res(TFAIL, "child %s", tst_strstatus(child_ret));
 }
 
-static void setup_mark(unsigned int n)
+static int setup_mark(unsigned int n)
 {
 	struct tcase *tc = &tcases[n];
 	struct fanotify_mark_type *mark = &tc->mark;
@@ -144,7 +149,12 @@ static void setup_mark(unsigned int n)
 	if (fanotify_mark(fd_notify, FAN_MARK_ADD | mark->flag,
 			  FAN_ACCESS_PERM | FAN_OPEN_PERM,
 			  AT_FDCWD, fname) < 0) {
-		if (errno == EINVAL) {
+		if (errno == EINVAL && support_perm_events &&
+		    mark->flag == FAN_MARK_FILESYSTEM) {
+			tst_res(TCONF,
+				"FAN_MARK_FILESYSTEM not supported in kernel?");
+			return -1;
+		} else if (errno == EINVAL) {
 			tst_brk(TCONF | TERRNO,
 				"CONFIG_FANOTIFY_ACCESS_PERMISSIONS not "
 				"configured in kernel?");
@@ -155,9 +165,16 @@ static void setup_mark(unsigned int n)
 				"AT_FDCWD, %s) failed.",
 				fd_notify, mark->name, fname);
 		}
+	} else {
+		/*
+		 * To distigouish between perm event not supported and
+		 * filesystem mark not supported.
+		 */
+		support_perm_events = 1;
 	}
 
 	tst_res(TINFO, "Test #%d: %s", n, tc->tname);
+	return 0;
 }
 
 static void test_fanotify(unsigned int n)
@@ -165,7 +182,9 @@ static void test_fanotify(unsigned int n)
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

