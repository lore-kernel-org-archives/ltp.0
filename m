From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Mon, 20 Aug 2018 08:42:53 +0200
Subject: [LTP] [PATCH 1/5] Convert nanosleep02 to newlib
In-Reply-To: <20180820064257.17974-1-rpalethorpe@suse.com>
References: <20180820064257.17974-1-rpalethorpe@suse.com>
Message-ID: <20180820064257.17974-2-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Also add extra check that nanosleep exited with the expected return value and
errno for the user's information.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 .../kernel/syscalls/nanosleep/nanosleep02.c   | 123 ++++++------------
 1 file changed, 40 insertions(+), 83 deletions(-)

diff --git a/testcases/kernel/syscalls/nanosleep/nanosleep02.c b/testcases/kernel/syscalls/nanosleep/nanosleep02.c
index 42c825190..2abe38a95 100644
--- a/testcases/kernel/syscalls/nanosleep/nanosleep02.c
+++ b/testcases/kernel/syscalls/nanosleep/nanosleep02.c
@@ -26,24 +26,10 @@
  */
 
 #include <errno.h>
-#include <unistd.h>
-#include <fcntl.h>
-#include <signal.h>
-#include <time.h>
-#include <sys/wait.h>
-#include <sys/time.h>
-#include <stdint.h>
-#include <inttypes.h>
 
-#include "test.h"
-#include "safe_macros.h"
-
-char *TCID = "nanosleep02";
-int TST_TOTAL = 1;
-
-static void do_child(void);
-static void setup(void);
-static void sig_handler();
+#include "tst_test.h"
+#include "tst_timer.h"
+#include "tst_safe_macros.h"
 
 /*
  * Define here the "rem" precision in microseconds,
@@ -57,50 +43,6 @@ static void sig_handler();
  */
 #define USEC_PRECISION 250000	/* Error margin allowed in usec */
 
-int main(int ac, char **av)
-{
-	int lc;
-	pid_t cpid;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-#ifdef UCLINUX
-	maybe_run_child(&do_child, "");
-#endif
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-
-		if ((cpid = FORK_OR_VFORK()) == -1) {
-			tst_brkm(TBROK, NULL,
-				 "fork() failed to create child process");
-		}
-
-		if (cpid == 0) {
-#ifdef UCLINUX
-			if (self_exec(av[0], "")) {
-				tst_brkm(TBROK, NULL, "self_exec failed");
-			}
-#else
-			do_child();
-#endif
-		}
-
-		/* wait for child to time slot for execution */
-		sleep(1);
-
-		/* Now send signal to child */
-		SAFE_KILL(NULL, cpid, SIGINT);
-
-		tst_record_childstatus(NULL, cpid);
-	}
-
-	tst_exit();
-}
-
 static void do_child(void)
 {
 	struct timespec timereq = {.tv_sec = 5, .tv_nsec = 9999};
@@ -110,42 +52,57 @@ static void do_child(void)
 	TEST(nanosleep(&timereq, &timerem));
 	tst_timer_stop();
 
-	if (tst_timespec_lt(timereq, tst_timer_elapsed())) {
-		tst_resm(TFAIL, "nanosleep() slept more than timereq");
-		return;
-	}
+	if (!TST_RET)
+		tst_brk(TBROK, "nanosleep was not interrupted");
+	if (TST_ERR != EINTR)
+		tst_brk(TBROK | TTERRNO, "nanosleep() failed");
+
+	if (tst_timespec_lt(timereq, tst_timer_elapsed()))
+		tst_brk(TFAIL, "nanosleep() slept more than timereq");
 
 	exp_rem = tst_timespec_diff(timereq, tst_timer_elapsed());
 
 	if (tst_timespec_abs_diff_us(timerem, exp_rem) > USEC_PRECISION) {
-		tst_resm(TFAIL,
-		         "nanosleep() remaining time %llius, expected %llius, diff %llius",
-			 tst_timespec_to_us(timerem), tst_timespec_to_us(exp_rem),
-			 tst_timespec_abs_diff_us(timerem, exp_rem));
+		tst_res(TFAIL,
+			"nanosleep() remaining time %llius, expected %llius, diff %llius",
+			tst_timespec_to_us(timerem), tst_timespec_to_us(exp_rem),
+			tst_timespec_abs_diff_us(timerem, exp_rem));
 	} else {
-		tst_resm(TPASS,
-		         "nanosleep() slept for %llius, remaining time difference %llius",
-			 tst_timer_elapsed_us(),
-		         tst_timespec_abs_diff_us(timerem, exp_rem));
+		tst_res(TPASS,
+			"nanosleep() slept for %llius, remaining time difference %llius",
+			tst_timer_elapsed_us(),
+			tst_timespec_abs_diff_us(timerem, exp_rem));
 	}
-
-	tst_exit();
 }
 
-static void setup(void)
+void run(void)
 {
-	tst_sig(FORK, DEF_HANDLER, NULL);
+	pid_t cpid;
 
-	tst_timer_check(CLOCK_MONOTONIC);
+	cpid = SAFE_FORK();
+	if (cpid == 0) {
+		do_child();
+	} else {
+		sleep(1);
 
-	TEST_PAUSE;
+		SAFE_KILL(cpid, SIGINT);
 
-	if (signal(SIGINT, sig_handler) == SIG_ERR) {
-		tst_brkm(TBROK, NULL,
-			 "signal() fails to setup signal handler");
+		tst_reap_children();
 	}
 }
 
-static void sig_handler(void)
+static void sig_handler(int si LTP_ATTRIBUTE_UNUSED)
+{
+}
+
+static void setup(void)
 {
+	tst_timer_check(CLOCK_MONOTONIC);
+	SAFE_SIGNAL(SIGINT, sig_handler);
 }
+
+static struct tst_test test = {
+	.forks_child = 1,
+	.setup = setup,
+	.test_all = run,
+};
-- 
2.18.0

