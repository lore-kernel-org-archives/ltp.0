From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Thu, 23 Jan 2020 10:31:24 +0530
Subject: [LTP] [PATCH 2/2] syscalls/io_pgetevents
In-Reply-To: <f9e9bc067d1153199440512d6ece01f7a001b660.1579755655.git.viresh.kumar@linaro.org>
References: <f9e9bc067d1153199440512d6ece01f7a001b660.1579755655.git.viresh.kumar@linaro.org>
Message-ID: <6aae63a2e362a0f09cf35fff058e7741f0987208.1579755655.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add tests to check working of io_pgetevents() syscall.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 configure.ac                                  |  1 +
 include/lapi/io_pgetevents.h                  | 49 +++++++++++
 runtest/syscalls                              |  4 +
 .../kernel/syscalls/io_pgetevents/.gitignore  |  2 +
 .../kernel/syscalls/io_pgetevents/Makefile    |  6 ++
 .../syscalls/io_pgetevents/io_pgetevents01.c  | 73 +++++++++++++++++
 .../syscalls/io_pgetevents/io_pgetevents02.c  | 81 +++++++++++++++++++
 7 files changed, 216 insertions(+)
 create mode 100644 include/lapi/io_pgetevents.h
 create mode 100644 testcases/kernel/syscalls/io_pgetevents/.gitignore
 create mode 100644 testcases/kernel/syscalls/io_pgetevents/Makefile
 create mode 100644 testcases/kernel/syscalls/io_pgetevents/io_pgetevents01.c
 create mode 100644 testcases/kernel/syscalls/io_pgetevents/io_pgetevents02.c

diff --git a/configure.ac b/configure.ac
index 1bf0911d88ad..c7cdff1c422c 100644
--- a/configure.ac
+++ b/configure.ac
@@ -75,6 +75,7 @@ AC_CHECK_FUNCS([ \
     getdents \
     getdents64 \
     kcmp \
+    io_pgetevents \
     mkdirat \
     mknodat \
     name_to_handle_at \
diff --git a/include/lapi/io_pgetevents.h b/include/lapi/io_pgetevents.h
new file mode 100644
index 000000000000..0499dc03b3f2
--- /dev/null
+++ b/include/lapi/io_pgetevents.h
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 Linaro Limited. All rights reserved.
+ * Author: Viresh Kumar <viresh.kumar@linaro.org>
+ */
+
+#ifndef IO_PGETEVENTS_H
+#define IO_PGETEVENTS_H
+
+#include <sys/types.h>
+
+#include "config.h"
+#include "lapi/syscalls.h"
+
+#ifdef HAVE_LIBAIO
+#include <libaio.h>
+
+#ifndef HAVE_IO_SETUP
+int io_setup(int nr, io_context_t *ctxp)
+{
+	return syscall(__NR_io_setup, nr, ctxp);
+}
+#endif /* HAVE_IO_SETUP */
+
+#ifndef HAVE_IO_DESTROY
+int io_destroy(io_context_t ctx)
+{
+	return syscall(__NR_io_destroy, ctx);
+}
+#endif /* HAVE_IO_DESTROY */
+
+#ifndef HAVE_IO_SUBMIT
+int io_submit(io_context_t ctx, long nr, struct iocb **iocbpp)
+{
+	return syscall(__NR_io_submit, ctx, nr, iocbpp);
+}
+#endif /* HAVE_IO_SUBMIT */
+
+#ifndef HAVE_IO_PGETEVENTS
+int io_pgetevents(io_context_t ctx, long min_nr, long max_nr,
+		 struct io_event *events, struct timespec *timeout,
+		 sigset_t *sigmask)
+{
+	return tst_syscall(__NR_io_pgetevents, ctx, min_nr, max_nr, events, timeout, sigmask);
+}
+#endif /* HAVE_IO_PGETEVENTS */
+#endif /* HAVE_LIBAIO */
+
+#endif /* IO_PGETEVENTS_H */
diff --git a/runtest/syscalls b/runtest/syscalls
index a2d749d526a8..6d167b800ac7 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -554,6 +554,10 @@ ioprio_set03 ioprio_set03
 io_cancel01 io_cancel01
 io_destroy01 io_destroy01
 io_getevents01 io_getevents01
+
+io_pgetevents01 io_pgetevents01
+io_pgetevents02 io_pgetevents02
+
 io_setup01 io_setup01
 io_submit01 io_submit01
 
diff --git a/testcases/kernel/syscalls/io_pgetevents/.gitignore b/testcases/kernel/syscalls/io_pgetevents/.gitignore
new file mode 100644
index 000000000000..ae02077ba44b
--- /dev/null
+++ b/testcases/kernel/syscalls/io_pgetevents/.gitignore
@@ -0,0 +1,2 @@
+io_pgetevents01
+io_pgetevents02
diff --git a/testcases/kernel/syscalls/io_pgetevents/Makefile b/testcases/kernel/syscalls/io_pgetevents/Makefile
new file mode 100644
index 000000000000..5ea7d67db123
--- /dev/null
+++ b/testcases/kernel/syscalls/io_pgetevents/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/io_pgetevents/io_pgetevents01.c b/testcases/kernel/syscalls/io_pgetevents/io_pgetevents01.c
new file mode 100644
index 000000000000..f8a12193dd2c
--- /dev/null
+++ b/testcases/kernel/syscalls/io_pgetevents/io_pgetevents01.c
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 Viresh Kumar <viresh.kumar@linaro.org>
+ *
+ * Description:
+ * Basic io_pgetevents() test to receive 1 event successfully.
+ */
+#include <sys/types.h>
+#include <sys/syscall.h>
+#include <fcntl.h>
+#include <string.h>
+#include <inttypes.h>
+
+#include "tst_test.h"
+#include "lapi/io_pgetevents.h"
+#include "lapi/syscalls.h"
+
+#ifdef HAVE_LIBAIO
+
+static int fd = -1;
+
+static void cleanup(void)
+{
+	SAFE_CLOSE(fd);
+}
+
+static void run(void)
+{
+	struct io_event events[1];
+	struct iocb cb, *cbs[1];
+	io_context_t ctx = 0;
+	sigset_t sigmask;
+	char data[4096];
+	int ret;
+
+	sigemptyset(&sigmask);
+
+	fd = SAFE_OPEN("io_pgetevents_file", O_RDWR | O_CREAT);
+
+	ret = io_setup(1, &ctx);
+	if (ret < 0)
+		tst_brk(TBROK | TERRNO, "io_setup() failed");
+
+	io_prep_pwrite(&cb, fd, data, 4096, 0);
+
+	cbs[0] = &cb;
+
+	ret = io_submit(ctx, 1, cbs);
+	if (ret != 1)
+		tst_brk(TBROK | TERRNO, "io_submit() failed");
+
+	/* get the reply */
+	ret = io_pgetevents(ctx, 1, 1, events, NULL, &sigmask);
+
+	if (io_destroy(ctx) < 0)
+		tst_brk(TBROK | TERRNO, "io_destroy() failed");
+
+	if (ret == 1)
+		tst_res(TPASS, "io_pgetevents() working as expected");
+	else
+		tst_brk(TBROK| TERRNO, "io_pgetevents() failed");
+}
+
+static struct tst_test test = {
+	.min_kver = "4.18",
+	.test_all = run,
+	.needs_tmpdir = 1,
+	.cleanup = cleanup,
+};
+
+#else
+TST_TEST_TCONF("test requires libaio and it's development packages");
+#endif
diff --git a/testcases/kernel/syscalls/io_pgetevents/io_pgetevents02.c b/testcases/kernel/syscalls/io_pgetevents/io_pgetevents02.c
new file mode 100644
index 000000000000..de101e6cd0e9
--- /dev/null
+++ b/testcases/kernel/syscalls/io_pgetevents/io_pgetevents02.c
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 Viresh Kumar <viresh.kumar@linaro.org>
+ *
+ * Description:
+ * Basic io_pgetevents() test to check various failures.
+ */
+#include <sys/types.h>
+#include <sys/syscall.h>
+#include <fcntl.h>
+#include <string.h>
+#include <inttypes.h>
+
+#include "tst_test.h"
+#include "lapi/io_pgetevents.h"
+#include "lapi/syscalls.h"
+
+#ifdef HAVE_LIBAIO
+
+static int fd = -1;
+
+static void cleanup(void)
+{
+	SAFE_CLOSE(fd);
+}
+
+static void run(void)
+{
+	struct io_event events[1];
+	struct iocb cb, *cbs[1];
+	io_context_t ctx = 0;
+	sigset_t sigmask;
+	char data[4096];
+	int ret;
+
+	sigemptyset(&sigmask);
+
+	fd = SAFE_OPEN("io_pgetevents_file", O_RDWR | O_CREAT);
+
+	ret = io_setup(1, &ctx);
+	if (ret < 0)
+		tst_brk(TBROK | TERRNO, "io_setup() failed");
+
+	io_prep_pwrite(&cb, fd, data, 4096, 0);
+
+	cbs[0] = &cb;
+
+	ret = io_submit(ctx, 1, cbs);
+	if (ret != 1)
+		tst_brk(TBROK | TERRNO, "io_submit() failed");
+
+	/* Invalid Max event count */
+	ret = io_pgetevents(ctx, 1, 0, events, NULL, &sigmask);
+
+	/* Invalid events*/
+	if (ret != 1)
+		ret = io_pgetevents(ctx, 1, 1, NULL, NULL, &sigmask);
+
+	if (io_destroy(ctx) < 0)
+		tst_brk(TBROK | TERRNO, "io_destroy() failed");
+
+	/* Invalid ctx */
+	if (ret != 1)
+		ret = io_pgetevents(ctx, 1, 1, events, NULL, &sigmask);
+
+	if (ret != 1)
+		tst_res(TPASS, "io_pgetevents() failed as expected");
+	else
+		tst_brk(TBROK| TERRNO, "io_pgetevents() passed unexpectedly");
+}
+
+static struct tst_test test = {
+	.min_kver = "4.18",
+	.test_all = run,
+	.needs_tmpdir = 1,
+	.cleanup = cleanup,
+};
+
+#else
+TST_TEST_TCONF("test requires libaio and it's development packages");
+#endif
-- 
2.21.0.rc0.269.g1a574e7a288b

