From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Thu, 16 Aug 2018 14:00:20 +0200
Subject: [LTP] [PATCH v3 4/4] fzsync: Limit execution time to prevent test
	timeouts
In-Reply-To: <20180816120020.11042-1-rpalethorpe@suse.com>
References: <20180816120020.11042-1-rpalethorpe@suse.com>
Message-ID: <20180816120020.11042-4-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Use the tst_timer library to check how long the main test loop has been
running for and break the loop if it exceeds (60 * LTP_TIMEOUT_MUL)
seconds. This prevents an overall test timeout which is reported as a failure.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 include/tst_fuzzy_sync.h                      | 50 +++++++++++++------
 lib/newlib_tests/test16.c                     |  4 +-
 testcases/cve/cve-2014-0196.c                 |  4 +-
 testcases/cve/cve-2016-7117.c                 |  6 ++-
 testcases/cve/cve-2017-2671.c                 |  4 +-
 testcases/kernel/syscalls/inotify/inotify09.c |  5 +-
 6 files changed, 51 insertions(+), 22 deletions(-)

diff --git a/include/tst_fuzzy_sync.h b/include/tst_fuzzy_sync.h
index bcc625e24..5e0ff3602 100644
--- a/include/tst_fuzzy_sync.h
+++ b/include/tst_fuzzy_sync.h
@@ -42,6 +42,7 @@
 #include <time.h>
 #include <math.h>
 #include "tst_atomic.h"
+#include "tst_timer.h"
 
 #ifndef CLOCK_MONOTONIC_RAW
 # define CLOCK_MONOTONIC_RAW CLOCK_MONOTONIC
@@ -66,6 +67,7 @@
  * @a_cntr: Internal; Atomic counter used by fzsync_pair_wait()
  * @b_cntr: Internal; Atomic counter used by fzsync_pair_wait()
  * @exit: Internal; Used by tst_fzsync_pair_exit() and fzsync_pair_wait()
+ * @timer: Internal; Used to limit the execution time.
  *
  * This contains all the necessary state for synchronising two points A and
  * B. Where A is the time of an event in one process and B is the time of an
@@ -87,6 +89,7 @@ struct tst_fzsync_pair {
 	int a_cntr;
 	int b_cntr;
 	int exit;
+	struct tst_timer timer;
 };
 
 /**
@@ -99,6 +102,15 @@ struct tst_fzsync_pair {
 	.info_gap = 0x7FFFF     \
 }
 
+static void tst_fzsync_pair_reset(struct tst_fzsync_pair *pair)
+{
+	pair->timer.clock_id = CLOCK_MONOTONIC_RAW;
+	pair->timer.limit.tv_sec = 60 * tst_timeout_mul();
+	pair->timer.limit.tv_nsec = 0;
+
+	tst_timer_start_st(&pair->timer);
+}
+
 /**
  * tst_fzsync_pair_info - Print some synchronisation statistics
  */
@@ -265,9 +277,7 @@ static inline int tst_fzsync_pair_wait(struct tst_fzsync_pair *pair,
 			;
 	}
 
-	/* Only exit if we have done the same amount of work as the other thread */
-	return !tst_atomic_load(&pair->exit) ||
-	  tst_atomic_load(other_cntr) <= tst_atomic_load(our_cntr);
+	return !tst_atomic_load(&pair->exit);
 }
 
 static inline int tst_fzsync_wait_a(struct tst_fzsync_pair *pair)
@@ -280,6 +290,17 @@ static inline int tst_fzsync_wait_b(struct tst_fzsync_pair *pair)
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
@@ -303,8 +324,16 @@ static inline int tst_fzsync_wait_update_a(struct tst_fzsync_pair *pair)
 	static int loop_index;
 
 	tst_fzsync_pair_wait(pair, &pair->a_cntr, &pair->b_cntr);
-	loop_index++;
-	tst_fzsync_pair_update(loop_index, pair);
+
+	if (tst_timer_expired_st(&pair->timer)) {
+		tst_res(TINFO,
+			"Exceeded fuzzy sync time limit, requesting exit");
+		tst_fzsync_pair_exit(pair);
+	} else {
+		loop_index++;
+		tst_fzsync_pair_update(loop_index, pair);
+	}
+
 	return tst_fzsync_pair_wait(pair, &pair->a_cntr, &pair->b_cntr);
 }
 
@@ -313,14 +342,3 @@ static inline int tst_fzsync_wait_update_b(struct tst_fzsync_pair *pair)
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
index d80bd5369..3447dbc5a 100644
--- a/lib/newlib_tests/test16.c
+++ b/lib/newlib_tests/test16.c
@@ -64,8 +64,10 @@ static void run(void)
 {
 	unsigned int i, j, fail = 0;
 
+	tst_fzsync_pair_reset(&pair);
 	for (i = 0; i < LOOPS; i++) {
-		tst_fzsync_wait_update_a(&pair);
+		if (!tst_fzsync_wait_update_a(&pair))
+			break;
 		tst_fzsync_delay_a(&pair);
 		seq[seq_n] = 'A';
 		seq_n = i * 2 + 1;
diff --git a/testcases/cve/cve-2014-0196.c b/testcases/cve/cve-2014-0196.c
index d18108897..4a3f24026 100644
--- a/testcases/cve/cve-2014-0196.c
+++ b/testcases/cve/cve-2014-0196.c
@@ -102,6 +102,7 @@ static void run(void)
 
 	tst_res(TINFO, "Attempting to overflow into a tty_struct...");
 
+	tst_fzsync_pair_reset(&fzsync_pair);
 	for (i = 0; i < ATTEMPTS; i++) {
 		create_pty((int *)&master_fd, (int *)&slave_fd);
 
@@ -118,7 +119,8 @@ static void run(void)
 		t.c_lflag |= ECHO;
 		tcsetattr(master_fd, TCSANOW, &t);
 
-		tst_fzsync_wait_update_a(&fzsync_pair);
+		if (!tst_fzsync_wait_update_a(&fzsync_pair))
+			break;
 
 		tst_fzsync_delay_a(&fzsync_pair);
 		tst_fzsync_time_a(&fzsync_pair);
diff --git a/testcases/cve/cve-2016-7117.c b/testcases/cve/cve-2016-7117.c
index 3cb7efcdf..fecc5889f 100644
--- a/testcases/cve/cve-2016-7117.c
+++ b/testcases/cve/cve-2016-7117.c
@@ -136,11 +136,13 @@ static void run(void)
 
 	msghdrs[0].msg_hdr.msg_iov->iov_base = (void *)&rbuf;
 
+	tst_fzsync_pair_reset(&fzsync_pair);
 	for (i = 1; i < ATTEMPTS; i++) {
 		if (socketpair(AF_LOCAL, SOCK_DGRAM, 0, (int *)socket_fds))
 			tst_brk(TBROK | TERRNO, "Socket creation failed");
 
-		tst_fzsync_wait_update_a(&fzsync_pair);
+		if (!tst_fzsync_wait_update_a(&fzsync_pair))
+			break;
 		tst_fzsync_delay_a(&fzsync_pair);
 
 		stat = tst_syscall(__NR_recvmmsg,
@@ -156,7 +158,7 @@ static void run(void)
 		tst_fzsync_wait_a(&fzsync_pair);
 	}
 
-	tst_res(TPASS, "Nothing happened after %d attempts", ATTEMPTS);
+	tst_res(TPASS, "Nothing happened after %d attempts", i);
 }
 
 static struct tst_test test = {
diff --git a/testcases/cve/cve-2017-2671.c b/testcases/cve/cve-2017-2671.c
index b0471bfff..ce3022ce2 100644
--- a/testcases/cve/cve-2017-2671.c
+++ b/testcases/cve/cve-2017-2671.c
@@ -111,11 +111,13 @@ static void run(void)
 {
 	int i;
 
+	tst_fzsync_pair_reset(&fzsync_pair);
 	for (i = 0; i < ATTEMPTS; i++) {
 		SAFE_CONNECT(sockfd,
 			     (struct sockaddr *)&iaddr, sizeof(iaddr));
 
-		tst_fzsync_wait_update_a(&fzsync_pair);
+		if (!tst_fzsync_wait_update_a(&fzsync_pair))
+			break;
 		tst_fzsync_delay_a(&fzsync_pair);
 		connect(sockfd, (struct sockaddr *)&uaddr, sizeof(uaddr));
 		tst_fzsync_time_a(&fzsync_pair);
diff --git a/testcases/kernel/syscalls/inotify/inotify09.c b/testcases/kernel/syscalls/inotify/inotify09.c
index 475411311..701ab1487 100644
--- a/testcases/kernel/syscalls/inotify/inotify09.c
+++ b/testcases/kernel/syscalls/inotify/inotify09.c
@@ -97,12 +97,15 @@ static void verify_inotify(void)
 	inotify_fd = myinotify_init1(0);
 	if (inotify_fd < 0)
 		tst_brk(TBROK | TERRNO, "inotify_init failed");
+
+	tst_fzsync_pair_reset(&fzsync_pair);
 	for (tests = 0; tests < TEARDOWNS; tests++) {
 		wd = myinotify_add_watch(inotify_fd, FNAME, IN_MODIFY);
 		if (wd < 0)
 			tst_brk(TBROK | TERRNO, "inotify_add_watch() failed.");
 
-		tst_fzsync_wait_update_a(&fzsync_pair);
+		if (!tst_fzsync_wait_update_a(&fzsync_pair))
+			break;
 		tst_fzsync_delay_a(&fzsync_pair);
 
 		wd = myinotify_rm_watch(inotify_fd, wd);
-- 
2.18.0

