From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Mon, 28 Aug 2017 13:02:38 +0200
Subject: [LTP] [PATCH v2 4/7] fzsync: Add functionality test for library
In-Reply-To: <20170828110241.30453-1-rpalethorpe@suse.com>
References: <20170828110241.30453-1-rpalethorpe@suse.com>
Message-ID: <20170828110241.30453-4-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 lib/newlib_tests/.gitignore |   1 +
 lib/newlib_tests/Makefile   |   2 +
 lib/newlib_tests/test16.c   | 106 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 109 insertions(+)
 create mode 100644 lib/newlib_tests/test16.c

diff --git a/lib/newlib_tests/.gitignore b/lib/newlib_tests/.gitignore
index 7d47a6531..d47a6ea12 100644
--- a/lib/newlib_tests/.gitignore
+++ b/lib/newlib_tests/.gitignore
@@ -13,6 +13,7 @@ test12
 test13
 test14
 test15
+test16
 tst_device
 tst_safe_fileops
 tst_res_hexd
diff --git a/lib/newlib_tests/Makefile b/lib/newlib_tests/Makefile
index e86d8f23a..afa09373e 100644
--- a/lib/newlib_tests/Makefile
+++ b/lib/newlib_tests/Makefile
@@ -8,6 +8,8 @@ LDLIBS			+= -lltp
 test08: CFLAGS+=-pthread
 test09: CFLAGS+=-pthread
 test15: CFLAGS+=-pthread
+test16: CFLAGS+=-pthread
+test16: LDLIBS+=-lrt
 
 ifeq ($(ANDROID),1)
 FILTER_OUT_MAKE_TARGETS	+= test08
diff --git a/lib/newlib_tests/test16.c b/lib/newlib_tests/test16.c
new file mode 100644
index 000000000..f4cc74e46
--- /dev/null
+++ b/lib/newlib_tests/test16.c
@@ -0,0 +1,106 @@
+/*
+ * Copyright (c) 2017 Richard Palethorpe <rpalethorpe@suse.com>
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
+/* Basic functionality test for tst_fuzzy_sync.h similar to the atomic tests
+ * (test15.c). One thread writes to the odd indexes of an array while the
+ * other writes to the even. If the threads are not synchronised then they
+ * will probably write to the wrong indexes as they share an index variable
+ * which they should take it in turns to update.
+ */
+
+#include <stdlib.h>
+#include "tst_test.h"
+#include "tst_safe_pthread.h"
+#include "tst_fuzzy_sync.h"
+
+#define LOOPS 0xFFFFFF
+
+static pthread_t thrd;
+static volatile char seq[LOOPS * 2 + 1];
+static struct tst_fzsync_pair pair = TST_FZSYNC_PAIR_INIT;
+static volatile int seq_n;
+
+static void *worker(void *v LTP_ATTRIBUTE_UNUSED)
+{
+	int i;
+
+	for (i = 0; tst_fzsync_wait_update_b(&pair) && i < LOOPS; i++) {
+		tst_fzsync_delay_b(&pair);
+		tst_fzsync_time_b(&pair);
+		if (!tst_fzsync_wait_b(&pair))
+			break;
+		seq[seq_n] = 'B';
+		seq_n = (i + 1) * 2;
+	}
+
+	if (i > LOOPS)
+		tst_res(TWARN, "Worker performed too many iterations: %d > %d",
+			i, LOOPS);
+
+	return NULL;
+}
+
+static void setup(void)
+{
+	SAFE_PTHREAD_CREATE(&thrd, NULL, worker, NULL);
+}
+
+static void run(void)
+{
+	int i, j, fail = 0;
+
+	for (i = 0; tst_fzsync_wait_update_a(&pair) && i < LOOPS; i++) {
+		tst_fzsync_delay_a(&pair);
+		seq[seq_n] = 'A';
+		seq_n = i * 2 + 1;
+		tst_fzsync_time_a(&pair);
+		if (!tst_fzsync_wait_a(&pair))
+			break;
+	}
+
+	for (i = 0; i < LOOPS; i++) {
+		j = i * 2;
+		if (seq[j] != 'A') {
+			tst_res(TFAIL, "Expected A, but found %c at %d",
+				seq[j], j);
+			fail = 1;
+		}
+		j = i * 2 + 1;
+		if (seq[j] != 'B') {
+			tst_res(TFAIL, "Expected A, but found %c@%d",
+				seq[j], j);
+			fail = 1;
+		}
+	}
+
+	if (!fail)
+		tst_res(TPASS, "Sequence is correct");
+
+	if (labs(pair.delay) > 1000)
+		tst_res(TFAIL, "Delay is suspiciously large");
+}
+
+static void cleanup(void)
+{
+	tst_fzsync_pair_exit(&pair);
+	SAFE_PTHREAD_JOIN(thrd, NULL);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run,
+};
-- 
2.14.1

