From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 14 Apr 2016 10:59:24 +0200
Subject: [LTP] [PATCH v2 4/4] tst_atomic: add test for tst_atomic_inc
In-Reply-To: <7260589f891c8c60ada465b5086215c4eba8d346.1460622188.git.jstancek@redhat.com>
References: <7260589f891c8c60ada465b5086215c4eba8d346.1460622188.git.jstancek@redhat.com>
Message-ID: <ef05a76cdd26cf838e25a397a8fc8d4e02c74f4c.1460622188.git.jstancek@redhat.com>
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
 lib/newlib_tests/test09.c | 61 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+)
 create mode 100644 lib/newlib_tests/test09.c

Changes in v2:
- removed .forks_child

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
index 000000000000..0674754f3770
--- /dev/null
+++ b/lib/newlib_tests/test09.c
@@ -0,0 +1,61 @@
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
+};
-- 
1.8.3.1

