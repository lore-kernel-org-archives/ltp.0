From: Filip Bozuta <Filip.Bozuta@syrmia.com>
Date: Fri,  7 Aug 2020 13:39:49 +0200
Subject: [LTP] [PATCH v2 2/3] syscalls/clock_nanosleep: add a test case for
 bad timespec address
In-Reply-To: <20200807113950.69052-1-Filip.Bozuta@syrmia.com>
References: <20200807113950.69052-1-Filip.Bozuta@syrmia.com>
Message-ID: <20200807113950.69052-3-Filip.Bozuta@syrmia.com>
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
 .../clock_nanosleep/clock_nanosleep01.c       | 35 +++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c b/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c
index 4542995f2..66108ed8e 100644
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
@@ -106,24 +124,37 @@ void setup(void)
 	SAFE_SIGNAL(SIGINT, sighandler);
 }
 
+void cleanup(void) {}
+
 static void do_test(unsigned int i)
 {
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
+		request = tst_get_bad_addr(cleanup);
+	else
+		request = tst_ts_get(rq);
+
+	if (tc->ttype == BAD_TS_ADDR_REM)
+		remain = tst_get_bad_addr(cleanup);
+	else
+		remain = tst_ts_get(rm);
+
+	TEST(tv->func(tc->clk_id, tc->flags, request, remain));
 
 	if (tv->func == libc_clock_nanosleep) {
 		/*
-- 
2.25.1

