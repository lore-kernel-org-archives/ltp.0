Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <lxiang@redhat.com>) id 1Sn4tJ-00061v-Uv
	for ltp-list@lists.sourceforge.net; Fri, 06 Jul 2012 09:31:57 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Sn4tF-00013K-OY
	for ltp-list@lists.sourceforge.net; Fri, 06 Jul 2012 09:31:57 +0000
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q669VlSI019154
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 6 Jul 2012 05:31:47 -0400
Received: from wlan-5-140.nay.redhat.com (wlan-5-140.nay.redhat.com
	[10.66.12.140] (may be forged))
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id q669Vj7u024855
	for <ltp-list@lists.sourceforge.net>; Fri, 6 Jul 2012 05:31:46 -0400
From: Lingzhu Xiang <lxiang@redhat.com>
Date: Sun,  8 Jul 2012 08:09:53 +0800
Message-Id: <1e99528971ce08cfebd0bd9c2b3333295dc9efe4.1341705843.git.lxiang@redhat.com>
Subject: [LTP]  [PATCH] timers: add a new test case leapsec_timer
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
To: LTP List <ltp-list@lists.sourceforge.net>

A bug in the hrtimer subsystem caused all TIMER_ABSTIME CLOCK_REALTIME
timers to expire one second early during and after leap seconds, thus
such sub-second timers expire immediately, causing load spikes if used
in fast loops. Calling clock_was_set() reverts this state. See [1].

[1]: http://lwn.net/Articles/504658/.

This patch is a regression test for the bug, based on the test case
provided by John Stultz from the above link, and also tries to recover
from inconsistency caused by reproduction of the bug.

Signed-off-by: Lingzhu Xiang <lxiang@redhat.com>
---
 runtest/timers                                  |    1 +
 testcases/kernel/timers/leapsec/Makefile        |   27 +++
 testcases/kernel/timers/leapsec/leapsec_timer.c |  222 +++++++++++++++++++++++
 3 files changed, 250 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/timers/leapsec/Makefile
 create mode 100644 testcases/kernel/timers/leapsec/leapsec_timer.c

diff --git a/runtest/timers b/runtest/timers
index 7a40125..a58ac57 100644
--- a/runtest/timers
+++ b/runtest/timers
@@ -10,3 +10,4 @@ timer_delete02 timer_delete02
 timer_delete03 timer_delete03
 timer_settime02 timer_settime02
 timer_settime03 timer_settime03
+leapsec_timer leapsec_timer
diff --git a/testcases/kernel/timers/leapsec/Makefile b/testcases/kernel/timers/leapsec/Makefile
new file mode 100644
index 0000000..782cdbc
--- /dev/null
+++ b/testcases/kernel/timers/leapsec/Makefile
@@ -0,0 +1,27 @@
+#
+#  Copyright (c) International Business Machines  Corp., 2001
+#
+#  This program is free software;  you can redistribute it and/or modify
+#  it under the terms of the GNU General Public License as published by
+#  the Free Software Foundation; either version 2 of the License, or
+#  (at your option) any later version.
+#
+#  This program is distributed in the hope that it will be useful,
+#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
+#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+#  the GNU General Public License for more details.
+#
+#  You should have received a copy of the GNU General Public License
+#  along with this program;  if not, write to the Free Software
+#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+#
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+
+CPPFLAGS		+= -I$(abs_srcdir)/../include
+
+LDLIBS			+= -lrt
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/timers/leapsec/leapsec_timer.c b/testcases/kernel/timers/leapsec/leapsec_timer.c
new file mode 100644
index 0000000..2fa7bc8
--- /dev/null
+++ b/testcases/kernel/timers/leapsec/leapsec_timer.c
@@ -0,0 +1,222 @@
+/*
+ * Regression test for hrtimer early expiration during and after leap seconds
+ *
+ * A bug in the hrtimer subsystem caused all TIMER_ABSTIME CLOCK_REALTIME
+ * timers to expire one second early during leap second.
+ * See http://lwn.net/Articles/504658/.
+ *
+ * This is a regression test for the bug.
+ *
+ * Lingzhu Xiang <lxiang@redhat.com> Copyright (c) Red Hat, Inc., 2012.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it would be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write the Free Software Foundation, Inc., 59
+ * Temple Place - Suite 330, Boston MA 02111-1307, USA.
+ *
+ */
+
+#include <sys/types.h>
+#include <sys/time.h>
+#include <sys/timex.h>
+#include <errno.h>
+#include <stdlib.h>
+#include <time.h>
+#include "test.h"
+#include "usctest.h"
+#include "common_timers.h"
+
+#define SECONDS_BEFORE_LEAP 2
+#define SECONDS_AFTER_LEAP 2
+
+char *TCID = "leapsec_timer";
+int TST_TOTAL = 1;
+
+static inline int in_order(struct timespec a, struct timespec b);
+static void adjtimex_status(struct timex *tx, int status);
+static const char *strtime(const struct timespec *now);
+static void test_hrtimer_early_expiration(void);
+static void run_leapsec(void);
+static void setup(void);
+static void cleanup(void);
+
+int main(int argc, char **argv)
+{
+	char *msg;
+	int lc;
+
+	msg = parse_opts(argc, argv, NULL, NULL);
+	if (msg != NULL)
+		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
+
+	setup();
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		Tst_count = 0;
+		run_leapsec();
+	}
+
+	cleanup();
+	tst_exit();
+}
+
+static inline int in_order(struct timespec a, struct timespec b)
+{
+	if (a.tv_sec < b.tv_sec)
+		return 1;
+	if (a.tv_sec > b.tv_sec)
+		return 0;
+	if (a.tv_nsec > b.tv_nsec)
+		return 0;
+	return 1;
+}
+
+static void adjtimex_status(struct timex *tx, int status)
+{
+	const char * const msgs[6] = {
+		"clock synchronized",
+		"insert leap second",
+		"delete leap second",
+		"leap second in progress",
+		"leap second has occurred",
+		"clock not synchronized",
+	};
+	int r;
+	struct timespec now;
+
+	tx->modes = ADJ_STATUS;
+	tx->status = status;
+	r = adjtimex(tx);
+	now.tv_sec = tx->time.tv_sec;
+	now.tv_nsec = tx->time.tv_usec * 1000;
+
+	if ((tx->status & status) != status)
+		tst_brkm(TBROK, cleanup, "adjtimex status %d not set", status);
+	else if (r < 0)
+		tst_brkm(TBROK | TERRNO, cleanup, "adjtimex");
+	else if (r < 6)
+		tst_resm(TINFO, "%s adjtimex: %s", strtime(&now), msgs[r]);
+	else
+		tst_resm(TINFO, "%s adjtimex: clock state %d",
+		    strtime(&now), r);
+}
+
+static const char *strtime(const struct timespec *now)
+{
+	static char fmt[256], buf[256];
+
+	if (snprintf(fmt, sizeof(fmt), "%%F %%T.%09ld %%z", now->tv_nsec) < 0) {
+		buf[0] = '\0';
+		return buf;
+	}
+	if (!strftime(buf, sizeof(buf), fmt, localtime(&now->tv_sec))) {
+		buf[0] = '\0';
+		return buf;
+	}
+	return buf;
+}
+
+static void test_hrtimer_early_expiration(void)
+{
+	struct timespec now, target;
+	int r, fail;
+
+	clock_gettime(CLOCK_REALTIME, &now);
+	tst_resm(TINFO, "now is     %s", strtime(&now));
+
+	target = now;
+	target.tv_sec++;
+	tst_resm(TINFO, "sleep till %s", strtime(&target));
+	r = clock_nanosleep(CLOCK_REALTIME, TIMER_ABSTIME, &target, NULL);
+	if (r < 0) {
+		tst_resm(TINFO | TERRNO, "clock_nanosleep");
+		return;
+	}
+
+	clock_gettime(CLOCK_REALTIME, &now);
+	tst_resm(TINFO, "now is     %s", strtime(&now));
+
+	fail = !in_order(target, now);
+	tst_resm(fail ? TFAIL : TINFO, "hrtimer early expiration is %s.",
+	    fail ? "detected" : "not detected");
+}
+
+static void run_leapsec(void)
+{
+	const struct timespec sleeptime = {0, NSEC_PER_SEC / 2};
+	struct timespec now, leap, start;
+	struct timex tx;
+
+	clock_gettime(CLOCK_REALTIME, &now);
+	start = now;
+	tst_resm(TINFO, "test start at %s", strtime(&now));
+
+	test_hrtimer_early_expiration();
+
+	/* calculate the next leap second */
+	now.tv_sec += 86400 - now.tv_sec % 86400;
+	now.tv_nsec = 0;
+	leap = now;
+	tst_resm(TINFO, "scheduling leap second %s", strtime(&leap));
+
+	/* start before the leap second */
+	now.tv_sec -= SECONDS_BEFORE_LEAP;
+	if (clock_settime(CLOCK_REALTIME, &now) < 0)
+		tst_brkm(TBROK | TERRNO, cleanup, "clock_settime");
+	tst_resm(TINFO, "setting time to        %s", strtime(&now));
+
+	/* reset NTP time state */
+	adjtimex_status(&tx, STA_PLL);
+	adjtimex_status(&tx, 0);
+
+	/* set the leap second insert flag */
+	adjtimex_status(&tx, STA_INS);
+
+	/* reliably sleep till after the leap second */
+	while (tx.time.tv_sec < leap.tv_sec + SECONDS_AFTER_LEAP) {
+		adjtimex_status(&tx, tx.status);
+		clock_nanosleep(CLOCK_MONOTONIC, 0, &sleeptime, NULL);
+	}
+
+	test_hrtimer_early_expiration();
+
+	adjtimex_status(&tx, STA_PLL);
+	adjtimex_status(&tx, 0);
+
+	/* recover from timer expiring state and restore time */
+	clock_gettime(CLOCK_REALTIME, &now);
+	start.tv_sec += now.tv_sec - (leap.tv_sec - SECONDS_BEFORE_LEAP);
+	start.tv_nsec += now.tv_nsec;
+	start.tv_sec += start.tv_nsec / NSEC_PER_SEC;
+	start.tv_nsec = start.tv_nsec % NSEC_PER_SEC;
+	tst_resm(TINFO, "restoring time to %s", strtime(&start));
+	/* calls clock_was_set() in kernel to revert inconsistency */
+	if (clock_settime(CLOCK_REALTIME, &start) < 0)
+		tst_brkm(TBROK | TERRNO, cleanup, "clock_settime");
+
+	test_hrtimer_early_expiration();
+}
+
+static void setup(void)
+{
+	tst_require_root(NULL);
+	tst_sig(NOFORK, DEF_HANDLER, CLEANUP);
+	TEST_PAUSE;
+}
+
+static void cleanup(void)
+{
+	struct timespec now;
+	clock_gettime(CLOCK_REALTIME, &now);
+	/* Calls clock_was_set() in kernel to revert inconsistency.
+	 * The only possible EPERM doesn't matter here. */
+	clock_settime(CLOCK_REALTIME, &now);
+	TEST_CLEANUP;
+}
-- 
1.7.7.6


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
