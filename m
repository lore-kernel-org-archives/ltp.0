From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Mon, 13 Aug 2018 15:59:08 +0200
Subject: [LTP] [PATCH v2 4/4] fzsync: Limit execution time to prevent test
	timeouts
In-Reply-To: <20180813135908.30752-1-rpalethorpe@suse.com>
References: <20180813135908.30752-1-rpalethorpe@suse.com>
Message-ID: <20180813135908.30752-4-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Use the tst_timer library to check how long the main test loop has been
running for and break the loop if it exceeds 60 seconds. This prevents an
overall test timeout which is reported as a failure.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 include/tst_fuzzy_sync.h                      | 47 ++++++++++++-------
 lib/newlib_tests/test16.c                     |  3 +-
 testcases/cve/cve-2014-0196.c                 |  3 +-
 testcases/cve/cve-2016-7117.c                 |  3 +-
 testcases/cve/cve-2017-2671.c                 |  3 +-
 testcases/kernel/syscalls/inotify/inotify09.c |  3 +-
 6 files changed, 41 insertions(+), 21 deletions(-)

diff --git a/include/tst_fuzzy_sync.h b/include/tst_fuzzy_sync.h
index bcc625e24..75866d73c 100644
--- a/include/tst_fuzzy_sync.h
+++ b/include/tst_fuzzy_sync.h
@@ -42,6 +42,7 @@
 #include <time.h>
 #include <math.h>
 #include "tst_atomic.h"
+#include "tst_timer.h"
 
 #ifndef CLOCK_MONOTONIC_RAW
 # define CLOCK_MONOTONIC_RAW CLOCK_MONOTONIC
@@ -265,9 +266,7 @@ static inline int tst_fzsync_pair_wait(struct tst_fzsync_pair *pair,
 			;
 	}
 
-	/* Only exit if we have done the same amount of work as the other thread */
-	return !tst_atomic_load(&pair->exit) ||
-	  tst_atomic_load(other_cntr) <= tst_atomic_load(our_cntr);
+	return !tst_atomic_load(&pair->exit);
 }
 
 static inline int tst_fzsync_wait_a(struct tst_fzsync_pair *pair)
@@ -280,6 +279,17 @@ static inline int tst_fzsync_wait_b(struct tst_fzsync_pair *pair)
 	return tst_fzsync_pair_wait(pair, &pair->b_cntr, &pair->a_cntr);
 }
 
+/**
+ * tst_fzsync_pair_exit - Signal that the other thread should exit
+ *
+ * Causes tst_fzsync_pair_wait() and tst_fzsync_pair_wait_update() to return
+ * 0.
+ */
+static inline void tst_fzsync_pair_exit(struct tst_fzsync_pair *pair)
+{
+	tst_atomic_store(1, &pair->exit);
+}
+
 /**
  * tst_fzsync_pair_wait_update_{a,b} - Wait and then recalculate
  *
@@ -301,10 +311,26 @@ static inline int tst_fzsync_wait_b(struct tst_fzsync_pair *pair)
 static inline int tst_fzsync_wait_update_a(struct tst_fzsync_pair *pair)
 {
 	static int loop_index;
+	int timer_state = tst_timer_state_ms(60000);
+	int exit = 0;
+
+	if (!(timer_state & TST_TIMER_STARTED)) {
+		tst_timer_start(CLOCK_MONOTONIC_RAW);
+	} else if (timer_state & TST_TIMER_EXPIRED) {
+		tst_res(TINFO,
+			"Exceeded fuzzy sync time limit, requesting exit");
+		exit = 1;
+	}
 
 	tst_fzsync_pair_wait(pair, &pair->a_cntr, &pair->b_cntr);
-	loop_index++;
-	tst_fzsync_pair_update(loop_index, pair);
+
+	if (exit) {
+		tst_fzsync_pair_exit(pair);
+	} else {
+		loop_index++;
+		tst_fzsync_pair_update(loop_index, pair);
+	}
+
 	return tst_fzsync_pair_wait(pair, &pair->a_cntr, &pair->b_cntr);
 }
 
@@ -313,14 +339,3 @@ static inline int tst_fzsync_wait_update_b(struct tst_fzsync_pair *pair)
 	tst_fzsync_pair_wait(pair, &pair->b_cntr, &pair->a_cntr);
 	return tst_fzsync_pair_wait(pair, &pair->b_cntr, &pair->a_cntr);
 }
-
-/**
- * tst_fzsync_pair_exit - Signal that the other thread should exit
- *
- * Causes tst_fzsync_pair_wait() and tst_fzsync_pair_wait_update() to return
- * 0.
- */
-static inline void tst_fzsync_pair_exit(struct tst_fzsync_pair *pair)
-{
-	tst_atomic_store(1, &pair->exit);
-}
diff --git a/lib/newlib_tests/test16.c b/lib/newlib_tests/test16.c
index d80bd5369..bb3d86e2d 100644
--- a/lib/newlib_tests/test16.c
+++ b/lib/newlib_tests/test16.c
@@ -65,7 +65,8 @@ static void run(void)
 	unsigned int i, j, fail = 0;
 
 	for (i = 0; i < LOOPS; i++) {
-		tst_fzsync_wait_update_a(&pair);
+		if (!tst_fzsync_wait_update_a(&pair))
+			break;
 		tst_fzsync_delay_a(&pair);
 		seq[seq_n] = 'A';
 		seq_n = i * 2 + 1;
diff --git a/testcases/cve/cve-2014-0196.c b/testcases/cve/cve-2014-0196.c
index d18108897..8d15909b7 100644
--- a/testcases/cve/cve-2014-0196.c
+++ b/testcases/cve/cve-2014-0196.c
@@ -118,7 +118,8 @@ static void run(void)
 		t.c_lflag |= ECHO;
 		tcsetattr(master_fd, TCSANOW, &t);
 
-		tst_fzsync_wait_update_a(&fzsync_pair);
+		if (!tst_fzsync_wait_update_a(&fzsync_pair))
+			break;
 
 		tst_fzsync_delay_a(&fzsync_pair);
 		tst_fzsync_time_a(&fzsync_pair);
diff --git a/testcases/cve/cve-2016-7117.c b/testcases/cve/cve-2016-7117.c
index 3cb7efcdf..d68f62ecc 100644
--- a/testcases/cve/cve-2016-7117.c
+++ b/testcases/cve/cve-2016-7117.c
@@ -140,7 +140,8 @@ static void run(void)
 		if (socketpair(AF_LOCAL, SOCK_DGRAM, 0, (int *)socket_fds))
 			tst_brk(TBROK | TERRNO, "Socket creation failed");
 
-		tst_fzsync_wait_update_a(&fzsync_pair);
+		if (!tst_fzsync_wait_update_a(&fzsync_pair))
+			break;
 		tst_fzsync_delay_a(&fzsync_pair);
 
 		stat = tst_syscall(__NR_recvmmsg,
diff --git a/testcases/cve/cve-2017-2671.c b/testcases/cve/cve-2017-2671.c
index b0471bfff..21dd2a754 100644
--- a/testcases/cve/cve-2017-2671.c
+++ b/testcases/cve/cve-2017-2671.c
@@ -115,7 +115,8 @@ static void run(void)
 		SAFE_CONNECT(sockfd,
 			     (struct sockaddr *)&iaddr, sizeof(iaddr));
 
-		tst_fzsync_wait_update_a(&fzsync_pair);
+		if (!tst_fzsync_wait_update_a(&fzsync_pair))
+			break;
 		tst_fzsync_delay_a(&fzsync_pair);
 		connect(sockfd, (struct sockaddr *)&uaddr, sizeof(uaddr));
 		tst_fzsync_time_a(&fzsync_pair);
diff --git a/testcases/kernel/syscalls/inotify/inotify09.c b/testcases/kernel/syscalls/inotify/inotify09.c
index 475411311..52df38f24 100644
--- a/testcases/kernel/syscalls/inotify/inotify09.c
+++ b/testcases/kernel/syscalls/inotify/inotify09.c
@@ -102,7 +102,8 @@ static void verify_inotify(void)
 		if (wd < 0)
 			tst_brk(TBROK | TERRNO, "inotify_add_watch() failed.");
 
-		tst_fzsync_wait_update_a(&fzsync_pair);
+		if (!tst_fzsync_wait_update_a(&fzsync_pair))
+			break;
 		tst_fzsync_delay_a(&fzsync_pair);
 
 		wd = myinotify_rm_watch(inotify_fd, wd);
-- 
2.18.0

