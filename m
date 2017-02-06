From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Mon, 6 Feb 2017 20:42:10 +0800
Subject: [LTP] [PATCH] syscalls/mq_open: fix limits for queues_max
Message-ID: <1486384930-28588-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This case fails on RHEL6.8GA and RHEL6.9Beta, because setting
queues_max to 0 is invalid.  the minimum value of queues_max
has been limitted to 1 on some distributions, Please see the
following kernel commit:

commit 5b5c4d1a1440e94994c73dddbad7be0676cd8b9a
Author: Doug Ledford <dledford@redhat.com>
Date:   Thu May 31 16:26:30 2012 -0700

	ipc/mqueue: update maximums for the mqueue subsystem

We set queues_max to 1 instead of 0, so this case can work on RHEL6.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/mq_open/mq_open01.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/mq_open/mq_open01.c b/testcases/kernel/syscalls/mq_open/mq_open01.c
index d6f7196..caffaf5 100644
--- a/testcases/kernel/syscalls/mq_open/mq_open01.c
+++ b/testcases/kernel/syscalls/mq_open/mq_open01.c
@@ -28,6 +28,7 @@
 #include "tst_test.h"
 
 #define QUEUE_NAME	"/test_mqueue"
+#define QUEUE_INIT      "/init_mqueue"
 
 static uid_t euid;
 static struct passwd *pw;
@@ -35,6 +36,7 @@ static char *qname;
 static struct rlimit rlim;
 
 static mqd_t fd, fd2;
+static mqd_t fd3 = -1;
 static int max_queues;
 
 struct test_case {
@@ -174,7 +176,7 @@ static void unlink_queue(void)
 static void set_max_queues(void)
 {
 	SAFE_FILE_SCANF(PROC_MAX_QUEUES, "%d", &max_queues);
-	SAFE_FILE_PRINTF(PROC_MAX_QUEUES, "%d", 0);
+	SAFE_FILE_PRINTF(PROC_MAX_QUEUES, "%d", 1);
 
 	SAFE_SETEUID(pw->pw_uid);
 }
@@ -206,6 +208,10 @@ static void setup(void)
 	euid = geteuid();
 	pw = SAFE_GETPWNAM("nobody");
 	SAFE_GETRLIMIT(RLIMIT_NOFILE, &rlim);
+
+	fd3 = mq_open(QUEUE_INIT, O_CREAT | O_EXCL | O_RDWR, S_IRWXU, NULL);
+	if (fd3 == -1)
+		tst_brk(TBROK | TERRNO, "mq_open(%s) failed", QUEUE_INIT);
 }
 
 static void cleanup(void)
@@ -216,6 +222,12 @@ static void cleanup(void)
 	if (fd2 > 0)
 		mq_close(fd2);
 
+	if (fd3 > 0 && mq_close(fd3))
+		tst_res(TWARN | TERRNO, "mq_close(%s) failed", QUEUE_INIT);
+
+	if (mq_unlink(QUEUE_INIT))
+		tst_res(TWARN | TERRNO, "mq_unlink(%s) failed", QUEUE_INIT);
+
 	mq_unlink(qname);
 }
 
-- 
1.8.3.1



