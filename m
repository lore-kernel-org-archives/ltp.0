From: Jan Stancek <jstancek@redhat.com>
Date: Tue,  5 Nov 2019 12:57:52 +0100
Subject: [LTP] [PATCH/RFC] tst_process_state_wait: wait for schedstats to
 settle when state == S
Message-ID: <48e9d0f8ed25dd69dc97fe31c4446a30cd990b06.1572954996.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

There can be a gap between task state update and process being scheduled
off from runqueue. For example futex_wait_queue_me() updates task state
before it queues the futex:

  static void futex_wait_queue_me(struct futex_hash_bucket *hb, struct futex_q *q,
				  struct hrtimer_sleeper *timeout)
  {
	  /*
	   * The task state is guaranteed to be set before another task can
	   * wake it. set_current_state() is implemented using smp_store_mb() and
	   * queue_me() calls spin_unlock() upon completion, both serializing
	   * access to the hash list and forcing another memory barrier.
	   */
	  set_current_state(TASK_INTERRUPTIBLE);
	  queue_me(q, hb);

This can lead to test assuming, that child process is already queued on
futex and try to requeue futexes early (example below is modified to use
2 children: 1 wake, 1 requeue):
  futex_cmp_requeue01.c:107: FAIL: futex_cmp_requeue() requeues 0 waiters, expected 1

In addition to tst_process_state_wait() waiting on 'S' state, also wait
for /proc/pid/schedstats' sum_exec_runtime and run_delay to settle:
  1) time spent on the cpu
  2) time spent waiting on a runqueue

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 lib/tst_process_state.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 53 insertions(+), 2 deletions(-)

diff --git a/lib/tst_process_state.c b/lib/tst_process_state.c
index 7a7824959d72..a24b49092ef2 100644
--- a/lib/tst_process_state.c
+++ b/lib/tst_process_state.c
@@ -28,6 +28,51 @@
 #include "test.h"
 #include "tst_process_state.h"
 
+#define SETTLE_SLEEP_US 20000 
+#define MAX_SETTLE_SLEEP_US (5 * SETTLE_SLEEP_US)
+
+/*
+ * When schedstats settle we have more confidence process ('S') has
+ * been scheduled off from runqueue.
+ */
+static void schedstat_settle(const char *file, const int lineno, pid_t pid)
+{
+	char ss_path[128];
+	int sleep = 0;
+
+	snprintf(ss_path, sizeof(ss_path), "/proc/%i/schedstat", pid);
+	if (access(ss_path, F_OK)) {
+		/* CONFIG_SCHED_INFO is likely disabled */
+		usleep(MAX_SETTLE_SLEEP_US);
+		return;
+	}
+
+	for (;;) {
+		unsigned long long sum_exec, run_delay, sum_exec2, run_delay2;
+		int ret = 0;
+
+		ret |= file_scanf(file, lineno, ss_path, "%llu %llu",
+			&sum_exec, &run_delay);
+		usleep(SETTLE_SLEEP_US);
+		sleep += SETTLE_SLEEP_US;
+		ret |= file_scanf(file, lineno, ss_path, "%llu %llu",
+			&sum_exec2, &run_delay2);
+
+		if (ret) {
+			tst_resm(TWARN, "Error parsing %s", ss_path);
+			return;
+		}
+
+		if (sum_exec == sum_exec2 && run_delay == run_delay2)
+			return;
+
+		if (sleep >= MAX_SETTLE_SLEEP_US) {
+			tst_resm(TWARN, "MAX_SETTLE_SLEEP_US reached");
+			return;
+		}
+	}
+}
+
 void tst_process_state_wait(const char *file, const int lineno,
                             void (*cleanup_fn)(void),
                             pid_t pid, const char state)
@@ -40,8 +85,11 @@ void tst_process_state_wait(const char *file, const int lineno,
 		safe_file_scanf(file, lineno, cleanup_fn, proc_path,
 		                "%*i %*s %c", &cur_state);
 
-		if (state == cur_state)
+		if (state == cur_state) {
+			if (state == 'S')
+				schedstat_settle(file, lineno, pid);
 			return;
+		}
 
 		usleep(10000);
 	}
@@ -69,8 +117,11 @@ int tst_process_state_wait2(pid_t pid, const char state)
 		}
 		fclose(f);
 
-		if (state == cur_state)
+		if (state == cur_state) {
+			if (state == 'S')
+				schedstat_settle(__FILE__, __LINE__, pid);
 			return 0;
+		}
 
 		usleep(10000);
 	}
-- 
1.8.3.1

