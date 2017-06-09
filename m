From: Petr Vorel <pvorel@suse.cz>
Date: Fri,  9 Jun 2017 21:12:49 +0200
Subject: [LTP] [PATCH v2 1/4] syscalls/mq_timedreceive: Add check data
	returned from mq_timedreceive
Message-ID: <20170609191252.9870-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This is a regression from
commit 5c266719126b0e770102b787a904cf90ece922ec
Author: Petr Vorel <pvorel@suse.cz>
Date:   Wed Mar 8 15:21:52 2017 +0100

    syscalls/mq_timedreceive: convert to new API

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .../syscalls/mq_timedreceive/mq_timedreceive01.c   | 32 ++++++++++++++--------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c b/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c
index f6ff4a5a4..6ed670464 100644
--- a/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c
+++ b/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c
@@ -28,6 +28,10 @@
 #include "tst_sig_proc.h"
 #include "tst_safe_posix_ipc.h"
 
+#define MAX_MSGSIZE     8192
+#define QUEUE_NAME	"/test_mqueue"
+
+static char smsg[MAX_MSGSIZE];
 static struct sigaction act;
 static pid_t pid;
 static int fd, fd_root;
@@ -35,7 +39,7 @@ static struct timespec timeout_ts;
 static struct timespec eintr_ts;
 
 struct test_case {
-	int len;
+	unsigned int len;
 	unsigned prio;
 	struct timespec *rq;
 	int fd;
@@ -47,10 +51,6 @@ struct test_case {
 	void (*cleanup)(void);
 };
 
-#define MAX_MSGSIZE     8192
-
-#define QUEUE_NAME	"/test_mqueue"
-
 static void create_queue(void);
 static void create_queue_nonblock(void);
 static void create_queue_sig(void);
@@ -175,10 +175,15 @@ static void sighandler(int sig LTP_ATTRIBUTE_UNUSED)
 
 static void setup(void)
 {
+	unsigned int i;
+
 	act.sa_handler = sighandler;
 	sigaction(SIGINT, &act, NULL);
 
 	fd_root = SAFE_OPEN("/", O_RDONLY);
+
+	for (i = 0; i < MAX_MSGSIZE; i++)
+		smsg[i] = i;
 }
 
 static void cleanup(void)
@@ -227,12 +232,6 @@ static void open_fd(void)
 
 static void send_msg(int fd, int len, int prio)
 {
-	char smsg[MAX_MSGSIZE];
-	int i;
-
-	for (i = 0; i < len; i++)
-		smsg[i] = i;
-
 	if (mq_timedsend(fd, smsg, len, prio,
 		&((struct timespec){0})) < 0)
 		tst_brk(TBROK | TERRNO, "mq_timedsend failed");
@@ -256,9 +255,10 @@ static void unlink_queue_sig(void)
 
 static void do_test(unsigned int i)
 {
+	unsigned int j;
 	const struct test_case *tc = &tcase[i];
 	char rmsg[MAX_MSGSIZE];
-	unsigned prio;
+	unsigned int prio;
 	size_t msg_len = MAX_MSGSIZE;
 
 	/*
@@ -308,6 +308,14 @@ static void do_test(unsigned int i)
 		return;
 	}
 
+	for (j = 0; j < tc->len; j++) {
+		if (rmsg[j] != smsg[j]) {
+			tst_res(TFAIL | TTERRNO, "mq_timedreceive wrong data in loop %d returned %d, expected %d",
+			i, rmsg[j], smsg[j]);
+			return;
+		}
+	}
+
 	tst_res(TPASS, "mq_timedreceive returned %ld prio %u", TEST_RETURN, prio);
 }
 
-- 
2.12.2

