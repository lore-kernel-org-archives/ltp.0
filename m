Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1XRhIM-0001Us-8m
	for ltp-list@lists.sourceforge.net; Wed, 10 Sep 2014 12:46:46 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XRhIK-000340-EZ
	for ltp-list@lists.sourceforge.net; Wed, 10 Sep 2014 12:46:46 +0000
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s8ACkbY8015172
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Wed, 10 Sep 2014 08:46:37 -0400
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with
	ESMTP id s8ACkaLs023801
	for <ltp-list@lists.sourceforge.net>; Wed, 10 Sep 2014 08:46:37 -0400
From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 10 Sep 2014 14:46:34 +0200
Message-Id: <8a36059fe9afea205712b2a1c9a0ca678b22b927.1410353116.git.jstancek@redhat.com>
Subject: [LTP] [PATCH] add clock_gettime04
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

Add regression test for commit:
  commit 4036ac1567834222fc763ab18e3e17df93b4eaaf
  Author: Mike Galbraith <umgwanakikbuti@gmail.com>
  Date:   Tue Jun 24 07:49:40 2014 +0200
    sched: Fix clock_gettime(CLOCK_[PROCESS/THREAD]_CPUTIME_ID) monotonicity

Cpu time returned by clock_gettime for thread specific clock prior to
this commit is not monotonic.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 runtest/timers                                     |    1 +
 testcases/kernel/timers/clock_gettime/.gitignore   |    1 +
 .../kernel/timers/clock_gettime/clock_gettime04.c  |  208 ++++++++++++++++++++
 3 files changed, 210 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/timers/clock_gettime/clock_gettime04.c

diff --git a/runtest/timers b/runtest/timers
index a58ac57..daa617f 100644
--- a/runtest/timers
+++ b/runtest/timers
@@ -1,6 +1,7 @@
 #DESCRIPTION:Posix Timer Tests
 clock_gettime02 clock_gettime02
 clock_gettime03 clock_gettime03
+clock_gettime04 clock_gettime04
 clock_settime02 clock_settime02
 clock_settime03 clock_settime03
 timer_create02 timer_create02
diff --git a/testcases/kernel/timers/clock_gettime/.gitignore b/testcases/kernel/timers/clock_gettime/.gitignore
index 004e742..4f17c8b 100644
--- a/testcases/kernel/timers/clock_gettime/.gitignore
+++ b/testcases/kernel/timers/clock_gettime/.gitignore
@@ -1,2 +1,3 @@
 /clock_gettime02
 /clock_gettime03
+/clock_gettime04
diff --git a/testcases/kernel/timers/clock_gettime/clock_gettime04.c b/testcases/kernel/timers/clock_gettime/clock_gettime04.c
new file mode 100644
index 0000000..9d1cb55
--- /dev/null
+++ b/testcases/kernel/timers/clock_gettime/clock_gettime04.c
@@ -0,0 +1,208 @@
+/*
+ *  Copyright (c) Linux Test Project, 2014
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU Library General Public License for more details.
+ */
+/*
+ * This is a regression test for bug fixed by:
+ *   commit 4036ac1567834222fc763ab18e3e17df93b4eaaf
+ *   Author: Mike Galbraith <umgwanakikbuti@gmail.com>
+ *   Date:   Tue Jun 24 07:49:40 2014 +0200
+ *     sched: Fix clock_gettime(CLOCK_[PROCESS/THREAD]_CPUTIME_ID) monotonicity
+ *
+ * cpu time returned by clock_gettime for thread specific clock prior to
+ * this commit is not monotonic.
+ */
+
+#include <pthread.h>
+#include <inttypes.h>
+#include <errno.h>
+
+#include "test.h"
+#include "usctest.h"
+#include "safe_macros.h"
+
+#define DEFAULT_TEST_TIME 4
+#define THREAD_COUNT 8
+#define NANOSECS_PER_SEC 1000000000
+
+#define SAFE_PTHREAD(fn, ...) do { \
+	int ret = fn(__VA_ARGS__); \
+	if (ret) { \
+		TEST_ERRNO = ret; \
+		tst_brkm(TBROK | TTERRNO, cleanup, #fn); \
+	} \
+} while (0)
+
+char *TCID = "clock_gettime04";
+int TST_TOTAL = 1;
+
+static volatile sig_atomic_t done_testing;
+static int opt_testtime;
+static char *opt_testtimestr;
+static option_t options[] = {
+	{"T:", &opt_testtime, &opt_testtimestr},
+	{NULL, NULL, NULL}
+};
+static pthread_mutex_t exit_mutex = PTHREAD_MUTEX_INITIALIZER;
+
+static void setup(void);
+static void cleanup(void);
+
+static void sigproc(int sig)
+{
+	(void) sig;
+	done_testing = 1;
+}
+
+int64_t get_thread_cpu_time(pthread_t thread)
+{
+	clockid_t clockid;
+	int ret;
+	struct timespec tp;
+
+	SAFE_PTHREAD(pthread_getcpuclockid, thread, &clockid);
+
+	ret = clock_gettime(clockid, &tp);
+	if (ret)
+		tst_brkm(TBROK | TERRNO, cleanup, "clock_gettime: %d", ret);
+
+	return (tp.tv_sec * NANOSECS_PER_SEC) + tp.tv_nsec;
+}
+
+static void *child(void *arg)
+{
+	struct timespec tim;
+	int64_t t, t_last = 0;
+	int check_own_cpu_time = *(int *)arg;
+
+	tim.tv_sec = 0;
+	tim.tv_nsec = 5000;
+
+	while (!done_testing) {
+		nanosleep(&tim, NULL);
+
+		if (!check_own_cpu_time)
+			continue;
+
+		t = get_thread_cpu_time(pthread_self());
+		if (t < t_last) {
+			tst_resm(TFAIL, "t: %" PRId64 " < t_last: %"
+				PRId64,	t, t_last);
+			done_testing = 2;
+		} else {
+			t_last = t;
+		}
+	}
+
+	SAFE_PTHREAD(pthread_mutex_lock, &exit_mutex);
+	SAFE_PTHREAD(pthread_mutex_unlock, &exit_mutex);
+
+	return NULL;
+}
+
+static void test(int seconds)
+{
+	int i, child_check_cpu_time[] = { 0, 1 };
+	pthread_t thread[THREAD_COUNT];
+	clockid_t clockid[THREAD_COUNT];
+	int64_t thread_time[THREAD_COUNT], cur_time;
+
+	done_testing = 0;
+	alarm(seconds);
+
+	/* create children and make every 2nd child check its own
+	 * cpu time as well. */
+	for (i = 0; i < THREAD_COUNT; i++) {
+		SAFE_PTHREAD(pthread_create, &thread[i], NULL, child,
+			&child_check_cpu_time[i % 2]);
+		SAFE_PTHREAD(pthread_getcpuclockid, thread[i], &clockid[i]);
+		tst_resm(TINFO, "thread no.: %d clockid: %d", i, clockid[i]);
+	}
+
+	for (i = 0; i < THREAD_COUNT; i++)
+		thread_time[i] = get_thread_cpu_time(thread[i]);
+
+	SAFE_PTHREAD(pthread_mutex_lock, &exit_mutex);
+
+	/* check periodically that cpu time of each thread
+	 * doesn't go backwards */
+	while (!done_testing) {
+		for (i = 0; i < THREAD_COUNT; i++) {
+			cur_time = get_thread_cpu_time(thread[i]);
+			if (cur_time < thread_time[i]) {
+				tst_resm(TFAIL, "cpu clock time went backwards "
+						"thread no. %d, clock id: %d"
+						" previous value: %" PRId64
+						" current value: %" PRId64,
+						i, clockid[i], thread_time[i],
+						cur_time);
+				done_testing = 2;
+				break;
+			}
+			thread_time[i] = cur_time;
+		}
+	}
+
+	/* allow children to exit now */
+	SAFE_PTHREAD(pthread_mutex_unlock, &exit_mutex);
+
+	for (i = 0; i < THREAD_COUNT; i++)
+		SAFE_PTHREAD(pthread_join, thread[i], NULL);
+
+	if (done_testing == 1)
+		tst_resm(TPASS, "Test completed, cpu times of all "
+				"thread clocks were monotonic");
+}
+
+int main(int argc, char *argv[])
+{
+	int testtime = DEFAULT_TEST_TIME;
+	const char *msg = NULL;
+
+	msg = parse_opts(argc, argv, options, NULL);
+	if (msg)
+		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
+
+	if (opt_testtime) {
+		testtime = atoi(opt_testtimestr);
+		if (testtime <= 0) {
+			tst_brkm(TBROK, NULL, "Invalid arg for -T: %s",
+				opt_testtimestr);
+		}
+	}
+
+	setup();
+
+	test(testtime);
+
+	cleanup();
+	tst_exit();
+}
+
+static void setup(void)
+{
+	struct sigaction sa;
+
+	TEST_PAUSE;
+
+	sigemptyset(&sa.sa_mask);
+	sa.sa_handler = sigproc;
+	sa.sa_flags = 0;
+
+	if (sigaction(SIGALRM, &sa, 0) == -1)
+		tst_brkm(TBROK | TERRNO, NULL, "sigaction() failed");
+}
+
+static void cleanup(void)
+{
+	TEST_CLEANUP;
+}
-- 
1.7.1


------------------------------------------------------------------------------
Want excitement?
Manually upgrade your production database.
When you want reliability, choose Perforce
Perforce version control. Predictably reliable.
http://pubads.g.doubleclick.net/gampad/clk?id=157508191&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
