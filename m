From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 12 Aug 2019 16:39:39 +0200
Subject: [LTP] [PATCH v2 09/11] syscalls/clock_getres01: Make use of guarded
 buffers.
In-Reply-To: <20190812143941.8119-1-chrubis@suse.cz>
References: <20190812143941.8119-1-chrubis@suse.cz>
Message-ID: <20190812143941.8119-10-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 .../kernel/syscalls/clock_getres/clock_getres01.c    | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/clock_getres/clock_getres01.c b/testcases/kernel/syscalls/clock_getres/clock_getres01.c
index 15f323108..e39f2909b 100644
--- a/testcases/kernel/syscalls/clock_getres/clock_getres01.c
+++ b/testcases/kernel/syscalls/clock_getres/clock_getres01.c
@@ -15,12 +15,12 @@
 #include "tst_test.h"
 #include "lapi/posix_clocks.h"
 
-static struct timespec res;
+static struct timespec *res, *null;
 
 static struct test_case {
 	char *name;
 	clockid_t clk_id;
-	struct timespec *res;
+	struct timespec **res;
 	int ret;
 	int err;
 } tcase[] = {
@@ -28,7 +28,7 @@ static struct test_case {
 	{"MONOTONIC", CLOCK_MONOTONIC, &res, 0, 0},
 	{"PROCESS_CPUTIME_ID", CLOCK_PROCESS_CPUTIME_ID, &res, 0, 0},
 	{"THREAD_CPUTIME_ID", CLOCK_THREAD_CPUTIME_ID, &res, 0, 0},
-	{"REALTIME", CLOCK_REALTIME, NULL, 0, 0},
+	{"REALTIME", CLOCK_REALTIME, &null, 0, 0},
 	{"CLOCK_MONOTONIC_RAW", CLOCK_MONOTONIC_RAW, &res, 0, 0,},
 	{"CLOCK_REALTIME_COARSE", CLOCK_REALTIME_COARSE, &res, 0, 0,},
 	{"CLOCK_MONOTONIC_COARSE", CLOCK_MONOTONIC_COARSE, &res, 0, 0,},
@@ -40,7 +40,7 @@ static struct test_case {
 
 static void do_test(unsigned int i)
 {
-	TEST(clock_getres(tcase[i].clk_id, tcase[i].res));
+	TEST(clock_getres(tcase[i].clk_id, *tcase[i].res));
 
 	if (TST_RET != tcase[i].ret) {
 		if (TST_ERR == EINVAL) {
@@ -65,4 +65,8 @@ static void do_test(unsigned int i)
 static struct tst_test test = {
 	.test = do_test,
 	.tcnt = ARRAY_SIZE(tcase),
+	.bufs = (struct tst_buffers []) {
+		{&res, .size = sizeof(*res)},
+		{},
+	}
 };
-- 
2.21.0

