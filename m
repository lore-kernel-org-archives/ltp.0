From: Filip Bozuta <Filip.Bozuta@syrmia.com>
Date: Mon, 17 Aug 2020 12:22:31 +0200
Subject: [LTP] [PATCH v3 1/2] syscalls/clock_nanosleep: add a test case for
 bad timespec address
In-Reply-To: <20200817102232.5902-1-Filip.Bozuta@syrmia.com>
References: <20200817102232.5902-1-Filip.Bozuta@syrmia.com>
Message-ID: <20200817102232.5902-2-Filip.Bozuta@syrmia.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This patch introduces test cases for already existing test
for syscall 'clock_nanosleep()' (clock_nanosleep01). These test
cases are for situations when bad timespec addresses are passed
for arguments 'request' and 'remain' in which case errno
EFAULT ('Bad address') is expected to be set.

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
---
 .../clock_nanosleep/clock_nanosleep01.c       | 43 +++++++++++++++++--
 1 file changed, 39 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c b/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c
index 4542995f2..fe5f4d7c7 100644
--- a/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c
+++ b/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c
@@ -20,10 +20,14 @@ static void sighandler(int sig LTP_ATTRIBUTE_UNUSED)
 enum test_type {
 	NORMAL,
 	SEND_SIGINT,
+	BAD_TS_ADDR_REQ,
+	BAD_TS_ADDR_REM,
 };
 
 #define TYPE_NAME(x) .ttype = x, .desc = #x
 
+static void *bad_addr;
+
 struct test_case {
 	clockid_t clk_id;	   /* clock_* clock type parameter */
 	int ttype;		   /* test type (enum) */
@@ -37,8 +41,11 @@ struct test_case {
 
 /*
  *   test status of errors on man page
- *   EINTR	      v (function was interrupted by a signal)
- *   EINVAL	     v (invalid tv_nsec, etc.)
+ *   EINTR        v (function was interrupted by a signal)
+ *   EINVAL       v (invalid tv_nsec, etc.)
+ *   ENOTSUP      v (sleep not supported against the specified clock_id)
+ *   EFAULT       v (Invalid request pointer)
+ *   EFAULT       V (Invalid remain pointer when interrupted by a signal)
  */
 
 static struct test_case tcase[] = {
@@ -78,6 +85,22 @@ static struct test_case tcase[] = {
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
@@ -104,6 +127,7 @@ void setup(void)
 	rq->type = variants[tst_variant].type;
 	tst_res(TINFO, "Testing variant: %s", variants[tst_variant].desc);
 	SAFE_SIGNAL(SIGINT, sighandler);
+	bad_addr = tst_get_bad_addr(NULL);
 }
 
 static void do_test(unsigned int i)
@@ -111,19 +135,30 @@ static void do_test(unsigned int i)
 	struct test_variants *tv = &variants[tst_variant];
 	struct test_case *tc = &tcase[i];
 	pid_t pid = 0;
+	void *request, *remain;
 
 	memset(rm, 0, sizeof(*rm));
 	rm->type = rq->type;
 
 	tst_res(TINFO, "case %s", tc->desc);
 
-	if (tc->ttype == SEND_SIGINT)
+	if (tc->ttype == SEND_SIGINT || tc->ttype == BAD_TS_ADDR_REM)
 		pid = create_sig_proc(SIGINT, 40, 500000);
 
 	tst_ts_set_sec(rq, tc->tv_sec);
 	tst_ts_set_nsec(rq, tc->tv_nsec);
 
-	TEST(tv->func(tc->clk_id, tc->flags, tst_ts_get(rq), tst_ts_get(rm)));
+	if (tc->ttype == BAD_TS_ADDR_REQ)
+		request = bad_addr;
+	else
+		request = tst_ts_get(rq);
+
+	if (tc->ttype == BAD_TS_ADDR_REM)
+		remain = bad_addr;
+	else
+		remain = tst_ts_get(rm);
+
+	TEST(tv->func(tc->clk_id, tc->flags, request, remain));
 
 	if (tv->func == libc_clock_nanosleep) {
 		/*
-- 
2.25.1

