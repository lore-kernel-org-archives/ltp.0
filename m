From: zhao gongyi <zhaogongyi@huawei.com>
Date: Fri, 5 Feb 2021 18:51:43 +0800
Subject: [LTP] [PATCH] ttype: using TTERRNO to macth errno
Message-ID: <20210205105143.243135-1-zhaogongyi@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Use TTERRNO because we are using the TEST() macro.

For those:
    testcases/kernel/containers/pidns/pidns06.c
    testcases/kernel/containers/pidns/pidns17.c
    testcases/kernel/pty/pty02.c
    testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep02.c
    testcases/kernel/syscalls/clock_settime/clock_settime03.c
    testcases/kernel/syscalls/cma/process_vm_readv02.c
    testcases/kernel/syscalls/cma/process_vm_readv03.c
    testcases/kernel/syscalls/cma/process_vm_writev02.c
    testcases/kernel/syscalls/dup/dup01.c
    testcases/kernel/syscalls/dup/dup04.c
    testcases/kernel/syscalls/dup2/dup202.c
    testcases/kernel/syscalls/execl/execl01.c
    testcases/kernel/syscalls/execle/execle01.c
    testcases/kernel/syscalls/execlp/execlp01.c
    testcases/kernel/syscalls/execv/execv01.c
    testcases/kernel/syscalls/execve/execve05.c
    testcases/kernel/syscalls/execveat/execveat01.c
    testcases/kernel/syscalls/execveat/execveat03.c
    testcases/kernel/syscalls/flock/flock04.c
    testcases/kernel/syscalls/kill/kill02.c
    testcases/kernel/syscalls/madvise/madvise06.c
    testcases/kernel/syscalls/migrate_pages/migrate_pages02.c
    testcases/kernel/syscalls/msync/msync01.c
    testcases/kernel/syscalls/nanosleep/nanosleep01.c
    testcases/kernel/syscalls/nice/nice01.c
    testcases/kernel/syscalls/nice/nice02.c
    testcases/kernel/syscalls/pipe/pipe02.c
    testcases/kernel/syscalls/pivot_root/pivot_root01.c
    testcases/kernel/syscalls/prctl/prctl07.c
    testcases/kernel/syscalls/preadv2/preadv203.c
    testcases/kernel/syscalls/recvmmsg/recvmmsg01.c
    testcases/kernel/syscalls/setrlimit/setrlimit01.c
    testcases/kernel/syscalls/statfs/statfs01.c
    testcases/kernel/syscalls/statvfs/statvfs01.c
    testcases/kernel/syscalls/swapon/libswapon.c
    testcases/kernel/syscalls/timer_getoverrun/timer_getoverrun01.c
    testcases/kernel/syscalls/timerfd/timerfd01.c
    testcases/kernel/syscalls/wait4/wait401.c
    testcases/network/lib6/asapi_03.c
---
 testcases/kernel/containers/pidns/pidns06.c                 | 2 +-
 testcases/kernel/containers/pidns/pidns17.c                 | 2 +-
 testcases/kernel/pty/pty02.c                                | 2 +-
 .../kernel/syscalls/clock_nanosleep/clock_nanosleep02.c     | 2 +-
 testcases/kernel/syscalls/clock_settime/clock_settime03.c   | 2 +-
 testcases/kernel/syscalls/cma/process_vm_readv02.c          | 2 +-
 testcases/kernel/syscalls/cma/process_vm_readv03.c          | 4 ++--
 testcases/kernel/syscalls/cma/process_vm_writev02.c         | 2 +-
 testcases/kernel/syscalls/dup/dup01.c                       | 2 +-
 testcases/kernel/syscalls/dup/dup04.c                       | 2 +-
 testcases/kernel/syscalls/dup2/dup202.c                     | 2 +-
 testcases/kernel/syscalls/execl/execl01.c                   | 2 +-
 testcases/kernel/syscalls/execle/execle01.c                 | 2 +-
 testcases/kernel/syscalls/execlp/execlp01.c                 | 2 +-
 testcases/kernel/syscalls/execv/execv01.c                   | 2 +-
 testcases/kernel/syscalls/execve/execve05.c                 | 2 +-
 testcases/kernel/syscalls/execveat/execveat01.c             | 2 +-
 testcases/kernel/syscalls/execveat/execveat03.c             | 2 +-
 testcases/kernel/syscalls/flock/flock04.c                   | 2 +-
 testcases/kernel/syscalls/kill/kill02.c                     | 2 +-
 testcases/kernel/syscalls/madvise/madvise06.c               | 4 ++--
 testcases/kernel/syscalls/migrate_pages/migrate_pages02.c   | 2 +-
 testcases/kernel/syscalls/msync/msync01.c                   | 2 +-
 testcases/kernel/syscalls/nanosleep/nanosleep01.c           | 2 +-
 testcases/kernel/syscalls/nice/nice01.c                     | 2 +-
 testcases/kernel/syscalls/nice/nice02.c                     | 2 +-
 testcases/kernel/syscalls/pipe/pipe02.c                     | 2 +-
 testcases/kernel/syscalls/pivot_root/pivot_root01.c         | 4 ++--
 testcases/kernel/syscalls/prctl/prctl07.c                   | 2 +-
 testcases/kernel/syscalls/preadv2/preadv203.c               | 2 +-
 testcases/kernel/syscalls/recvmmsg/recvmmsg01.c             | 2 +-
 testcases/kernel/syscalls/setrlimit/setrlimit01.c           | 2 +-
 testcases/kernel/syscalls/statfs/statfs01.c                 | 2 +-
 testcases/kernel/syscalls/statvfs/statvfs01.c               | 2 +-
 testcases/kernel/syscalls/swapon/libswapon.c                | 2 +-
 .../kernel/syscalls/timer_getoverrun/timer_getoverrun01.c   | 6 +++---
 testcases/kernel/syscalls/timerfd/timerfd01.c               | 2 +-
 testcases/kernel/syscalls/wait4/wait401.c                   | 2 +-
 testcases/network/lib6/asapi_03.c                           | 4 ++--
 39 files changed, 45 insertions(+), 45 deletions(-)

diff --git a/testcases/kernel/containers/pidns/pidns06.c b/testcases/kernel/containers/pidns/pidns06.c
index 6afcc81ee..d6623941a 100644
--- a/testcases/kernel/containers/pidns/pidns06.c
+++ b/testcases/kernel/containers/pidns/pidns06.c
@@ -124,7 +124,7 @@ int main(void)
 	TEST(do_clone_unshare_test(T_CLONE, CLONE_NEWPID, kill_pid_in_childfun,
 				   (void *)&pid));
 	if (TEST_RETURN == -1) {
-		tst_brkm(TFAIL | TERRNO, NULL, "clone failed");
+		tst_brkm(TFAIL | TTERRNO, NULL, "clone failed");
 	} else if (wait(&status) == -1) {
 		tst_brkm(TFAIL | TERRNO, NULL, "wait failed");
 	}
diff --git a/testcases/kernel/containers/pidns/pidns17.c b/testcases/kernel/containers/pidns/pidns17.c
index 8c152897b..cf0c5826f 100644
--- a/testcases/kernel/containers/pidns/pidns17.c
+++ b/testcases/kernel/containers/pidns/pidns17.c
@@ -143,7 +143,7 @@ int main(void)
 	/* Container creation on PID namespace */
 	TEST(do_clone_unshare_test(T_CLONE, CLONE_NEWPID, child_fn, NULL));
 	if (TEST_RETURN == -1) {
-		tst_brkm(TBROK | TERRNO, NULL, "clone failed");
+		tst_brkm(TBROK | TTERRNO, NULL, "clone failed");
 	}

 	sleep(1);
diff --git a/testcases/kernel/pty/pty02.c b/testcases/kernel/pty/pty02.c
index eea52a8f6..050a9f7ea 100644
--- a/testcases/kernel/pty/pty02.c
+++ b/testcases/kernel/pty/pty02.c
@@ -39,7 +39,7 @@ static void do_test(void)
 	if (TST_RET == -1) {
 		if (TST_ERR == EINVAL)
 			tst_brk(TCONF, "tcsetattr(, , EXTPROC | ICANON) is not supported");
-		tst_brk(TBROK | TERRNO, "tcsetattr() failed");
+		tst_brk(TBROK | TTERRNO, "tcsetattr() failed");
 	}

 	if (unlockpt(ptmx) != 0)
diff --git a/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep02.c b/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep02.c
index a45912477..feb3e4791 100644
--- a/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep02.c
+++ b/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep02.c
@@ -22,7 +22,7 @@ int sample_fn(int clk_id, long long usec)
 	tst_timer_sample();

 	if (TST_RET != 0) {
-		tst_res(TFAIL | TERRNO,
+		tst_res(TFAIL | TTERRNO,
 			"nanosleep() returned %li", TST_RET);
 		return 1;
 	}
diff --git a/testcases/kernel/syscalls/clock_settime/clock_settime03.c b/testcases/kernel/syscalls/clock_settime/clock_settime03.c
index fef3c10e9..c25277d92 100644
--- a/testcases/kernel/syscalls/clock_settime/clock_settime03.c
+++ b/testcases/kernel/syscalls/clock_settime/clock_settime03.c
@@ -61,7 +61,7 @@ static void run(void)

 	TEST(tst_syscall(__NR_timer_create, CLOCK_REALTIME, &ev, &timer));
 	if (TST_RET != 0)
-		tst_brk(TBROK | TERRNO, "timer_create() failed");
+		tst_brk(TBROK | TTERRNO, "timer_create() failed");

 	tst_ts_set_sec(&start, time);
 	tst_ts_set_nsec(&start, 0);
diff --git a/testcases/kernel/syscalls/cma/process_vm_readv02.c b/testcases/kernel/syscalls/cma/process_vm_readv02.c
index 68e1bea97..ac53ed226 100644
--- a/testcases/kernel/syscalls/cma/process_vm_readv02.c
+++ b/testcases/kernel/syscalls/cma/process_vm_readv02.c
@@ -137,7 +137,7 @@ static void child_invoke(void)
 	TEST(ltp_syscall(__NR_process_vm_readv, pids[0],
 			 &local, 1UL, &remote, 1UL, 0UL));
 	if (TEST_RETURN != len)
-		tst_brkm(TFAIL | TERRNO, tst_exit, "process_vm_readv");
+		tst_brkm(TFAIL | TTERRNO, tst_exit, "process_vm_readv");
 	if (strncmp(lp, tst_string, len) != 0)
 		tst_brkm(TFAIL, tst_exit, "child 1: expected string: %s, "
 			 "received string: %256s", tst_string, lp);
diff --git a/testcases/kernel/syscalls/cma/process_vm_readv03.c b/testcases/kernel/syscalls/cma/process_vm_readv03.c
index f8425c1f9..561146e5e 100644
--- a/testcases/kernel/syscalls/cma/process_vm_readv03.c
+++ b/testcases/kernel/syscalls/cma/process_vm_readv03.c
@@ -183,7 +183,7 @@ static long *fetch_remote_addrs(void)
 	TEST(ltp_syscall(__NR_process_vm_readv, pids[0], &local,
 			 1UL, &remote, 1UL, 0UL));
 	if (TEST_RETURN != len)
-		tst_brkm(TFAIL | TERRNO, tst_exit, "process_vm_readv");
+		tst_brkm(TFAIL | TTERRNO, tst_exit, "process_vm_readv");

 	return local.iov_base;
 }
@@ -217,7 +217,7 @@ static void child_invoke(int *bufsz_arr)
 			    (unsigned long)NUM_LOCAL_VECS, remote,
 			    (unsigned long)nr_iovecs, 0UL));
 	if (TEST_RETURN != bufsz)
-		tst_brkm(TBROK | TERRNO, tst_exit, "process_vm_readv");
+		tst_brkm(TBROK | TTERRNO, tst_exit, "process_vm_readv");

 	/* verify every byte */
 	count = 0;
diff --git a/testcases/kernel/syscalls/cma/process_vm_writev02.c b/testcases/kernel/syscalls/cma/process_vm_writev02.c
index 2e7a8d60b..ea2ca63d1 100644
--- a/testcases/kernel/syscalls/cma/process_vm_writev02.c
+++ b/testcases/kernel/syscalls/cma/process_vm_writev02.c
@@ -174,7 +174,7 @@ static void child_write(void)
 	TEST(ltp_syscall(__NR_process_vm_writev, pids[0], &local,
 			 1UL, &remote, 1UL, 0UL));
 	if (TEST_RETURN != bufsz)
-		tst_brkm(TFAIL | TERRNO, tst_exit, "process_vm_readv");
+		tst_brkm(TFAIL | TTERRNO, tst_exit, "process_vm_readv");
 }

 static void setup(void)
diff --git a/testcases/kernel/syscalls/dup/dup01.c b/testcases/kernel/syscalls/dup/dup01.c
index b4523cbd6..74e24cc02 100644
--- a/testcases/kernel/syscalls/dup/dup01.c
+++ b/testcases/kernel/syscalls/dup/dup01.c
@@ -18,7 +18,7 @@ static void verify_dup(void)
 	if (TST_RET < -1) {
 		tst_res(TFAIL, "Invalid dup() return value %ld", TST_RET);
 	} else if (TST_RET == -1) {
-		tst_res(TFAIL | TERRNO, "dup(%d) Failed", fd);
+		tst_res(TFAIL | TTERRNO, "dup(%d) Failed", fd);
 	} else {
 		tst_res(TPASS, "dup(%d) returned %ld", fd, TST_RET);
 		SAFE_CLOSE(TST_RET);
diff --git a/testcases/kernel/syscalls/dup/dup04.c b/testcases/kernel/syscalls/dup/dup04.c
index 1414b2a9e..0b1827c68 100644
--- a/testcases/kernel/syscalls/dup/dup04.c
+++ b/testcases/kernel/syscalls/dup/dup04.c
@@ -144,7 +144,7 @@ int main(int ac, char **av)
 		TEST(dup(fd[0]));

 		if (TEST_RETURN == -1)
-			tst_resm(TFAIL | TERRNO,
+			tst_resm(TFAIL | TTERRNO,
 				 "dup of read side of pipe failed");
 		else {
 			tst_resm(TPASS,
diff --git a/testcases/kernel/syscalls/dup2/dup202.c b/testcases/kernel/syscalls/dup2/dup202.c
index 15443ef3d..c87769fa9 100644
--- a/testcases/kernel/syscalls/dup2/dup202.c
+++ b/testcases/kernel/syscalls/dup2/dup202.c
@@ -108,7 +108,7 @@ int main(int ac, char **av)
 			TEST(dup2(ofd, *TC[i].nfd));

 			if (TEST_RETURN == -1) {
-				tst_resm(TFAIL | TERRNO,
+				tst_resm(TFAIL | TTERRNO,
 					 "call failed unexpectedly");
 				continue;
 			}
diff --git a/testcases/kernel/syscalls/execl/execl01.c b/testcases/kernel/syscalls/execl/execl01.c
index 4ec94b5f9..9268d4976 100644
--- a/testcases/kernel/syscalls/execl/execl01.c
+++ b/testcases/kernel/syscalls/execl/execl01.c
@@ -26,7 +26,7 @@ static void verify_execl(void)
 	pid = SAFE_FORK();
 	if (pid == 0) {
 		TEST(execl(path, "execl01_child", "canary", NULL));
-		tst_brk(TFAIL | TERRNO,
+		tst_brk(TFAIL | TTERRNO,
 			"Failed to execute execl01_child");
 	}
 }
diff --git a/testcases/kernel/syscalls/execle/execle01.c b/testcases/kernel/syscalls/execle/execle01.c
index 8df1cc649..f10813cca 100644
--- a/testcases/kernel/syscalls/execle/execle01.c
+++ b/testcases/kernel/syscalls/execle/execle01.c
@@ -33,7 +33,7 @@ static void verify_execle(void)
 	pid = SAFE_FORK();
 	if (pid == 0) {
 		TEST(execle(path, "execle01_child", "canary", NULL, envp));
-		tst_brk(TFAIL | TERRNO,
+		tst_brk(TFAIL | TTERRNO,
 			"Failed to execute execl01_child");
 	}
 }
diff --git a/testcases/kernel/syscalls/execlp/execlp01.c b/testcases/kernel/syscalls/execlp/execlp01.c
index 61a81c612..87c2a9fca 100644
--- a/testcases/kernel/syscalls/execlp/execlp01.c
+++ b/testcases/kernel/syscalls/execlp/execlp01.c
@@ -24,7 +24,7 @@ static void verify_execlp(void)
 	pid = SAFE_FORK();
 	if (pid == 0 ) {
 		TEST(execlp("execlp01_child", "execlp01_child", "canary", NULL));
-		tst_brk(TFAIL | TERRNO,
+		tst_brk(TFAIL | TTERRNO,
 			"Failed to execute execlp01_child");
 	}
 }
diff --git a/testcases/kernel/syscalls/execv/execv01.c b/testcases/kernel/syscalls/execv/execv01.c
index 58c61a3e4..730333f4b 100644
--- a/testcases/kernel/syscalls/execv/execv01.c
+++ b/testcases/kernel/syscalls/execv/execv01.c
@@ -28,7 +28,7 @@ static void verify_execv(void)
 	pid = SAFE_FORK();
 	if (pid == 0) {
 		TEST(execv(path, args));
-		tst_brk(TFAIL | TERRNO, "Failed to execute execv01_child");
+		tst_brk(TFAIL | TTERRNO, "Failed to execute execv01_child");
 	}
 }

diff --git a/testcases/kernel/syscalls/execve/execve05.c b/testcases/kernel/syscalls/execve/execve05.c
index e1f4b0e2d..4c9789cc5 100644
--- a/testcases/kernel/syscalls/execve/execve05.c
+++ b/testcases/kernel/syscalls/execve/execve05.c
@@ -56,7 +56,7 @@ static void do_child(void)
 	TST_CHECKPOINT_WAIT(0);

 	TEST(execve(TEST_APP, argv, environ));
-	tst_res(TFAIL | TERRNO, "execve() returned unexpected errno");
+	tst_res(TFAIL | TTERRNO, "execve() returned unexpected errno");
 }

 static void verify_execve(void)
diff --git a/testcases/kernel/syscalls/execveat/execveat01.c b/testcases/kernel/syscalls/execveat/execveat01.c
index 5325d484b..16d27acf6 100644
--- a/testcases/kernel/syscalls/execveat/execveat01.c
+++ b/testcases/kernel/syscalls/execveat/execveat01.c
@@ -55,7 +55,7 @@ static void verify_execveat(unsigned int i)
 	pid = SAFE_FORK();
 	if (pid == 0) {
 		TEST(execveat(*tc->fd, tc->pathname, argv, environ, tc->flag));
-		tst_res(TFAIL | TERRNO, "execveat() returns unexpected errno");
+		tst_res(TFAIL | TTERRNO, "execveat() returns unexpected errno");
 	}
 }

diff --git a/testcases/kernel/syscalls/execveat/execveat03.c b/testcases/kernel/syscalls/execveat/execveat03.c
index 27247e664..78b26ab56 100644
--- a/testcases/kernel/syscalls/execveat/execveat03.c
+++ b/testcases/kernel/syscalls/execveat/execveat03.c
@@ -51,7 +51,7 @@ static void do_child(void)
 	SAFE_UNLINK(TEST_FILE_PATH);

 	TEST(execveat(fd, "", argv, environ, AT_EMPTY_PATH));
-	tst_res(TFAIL | TERRNO, "execveat() returned unexpected errno");
+	tst_res(TFAIL | TTERRNO, "execveat() returned unexpected errno");
 }

 static void verify_execveat(void)
diff --git a/testcases/kernel/syscalls/flock/flock04.c b/testcases/kernel/syscalls/flock/flock04.c
index e4fd23c35..89d1949cf 100644
--- a/testcases/kernel/syscalls/flock/flock04.c
+++ b/testcases/kernel/syscalls/flock/flock04.c
@@ -52,7 +52,7 @@ static void verify_flock(unsigned n)
 	fd2 = SAFE_OPEN("testfile", O_RDWR);
 	TEST(flock(fd2, tc->operation));
 	if (TST_RET != 0) {
-		tst_res(TFAIL | TERRNO, "flock() failed to acquire %s",
+		tst_res(TFAIL | TTERRNO, "flock() failed to acquire %s",
 			tc->f_lock);
 		SAFE_CLOSE(fd2);
 		return;
diff --git a/testcases/kernel/syscalls/kill/kill02.c b/testcases/kernel/syscalls/kill/kill02.c
index 08360ddbe..7ae2427c8 100644
--- a/testcases/kernel/syscalls/kill/kill02.c
+++ b/testcases/kernel/syscalls/kill/kill02.c
@@ -349,7 +349,7 @@ void parent_rout(void)
 	TEST(kill(0, SIGUSR1));

 	if (TEST_RETURN == -1) {
-		tst_brkm(TBROK | TERRNO, NULL, "kill() failed");
+		tst_brkm(TBROK | TTERRNO, NULL, "kill() failed");
 		(void)par_kill();
 		cleanup();
 	}
diff --git a/testcases/kernel/syscalls/madvise/madvise06.c b/testcases/kernel/syscalls/madvise/madvise06.c
index 962554163..2099df6c3 100644
--- a/testcases/kernel/syscalls/madvise/madvise06.c
+++ b/testcases/kernel/syscalls/madvise/madvise06.c
@@ -203,7 +203,7 @@ static void test_advice_willneed(void)

 	TEST(madvise(target, MEM_LIMIT, MADV_WILLNEED));
 	if (TST_RET == -1)
-		tst_brk(TBROK | TERRNO, "madvise failed");
+		tst_brk(TBROK | TTERRNO, "madvise failed");

 	do {
 		loops--;
@@ -223,7 +223,7 @@ static void test_advice_willneed(void)

 	TEST(madvise(target, PASS_THRESHOLD, MADV_WILLNEED));
 	if (TST_RET == -1)
-		tst_brk(TBROK | TERRNO, "madvise failed");
+		tst_brk(TBROK | TTERRNO, "madvise failed");

 	page_fault_num_1 = get_page_fault_num();
 	tst_res(TINFO, "PageFault(madvice / no mem access): %d",
diff --git a/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c b/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c
index 7c58cac4c..485a1c5aa 100644
--- a/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c
+++ b/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c
@@ -89,7 +89,7 @@ static int migrate_to_node(pid_t pid, int node)
 		new_nodes));
 	if (TST_RET != 0) {
 		if (TST_RET < 0) {
-			tst_res(TFAIL | TERRNO, "migrate_pages failed "
+			tst_res(TFAIL | TTERRNO, "migrate_pages failed "
 				 "ret: %ld, ", TST_RET);
 			print_mem_stats(pid, node);
 		} else {
diff --git a/testcases/kernel/syscalls/msync/msync01.c b/testcases/kernel/syscalls/msync/msync01.c
index cb740565d..3a5a48ee5 100644
--- a/testcases/kernel/syscalls/msync/msync01.c
+++ b/testcases/kernel/syscalls/msync/msync01.c
@@ -103,7 +103,7 @@ int main(int ac, char **av)
 		TEST(msync(addr, page_sz, MS_ASYNC));

 		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL | TERRNO, "msync failed");
+			tst_resm(TFAIL | TTERRNO, "msync failed");
 			continue;
 		}

diff --git a/testcases/kernel/syscalls/nanosleep/nanosleep01.c b/testcases/kernel/syscalls/nanosleep/nanosleep01.c
index 2de2a76f2..eaacb89fa 100644
--- a/testcases/kernel/syscalls/nanosleep/nanosleep01.c
+++ b/testcases/kernel/syscalls/nanosleep/nanosleep01.c
@@ -24,7 +24,7 @@ int sample_fn(int clk_id, long long usec)
 	tst_timer_sample();

 	if (TST_RET != 0) {
-		tst_res(TFAIL | TERRNO,
+		tst_res(TFAIL | TTERRNO,
 			"nanosleep() returned %li", TST_RET);
 		return 1;
 	}
diff --git a/testcases/kernel/syscalls/nice/nice01.c b/testcases/kernel/syscalls/nice/nice01.c
index 04ca17a1e..aee5ea043 100644
--- a/testcases/kernel/syscalls/nice/nice01.c
+++ b/testcases/kernel/syscalls/nice/nice01.c
@@ -49,7 +49,7 @@ static void verify_nice(void)

 	TEST(nice(-NICEINC));
 	if (TST_ERR)
-		tst_brk(TBROK | TERRNO, "nice(-NICEINC) failed");
+		tst_brk(TBROK | TTERRNO, "nice(-NICEINC) failed");
 }

 static struct tst_test test = {
diff --git a/testcases/kernel/syscalls/nice/nice02.c b/testcases/kernel/syscalls/nice/nice02.c
index 65c612265..036301000 100644
--- a/testcases/kernel/syscalls/nice/nice02.c
+++ b/testcases/kernel/syscalls/nice/nice02.c
@@ -47,7 +47,7 @@ static void verify_nice(void)

 	TEST(nice(DEFAULT_PRIO));
 	if (TST_ERR)
-		tst_brk(TBROK | TERRNO, "nice(-NICEINC) failed");
+		tst_brk(TBROK | TTERRNO, "nice(-NICEINC) failed");
 }

 static struct tst_test test = {
diff --git a/testcases/kernel/syscalls/pipe/pipe02.c b/testcases/kernel/syscalls/pipe/pipe02.c
index 204091163..bf81c1899 100644
--- a/testcases/kernel/syscalls/pipe/pipe02.c
+++ b/testcases/kernel/syscalls/pipe/pipe02.c
@@ -47,7 +47,7 @@ static void verify_pipe(void)

 	TEST(pipe(fd));
 	if (TST_RET == -1) {
-		tst_res(TFAIL|TERRNO, "pipe() failed");
+		tst_res(TFAIL|TTERRNO, "pipe() failed");
 		return;
 	}

diff --git a/testcases/kernel/syscalls/pivot_root/pivot_root01.c b/testcases/kernel/syscalls/pivot_root/pivot_root01.c
index 2e8a7ff24..1fbe8c189 100644
--- a/testcases/kernel/syscalls/pivot_root/pivot_root01.c
+++ b/testcases/kernel/syscalls/pivot_root/pivot_root01.c
@@ -101,7 +101,7 @@ static void run(unsigned int test_case)
 	/* pivot_root requires no shared mounts exist in process namespace */
 	TEST(unshare(CLONE_NEWNS | CLONE_FS));
 	if (TST_RET == -1)
-		tst_brk(TFAIL | TERRNO, "unshare failed");
+		tst_brk(TFAIL | TTERRNO, "unshare failed");

 	/*
 	 * Create an initial root dir. pivot_root doesn't work if the initial root
@@ -153,7 +153,7 @@ static void run(unsigned int test_case)

 	if (test_cases[test_case].test_case == NORMAL) {
 		if (TST_RET)
-			tst_res(TFAIL | TERRNO, "pivot_root failed");
+			tst_res(TFAIL | TTERRNO, "pivot_root failed");
 		else
 			tst_res(TPASS, "pivot_root succeeded");

diff --git a/testcases/kernel/syscalls/prctl/prctl07.c b/testcases/kernel/syscalls/prctl/prctl07.c
index a6f23a098..d27cac26c 100644
--- a/testcases/kernel/syscalls/prctl/prctl07.c
+++ b/testcases/kernel/syscalls/prctl/prctl07.c
@@ -140,7 +140,7 @@ static void verify_prctl(void)
 	if (TST_RET == 0)
 		tst_res(TPASS, "PR_CAP_AMBIENT_CLEAR ALL succeeded");
 	else
-		tst_res(TFAIL | TERRNO, "PR_AMBIENT_CLEAR_ALL failed");
+		tst_res(TFAIL | TTERRNO, "PR_AMBIENT_CLEAR_ALL failed");

 	tst_res(TINFO, "After PR_CAP_AMBIENT_CLEAR_ALL");
 	TST_ASSERT_FILE_STR(PROC_STATUS, "CapAmb", ZERO_STRING);
diff --git a/testcases/kernel/syscalls/preadv2/preadv203.c b/testcases/kernel/syscalls/preadv2/preadv203.c
index 47c46d526..01622ad15 100644
--- a/testcases/kernel/syscalls/preadv2/preadv203.c
+++ b/testcases/kernel/syscalls/preadv2/preadv203.c
@@ -235,7 +235,7 @@ static void check_preadv2_nowait(int fd)
 	TEST(preadv2(fd, iovec, 1, 0, RWF_NOWAIT));

 	if (TST_ERR == EOPNOTSUPP)
-		tst_brk(TCONF | TERRNO, "preadv2()");
+		tst_brk(TCONF | TTERRNO, "preadv2()");
 }

 static void setup(void)
diff --git a/testcases/kernel/syscalls/recvmmsg/recvmmsg01.c b/testcases/kernel/syscalls/recvmmsg/recvmmsg01.c
index 8f066de9b..4e7e6aa28 100644
--- a/testcases/kernel/syscalls/recvmmsg/recvmmsg01.c
+++ b/testcases/kernel/syscalls/recvmmsg/recvmmsg01.c
@@ -117,7 +117,7 @@ static void setup(void)
 	TEST(tv->sendmmsg(send_sockfd, msg, 1, 0));

 	if (TST_RET != 1) {
-		tst_res(TFAIL | TERRNO, "sendmmsg() failed");
+		tst_res(TFAIL | TTERRNO, "sendmmsg() failed");
 		return;
 	}

diff --git a/testcases/kernel/syscalls/setrlimit/setrlimit01.c b/testcases/kernel/syscalls/setrlimit/setrlimit01.c
index f57b66c4c..2f4c47606 100644
--- a/testcases/kernel/syscalls/setrlimit/setrlimit01.c
+++ b/testcases/kernel/syscalls/setrlimit/setrlimit01.c
@@ -247,7 +247,7 @@ static void test4(void)
 	TEST(setrlimit(RLIMIT_CORE, &rlim));

 	if (TEST_RETURN == -1) {
-		tst_resm(TFAIL | TERRNO, "setrlimit failed to set RLIMIT_CORE");
+		tst_resm(TFAIL | TTERRNO, "setrlimit failed to set RLIMIT_CORE");
 		return;
 	}

diff --git a/testcases/kernel/syscalls/statfs/statfs01.c b/testcases/kernel/syscalls/statfs/statfs01.c
index c3678d5f4..65f008988 100644
--- a/testcases/kernel/syscalls/statfs/statfs01.c
+++ b/testcases/kernel/syscalls/statfs/statfs01.c
@@ -144,7 +144,7 @@ int main(int ac, char **av)

 		/* check return code */
 		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL | TERRNO, "statfs(%s, ..) failed",
+			tst_resm(TFAIL | TTERRNO, "statfs(%s, ..) failed",
 				 fname);
 		} else {
 			tst_resm(TPASS, "statfs(%s, ..) returned %ld",
diff --git a/testcases/kernel/syscalls/statvfs/statvfs01.c b/testcases/kernel/syscalls/statvfs/statvfs01.c
index 1523058e7..e3b356c93 100644
--- a/testcases/kernel/syscalls/statvfs/statvfs01.c
+++ b/testcases/kernel/syscalls/statvfs/statvfs01.c
@@ -54,7 +54,7 @@ int main(int ac, char **av)
 		TEST(statvfs(TEST_PATH, &buf));

 		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL | TERRNO, "statvfs(%s, ...) failed",
+			tst_resm(TFAIL | TTERRNO, "statvfs(%s, ...) failed",
 				 TEST_PATH);
 		} else {
 			tst_resm(TPASS, "statvfs(%s, ...) passed", TEST_PATH);
diff --git a/testcases/kernel/syscalls/swapon/libswapon.c b/testcases/kernel/syscalls/swapon/libswapon.c
index d5bbfa567..a4f0bef28 100644
--- a/testcases/kernel/syscalls/swapon/libswapon.c
+++ b/testcases/kernel/syscalls/swapon/libswapon.c
@@ -84,7 +84,7 @@ void is_swap_supported(void (cleanup)(void), const char *filename)

 	TEST(ltp_syscall(__NR_swapoff, filename, 0));
 	if (TEST_RETURN == -1) {
-		tst_brkm(TFAIL | TERRNO, cleanup,
+		tst_brkm(TFAIL | TTERRNO, cleanup,
 			"swapoff on %s failed", fstype);
 	}
 }
diff --git a/testcases/kernel/syscalls/timer_getoverrun/timer_getoverrun01.c b/testcases/kernel/syscalls/timer_getoverrun/timer_getoverrun01.c
index 2bb38ea7a..ec5588410 100644
--- a/testcases/kernel/syscalls/timer_getoverrun/timer_getoverrun01.c
+++ b/testcases/kernel/syscalls/timer_getoverrun/timer_getoverrun01.c
@@ -60,7 +60,7 @@ int main(int ac, char **av)
 	TEST(ltp_syscall(__NR_timer_create, CLOCK_REALTIME, &ev, &timer));

 	if (TEST_RETURN != 0)
-		tst_brkm(TBROK | TERRNO, cleanup, "Failed to create timer");
+		tst_brkm(TBROK | TTERRNO, cleanup, "Failed to create timer");

 	for (lc = 0; TEST_LOOPING(lc); ++lc) {
 		tst_count = 0;
@@ -70,7 +70,7 @@ int main(int ac, char **av)
 			tst_resm(TPASS,
 			         "timer_getoverrun(CLOCK_REALTIME) Passed");
 		} else {
-			tst_resm(TFAIL | TERRNO,
+			tst_resm(TFAIL | TTERRNO,
 			         "timer_getoverrun(CLOCK_REALTIME) Failed");
 		}

@@ -78,7 +78,7 @@ int main(int ac, char **av)
 		if (TEST_RETURN == -1 && TEST_ERRNO == EINVAL) {
 			tst_resm(TPASS,	"timer_gettime(-1) Failed: EINVAL");
 		} else {
-			tst_resm(TFAIL | TERRNO,
+			tst_resm(TFAIL | TTERRNO,
 			         "timer_gettime(-1) = %li", TEST_RETURN);
 		}
 	}
diff --git a/testcases/kernel/syscalls/timerfd/timerfd01.c b/testcases/kernel/syscalls/timerfd/timerfd01.c
index cede40daf..9f5694217 100644
--- a/testcases/kernel/syscalls/timerfd/timerfd01.c
+++ b/testcases/kernel/syscalls/timerfd/timerfd01.c
@@ -141,7 +141,7 @@ static void run(unsigned int n)
 	if (TST_RET > 0)
 		tst_res(TFAIL, "timer ticks not zero");
 	else if (TST_ERR != EAGAIN)
-		tst_res(TFAIL | TERRNO, "read should fail with EAGAIN got");
+		tst_res(TFAIL | TTERRNO, "read should fail with EAGAIN got");
 	else
 		tst_res(TPASS | TERRNO, "read failed with");

diff --git a/testcases/kernel/syscalls/wait4/wait401.c b/testcases/kernel/syscalls/wait4/wait401.c
index ed42d8659..07fb864f3 100644
--- a/testcases/kernel/syscalls/wait4/wait401.c
+++ b/testcases/kernel/syscalls/wait4/wait401.c
@@ -31,7 +31,7 @@ static void run(void)

 	TEST(wait4(pid, &status, 0, &rusage));
 	if (TST_RET == -1) {
-		tst_res(TFAIL | TERRNO, "wait4() failed");
+		tst_res(TFAIL | TTERRNO, "wait4() failed");
 		return;
 	}

diff --git a/testcases/network/lib6/asapi_03.c b/testcases/network/lib6/asapi_03.c
index c6e2c8e34..2124ba7d9 100644
--- a/testcases/network/lib6/asapi_03.c
+++ b/testcases/network/lib6/asapi_03.c
@@ -269,7 +269,7 @@ static void so_test(struct soent *psoe)
 	TEST(setsockopt(sr, SOL_IPV6, psoe->so_opt, &psoe->so_setval,
 			psoe->so_valsize));
 	if (TEST_RETURN != 0) {
-		tst_resm(TFAIL | TERRNO, "%s set-get: setsockopt",
+		tst_resm(TFAIL | TTERRNO, "%s set-get: setsockopt",
 			 psoe->so_tname);
 		return;
 	}
@@ -277,7 +277,7 @@ static void so_test(struct soent *psoe)
 	valsize = psoe->so_valsize;
 	TEST(getsockopt(sr, SOL_IPV6, psoe->so_opt, &sobuf, &valsize));
 	if (TEST_RETURN != 0) {
-		tst_brkm(TBROK | TERRNO, NULL, "%s set-get: getsockopt",
+		tst_brkm(TBROK | TTERRNO, NULL, "%s set-get: getsockopt",
 			 psoe->so_tname);
 	} else if (memcmp(&psoe->so_setval, &sobuf, psoe->so_valsize)) {
 		tst_resm(TFAIL, "%s set-get optval != setval", psoe->so_tname);
--
2.17.1

