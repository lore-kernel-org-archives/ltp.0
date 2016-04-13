From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 13 Apr 2016 15:10:46 +0200
Subject: [LTP] [PATCH 4/4] tst_atomic: add test for tst_atomic_inc
In-Reply-To: <82bcc056edc64dee3a13275a2b4bdbec958f60eb.1460552890.git.jstancek@redhat.com>
References: <82bcc056edc64dee3a13275a2b4bdbec958f60eb.1460552890.git.jstancek@redhat.com>
Message-ID: <c7a40e44c496051bedb3c8af46d16d42c50c49af.1460552890.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Spawn a lot of threads and run tst_atomic_inc in a loop.
At the end we expect value to be THREADS * ITERATIONS.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 lib/newlib_tests/Makefile |  1 +
 lib/newlib_tests/test09.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+)
 create mode 100644 lib/newlib_tests/test09.c

diff --git a/lib/newlib_tests/Makefile b/lib/newlib_tests/Makefile
index 5771712fab10..0e4eeb83b6d4 100644
--- a/lib/newlib_tests/Makefile
+++ b/lib/newlib_tests/Makefile
@@ -6,5 +6,6 @@ CFLAGS			+= -W -Wall
 LDLIBS			+= -lltp
 
 test08: CFLAGS+=-pthread
+test09: CFLAGS+=-pthread
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/lib/newlib_tests/test09.c b/lib/newlib_tests/test09.c
new file mode 100644
index 000000000000..7b063b55cea4
--- /dev/null
+++ b/lib/newlib_tests/test09.c
@@ -0,0 +1,62 @@
+/*
+ * Copyright (c) 2016 Linux Test Project
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it would be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+/*
+ * Test that tst_atomic_inc works as expected.
+ */
+
+#include <pthread.h>
+#include "tst_test.h"
+
+#define THREADS 64
+#define ITERATIONS 100000
+
+static int atomic;
+
+static void *worker(void *id)
+{
+	int i;
+
+	(void) id;
+	for (i = 0; i < ITERATIONS; i++)
+		tst_atomic_inc(&atomic);
+
+	return NULL;
+}
+
+static void do_test(void)
+{
+	long i;
+	pthread_t threads[THREADS];
+
+	for (i = 0; i < THREADS; i++)
+		pthread_create(threads+i, NULL, worker, (void *)i);
+
+	for (i = 0; i < THREADS; i++) {
+		tst_res(TINFO, "Joining thread %li", i);
+		pthread_join(threads[i], NULL);
+	}
+
+	if (atomic == THREADS * ITERATIONS)
+		tst_res(TPASS, "Atomic working as expected");
+	else
+		tst_res(TFAIL, "Atomic does not have expected value");
+}
+
+static struct tst_test test = {
+	.tid = "test09",
+	.test_all = do_test,
+	.forks_child = 1
+};
-- 
1.8.3.1

