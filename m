From: Li Wang <liwang@redhat.com>
Date: Wed, 25 Oct 2017 16:11:50 +0800
Subject: [LTP] [PATCH] ltp: keep the .tid hidden in the test library
Message-ID: <20171025081150.11206-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

And also fix some typos at the same time.

Signed-off-by: Li Wang <liwang@redhat.com>
---
 include/tst_safe_macros.h                                     | 2 +-
 include/tst_timer_test.h                                      | 1 -
 lib/tst_test.c                                                | 8 +++++---
 testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep02.c | 3 +--
 testcases/kernel/syscalls/epoll_wait/epoll_wait02.c           | 1 -
 testcases/kernel/syscalls/futex/futex_wait05.c                | 1 -
 testcases/kernel/syscalls/poll/poll02.c                       | 1 -
 testcases/kernel/syscalls/pselect/pselect01.c                 | 1 -
 testcases/kernel/syscalls/select/select04.c                   | 1 -
 9 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index 9562005..ed9c73c 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -406,7 +406,7 @@ static inline sighandler_t safe_signal(const char *file, const int lineno,
 #define SAFE_EXECL(file, arg, ...) do {				\
        execl((file), (arg), ##__VA_ARGS__);			\
        tst_brk_(__FILE__, __LINE__, TBROK | TERRNO,		\
-                "execlp(%s, %s, ...) failed", file, arg); 	\
+                "execl(%s, %s, ...) failed", file, arg); 	\
        } while (0)
 
 int safe_getpriority(const char *file, const int lineno, int which, id_t who);
diff --git a/include/tst_timer_test.h b/include/tst_timer_test.h
index 59931d3..c22159a 100644
--- a/include/tst_timer_test.h
+++ b/include/tst_timer_test.h
@@ -37,7 +37,6 @@
     }
 
     struct tst_test test = {
-	.tid = "syscall_name()",
 	.sample = sample,
     };
 
diff --git a/lib/tst_test.c b/lib/tst_test.c
index f8b3fb4..5b3f9c1 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -688,11 +688,13 @@ static void do_setup(int argc, char *argv[])
 
 	assert_test_fn();
 
-	if (tst_test->sample)
-		tst_test = tst_timer_test_setup(tst_test);
-
 	if (!tst_test->tid)
 		tst_test->tid = get_tid(argv);
+	else
+		tst_brk(TBROK, "The .tid field should not be set in the tests");
+
+	if (tst_test->sample)
+		tst_test = tst_timer_test_setup(tst_test);
 
 	parse_opts(argc, argv);
 
diff --git a/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep02.c b/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep02.c
index f114013..0efaf23 100644
--- a/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep02.c
+++ b/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep02.c
@@ -36,7 +36,7 @@ int sample_fn(int clk_id, long long usec)
 
 	if (TEST_RETURN != 0) {
 		tst_res(TFAIL | TERRNO,
-			"nanosleep() returned %li", TEST_RETURN);
+			"clock_nanosleep() returned %li", TEST_RETURN);
 		return 1;
 	}
 
@@ -44,6 +44,5 @@ int sample_fn(int clk_id, long long usec)
 }
 
 static struct tst_test test = {
-	.tid = "nanosleep()",
 	.sample = sample_fn,
 };
diff --git a/testcases/kernel/syscalls/epoll_wait/epoll_wait02.c b/testcases/kernel/syscalls/epoll_wait/epoll_wait02.c
index aa1bd0d..9ffe9bd 100644
--- a/testcases/kernel/syscalls/epoll_wait/epoll_wait02.c
+++ b/testcases/kernel/syscalls/epoll_wait/epoll_wait02.c
@@ -77,7 +77,6 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
-	.tid = "epoll_wait()",
 	.sample = sample_fn,
 	.setup = setup,
 	.cleanup = cleanup,
diff --git a/testcases/kernel/syscalls/futex/futex_wait05.c b/testcases/kernel/syscalls/futex/futex_wait05.c
index f6b0aa1..8459c3d 100644
--- a/testcases/kernel/syscalls/futex/futex_wait05.c
+++ b/testcases/kernel/syscalls/futex/futex_wait05.c
@@ -52,6 +52,5 @@ int sample_fn(int clk_id, long long usec)
 }
 
 static struct tst_test test = {
-	.tid = "futex_wait()",
 	.sample = sample_fn,
 };
diff --git a/testcases/kernel/syscalls/poll/poll02.c b/testcases/kernel/syscalls/poll/poll02.c
index 0aa228c..71d7369 100644
--- a/testcases/kernel/syscalls/poll/poll02.c
+++ b/testcases/kernel/syscalls/poll/poll02.c
@@ -64,7 +64,6 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
-	.tid = "poll()",
 	.sample = sample_fn,
 	.setup = setup,
 	.cleanup = cleanup,
diff --git a/testcases/kernel/syscalls/pselect/pselect01.c b/testcases/kernel/syscalls/pselect/pselect01.c
index a2b5339..fc55bf2 100644
--- a/testcases/kernel/syscalls/pselect/pselect01.c
+++ b/testcases/kernel/syscalls/pselect/pselect01.c
@@ -44,6 +44,5 @@ int sample_fn(int clk_id, long long usec)
 }
 
 static struct tst_test test = {
-	.tid = "pselect()",
 	.sample = sample_fn,
 };
diff --git a/testcases/kernel/syscalls/select/select04.c b/testcases/kernel/syscalls/select/select04.c
index 1431785..46ad934 100644
--- a/testcases/kernel/syscalls/select/select04.c
+++ b/testcases/kernel/syscalls/select/select04.c
@@ -66,7 +66,6 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
-	.tid = "select()",
 	.sample = sample_fn,
 	.setup = setup,
 	.cleanup = cleanup,
-- 
2.9.3

