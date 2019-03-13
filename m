From: Matthias Maennich <maennich@google.com>
Date: Wed, 13 Mar 2019 12:02:22 +0000
Subject: [LTP] [PATCH v2 2/2] sigpending/rt_sigpending: add basic test
In-Reply-To: <20190313120222.47673-1-maennich@google.com>
References: <20190308163832.212631-1-maennich@google.com>
 <20190313120222.47673-1-maennich@google.com>
Message-ID: <20190313120222.47673-3-maennich@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Test basic functionality of sigpending/rt_sigpending.

Signed-off-by: Matthias Maennich <maennich@google.com>
---
 .../kernel/syscalls/sigpending/sigpending02.c | 112 ++++++++++++++++--
 1 file changed, 102 insertions(+), 10 deletions(-)

diff --git a/testcases/kernel/syscalls/sigpending/sigpending02.c b/testcases/kernel/syscalls/sigpending/sigpending02.c
index cc50870b107a..e75c6aa69c4c 100644
--- a/testcases/kernel/syscalls/sigpending/sigpending02.c
+++ b/testcases/kernel/syscalls/sigpending/sigpending02.c
@@ -4,14 +4,18 @@
  *
  * AUTHORS
  *	Paul Larson
+ *	Matthias Maennich
  *
  * DESCRIPTION
- *	Test to see that the proper errors are returned by sigpending. All the
- *	tests can also be compiled to use the rt_sigpending syscall instead. To
- *	simplify the documentation, only sigpending() is usually mentioned
- *	below.
+ *	Test to assert basic functionality of sigpending. All the tests can also be
+ *	compiled to use the rt_sigpending syscall instead. To simplify the
+ *	documentation, only sigpending() is usually mentioned below.
  *
  *	Test 1:
+ *		Suppress handling SIGUSR1 and SIGUSR1, raise them and assert their
+ *		signal pending.
+ *
+ *	Test 2:
  *		Call sigpending(sigset_t*=-1), it should return -1 with errno EFAULT
  */
 
@@ -23,19 +27,101 @@
 #include "ltp_signal.h"
 #include "lapi/syscalls.h"
 
-static void run(void)
-{
-	/* set sigset to point to an invalid location */
-	sigset_t *sigset = (sigset_t *) - 1;
+#define min(x, y) (((x) < (y)) ? (x) : (y))
 
 #if defined(TEST_SIGPENDING)
-	TEST(tst_syscall(__NR_sigpending, sigset));
+#define tested_sigpending(sigset) TEST(tst_syscall(__NR_sigpending, sigset))
 #elif defined(TEST_RT_SIGPENDING)
-	TEST(tst_syscall(__NR_rt_sigpending, sigset, SIGSETSIZE));
+#define tested_sigpending(sigset)                                              \
+	TEST(tst_syscall(__NR_rt_sigpending, sigset, SIGSETSIZE))
 #else
 #error Neither TEST_SIGPENDING nor TEST_RT_SIGPENDING is defined!
 #endif
 
+static int sighandler_counter = 0;
+static void sighandler(int signum)
+{
+	(void)signum;
+	++sighandler_counter;
+}
+
+static void test_sigpending(void)
+{
+	int SIGMAX = min(sizeof(sigset_t) * 8, _NSIG);
+
+	// set up signal mask and handler
+	sigset_t only_SIGUSR, old_mask;
+	sighandler_t old_sighandler1, old_sighandler2;
+	sigemptyset(&only_SIGUSR);
+	sigaddset(&only_SIGUSR, SIGUSR1);
+	sigaddset(&only_SIGUSR, SIGUSR2);
+	if (sigprocmask(SIG_SETMASK, &only_SIGUSR, &old_mask))
+		tst_brk(TBROK, "sigprocmask failed");
+	old_sighandler1 = SAFE_SIGNAL(SIGUSR1, sighandler);
+	old_sighandler2 = SAFE_SIGNAL(SIGUSR2, sighandler);
+
+	// Initially no signal should be pending
+	sigset_t pending;
+	sigemptyset(&pending);
+	tested_sigpending(&pending);
+
+	for (int i = 1; i < SIGMAX; ++i)
+		if (sigismember(&pending, i))
+			tst_brk(TFAIL,
+				"initialization failed: no signal should be pending by now");
+
+	// raise a signal
+	if (raise(SIGUSR1))
+		tst_brk(TBROK, "raising SIGUSR1 failed");
+	if (sighandler_counter > 0)
+		tst_brk(TFAIL,
+			"signal handler is not (yet) supposed to be called");
+
+	// now we should have exactly one pending signal (SIGUSR1)
+	sigemptyset(&pending);
+	tested_sigpending(&pending);
+	for (int i = 1; i < SIGMAX; ++i)
+		if ((i == SIGUSR1) != sigismember(&pending, i))
+			tst_brk(TFAIL, "only SIGUSR1 should be pending by now");
+
+	// raise another signal
+	if (raise(SIGUSR2))
+		tst_brk(TBROK, "raising SIGUSR2 failed");
+	if (sighandler_counter > 0)
+		tst_brk(TFAIL,
+			"signal handler is not (yet) supposed to be called");
+
+	// now we should have exactly two pending signals (SIGUSR1, SIGUSR2)
+	sigemptyset(&pending);
+	tested_sigpending(&pending);
+	for (int i = 1; i < SIGMAX; ++i)
+		if ((i == SIGUSR1 || i == SIGUSR2) != sigismember(&pending, i))
+			tst_brk(TFAIL,
+				"only SIGUSR1, SIGUSR2 should be pending by now");
+
+	tst_res(TPASS, "basic sigpending test successful");
+
+	// reinstate old mask
+	if (sigprocmask(SIG_SETMASK, &old_mask, NULL))
+		tst_brk(TBROK, "sigprocmask failed");
+
+	//@this time the signal handler has been called, once for each signal
+	if (sighandler_counter != 2)
+		tst_brk(TFAIL,
+			"signal handler has not been called for each signal");
+
+	// reinstate the original signal handlers
+	SAFE_SIGNAL(SIGUSR1, old_sighandler1);
+	SAFE_SIGNAL(SIGUSR2, old_sighandler2);
+}
+
+static void test_efault_on_invalid_sigset(void)
+{
+	/* set sigset to point to an invalid location */
+	sigset_t *sigset = (sigset_t *)-1;
+
+	tested_sigpending(sigset);
+
 	/* check return code */
 	if (TST_RET == -1) {
 		if (TST_ERR != EFAULT) {
@@ -51,6 +137,12 @@ static void run(void)
 	}
 }
 
+static void run(void)
+{
+	test_sigpending();
+	test_efault_on_invalid_sigset();
+}
+
 static struct tst_test test = {
 	.test_all = run
 };
-- 
2.21.0.360.g471c308f928-goog

