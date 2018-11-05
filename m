From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Mon,  5 Nov 2018 16:42:16 +0100
Subject: [LTP] [PATCH v4 3/4] Convert tests to use fzsync_{start,
	end}_race API
In-Reply-To: <20181105154217.18879-1-rpalethorpe@suse.com>
References: <20181105154217.18879-1-rpalethorpe@suse.com>
Message-ID: <20181105154217.18879-4-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 lib/newlib_tests/test16.c                     | 62 ++++++++++---------
 testcases/cve/cve-2014-0196.c                 | 39 +++++-------
 testcases/cve/cve-2016-7117.c                 | 58 ++++++++---------
 testcases/cve/cve-2017-2671.c                 | 32 ++++------
 testcases/kernel/syscalls/inotify/inotify09.c | 33 ++++------
 .../kernel/syscalls/ipc/shmctl/shmctl05.c     | 30 +++------
 6 files changed, 107 insertions(+), 147 deletions(-)

diff --git a/lib/newlib_tests/test16.c b/lib/newlib_tests/test16.c
index d80bd5369..f453968cd 100644
--- a/lib/newlib_tests/test16.c
+++ b/lib/newlib_tests/test16.c
@@ -27,51 +27,54 @@
 #include "tst_fuzzy_sync.h"
 
 /* LOOPS * 2 + 1 must be less than INT_MAX */
-#define LOOPS 0xFFFFFFULL
+#define LOOPS 0xFFFFULL
 
-static pthread_t thrd;
 static volatile char seq[LOOPS * 2 + 1];
-static struct tst_fzsync_pair pair = TST_FZSYNC_PAIR_INIT;
+static struct tst_fzsync_pair pair;
 static volatile int seq_n;
-static volatile int iterations;
+static volatile char last_wins;
+
+static void setup(void)
+{
+	pair.exec_loops = LOOPS;
+	tst_fzsync_pair_init(&pair);
+}
 
 static void *worker(void *v LTP_ATTRIBUTE_UNUSED)
 {
 	unsigned long long i;
 
-	for (i = 0; tst_fzsync_wait_update_b(&pair); i++) {
-		tst_fzsync_delay_b(&pair);
-		tst_fzsync_time_b(&pair);
-		if (!tst_fzsync_wait_b(&pair))
-			break;
+	for (i = 0; tst_fzsync_run_b(&pair); i++) {
+		tst_fzsync_start_race_b(&pair);
+		usleep(1);
+		last_wins = 'B';
+		tst_fzsync_end_race_b(&pair);
 		seq[seq_n] = 'B';
 		seq_n = (i + 1) * 2 % (int)LOOPS * 2;
 	}
 
-	if (i > LOOPS * iterations)
-		tst_res(TWARN, "Worker performed too many iterations: %lld > %lld",
-			i, LOOPS * iterations);
+	if (i != LOOPS) {
+		tst_res(TFAIL,
+			"Worker performed wrong number of iterations: %lld != %lld",
+			i, LOOPS);
+	}
 
 	return NULL;
 }
 
-static void setup(void)
-{
-	SAFE_PTHREAD_CREATE(&thrd, NULL, worker, NULL);
-}
-
 static void run(void)
 {
-	unsigned int i, j, fail = 0;
+	unsigned int i, j, fail = 0, lost_race = 0;
 
-	for (i = 0; i < LOOPS; i++) {
-		tst_fzsync_wait_update_a(&pair);
-		tst_fzsync_delay_a(&pair);
+	tst_fzsync_pair_reset(&pair, worker);
+	for (i = 0; tst_fzsync_run_a(&pair); i++) {
+		tst_fzsync_start_race_a(&pair);
 		seq[seq_n] = 'A';
 		seq_n = i * 2 + 1;
-		tst_fzsync_time_a(&pair);
-		if (!tst_fzsync_wait_a(&pair))
-			break;
+		last_wins = 'A';
+		tst_fzsync_end_race_a(&pair);
+		if (last_wins == 'B')
+			lost_race++;
 	}
 
 	tst_res(TINFO, "Checking sequence...");
@@ -93,16 +96,15 @@ static void run(void)
 	if (!fail)
 		tst_res(TPASS, "Sequence is correct");
 
-	if (labs(pair.delay) > 1000)
-		tst_res(TFAIL, "Delay is suspiciously large");
-
-	iterations++;
+	if (lost_race < 100)
+		tst_res(TFAIL, "A only lost the race %d times", lost_race);
+	else
+		tst_res(TPASS, "A lost the race %d times", lost_race);
 }
 
 static void cleanup(void)
 {
-	tst_fzsync_pair_exit(&pair);
-	SAFE_PTHREAD_JOIN(thrd, NULL);
+	tst_fzsync_pair_cleanup(&pair);
 }
 
 static struct tst_test test = {
diff --git a/testcases/cve/cve-2014-0196.c b/testcases/cve/cve-2014-0196.c
index d18108897..50a8b35a5 100644
--- a/testcases/cve/cve-2014-0196.c
+++ b/testcases/cve/cve-2014-0196.c
@@ -48,7 +48,6 @@
 
 #define ONEOFF_ALLOCS 200
 #define RUN_ALLOCS    30
-#define ATTEMPTS      0x7000
 #define BUFLEN        512
 
 static volatile int master_fd, slave_fd;
@@ -56,9 +55,8 @@ static int filler_ptys[ONEOFF_ALLOCS * 2];
 static int target_ptys[RUN_ALLOCS * 2];
 static char buf[BUFLEN];
 
-static pthread_t overwrite_thread;
 static void *overwrite_thread_fn(void *);
-static struct tst_fzsync_pair fzsync_pair = TST_FZSYNC_PAIR_INIT;
+static struct tst_fzsync_pair fzsync_pair;
 
 static void create_pty(int *amaster, int *aslave)
 {
@@ -70,27 +68,24 @@ static void setup(void)
 {
 	int i;
 
+	fzsync_pair.exec_loops = 50000;
+
+	tst_fzsync_pair_init(&fzsync_pair);
+
 	for (i = 0; i < ONEOFF_ALLOCS; i++) {
 		create_pty(&filler_ptys[i],
 			   &filler_ptys[i + ONEOFF_ALLOCS]);
 	}
-
-	fzsync_pair.info_gap = 0xFFF;
-	SAFE_PTHREAD_CREATE(&overwrite_thread, NULL,
-			    overwrite_thread_fn, NULL);
 }
 
 static void *overwrite_thread_fn(void *p LTP_ATTRIBUTE_UNUSED)
 {
-	while(tst_fzsync_wait_update_b(&fzsync_pair)) {
-		tst_fzsync_delay_b(&fzsync_pair);
-		tst_fzsync_time_b(&fzsync_pair);
-
+	while(tst_fzsync_run_b(&fzsync_pair)) {
+		tst_fzsync_start_race_b(&fzsync_pair);
 		SAFE_WRITE(0, slave_fd, buf, BUFLEN - 1);
 		SAFE_WRITE(0, slave_fd, buf, BUFLEN - 1);
 		SAFE_WRITE(0, slave_fd, buf, BUFLEN);
-		if (!tst_fzsync_wait_b(&fzsync_pair))
-			break;
+		tst_fzsync_end_race_b(&fzsync_pair);
 	}
 	return 0;
 }
@@ -98,11 +93,12 @@ static void *overwrite_thread_fn(void *p LTP_ATTRIBUTE_UNUSED)
 static void run(void)
 {
 	struct termios t;
-	int i, j;
+	int j;
 
 	tst_res(TINFO, "Attempting to overflow into a tty_struct...");
 
-	for (i = 0; i < ATTEMPTS; i++) {
+	tst_fzsync_pair_reset(&fzsync_pair, overwrite_thread_fn);
+	while (tst_fzsync_run_a(&fzsync_pair)) {
 		create_pty((int *)&master_fd, (int *)&slave_fd);
 
 		for (j = 0; j < RUN_ALLOCS; j++)
@@ -118,13 +114,9 @@ static void run(void)
 		t.c_lflag |= ECHO;
 		tcsetattr(master_fd, TCSANOW, &t);
 
-		tst_fzsync_wait_update_a(&fzsync_pair);
-
-		tst_fzsync_delay_a(&fzsync_pair);
-		tst_fzsync_time_a(&fzsync_pair);
+		tst_fzsync_start_race_a(&fzsync_pair);
 		SAFE_WRITE(0, master_fd, "A", 1);
-
-		tst_fzsync_wait_a(&fzsync_pair);
+		tst_fzsync_end_race_a(&fzsync_pair);
 
 		for (j = 0; j < RUN_ALLOCS; j++) {
 			if (j == RUN_ALLOCS / 2)
@@ -149,10 +141,7 @@ static void cleanup(void)
 {
 	int i;
 
-	if (overwrite_thread) {
-		tst_fzsync_pair_exit(&fzsync_pair);
-		SAFE_PTHREAD_JOIN(overwrite_thread, NULL);
-	}
+	tst_fzsync_pair_cleanup(&fzsync_pair);
 
 	for (i = 0; i < ONEOFF_ALLOCS * 2; i++)
 		close(filler_ptys[i]);
diff --git a/testcases/cve/cve-2016-7117.c b/testcases/cve/cve-2016-7117.c
index 3cb7efcdf..f3d9970c3 100644
--- a/testcases/cve/cve-2016-7117.c
+++ b/testcases/cve/cve-2016-7117.c
@@ -51,7 +51,6 @@
 
 #include "tst_test.h"
 #include "tst_safe_net.h"
-#include "tst_safe_pthread.h"
 #include "tst_timer.h"
 #include "tst_fuzzy_sync.h"
 
@@ -93,13 +92,12 @@ static struct mmsghdr msghdrs[2] = {
 };
 static char rbuf[sizeof(MSG)];
 static struct timespec timeout = { .tv_sec = RECV_TIMEOUT };
-static struct tst_fzsync_pair fzsync_pair = TST_FZSYNC_PAIR_INIT;
-static pthread_t pt_send;
+static struct tst_fzsync_pair fzsync_pair;
 static void *send_and_close(void *);
 
 static void setup(void)
 {
-	SAFE_PTHREAD_CREATE(&pt_send, 0, send_and_close, 0);
+	tst_fzsync_pair_init(&fzsync_pair);
 }
 
 static void cleanup(void)
@@ -107,61 +105,63 @@ static void cleanup(void)
 	close(socket_fds[0]);
 	close(socket_fds[1]);
 
-	if (pt_send) {
-		tst_fzsync_pair_exit(&fzsync_pair);
-		SAFE_PTHREAD_JOIN(pt_send, 0);
-	}
+	tst_fzsync_pair_cleanup(&fzsync_pair);
 }
 
 static void *send_and_close(void *arg)
 {
-	while (tst_fzsync_wait_update_b(&fzsync_pair)) {
+	while (tst_fzsync_run_b(&fzsync_pair)) {
+
+		tst_fzsync_wait_b(&fzsync_pair);
 		send(socket_fds[0], MSG, sizeof(MSG), 0);
 		send(socket_fds[0], MSG, sizeof(MSG), 0);
 
-		tst_fzsync_delay_b(&fzsync_pair);
-
 		close(socket_fds[0]);
+
+		tst_fzsync_start_race_b(&fzsync_pair);
 		close(socket_fds[1]);
-		tst_fzsync_time_b(&fzsync_pair);
-		if (!tst_fzsync_wait_b(&fzsync_pair))
-			break;
+		tst_fzsync_end_race_b(&fzsync_pair);
 	}
 	return arg;
 }
 
 static void run(void)
 {
-	int i, stat, too_early_count = 0;
+	int stat, too_early_count = 0;
 
 	msghdrs[0].msg_hdr.msg_iov->iov_base = (void *)&rbuf;
 
-	for (i = 1; i < ATTEMPTS; i++) {
+	tst_fzsync_pair_reset(&fzsync_pair, send_and_close);
+	while (tst_fzsync_run_a(&fzsync_pair)) {
+
 		if (socketpair(AF_LOCAL, SOCK_DGRAM, 0, (int *)socket_fds))
 			tst_brk(TBROK | TERRNO, "Socket creation failed");
+		tst_fzsync_wait_a(&fzsync_pair);
 
-		tst_fzsync_wait_update_a(&fzsync_pair);
-		tst_fzsync_delay_a(&fzsync_pair);
-
+		tst_fzsync_start_race_a(&fzsync_pair);
 		stat = tst_syscall(__NR_recvmmsg,
 				   socket_fds[1], msghdrs, 2, 0, &timeout);
-		tst_fzsync_time_a(&fzsync_pair);
-		if (stat < 0 && errno == EBADF)
-			too_early_count++;
-		else if (stat == 0)
-			tst_res(TWARN, "No messages received, should be one");
-		else if (stat < 0)
-			tst_res(TWARN | TERRNO, "recvmmsg failed unexpectedly");
+		tst_fzsync_end_race_a(&fzsync_pair);
 
-		tst_fzsync_wait_a(&fzsync_pair);
+		if (stat == 0)
+			tst_res(TWARN, "No messages received, should be one");
+		else if (stat < 0) {
+			if (errno != EBADF) {
+				tst_res(TWARN | TERRNO,
+					"recvmmsg failed unexpectedly");
+			} else {
+				too_early_count++;
+			}
+		}
 	}
 
-	tst_res(TPASS, "Nothing happened after %d attempts", ATTEMPTS);
+	tst_res(TPASS, "Nothing bad happened, probably.");
+	tst_res(TINFO, "Socket was closed too early %d times", too_early_count);
 }
 
 static struct tst_test test = {
-	.setup = setup,
 	.test_all = run,
+	.setup = setup,
 	.cleanup = cleanup,
 	.min_kver = "2.6.33",
 };
diff --git a/testcases/cve/cve-2017-2671.c b/testcases/cve/cve-2017-2671.c
index b0471bfff..5bdb37b69 100644
--- a/testcases/cve/cve-2017-2671.c
+++ b/testcases/cve/cve-2017-2671.c
@@ -54,9 +54,8 @@
 
 static int sockfd;
 static unsigned int ping_min_grp, ping_max_grp;
-static struct tst_fzsync_pair fzsync_pair = TST_FZSYNC_PAIR_INIT;
+static struct tst_fzsync_pair fzsync_pair;
 static struct sockaddr_in iaddr, uaddr;
-static pthread_t thrd;
 static void *connect_b(void *);
 
 static void setup(void)
@@ -65,7 +64,6 @@ static void setup(void)
 	uaddr = iaddr;
 	iaddr.sin_family = AF_INET;
 	uaddr.sin_family = AF_UNSPEC;
-	fzsync_pair.delay_inc = 1;
 
 	if (access(PING_SYSCTL_PATH, F_OK))
 		tst_brk(TCONF, "socket() does not support IPPROTO_ICMP");
@@ -75,16 +73,14 @@ static void setup(void)
 	SAFE_FILE_PRINTF(PING_SYSCTL_PATH, "0 0");
 
 	sockfd = SAFE_SOCKET(AF_INET, SOCK_DGRAM, IPPROTO_ICMP);
-	SAFE_PTHREAD_CREATE(&thrd, 0, connect_b, 0);
 	tst_res(TINFO, "Created ping socket, attempting to race...");
+
+	tst_fzsync_pair_init(&fzsync_pair);
 }
 
 static void cleanup(void)
 {
-	if (thrd) {
-		tst_fzsync_pair_exit(&fzsync_pair);
-		SAFE_PTHREAD_JOIN(thrd, NULL);
-	}
+	tst_fzsync_pair_cleanup(&fzsync_pair);
 
 	if (sockfd > 0)
 		SAFE_CLOSE(sockfd);
@@ -96,12 +92,10 @@ static void cleanup(void)
 
 static void *connect_b(void * param LTP_ATTRIBUTE_UNUSED)
 {
-	while(tst_fzsync_wait_update_b(&fzsync_pair)) {
-		tst_fzsync_delay_b(&fzsync_pair);
+	while (tst_fzsync_run_b(&fzsync_pair)) {
+		tst_fzsync_start_race_b(&fzsync_pair);
 		connect(sockfd, (struct sockaddr *)&uaddr, sizeof(uaddr));
-		tst_fzsync_time_b(&fzsync_pair);
-		if (!tst_fzsync_wait_b(&fzsync_pair))
-			break;
+		tst_fzsync_end_race_b(&fzsync_pair);
 	}
 
 	return 0;
@@ -109,18 +103,14 @@ static void *connect_b(void * param LTP_ATTRIBUTE_UNUSED)
 
 static void run(void)
 {
-	int i;
-
-	for (i = 0; i < ATTEMPTS; i++) {
+	tst_fzsync_pair_reset(&fzsync_pair, connect_b);
+	while (tst_fzsync_run_a(&fzsync_pair)) {
 		SAFE_CONNECT(sockfd,
 			     (struct sockaddr *)&iaddr, sizeof(iaddr));
 
-		tst_fzsync_wait_update_a(&fzsync_pair);
-		tst_fzsync_delay_a(&fzsync_pair);
+		tst_fzsync_start_race_a(&fzsync_pair);
 		connect(sockfd, (struct sockaddr *)&uaddr, sizeof(uaddr));
-		tst_fzsync_time_a(&fzsync_pair);
-
-		tst_fzsync_wait_a(&fzsync_pair);
+		tst_fzsync_end_race_a(&fzsync_pair);
 	}
 
 	tst_res(TPASS, "We didn't crash");
diff --git a/testcases/kernel/syscalls/inotify/inotify09.c b/testcases/kernel/syscalls/inotify/inotify09.c
index 475411311..f587a3a3c 100644
--- a/testcases/kernel/syscalls/inotify/inotify09.c
+++ b/testcases/kernel/syscalls/inotify/inotify09.c
@@ -46,26 +46,22 @@
 #include "inotify.h"
 
 #define FNAME "stress_fname"
-#define TEARDOWNS 200000
 
 #if defined(HAVE_SYS_INOTIFY_H)
 #include <sys/inotify.h>
 
-static struct tst_fzsync_pair fzsync_pair = TST_FZSYNC_PAIR_INIT;
-static pthread_t pt_write_seek;
+static struct tst_fzsync_pair fzsync_pair;
 static int fd;
 
 static void *write_seek(void *unused)
 {
 	char buf[64];
 
-	while (tst_fzsync_wait_update_b(&fzsync_pair)) {
-		tst_fzsync_delay_b(&fzsync_pair);
+	while (tst_fzsync_run_b(&fzsync_pair)) {
+		tst_fzsync_start_race_b(&fzsync_pair);
 		SAFE_WRITE(0, fd, buf, sizeof(buf));
-		tst_fzsync_time_b(&fzsync_pair);
 		SAFE_LSEEK(fd, 0, SEEK_SET);
-		if (!tst_fzsync_wait_b(&fzsync_pair))
-			break;
+		tst_fzsync_end_race_b(&fzsync_pair);
 	}
 	return unused;
 }
@@ -73,8 +69,7 @@ static void *write_seek(void *unused)
 static void setup(void)
 {
 	fd = SAFE_OPEN(FNAME, O_CREAT | O_RDWR, 0600);
-	fzsync_pair.info_gap = 0x7fff;
-	SAFE_PTHREAD_CREATE(&pt_write_seek, 0, write_seek, NULL);
+	tst_fzsync_pair_init(&fzsync_pair);
 }
 
 static void cleanup(void)
@@ -82,35 +77,29 @@ static void cleanup(void)
 	if (fd > 0)
 		SAFE_CLOSE(fd);
 
-	if (pt_write_seek) {
-		tst_fzsync_pair_exit(&fzsync_pair);
-		SAFE_PTHREAD_JOIN(pt_write_seek, NULL);
-	}
+	tst_fzsync_pair_cleanup(&fzsync_pair);
 }
 
 static void verify_inotify(void)
 {
 	int inotify_fd;
 	int wd;
-	int tests;
 
 	inotify_fd = myinotify_init1(0);
 	if (inotify_fd < 0)
 		tst_brk(TBROK | TERRNO, "inotify_init failed");
-	for (tests = 0; tests < TEARDOWNS; tests++) {
+
+	tst_fzsync_pair_reset(&fzsync_pair, write_seek);
+	while (tst_fzsync_run_a(&fzsync_pair)) {
 		wd = myinotify_add_watch(inotify_fd, FNAME, IN_MODIFY);
 		if (wd < 0)
 			tst_brk(TBROK | TERRNO, "inotify_add_watch() failed.");
 
-		tst_fzsync_wait_update_a(&fzsync_pair);
-		tst_fzsync_delay_a(&fzsync_pair);
-
+		tst_fzsync_start_race_a(&fzsync_pair);
 		wd = myinotify_rm_watch(inotify_fd, wd);
+		tst_fzsync_end_race_a(&fzsync_pair);
 		if (wd < 0)
 			tst_brk(TBROK | TERRNO, "inotify_rm_watch() failed.");
-
-		tst_fzsync_time_a(&fzsync_pair);
-		tst_fzsync_wait_a(&fzsync_pair);
 	}
 	SAFE_CLOSE(inotify_fd);
 	/* We survived for given time - test succeeded */
diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl05.c b/testcases/kernel/syscalls/ipc/shmctl/shmctl05.c
index 51879c220..ecae202e8 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/shmctl05.c
+++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl05.c
@@ -32,9 +32,7 @@
 #include "tst_safe_sysv_ipc.h"
 #include "tst_timer.h"
 
-static struct tst_fzsync_pair fzsync_pair = TST_FZSYNC_PAIR_INIT;
-
-static pthread_t thrd;
+static struct tst_fzsync_pair fzsync_pair;
 
 /*
  * Thread 2: repeatedly remove the shm ID and reallocate it again for a
@@ -44,54 +42,49 @@ static void *thrproc(void *unused)
 {
 	int id = SAFE_SHMGET(0xF00F, 4096, IPC_CREAT|0700);
 
-	for (;;) {
-		if (!tst_fzsync_wait_b(&fzsync_pair))
-			break;
+	while (tst_fzsync_run_b(&fzsync_pair)) {
+		tst_fzsync_start_race_b(&fzsync_pair);
 		SAFE_SHMCTL(id, IPC_RMID, NULL);
 		id = SAFE_SHMGET(0xF00F, 4096, IPC_CREAT|0700);
-		if (!tst_fzsync_wait_b(&fzsync_pair))
-			break;
+		tst_fzsync_end_race_b(&fzsync_pair);
 	}
 	return unused;
 }
 
 static void setup(void)
 {
-	tst_timer_check(CLOCK_MONOTONIC);
-
 	/* Skip test if either remap_file_pages() or SysV IPC is unavailable */
 	tst_syscall(__NR_remap_file_pages, NULL, 0, 0, 0, 0);
 	tst_syscall(__NR_shmctl, 0xF00F, IPC_RMID, NULL);
 
-	SAFE_PTHREAD_CREATE(&thrd, NULL, thrproc, NULL);
+	tst_fzsync_pair_init(&fzsync_pair);
 }
 
 static void do_test(void)
 {
-	tst_timer_start(CLOCK_MONOTONIC);
-
 	/*
 	 * Thread 1: repeatedly attach a shm segment, then remap it until the ID
 	 * seems to have been removed by the other process.
 	 */
-	while (!tst_timer_expired_ms(5000)) {
+	tst_fzsync_pair_reset(&fzsync_pair, thrproc);
+	while (tst_fzsync_run_a(&fzsync_pair)) {
 		int id;
 		void *addr;
 
 		id = SAFE_SHMGET(0xF00F, 4096, IPC_CREAT|0700);
 		addr = SAFE_SHMAT(id, NULL, 0);
-		tst_fzsync_wait_a(&fzsync_pair);
+		tst_fzsync_start_race_a(&fzsync_pair);
 		do {
 			/* This is the system call that crashed */
 			TEST(syscall(__NR_remap_file_pages, addr, 4096,
 				     0, 0, 0));
 		} while (TST_RET == 0);
+		tst_fzsync_end_race_a(&fzsync_pair);
 
 		if (TST_ERR != EIDRM && TST_ERR != EINVAL) {
 			tst_brk(TBROK | TTERRNO,
 				"Unexpected remap_file_pages() error");
 		}
-		tst_fzsync_wait_a(&fzsync_pair);
 
 		/*
 		 * Ensure that a shm segment will actually be destroyed.
@@ -106,10 +99,7 @@ static void do_test(void)
 
 static void cleanup(void)
 {
-	if (thrd) {
-		tst_fzsync_pair_exit(&fzsync_pair);
-		SAFE_PTHREAD_JOIN(thrd, NULL);
-	}
+	tst_fzsync_pair_cleanup(&fzsync_pair);
 	shmctl(0xF00F, IPC_RMID, NULL);
 }
 
-- 
2.18.0

