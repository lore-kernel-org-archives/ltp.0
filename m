From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Mon,  6 Jul 2020 17:10:00 +0530
Subject: [LTP] [PATCH V7.1 07/19] syscalls/futex: Add support for time64
 tests
In-Reply-To: <6030fa8c1deda3aab977c7d5745c117fda87708a.1593152309.git.viresh.kumar@linaro.org>
References: <6030fa8c1deda3aab977c7d5745c117fda87708a.1593152309.git.viresh.kumar@linaro.org>
Message-ID: <8485ad1373a22b8f512eb17cf65d7662a7ede619.1594035467.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This adds support for time64 tests to the existing futex() syscall
tests.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V7.1:
- s/TTERRNO/TERRNO/ at many places
- Use TST_PROCESS_STATE_WAIT()
- Use PTHREAD and hugepage library helpers
- Many other cleanups that Cyril suggested

 .../syscalls/futex/futex_cmp_requeue01.c      |  34 +++-
 .../syscalls/futex/futex_cmp_requeue02.c      |  28 ++-
 testcases/kernel/syscalls/futex/futex_utils.h |  24 +--
 .../kernel/syscalls/futex/futex_wait01.c      |  75 ++++----
 .../kernel/syscalls/futex/futex_wait02.c      | 109 +++++------
 .../kernel/syscalls/futex/futex_wait03.c      |  94 +++++-----
 .../kernel/syscalls/futex/futex_wait04.c      |  79 ++++----
 .../kernel/syscalls/futex/futex_wait05.c      |   2 +-
 .../syscalls/futex/futex_wait_bitset01.c      |  50 ++++--
 .../kernel/syscalls/futex/futex_wake01.c      |  67 ++++---
 .../kernel/syscalls/futex/futex_wake02.c      | 110 ++++++------
 .../kernel/syscalls/futex/futex_wake03.c      | 114 ++++++------
 .../kernel/syscalls/futex/futex_wake04.c      | 169 +++++++-----------
 testcases/kernel/syscalls/futex/futextest.h   | 122 ++++++++-----
 14 files changed, 539 insertions(+), 538 deletions(-)

diff --git a/testcases/kernel/syscalls/futex/futex_cmp_requeue01.c b/testcases/kernel/syscalls/futex/futex_cmp_requeue01.c
index c50fade9f969..537641766357 100644
--- a/testcases/kernel/syscalls/futex/futex_cmp_requeue01.c
+++ b/testcases/kernel/syscalls/futex/futex_cmp_requeue01.c
@@ -42,14 +42,29 @@ static struct tcase {
 	{1000, 300, 500},
 };
 
+static struct test_variants {
+	enum futex_fn_type fntype;
+	enum tst_ts_type tstype;
+	char *desc;
+} variants[] = {
+#if (__NR_futex != __LTP__NR_INVALID_SYSCALL)
+	{ .fntype = FUTEX_FN_FUTEX, .tstype = TST_KERN_OLD_TIMESPEC, .desc = "syscall with old kernel spec"},
+#endif
+
+#if (__NR_futex_time64 != __LTP__NR_INVALID_SYSCALL)
+	{ .fntype = FUTEX_FN_FUTEX64, .tstype = TST_KERN_TIMESPEC, .desc = "syscall time64 with kernel spec"},
+#endif
+};
+
 static void do_child(void)
 {
+	struct test_variants *tv = &variants[tst_variant];
+	struct tst_ts usec = tst_ts_from_ms(tv->tstype, max_sleep_ms);
 	int slept_for_ms = 0;
-	struct timespec usec = tst_timespec_from_ms(max_sleep_ms);
 	int pid = getpid();
 	int ret = 0;
 
-	if (futex_wait(&sd->futexes[0], sd->futexes[0], &usec, 0) == -1) {
+	if (futex_wait(tv->fntype, &sd->futexes[0], sd->futexes[0], &usec, 0) == -1) {
 		if (errno == EAGAIN) {
 			/* spurious wakeup or signal */
 			tst_atomic_inc(&sd->spurious);
@@ -72,6 +87,7 @@ static void do_child(void)
 
 static void verify_futex_cmp_requeue(unsigned int n)
 {
+	struct test_variants *tv = &variants[tst_variant];
 	int num_requeues = 0, num_waits = 0, num_total = 0;
 	int i, status, spurious, woken_up;
 	struct tcase *tc = &tcases[n];
@@ -104,8 +120,8 @@ static void verify_futex_cmp_requeue(unsigned int n)
 	 * specifies an upper limit on the number of waiters that are requeued.
 	 * Returns the total number of waiters that were woken up or requeued.
 	 */
-	TEST(futex_cmp_requeue(&sd->futexes[0], sd->futexes[0], &sd->futexes[1],
-		tc->set_wakes, tc->set_requeues, 0));
+	TEST(futex_cmp_requeue(tv->fntype, &sd->futexes[0], sd->futexes[0],
+			&sd->futexes[1], tc->set_wakes, tc->set_requeues, 0));
 
 	/* Fail if more than requested wakes + requeues were returned */
 	if (TST_RET > exp_ret) {
@@ -115,8 +131,8 @@ static void verify_futex_cmp_requeue(unsigned int n)
 		tst_res(TINFO, "futex_cmp_requeue() returned %ld", TST_RET);
 	}
 
-	num_requeues = futex_wake(&sd->futexes[1], tc->num_waiters, 0);
-	num_waits = futex_wake(&sd->futexes[0], tc->num_waiters, 0);
+	num_requeues = futex_wake(tv->fntype, &sd->futexes[1], tc->num_waiters, 0);
+	num_waits = futex_wake(tv->fntype, &sd->futexes[0], tc->num_waiters, 0);
 
 	tst_atomic_store(1, &sd->test_done);
 	for (i = 0; i < tc->num_waiters; i++) {
@@ -178,6 +194,11 @@ static void verify_futex_cmp_requeue(unsigned int n)
 
 static void setup(void)
 {
+	struct test_variants *tv = &variants[tst_variant];
+
+	tst_res(TINFO, "Testing variant: %s", tv->desc);
+	futex_supported_by_kernel(tv->fntype);
+
 	max_sleep_ms = tst_multiply_timeout(5000);
 
 	sd = SAFE_MMAP(NULL, sizeof(*sd), PROT_READ | PROT_WRITE,
@@ -198,5 +219,6 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.tcnt = ARRAY_SIZE(tcases),
 	.test = verify_futex_cmp_requeue,
+	.test_variants = ARRAY_SIZE(variants),
 	.forks_child = 1,
 };
diff --git a/testcases/kernel/syscalls/futex/futex_cmp_requeue02.c b/testcases/kernel/syscalls/futex/futex_cmp_requeue02.c
index 228d8cff6ea0..e5257ec18369 100644
--- a/testcases/kernel/syscalls/futex/futex_cmp_requeue02.c
+++ b/testcases/kernel/syscalls/futex/futex_cmp_requeue02.c
@@ -32,29 +32,48 @@ static struct tcase {
 	{1, 1, FUTEX_INITIALIZER + 1, EAGAIN},
 };
 
+static struct test_variants {
+	enum futex_fn_type fntype;
+	char *desc;
+} variants[] = {
+#if (__NR_futex != __LTP__NR_INVALID_SYSCALL)
+	{ .fntype = FUTEX_FN_FUTEX, .desc = "syscall with old kernel spec"},
+#endif
+
+#if (__NR_futex_time64 != __LTP__NR_INVALID_SYSCALL)
+	{ .fntype = FUTEX_FN_FUTEX64, .desc = "syscall time64 with kernel spec"},
+#endif
+};
+
 static void verify_futex_cmp_requeue(unsigned int n)
 {
+	struct test_variants *tv = &variants[tst_variant];
 	struct tcase *tc = &tcases[n];
 
-	TEST(futex_cmp_requeue(&futexes[0], tc->exp_val, &futexes[1],
-	     tc->set_wakes, tc->set_requeues, 0));
+	TEST(futex_cmp_requeue(tv->fntype, &futexes[0], tc->exp_val,
+			&futexes[1], tc->set_wakes, tc->set_requeues, 0));
 	if (TST_RET != -1) {
 		tst_res(TFAIL, "futex_cmp_requeue() succeeded unexpectedly");
 		return;
 	}
 
 	if (TST_ERR != tc->exp_errno) {
-		tst_res(TFAIL | TTERRNO,
+		tst_res(TFAIL | TERRNO,
 			"futex_cmp_requeue() failed unexpectedly, expected %s",
 			tst_strerrno(tc->exp_errno));
 		return;
 	}
 
-	tst_res(TPASS | TTERRNO, "futex_cmp_requeue() failed as expected");
+	tst_res(TPASS | TERRNO, "futex_cmp_requeue() failed as expected");
 }
 
 static void setup(void)
 {
+	struct test_variants *tv = &variants[tst_variant];
+
+	tst_res(TINFO, "Testing variant: %s", tv->desc);
+	futex_supported_by_kernel(tv->fntype);
+
 	futexes = SAFE_MMAP(NULL, sizeof(futex_t) * 2, PROT_READ | PROT_WRITE,
 			    MAP_ANONYMOUS | MAP_SHARED, -1, 0);
 
@@ -73,6 +92,7 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.test = verify_futex_cmp_requeue,
 	.tcnt = ARRAY_SIZE(tcases),
+	.test_variants = ARRAY_SIZE(variants),
 	.tags = (const struct tst_tag[]) {
 		{"CVE", "2018-6927"},
 		{"linux-git", "fbe0e839d1e2"},
diff --git a/testcases/kernel/syscalls/futex/futex_utils.h b/testcases/kernel/syscalls/futex/futex_utils.h
index 63b97c00b631..bdcbc90d5b2d 100644
--- a/testcases/kernel/syscalls/futex/futex_utils.h
+++ b/testcases/kernel/syscalls/futex/futex_utils.h
@@ -20,10 +20,13 @@
 #ifndef FUTEX_UTILS_H__
 #define FUTEX_UTILS_H__
 
+#include <stdio.h>
+#include <stdlib.h>
+
 /*
  * Wait for nr_threads to be sleeping
  */
-static int wait_for_threads(unsigned int nr_threads)
+static inline int wait_for_threads(unsigned int nr_threads)
 {
 	char thread_state, name[1024];
 	DIR *dir;
@@ -32,34 +35,33 @@ static int wait_for_threads(unsigned int nr_threads)
 
 	snprintf(name, sizeof(name), "/proc/%i/task/", getpid());
 
-	dir = SAFE_OPENDIR(NULL, name);
+	dir = SAFE_OPENDIR(name);
 
-	while ((dent = SAFE_READDIR(NULL, dir))) {
+	while ((dent = SAFE_READDIR(dir))) {
 		/* skip ".", ".." and the main thread */
 		if (atoi(dent->d_name) == getpid() || atoi(dent->d_name) == 0)
 			continue;
 
 		snprintf(name, sizeof(name), "/proc/%i/task/%s/stat",
-		         getpid(), dent->d_name);
+			 getpid(), dent->d_name);
 
-		SAFE_FILE_SCANF(NULL, name, "%*i %*s %c", &thread_state);
+		SAFE_FILE_SCANF(name, "%*i %*s %c", &thread_state);
 
 		if (thread_state != 'S') {
-			tst_resm(TINFO, "Thread %s not sleeping yet", dent->d_name);
-			SAFE_CLOSEDIR(NULL, dir);
+			tst_res(TINFO, "Thread %s not sleeping yet", dent->d_name);
+			SAFE_CLOSEDIR(dir);
 			return 1;
 		}
 		cnt++;
 	}
 
-	SAFE_CLOSEDIR(NULL, dir);
+	SAFE_CLOSEDIR(dir);
 
 	if (cnt != nr_threads) {
-		tst_resm(TINFO, "%u threads sleeping, expected %u",
-	                  cnt, nr_threads);
+		tst_res(TINFO, "%u threads sleeping, expected %u", cnt,
+			nr_threads);
 	}
 
 	return 0;
 }
-
 #endif /* FUTEX_UTILS_H__ */
diff --git a/testcases/kernel/syscalls/futex/futex_wait01.c b/testcases/kernel/syscalls/futex/futex_wait01.c
index 51a540d9e315..9b5846f932c5 100644
--- a/testcases/kernel/syscalls/futex/futex_wait01.c
+++ b/testcases/kernel/syscalls/futex/futex_wait01.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (C) 2015 Cyril Hrubis <chrubis@suse.cz>
  *
@@ -5,34 +6,15 @@
  * written by Darren Hart <dvhltc@us.ibm.com>
  *            Gowrishankar <gowrishankar.m@in.ibm.com>
  *
- * Licensed under the GNU GPLv2 or later.
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program;  if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * 1. Block on a futex and wait for timeout.
+ * 2. Test if FUTEX_WAIT op returns -EWOULDBLOCK if the futex value differs
+ *    from the expected one.
  */
- /*
-  * 1. Block on a futex and wait for timeout.
-  * 2. Test if FUTEX_WAIT op returns -EWOULDBLOCK if the futex value differs
-  *    from the expected one.
-  */
 
 #include <errno.h>
 
-#include "test.h"
 #include "futextest.h"
 
-const char *TCID="futex_wait01";
-
 struct testcase {
 	futex_t *f_addr;
 	futex_t f_val;
@@ -41,7 +23,6 @@ struct testcase {
 };
 
 static futex_t futex = FUTEX_INITIALIZER;
-static struct timespec to = {.tv_sec = 0, .tv_nsec = 10000};
 
 static struct testcase testcases[] = {
 	{&futex, FUTEX_INITIALIZER, 0, ETIMEDOUT},
@@ -50,38 +31,54 @@ static struct testcase testcases[] = {
 	{&futex, FUTEX_INITIALIZER+1, FUTEX_PRIVATE_FLAG, EWOULDBLOCK},
 };
 
-const int TST_TOTAL=ARRAY_SIZE(testcases);
+static struct test_variants {
+	enum futex_fn_type fntype;
+	enum tst_ts_type tstype;
+	char *desc;
+} variants[] = {
+#if (__NR_futex != __LTP__NR_INVALID_SYSCALL)
+	{ .fntype = FUTEX_FN_FUTEX, .tstype = TST_KERN_OLD_TIMESPEC, .desc = "syscall with old kernel spec"},
+#endif
+
+#if (__NR_futex_time64 != __LTP__NR_INVALID_SYSCALL)
+	{ .fntype = FUTEX_FN_FUTEX64, .tstype = TST_KERN_TIMESPEC, .desc = "syscall time64 with kernel spec"},
+#endif
+};
 
-static void verify_futex_wait(struct testcase *tc)
+static void run(unsigned int n)
 {
+	struct test_variants *tv = &variants[tst_variant];
+	struct testcase *tc = &testcases[n];
+	struct tst_ts to = tst_ts_from_ns(tv->tstype, 10000);
 	int res;
 
-	res = futex_wait(tc->f_addr, tc->f_val, &to, tc->opflags);
+	res = futex_wait(tv->fntype, tc->f_addr, tc->f_val, &to, tc->opflags);
 
 	if (res != -1) {
-		tst_resm(TFAIL, "futex_wait() returned %i, expected -1", res);
+		tst_res(TFAIL, "futex_wait() succeeded unexpectedly");
 		return;
 	}
 
 	if (errno != tc->exp_errno) {
-		tst_resm(TFAIL | TERRNO, "expected errno=%s",
+		tst_res(TFAIL | TERRNO, "futex_wait() failed with incorrect error, expected errno=%s",
 		         tst_strerrno(tc->exp_errno));
 		return;
 	}
 
-	tst_resm(TPASS | TERRNO, "futex_wait()");
+	tst_res(TPASS | TERRNO, "futex_wait() passed");
 }
 
-int main(int argc, char *argv[])
+static void setup(void)
 {
-	int lc, i;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
+	struct test_variants *tv = &variants[tst_variant];
 
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		for (i = 0; i < TST_TOTAL; i++)
-			verify_futex_wait(testcases + i);
-	}
-
-	tst_exit();
+	tst_res(TINFO, "Testing variant: %s", tv->desc);
+	futex_supported_by_kernel(tv->fntype);
 }
+
+static struct tst_test test = {
+	.setup = setup,
+	.test = run,
+	.tcnt = ARRAY_SIZE(testcases),
+	.test_variants = ARRAY_SIZE(variants),
+};
diff --git a/testcases/kernel/syscalls/futex/futex_wait02.c b/testcases/kernel/syscalls/futex/futex_wait02.c
index 1ca1df457b4a..092e540f5fb7 100644
--- a/testcases/kernel/syscalls/futex/futex_wait02.c
+++ b/testcases/kernel/syscalls/futex/futex_wait02.c
@@ -1,105 +1,84 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (C) 2015 Cyril Hrubis <chrubis@suse.cz>
  *
- * Licensed under the GNU GPLv2 or later.
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
+ * Block on a futex and wait for wakeup.
  *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program;  if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * This tests uses shared memory page to store the mutex variable.
  */
- /*
-  * Block on a futex and wait for wakeup.
-  *
-  * This tests uses shared memory page to store the mutex variable.
-  */
 
 #include <sys/mman.h>
 #include <sys/wait.h>
 #include <errno.h>
 
-#include "test.h"
-#include "safe_macros.h"
 #include "futextest.h"
-
-const char *TCID="futex_wait02";
-const int TST_TOTAL=1;
+#include "futex_utils.h"
 
 static futex_t *futex;
 
+static struct test_variants {
+	enum futex_fn_type fntype;
+	char *desc;
+} variants[] = {
+#if (__NR_futex != __LTP__NR_INVALID_SYSCALL)
+	{ .fntype = FUTEX_FN_FUTEX, .desc = "syscall with old kernel spec"},
+#endif
+
+#if (__NR_futex_time64 != __LTP__NR_INVALID_SYSCALL)
+	{ .fntype = FUTEX_FN_FUTEX64, .desc = "syscall time64 with kernel spec"},
+#endif
+};
+
 static void do_child(void)
 {
+	struct test_variants *tv = &variants[tst_variant];
 	int ret;
 
-	tst_process_state_wait2(getppid(), 'S');
+	TST_PROCESS_STATE_WAIT(getppid(), 'S', 1000);
 
-	ret = futex_wake(futex, 1, 0);
+	ret = futex_wake(tv->fntype, futex, 1, 0);
 
 	if (ret != 1)
-		tst_brkm(TFAIL, NULL, "futex_wake() returned %i", ret);
+		tst_res(TFAIL | TERRNO, "futex_wake() failed");
 
-	exit(TPASS);
+	exit(0);
 }
 
-static void verify_futex_wait(void)
+static void run(void)
 {
-	int res;
-	int pid;
+	struct test_variants *tv = &variants[tst_variant];
+	int res, pid;
 
-	pid = tst_fork();
-
-	switch (pid) {
-	case 0:
+	pid = SAFE_FORK();
+	if (!pid)
 		do_child();
-	break;
-	case -1:
-		tst_brkm(TBROK | TERRNO, NULL, "fork() failed");
-	break;
-	default:
-	break;
-	}
-
-	res = futex_wait(futex, *futex, NULL, 0);
 
+	res = futex_wait(tv->fntype, futex, *futex, NULL, 0);
 	if (res) {
-		tst_resm(TFAIL, "futex_wait() returned %i, errno %s",
-		         res, tst_strerrno(errno));
+		tst_res(TFAIL | TERRNO, "futex_wait() failed");
+		return;
 	}
 
-	SAFE_WAIT(NULL, &res);
-
-	if (WIFEXITED(res) && WEXITSTATUS(res) == TPASS)
-		tst_resm(TPASS, "futex_wait() woken up");
-	else
-		tst_resm(TFAIL, "child failed");
+	SAFE_WAIT(NULL);
+	tst_res(TPASS, "futex_wait() woken up");
 }
 
 static void setup(void)
 {
-	futex = SAFE_MMAP(NULL, NULL, sizeof(*futex), PROT_READ | PROT_WRITE,
+	struct test_variants *tv = &variants[tst_variant];
+
+	tst_res(TINFO, "Testing variant: %s", tv->desc);
+	futex_supported_by_kernel(tv->fntype);
+
+	futex = SAFE_MMAP(NULL, sizeof(*futex), PROT_READ | PROT_WRITE,
 			  MAP_ANONYMOUS | MAP_SHARED, -1, 0);
 
 	*futex = FUTEX_INITIALIZER;
 }
 
-int main(int argc, char *argv[])
-{
-	int lc;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++)
-		verify_futex_wait();
-
-	tst_exit();
-}
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = run,
+	.test_variants = ARRAY_SIZE(variants),
+	.forks_child = 1,
+};
diff --git a/testcases/kernel/syscalls/futex/futex_wait03.c b/testcases/kernel/syscalls/futex/futex_wait03.c
index 9683e76503c0..94d522dcb75a 100644
--- a/testcases/kernel/syscalls/futex/futex_wait03.c
+++ b/testcases/kernel/syscalls/futex/futex_wait03.c
@@ -1,87 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (C) 2015 Cyril Hrubis <chrubis@suse.cz>
  *
- * Licensed under the GNU GPLv2 or later.
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
+ * Block on a futex and wait for wakeup.
  *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program;  if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * This tests uses private mutexes with threads.
  */
- /*
-  * Block on a futex and wait for wakeup.
-  *
-  * This tests uses private mutexes with threads.
-  */
 
 #include <errno.h>
 #include <pthread.h>
 
-#include "test.h"
 #include "futextest.h"
-
-const char *TCID="futex_wait03";
-const int TST_TOTAL=1;
+#include "futex_utils.h"
+#include "tst_safe_pthread.h"
 
 static futex_t futex = FUTEX_INITIALIZER;
 
+static struct test_variants {
+	enum futex_fn_type fntype;
+	char *desc;
+} variants[] = {
+#if (__NR_futex != __LTP__NR_INVALID_SYSCALL)
+	{ .fntype = FUTEX_FN_FUTEX, .desc = "syscall with old kernel spec"},
+#endif
+
+#if (__NR_futex_time64 != __LTP__NR_INVALID_SYSCALL)
+	{ .fntype = FUTEX_FN_FUTEX64, .desc = "syscall time64 with kernel spec"},
+#endif
+};
+
 static void *threaded(void *arg LTP_ATTRIBUTE_UNUSED)
 {
+	struct test_variants *tv = &variants[tst_variant];
 	long ret;
 
-	tst_process_state_wait2(getpid(), 'S');
+	TST_PROCESS_STATE_WAIT(getppid(), 'S', 1000);
 
-	ret = futex_wake(&futex, 1, FUTEX_PRIVATE_FLAG);
+	ret = futex_wake(tv->fntype, &futex, 1, FUTEX_PRIVATE_FLAG);
+	if (ret != 1)
+		tst_res(TFAIL, "futex_wake() returned %li", ret);
 
 	return (void*)ret;
 }
 
-static void verify_futex_wait(void)
+static void run(void)
 {
-	long ret;
-	int res;
+	struct test_variants *tv = &variants[tst_variant];
+	long res;
 	pthread_t t;
 
-	res = pthread_create(&t, NULL, threaded, NULL);
-	if (res) {
-		tst_brkm(TBROK, NULL, "pthread_create(): %s",
-	                 tst_strerrno(res));
-	}
+	SAFE_PTHREAD_CREATE(&t, NULL, threaded, NULL);
 
-	res = futex_wait(&futex, futex, NULL, FUTEX_PRIVATE_FLAG);
+	res = futex_wait(tv->fntype, &futex, futex, NULL, FUTEX_PRIVATE_FLAG);
 	if (res) {
-		tst_resm(TFAIL, "futex_wait() returned %i, errno %s",
-	                 res, tst_strerrno(errno));
-		pthread_join(t, NULL);
+		tst_res(TFAIL | TERRNO, "futex_wait() failed");
+		SAFE_PTHREAD_JOIN(t, NULL);
 		return;
 	}
 
-	res = pthread_join(t, (void*)&ret);
-	if (res)
-		tst_brkm(TBROK, NULL, "pthread_join(): %s", tst_strerrno(res));
-
-	if (ret != 1)
-		tst_resm(TFAIL, "futex_wake() returned %li", ret);
-	else
-		tst_resm(TPASS, "futex_wait() woken up");
+	SAFE_PTHREAD_JOIN(t, NULL);
+	tst_res(TPASS, "futex_wait() woken up");
 }
 
-int main(int argc, char *argv[])
+static void setup(void)
 {
-	int lc;
+	struct test_variants *tv = &variants[tst_variant];
 
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	for (lc = 0; TEST_LOOPING(lc); lc++)
-		verify_futex_wait();
-
-	tst_exit();
+	tst_res(TINFO, "Testing variant: %s", tv->desc);
+	futex_supported_by_kernel(tv->fntype);
 }
+
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = run,
+	.test_variants = ARRAY_SIZE(variants),
+};
diff --git a/testcases/kernel/syscalls/futex/futex_wait04.c b/testcases/kernel/syscalls/futex/futex_wait04.c
index b8360ff80914..f2885c8b27d5 100644
--- a/testcases/kernel/syscalls/futex/futex_wait04.c
+++ b/testcases/kernel/syscalls/futex/futex_wait04.c
@@ -1,65 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (C) 2015 Cyril Hrubis <chrubis@suse.cz>
  *
  * Based on futextest (futext_wait_uninitialized_heap.c)
  * written by KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
  *
- * Licensed under the GNU GPLv2 or later.
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program;  if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * Wait on uninitialized heap. It shold be zero and FUTEX_WAIT should return
+ * immediately. This test tests zero page handling in futex code.
  */
- /*
-  * Wait on uninitialized heap. It shold be zero and FUTEX_WAIT should return
-  * immediately. This test tests zero page handling in futex code.
-  */
 
 #include <errno.h>
 
-#include "test.h"
-#include "safe_macros.h"
 #include "futextest.h"
 
-const char *TCID="futex_wait04";
-const int TST_TOTAL=1;
-static struct timespec to = {.tv_sec = 0, .tv_nsec = 10000};
-
-static void verify_futex_wait(void)
+static struct test_variants {
+	enum futex_fn_type fntype;
+	enum tst_ts_type tstype;
+	char *desc;
+} variants[] = {
+#if (__NR_futex != __LTP__NR_INVALID_SYSCALL)
+	{ .fntype = FUTEX_FN_FUTEX, .tstype = TST_KERN_OLD_TIMESPEC, .desc = "syscall with old kernel spec"},
+#endif
+
+#if (__NR_futex_time64 != __LTP__NR_INVALID_SYSCALL)
+	{ .fntype = FUTEX_FN_FUTEX64, .tstype = TST_KERN_TIMESPEC, .desc = "syscall time64 with kernel spec"},
+#endif
+};
+
+static void run(void)
 {
-	int res;
-	void *buf;
+	struct test_variants *tv = &variants[tst_variant];
+	struct tst_ts to = tst_ts_from_ns(tv->tstype, 10000);
 	size_t pagesize = getpagesize();
-	buf = SAFE_MMAP(NULL, NULL, pagesize, PROT_READ|PROT_WRITE,
-                        MAP_PRIVATE|MAP_ANONYMOUS, 0, 0);
+	void *buf;
+	int res;
 
-	res = futex_wait(buf, 1, &to, 0);
+	buf = SAFE_MMAP(NULL, pagesize, PROT_READ|PROT_WRITE,
+			MAP_PRIVATE|MAP_ANONYMOUS, 0, 0);
 
+	res = futex_wait(tv->fntype, buf, 1, &to, 0);
 	if (res == -1 && errno == EWOULDBLOCK)
-		tst_resm(TPASS | TERRNO, "futex_wait() returned %i", res);
+		tst_res(TPASS | TERRNO, "futex_wait() returned %i", res);
 	else
-		tst_resm(TFAIL | TERRNO, "futex_wait() returned %i", res);
+		tst_res(TFAIL | TERRNO, "futex_wait() returned %i", res);
 
-	SAFE_MUNMAP(NULL, buf, pagesize);
+	SAFE_MUNMAP(buf, pagesize);
 }
 
-int main(int argc, char *argv[])
+static void setup(void)
 {
-	int lc;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
+	struct test_variants *tv = &variants[tst_variant];
 
-	for (lc = 0; TEST_LOOPING(lc); lc++)
-		verify_futex_wait();
-
-	tst_exit();
+	tst_res(TINFO, "Testing variant: %s", tv->desc);
+	futex_supported_by_kernel(tv->fntype);
 }
+
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = run,
+	.test_variants = ARRAY_SIZE(variants),
+};
diff --git a/testcases/kernel/syscalls/futex/futex_wait05.c b/testcases/kernel/syscalls/futex/futex_wait05.c
index 2573ae177d5b..8fad5d858716 100644
--- a/testcases/kernel/syscalls/futex/futex_wait05.c
+++ b/testcases/kernel/syscalls/futex/futex_wait05.c
@@ -19,7 +19,7 @@ int sample_fn(int clk_id, long long usec)
 	futex_t futex = FUTEX_INITIALIZER;
 
 	tst_timer_start(clk_id);
-	TEST(futex_wait(&futex, futex, &to, 0));
+	TEST(syscall(SYS_futex, &futex, FUTEX_WAIT, futex, &to, NULL, 0));
 	tst_timer_stop();
 	tst_timer_sample();
 
diff --git a/testcases/kernel/syscalls/futex/futex_wait_bitset01.c b/testcases/kernel/syscalls/futex/futex_wait_bitset01.c
index fc5656060951..cfde61083de2 100644
--- a/testcases/kernel/syscalls/futex/futex_wait_bitset01.c
+++ b/testcases/kernel/syscalls/futex/futex_wait_bitset01.c
@@ -23,22 +23,40 @@ static struct test_case_t {
 	{ CLOCK_REALTIME }
 };
 
+static struct test_variants {
+	enum futex_fn_type fntype;
+	enum tst_ts_type tstype;
+	int (*gettime)(clockid_t clk_id, void *ts);
+	char *desc;
+} variants[] = {
+#if (__NR_futex != __LTP__NR_INVALID_SYSCALL)
+	{ .fntype = FUTEX_FN_FUTEX, .tstype = TST_KERN_OLD_TIMESPEC, .gettime = sys_clock_gettime, .desc = "syscall with old kernel spec"},
+#endif
+
+#if (__NR_futex_time64 != __LTP__NR_INVALID_SYSCALL)
+	{ .fntype = FUTEX_FN_FUTEX64, .tstype = TST_KERN_TIMESPEC, .gettime = sys_clock_gettime64, .desc = "syscall time64 with kernel spec"},
+#endif
+};
+
 static void verify_futex_wait_bitset(long long wait_us, clock_t clk_id)
 {
-	struct timespec start, to, end;
+	struct test_variants *tv = &variants[tst_variant];
+	struct tst_ts start, to, end;
 	futex_t futex = FUTEX_INITIALIZER;
 	u_int32_t bitset = 0xffffffff;
 	int flags = clk_id == CLOCK_REALTIME ? FUTEX_CLOCK_REALTIME : 0;
 
+	start.type = end.type = to.type = tv->tstype;
+
 	tst_res(TINFO, "testing futex_wait_bitset() timeout with %s",
 		clk_id == CLOCK_REALTIME ? "CLOCK_REALTIME" : "CLOCK_MONOTONIC");
 
-	clock_gettime(clk_id, &start);
-	to = tst_timespec_add_us(start, wait_us);
+	tv->gettime(clk_id, tst_ts_get(&start));
+	to = tst_ts_add_us(start, wait_us);
 
-	TEST(futex_wait_bitset(&futex, futex, &to, bitset, flags));
+	TEST(futex_wait_bitset(tv->fntype, &futex, futex, &to, bitset, flags));
 
-	clock_gettime(clk_id, &end);
+	tv->gettime(clk_id, tst_ts_get(&end));
 
 	if (TST_RET != -1) {
 		tst_res(TFAIL, "futex_wait_bitset() returned %li, expected -1",
@@ -53,27 +71,27 @@ static void verify_futex_wait_bitset(long long wait_us, clock_t clk_id)
 	}
 
 	if (TST_ERR != ETIMEDOUT) {
-		tst_res(TFAIL | TTERRNO, "expected %s",
+		tst_res(TFAIL | TERRNO, "expected %s",
 			tst_strerrno(ETIMEDOUT));
 		return;
 	}
 
-	if (tst_timespec_lt(end, to)) {
+	if (tst_ts_lt(end, to)) {
 		tst_res(TFAIL,
 			"futex_wait_bitset() woken up prematurely %llius, expected %llius",
-			tst_timespec_diff_us(end, start), wait_us);
+			tst_ts_diff_us(end, start), wait_us);
 		return;
 	}
 
-	if (tst_timespec_diff_us(end, to) > THRESHOLD_US) {
+	if (tst_ts_diff_us(end, to) > THRESHOLD_US) {
 		tst_res(TFAIL,
 			"futex_wait_bitset() waited too long %llius, expected %llius",
-			tst_timespec_diff_us(end, start), wait_us);
+			tst_ts_diff_us(end, start), wait_us);
 		return;
 	}
 
 	tst_res(TPASS, "futex_wait_bitset() waited %llius, expected %llius",
-		tst_timespec_diff_us(end, start), wait_us);
+		tst_ts_diff_us(end, start), wait_us);
 }
 
 static void run(unsigned int n)
@@ -81,7 +99,17 @@ static void run(unsigned int n)
 	verify_futex_wait_bitset(DEFAULT_TIMEOUT_US, tcases[n].clk_id);
 }
 
+static void setup(void)
+{
+	struct test_variants *tv = &variants[tst_variant];
+
+	tst_res(TINFO, "Testing variant: %s", tv->desc);
+	futex_supported_by_kernel(tv->fntype);
+}
+
 static struct tst_test test = {
+	.setup = setup,
 	.test = run,
 	.tcnt = ARRAY_SIZE(tcases),
+	.test_variants = ARRAY_SIZE(variants),
 };
diff --git a/testcases/kernel/syscalls/futex/futex_wake01.c b/testcases/kernel/syscalls/futex/futex_wake01.c
index 42ea6f6e6a75..f2f682fe7e2e 100644
--- a/testcases/kernel/syscalls/futex/futex_wake01.c
+++ b/testcases/kernel/syscalls/futex/futex_wake01.c
@@ -1,33 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (C) 2015 Cyril Hrubis <chrubis@suse.cz>
  *
- * Licensed under the GNU GPLv2 or later.
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program;  if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * futex_wake() returns 0 (0 woken up processes) when no processes wait on the mutex.
  */
- /*
-  * futex_wake() returns 0 (0 woken up processes) when no processes wait on the mutex.
-  */
 
 #include <errno.h>
 #include <limits.h>
 
-#include "test.h"
 #include "futextest.h"
 
-const char *TCID="futex_wake01";
-
 struct testcase {
 	futex_t *f_addr;
 	int nr_wake;
@@ -46,32 +28,45 @@ static struct testcase testcases[] = {
 	{&futex, INT_MAX, FUTEX_PRIVATE_FLAG},
 };
 
-const int TST_TOTAL=ARRAY_SIZE(testcases);
+static struct test_variants {
+	enum futex_fn_type fntype;
+	char *desc;
+} variants[] = {
+#if (__NR_futex != __LTP__NR_INVALID_SYSCALL)
+	{ .fntype = FUTEX_FN_FUTEX, .desc = "syscall with old kernel spec"},
+#endif
 
-static void verify_futex_wake(struct testcase *tc)
+#if (__NR_futex_time64 != __LTP__NR_INVALID_SYSCALL)
+	{ .fntype = FUTEX_FN_FUTEX64, .desc = "syscall time64 with kernel spec"},
+#endif
+};
+
+static void run(unsigned int n)
 {
+	struct test_variants *tv = &variants[tst_variant];
+	struct testcase *tc = &testcases[n];
 	int res;
 
-	res = futex_wake(tc->f_addr, tc->nr_wake, tc->opflags);
-
+	res = futex_wake(tv->fntype, tc->f_addr, tc->nr_wake, tc->opflags);
 	if (res != 0) {
-		tst_resm(TFAIL, "futex_wake() returned %i, expected 0", res);
+		tst_res(TFAIL | TERRNO, "futex_wake() failed");
 		return;
 	}
 
-	tst_resm(TPASS, "futex_wake() returned 0");
+	tst_res(TPASS, "futex_wake() passed");
 }
 
-int main(int argc, char *argv[])
+static void setup(void)
 {
-	int lc, i;
+	struct test_variants *tv = &variants[tst_variant];
 
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		for (i = 0; i < TST_TOTAL; i++)
-			verify_futex_wake(testcases + i);
-	}
-
-	tst_exit();
+	tst_res(TINFO, "Testing variant: %s", tv->desc);
+	futex_supported_by_kernel(tv->fntype);
 }
+
+static struct tst_test test = {
+	.setup = setup,
+	.test = run,
+	.tcnt = ARRAY_SIZE(testcases),
+	.test_variants = ARRAY_SIZE(variants),
+};
diff --git a/testcases/kernel/syscalls/futex/futex_wake02.c b/testcases/kernel/syscalls/futex/futex_wake02.c
index 8a4c2d58e4b9..d8a35e7a6d2c 100644
--- a/testcases/kernel/syscalls/futex/futex_wake02.c
+++ b/testcases/kernel/syscalls/futex/futex_wake02.c
@@ -1,40 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (C) 2015 Cyril Hrubis <chrubis@suse.cz>
  *
- * Licensed under the GNU GPLv2 or later.
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program;  if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * Block several threads on a private mutex, then wake them up.
  */
- /*
-  * Block several threads on a private mutex, then wake them up.
-  */
 
 #include <errno.h>
 #include <pthread.h>
+#include <sys/types.h>
 
-#include "test.h"
-#include "safe_macros.h"
 #include "futextest.h"
 #include "futex_utils.h"
-
-const char *TCID="futex_wake02";
-const int TST_TOTAL=11;
+#include "tst_safe_pthread.h"
 
 static futex_t futex = FUTEX_INITIALIZER;
 
 static volatile int threads_flags[55];
 
+static struct test_variants {
+	enum futex_fn_type fntype;
+	char *desc;
+} variants[] = {
+#if (__NR_futex != __LTP__NR_INVALID_SYSCALL)
+	{ .fntype = FUTEX_FN_FUTEX, .desc = "syscall with old kernel spec"},
+#endif
+
+#if (__NR_futex_time64 != __LTP__NR_INVALID_SYSCALL)
+	{ .fntype = FUTEX_FN_FUTEX64, .desc = "syscall time64 with kernel spec"},
+#endif
+};
+
 static int threads_awake(void)
 {
 	int ret = 0;
@@ -58,9 +53,10 @@ static void clear_threads_awake(void)
 
 static void *threaded(void *arg)
 {
+	struct test_variants *tv = &variants[tst_variant];
 	long i = (long)arg;
 
-	futex_wait(&futex, futex, NULL, FUTEX_PRIVATE_FLAG);
+	futex_wait(tv->fntype, &futex, futex, NULL, FUTEX_PRIVATE_FLAG);
 
 	threads_flags[i] = 1;
 
@@ -69,25 +65,21 @@ static void *threaded(void *arg)
 
 static void do_child(void)
 {
+	struct test_variants *tv = &variants[tst_variant];
 	int res, i, j, awake;
 	pthread_t t[55];
 
-	for (i = 0; i < (int)ARRAY_SIZE(t); i++) {
-		res = pthread_create(&t[i], NULL, threaded, (void*)((long)i));
-		if (res) {
-			tst_brkm(TBROK, NULL, "pthread_create(): %s",
-			         tst_strerrno(res));
-		}
-	}
+	for (i = 0; i < (int)ARRAY_SIZE(t); i++)
+		SAFE_PTHREAD_CREATE(&t[i], NULL, threaded, (void*)((long)i));
 
 	while (wait_for_threads(ARRAY_SIZE(t)))
 		usleep(100);
 
 	for (i = 1; i <= 10; i++) {
 		clear_threads_awake();
-		res = futex_wake(&futex, i, FUTEX_PRIVATE_FLAG);
+		res = futex_wake(tv->fntype, &futex, i, FUTEX_PRIVATE_FLAG);
 		if (i != res) {
-			tst_resm(TFAIL,
+			tst_res(TFAIL | TERRNO,
 			         "futex_wake() woken up %i threads, expected %i",
 			         res, i);
 		}
@@ -101,26 +93,26 @@ static void do_child(void)
 		}
 
 		if (awake == i) {
-			tst_resm(TPASS, "futex_wake() woken up %i threads", i);
+			tst_res(TPASS, "futex_wake() woken up %i threads", i);
 		} else {
-			tst_resm(TFAIL, "Woken up %i threads, expected %i",
-			         awake, i);
+			tst_res(TFAIL, "Woken up %i threads, expected %i",
+				awake, i);
 		}
 	}
 
-	res = futex_wake(&futex, 1, FUTEX_PRIVATE_FLAG);
+	res = futex_wake(tv->fntype, &futex, 1, FUTEX_PRIVATE_FLAG);
 
 	if (res) {
-		tst_resm(TFAIL, "futex_wake() woken up %i, none were waiting",
-		         res);
+		tst_res(TFAIL | TERRNO, "futex_wake() woken up %i, none were waiting",
+			res);
 	} else {
-		tst_resm(TPASS, "futex_wake() woken up 0 threads");
+		tst_res(TPASS, "futex_wake() woken up 0 threads");
 	}
 
 	for (i = 0; i < (int)ARRAY_SIZE(t); i++)
-		pthread_join(t[i], NULL);
+		SAFE_PTHREAD_JOIN(t[i], NULL);
 
-	tst_exit();
+	exit(0);
 }
 
 /*
@@ -135,30 +127,28 @@ static void do_child(void)
  * under /proc/$PID/tasks/, but the subsequent open() fails with ENOENT because
  * the thread was removed meanwhile.
  */
-static void verify_futex_wake(void)
+static void run(void)
 {
-	int pid;
-
-	pid = tst_fork();
+	int status, pid;
 
-	switch (pid) {
-	case 0:
+	pid = SAFE_FORK();
+	if (!pid)
 		do_child();
-	case -1:
-		tst_brkm(TBROK | TERRNO, NULL, "fork() failed");
-	default:
-		tst_record_childstatus(NULL, pid);
-	}
+
+	SAFE_WAITPID(pid, &status, 0);
 }
 
-int main(int argc, char *argv[])
+static void setup(void)
 {
-	int lc;
+	struct test_variants *tv = &variants[tst_variant];
 
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	for (lc = 0; TEST_LOOPING(lc); lc++)
-		verify_futex_wake();
-
-	tst_exit();
+	tst_res(TINFO, "Testing variant: %s", tv->desc);
+	futex_supported_by_kernel(tv->fntype);
 }
+
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = run,
+	.test_variants = ARRAY_SIZE(variants),
+	.forks_child = 1,
+};
diff --git a/testcases/kernel/syscalls/futex/futex_wake03.c b/testcases/kernel/syscalls/futex/futex_wake03.c
index d6e5e5422db9..32936df87aa8 100644
--- a/testcases/kernel/syscalls/futex/futex_wake03.c
+++ b/testcases/kernel/syscalls/futex/futex_wake03.c
@@ -1,54 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (C) 2015 Cyril Hrubis <chrubis@suse.cz>
  *
- * Licensed under the GNU GPLv2 or later.
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program;  if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * Block several processes on a mutex, then wake them up.
  */
- /*
-  * Block several processes on a mutex, then wake them up.
-  */
 
 #include <errno.h>
 #include <sys/types.h>
 #include <sys/wait.h>
 
-#include "test.h"
-#include "safe_macros.h"
 #include "futextest.h"
-
-const char *TCID="futex_wake03";
-const int TST_TOTAL=11;
+#include "futex_utils.h"
 
 static futex_t *futex;
 
+static struct test_variants {
+	enum futex_fn_type fntype;
+	char *desc;
+} variants[] = {
+#if (__NR_futex != __LTP__NR_INVALID_SYSCALL)
+	{ .fntype = FUTEX_FN_FUTEX, .desc = "syscall with old kernel spec"},
+#endif
+
+#if (__NR_futex_time64 != __LTP__NR_INVALID_SYSCALL)
+	{ .fntype = FUTEX_FN_FUTEX64, .desc = "syscall time64 with kernel spec"},
+#endif
+};
+
 static void do_child(void)
 {
-	futex_wait(futex, *futex, NULL, 0);
+	struct test_variants *tv = &variants[tst_variant];
+
+	futex_wait(tv->fntype, futex, *futex, NULL, 0);
 	exit(0);
 }
 
 static void do_wake(int nr_children)
 {
+	struct test_variants *tv = &variants[tst_variant];
 	int res, i, cnt;
 
-	res = futex_wake(futex, nr_children, 0);
+	res = futex_wake(tv->fntype, futex, nr_children, 0);
 
 	if (res != nr_children) {
-		tst_resm(TFAIL,
-		         "futex_wake() woken up %i children, expected %i",
-		         res, nr_children);
+		tst_res(TFAIL | TERRNO,
+		        "futex_wake() woken up %i children, expected %i",
+			res, nr_children);
 		return;
 	}
 
@@ -63,65 +60,58 @@ static void do_wake(int nr_children)
 	}
 
 	if (cnt != nr_children) {
-		tst_resm(TFAIL, "reaped only %i childs, expected %i",
-		         cnt, nr_children);
+		tst_res(TFAIL, "reaped only %i childs, expected %i",
+		        cnt, nr_children);
 	} else {
-		tst_resm(TPASS, "futex_wake() woken up %i childs", cnt);
+		tst_res(TPASS, "futex_wake() woken up %i childs", cnt);
 	}
 }
 
-static void verify_futex_wake(void)
+static void run(void)
 {
-	int i, res;
+	struct test_variants *tv = &variants[tst_variant];
 	pid_t pids[55];
+	unsigned int i;
+	int res;
 
-	for (i = 0; i < (int)ARRAY_SIZE(pids); i++) {
-		pids[i] = tst_fork();
-
-		switch (pids[i]) {
-		case -1:
-			tst_brkm(TBROK | TERRNO, NULL, "fork()");
-		case 0:
+	for (i = 0; i < ARRAY_SIZE(pids); i++) {
+		pids[i] = SAFE_FORK();
+		if (!pids[i])
 			do_child();
-		default:
-		break;
-		}
 	}
 
-	for (i = 0; i < (int)ARRAY_SIZE(pids); i++)
-		tst_process_state_wait2(pids[i], 'S');
+	for (i = 0; i < ARRAY_SIZE(pids); i++)
+		TST_PROCESS_STATE_WAIT(pids[i], 'S', 1000);
 
 	for (i = 1; i <= 10; i++)
 		do_wake(i);
 
-	res = futex_wake(futex, 1, 0);
+	res = futex_wake(tv->fntype, futex, 1, 0);
 
 	if (res) {
-		tst_resm(TFAIL, "futex_wake() woken up %u, none were waiting",
-		         res);
+		tst_res(TFAIL | TERRNO, "futex_wake() woken up %u, none were waiting",
+			res);
 	} else {
-		tst_resm(TPASS, "futex_wake() woken up 0 children");
+		tst_res(TPASS, "futex_wake() woken up 0 children");
 	}
 }
 
 static void setup(void)
 {
-	futex = SAFE_MMAP(NULL, NULL, sizeof(*futex), PROT_READ | PROT_WRITE,
+	struct test_variants *tv = &variants[tst_variant];
+
+	tst_res(TINFO, "Testing variant: %s", tv->desc);
+	futex_supported_by_kernel(tv->fntype);
+
+	futex = SAFE_MMAP(NULL, sizeof(*futex), PROT_READ | PROT_WRITE,
 			  MAP_ANONYMOUS | MAP_SHARED, -1, 0);
 
 	*futex = FUTEX_INITIALIZER;
 }
 
-int main(int argc, char *argv[])
-{
-	int lc;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++)
-		verify_futex_wake();
-
-	tst_exit();
-}
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = run,
+	.test_variants = ARRAY_SIZE(variants),
+	.forks_child = 1,
+};
diff --git a/testcases/kernel/syscalls/futex/futex_wake04.c b/testcases/kernel/syscalls/futex/futex_wake04.c
index f92bda53f6c7..0b8e30e7521a 100644
--- a/testcases/kernel/syscalls/futex/futex_wake04.c
+++ b/testcases/kernel/syscalls/futex/futex_wake04.c
@@ -1,23 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (C) 2015  Yi Zhang <wetpzy@gmail.com>
  *                     Li Wang <liwang@redhat.com>
  *
- * Licensed under the GNU GPLv2 or later.
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program;  if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
- */
- /* DESCRIPTION:
+ * DESCRIPTION:
  *
  *   It is a regression test for commit:
  *   http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/
@@ -42,115 +28,98 @@
 #include <sys/time.h>
 #include <string.h>
 
-#include "test.h"
-#include "safe_macros.h"
 #include "futextest.h"
 #include "futex_utils.h"
 #include "lapi/mmap.h"
-
-#define PATH_MEMINFO "/proc/meminfo"
-#define PATH_NR_HUGEPAGES "/proc/sys/vm/nr_hugepages"
-#define PATH_HUGEPAGES	"/sys/kernel/mm/hugepages/"
-
-const char *TCID = "futex_wake04";
-const int TST_TOTAL = 1;
+#include "tst_safe_stdio.h"
+#include "tst_safe_pthread.h"
 
 static futex_t *futex1, *futex2;
 
-static struct timespec to = {.tv_sec = 30, .tv_nsec = 0};
+static struct tst_ts to;
 
 static long orig_hugepages;
 
+static struct test_variants {
+	enum futex_fn_type fntype;
+	enum tst_ts_type tstype;
+	char *desc;
+} variants[] = {
+#if (__NR_futex != __LTP__NR_INVALID_SYSCALL)
+	{ .fntype = FUTEX_FN_FUTEX, .tstype = TST_KERN_OLD_TIMESPEC, .desc = "syscall with old kernel spec"},
+#endif
+
+#if (__NR_futex_time64 != __LTP__NR_INVALID_SYSCALL)
+	{ .fntype = FUTEX_FN_FUTEX64, .tstype = TST_KERN_TIMESPEC, .desc = "syscall time64 with kernel spec"},
+#endif
+};
+
 static void setup(void)
 {
-	tst_require_root();
+	struct test_variants *tv = &variants[tst_variant];
 
-	if ((tst_kvercmp(2, 6, 32)) < 0) {
-		tst_brkm(TCONF, NULL, "This test can only run on kernels "
-			"that are 2.6.32 or higher");
-	}
+	tst_res(TINFO, "Testing variant: %s", tv->desc);
+	futex_supported_by_kernel(tv->fntype);
 
-	if (access(PATH_HUGEPAGES, F_OK))
-		tst_brkm(TCONF, NULL, "Huge page is not supported.");
+	to = tst_ts_from_ns(tv->tstype, 30 * NSEC_PER_SEC);
 
-	tst_tmpdir();
+	if (access(PATH_HUGEPAGES, F_OK))
+		tst_brk(TCONF, "Huge page is not supported.");
 
-	SAFE_FILE_SCANF(NULL, PATH_NR_HUGEPAGES, "%ld", &orig_hugepages);
+	SAFE_FILE_SCANF(PATH_NR_HPAGES, "%ld", &orig_hugepages);
 
 	if (orig_hugepages <= 0)
-		SAFE_FILE_PRINTF(NULL, PATH_NR_HUGEPAGES, "%d", 1);
-
-	TEST_PAUSE;
+		SAFE_FILE_PRINTF(PATH_NR_HPAGES, "%d", 1);
 }
 
 static void cleanup(void)
 {
 	if (orig_hugepages <= 0)
-		SAFE_FILE_PRINTF(NULL, PATH_NR_HUGEPAGES, "%ld", orig_hugepages);
-
-	tst_rmdir();
-}
-
-static int read_hugepagesize(void)
-{
-	FILE *fp;
-	char line[BUFSIZ], buf[BUFSIZ];
-	int val;
-
-	fp = SAFE_FOPEN(cleanup, PATH_MEMINFO, "r");
-	while (fgets(line, BUFSIZ, fp) != NULL) {
-		if (sscanf(line, "%64s %d", buf, &val) == 2)
-			if (strcmp(buf, "Hugepagesize:") == 0) {
-				SAFE_FCLOSE(cleanup, fp);
-				return 1024 * val;
-			}
-	}
-
-	SAFE_FCLOSE(cleanup, fp);
-	tst_brkm(TBROK, NULL, "can't find \"%s\" in %s",
-			"Hugepagesize:", PATH_MEMINFO);
+		SAFE_FILE_PRINTF(PATH_NR_HPAGES, "%ld", orig_hugepages);
 }
 
 static void *wait_thread1(void *arg LTP_ATTRIBUTE_UNUSED)
 {
-	futex_wait(futex1, *futex1, &to, 0);
+	struct test_variants *tv = &variants[tst_variant];
+
+	futex_wait(tv->fntype, futex1, *futex1, &to, 0);
 
 	return NULL;
 }
 
 static void *wait_thread2(void *arg LTP_ATTRIBUTE_UNUSED)
 {
+	struct test_variants *tv = &variants[tst_variant];
 	int res;
 
-	res = futex_wait(futex2, *futex2, &to, 0);
+	res = futex_wait(tv->fntype, futex2, *futex2, &to, 0);
 	if (!res)
-		tst_resm(TPASS, "Hi hydra, thread2 awake!");
+		tst_res(TPASS, "Hi hydra, thread2 awake!");
 	else
-		tst_resm(TFAIL, "Bug: wait_thread2 did not wake after 30 secs.");
+		tst_res(TFAIL | TERRNO, "Bug: wait_thread2 did not wake after 30 secs.");
 
 	return NULL;
 }
 
 static void wakeup_thread2(void)
 {
+	struct test_variants *tv = &variants[tst_variant];
 	void *addr;
-	int hpsz, pgsz, res;
+	int hpsz, pgsz;
 	pthread_t th1, th2;
 
-	hpsz = read_hugepagesize();
-	tst_resm(TINFO, "Hugepagesize %i", hpsz);
+	hpsz = tst_get_hugepage_size();
+	tst_res(TINFO, "Hugepagesize %i", hpsz);
 
 	/*allocate some shared memory*/
 	addr = mmap(NULL, hpsz, PROT_WRITE | PROT_READ,
 	            MAP_SHARED | MAP_ANONYMOUS | MAP_HUGETLB, -1, 0);
 
 	if (addr == MAP_FAILED) {
-		if (errno == ENOMEM) {
-			tst_brkm(TCONF, NULL,
-				 "Cannot allocate hugepage, memory too fragmented?");
-		}
+		if (errno == ENOMEM)
+			tst_brk(TCONF, "Cannot allocate hugepage, memory too fragmented?");
 
-		tst_brkm(TBROK | TERRNO, NULL, "Cannot allocate hugepage");
+		tst_brk(TBROK | TERRNO, "Cannot allocate hugepage");
 	}
 
 	pgsz = getpagesize();
@@ -163,47 +132,31 @@ static void wakeup_thread2(void)
 	*futex2 = 0;
 
 	/*thread1 block on futex1 first,then thread2 block on futex2*/
-	res = pthread_create(&th1, NULL, wait_thread1, NULL);
-	if (res) {
-		tst_brkm(TBROK, NULL, "pthread_create(): %s",
-				tst_strerrno(res));
-	}
-
-	res = pthread_create(&th2, NULL, wait_thread2, NULL);
-	if (res) {
-		tst_brkm(TBROK, NULL, "pthread_create(): %s",
-				tst_strerrno(res));
-	}
+	SAFE_PTHREAD_CREATE(&th1, NULL, wait_thread1, NULL);
+	SAFE_PTHREAD_CREATE(&th2, NULL, wait_thread2, NULL);
 
 	while (wait_for_threads(2))
 		usleep(1000);
 
-	futex_wake(futex2, 1, 0);
-
-	res = pthread_join(th2, NULL);
-	if (res)
-		tst_brkm(TBROK, NULL, "pthread_join(): %s", tst_strerrno(res));
+	futex_wake(tv->fntype, futex2, 1, 0);
+	SAFE_PTHREAD_JOIN(th2, NULL);
+	futex_wake(tv->fntype, futex1, 1, 0);
+	SAFE_PTHREAD_JOIN(th1, NULL);
 
-	futex_wake(futex1, 1, 0);
-
-	res = pthread_join(th1, NULL);
-	if (res)
-		tst_brkm(TBROK, NULL, "pthread_join(): %s", tst_strerrno(res));
-
-	SAFE_MUNMAP(NULL, addr, hpsz);
+	SAFE_MUNMAP(addr, hpsz);
 }
 
-int main(int argc, char *argv[])
+static void run(void)
 {
-	int lc;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++)
-		wakeup_thread2();
-
-	cleanup();
-	tst_exit();
+	wakeup_thread2();
 }
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run,
+	.test_variants = ARRAY_SIZE(variants),
+	.needs_root = 1,
+	.min_kver = "2.6.32",
+	.needs_tmpdir = 1,
+};
diff --git a/testcases/kernel/syscalls/futex/futextest.h b/testcases/kernel/syscalls/futex/futextest.h
index 5754d36dae51..b72d83bc711b 100644
--- a/testcases/kernel/syscalls/futex/futextest.h
+++ b/testcases/kernel/syscalls/futex/futextest.h
@@ -39,6 +39,7 @@
 #include <sys/types.h>
 #include <linux/futex.h>
 #include "lapi/futex.h"
+#include "tst_timer.h"
 
 #define FUTEX_INITIALIZER 0
 
@@ -82,18 +83,35 @@
 # define FUTEX_CLOCK_REALTIME 256
 #endif
 
+enum futex_fn_type {
+	FUTEX_FN_FUTEX,
+	FUTEX_FN_FUTEX64,
+};
+
+static inline void futex_supported_by_kernel(enum futex_fn_type fntype)
+{
+	if (fntype != FUTEX_FN_FUTEX64)
+		return;
+
+	/* Check if the syscall is implemented on the platform */
+	TEST(sys_futex_time64(NULL, 0, 0, NULL, NULL, 0));
+	if (TST_RET == -1 && TST_ERR == ENOSYS)
+		tst_brk(TCONF, "Test not supported on kernel/platform");
+}
+
 /**
- * futex() - SYS_futex syscall wrapper
+ * futex_syscall() - futex syscall wrapper
+ * @fntype:	Futex function type
  * @uaddr:	address of first futex
  * @op:		futex op code
  * @val:	typically expected value of uaddr, but varies by op
- * @timeout:	typically an absolute struct timespec (except where noted
+ * @timeout:	typically an absolute struct tst_ts (except where noted
  *		otherwise). Overloaded by some ops
  * @uaddr2:	address of second futex for some ops\
  * @val3:	varies by op
  * @opflags:	flags to be bitwise OR'd with op, such as FUTEX_PRIVATE_FLAG
  *
- * futex() is used by all the following futex op wrappers. It can also be
+ * futex_syscall() is used by all the following futex op wrappers. It can also be
  * used for misuse and abuse testing. Generally, the specific op wrappers
  * should be used instead. It is a macro instead of an static inline function as
  * some of the types over overloaded (timeout is used for nr_requeue for
@@ -102,17 +120,30 @@
  * These argument descriptions are the defaults for all
  * like-named arguments in the following wrappers except where noted below.
  */
-#define futex(uaddr, op, val, timeout, uaddr2, val3, opflags) \
-	syscall(SYS_futex, uaddr, op | opflags, val, timeout, uaddr2, val3)
+static inline int futex_syscall(enum futex_fn_type fntype, futex_t *uaddr,
+				int futex_op, futex_t val, void *timeout,
+				futex_t *uaddr2, int val3, int opflags)
+{
+	int (*func)(int *uaddr, int futex_op, int val, void *to, int *uaddr2, int val3);
+
+	if (fntype == FUTEX_FN_FUTEX)
+		func = sys_futex;
+	else
+		func = sys_futex_time64;
+
+	return func((int *)uaddr, futex_op | opflags, val, timeout, (int *)uaddr2, val3);
+}
 
 /**
  * futex_wait() - block on uaddr with optional timeout
  * @timeout:	relative timeout
  */
 static inline int
-futex_wait(futex_t *uaddr, futex_t val, struct timespec *timeout, int opflags)
+futex_wait(enum futex_fn_type fntype, futex_t *uaddr, futex_t val,
+	   struct tst_ts *timeout, int opflags)
 {
-	return futex(uaddr, FUTEX_WAIT, val, timeout, NULL, 0, opflags);
+	return futex_syscall(fntype, uaddr, FUTEX_WAIT, val,
+			     tst_ts_get(timeout), NULL, 0, opflags);
 }
 
 /**
@@ -120,9 +151,10 @@ futex_wait(futex_t *uaddr, futex_t val, struct timespec *timeout, int opflags)
  * @nr_wake:	wake up to this many tasks
  */
 static inline int
-futex_wake(futex_t *uaddr, int nr_wake, int opflags)
+futex_wake(enum futex_fn_type fntype, futex_t *uaddr, int nr_wake, int opflags)
 {
-	return futex(uaddr, FUTEX_WAKE, nr_wake, NULL, NULL, 0, opflags);
+	return futex_syscall(fntype, uaddr, FUTEX_WAKE, nr_wake, NULL, NULL, 0,
+			     opflags);
 }
 
 /**
@@ -130,11 +162,11 @@ futex_wake(futex_t *uaddr, int nr_wake, int opflags)
  * @bitset:	bitset to be used with futex_wake_bitset
  */
 static inline int
-futex_wait_bitset(futex_t *uaddr, futex_t val, struct timespec *timeout,
-		  u_int32_t bitset, int opflags)
+futex_wait_bitset(enum futex_fn_type fntype, futex_t *uaddr, futex_t val,
+		  struct tst_ts *timeout, u_int32_t bitset, int opflags)
 {
-	return futex(uaddr, FUTEX_WAIT_BITSET, val, timeout, NULL, bitset,
-		     opflags);
+	return futex_syscall(fntype, uaddr, FUTEX_WAIT_BITSET, val,
+			     tst_ts_get(timeout), NULL, bitset, opflags);
 }
 
 /**
@@ -142,10 +174,11 @@ futex_wait_bitset(futex_t *uaddr, futex_t val, struct timespec *timeout,
  * @bitset:	bitset to compare with that used in futex_wait_bitset
  */
 static inline int
-futex_wake_bitset(futex_t *uaddr, int nr_wake, u_int32_t bitset, int opflags)
+futex_wake_bitset(enum futex_fn_type fntype, futex_t *uaddr, int nr_wake,
+		  u_int32_t bitset, int opflags)
 {
-	return futex(uaddr, FUTEX_WAKE_BITSET, nr_wake, NULL, NULL, bitset,
-		     opflags);
+	return futex_syscall(fntype, uaddr, FUTEX_WAKE_BITSET, nr_wake, NULL,
+			     NULL, bitset, opflags);
 }
 
 /**
@@ -153,30 +186,32 @@ futex_wake_bitset(futex_t *uaddr, int nr_wake, u_int32_t bitset, int opflags)
  * @detect:	whether (1) or not (0) to perform deadlock detection
  */
 static inline int
-futex_lock_pi(futex_t *uaddr, struct timespec *timeout, int detect,
-	      int opflags)
+futex_lock_pi(enum futex_fn_type fntype, futex_t *uaddr, struct tst_ts *timeout,
+	      int detect, int opflags)
 {
-	return futex(uaddr, FUTEX_LOCK_PI, detect, timeout, NULL, 0, opflags);
+	return futex_syscall(fntype, uaddr, FUTEX_LOCK_PI, detect,
+			     tst_ts_get(timeout), NULL, 0, opflags);
 }
 
 /**
  * futex_unlock_pi() - release uaddr as a PI mutex, waking the top waiter
  */
 static inline int
-futex_unlock_pi(futex_t *uaddr, int opflags)
+futex_unlock_pi(enum futex_fn_type fntype, futex_t *uaddr, int opflags)
 {
-	return futex(uaddr, FUTEX_UNLOCK_PI, 0, NULL, NULL, 0, opflags);
-}
+	return futex_syscall(fntype, uaddr, FUTEX_UNLOCK_PI, 0, NULL, NULL, 0,
+			     opflags); }
 
 /**
  * futex_wake_op() - FIXME: COME UP WITH A GOOD ONE LINE DESCRIPTION
  */
 static inline int
-futex_wake_op(futex_t *uaddr, futex_t *uaddr2, int nr_wake, int nr_wake2,
-	      int wake_op, int opflags)
+futex_wake_op(enum futex_fn_type fntype, futex_t *uaddr, futex_t *uaddr2,
+	      int nr_wake, int nr_wake2, int wake_op, int opflags)
 {
-	return futex(uaddr, FUTEX_WAKE_OP, nr_wake, nr_wake2, uaddr2, wake_op,
-		     opflags);
+	return futex_syscall(fntype, uaddr, FUTEX_WAKE_OP, nr_wake,
+			     (void *)((unsigned long)nr_wake2), uaddr2, wake_op,
+			     opflags);
 }
 
 /**
@@ -188,11 +223,12 @@ futex_wake_op(futex_t *uaddr, futex_t *uaddr2, int nr_wake, int nr_wake2,
  * favor of futex_cmp_requeue().
  */
 static inline int
-futex_requeue(futex_t *uaddr, futex_t *uaddr2, int nr_wake, int nr_requeue,
-	      int opflags)
+futex_requeue(enum futex_fn_type fntype, futex_t *uaddr, futex_t *uaddr2,
+	      int nr_wake, int nr_requeue, int opflags)
 {
-	return futex(uaddr, FUTEX_REQUEUE, nr_wake, nr_requeue, uaddr2, 0,
-		     opflags);
+	return futex_syscall(fntype, uaddr, FUTEX_REQUEUE, nr_wake,
+			     (void *)((unsigned long)nr_requeue), uaddr2, 0,
+			     opflags);
 }
 
 /**
@@ -201,11 +237,12 @@ futex_requeue(futex_t *uaddr, futex_t *uaddr2, int nr_wake, int nr_requeue,
  * @nr_requeue:	requeue up to this many tasks
  */
 static inline int
-futex_cmp_requeue(futex_t *uaddr, futex_t val, futex_t *uaddr2, int nr_wake,
-		  int nr_requeue, int opflags)
+futex_cmp_requeue(enum futex_fn_type fntype, futex_t *uaddr, futex_t val,
+		  futex_t *uaddr2, int nr_wake, int nr_requeue, int opflags)
 {
-	return futex(uaddr, FUTEX_CMP_REQUEUE, nr_wake, nr_requeue, uaddr2,
-		     val, opflags);
+	return futex_syscall(fntype, uaddr, FUTEX_CMP_REQUEUE, nr_wake,
+			     (void *)((unsigned long)nr_requeue), uaddr2, val,
+			     opflags);
 }
 
 /**
@@ -217,11 +254,11 @@ futex_cmp_requeue(futex_t *uaddr, futex_t val, futex_t *uaddr2, int nr_wake,
  * paired with futex_cmp_requeue_pi().
  */
 static inline int
-futex_wait_requeue_pi(futex_t *uaddr, futex_t val, futex_t *uaddr2,
-		      struct timespec *timeout, int opflags)
+futex_wait_requeue_pi(enum futex_fn_type fntype, futex_t *uaddr, futex_t val,
+		      futex_t *uaddr2, struct tst_ts *timeout, int opflags)
 {
-	return futex(uaddr, FUTEX_WAIT_REQUEUE_PI, val, timeout, uaddr2, 0,
-		     opflags);
+	return futex_syscall(fntype, uaddr, FUTEX_WAIT_REQUEUE_PI, val,
+			     tst_ts_get(timeout), uaddr2, 0, opflags);
 }
 
 /**
@@ -232,11 +269,12 @@ futex_wait_requeue_pi(futex_t *uaddr, futex_t val, futex_t *uaddr2,
  * @nr_requeue:	requeue up to this many tasks
  */
 static inline int
-futex_cmp_requeue_pi(futex_t *uaddr, futex_t val, futex_t *uaddr2, int nr_wake,
-		     int nr_requeue, int opflags)
+futex_cmp_requeue_pi(enum futex_fn_type fntype, futex_t *uaddr, futex_t val,
+		     futex_t *uaddr2, int nr_wake, int nr_requeue, int opflags)
 {
-	return futex(uaddr, FUTEX_CMP_REQUEUE_PI, nr_wake, nr_requeue, uaddr2, val,
-		     opflags);
+	return futex_syscall(fntype, uaddr, FUTEX_CMP_REQUEUE_PI, nr_wake,
+			     (void *)((unsigned long)nr_requeue), uaddr2, val,
+			     opflags);
 }
 
 /**
-- 
2.25.0.rc1.19.g042ed3e048af

