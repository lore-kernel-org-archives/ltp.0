From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 27 Feb 2020 17:39:19 +0100
Subject: [LTP] [PATCH 1/4] Avoid using tst_res(TBROK)
Message-ID: <20200227163922.317-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Mostly TFAIL is better, TBROK should be used only with tst_brk().
This is a preparation for next commit.

+ Adding cleanup() for io_pgetevents01.c

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 doc/test-writing-guidelines.txt               |  4 +--
 lib/newlib_tests/test_exec.c                  |  2 +-
 lib/newlib_tests/tst_capability01.c           |  2 +-
 testcases/cve/cve-2017-17052.c                |  2 +-
 testcases/cve/meltdown.c                      |  6 ++---
 testcases/kernel/crypto/af_alg05.c            |  4 +--
 .../mem/hugetlb/hugeshmctl/hugeshmctl01.c     |  4 +--
 testcases/kernel/pty/pty03.c                  |  2 +-
 testcases/kernel/syscalls/fstat/fstat03.c     |  2 +-
 .../syscalls/gettimeofday/gettimeofday02.c    | 13 +++-------
 .../syscalls/io_pgetevents/io_pgetevents01.c  | 26 ++++++++++---------
 .../syscalls/io_pgetevents/io_pgetevents02.c  |  2 +-
 testcases/kernel/syscalls/keyctl/keyctl05.c   | 12 ++++-----
 .../syscalls/migrate_pages/migrate_pages02.c  |  4 +--
 .../kernel/syscalls/mq_unlink/mq_unlink01.c   |  2 +-
 .../kernel/syscalls/readahead/readahead01.c   |  2 +-
 .../sched_setscheduler/sched_setscheduler03.c |  4 +--
 .../kernel/syscalls/setregid/setregid04.c     |  9 ++++---
 .../kernel/syscalls/setrlimit/setrlimit05.c   |  2 +-
 .../kernel/syscalls/setrlimit/setrlimit06.c   |  2 +-
 20 files changed, 52 insertions(+), 54 deletions(-)

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index 9ff70b1bc..48fd06764 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -724,7 +724,7 @@ static void do_test(void)
 
 	execve(path, argv, environ);
 
-	tst_res(TBROK | TERRNO, "EXEC!");
+	tst_res(TFAIL | TERRNO, "EXEC!");
 }
 
 static struct tst_test test = {
@@ -1816,7 +1816,7 @@ static void run(void)
 	if (TST_RET > -1) {
 		tst_res(TFAIL, "Created raw socket");
 	} else if (TST_ERR != EPERM) {
-		tst_res(TBROK | TTERRNO,
+		tst_res(TFAIL | TTERRNO,
 			"Failed to create socket for wrong reason");
 	} else {
 		tst_res(TPASS | TTERRNO, "Didn't create raw socket");
diff --git a/lib/newlib_tests/test_exec.c b/lib/newlib_tests/test_exec.c
index 75f1b03a4..370a0b948 100644
--- a/lib/newlib_tests/test_exec.c
+++ b/lib/newlib_tests/test_exec.c
@@ -25,7 +25,7 @@ static void do_test(void)
 
 	execve(path, argv, environ);
 
-	tst_res(TBROK | TERRNO, "EXEC!");
+	tst_res(TFAIL | TERRNO, "EXEC!");
 }
 
 static struct tst_test test = {
diff --git a/lib/newlib_tests/tst_capability01.c b/lib/newlib_tests/tst_capability01.c
index 7d3f0f1ea..47ac04569 100644
--- a/lib/newlib_tests/tst_capability01.c
+++ b/lib/newlib_tests/tst_capability01.c
@@ -22,7 +22,7 @@ static void run(void)
 		tst_res(TFAIL, "Created raw socket");
 		SAFE_CLOSE(TST_RET);
 	} else if (TST_ERR != EPERM) {
-		tst_res(TBROK | TTERRNO,
+		tst_res(TFAIL | TTERRNO,
 			"Failed to create socket for wrong reason");
 	} else {
 		tst_res(TPASS | TTERRNO, "Didn't create raw socket");
diff --git a/testcases/cve/cve-2017-17052.c b/testcases/cve/cve-2017-17052.c
index 361ed66be..b97815708 100644
--- a/testcases/cve/cve-2017-17052.c
+++ b/testcases/cve/cve-2017-17052.c
@@ -112,7 +112,7 @@ static void run(void)
 	if (run == RUNS)
 		tst_res(TPASS, "kernel survived %d runs", run);
 	else
-		tst_res(TBROK, "something strange happened");
+		tst_res(TFAIL, "something strange happened");
 }
 
 static struct tst_test test = {
diff --git a/testcases/cve/meltdown.c b/testcases/cve/meltdown.c
index db00e1811..a387b3205 100644
--- a/testcases/cve/meltdown.c
+++ b/testcases/cve/meltdown.c
@@ -175,7 +175,7 @@ readbit(int fd, unsigned long addr, char bit)
 	for (i = 0; i < CYCLES; i++) {
 		ret = pread(fd, buf, sizeof(buf), 0);
 		if (ret < 0)
-			tst_res(TBROK | TERRNO, "can't read fd");
+			tst_res(TFAIL | TERRNO, "can't read fd");
 
 		clflush_target();
 
@@ -304,7 +304,7 @@ static void setup(void)
 	memset(target_array, 1, sizeof(target_array));
 
 	if (set_signal() < 0)
-		tst_res(TBROK | TERRNO, "set_signal");
+		tst_res(TFAIL | TERRNO, "set_signal");
 }
 
 #define READ_SIZE 32
@@ -320,7 +320,7 @@ static void run(void)
 
 	expected_len = pread(spec_fd, expected, sizeof(expected), 0);
 	if (expected_len < 0)
-		tst_res(TBROK | TERRNO, "can't read test fd");
+		tst_res(TFAIL | TERRNO, "can't read test fd");
 
 	/* read address of saved_cmdline_addr */
 	addr = saved_cmdline_addr;
diff --git a/testcases/kernel/crypto/af_alg05.c b/testcases/kernel/crypto/af_alg05.c
index df2b03546..e835b8a1f 100644
--- a/testcases/kernel/crypto/af_alg05.c
+++ b/testcases/kernel/crypto/af_alg05.c
@@ -35,11 +35,11 @@ static void run(void)
 	TEST(read(reqfd, buffer, 15));
 
 	if (TST_RET == 0)
-		tst_res(TBROK, "read() unexpectedly succeeded");
+		tst_res(TFAIL, "read() unexpectedly succeeded");
 	else if (TST_ERR == EINVAL)
 		tst_res(TPASS, "read() expectedly failed with EINVAL");
 	else
-		tst_res(TBROK | TTERRNO, "read() failed with unexpected error");
+		tst_res(TFAIL | TTERRNO, "read() failed with unexpected error");
 
 	close(reqfd);
 }
diff --git a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
index e3e3f6a7f..e6cf8bf09 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
@@ -223,7 +223,7 @@ static void stat_cleanup(void)
 	/* remove the parent's shared memory the second time through */
 	if (stat_time == SECOND)
 		if (shmdt(set_shared) == -1)
-			tst_res(TBROK | TERRNO, "shmdt in stat_cleanup()");
+			tst_res(TFAIL | TERRNO, "shmdt in stat_cleanup()");
 	stat_time++;
 }
 
@@ -246,7 +246,7 @@ static void func_set(void)
 {
 	/* first stat the shared memory to get the new data */
 	if (shmctl(shm_id_1, IPC_STAT, &buf) == -1) {
-		tst_res(TBROK | TERRNO, "shmctl in func_set()");
+		tst_res(TFAIL | TERRNO, "shmctl in func_set()");
 		return;
 	}
 
diff --git a/testcases/kernel/pty/pty03.c b/testcases/kernel/pty/pty03.c
index b79c499ef..8e05ad3be 100644
--- a/testcases/kernel/pty/pty03.c
+++ b/testcases/kernel/pty/pty03.c
@@ -85,7 +85,7 @@ static int set_ldisc(int tty, struct ldisc_info *ldisc)
 			"You don't appear to have the %s TTY line discipline",
 			ldisc->name);
 	} else {
-		tst_res(TBROK | TTERRNO,
+		tst_res(TFAIL | TTERRNO,
 			"Failed to set the %s line discipline", ldisc->name);
 	}
 
diff --git a/testcases/kernel/syscalls/fstat/fstat03.c b/testcases/kernel/syscalls/fstat/fstat03.c
index 68fae43df..4ff37e882 100644
--- a/testcases/kernel/syscalls/fstat/fstat03.c
+++ b/testcases/kernel/syscalls/fstat/fstat03.c
@@ -78,7 +78,7 @@ static void run(unsigned int tc_num)
 	if (WIFEXITED(status) && WEXITSTATUS(status) == 0)
 		return;
 
-	tst_res(TBROK, "child %s", tst_strstatus(status));
+	tst_res(TFAIL, "child %s", tst_strstatus(status));
 }
 
 static void setup(void)
diff --git a/testcases/kernel/syscalls/gettimeofday/gettimeofday02.c b/testcases/kernel/syscalls/gettimeofday/gettimeofday02.c
index 1d60f448e..e78bd7dca 100644
--- a/testcases/kernel/syscalls/gettimeofday/gettimeofday02.c
+++ b/testcases/kernel/syscalls/gettimeofday/gettimeofday02.c
@@ -48,16 +48,12 @@ static void verify_gettimeofday(void)
 
 	alarm(rtime);
 
-	if (gettimeofday(&tv1, NULL)) {
-		tst_res(TBROK | TERRNO, "gettimeofday() failed");
-		return;
-	}
+	if (gettimeofday(&tv1, NULL))
+		tst_brk(TFAIL | TERRNO, "gettimeofday() failed");
 
 	while (!done) {
-		if (gettimeofday(&tv2, NULL)) {
-			tst_res(TBROK | TERRNO, "gettimeofday() failed");
-			return;
-		}
+		if (gettimeofday(&tv2, NULL))
+			tst_brk(TFAIL | TERRNO, "gettimeofday() failed");
 
 		if (tv2.tv_sec < tv1.tv_sec ||
 		    (tv2.tv_sec == tv1.tv_sec && tv2.tv_usec < tv1.tv_usec)) {
@@ -72,7 +68,6 @@ static void verify_gettimeofday(void)
 		cnt++;
 	}
 
-
 	tst_res(TINFO, "gettimeofday() called %llu times", cnt);
 	tst_res(TPASS, "gettimeofday() monotonous in %i seconds", rtime);
 }
diff --git a/testcases/kernel/syscalls/io_pgetevents/io_pgetevents01.c b/testcases/kernel/syscalls/io_pgetevents/io_pgetevents01.c
index e80d7de9d..50d2c5f9a 100644
--- a/testcases/kernel/syscalls/io_pgetevents/io_pgetevents01.c
+++ b/testcases/kernel/syscalls/io_pgetevents/io_pgetevents01.c
@@ -9,6 +9,14 @@
 #include "lapi/io_pgetevents.h"
 
 #ifdef HAVE_LIBAIO
+static int fd;
+
+static void cleanup(void)
+{
+	if (fd > 0)
+		SAFE_CLOSE(fd);
+}
+
 static void run(void)
 {
 	struct io_event events[1];
@@ -25,16 +33,12 @@ static void run(void)
 	io_prep_pwrite(&cb, fd, data, 4096, 0);
 
 	ret = io_setup(1, &ctx);
-	if (ret < 0) {
-		tst_res(TBROK | TERRNO, "io_setup() failed");
-		goto exit;
-	}
+	if (ret < 0)
+		tst_brk(TBROK | TERRNO, "io_setup() failed");
 
 	ret = io_submit(ctx, 1, cbs);
-	if (ret != 1) {
-		tst_res(TBROK | TERRNO, "io_submit() failed");
-		goto exit;
-	}
+	if (ret != 1)
+		tst_brk(TBROK | TERRNO, "io_submit() failed");
 
 	/* get the reply */
 	ret = io_pgetevents(ctx, 1, 1, events, NULL, &sigmask);
@@ -45,16 +49,14 @@ static void run(void)
 		tst_res(TFAIL | TERRNO, "io_pgetevents() failed");
 
 	if (io_destroy(ctx) < 0)
-		tst_res(TBROK | TERRNO, "io_destroy() failed");
-
-exit:
-	SAFE_CLOSE(fd);
+		tst_brk(TBROK | TERRNO, "io_destroy() failed");
 }
 
 static struct tst_test test = {
 	.min_kver = "4.18",
 	.test_all = run,
 	.needs_tmpdir = 1,
+	.cleanup = cleanup,
 };
 
 #else
diff --git a/testcases/kernel/syscalls/io_pgetevents/io_pgetevents02.c b/testcases/kernel/syscalls/io_pgetevents/io_pgetevents02.c
index 117380f55..7cca7fc08 100644
--- a/testcases/kernel/syscalls/io_pgetevents/io_pgetevents02.c
+++ b/testcases/kernel/syscalls/io_pgetevents/io_pgetevents02.c
@@ -60,7 +60,7 @@ static void cleanup(void)
 {
 	if (ctx_initialized) {
 		if (io_destroy(ctx) < 0)
-			tst_res(TBROK | TERRNO, "io_destroy() failed");
+			tst_res(TWARN | TERRNO, "io_destroy() failed");
 	}
 
 	if (fd > 0)
diff --git a/testcases/kernel/syscalls/keyctl/keyctl05.c b/testcases/kernel/syscalls/keyctl/keyctl05.c
index c592eb49e..55ce852b8 100644
--- a/testcases/kernel/syscalls/keyctl/keyctl05.c
+++ b/testcases/kernel/syscalls/keyctl/keyctl05.c
@@ -103,7 +103,7 @@ static void test_update_nonupdatable(const char *type,
 				"and/or CONFIG_CRYPTO_SHA256)");
 			return;
 		}
-		tst_res(TBROK | TTERRNO, "unexpected error adding '%s' key",
+		tst_res(TFAIL | TTERRNO, "unexpected error adding '%s' key",
 			type);
 		return;
 	}
@@ -115,7 +115,7 @@ static void test_update_nonupdatable(const char *type,
 	 */
 	TEST(keyctl(KEYCTL_SETPERM, keyid, KEY_POS_ALL));
 	if (TST_RET != 0) {
-		tst_res(TBROK | TTERRNO,
+		tst_res(TFAIL | TTERRNO,
 			"failed to grant write permission to '%s' key", type);
 		return;
 	}
@@ -123,12 +123,12 @@ static void test_update_nonupdatable(const char *type,
 	tst_res(TINFO, "Try to update the '%s' key...", type);
 	TEST(keyctl(KEYCTL_UPDATE, keyid, payload, plen));
 	if (TST_RET == 0) {
-		tst_res(TBROK,
+		tst_res(TFAIL,
 			"updating '%s' key unexpectedly succeeded", type);
 		return;
 	}
 	if (TST_ERR != EOPNOTSUPP) {
-		tst_res(TBROK | TTERRNO,
+		tst_res(TFAIL | TTERRNO,
 			"updating '%s' key unexpectedly failed", type);
 		return;
 	}
@@ -151,7 +151,7 @@ static void test_update_setperm_race(void)
 	TEST(add_key("user", "desc", payload, sizeof(payload),
 		KEY_SPEC_SESSION_KEYRING));
 	if (TST_RET < 0) {
-		tst_res(TBROK | TTERRNO, "failed to add 'user' key");
+		tst_res(TFAIL | TTERRNO, "failed to add 'user' key");
 		return;
 	}
 	keyid = TST_RET;
@@ -172,7 +172,7 @@ static void test_update_setperm_race(void)
 	for (i = 0; i < 10000; i++) {
 		TEST(keyctl(KEYCTL_UPDATE, keyid, payload, sizeof(payload)));
 		if (TST_RET != 0 && TST_ERR != EACCES) {
-			tst_res(TBROK | TTERRNO, "failed to update 'user' key");
+			tst_res(TFAIL | TTERRNO, "failed to update 'user' key");
 			return;
 		}
 	}
diff --git a/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c b/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c
index e6e2fdff3..fac30a076 100644
--- a/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c
+++ b/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c
@@ -115,8 +115,8 @@ static int addr_on_node(void *addr)
 	ret = tst_syscall(__NR_get_mempolicy, &node, NULL, (unsigned long)0,
 		      (unsigned long)addr, MPOL_F_NODE | MPOL_F_ADDR);
 	if (ret == -1) {
-		tst_res(TBROK | TERRNO, "error getting memory policy "
-			 "for page %p", addr);
+		tst_res(TFAIL | TERRNO,
+				"error getting memory policy for page %p", addr);
 	}
 	return node;
 }
diff --git a/testcases/kernel/syscalls/mq_unlink/mq_unlink01.c b/testcases/kernel/syscalls/mq_unlink/mq_unlink01.c
index af79d9571..baca57948 100644
--- a/testcases/kernel/syscalls/mq_unlink/mq_unlink01.c
+++ b/testcases/kernel/syscalls/mq_unlink/mq_unlink01.c
@@ -85,7 +85,7 @@ static void do_test(unsigned int i)
 	fd = SAFE_MQ_OPEN(QUEUE_NAME, O_CREAT | O_EXCL | O_RDWR, S_IRWXU, NULL);
 
 	if (tc->as_nobody && seteuid(pw->pw_uid)) {
-		tst_res(TBROK | TERRNO, "seteuid failed");
+		tst_res(TFAIL | TERRNO, "seteuid failed");
 		goto EXIT;
 	}
 
diff --git a/testcases/kernel/syscalls/readahead/readahead01.c b/testcases/kernel/syscalls/readahead/readahead01.c
index e1967955a..a0be96065 100644
--- a/testcases/kernel/syscalls/readahead/readahead01.c
+++ b/testcases/kernel/syscalls/readahead/readahead01.c
@@ -61,7 +61,7 @@ static void test_bad_fd(void)
 	tst_res(TINFO, "test_bad_fd O_WRONLY");
 	fd = mkstemp(tempname);
 	if (fd == -1)
-		tst_res(TBROK | TERRNO, "mkstemp failed");
+		tst_res(TFAIL | TERRNO, "mkstemp failed");
 	SAFE_CLOSE(fd);
 	fd = SAFE_OPEN(tempname, O_WRONLY);
 	TEST(readahead(fd, 0, getpagesize()));
diff --git a/testcases/kernel/syscalls/sched_setscheduler/sched_setscheduler03.c b/testcases/kernel/syscalls/sched_setscheduler/sched_setscheduler03.c
index 22f4e34f4..9045d0366 100644
--- a/testcases/kernel/syscalls/sched_setscheduler/sched_setscheduler03.c
+++ b/testcases/kernel/syscalls/sched_setscheduler/sched_setscheduler03.c
@@ -130,11 +130,11 @@ static void setup(void)
 
 	tst_res(TINFO, "Setting init sched policy to SCHED_OTHER");
 	if (sched_setscheduler(0, SCHED_OTHER, &param[0]) != 0)
-		tst_res(TBROK | TERRNO,
+		tst_res(TFAIL | TERRNO,
 			 "ERROR sched_setscheduler: (0, SCHED_OTHER, param)");
 
 	if (sched_getscheduler(0) != SCHED_OTHER)
-		tst_res(TBROK | TERRNO, "ERROR sched_setscheduler");
+		tst_res(TFAIL | TERRNO, "ERROR sched_setscheduler");
 
 	tst_res(TINFO, "Setting euid to nobody to drop privilege");
 
diff --git a/testcases/kernel/syscalls/setregid/setregid04.c b/testcases/kernel/syscalls/setregid/setregid04.c
index d8e7c2dc2..9490ae173 100644
--- a/testcases/kernel/syscalls/setregid/setregid04.c
+++ b/testcases/kernel/syscalls/setregid/setregid04.c
@@ -69,12 +69,13 @@ static void run(unsigned int i)
 	TEST(SETREGID(*test_data[i].real_gid, *test_data[i].eff_gid));
 
 	if (TST_RET == -1) {
-		tst_res(TBROK | TTERRNO, "setregid(%d, %d) failed",
+		tst_res(TFAIL | TTERRNO, "setregid(%d, %d) failed",
 			*test_data[i].real_gid, *test_data[i].eff_gid);
-	} else {
-		gid_verify(test_data[i].exp_real_usr, test_data[i].exp_eff_usr,
-			   test_data[i].test_msg);
+		return;
 	}
+
+	gid_verify(test_data[i].exp_real_usr, test_data[i].exp_eff_usr,
+		   test_data[i].test_msg);
 }
 
 static void setup(void)
diff --git a/testcases/kernel/syscalls/setrlimit/setrlimit05.c b/testcases/kernel/syscalls/setrlimit/setrlimit05.c
index 077399e83..906396f01 100644
--- a/testcases/kernel/syscalls/setrlimit/setrlimit05.c
+++ b/testcases/kernel/syscalls/setrlimit/setrlimit05.c
@@ -57,7 +57,7 @@ static void verify_setrlimit(void)
 	if (WIFEXITED(status) && WEXITSTATUS(status) == 0)
 		return;
 
-	tst_res(TBROK, "child %s", tst_strstatus(status));
+	tst_res(TFAIL, "child %s", tst_strstatus(status));
 }
 
 static void setup(void)
diff --git a/testcases/kernel/syscalls/setrlimit/setrlimit06.c b/testcases/kernel/syscalls/setrlimit/setrlimit06.c
index 3e5bf1d42..9ff515d81 100644
--- a/testcases/kernel/syscalls/setrlimit/setrlimit06.c
+++ b/testcases/kernel/syscalls/setrlimit/setrlimit06.c
@@ -106,7 +106,7 @@ static void verify_setrlimit(void)
 		}
 	}
 
-	tst_res(TBROK, "Child %s", tst_strstatus(status));
+	tst_res(TFAIL, "Child %s", tst_strstatus(status));
 }
 
 static struct tst_test test = {
-- 
2.25.1

