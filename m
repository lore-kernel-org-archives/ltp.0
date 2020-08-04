From: Filip Bozuta <Filip.Bozuta@syrmia.com>
Date: Tue,  4 Aug 2020 16:40:44 +0200
Subject: [LTP] [PATCH 2/3] syscalls/clock_nanosleep: add a test case for bad
 timespec address
In-Reply-To: <20200804144045.18875-1-Filip.Bozuta@syrmia.com>
References: <20200804144045.18875-1-Filip.Bozuta@syrmia.com>
Message-ID: <20200804144045.18875-3-Filip.Bozuta@syrmia.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This patch introduces test cases for already existing test
for syscall 'clock_nanosleep()' (clock_nanosleep01). These test
cases are for situations when bad timespec addresses are passed
for arguments 'request' and 'remain' in which case errno
EFAULT ('Bad address') is expected to be set. Value '(void *)1'
is used as a bad address for these arguments.

Implementation notes:

   New test types are added in 'enum test_type': BAD_TS_REQ,
   BAD_TS_REM, for cases when bad timespec addresses are
   passed for the 'request' and 'remain' argument respectively.
   Appropriate test cases are added for these types where the
   'exp_err' is EFAULT. The test checks whether the test case type
   are one of the newly added types and passes the value '(void *)1'
   for the above mentioned arguments accordingly.

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
---
 .../clock_nanosleep/clock_nanosleep01.c       | 27 +++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c b/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c
index 4542995f2..a9cafe1b5 100644
--- a/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c
+++ b/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c
@@ -20,6 +20,8 @@ static void sighandler(int sig LTP_ATTRIBUTE_UNUSED)
 enum test_type {
 	NORMAL,
 	SEND_SIGINT,
+	BAD_TS_ADDR_REQ,
+	BAD_TS_ADDR_REM,
 };
 
 #define TYPE_NAME(x) .ttype = x, .desc = #x
@@ -78,6 +80,22 @@ static struct test_case tcase[] = {
 		.exp_ret = -1,
 		.exp_err = EINTR,
 	},
+	{
+		TYPE_NAME(BAD_TS_ADDR_REQ),
+		.clk_id = CLOCK_REALTIME,
+		.flags = 0,
+		.exp_ret = -1,
+		.exp_err = EFAULT,
+	},
+	{
+		TYPE_NAME(BAD_TS_ADDR_REM),
+		.clk_id = CLOCK_REALTIME,
+		.flags = 0,
+		.tv_sec = 10,
+		.tv_nsec = 0,
+		.exp_ret = -1,
+		.exp_err = EFAULT,
+	},
 };
 
 static struct tst_ts *rq;
@@ -117,13 +135,18 @@ static void do_test(unsigned int i)
 
 	tst_res(TINFO, "case %s", tc->desc);
 
-	if (tc->ttype == SEND_SIGINT)
+	if (tc->ttype == SEND_SIGINT || tc->ttype == BAD_TS_ADDR_REM)
 		pid = create_sig_proc(SIGINT, 40, 500000);
 
 	tst_ts_set_sec(rq, tc->tv_sec);
 	tst_ts_set_nsec(rq, tc->tv_nsec);
 
-	TEST(tv->func(tc->clk_id, tc->flags, tst_ts_get(rq), tst_ts_get(rm)));
+	if (tc->ttype == BAD_TS_ADDR_REQ)
+		TEST(tv->func(tc->clk_id, tc->flags, (void *) 1, NULL));
+	else if (tc->ttype == BAD_TS_ADDR_REM)
+		TEST(tv->func(tc->clk_id, tc->flags, tst_ts_get(rq), (void *)1));
+	else
+		TEST(tv->func(tc->clk_id, tc->flags, tst_ts_get(rq), tst_ts_get(rm)));
 
 	if (tv->func == libc_clock_nanosleep) {
 		/*
-- 
2.25.1

