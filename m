From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 24 Nov 2016 12:32:05 +0100
Subject: [LTP] [PATCH v3 1/1] syscalls/mq_notify01: prevent deadlock, cleanup
Message-ID: <20161124113205.26581-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes v2->v3:
* simplify code (optimize TEST macro usage)
* cleanup comments

Changes v1->v2:
* deadlock prevention: copy the siginfo_t structure into an global variable and
examine/print it in the main thread.
* variables changed in signal handlers are defined volatile
* removed redundant opt_debug (+ setup function)
* not using tmpdir
* formating cleanup
---
 testcases/kernel/syscalls/mq_notify/mq_notify01.c | 168 ++++++++++------------
 1 file changed, 79 insertions(+), 89 deletions(-)

diff --git a/testcases/kernel/syscalls/mq_notify/mq_notify01.c b/testcases/kernel/syscalls/mq_notify/mq_notify01.c
index 9dd073f..a0aee1b 100644
--- a/testcases/kernel/syscalls/mq_notify/mq_notify01.c
+++ b/testcases/kernel/syscalls/mq_notify/mq_notify01.c
@@ -35,11 +35,16 @@
 #include "linux_syscall_numbers.h"
 #include "tst_test.h"
 
+#define MAX_MSGSIZE     8192
+#define MSG_SIZE	16
+#define USER_DATA       0x12345678
+#define QUEUE_NAME	"/test_mqueue"
+
 static char *str_debug;
-static int opt_debug;
+static char smsg[MAX_MSGSIZE];
 
-static int notified;
-static int cmp_ok;
+static volatile sig_atomic_t notified, cmp_ok;
+static siginfo_t info;
 
 enum test_type {
 	NORMAL,
@@ -52,83 +57,73 @@ enum test_type {
 struct test_case {
 	int notify;
 	int ttype;
-	const char *desc;	   /* test description (name) */
+	const char *desc;
 	int ret;
 	int err;
 };
 
-#define MAX_MSGSIZE     8192
-#define MSG_SIZE	16
-#define USER_DATA       0x12345678
-#define QUEUE_NAME	"/test_mqueue"
-
-
 #define TYPE_NAME(x) .ttype = x, .desc = #x
-
 static struct test_case tcase[] = {
 	{
-	 TYPE_NAME(NORMAL),
-	 .notify = SIGEV_NONE,
-	 .ret = 0,
-	 .err = 0,
-	 },
+		TYPE_NAME(NORMAL),
+		.notify = SIGEV_NONE,
+		.ret = 0,
+		.err = 0,
+	},
 	{
-	 TYPE_NAME(NORMAL),
-	 .notify = SIGEV_SIGNAL,
-	 .ret = 0,
-	 .err = 0,
-	 },
+		TYPE_NAME(NORMAL),
+		.notify = SIGEV_SIGNAL,
+		.ret = 0,
+		.err = 0,
+	},
 	{
-	 TYPE_NAME(NORMAL),
-	 .notify = SIGEV_THREAD,
-	 .ret = 0,
-	 .err = 0,
-	 },
+		TYPE_NAME(NORMAL),
+		.notify = SIGEV_THREAD,
+		.ret = 0,
+		.err = 0,
+	},
 	{
-	 TYPE_NAME(FD_NONE),
-	 .notify = SIGEV_NONE,
-	 .ret = -1,
-	 .err = EBADF,
-	 },
+		TYPE_NAME(FD_NONE),
+		.notify = SIGEV_NONE,
+		.ret = -1,
+		.err = EBADF,
+	},
 	{
-	 TYPE_NAME(FD_NOT_EXIST),
-	 .notify = SIGEV_NONE,
-	 .ret = -1,
-	 .err = EBADF,
-	 },
+		TYPE_NAME(FD_NOT_EXIST),
+		.notify = SIGEV_NONE,
+		.ret = -1,
+		.err = EBADF,
+	},
 	{
-	 TYPE_NAME(FD_FILE),
-	 .notify = SIGEV_NONE,
-	 .ret = -1,
-	 .err = EBADF,
-	 },
+		TYPE_NAME(FD_FILE),
+		.notify = SIGEV_NONE,
+		.ret = -1,
+		.err = EBADF,
+	},
 	{
-	 TYPE_NAME(ALREADY_REGISTERED),
-	 .notify = SIGEV_NONE,
-	 .ret = -1,
-	 .err = EBUSY,
-	 },
+		TYPE_NAME(ALREADY_REGISTERED),
+		.notify = SIGEV_NONE,
+		.ret = -1,
+		.err = EBUSY,
+	},
 };
 
 static void setup(void)
 {
-	opt_debug = str_debug ? 1 : 0;
+	int i;
+	for (i = 0; i < MSG_SIZE; i++)
+		smsg[i] = i;
 }
-
-static void sigfunc(int signo, siginfo_t * info, void *data)
+static void sigfunc(int signo LTP_ATTRIBUTE_UNUSED, siginfo_t *si,
+	void *data LTP_ATTRIBUTE_UNUSED)
 {
-	if (opt_debug) {
-		tst_res(TINFO, "si_code  E:%d,\tR:%d", info->si_code, SI_MESGQ);
-		tst_res(TINFO, "si_signo E:%d,\tR:%d", info->si_signo, SIGUSR1);
-		tst_res(TINFO, "si_value E:0x%x,\tR:0x%x",
-			 info->si_value.sival_int, USER_DATA);
-		tst_res(TINFO, "si_pid   E:%d,\tR:%d", info->si_pid, getpid());
-		tst_res(TINFO, "si_uid   E:%d,\tR:%d", info->si_uid, getuid());
-	}
-	cmp_ok = info->si_code == SI_MESGQ &&
-	    info->si_signo == SIGUSR1 &&
-	    info->si_value.sival_int == USER_DATA &&
-	    info->si_pid == getpid() && info->si_uid == getuid();
+	if (str_debug)
+		memcpy(&info, si, sizeof(info));
+
+	cmp_ok = si->si_code == SI_MESGQ &&
+	    si->si_signo == SIGUSR1 &&
+	    si->si_value.sival_int == USER_DATA &&
+	    si->si_pid == getpid() && si->si_uid == getuid();
 	notified = 1;
 }
 
@@ -140,13 +135,10 @@ static void tfunc(union sigval sv)
 
 static void do_test(unsigned int i)
 {
-	int sys_ret;
-	int sys_errno;
-	int rc, j, fd = -1;
+	int rc, fd = -1;
 	struct sigevent ev;
 	struct sigaction sigact;
 	struct timespec abs_timeout;
-	char smsg[MAX_MSGSIZE];
 	struct test_case *tc = &tcase[i];
 
 	notified = cmp_ok = 1;
@@ -162,10 +154,10 @@ static void do_test(unsigned int i)
 	mq_unlink(QUEUE_NAME);
 
 	switch (tc->ttype) {
+	case FD_NONE:
+		break;
 	case FD_NOT_EXIST:
 		fd = INT_MAX - 1;
-		/* fallthrough */
-	case FD_NONE:
 		break;
 	case FD_FILE:
 		TEST(fd = open("/", O_RDONLY));
@@ -175,9 +167,7 @@ static void do_test(unsigned int i)
 		}
 		break;
 	default:
-		TEST(fd =
-		     mq_open(QUEUE_NAME, O_CREAT | O_EXCL | O_RDWR, S_IRWXU,
-			     NULL));
+		TEST(fd = mq_open(QUEUE_NAME, O_CREAT | O_EXCL | O_RDWR, S_IRWXU, NULL));
 		if (TEST_RETURN < 0) {
 			tst_res(TFAIL | TTERRNO, "mq_open failed");
 			goto CLEANUP;
@@ -213,19 +203,10 @@ static void do_test(unsigned int i)
 		}
 	}
 
-	/*
-	 * Execute system call
-	 */
-	errno = 0;
-	sys_ret = mq_notify(fd, &ev);
-	sys_errno = errno;
-	if (sys_ret >= 0) {
-		/*
-		 * Prepare send message
-		 */
-		for (j = 0; j < MSG_SIZE; j++)
-			smsg[j] = j;
-		TEST(rc = mq_timedsend(fd, smsg, MSG_SIZE, 0, &abs_timeout));
+	/* test */
+	TEST(mq_notify(fd, &ev));
+	if (TEST_RETURN >= 0) {
+		rc = mq_timedsend(fd, smsg, MSG_SIZE, 0, &abs_timeout);
 		if (rc < 0) {
 			tst_res(TFAIL | TTERRNO, "mq_timedsend failed");
 			goto CLEANUP;
@@ -233,15 +214,25 @@ static void do_test(unsigned int i)
 
 		while (!notified)
 			usleep(10000);
+
+		if (str_debug && tc->notify == SIGEV_SIGNAL) {
+			tst_res(TINFO, "si_code  E:%d,\tR:%d", info.si_code, SI_MESGQ);
+			tst_res(TINFO, "si_signo E:%d,\tR:%d", info.si_signo, SIGUSR1);
+			tst_res(TINFO, "si_value E:0x%x,\tR:0x%x",
+					info.si_value.sival_int, USER_DATA);
+			tst_res(TINFO, "si_pid   E:%d,\tR:%d", info.si_pid, getpid());
+			tst_res(TINFO, "si_uid   E:%d,\tR:%d", info.si_uid, getuid());
+		}
 	}
 
-	if ((sys_ret != 0 && sys_errno != tc->err) || !cmp_ok) {
-		tst_res(TFAIL, "%s r/w check returned: %d, expected: %d,"
+	/* result check */
+	if ((TEST_RETURN != 0 && TEST_ERRNO != tc->err) || !cmp_ok) {
+		tst_res(TFAIL, "%s r/w check returned: %ld, expected: %d,"
 			" returned errno: %s (%d), expected errno: %s (%d)",
-			tc->desc, sys_ret, tc->ret, tst_strerrno(sys_errno),
-			sys_errno, tst_strerrno(tc->err), tc->err);
+			tc->desc, TEST_RETURN, tc->ret, tst_strerrno(TEST_ERRNO),
+			TEST_ERRNO, tst_strerrno(tc->err), tc->err);
 	} else {
-		tst_res(TPASS, "%s returned: %d", tc->desc, sys_ret);
+		tst_res(TPASS, "%s returned: %ld", tc->desc, TEST_RETURN);
 	}
 
 CLEANUP:
@@ -261,6 +252,5 @@ static struct tst_test test = {
 	.tcnt = ARRAY_SIZE(tcase),
 	.test = do_test,
 	.options = options,
-	.needs_tmpdir = 1,
 	.setup = setup,
 };
-- 
2.10.2

