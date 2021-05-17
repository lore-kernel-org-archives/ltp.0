From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Mon, 17 May 2021 17:30:25 +0100
Subject: [LTP] [RFC PATCH 2/6] API: Add tst_ to create_sig_proc
In-Reply-To: <20210517163029.22974-1-rpalethorpe@suse.com>
References: <20210517163029.22974-1-rpalethorpe@suse.com>
Message-ID: <20210517163029.22974-3-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 include/tst_sig_proc.h                         |  2 +-
 lib/tst_sig_proc.c                             |  2 +-
 libs/libltpsigwait/sigwait.c                   | 18 +++++++++---------
 .../clock_nanosleep/clock_nanosleep01.c        |  2 +-
 testcases/kernel/syscalls/ppoll/ppoll01.c      |  4 ++--
 testcases/kernel/syscalls/utils/mq_timed.h     |  2 +-
 6 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/include/tst_sig_proc.h b/include/tst_sig_proc.h
index b85981e77..39a201037 100644
--- a/include/tst_sig_proc.h
+++ b/include/tst_sig_proc.h
@@ -7,6 +7,6 @@
 
 #include <sys/types.h>
 
-pid_t create_sig_proc(int sig, int count, unsigned int usec);
+pid_t tst_create_sig_proc(int sig, int count, unsigned int usec);
 
 #endif	/* TST_SIG_PROC_H__ */
diff --git a/lib/tst_sig_proc.c b/lib/tst_sig_proc.c
index 509418af4..4826f9679 100644
--- a/lib/tst_sig_proc.c
+++ b/lib/tst_sig_proc.c
@@ -11,7 +11,7 @@
 #define TST_NO_DEFAULT_MAIN
 #include "tst_test.h"
 
-pid_t create_sig_proc(int sig, int count, unsigned int usec)
+pid_t tst_create_sig_proc(int sig, int count, unsigned int usec)
 {
 	pid_t pid, cpid;
 
diff --git a/libs/libltpsigwait/sigwait.c b/libs/libltpsigwait/sigwait.c
index 2be949929..aa8ef226d 100644
--- a/libs/libltpsigwait/sigwait.c
+++ b/libs/libltpsigwait/sigwait.c
@@ -19,7 +19,7 @@ void test_empty_set(swi_func sigwaitinfo, int signo,
 	SAFE_SIGEMPTYSET(&sigs);
 
 	/* Run a child that will wake us up */
-	child = create_sig_proc(signo, INT_MAX, 100000);
+	child = tst_create_sig_proc(signo, INT_MAX, 100000);
 
 	TEST(sigwaitinfo(&sigs, &si, NULL));
 	if (TST_RET == -1) {
@@ -49,7 +49,7 @@ void test_timeout(swi_func sigwaitinfo, int signo, enum tst_ts_type type)
 	SAFE_SIGEMPTYSET(&sigs);
 
 	/* Run a child that will wake us up */
-	child = create_sig_proc(signo, INT_MAX, 100000);
+	child = tst_create_sig_proc(signo, INT_MAX, 100000);
 
 	TEST(sigwaitinfo(&sigs, &si, tst_ts_get(&ts)));
 	if (TST_RET == -1) {
@@ -79,7 +79,7 @@ void test_unmasked_matching(swi_func sigwaitinfo, int signo,
 	SAFE_SIGADDSET(&sigs, signo);
 
 	/* Run a child that will wake us up */
-	child = create_sig_proc(signo, INT_MAX, 100000);
+	child = tst_create_sig_proc(signo, INT_MAX, 100000);
 
 	TEST(sigwaitinfo(&sigs, &si, NULL));
 	if (TST_RET == signo) {
@@ -106,7 +106,7 @@ void test_unmasked_matching_noinfo(swi_func sigwaitinfo, int signo,
 	SAFE_SIGADDSET(&sigs, signo);
 
 	/* Run a child that will wake us up */
-	child = create_sig_proc(signo, INT_MAX, 100000);
+	child = tst_create_sig_proc(signo, INT_MAX, 100000);
 
 	TEST(sigwaitinfo(&sigs, NULL, NULL));
 	if (TST_RET == signo)
@@ -139,7 +139,7 @@ void test_masked_matching(swi_func sigwaitinfo, int signo,
 	SAFE_SIGDELSET(&sigs, SIGCHLD);
 
 	/* Run a child that will wake us up */
-	child = create_sig_proc(signo, 1, 0);
+	child = tst_create_sig_proc(signo, 1, 0);
 
 	TEST(sigwaitinfo(&sigs, &si, NULL));
 	if (TST_RET == signo) {
@@ -191,8 +191,8 @@ void test_masked_matching_rt(swi_func sigwaitinfo, int signo,
 	SAFE_SIGDELSET(&sigs, SIGCHLD);
 
 	/* Run a child that will wake us up */
-	child[0] = create_sig_proc(signo, 1, 0);
-	child[1] = create_sig_proc(signo + 1, 1, 0);
+	child[0] = tst_create_sig_proc(signo, 1, 0);
+	child[1] = tst_create_sig_proc(signo + 1, 1, 0);
 
 	/* Ensure that the signals have been sent */
 	SAFE_WAITPID(child[0], &status, 0);
@@ -252,7 +252,7 @@ void test_masked_matching_noinfo(swi_func sigwaitinfo, int signo,
 	SAFE_SIGDELSET(&sigs, SIGCHLD);
 
 	/* Run a child that will wake us up */
-	child = create_sig_proc(signo, 1, 0);
+	child = tst_create_sig_proc(signo, 1, 0);
 
 	TEST(sigwaitinfo(&sigs, NULL, NULL));
 	if (TST_RET == signo)
@@ -294,7 +294,7 @@ void test_bad_address(swi_func sigwaitinfo, int signo,
 	SAFE_SIGDELSET(&sigs, SIGCHLD);
 
 	/* Run a child that will wake us up */
-	child = create_sig_proc(signo, 1, 0);
+	child = tst_create_sig_proc(signo, 1, 0);
 
 	TEST(sigwaitinfo(&sigs, (void *)1, NULL));
 	if (TST_RET == -1) {
diff --git a/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c b/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c
index 382497918..983dfe1ad 100644
--- a/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c
+++ b/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c
@@ -139,7 +139,7 @@ static void do_test(unsigned int i)
 	tst_res(TINFO, "case %s", tc->desc);
 
 	if (tc->ttype == SEND_SIGINT || tc->ttype == BAD_TS_ADDR_REM)
-		pid = create_sig_proc(SIGINT, 40, 500000);
+		pid = tst_create_sig_proc(SIGINT, 40, 500000);
 
 	tst_ts_set_sec(rq, tc->tv_sec);
 	tst_ts_set_nsec(rq, tc->tv_nsec);
diff --git a/testcases/kernel/syscalls/ppoll/ppoll01.c b/testcases/kernel/syscalls/ppoll/ppoll01.c
index 3d2f92f2a..3ea155445 100644
--- a/testcases/kernel/syscalls/ppoll/ppoll01.c
+++ b/testcases/kernel/syscalls/ppoll/ppoll01.c
@@ -251,8 +251,8 @@ static void do_test(unsigned int i)
 			tst_brk(TBROK, "sigprocmask");
 	}
 	if (tc->sigint_count > 0) {
-		pid = create_sig_proc(SIGINT, tc->sigint_count,
-			tc->sigint_delay);
+		pid = tst_create_sig_proc(SIGINT, tc->sigint_count,
+					  tc->sigint_delay);
 	}
 
 	/* test */
diff --git a/testcases/kernel/syscalls/utils/mq_timed.h b/testcases/kernel/syscalls/utils/mq_timed.h
index adf46034b..84831b548 100644
--- a/testcases/kernel/syscalls/utils/mq_timed.h
+++ b/testcases/kernel/syscalls/utils/mq_timed.h
@@ -45,7 +45,7 @@ static pid_t set_sig(struct tst_ts *ts,
 	gettime(CLOCK_REALTIME, tst_ts_get(ts));
 	*ts = tst_ts_add_us(*ts, 3000000);
 
-	return create_sig_proc(SIGINT, 40, 50000);
+	return tst_create_sig_proc(SIGINT, 40, 50000);
 }
 
 static void set_timeout(struct tst_ts *ts,
-- 
2.31.1

