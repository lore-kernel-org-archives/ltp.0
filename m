From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Wed, 31 Jul 2019 14:24:06 +0800
Subject: [LTP] [PATCH v2] syscalls/nanosleep03: remove duplicated nanosleep03
In-Reply-To: <20190730112120.GA10214@rei.lan>
References: <20190730112120.GA10214@rei.lan>
Message-ID: <1564554246-2265-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1) remove duplicated nanosleep03, because nanosleep02 also
test EINTR when it is interrupted by a signal handler
2)nanosleep01:Replace GPL verbose text by SPDX license identifier

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 runtest/syscalls                              |   1 -
 .../kernel/syscalls/nanosleep/.gitignore      |   1 -
 .../kernel/syscalls/nanosleep/nanosleep01.c   |  16 +-
 .../kernel/syscalls/nanosleep/nanosleep02.c   |  20 ++-
 .../kernel/syscalls/nanosleep/nanosleep03.c   | 148 ------------------
 5 files changed, 17 insertions(+), 169 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/nanosleep/nanosleep03.c

diff --git a/runtest/syscalls b/runtest/syscalls
index da5924716..1c858d53e 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -785,7 +785,6 @@ munmap03 munmap03
 
 nanosleep01 nanosleep01
 nanosleep02 nanosleep02
-nanosleep03 nanosleep03
 nanosleep04 nanosleep04
 
 nftw01 nftw01
diff --git a/testcases/kernel/syscalls/nanosleep/.gitignore b/testcases/kernel/syscalls/nanosleep/.gitignore
index 11ed6bbcb..9bf03ea97 100644
--- a/testcases/kernel/syscalls/nanosleep/.gitignore
+++ b/testcases/kernel/syscalls/nanosleep/.gitignore
@@ -1,4 +1,3 @@
 /nanosleep01
 /nanosleep02
-/nanosleep03
 /nanosleep04
diff --git a/testcases/kernel/syscalls/nanosleep/nanosleep01.c b/testcases/kernel/syscalls/nanosleep/nanosleep01.c
index 96e1cf1b4..567be8c10 100644
--- a/testcases/kernel/syscalls/nanosleep/nanosleep01.c
+++ b/testcases/kernel/syscalls/nanosleep/nanosleep01.c
@@ -1,21 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) International Business Machines  Corp., 2001
  *  07/2001 Ported by Wayne Boyer
  * Copyright (C) 2015-2017 Cyril Hrubis <chrubis@suse.cz>
- *
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
- * along with this program;  if not, write to the Free Software Foundation,
- * Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
 
 /*
@@ -25,7 +12,6 @@
  */
 
 #include <errno.h>
-
 #include "tst_timer_test.h"
 
 int sample_fn(int clk_id, long long usec)
diff --git a/testcases/kernel/syscalls/nanosleep/nanosleep02.c b/testcases/kernel/syscalls/nanosleep/nanosleep02.c
index 8bd2c44c4..cf7849ca5 100644
--- a/testcases/kernel/syscalls/nanosleep/nanosleep02.c
+++ b/testcases/kernel/syscalls/nanosleep/nanosleep02.c
@@ -10,6 +10,9 @@
  *  Verify that nanosleep() will be successful to suspend the execution
  *  of a process, returns after the receipt of a signal and writes the
  *  remaining sleep time into the structure.
+ *
+ *  This test also verifies that if the call is interrupted by a signal
+ *  handler, nanosleep() returns -1, sets errno to EINTR.
  */
 
 #include <errno.h>
@@ -39,10 +42,19 @@ static void do_child(void)
 	TEST(nanosleep(&timereq, &timerem));
 	tst_timer_stop();
 
-	if (!TST_RET)
-		tst_brk(TBROK, "nanosleep was not interrupted");
-	if (TST_ERR != EINTR)
-		tst_brk(TBROK | TTERRNO, "nanosleep() failed");
+	if (TST_RET != -1) {
+		tst_res(TFAIL,
+			"nanosleep was not interrupted, returned %ld ,expected -1",
+			TST_RET);
+		return;
+	}
+	if (TST_ERR != EINTR) {
+		tst_res(TFAIL | TTERRNO,
+			"nanosleep() failed, expected EINTT, got");
+		return;
+	}
+
+	tst_res(TPASS, "nanosleep() returned -1, set errno to EINTER");
 
 	if (tst_timespec_lt(timereq, tst_timer_elapsed()))
 		tst_brk(TFAIL, "nanosleep() slept more than timereq");
diff --git a/testcases/kernel/syscalls/nanosleep/nanosleep03.c b/testcases/kernel/syscalls/nanosleep/nanosleep03.c
deleted file mode 100644
index 456e140e9..000000000
--- a/testcases/kernel/syscalls/nanosleep/nanosleep03.c
+++ /dev/null
@@ -1,148 +0,0 @@
-/*
- * Copyright (c) International Business Machines  Corp., 2001
- *  07/2001 Ported by Wayne Boyer
- *
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
- * along with this program;  if not, write to the Free Software Foundation,
- * Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
- */
-
-/*
- * Test Description:
- *  Verify that nanosleep() will fail to suspend the execution
- *  of a process for a specified time if interrupted by a non-blocked signal.
- *
- * Expected Result:
- *  nanosleep() should return with -1 value and sets errno to EINTR.
- */
-
-#include <errno.h>
-#include <unistd.h>
-#include <fcntl.h>
-#include <time.h>
-#include <sys/wait.h>
-
-#include "test.h"
-#include "safe_macros.h"
-
-char *TCID = "nanosleep03";
-int TST_TOTAL = 1;
-
-static void do_child(void);
-static void setup(void);
-static void sig_handler();
-
-int main(int ac, char **av)
-{
-	int lc;
-	pid_t cpid;
-	int status;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-#ifdef UCLINUX
-	maybe_run_child(&do_child, "dddd", &timereq.tv_sec, &timereq.tv_nsec,
-			&timerem.tv_sec, &timerem.tv_nsec);
-#endif
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		/*
-		 * Creat a child process and suspend its
-		 * execution using nanosleep()
-		 */
-		if ((cpid = FORK_OR_VFORK()) == -1)
-			tst_brkm(TBROK, NULL, "fork() failed");
-
-		if (cpid == 0) {
-#ifdef UCLINUX
-			if (self_exec(av[0], "dddd",
-				      timereq.tv_sec, timereq.tv_nsec,
-				      timerem.tv_sec, timerem.tv_nsec) < 0) {
-				tst_brkm(TBROK, NULL, "self_exec failed");
-			}
-#else
-			do_child();
-#endif
-		}
-
-		sleep(1);
-
-		/* Now send signal to child */
-		SAFE_KILL(NULL, cpid, SIGINT);
-
-		/* Wait for child to execute */
-		wait(&status);
-		if (WIFEXITED(status) && WEXITSTATUS(status) == 0) {
-			tst_resm(TPASS, "nanosleep() failed, interrupted"
-				 " by signal (%d) as expected", EINTR);
-		} else {
-			tst_resm(TFAIL, "child process exited abnormally; "
-				 "status = %d", status);
-		}
-	}
-
-	tst_exit();
-}
-
-static void do_child(void)
-{
-	struct timespec timereq = {.tv_sec = 5, .tv_nsec = 9999};
-	struct timespec timerem;
-
-	/*
-	 * Call nanosleep() to suspend child process
-	 * for specified time 'tv_sec'.
-	 * Call should return before suspending execution
-	 * for the specified time due to receipt of signal
-	 * from Parent.
-	 */
-	TEST(nanosleep(&timereq, &timerem));
-
-	if (TEST_RETURN == -1) {
-
-		/* Check for expected errno is set */
-		if (TEST_ERRNO != EINTR) {
-			tst_resm(TFAIL | TTERRNO,
-				 "nanosleep() failed; expected errno: %d",
-				 EINTR);
-			exit(1);
-		}
-	} else {
-		tst_resm(TFAIL, "nanosleep() returns %ld, "
-			 "expected -1, errno:%d", TEST_RETURN, EINTR);
-		exit(1);
-	}
-
-	exit(0);
-}
-
-static void setup(void)
-{
-	tst_sig(FORK, DEF_HANDLER, NULL);
-
-	TEST_PAUSE;
-
-	if (signal(SIGINT, sig_handler) == SIG_ERR) {
-		tst_brkm(TBROK, NULL,
-			 "signal() fails to setup signal handler");
-	}
-
-}
-
-static void sig_handler(void)
-{
-}
-- 
2.18.1



