From: Jorik Cronenberg <jcronenberg@suse.de>
Date: Wed, 15 Jan 2020 16:51:56 +0100
Subject: [LTP] [PATCH] syscalls/timerfd01: Port to new library & cleanup
Message-ID: <20200115155156.5891-1-jcronenberg@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Port timerfd01 to new test library and clean it up.
Also make it use the LTP framework properly.

Signed-off-by: Jorik Cronenberg <jcronenberg@suse.de>
---
Hi,

in cleaning this testcase up i removed a lot of information
reporting, most of which I found to be unnecessary.
Since it didn't do anything with the values except printing
it generated a lot of noise. But some could theoretically
be useful, feel free to let me know if something should be kept.

regards,
Jorik

 testcases/kernel/syscalls/timerfd/timerfd01.c | 284 +++++-------------
 1 file changed, 70 insertions(+), 214 deletions(-)

diff --git a/testcases/kernel/syscalls/timerfd/timerfd01.c b/testcases/kernel/syscalls/timerfd/timerfd01.c
index 868fbe271..6d17357f1 100644
--- a/testcases/kernel/syscalls/timerfd/timerfd01.c
+++ b/testcases/kernel/syscalls/timerfd/timerfd01.c
@@ -1,110 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *  timerfd() test by Davide Libenzi (test app for timerfd)
  *  Copyright (C) 2007  Davide Libenzi
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- *
  *  Davide Libenzi <davidel@xmailserver.org>
  *
+ *  Description:
+ *	Test timerfd with the flags:
+ *		1) CLOCK_MONOTONIC
+ *		2) CLOCK_REALTIME
  *
- *     $ gcc -o timerfd-test2 timerfd-test2.c -lrt
- *
- * NAME
- *	timerfd01.c
  * HISTORY
- *	28/05/2008 Initial contribution by Davide Libenzi <davidel@xmailserver.org>
- *      28/05/2008 Integrated to LTP by Subrata Modak <subrata@linux.vnet.ibm.com>
+ *  28/05/2008 Initial contribution by Davide Libenzi <davidel@xmailserver.org>
+ *  28/05/2008 Integrated to LTP by Subrata Modak <subrata@linux.vnet.ibm.com>
  */
 
 #define _GNU_SOURCE
-#include <sys/syscall.h>
-#include <sys/types.h>
-#include <sys/signal.h>
-#include <sys/time.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <string.h>
-#include <unistd.h>
-#include <signal.h>
 #include <poll.h>
-#include <fcntl.h>
-#include <time.h>
-#include <errno.h>
-#include "test.h"
-#include "lapi/syscalls.h"
-
-#define cleanup tst_exit
-
-char *TCID = "timerfd01";
-
-/*
- * This were good at the time of 2.6.23-rc7 ...
- *
- * #ifdef __NR_timerfd
- *
- * ... but is not now with 2.6.25
- */
-#ifdef __NR_timerfd_create
-
-/* Definitions from include/linux/timerfd.h */
-#define TFD_TIMER_ABSTIME (1 << 0)
+#include "tst_test.h"
+#include "lapi/timerfd.h"
 
-struct tmr_type {
+static struct tcase {
 	int id;
 	char const *name;
+} tcases[] = {
+	{CLOCK_MONOTONIC, "CLOCK MONOTONIC"},
+	{CLOCK_REALTIME, "CLOCK REALTIME"},
 };
 
-unsigned long long getustime(int clockid)
+static unsigned long long getustime(int clockid)
 {
 	struct timespec tp;
 
 	if (clock_gettime((clockid_t) clockid, &tp)) {
-		perror("clock_gettime");
+		tst_res(TFAIL | TERRNO, "clock_gettime() failed");
 		return 0;
 	}
 
 	return 1000000ULL * tp.tv_sec + tp.tv_nsec / 1000;
 }
 
-void set_timespec(struct timespec *tmr, unsigned long long ustime)
+static void set_timespec(struct timespec *tmr, unsigned long long ustime)
 {
-
 	tmr->tv_sec = (time_t) (ustime / 1000000ULL);
 	tmr->tv_nsec = (long)(1000ULL * (ustime % 1000000ULL));
 }
 
-int timerfd_create(int clockid, int flags)
-{
-
-	return ltp_syscall(__NR_timerfd_create, clockid, flags);
-}
-
-int timerfd_settime(int ufc, int flags, const struct itimerspec *utmr,
-		    struct itimerspec *otmr)
-{
-
-	return ltp_syscall(__NR_timerfd_settime, ufc, flags, utmr, otmr);
-}
-
-int timerfd_gettime(int ufc, struct itimerspec *otmr)
+static void settime(int tfd, struct itimerspec *tmr, int tflags,
+	unsigned long long tvalue, int tinterval)
 {
-
-	return ltp_syscall(__NR_timerfd_gettime, ufc, otmr);
+	set_timespec(&tmr->it_value, tvalue);
+	set_timespec(&tmr->it_interval, tinterval);
+	if (timerfd_settime(tfd, tflags, tmr, NULL))
+		tst_brk(TFAIL | TERRNO, "timerfd_settime() failed");
 }
 
-long waittmr(int tfd, int timeo)
+static void waittmr(int tfd, int timeo)
 {
 	u_int64_t ticks;
 	struct pollfd pfd;
@@ -113,170 +64,75 @@ long waittmr(int tfd, int timeo)
 	pfd.events = POLLIN;
 	pfd.revents = 0;
 	if (poll(&pfd, 1, timeo) < 0) {
-		perror("poll");
-		return -1;
+		tst_res(TFAIL | TERRNO, "poll() failed");
+		return;
 	}
 	if ((pfd.revents & POLLIN) == 0) {
-		fprintf(stdout, "no ticks happened\n");
-		return -1;
-	}
-	if (read(tfd, &ticks, sizeof(ticks)) != sizeof(ticks)) {
-		perror("timerfd read");
-		return -1;
+		tst_res(TFAIL, "no ticks happened");
+		return;
 	}
+	SAFE_READ(0, tfd, &ticks, sizeof(ticks));
 
-	return ticks;
+	if (ticks <= 0)
+		tst_res(TFAIL, "got no timer");
 }
 
-int TST_TOTAL = 3;
-
-int main(int ac, char **av)
+static void run(unsigned int n)
 {
 	int tfd;
-	unsigned int i;
-	long ticks;
-	unsigned long long tnow, ttmr;
+	unsigned long long tnow;
 	u_int64_t uticks;
 	struct itimerspec tmr;
-	struct tmr_type clks[] = {
-		{CLOCK_MONOTONIC, "CLOCK MONOTONIC"},
-		{CLOCK_REALTIME, "CLOCK REALTIME"},
-	};
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	if ((tst_kvercmp(2, 6, 25)) < 0) {
-		tst_resm(TCONF, "This test can only run on kernels that are ");
-		tst_resm(TCONF, "2.6.25 and higher");
-		exit(0);
-	}
+	struct tcase *clks = &tcases[n];
 
-	for (i = 0; i < sizeof(clks) / sizeof(clks[0]); i++) {
-		fprintf(stdout,
-			"\n\n---------------------------------------\n");
-		fprintf(stdout, "| testing %s\n", clks[i].name);
-		fprintf(stdout, "---------------------------------------\n\n");
+	if (TFD_TIMER_ABSTIME == 0)
+		tst_brk(TCONF, "Test not suited for this system");
 
-		fprintf(stdout, "relative timer test (at 500 ms) ...\n");
-		set_timespec(&tmr.it_value, 500 * 1000);
-		set_timespec(&tmr.it_interval, 0);
-		tnow = getustime(clks[i].id);
-		if ((tfd = timerfd_create(clks[i].id, 0)) == -1) {
-			perror("timerfd");
-			return 1;
-		}
-		fprintf(stdout, "timerfd = %d\n", tfd);
+	tst_res(TINFO, "testing %s", clks->name);
 
-		if (timerfd_settime(tfd, 0, &tmr, NULL)) {
-			perror("timerfd_settime");
-			return 1;
-		}
+	tfd = timerfd_create(clks->id, 0);
+	if (tfd == -1)
+		tst_brk(TFAIL | TERRNO, "timerfd_create() failed");
 
-		fprintf(stdout, "wating timer ...\n");
-		ticks = waittmr(tfd, -1);
-		ttmr = getustime(clks[i].id);
-		if (ticks <= 0)
-			fprintf(stdout, "whooops! no timer showed up!\n");
-		else
-			fprintf(stdout, "got timer ticks (%ld) after %llu ms\n",
-				ticks, (ttmr - tnow) / 1000);
+	tst_res(TINFO, "relative timer (500 ms)");
+	settime(tfd, &tmr, 0, 500 * 1000, 0);
+	waittmr(tfd, -1);
 
-		fprintf(stdout, "absolute timer test (at 500 ms) ...\n");
-		tnow = getustime(clks[i].id);
-		set_timespec(&tmr.it_value, tnow + 500 * 1000);
-		set_timespec(&tmr.it_interval, 0);
-		if (timerfd_settime(tfd, TFD_TIMER_ABSTIME, &tmr, NULL)) {
-			perror("timerfd_settime");
-			return 1;
-		}
+	tst_res(TINFO, "absolute timer (500 ms)");
+	tnow = getustime(clks->id);
+	settime(tfd, &tmr, TFD_TIMER_ABSTIME, tnow + 500 * 1000, 0);
+	waittmr(tfd, -1);
 
-		fprintf(stdout, "wating timer ...\n");
-		ticks = waittmr(tfd, -1);
-		ttmr = getustime(clks[i].id);
-		if (ticks <= 0)
-			fprintf(stdout, "whooops! no timer showed up!\n");
-		else
-			fprintf(stdout, "got timer ticks (%ld) after %llu ms\n",
-				ticks, (ttmr - tnow) / 1000);
+	tst_res(TINFO, "sequential timer (100 ms)");
+	tnow = getustime(clks->id);
+	settime(tfd, &tmr, TFD_TIMER_ABSTIME, tnow + 100 * 1000, 100 * 1000);
 
-		fprintf(stdout, "sequential timer test (100 ms clock) ...\n");
-		tnow = getustime(clks[i].id);
-		set_timespec(&tmr.it_value, tnow + 100 * 1000);
-		set_timespec(&tmr.it_interval, 100 * 1000);
-		if (timerfd_settime(tfd, TFD_TIMER_ABSTIME, &tmr, NULL)) {
-			perror("timerfd_settime");
-			return 1;
-		}
+	if (timerfd_gettime(tfd, &tmr))
+		tst_res(TFAIL | TERRNO, "timerfd_gettime() failed");
 
-		fprintf(stdout, "sleeping 1 second ...\n");
-		sleep(1);
-		if (timerfd_gettime(tfd, &tmr)) {
-			perror("timerfd_gettime");
-			return 1;
-		}
-		fprintf(stdout, "timerfd_gettime returned:\n"
-			"\tit_value = { %ld, %ld } it_interval = { %ld, %ld }\n",
-			(long)tmr.it_value.tv_sec, (long)tmr.it_value.tv_nsec,
-			(long)tmr.it_interval.tv_sec,
-			(long)tmr.it_interval.tv_nsec);
-		fprintf(stdout, "sleeping 1 second ...\n");
-		sleep(1);
+	waittmr(tfd, -1);
 
-		fprintf(stdout, "wating timer ...\n");
-		ticks = waittmr(tfd, -1);
-		ttmr = getustime(clks[i].id);
-		if (ticks <= 0)
-			fprintf(stdout, "whooops! no timer showed up!\n");
-		else
-			fprintf(stdout, "got timer ticks (%ld) after %llu ms\n",
-				ticks, (ttmr - tnow) / 1000);
+	tst_res(TINFO, "testing with O_NONBLOCK");
+	settime(tfd, &tmr, 0, 100 * 1000, 0);
+	waittmr(tfd, -1);
 
-		fprintf(stdout, "O_NONBLOCK test ...\n");
-		tnow = getustime(clks[i].id);
-		set_timespec(&tmr.it_value, 100 * 1000);
-		set_timespec(&tmr.it_interval, 0);
-		if (timerfd_settime(tfd, 0, &tmr, NULL)) {
-			perror("timerfd_settime");
-			return 1;
-		}
-		fprintf(stdout, "timerfd = %d\n", tfd);
+	SAFE_FCNTL(tfd, F_SETFL, fcntl(tfd, F_GETFL, 0) | O_NONBLOCK);
 
-		fprintf(stdout, "wating timer (flush the single tick) ...\n");
-		ticks = waittmr(tfd, -1);
-		ttmr = getustime(clks[i].id);
-		if (ticks <= 0)
-			fprintf(stdout, "whooops! no timer showed up!\n");
-		else
-			fprintf(stdout, "got timer ticks (%ld) after %llu ms\n",
-				ticks, (ttmr - tnow) / 1000);
+	TEST(read(tfd, &uticks, sizeof(uticks)));
+	if (TST_RET > 0)
+		tst_res(TFAIL, "timer ticks not zero");
+	else if (TST_ERR != EAGAIN)
+		tst_res(TFAIL | TERRNO, "expected errno EAGAIN got");
+	else
+		tst_res(TPASS, "Passed test %s", clks->name);
 
-		fcntl(tfd, F_SETFL, fcntl(tfd, F_GETFL, 0) | O_NONBLOCK);
+	SAFE_FCNTL(tfd, F_SETFL, fcntl(tfd, F_GETFL, 0) & ~O_NONBLOCK);
+	SAFE_CLOSE(tfd);
 
-		if (read(tfd, &uticks, sizeof(uticks)) > 0)
-			fprintf(stdout,
-				"whooops! timer ticks not zero when should have been\n");
-		else if (errno != EAGAIN)
-			fprintf(stdout,
-				"whooops! bad errno value (%d = '%s')!\n",
-				errno, strerror(errno));
-		else
-			fprintf(stdout, "success\n");
-
-		fcntl(tfd, F_SETFL, fcntl(tfd, F_GETFL, 0) & ~O_NONBLOCK);
-
-		close(tfd);
-	}
-
-	tst_exit();
 }
 
-#else
-int TST_TOTAL = 0;
-
-int main(void)
-{
-
-	tst_brkm(TCONF, NULL,
-		 "This test needs a kernel that has timerfd syscall.");
-}
-#endif
+static struct tst_test test = {
+	.test = run,
+	.tcnt = ARRAY_SIZE(tcases),
+	.min_kver = "2.6.25",
+};
-- 
2.24.1

