From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 2 Jul 2020 15:06:54 +0200
Subject: [LTP] [PATCH V7 05/19] syscalls/sched_rr_get_interval: Add
 support for time64 tests
In-Reply-To: <325a43a851acca8bb242011a1d62063c8154653c.1593152309.git.viresh.kumar@linaro.org>
References: <cover.1593152309.git.viresh.kumar@linaro.org>
 <325a43a851acca8bb242011a1d62063c8154653c.1593152309.git.viresh.kumar@linaro.org>
Message-ID: <20200702130654.GC9101@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I've did some further cleanup and pushed, thanks.

Btw, we may as well add a check that the value is consistent with
/proc/sys/kernel/sched_rr_timeslice_ms.

I've mostly removed useless comments, etc. but also added a sanity check for
the time quantum timespec. See:

diff --git a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval01.c b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval01.c
index 9bad698aa..31d7b5d56 100644
--- a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval01.c
+++ b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval01.c
@@ -1,53 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) Wipro Technologies Ltd, 2002.  All Rights Reserved.
- *
- *    TEST IDENTIFIER	: sched_rr_get_interval01
- *
- *    EXECUTED BY	: root / superuser
- *
- *    TEST TITLE	: Basic test for sched_rr_get_interval(2)
- *
- *    TEST CASE TOTAL	: 1
- *
  *    AUTHOR		: Saji Kumar.V.R <saji.kumar@wipro.com>
  *
- *    SIGNALS
- *	Uses SIGUSR1 to pause before test if option set.
- *	(See the parse_opts(3) man page).
- *
- *    DESCRIPTION
- *	This is a Phase I test for the sched_rr_get_interval(2) system call.
- *	It is intended to provide a limited exposure of the system call.
- *
- *	Setup:
- *	  Setup signal handling.
- *	  Pause for SIGUSR1 if option specified.
- *	  Change scheduling policy to SCHED_RR
- *
- *	Test:
- *	 Loop if the proper options are given.
- *	  Execute system call
- *	  Check return code, if it is 0,
- *		Test passed.
- *	  Otherwise
- *		Test failed
- *
- *	Cleanup:
- *	  Print errno log and/or timing stats if options given
- *
- * USAGE:  <for command-line>
- * sched_rr_get_interval01 [-c n] [-e] [-i n] [-I x] [-P x] [-t] [-h] [-f] [-p]
- *			where,  -c n : Run n copies concurrently.
- *				-e   : Turn on errno logging.
- *				-h   : Show help screen
- *				-f   : Turn off functional testing
- *				-i n : Execute test n times.
- *				-I x : Execute test for x seconds.
- *				-p   : Pause for SIGUSR1 before starting
- *				-P x : Pause for x seconds between iterations.
- *				-t   : Turn on syscall timing.
- *
+ * Gets round-robin time quantum by calling sched_rr_get_interval() and
+ * checks that the value is sane.
  */
 
 #include <sched.h>
@@ -74,17 +31,12 @@ static struct test_variants {
 static void setup(void)
 {
 	struct test_variants *tv = &variants[tst_variant];
-	/*
-	 * Initialize scheduling parameter structure to use with
-	 * sched_setscheduler()
-	 */
 	struct sched_param p = { 1 };
 
 	tst_res(TINFO, "Testing variant: %s", tv->desc);
 
 	tp.type = tv->type;
 
-	/* Change scheduling policy to SCHED_RR */
 	if ((sched_setscheduler(0, SCHED_RR, &p)) == -1)
 		tst_res(TFAIL | TTERRNO, "sched_setscheduler() failed");
 }
@@ -93,11 +45,6 @@ static void run(void)
 {
 	struct test_variants *tv = &variants[tst_variant];
 
-	/*
-	 * Call sched_rr_get_interval(2) with pid=0 so that it will
-	 * write into the timespec structure pointed to by tp, the
-	 * round robin time quantum for the current process.
-	 */
 	TEST(tv->func(0, tst_ts_get(&tp)));
 
 	if (!TST_RET) {
@@ -106,6 +53,15 @@ static void run(void)
 		tst_res(TFAIL | TTERRNO, "Test Failed, sched_rr_get_interval() returned %ld",
 			TST_RET);
 	}
+
+	if (!tst_ts_valid(&tp)) {
+		tst_res(TPASS, "Time quantum %llis %llins",
+		        tst_ts_get_sec(tp), tst_ts_get_nsec(tp));
+	} else {
+		tst_res(TFAIL, "Invalid time quantum %llis %llins",
+		        tst_ts_get_sec(tp), tst_ts_get_nsec(tp));
+	}
+
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval02.c b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval02.c
index 8da42e974..5b38e5bff 100644
--- a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval02.c
+++ b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval02.c
@@ -1,60 +1,17 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) Wipro Technologies Ltd, 2002.  All Rights Reserved.
- *
- *    TEST IDENTIFIER	: sched_rr_get_interval02
- *
- *    EXECUTED BY	: root / superuser
- *
- *    TEST TITLE	: Functionality test
- *
- *    TEST CASE TOTAL	: 1
- *
  *    AUTHOR		: Saji Kumar.V.R <saji.kumar@wipro.com>
  *
- *    SIGNALS
- *	Uses SIGUSR1 to pause before test if option set.
- *	(See the parse_opts(3) man page).
- *
- *    DESCRIPTION
- *	Verify that for a process with scheduling policy SCHED_FIFO,
- *	sched_rr_get_interval() writes zero into timespec structure
- *	for tv_sec & tv_nsec.
- *
- *	Setup:
- *	  Setup signal handling.
- *	  Pause for SIGUSR1 if option specified.
- *	  Change scheduling policy to SCHED_FIFO
- *
- *	Test:
- *	 Loop if the proper options are given.
- *	  Execute system call
- *	  Check (return code == 0) & (got 0 for tv_sec & tv_nsec )
- *		Test passed.
- *	  Otherwise
- *		Test failed
- *
- *	Cleanup:
- *	  Print errno log and/or timing stats if options given
- *
- * USAGE:  <for command-line>
- * sched_rr_get_interval02 [-c n] [-e] [-i n] [-I x] [-P x] [-t] [-h] [-f] [-p]
- *			where,  -c n : Run n copies concurrently.
- *				-e   : Turn on errno logging.
- *				-h   : Show help screen
- *				-f   : Turn off functional testing
- *				-i n : Execute test n times.
- *				-I x : Execute test for x seconds.
- *				-p   : Pause for SIGUSR1 before starting
- *				-P x : Pause for x seconds between iterations.
- *				-t   : Turn on syscall timing.
- *
+ * Verify that for a process with scheduling policy SCHED_FIFO,
+ * sched_rr_get_interval() writes zero into timespec structure
+ * for tv_sec & tv_nsec.
  */
 
 #include <sched.h>
 #include "tst_timer.h"
 
-struct tst_ts tp;
+static struct tst_ts tp;
 
 static struct test_variants {
 	int (*func)(pid_t pid, void *ts);
@@ -75,17 +32,12 @@ static struct test_variants {
 static void setup(void)
 {
 	struct test_variants *tv = &variants[tst_variant];
-	/*
-	 * Initialize scheduling parameter structure to use with
-	 * sched_setscheduler()
-	 */
 	struct sched_param p = { 1 };
 
 	tst_res(TINFO, "Testing variant: %s", tv->desc);
 
 	tp.type = tv->type;
 
-	/* Change scheduling policy to SCHED_FIFO */
 	if ((sched_setscheduler(0, SCHED_FIFO, &p)) == -1)
 		tst_res(TFAIL | TTERRNO, "sched_setscheduler() failed");
 }
@@ -97,17 +49,13 @@ static void run(void)
 	tst_ts_set_sec(&tp, 99);
 	tst_ts_set_nsec(&tp, 99);
 
-	/*
-	 * Call sched_rr_get_interval(2) with pid=0 so that it will
-	 * write into the timespec structure pointed to by tp the
-	 * round robin time quantum for the current process.
-	 */
 	TEST(tv->func(0, tst_ts_get(&tp)));
 
 	if (!TST_RET && tst_ts_valid(&tp) == -1) {
 		tst_res(TPASS, "sched_rr_get_interval() passed");
 	} else {
-		tst_res(TFAIL | TTERRNO, "Test Failed, sched_rr_get_interval() returned %ld, tp.tv_sec = %lld, tp.tv_nsec = %lld",
+		tst_res(TFAIL | TTERRNO,
+			"sched_rr_get_interval() returned %ld, tp.tv_sec = %lld, tp.tv_nsec = %lld",
 			TST_RET, tst_ts_get_sec(tp), tst_ts_get_nsec(tp));
 	}
 }
diff --git a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval03.c b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval03.c
index 0ccf47d2a..d7bbe2686 100644
--- a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval03.c
+++ b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval03.c
@@ -1,59 +1,15 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) Wipro Technologies Ltd, 2002.  All Rights Reserved.
- *
- *    TEST IDENTIFIER	: sched_rr_get_interval03
- *
- *    EXECUTED BY	: root / superuser
- *
- *    TEST TITLE	: Tests for error conditions
- *
- *    TEST CASE TOTAL	: 3
- *
  *    AUTHOR		: Saji Kumar.V.R <saji.kumar@wipro.com>
  *
- *    SIGNALS
- *	Uses SIGUSR1 to pause before test if option set.
- *	(See the parse_opts(3) man page).
- *
- *    DESCRIPTION
- *	Verify that
- *	1) sched_rr_get_interval() fails with errno set to EINVAL for an
- *	   invalid pid
- *	2) sched_rr_get_interval() fails with errno set to ESRCH if the
- *	   process with specified pid does not exists
- *	2) sched_rr_get_interval() fails with errno set to EFAULT if the
- *	   address specified as &tp is invalid
- *
- *	Setup:
- *	  Setup signal handling.
- *	  Set expected errors for logging.
- *	  Pause for SIGUSR1 if option specified.
- *	  Change scheduling policy to SCHED_RR
- *
- *	Test:
- *	 Loop if the proper options are given.
- *	  Execute system call
- *	  if call fails with expected errno,
- *		Test passed.
- *	  Otherwise
- *		Test failed
- *
- *	Cleanup:
- *	  Print errno log and/or timing stats if options given
- *
- * USAGE:  <for command-line>
- * sched_rr_get_interval03 [-c n] [-e] [-i n] [-I x] [-P x] [-t] [-h] [-f] [-p]
- *			where,  -c n : Run n copies concurrently.
- *				-e   : Turn on errno logging.
- *				-h   : Show help screen
- *				-f   : Turn off functional testing
- *				-i n : Execute test n times.
- *				-I x : Execute test for x seconds.
- *				-p   : Pause for SIGUSR1 before starting
- *				-P x : Pause for x seconds between iterations.
- *				-t   : Turn on syscall timing.
- *
+ * Verify that
+ *  1) sched_rr_get_interval() fails with errno set to EINVAL for an
+ *     invalid pid
+ *  2) sched_rr_get_interval() fails with errno set to ESRCH if the
+ *     process with specified pid does not exists
+ *  3) sched_rr_get_interval() fails with errno set to EFAULT if the
+ *     address specified as &tp is invalid
  */
 
 #include <sched.h>
@@ -63,7 +19,7 @@ static pid_t unused_pid;
 static pid_t inval_pid = -1;
 static pid_t zero_pid;
 
-struct tst_ts tp;
+static struct tst_ts tp;
 static void *bad_addr;
 
 struct test_cases_t {
@@ -73,10 +29,7 @@ struct test_cases_t {
 } test_cases[] = {
 	{ &inval_pid, &tp, EINVAL},
 	{ &unused_pid, &tp, ESRCH},
-#ifndef UCLINUX
-	/* Skip since uClinux does not implement memory protection */
 	{ &zero_pid, NULL, EFAULT}
-#endif
 };
 
 static struct test_variants {
@@ -98,10 +51,6 @@ static struct test_variants {
 static void setup(void)
 {
 	struct test_variants *tv = &variants[tst_variant];
-	/*
-	 * Initialize scheduling parameter structure to use with
-	 * sched_setscheduler()
-	 */
 	struct sched_param p = { 1 };
 
 	tst_res(TINFO, "Testing variant: %s", tv->desc);
@@ -109,7 +58,6 @@ static void setup(void)
 	bad_addr = tst_get_bad_addr(NULL);
 	tp.type = tv->type;
 
-	/* Change scheduling policy to SCHED_RR */
 	if ((sched_setscheduler(0, SCHED_RR, &p)) == -1)
 		tst_res(TFAIL | TTERRNO, "sched_setscheduler() failed");
 
@@ -127,9 +75,6 @@ static void run(unsigned int i)
 	else
 		ts = tst_ts_get(tc->tp);
 
-	/*
-	 * Call sched_rr_get_interval(2)
-	 */
 	TEST(tv->func(*tc->pid, ts));
 
 	if (TST_RET != -1) {

-- 
Cyril Hrubis
chrubis@suse.cz
