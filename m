From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 24 Nov 2016 12:11:16 +0100
Subject: [LTP] [PATCH v2 1/1] syscalls/mq_notify01: cleanup
Message-ID: <20161124111116.24258-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes v1->v2:
* deadlock prevention: copy the siginfo_t structure into an global variable and
examine/print it in the main thread.
* variables changed in signal handlers are defined volatile
* removed redundant opt_debug (+ setup function)
* not using tmpdir
* formating cleanup
---
 testcases/kernel/syscalls/mq_notify/mq_notify01.c | 121 +++++++++++-----------
 1 file changed, 58 insertions(+), 63 deletions(-)

diff --git a/testcases/kernel/syscalls/mq_notify/mq_notify01.c b/testcases/kernel/syscalls/mq_notify/mq_notify01.c
index 9dd073f..41e1db8 100644
--- a/testcases/kernel/syscalls/mq_notify/mq_notify01.c
+++ b/testcases/kernel/syscalls/mq_notify/mq_notify01.c
@@ -36,10 +36,9 @@
 #include "tst_test.h"
 
 static char *str_debug;
-static int opt_debug;
 
-static int notified;
-static int cmp_ok;
+static volatile sig_atomic_t notified, cmp_ok;
+static siginfo_t info;
 
 enum test_type {
 	NORMAL,
@@ -52,7 +51,7 @@ enum test_type {
 struct test_case {
 	int notify;
 	int ttype;
-	const char *desc;	   /* test description (name) */
+	const char *desc;
 	int ret;
 	int err;
 };
@@ -67,68 +66,59 @@ struct test_case {
 
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
 
-static void setup(void)
+static void sigfunc(int signo LTP_ATTRIBUTE_UNUSED, siginfo_t *si,
+	void *data LTP_ATTRIBUTE_UNUSED)
 {
-	opt_debug = str_debug ? 1 : 0;
-}
+	if (str_debug)
+		memcpy(&info, si, sizeof(info));
 
-static void sigfunc(int signo, siginfo_t * info, void *data)
-{
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
+	cmp_ok = si->si_code == SI_MESGQ &&
+	    si->si_signo == SIGUSR1 &&
+	    si->si_value.sival_int == USER_DATA &&
+	    si->si_pid == getpid() && si->si_uid == getuid();
 	notified = 1;
 }
 
@@ -162,10 +152,10 @@ static void do_test(unsigned int i)
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
@@ -175,9 +165,7 @@ static void do_test(unsigned int i)
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
@@ -233,6 +221,15 @@ static void do_test(unsigned int i)
 
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
 
 	if ((sys_ret != 0 && sys_errno != tc->err) || !cmp_ok) {
@@ -261,6 +258,4 @@ static struct tst_test test = {
 	.tcnt = ARRAY_SIZE(tcase),
 	.test = do_test,
 	.options = options,
-	.needs_tmpdir = 1,
-	.setup = setup,
 };
-- 
2.10.2

