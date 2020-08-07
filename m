From: Filip Bozuta <Filip.Bozuta@syrmia.com>
Date: Fri,  7 Aug 2020 13:39:48 +0200
Subject: [LTP] [PATCH v2 1/3] syscalls/mq_timed{send|receive}: Add test
 cases for bad address
In-Reply-To: <20200807113950.69052-1-Filip.Bozuta@syrmia.com>
References: <20200807113950.69052-1-Filip.Bozuta@syrmia.com>
Message-ID: <20200807113950.69052-2-Filip.Bozuta@syrmia.com>
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

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
---
 .../mq_timedreceive/mq_timedreceive01.c       | 15 +++++++++-
 .../syscalls/mq_timedsend/mq_timedsend01.c    | 29 +++++++++++++++++--
 testcases/kernel/syscalls/utils/mq_timed.h    |  2 ++
 3 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c b/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c
index 8e24651c9..d99538e4b 100644
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
@@ -144,6 +151,7 @@ static void do_test(unsigned int i)
 	size_t len = MAX_MSGSIZE;
 	char rmsg[len];
 	pid_t pid = -1;
+	void *abs_timeout;
 
 	tst_ts_set_sec(&ts, tc->tv_sec);
 	tst_ts_set_nsec(&ts, tc->tv_nsec);
@@ -164,7 +172,12 @@ static void do_test(unsigned int i)
 	if (tc->invalid_msg)
 		len -= 1;
 
-	TEST(tv->receive(*tc->fd, rmsg, len, &prio, tst_ts_get(tc->rq)));
+	if (tc->bad_ts_addr)
+		abs_timeout = tst_get_bad_addr(cleanup_common);
+	else
+		abs_timeout = tst_ts_get(tc->rq);
+
+	TEST(tv->receive(*tc->fd, rmsg, len, &prio, abs_timeout));
 
 	if (pid > 0)
 		kill_pid(pid);
diff --git a/testcases/kernel/syscalls/mq_timedsend/mq_timedsend01.c b/testcases/kernel/syscalls/mq_timedsend/mq_timedsend01.c
index f7fc2c533..7e220f297 100644
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
@@ -150,6 +164,7 @@ static void do_test(unsigned int i)
 	size_t len = MAX_MSGSIZE;
 	char rmsg[len];
 	pid_t pid = -1;
+	void *msg_ptr, *abs_timeout;
 
 	tst_ts_set_sec(&ts, tc->tv_sec);
 	tst_ts_set_nsec(&ts, tc->tv_nsec);
@@ -168,7 +183,17 @@ static void do_test(unsigned int i)
 			}
 	}
 
-	TEST(tv->send(*tc->fd, smsg, tc->len, tc->prio, tst_ts_get(tc->rq)));
+	if (tc->bad_msg_addr)
+		msg_ptr = tst_get_bad_addr(cleanup_common);
+	else
+		msg_ptr = smsg;
+
+	if (tc->bad_ts_addr)
+		abs_timeout = tst_get_bad_addr(cleanup_common);
+	else
+		abs_timeout = tst_ts_get(tc->rq);
+
+	TEST(tv->send(*tc->fd, msg_ptr, tc->len, tc->prio, abs_timeout));
 
 	if (pid > 0)
 		kill_pid(pid);
@@ -179,7 +204,7 @@ static void do_test(unsigned int i)
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

