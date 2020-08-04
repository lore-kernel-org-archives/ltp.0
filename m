From: Filip Bozuta <Filip.Bozuta@syrmia.com>
Date: Tue,  4 Aug 2020 16:40:43 +0200
Subject: [LTP] [PATCH 1/3] syscalls/mq_timed{send|receive}: Add test cases
 for bad address
In-Reply-To: <20200804144045.18875-1-Filip.Bozuta@syrmia.com>
References: <20200804144045.18875-1-Filip.Bozuta@syrmia.com>
Message-ID: <20200804144045.18875-2-Filip.Bozuta@syrmia.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This patch introduces test cases for already existing
tests for syscalls 'mq_timedsend()' and 'mq_timedreceive()'
(mq_timedsend01, mq_timedreceive01). These test cases are for
situations when bad addresses are passed for arguments 'msg_ptr'
and 'abs_timeout' in which case errno 'EFAULT' is expected to be set.
Value '(void *)1' is used as a bad address for these arguments.

Implementation notes:

   Structure 'struct test_case' from file 'mq_timed.h' was modified
   with addition of two fields (bad_msg_addr and bad_ts_addr) which
   represent indicators for the implemented testcases. They are set
   to 1 for the new added test cases. These fileds are checked before
   running the test to see if bad address value '(void *)1' should be
   passed for the above mentioned arguments.

   For 'mq_timedreceive()' only the test case for bad 'abs_timeout'
   was included because the syscall blocks when a bad address for
   'msg_ptr' is passed.

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
---
 .../mq_timedreceive/mq_timedreceive01.c       | 12 +++++++++-
 .../syscalls/mq_timedsend/mq_timedsend01.c    | 23 +++++++++++++++++--
 testcases/kernel/syscalls/utils/mq_timed.h    |  2 ++
 3 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c b/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c
index 8e24651c9..01973c76b 100644
--- a/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c
+++ b/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c
@@ -123,6 +123,13 @@ static struct test_case tcase[] = {
 		.ret = -1,
 		.err = EINTR,
 	},
+	{
+		.fd = &fd,
+		.len = 16,
+		.bad_ts_addr = 1,
+		.ret = -1,
+		.err = EFAULT,
+	}
 };
 
 static void setup(void)
@@ -164,7 +171,10 @@ static void do_test(unsigned int i)
 	if (tc->invalid_msg)
 		len -= 1;
 
-	TEST(tv->receive(*tc->fd, rmsg, len, &prio, tst_ts_get(tc->rq)));
+	if (tc->bad_ts_addr)
+		TEST(tv->receive(*tc->fd, rmsg, len, &prio, (void *)1));
+	else
+		TEST(tv->receive(*tc->fd, rmsg, len, &prio, tst_ts_get(tc->rq)));
 
 	if (pid > 0)
 		kill_pid(pid);
diff --git a/testcases/kernel/syscalls/mq_timedsend/mq_timedsend01.c b/testcases/kernel/syscalls/mq_timedsend/mq_timedsend01.c
index f7fc2c533..dbef665dc 100644
--- a/testcases/kernel/syscalls/mq_timedsend/mq_timedsend01.c
+++ b/testcases/kernel/syscalls/mq_timedsend/mq_timedsend01.c
@@ -129,6 +129,20 @@ static struct test_case tcase[] = {
 		.ret = -1,
 		.err = EINTR,
 	},
+	{
+		.fd = &fd,
+		.len = 16,
+		.bad_msg_addr = 1,
+		.ret = -1,
+		.err = EFAULT,
+	},
+	{
+		.fd = &fd,
+		.len = 16,
+		.bad_ts_addr = 1,
+		.ret = -1,
+		.err = EFAULT,
+	}
 };
 
 static void setup(void)
@@ -168,7 +182,12 @@ static void do_test(unsigned int i)
 			}
 	}
 
-	TEST(tv->send(*tc->fd, smsg, tc->len, tc->prio, tst_ts_get(tc->rq)));
+	if (tc->bad_msg_addr)
+		TEST(tv->send(*tc->fd, (void *)1, tc->len, tc->prio, tst_ts_get(tc->rq)));
+	else if (tc->bad_ts_addr)
+		TEST(tv->send(*tc->fd, smsg, tc->len, tc->prio, (void *)1));
+	else
+		TEST(tv->send(*tc->fd, smsg, tc->len, tc->prio, tst_ts_get(tc->rq)));
 
 	if (pid > 0)
 		kill_pid(pid);
@@ -179,7 +198,7 @@ static void do_test(unsigned int i)
 				"mq_timedsend() failed unexpectedly, expected %s",
 				tst_strerrno(tc->err));
 		else
-			tst_res(TPASS | TTERRNO, "mq_timedreceive() failed expectedly");
+			tst_res(TPASS | TTERRNO, "mq_timedsend() failed expectedly");
 
 		if (*tc->fd == fd)
 			cleanup_queue(fd);
diff --git a/testcases/kernel/syscalls/utils/mq_timed.h b/testcases/kernel/syscalls/utils/mq_timed.h
index 3a99d9eef..a217e864e 100644
--- a/testcases/kernel/syscalls/utils/mq_timed.h
+++ b/testcases/kernel/syscalls/utils/mq_timed.h
@@ -41,6 +41,8 @@ struct test_case {
 	int send;
 	int signal;
 	int timeout;
+	int bad_msg_addr;
+	int bad_ts_addr;
 	int ret;
 	int err;
 };
-- 
2.25.1

