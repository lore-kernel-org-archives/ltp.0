From: Li Wang <liwang@redhat.com>
Date: Wed,  1 Nov 2017 13:15:23 +0800
Subject: [LTP] [PATCH v3 2/2] lib: keep the test id hidden in LTP library
Message-ID: <20171101051523.373-2-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

To avoid introducing wrong tid's typos radically, this patch keep the tid
hidden in library by moving out '.tid' variable from the test struct.

Meanwhile, adding a newly string '.scall' to support LTP can get the correct
syscall name for timer management library.

Signed-off-by: Li Wang <liwang@redhat.com>
---
 include/tst_test.h                                          |  5 +++--
 include/tst_timer_test.h                                    |  2 +-
 lib/tst_test.c                                              | 13 +++++++------
 lib/tst_timer_test.c                                        |  4 ++--
 .../kernel/controllers/memcg/regression/memcg_test_3.c      |  1 -
 testcases/kernel/mem/ksm/ksm06.c                            |  1 -
 testcases/kernel/mem/tunable/max_map_count.c                |  1 -
 .../kernel/syscalls/clock_nanosleep/clock_nanosleep02.c     |  2 +-
 testcases/kernel/syscalls/epoll_wait/epoll_wait02.c         |  2 +-
 testcases/kernel/syscalls/futex/futex_wait05.c              |  2 +-
 testcases/kernel/syscalls/nanosleep/nanosleep01.c           |  2 +-
 testcases/kernel/syscalls/poll/poll02.c                     |  2 +-
 testcases/kernel/syscalls/pselect/pselect01.c               |  2 +-
 testcases/kernel/syscalls/select/select04.c                 |  2 +-
 testcases/lib/tst_device.c                                  |  1 -
 15 files changed, 20 insertions(+), 22 deletions(-)

diff --git a/include/tst_test.h b/include/tst_test.h
index f9872d9..9b940d6 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -105,8 +105,6 @@ int tst_parse_long(const char *str, long *val, long min, long max);
 int tst_parse_float(const char *str, float *val, float min, float max);
 
 struct tst_test {
-	/* test id usually the same as test filename without file suffix */
-	const char *tid;
 	/* number of tests available in test() function */
 	unsigned int tcnt;
 
@@ -150,6 +148,9 @@ struct tst_test {
 	void (*test)(unsigned int test_nr);
 	void (*test_all)(void);
 
+	/* Syscall name will pass to timer measurement library*/
+	const char *scall;
+
 	/* Sampling function for timer measurement testcases */
 	int (*sample)(int clk_id, long long usec);
 
diff --git a/include/tst_timer_test.h b/include/tst_timer_test.h
index 59931d3..23fc0ba 100644
--- a/include/tst_timer_test.h
+++ b/include/tst_timer_test.h
@@ -37,7 +37,7 @@
     }
 
     struct tst_test test = {
-	.tid = "syscall_name()",
+	.scall = "syscall_name()",
 	.sample = sample,
     };
 
diff --git a/lib/tst_test.c b/lib/tst_test.c
index f8b3fb4..1b9f80c 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -41,6 +41,7 @@
 
 struct tst_test *tst_test;
 
+static char *tid = NULL;
 static int iterations = 1;
 static float duration = -1;
 static pid_t main_pid, lib_pid;
@@ -77,7 +78,7 @@ static void setup_ipc(void)
 
 	if (access("/dev/shm", F_OK) == 0) {
 		snprintf(shm_path, sizeof(shm_path), "/dev/shm/ltp_%s_%d",
-		         tst_test->tid, getpid());
+		         tid, getpid());
 	} else {
 		char *tmpdir;
 
@@ -86,7 +87,7 @@ static void setup_ipc(void)
 
 		tmpdir = tst_get_tmpdir();
 		snprintf(shm_path, sizeof(shm_path), "%s/ltp_%s_%d",
-		         tmpdir, tst_test->tid, getpid());
+		         tmpdir, tid, getpid());
 		free(tmpdir);
 	}
 
@@ -688,12 +689,12 @@ static void do_setup(int argc, char *argv[])
 
 	assert_test_fn();
 
+	if (!tid)
+		tid = get_tid(argv);
+
 	if (tst_test->sample)
 		tst_test = tst_timer_test_setup(tst_test);
 
-	if (!tst_test->tid)
-		tst_test->tid = get_tid(argv);
-
 	parse_opts(argc, argv);
 
 	if (tst_test->needs_root && geteuid() != 0)
@@ -972,7 +973,7 @@ void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
 
 	do_setup(argc, argv);
 
-	TCID = tst_test->tid;
+	TCID = tid;
 
 	SAFE_SIGNAL(SIGALRM, alarm_handler);
 	SAFE_SIGNAL(SIGUSR1, heartbeat_handler);
diff --git a/lib/tst_timer_test.c b/lib/tst_timer_test.c
index cd4ebca..2aa2792 100644
--- a/lib/tst_timer_test.c
+++ b/lib/tst_timer_test.c
@@ -459,10 +459,10 @@ struct tst_test *tst_timer_test_setup(struct tst_test *timer_test)
 {
 	setup = timer_test->setup;
 	cleanup = timer_test->cleanup;
-	scall = timer_test->tid;
+	scall = timer_test->scall;
 	sample = timer_test->sample;
 
-	timer_test->tid = NULL;
+	timer_test->scall = NULL;
 	timer_test->setup = timer_setup;
 	timer_test->cleanup = timer_cleanup;
 	timer_test->test = timer_test_fn;
diff --git a/testcases/kernel/controllers/memcg/regression/memcg_test_3.c b/testcases/kernel/controllers/memcg/regression/memcg_test_3.c
index 994d87b..3b25f84 100644
--- a/testcases/kernel/controllers/memcg/regression/memcg_test_3.c
+++ b/testcases/kernel/controllers/memcg/regression/memcg_test_3.c
@@ -112,7 +112,6 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
-	.tid = "memcg_test_3",
 	.needs_root = 1,
 	.needs_tmpdir = 1,
 	.forks_child = 1,
diff --git a/testcases/kernel/mem/ksm/ksm06.c b/testcases/kernel/mem/ksm/ksm06.c
index 334a048..4272a42 100644
--- a/testcases/kernel/mem/ksm/ksm06.c
+++ b/testcases/kernel/mem/ksm/ksm06.c
@@ -97,7 +97,6 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
-	.tid = "ksm06",
 	.needs_root = 1,
 	.options = ksm_options,
 	.setup = setup,
diff --git a/testcases/kernel/mem/tunable/max_map_count.c b/testcases/kernel/mem/tunable/max_map_count.c
index e47543d..93a764d 100644
--- a/testcases/kernel/mem/tunable/max_map_count.c
+++ b/testcases/kernel/mem/tunable/max_map_count.c
@@ -208,7 +208,6 @@ static void max_map_count_test(void)
 }
 
 static struct tst_test test = {
-	.tid = "max_map_count",
 	.needs_root = 1,
 	.forks_child = 1,
 	.setup = setup,
diff --git a/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep02.c b/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep02.c
index f114013..9b0b243 100644
--- a/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep02.c
+++ b/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep02.c
@@ -44,6 +44,6 @@ int sample_fn(int clk_id, long long usec)
 }
 
 static struct tst_test test = {
-	.tid = "nanosleep()",
+	.scall = "clock_nanosleep()",
 	.sample = sample_fn,
 };
diff --git a/testcases/kernel/syscalls/epoll_wait/epoll_wait02.c b/testcases/kernel/syscalls/epoll_wait/epoll_wait02.c
index aa1bd0d..70cddb9 100644
--- a/testcases/kernel/syscalls/epoll_wait/epoll_wait02.c
+++ b/testcases/kernel/syscalls/epoll_wait/epoll_wait02.c
@@ -77,7 +77,7 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
-	.tid = "epoll_wait()",
+	.scall = "epoll_wait()",
 	.sample = sample_fn,
 	.setup = setup,
 	.cleanup = cleanup,
diff --git a/testcases/kernel/syscalls/futex/futex_wait05.c b/testcases/kernel/syscalls/futex/futex_wait05.c
index f6b0aa1..066944f 100644
--- a/testcases/kernel/syscalls/futex/futex_wait05.c
+++ b/testcases/kernel/syscalls/futex/futex_wait05.c
@@ -52,6 +52,6 @@ int sample_fn(int clk_id, long long usec)
 }
 
 static struct tst_test test = {
-	.tid = "futex_wait()",
+	.scall = "futex_wait()",
 	.sample = sample_fn,
 };
diff --git a/testcases/kernel/syscalls/nanosleep/nanosleep01.c b/testcases/kernel/syscalls/nanosleep/nanosleep01.c
index 6d90a60..bcec1f8 100644
--- a/testcases/kernel/syscalls/nanosleep/nanosleep01.c
+++ b/testcases/kernel/syscalls/nanosleep/nanosleep01.c
@@ -47,6 +47,6 @@ int sample_fn(int clk_id, long long usec)
 }
 
 static struct tst_test test = {
-	.tid = "nanosleep()",
+	.scall = "nanosleep()",
 	.sample = sample_fn,
 };
diff --git a/testcases/kernel/syscalls/poll/poll02.c b/testcases/kernel/syscalls/poll/poll02.c
index 0aa228c..b85df29 100644
--- a/testcases/kernel/syscalls/poll/poll02.c
+++ b/testcases/kernel/syscalls/poll/poll02.c
@@ -64,7 +64,7 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
-	.tid = "poll()",
+	.scall = "poll()",
 	.sample = sample_fn,
 	.setup = setup,
 	.cleanup = cleanup,
diff --git a/testcases/kernel/syscalls/pselect/pselect01.c b/testcases/kernel/syscalls/pselect/pselect01.c
index a2b5339..1392689 100644
--- a/testcases/kernel/syscalls/pselect/pselect01.c
+++ b/testcases/kernel/syscalls/pselect/pselect01.c
@@ -44,6 +44,6 @@ int sample_fn(int clk_id, long long usec)
 }
 
 static struct tst_test test = {
-	.tid = "pselect()",
+	.scall = "pselect()",
 	.sample = sample_fn,
 };
diff --git a/testcases/kernel/syscalls/select/select04.c b/testcases/kernel/syscalls/select/select04.c
index 1431785..4ca7a31 100644
--- a/testcases/kernel/syscalls/select/select04.c
+++ b/testcases/kernel/syscalls/select/select04.c
@@ -66,7 +66,7 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
-	.tid = "select()",
+	.scall = "select()",
 	.sample = sample_fn,
 	.setup = setup,
 	.cleanup = cleanup,
diff --git a/testcases/lib/tst_device.c b/testcases/lib/tst_device.c
index d33cac6..1640662 100644
--- a/testcases/lib/tst_device.c
+++ b/testcases/lib/tst_device.c
@@ -27,7 +27,6 @@
 extern struct tst_test *tst_test;
 
 static struct tst_test test = {
-	.tid = "tst_device"
 };
 
 static void print_help(void)
-- 
2.9.3

