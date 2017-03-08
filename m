From: Petr Vorel <pvorel@suse.cz>
Date: Wed,  8 Mar 2017 01:03:08 +0100
Subject: [LTP] [PATCH v3 3/3] syscalls: use SAFE_MQ_OPEN() macro
In-Reply-To: <20170308000308.8274-1-pvorel@suse.cz>
References: <20170308000308.8274-1-pvorel@suse.cz>
Message-ID: <20170308000308.8274-3-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/syscalls/mq_notify/mq_notify01.c             |  7 ++-----
 testcases/kernel/syscalls/mq_open/mq_open01.c                 |  9 +++------
 testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c | 11 ++++-------
 testcases/kernel/syscalls/mq_unlink/mq_unlink01.c             |  7 ++-----
 4 files changed, 11 insertions(+), 23 deletions(-)

diff --git a/testcases/kernel/syscalls/mq_notify/mq_notify01.c b/testcases/kernel/syscalls/mq_notify/mq_notify01.c
index 68fabffcf..99ec2edcc 100644
--- a/testcases/kernel/syscalls/mq_notify/mq_notify01.c
+++ b/testcases/kernel/syscalls/mq_notify/mq_notify01.c
@@ -28,6 +28,7 @@
 #include <fcntl.h>
 
 #include "tst_test.h"
+#include "tst_safe_posix_ipc.h"
 
 #define MAX_MSGSIZE     8192
 #define MSG_SIZE	16
@@ -162,11 +163,7 @@ static void do_test(unsigned int i)
 		}
 		break;
 	default:
-		fd = mq_open(QUEUE_NAME, O_CREAT | O_EXCL | O_RDWR, S_IRWXU, NULL);
-		if (fd < 0) {
-			tst_res(TBROK | TERRNO, "mq_open failed");
-			goto CLEANUP;
-		}
+		fd = SAFE_MQ_OPEN(QUEUE_NAME, O_CREAT | O_EXCL | O_RDWR, S_IRWXU, NULL);
 	}
 
 	ev.sigev_notify = tc->notify;
diff --git a/testcases/kernel/syscalls/mq_open/mq_open01.c b/testcases/kernel/syscalls/mq_open/mq_open01.c
index 6324d921d..c2955d861 100644
--- a/testcases/kernel/syscalls/mq_open/mq_open01.c
+++ b/testcases/kernel/syscalls/mq_open/mq_open01.c
@@ -25,6 +25,7 @@
 #include <pwd.h>
 
 #include "tst_safe_file_ops.h"
+#include "tst_safe_posix_ipc.h"
 #include "tst_test.h"
 
 #define QUEUE_NAME	"/test_mqueue"
@@ -155,9 +156,7 @@ static struct test_case tcase[] = {
 
 static void create_queue(void)
 {
-	fd2 = mq_open(QUEUE_NAME, O_CREAT | O_EXCL | O_RDWR, S_IRWXU, NULL);
-	if (fd2 == -1)
-		tst_brk(TBROK | TERRNO, "mq_open(" QUEUE_NAME ") failed");
+	fd2 = SAFE_MQ_OPEN(QUEUE_NAME, O_CREAT | O_EXCL | O_RDWR, S_IRWXU, NULL);
 
 	SAFE_SETEUID(pw->pw_uid);
 }
@@ -209,9 +208,7 @@ static void setup(void)
 	pw = SAFE_GETPWNAM("nobody");
 	SAFE_GETRLIMIT(RLIMIT_NOFILE, &rlim);
 
-	fd3 = mq_open(QUEUE_INIT, O_CREAT | O_EXCL | O_RDWR, S_IRWXU, NULL);
-	if (fd3 == -1)
-		tst_brk(TBROK | TERRNO, "mq_open(%s) failed", QUEUE_INIT);
+	fd3 = SAFE_MQ_OPEN(QUEUE_INIT, O_CREAT | O_EXCL | O_RDWR, S_IRWXU, NULL);
 }
 
 static void cleanup(void)
diff --git a/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c b/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c
index ab46bc6b0..c1ffd0eb1 100644
--- a/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c
+++ b/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c
@@ -25,6 +25,7 @@
 #include <mqueue.h>
 
 #include "tst_sig_proc.h"
+#include "tst_safe_posix_ipc.h"
 #include "tst_test.h"
 
 static struct sigaction act;
@@ -179,17 +180,13 @@ static void cleanup(void)
 
 static void create_queue(void)
 {
-	fd = mq_open(QUEUE_NAME, O_CREAT | O_EXCL | O_RDWR, S_IRWXU, NULL);
-	if (fd == -1)
-		tst_brk(TBROK | TERRNO, "mq_open(" QUEUE_NAME ") failed");
+	fd = SAFE_MQ_OPEN(QUEUE_NAME, O_CREAT | O_EXCL | O_RDWR, S_IRWXU, NULL);
 }
 
 static void create_queue_nonblock(void)
 {
-	fd = mq_open(QUEUE_NAME, O_CREAT | O_EXCL | O_RDWR | O_NONBLOCK, S_IRWXU,
-		     NULL);
-	if (fd == -1)
-		tst_brk(TBROK | TERRNO, "mq_open(" QUEUE_NAME ") failed");
+	fd = SAFE_MQ_OPEN(QUEUE_NAME, O_CREAT | O_EXCL | O_RDWR | O_NONBLOCK,
+		S_IRWXU, NULL);
 }
 
 static void create_queue_sig(void)
diff --git a/testcases/kernel/syscalls/mq_unlink/mq_unlink01.c b/testcases/kernel/syscalls/mq_unlink/mq_unlink01.c
index 9e0a2a7e3..03ce3f8a0 100644
--- a/testcases/kernel/syscalls/mq_unlink/mq_unlink01.c
+++ b/testcases/kernel/syscalls/mq_unlink/mq_unlink01.c
@@ -25,6 +25,7 @@
 #include <mqueue.h>
 
 #include "tst_test.h"
+#include "tst_safe_posix_ipc.h"
 
 #define QUEUE_NAME	"/test_mqueue"
 
@@ -94,11 +95,7 @@ static void do_test(unsigned int i)
 	mq_unlink(QUEUE_NAME);
 
 	/* prepare */
-	fd = mq_open(QUEUE_NAME, O_CREAT | O_EXCL | O_RDWR, S_IRWXU, NULL);
-	if (fd == -1) {
-		tst_res(TBROK | TERRNO, "mq_open failed");
-		goto EXIT;
-	}
+	fd = SAFE_MQ_OPEN(QUEUE_NAME, O_CREAT | O_EXCL | O_RDWR, S_IRWXU, NULL);
 
 	if (tc->as_nobody && seteuid(pw->pw_uid)) {
 		tst_res(TBROK | TERRNO, "seteuid failed");
-- 
2.12.0

