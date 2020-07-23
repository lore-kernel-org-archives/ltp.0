From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Thu, 23 Jul 2020 19:12:07 +0530
Subject: [LTP] [PATCH 3/4] libs: sigwait: Remove alarm() from setup() and
 cleanup()
In-Reply-To: <e51142a397858a2fe6a040563d3c0795a7d0bb05.1595511710.git.viresh.kumar@linaro.org>
References: <e51142a397858a2fe6a040563d3c0795a7d0bb05.1595511710.git.viresh.kumar@linaro.org>
Message-ID: <d9c84f9453350ff1b844c0951624d508ef62e4dd.1595511710.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

These aren't required anymore as the new library maintains timeouts
properly. While at it, remove sigwait_cleanup() as well.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 include/libsigwait.h                                          | 1 -
 libs/libltpsigwait/sigwait.c                                  | 7 -------
 testcases/kernel/syscalls/rt_sigtimedwait/rt_sigtimedwait01.c | 1 -
 testcases/kernel/syscalls/sigtimedwait/sigtimedwait01.c       | 1 -
 testcases/kernel/syscalls/sigwait/sigwait01.c                 | 1 -
 testcases/kernel/syscalls/sigwaitinfo/sigwaitinfo01.c         | 1 -
 6 files changed, 12 deletions(-)

diff --git a/include/libsigwait.h b/include/libsigwait.h
index 7202fc78fde8..2fca578b19ac 100644
--- a/include/libsigwait.h
+++ b/include/libsigwait.h
@@ -41,5 +41,4 @@ void test_bad_address2(swi_func sigwaitinfo, int signo LTP_ATTRIBUTE_UNUSED,
 void test_bad_address3(swi_func sigwaitinfo, int signo LTP_ATTRIBUTE_UNUSED,
 		       enum tst_ts_type type LTP_ATTRIBUTE_UNUSED);
 void sigwait_setup(void);
-void sigwait_cleanup(void);
 #endif /* SIGWAIT_H__ */
diff --git a/libs/libltpsigwait/sigwait.c b/libs/libltpsigwait/sigwait.c
index 0a658625a984..dbd33a61f2b1 100644
--- a/libs/libltpsigwait/sigwait.c
+++ b/libs/libltpsigwait/sigwait.c
@@ -358,11 +358,4 @@ void sigwait_setup(void)
 	signal(SIGUSR1, empty_handler);
 	signal(SIGALRM, empty_handler);
 	signal(SIGUSR2, SIG_IGN);
-
-	alarm(10);	/* arrange a 10 second timeout */
-}
-
-void sigwait_cleanup(void)
-{
-	alarm(0);
 }
diff --git a/testcases/kernel/syscalls/rt_sigtimedwait/rt_sigtimedwait01.c b/testcases/kernel/syscalls/rt_sigtimedwait/rt_sigtimedwait01.c
index 8b6153744938..db4901a40ea1 100644
--- a/testcases/kernel/syscalls/rt_sigtimedwait/rt_sigtimedwait01.c
+++ b/testcases/kernel/syscalls/rt_sigtimedwait/rt_sigtimedwait01.c
@@ -73,6 +73,5 @@ static struct tst_test test = {
 	.tcnt = ARRAY_SIZE(tests),
 	.test_variants = ARRAY_SIZE(variants),
 	.setup = setup,
-	.cleanup = sigwait_cleanup,
 	.forks_child = 1,
 };
diff --git a/testcases/kernel/syscalls/sigtimedwait/sigtimedwait01.c b/testcases/kernel/syscalls/sigtimedwait/sigtimedwait01.c
index 946d8e7239a0..fa36c455fb6d 100644
--- a/testcases/kernel/syscalls/sigtimedwait/sigtimedwait01.c
+++ b/testcases/kernel/syscalls/sigtimedwait/sigtimedwait01.c
@@ -32,6 +32,5 @@ static struct tst_test test = {
 	.test= run,
 	.tcnt = ARRAY_SIZE(tests),
 	.setup = sigwait_setup,
-	.cleanup = sigwait_cleanup,
 	.forks_child = 1,
 };
diff --git a/testcases/kernel/syscalls/sigwait/sigwait01.c b/testcases/kernel/syscalls/sigwait/sigwait01.c
index 563d15635fd9..92544c141e85 100644
--- a/testcases/kernel/syscalls/sigwait/sigwait01.c
+++ b/testcases/kernel/syscalls/sigwait/sigwait01.c
@@ -32,6 +32,5 @@ static struct tst_test test = {
 	.test= run,
 	.tcnt = ARRAY_SIZE(tests),
 	.setup = sigwait_setup,
-	.cleanup = sigwait_cleanup,
 	.forks_child = 1,
 };
diff --git a/testcases/kernel/syscalls/sigwaitinfo/sigwaitinfo01.c b/testcases/kernel/syscalls/sigwaitinfo/sigwaitinfo01.c
index 6563d14f0ec7..f7d90047f8a2 100644
--- a/testcases/kernel/syscalls/sigwaitinfo/sigwaitinfo01.c
+++ b/testcases/kernel/syscalls/sigwaitinfo/sigwaitinfo01.c
@@ -30,6 +30,5 @@ static struct tst_test test = {
 	.test= run,
 	.tcnt = ARRAY_SIZE(tests),
 	.setup = sigwait_setup,
-	.cleanup = sigwait_cleanup,
 	.forks_child = 1,
 };
-- 
2.14.1

