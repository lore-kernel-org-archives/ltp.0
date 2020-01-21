From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Tue, 21 Jan 2020 15:07:07 +0100
Subject: [LTP] [RFC PATCH] pty03: Regression test for slip/slcan data race
Message-ID: <20200121140707.20583-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---

The kernel patch to fix this is still under review:
https://lore.kernel.org/netdev/20200121134258.18013-1-rpalethorpe@suse.com/T/#u

 testcases/kernel/pty/Makefile |   2 +
 testcases/kernel/pty/pty03.c  | 132 ++++++++++++++++++++++++++++++++++
 2 files changed, 134 insertions(+)
 create mode 100644 testcases/kernel/pty/pty03.c

diff --git a/testcases/kernel/pty/Makefile b/testcases/kernel/pty/Makefile
index f9fc4f57e..52bb56c8d 100644
--- a/testcases/kernel/pty/Makefile
+++ b/testcases/kernel/pty/Makefile
@@ -26,4 +26,6 @@ include $(top_srcdir)/include/mk/testcases.mk
 
 CPPFLAGS		+= -D_GNU_SOURCE
 
+pty03: LDFLAGS += -pthread
+
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/pty/pty03.c b/testcases/kernel/pty/pty03.c
new file mode 100644
index 000000000..d9eaf1a67
--- /dev/null
+++ b/testcases/kernel/pty/pty03.c
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 SUSE
+ *
+ * Test based on Syzkaller reproducer:
+ * https://syzkaller.appspot.com/bug?id=680c24ff647dd7241998e19da52e8136d2fd3523
+ *
+ * The SLIP and SLCAN disciplines can have a race between write_wakeup and
+ * close/hangup. This atleast allows the netdev private data (tty->disc_data)
+ * to be set to NULL or possibly freed while a transmit operation is being
+ * added to a workqueue.
+ *
+ * If the race condition exists, then the most likely result of running this
+ * is a null pointer dereference.
+ *
+ * Note that we must set the line discipline to "mouse" first which, for
+ * whatever reason, results in tty_wakeup being called during the close
+ * operation.
+ */
+
+#include <stdlib.h>
+#include <stdio.h>
+#include <errno.h>
+#include <termio.h>
+#include <termios.h>
+#include <sys/ioctl.h>
+
+#include "tst_test.h"
+#include "tst_safe_stdio.h"
+#include "tst_fuzzy_sync.h"
+
+struct ldisc_info {
+	int n;
+	char *name;
+};
+
+static struct ldisc_info ldiscs[] = {
+	{2, "mouse"},
+
+	{1, "SLIP"},
+	{17, "SLCAN"}
+};
+
+static struct tst_fzsync_pair fzp;
+static volatile int ptmx;
+
+static void *hangup(void *unused)
+{
+	int i;
+
+	while (tst_fzsync_run_b(&fzp)) {
+		tst_fzsync_start_race_b(&fzp);
+		for (i = 0; i < 10; i++) {
+			if (tcflush(ptmx, TCIFLUSH))
+				tst_brk(TBROK | TERRNO, "tcflush(ptmx, TCIFLUSH)");
+		}
+		tst_fzsync_end_race_b(&fzp);
+	}
+
+	return unused;
+}
+
+static int set_ldisc(int tty, struct ldisc_info *ldisc)
+{
+	TEST(ioctl(tty, TIOCSETD, &ldisc->n));
+
+	if (!TST_RET)
+		return 0;
+
+	if (TST_ERR == EINVAL) {
+		tst_res(TCONF | TTERRNO,
+			"You don't appear to have the %s TTY line discipline",
+			ldisc->name);
+	} else {
+		tst_res(TBROK | TTERRNO,
+			"Failed to set the %s line discipline", ldisc->name);
+	}
+
+	return 1;
+}
+
+static void do_test(unsigned int n)
+{
+	int pts;
+	char pts_path[PATH_MAX];
+
+	tst_fzsync_pair_reset(&fzp, hangup);
+	while (tst_fzsync_run_a(&fzp)) {
+		ptmx = SAFE_OPEN("/dev/ptmx", O_RDONLY);
+		if (grantpt(ptmx))
+			tst_brk(TBROK | TERRNO, "grantpt(ptmx)");
+		if (unlockpt(ptmx))
+			tst_brk(TBROK | TERRNO, "unlockpt(ptmx)");
+		if (ptsname_r(ptmx, pts_path, sizeof(pts_path)))
+			tst_brk(TBROK | TERRNO, "ptsname_r(ptmx, ...)");
+		pts = SAFE_OPEN(pts_path, O_RDONLY);
+
+		if (set_ldisc(pts, &ldiscs[0]))
+			tst_brk(TCONF, "Need to set mouse discipline first");
+		if (set_ldisc(pts, &ldiscs[n + 1]))
+			return;
+
+		tst_fzsync_start_race_a(&fzp);
+		ioctl(pts, TIOCVHANGUP);
+		tst_fzsync_end_race_a(&fzp);
+
+		SAFE_CLOSE(pts);
+		SAFE_CLOSE(ptmx);
+	}
+
+	tst_res(TPASS, "Did not crash with %s TTY discipline", ldiscs[n+1].name);
+}
+
+static void setup(void)
+{
+	fzp.min_samples = 20;
+	fzp.exec_time_p = 0.1;
+
+	tst_fzsync_pair_init(&fzp);
+}
+
+static void cleanup(void)
+{
+	tst_fzsync_pair_cleanup(&fzp);
+}
+
+static struct tst_test test = {
+	.test = do_test,
+	.tcnt = 2,
+	.setup = setup,
+	.cleanup = cleanup
+};
-- 
2.24.0

