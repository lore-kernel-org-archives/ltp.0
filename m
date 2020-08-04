From: Martin Doucha <mdoucha@suse.cz>
Date: Tue,  4 Aug 2020 12:49:37 +0200
Subject: [LTP] [PATCH] Add test for CVE 2017-2636
Message-ID: <20200804104937.5541-1-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Fixes #498

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 include/lapi/tty.h            |   4 ++
 runtest/cve                   |   1 +
 runtest/pty                   |   1 +
 testcases/kernel/pty/Makefile |   4 +-
 testcases/kernel/pty/pty05.c  | 107 ++++++++++++++++++++++++++++++++++
 5 files changed, 115 insertions(+), 2 deletions(-)
 create mode 100644 testcases/kernel/pty/pty05.c

diff --git a/include/lapi/tty.h b/include/lapi/tty.h
index 353a103f1..6122145f3 100644
--- a/include/lapi/tty.h
+++ b/include/lapi/tty.h
@@ -10,6 +10,10 @@
 # include <linux/tty.h>
 #endif
 
+#ifndef N_HDLC
+# define N_HDLC 13
+#endif
+
 #ifndef N_SLCAN
 # define N_SLCAN		17	/* Serial / USB serial CAN Adaptors */
 #endif
diff --git a/runtest/cve b/runtest/cve
index fdb455af1..fa37ed38e 100644
--- a/runtest/cve
+++ b/runtest/cve
@@ -17,6 +17,7 @@ cve-2016-9604 keyctl08
 cve-2016-9793 setsockopt04
 cve-2016-10044 cve-2016-10044
 cve-2017-2618 cve-2017-2618
+cve-2017-2636 pty05
 cve-2017-2671 cve-2017-2671
 cve-2017-6951 request_key05
 cve-2017-7308 setsockopt02
diff --git a/runtest/pty b/runtest/pty
index 5587312d3..a43b18f2d 100644
--- a/runtest/pty
+++ b/runtest/pty
@@ -3,6 +3,7 @@ pty01 pty01
 pty02 pty02
 pty03 pty03
 pty04 pty04
+pty05 pty05
 ptem01 ptem01
 hangup01 hangup01
 
diff --git a/testcases/kernel/pty/Makefile b/testcases/kernel/pty/Makefile
index 4469775aa..87d70ac1d 100644
--- a/testcases/kernel/pty/Makefile
+++ b/testcases/kernel/pty/Makefile
@@ -24,7 +24,7 @@ top_srcdir		?= ../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 
-pty03: CFLAGS += -pthread
-pty03: LDLIBS += -lrt
+pty03 pty05: CFLAGS += -pthread
+pty03 pty05: LDLIBS += -lrt
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/pty/pty05.c b/testcases/kernel/pty/pty05.c
new file mode 100644
index 000000000..6e1d7972a
--- /dev/null
+++ b/testcases/kernel/pty/pty05.c
@@ -0,0 +1,107 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 SUSE LLC <mdoucha@suse.cz>
+ */
+
+/*
+ * CVE-2017-2636
+ *
+ * Check for race between flush_tx_queue() and n_hdlc_send_frames(). Kernel
+ * crash fixed in:
+ *
+ *  commit 82f2341c94d270421f383641b7cd670e474db56b
+ *  Author: Alexander Popov <alex.popov@linux.com>
+ *  Date:   Tue Feb 28 19:54:40 2017 +0300
+ *
+ *  tty: n_hdlc: get rid of racy n_hdlc.tbuf
+ */
+
+#define _GNU_SOURCE
+#include <termios.h>
+#include "lapi/ioctl.h"
+#include "lapi/tty.h"
+
+#include "tst_test.h"
+#include "tst_taint.h"
+#include "tst_fuzzy_sync.h"
+
+#define BUF_SIZE 1
+
+static struct tst_fzsync_pair fzsync_pair;
+static volatile int ptmx = -1;
+static char buf[BUF_SIZE];
+
+static void setup(void)
+{
+	tst_taint_init(TST_TAINT_W | TST_TAINT_D);
+
+	fzsync_pair.exec_loops = 100000;
+	tst_fzsync_pair_init(&fzsync_pair);
+}
+
+static void *thread_run(void *arg)
+{
+	while (tst_fzsync_run_b(&fzsync_pair)) {
+		tst_fzsync_start_race_b(&fzsync_pair);
+		ioctl(ptmx, TCFLSH, TCIOFLUSH);
+		tst_fzsync_end_race_b(&fzsync_pair);
+	}
+
+	return arg;
+}
+
+static void run(void)
+{
+	int ldisc = N_HDLC;
+
+	tst_fzsync_pair_reset(&fzsync_pair, thread_run);
+
+	while (tst_fzsync_run_a(&fzsync_pair)) {
+		ptmx = SAFE_OPEN("/dev/ptmx", O_RDWR);
+		TEST(ioctl(ptmx, TIOCSETD, &ldisc));
+
+		if (TST_RET == -1 && TST_ERR == EINVAL) {
+			tst_brk(TCONF, "HDLC line discipline not available");
+		} else if (TST_RET == -1) {
+			tst_brk(TBROK | TTERRNO, "Cannot set line discipline");
+		} else if (TST_RET != 0) {
+			tst_brk(TBROK | TTERRNO,
+				"Invalid ioctl() return value %ld", TST_RET);
+		}
+
+		SAFE_IOCTL(ptmx, TCXONC, TCOOFF);
+		SAFE_WRITE(1, ptmx, buf, BUF_SIZE);
+
+		tst_fzsync_start_race_a(&fzsync_pair);
+		ioctl(ptmx, TCXONC, TCOON);
+		tst_fzsync_end_race_a(&fzsync_pair);
+
+		SAFE_CLOSE(ptmx);
+
+		if (tst_taint_check()) {
+			tst_res(TFAIL, "Kernel is vulnerable");
+			return;
+		}
+	}
+
+	tst_res(TPASS, "Nothing bad happened, probably");
+}
+
+static void cleanup(void)
+{
+	tst_fzsync_pair_cleanup(&fzsync_pair);
+
+	if (ptmx >= 0)
+		SAFE_CLOSE(ptmx);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "82f2341c94d27"},
+		{"CVE", "2017-2636"},
+		{}
+	}
+};
-- 
2.27.0

