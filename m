From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Tue, 28 Aug 2018 11:30:02 +0200
Subject: [LTP] [PATCH 5/5] Convert tests to use fzsync_{start, end}_race API
In-Reply-To: <20180828093002.20368-1-rpalethorpe@suse.com>
References: <20180828093002.20368-1-rpalethorpe@suse.com>
Message-ID: <20180828093002.20368-6-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

---
 lib/newlib_tests/test16.c                     | 24 ++++---------
 testcases/cve/cve-2014-0196.c                 | 25 ++++---------
 testcases/cve/cve-2016-7117.c                 | 35 ++++++-------------
 testcases/cve/cve-2017-2671.c                 | 23 ++++--------
 testcases/kernel/syscalls/inotify/inotify09.c | 23 +++++-------
 .../kernel/syscalls/ipc/shmctl/shmctl05.c     | 28 +++++----------
 6 files changed, 49 insertions(+), 109 deletions(-)

diff --git a/lib/newlib_tests/test16.c b/lib/newlib_tests/test16.c
index d80bd5369..a209a7b5d 100644
--- a/lib/newlib_tests/test16.c
+++ b/lib/newlib_tests/test16.c
@@ -29,7 +29,6 @@
 /* LOOPS * 2 + 1 must be less than INT_MAX */
 #define LOOPS 0xFFFFFFULL
 
-static pthread_t thrd;
 static volatile char seq[LOOPS * 2 + 1];
 static struct tst_fzsync_pair pair = TST_FZSYNC_PAIR_INIT;
 static volatile int seq_n;
@@ -39,10 +38,8 @@ static void *worker(void *v LTP_ATTRIBUTE_UNUSED)
 {
 	unsigned long long i;
 
-	for (i = 0; tst_fzsync_wait_update_b(&pair); i++) {
-		tst_fzsync_delay_b(&pair);
-		tst_fzsync_time_b(&pair);
-		if (!tst_fzsync_wait_b(&pair))
+	for (i = 0; tst_fzsync_start_race_b(&pair); i++) {
+		if (!tst_fzsync_end_race_b(&pair))
 			break;
 		seq[seq_n] = 'B';
 		seq_n = (i + 1) * 2 % (int)LOOPS * 2;
@@ -55,22 +52,17 @@ static void *worker(void *v LTP_ATTRIBUTE_UNUSED)
 	return NULL;
 }
 
-static void setup(void)
-{
-	SAFE_PTHREAD_CREATE(&thrd, NULL, worker, NULL);
-}
-
 static void run(void)
 {
 	unsigned int i, j, fail = 0;
 
+	tst_fzsync_pair_reset(&pair, worker);
 	for (i = 0; i < LOOPS; i++) {
-		tst_fzsync_wait_update_a(&pair);
-		tst_fzsync_delay_a(&pair);
+		if (!tst_fzsync_start_race_a(&pair))
+			break;
 		seq[seq_n] = 'A';
 		seq_n = i * 2 + 1;
-		tst_fzsync_time_a(&pair);
-		if (!tst_fzsync_wait_a(&pair))
+		if (!tst_fzsync_end_race_a(&pair))
 			break;
 	}
 
@@ -101,12 +93,10 @@ static void run(void)
 
 static void cleanup(void)
 {
-	tst_fzsync_pair_exit(&pair);
-	SAFE_PTHREAD_JOIN(thrd, NULL);
+	tst_fzsync_pair_cleanup(&pair);
 }
 
 static struct tst_test test = {
-	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = run,
 };
diff --git a/testcases/cve/cve-2014-0196.c b/testcases/cve/cve-2014-0196.c
index d18108897..0a971be41 100644
--- a/testcases/cve/cve-2014-0196.c
+++ b/testcases/cve/cve-2014-0196.c
@@ -56,7 +56,6 @@ static int filler_ptys[ONEOFF_ALLOCS * 2];
 static int target_ptys[RUN_ALLOCS * 2];
 static char buf[BUFLEN];
 
-static pthread_t overwrite_thread;
 static void *overwrite_thread_fn(void *);
 static struct tst_fzsync_pair fzsync_pair = TST_FZSYNC_PAIR_INIT;
 
@@ -74,22 +73,15 @@ static void setup(void)
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
+	while(tst_fzsync_start_race_b(&fzsync_pair)) {
 		SAFE_WRITE(0, slave_fd, buf, BUFLEN - 1);
 		SAFE_WRITE(0, slave_fd, buf, BUFLEN - 1);
 		SAFE_WRITE(0, slave_fd, buf, BUFLEN);
-		if (!tst_fzsync_wait_b(&fzsync_pair))
+		if (!tst_fzsync_end_race_b(&fzsync_pair))
 			break;
 	}
 	return 0;
@@ -102,6 +94,7 @@ static void run(void)
 
 	tst_res(TINFO, "Attempting to overflow into a tty_struct...");
 
+	tst_fzsync_pair_reset(&fzsync_pair, overwrite_thread_fn);
 	for (i = 0; i < ATTEMPTS; i++) {
 		create_pty((int *)&master_fd, (int *)&slave_fd);
 
@@ -118,13 +111,12 @@ static void run(void)
 		t.c_lflag |= ECHO;
 		tcsetattr(master_fd, TCSANOW, &t);
 
-		tst_fzsync_wait_update_a(&fzsync_pair);
+		if (!tst_fzsync_start_race_a(&fzsync_pair))
+			break;
 
-		tst_fzsync_delay_a(&fzsync_pair);
-		tst_fzsync_time_a(&fzsync_pair);
 		SAFE_WRITE(0, master_fd, "A", 1);
 
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
index 3cb7efcdf..206e8f25e 100644
--- a/testcases/cve/cve-2016-7117.c
+++ b/testcases/cve/cve-2016-7117.c
@@ -51,7 +51,6 @@
 
 #include "tst_test.h"
 #include "tst_safe_net.h"
-#include "tst_safe_pthread.h"
 #include "tst_timer.h"
 #include "tst_fuzzy_sync.h"
 
@@ -94,38 +93,27 @@ static struct mmsghdr msghdrs[2] = {
 static char rbuf[sizeof(MSG)];
 static struct timespec timeout = { .tv_sec = RECV_TIMEOUT };
 static struct tst_fzsync_pair fzsync_pair = TST_FZSYNC_PAIR_INIT;
-static pthread_t pt_send;
 static void *send_and_close(void *);
 
-static void setup(void)
-{
-	SAFE_PTHREAD_CREATE(&pt_send, 0, send_and_close, 0);
-}
-
 static void cleanup(void)
 {
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
+	while (tst_fzsync_wait_b(&fzsync_pair)) {
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
@@ -136,31 +124,30 @@ static void run(void)
 
 	msghdrs[0].msg_hdr.msg_iov->iov_base = (void *)&rbuf;
 
+	tst_fzsync_pair_reset(&fzsync_pair, send_and_close);
 	for (i = 1; i < ATTEMPTS; i++) {
 		if (socketpair(AF_LOCAL, SOCK_DGRAM, 0, (int *)socket_fds))
 			tst_brk(TBROK | TERRNO, "Socket creation failed");
 
-		tst_fzsync_wait_update_a(&fzsync_pair);
-		tst_fzsync_delay_a(&fzsync_pair);
+		if (!tst_fzsync_wait_a(&fzsync_pair))
+			break;
 
+		tst_fzsync_start_race_a(&fzsync_pair);
 		stat = tst_syscall(__NR_recvmmsg,
 				   socket_fds[1], msghdrs, 2, 0, &timeout);
-		tst_fzsync_time_a(&fzsync_pair);
+		tst_fzsync_end_race_a(&fzsync_pair);
 		if (stat < 0 && errno == EBADF)
 			too_early_count++;
 		else if (stat == 0)
 			tst_res(TWARN, "No messages received, should be one");
 		else if (stat < 0)
 			tst_res(TWARN | TERRNO, "recvmmsg failed unexpectedly");
-
-		tst_fzsync_wait_a(&fzsync_pair);
 	}
 
-	tst_res(TPASS, "Nothing happened after %d attempts", ATTEMPTS);
+	tst_res(TPASS, "Nothing happened after %d attempts", i);
 }
 
 static struct tst_test test = {
-	.setup = setup,
 	.test_all = run,
 	.cleanup = cleanup,
 	.min_kver = "2.6.33",
diff --git a/testcases/cve/cve-2017-2671.c b/testcases/cve/cve-2017-2671.c
index b0471bfff..1f32f1c17 100644
--- a/testcases/cve/cve-2017-2671.c
+++ b/testcases/cve/cve-2017-2671.c
@@ -56,7 +56,6 @@ static int sockfd;
 static unsigned int ping_min_grp, ping_max_grp;
 static struct tst_fzsync_pair fzsync_pair = TST_FZSYNC_PAIR_INIT;
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
@@ -75,16 +73,12 @@ static void setup(void)
 	SAFE_FILE_PRINTF(PING_SYSCTL_PATH, "0 0");
 
 	sockfd = SAFE_SOCKET(AF_INET, SOCK_DGRAM, IPPROTO_ICMP);
-	SAFE_PTHREAD_CREATE(&thrd, 0, connect_b, 0);
 	tst_res(TINFO, "Created ping socket, attempting to race...");
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
@@ -96,11 +90,9 @@ static void cleanup(void)
 
 static void *connect_b(void * param LTP_ATTRIBUTE_UNUSED)
 {
-	while(tst_fzsync_wait_update_b(&fzsync_pair)) {
-		tst_fzsync_delay_b(&fzsync_pair);
+	while(tst_fzsync_start_race_b(&fzsync_pair)) {
 		connect(sockfd, (struct sockaddr *)&uaddr, sizeof(uaddr));
-		tst_fzsync_time_b(&fzsync_pair);
-		if (!tst_fzsync_wait_b(&fzsync_pair))
+		if (!tst_fzsync_end_race_b(&fzsync_pair))
 			break;
 	}
 
@@ -111,16 +103,15 @@ static void run(void)
 {
 	int i;
 
+	tst_fzsync_pair_reset(&fzsync_pair, connect_b);
 	for (i = 0; i < ATTEMPTS; i++) {
 		SAFE_CONNECT(sockfd,
 			     (struct sockaddr *)&iaddr, sizeof(iaddr));
 
-		tst_fzsync_wait_update_a(&fzsync_pair);
-		tst_fzsync_delay_a(&fzsync_pair);
+		if (!tst_fzsync_start_race_a(&fzsync_pair))
+			break;
 		connect(sockfd, (struct sockaddr *)&uaddr, sizeof(uaddr));
-		tst_fzsync_time_a(&fzsync_pair);
-
-		tst_fzsync_wait_a(&fzsync_pair);
+		tst_fzsync_end_race_a(&fzsync_pair);
 	}
 
 	tst_res(TPASS, "We didn't crash");
diff --git a/testcases/kernel/syscalls/inotify/inotify09.c b/testcases/kernel/syscalls/inotify/inotify09.c
index 475411311..b15136fcf 100644
--- a/testcases/kernel/syscalls/inotify/inotify09.c
+++ b/testcases/kernel/syscalls/inotify/inotify09.c
@@ -52,19 +52,16 @@
 #include <sys/inotify.h>
 
 static struct tst_fzsync_pair fzsync_pair = TST_FZSYNC_PAIR_INIT;
-static pthread_t pt_write_seek;
 static int fd;
 
 static void *write_seek(void *unused)
 {
 	char buf[64];
 
-	while (tst_fzsync_wait_update_b(&fzsync_pair)) {
-		tst_fzsync_delay_b(&fzsync_pair);
+	while (tst_fzsync_start_race_b(&fzsync_pair)) {
 		SAFE_WRITE(0, fd, buf, sizeof(buf));
-		tst_fzsync_time_b(&fzsync_pair);
 		SAFE_LSEEK(fd, 0, SEEK_SET);
-		if (!tst_fzsync_wait_b(&fzsync_pair))
+		if (!tst_fzsync_end_race_b(&fzsync_pair))
 			break;
 	}
 	return unused;
@@ -73,8 +70,6 @@ static void *write_seek(void *unused)
 static void setup(void)
 {
 	fd = SAFE_OPEN(FNAME, O_CREAT | O_RDWR, 0600);
-	fzsync_pair.info_gap = 0x7fff;
-	SAFE_PTHREAD_CREATE(&pt_write_seek, 0, write_seek, NULL);
 }
 
 static void cleanup(void)
@@ -82,10 +77,7 @@ static void cleanup(void)
 	if (fd > 0)
 		SAFE_CLOSE(fd);
 
-	if (pt_write_seek) {
-		tst_fzsync_pair_exit(&fzsync_pair);
-		SAFE_PTHREAD_JOIN(pt_write_seek, NULL);
-	}
+	tst_fzsync_pair_cleanup(&fzsync_pair);
 }
 
 static void verify_inotify(void)
@@ -97,20 +89,21 @@ static void verify_inotify(void)
 	inotify_fd = myinotify_init1(0);
 	if (inotify_fd < 0)
 		tst_brk(TBROK | TERRNO, "inotify_init failed");
+
+	tst_fzsync_pair_reset(&fzsync_pair, write_seek);
 	for (tests = 0; tests < TEARDOWNS; tests++) {
 		wd = myinotify_add_watch(inotify_fd, FNAME, IN_MODIFY);
 		if (wd < 0)
 			tst_brk(TBROK | TERRNO, "inotify_add_watch() failed.");
 
-		tst_fzsync_wait_update_a(&fzsync_pair);
-		tst_fzsync_delay_a(&fzsync_pair);
+		if (!tst_fzsync_start_race_a(&fzsync_pair))
+			break;
 
 		wd = myinotify_rm_watch(inotify_fd, wd);
 		if (wd < 0)
 			tst_brk(TBROK | TERRNO, "inotify_rm_watch() failed.");
 
-		tst_fzsync_time_a(&fzsync_pair);
-		tst_fzsync_wait_a(&fzsync_pair);
+		tst_fzsync_end_race_a(&fzsync_pair);
 	}
 	SAFE_CLOSE(inotify_fd);
 	/* We survived for given time - test succeeded */
diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl05.c b/testcases/kernel/syscalls/ipc/shmctl/shmctl05.c
index a960cc906..b984b9760 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/shmctl05.c
+++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl05.c
@@ -34,8 +34,6 @@
 
 static struct tst_fzsync_pair fzsync_pair = TST_FZSYNC_PAIR_INIT;
 
-static pthread_t thrd;
-
 /*
  * Thread 2: repeatedly remove the shm ID and reallocate it again for a
  * new shm segment.
@@ -44,12 +42,10 @@ static void *thrproc(void *unused)
 {
 	int id = SAFE_SHMGET(0xF00F, 4096, IPC_CREAT|0700);
 
-	for (;;) {
-		if (!tst_fzsync_wait_b(&fzsync_pair))
-			break;
+	while (tst_fzsync_start_race_b(&fzsync_pair)) {
 		SAFE_SHMCTL(id, IPC_RMID, NULL);
 		id = SAFE_SHMGET(0xF00F, 4096, IPC_CREAT|0700);
-		if (!tst_fzsync_wait_b(&fzsync_pair))
+		if (!tst_fzsync_end_race_b(&fzsync_pair))
 			break;
 	}
 	return unused;
@@ -57,30 +53,27 @@ static void *thrproc(void *unused)
 
 static void setup(void)
 {
-	tst_timer_check(CLOCK_MONOTONIC);
-
+	fzsync_pair.execution_time = 5;
 	/* Skip test if either remap_file_pages() or SysV IPC is unavailable */
 	tst_syscall(__NR_remap_file_pages, NULL, 0, 0, 0, 0);
 	tst_syscall(__NR_shmctl, 0xF00F, IPC_RMID, NULL);
-
-	SAFE_PTHREAD_CREATE(&thrd, NULL, thrproc, NULL);
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
+	for (;;) {
 		int id;
 		void *addr;
 
 		id = SAFE_SHMGET(0xF00F, 4096, IPC_CREAT|0700);
 		addr = SAFE_SHMAT(id, NULL, 0);
-		tst_fzsync_wait_a(&fzsync_pair);
+		if (!tst_fzsync_start_race_a(&fzsync_pair))
+			break;
 		do {
 			/* This is the system call that crashed */
 			TEST(syscall(__NR_remap_file_pages, addr, 4096,
@@ -91,7 +84,7 @@ static void do_test(void)
 			tst_brk(TBROK | TTERRNO,
 				"Unexpected remap_file_pages() error");
 		}
-		tst_fzsync_wait_a(&fzsync_pair);
+		tst_fzsync_end_race_a(&fzsync_pair);
 	}
 
 	tst_res(TPASS, "didn't crash");
@@ -99,10 +92,7 @@ static void do_test(void)
 
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

