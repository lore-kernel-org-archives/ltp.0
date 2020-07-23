From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 23 Jul 2020 21:44:45 +0200
Subject: [LTP] [PATCH V7.1 07/19] syscalls/futex: Add support for time64
 tests
In-Reply-To: <8485ad1373a22b8f512eb17cf65d7662a7ede619.1594035467.git.viresh.kumar@linaro.org>
References: <6030fa8c1deda3aab977c7d5745c117fda87708a.1593152309.git.viresh.kumar@linaro.org>
 <8485ad1373a22b8f512eb17cf65d7662a7ede619.1594035467.git.viresh.kumar@linaro.org>
Message-ID: <20200723194445.GC9768@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with minor changes, thanks.

Here is the diff, if something there is puzzling I will explain it
tomorrow, I'm too tired to do it now...

diff --git a/testcases/kernel/syscalls/futex/futex_cmp_requeue02.c b/testcases/kernel/syscalls/futex/futex_cmp_requeue02.c
index e5257ec18..dd8fafb3e 100644
--- a/testcases/kernel/syscalls/futex/futex_cmp_requeue02.c
+++ b/testcases/kernel/syscalls/futex/futex_cmp_requeue02.c
@@ -58,13 +58,13 @@ static void verify_futex_cmp_requeue(unsigned int n)
 	}
 
 	if (TST_ERR != tc->exp_errno) {
-		tst_res(TFAIL | TERRNO,
+		tst_res(TFAIL | TTERRNO,
 			"futex_cmp_requeue() failed unexpectedly, expected %s",
 			tst_strerrno(tc->exp_errno));
 		return;
 	}
 
-	tst_res(TPASS | TERRNO, "futex_cmp_requeue() failed as expected");
+	tst_res(TPASS | TTERRNO, "futex_cmp_requeue() failed as expected");
 }
 
 static void setup(void)
diff --git a/testcases/kernel/syscalls/futex/futex_utils.h b/testcases/kernel/syscalls/futex/futex_utils.h
index bdcbc90d5..156895efb 100644
--- a/testcases/kernel/syscalls/futex/futex_utils.h
+++ b/testcases/kernel/syscalls/futex/futex_utils.h
@@ -64,4 +64,5 @@ static inline int wait_for_threads(unsigned int nr_threads)
 
 	return 0;
 }
+
 #endif /* FUTEX_UTILS_H__ */
diff --git a/testcases/kernel/syscalls/futex/futex_wait01.c b/testcases/kernel/syscalls/futex/futex_wait01.c
index 9b5846f93..09a95aa2c 100644
--- a/testcases/kernel/syscalls/futex/futex_wait01.c
+++ b/testcases/kernel/syscalls/futex/futex_wait01.c
@@ -11,8 +11,6 @@
  *    from the expected one.
  */
 
-#include <errno.h>
-
 #include "futextest.h"
 
 struct testcase {
diff --git a/testcases/kernel/syscalls/futex/futex_wait02.c b/testcases/kernel/syscalls/futex/futex_wait02.c
index 092e540f5..32bcfd1e7 100644
--- a/testcases/kernel/syscalls/futex/futex_wait02.c
+++ b/testcases/kernel/syscalls/futex/futex_wait02.c
@@ -9,7 +9,6 @@
 
 #include <sys/mman.h>
 #include <sys/wait.h>
-#include <errno.h>
 
 #include "futextest.h"
 #include "futex_utils.h"
diff --git a/testcases/kernel/syscalls/futex/futex_wait03.c b/testcases/kernel/syscalls/futex/futex_wait03.c
index 94d522dcb..e6e94055b 100644
--- a/testcases/kernel/syscalls/futex/futex_wait03.c
+++ b/testcases/kernel/syscalls/futex/futex_wait03.c
@@ -7,9 +7,6 @@
  * This tests uses private mutexes with threads.
  */
 
-#include <errno.h>
-#include <pthread.h>
-
 #include "futextest.h"
 #include "futex_utils.h"
 #include "tst_safe_pthread.h"
@@ -34,7 +31,7 @@ static void *threaded(void *arg LTP_ATTRIBUTE_UNUSED)
 	struct test_variants *tv = &variants[tst_variant];
 	long ret;
 
-	TST_PROCESS_STATE_WAIT(getppid(), 'S', 1000);
+	TST_PROCESS_STATE_WAIT(getppid(), 'S', 0);
 
 	ret = futex_wake(tv->fntype, &futex, 1, FUTEX_PRIVATE_FLAG);
 	if (ret != 1)
diff --git a/testcases/kernel/syscalls/futex/futex_wait_bitset01.c b/testcases/kernel/syscalls/futex/futex_wait_bitset01.c
index cfde61083..358a5cd45 100644
--- a/testcases/kernel/syscalls/futex/futex_wait_bitset01.c
+++ b/testcases/kernel/syscalls/futex/futex_wait_bitset01.c
@@ -7,8 +7,6 @@
  * 2. Check that the futex waited for expected time.
  */
 
-#include <errno.h>
-
 #include "tst_test.h"
 #include "tst_timer.h"
 #include "futextest.h"
@@ -71,7 +69,7 @@ static void verify_futex_wait_bitset(long long wait_us, clock_t clk_id)
 	}
 
 	if (TST_ERR != ETIMEDOUT) {
-		tst_res(TFAIL | TERRNO, "expected %s",
+		tst_res(TFAIL | TTERRNO, "expected %s",
 			tst_strerrno(ETIMEDOUT));
 		return;
 	}
diff --git a/testcases/kernel/syscalls/futex/futex_wake01.c b/testcases/kernel/syscalls/futex/futex_wake01.c
index f2f682fe7..a2f225a9c 100644
--- a/testcases/kernel/syscalls/futex/futex_wake01.c
+++ b/testcases/kernel/syscalls/futex/futex_wake01.c
@@ -5,7 +5,6 @@
  * futex_wake() returns 0 (0 woken up processes) when no processes wait on the mutex.
  */
 
-#include <errno.h>
 #include <limits.h>
 
 #include "futextest.h"
diff --git a/testcases/kernel/syscalls/futex/futex_wake02.c b/testcases/kernel/syscalls/futex/futex_wake02.c
index d8a35e7a6..de80738bd 100644
--- a/testcases/kernel/syscalls/futex/futex_wake02.c
+++ b/testcases/kernel/syscalls/futex/futex_wake02.c
@@ -5,8 +5,6 @@
  * Block several threads on a private mutex, then wake them up.
  */
 
-#include <errno.h>
-#include <pthread.h>
 #include <sys/types.h>
 
 #include "futextest.h"
@@ -66,7 +64,7 @@ static void *threaded(void *arg)
 static void do_child(void)
 {
 	struct test_variants *tv = &variants[tst_variant];
-	int res, i, j, awake;
+	int i, j, awake;
 	pthread_t t[55];
 
 	for (i = 0; i < (int)ARRAY_SIZE(t); i++)
@@ -77,11 +75,11 @@ static void do_child(void)
 
 	for (i = 1; i <= 10; i++) {
 		clear_threads_awake();
-		res = futex_wake(tv->fntype, &futex, i, FUTEX_PRIVATE_FLAG);
-		if (i != res) {
-			tst_res(TFAIL | TERRNO,
-			         "futex_wake() woken up %i threads, expected %i",
-			         res, i);
+		TEST(futex_wake(tv->fntype, &futex, i, FUTEX_PRIVATE_FLAG));
+		if (i != TST_RET) {
+			tst_res(TFAIL | TTERRNO,
+			         "futex_wake() woken up %li threads, expected %i",
+			         TST_RET, i);
 		}
 
 		for (j = 0; j < 100000; j++) {
@@ -100,11 +98,10 @@ static void do_child(void)
 		}
 	}
 
-	res = futex_wake(tv->fntype, &futex, 1, FUTEX_PRIVATE_FLAG);
-
-	if (res) {
-		tst_res(TFAIL | TERRNO, "futex_wake() woken up %i, none were waiting",
-			res);
+	TEST(futex_wake(tv->fntype, &futex, 1, FUTEX_PRIVATE_FLAG));
+	if (TST_RET) {
+		tst_res(TFAIL | TTERRNO, "futex_wake() woken up %li, none were waiting",
+			TST_RET);
 	} else {
 		tst_res(TPASS, "futex_wake() woken up 0 threads");
 	}
@@ -129,13 +126,8 @@ static void do_child(void)
  */
 static void run(void)
 {
-	int status, pid;
-
-	pid = SAFE_FORK();
-	if (!pid)
+	if (!SAFE_FORK())
 		do_child();
-
-	SAFE_WAITPID(pid, &status, 0);
 }
 
 static void setup(void)
diff --git a/testcases/kernel/syscalls/futex/futex_wake03.c b/testcases/kernel/syscalls/futex/futex_wake03.c
index 32936df87..02b291e1a 100644
--- a/testcases/kernel/syscalls/futex/futex_wake03.c
+++ b/testcases/kernel/syscalls/futex/futex_wake03.c
@@ -5,7 +5,6 @@
  * Block several processes on a mutex, then wake them up.
  */
 
-#include <errno.h>
 #include <sys/types.h>
 #include <sys/wait.h>
 
@@ -40,12 +39,11 @@ static void do_wake(int nr_children)
 	struct test_variants *tv = &variants[tst_variant];
 	int res, i, cnt;
 
-	res = futex_wake(tv->fntype, futex, nr_children, 0);
-
-	if (res != nr_children) {
-		tst_res(TFAIL | TERRNO,
-		        "futex_wake() woken up %i children, expected %i",
-			res, nr_children);
+	TEST(futex_wake(tv->fntype, futex, nr_children, 0));
+	if (TST_RET != nr_children) {
+		tst_res(TFAIL | TTERRNO,
+		        "futex_wake() woken up %li children, expected %i",
+			TST_RET, nr_children);
 		return;
 	}
 
@@ -72,7 +70,6 @@ static void run(void)
 	struct test_variants *tv = &variants[tst_variant];
 	pid_t pids[55];
 	unsigned int i;
-	int res;
 
 	for (i = 0; i < ARRAY_SIZE(pids); i++) {
 		pids[i] = SAFE_FORK();
@@ -81,16 +78,16 @@ static void run(void)
 	}
 
 	for (i = 0; i < ARRAY_SIZE(pids); i++)
-		TST_PROCESS_STATE_WAIT(pids[i], 'S', 1000);
+		TST_PROCESS_STATE_WAIT(pids[i], 'S', 0);
 
 	for (i = 1; i <= 10; i++)
 		do_wake(i);
 
-	res = futex_wake(tv->fntype, futex, 1, 0);
-
-	if (res) {
-		tst_res(TFAIL | TERRNO, "futex_wake() woken up %u, none were waiting",
-			res);
+	TEST(futex_wake(tv->fntype, futex, 1, 0));
+	if (TST_RET) {
+		tst_res(TFAIL | TTERRNO,
+			"futex_wake() woken up %li, none were waiting",
+		        TST_RET);
 	} else {
 		tst_res(TPASS, "futex_wake() woken up 0 children");
 	}
diff --git a/testcases/kernel/syscalls/futex/futex_wake04.c b/testcases/kernel/syscalls/futex/futex_wake04.c
index 0b8e30e75..8fae7ced9 100644
--- a/testcases/kernel/syscalls/futex/futex_wake04.c
+++ b/testcases/kernel/syscalls/futex/futex_wake04.c
@@ -23,8 +23,6 @@
 #include <stdio.h>
 #include <sys/mman.h>
 #include <fcntl.h>
-#include <pthread.h>
-#include <errno.h>
 #include <sys/time.h>
 #include <string.h>
 
@@ -92,6 +90,7 @@ static void *wait_thread2(void *arg LTP_ATTRIBUTE_UNUSED)
 	struct test_variants *tv = &variants[tst_variant];
 	int res;
 
+	errno = 0;
 	res = futex_wait(tv->fntype, futex2, *futex2, &to, 0);
 	if (!res)
 		tst_res(TPASS, "Hi hydra, thread2 awake!");
@@ -146,15 +145,10 @@ static void wakeup_thread2(void)
 	SAFE_MUNMAP(addr, hpsz);
 }
 
-static void run(void)
-{
-	wakeup_thread2();
-}
-
 static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
-	.test_all = run,
+	.test_all = wakeup_thread2,
 	.test_variants = ARRAY_SIZE(variants),
 	.needs_root = 1,
 	.min_kver = "2.6.32",
diff --git a/testcases/kernel/syscalls/futex/futextest.h b/testcases/kernel/syscalls/futex/futextest.h
index b72d83bc7..c50876fa6 100644
--- a/testcases/kernel/syscalls/futex/futextest.h
+++ b/testcases/kernel/syscalls/futex/futextest.h
@@ -1,35 +1,14 @@
-/******************************************************************************
- *
- *   Copyright ? International Business Machines  Corp., 2009
- *   Copyright (C) 2015 Cyril Hrubis <chrubis@suse.cz>
- *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- *
- * NAME
- *      futextest.h
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright ? International Business Machines  Corp., 2009
+ * Copyright (C) 2015 Cyril Hrubis <chrubis@suse.cz>
  *
  * DESCRIPTION
  *      Glibc independent futex library for testing kernel functionality.
  *
  * AUTHOR
  *      Darren Hart <dvhltc@us.ibm.com>
- *
- * HISTORY
- *      2009-Nov-6: Initial version by Darren Hart <dvhltc@us.ibm.com>
- *
- *****************************************************************************/
+ */
 
 #ifndef _FUTEXTEST_H
 #define _FUTEXTEST_H

-- 
Cyril Hrubis
chrubis@suse.cz
