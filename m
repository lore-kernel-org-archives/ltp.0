From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Mon, 27 Jan 2020 16:20:18 +0530
Subject: [LTP] [PATCH V3 2/2] syscalls/io_pgetevents
In-Reply-To: <2d23f3a542bbd04179aba828e28d37f5c7be7b45.1579859350.git.viresh.kumar@linaro.org>
References: <2d23f3a542bbd04179aba828e28d37f5c7be7b45.1579859350.git.viresh.kumar@linaro.org>
Message-ID: <5c8bc1c031ec992f402e009a5ed85f9351ecd7ac.1580122000.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add tests to check working of io_pgetevents() syscall.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V2->V3:
- Dropped duplicate headers
- Handle failure tests with global variable
- All changes were inspired from the reviews of pidfd_open() patchset.

V1->V2:
- Do the failure testing with help of array and .tcnt.
- Use tst_syscall().
- Removed cleanup() routines.
- Improved print messages and few more minor changes.

 configure.ac                                  |   1 +
 include/lapi/io_pgetevents.h                  |  51 +++++++++
 runtest/syscalls                              |   4 +
 .../kernel/syscalls/io_pgetevents/.gitignore  |   2 +
 .../kernel/syscalls/io_pgetevents/Makefile    |   6 +
 .../syscalls/io_pgetevents/io_pgetevents01.c  |  61 +++++++++++
 .../syscalls/io_pgetevents/io_pgetevents02.c  | 103 ++++++++++++++++++
 7 files changed, 228 insertions(+)
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
index 000000000000..6ee38c44d419
--- /dev/null
+++ b/include/lapi/io_pgetevents.h
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 Linaro Limited. All rights reserved.
+ * Author: Viresh Kumar <viresh.kumar@linaro.org>
+ */
+
+#ifndef IO_PGETEVENTS_H
+#define IO_PGETEVENTS_H
+
+#include <sys/syscall.h>
+#include <sys/types.h>
+
+#include "config.h"
+#include "lapi/syscalls.h"
+#include "tst_test.h"
+
+#ifdef HAVE_LIBAIO
+#include <libaio.h>
+
+#ifndef HAVE_IO_SETUP
+int io_setup(int nr, io_context_t *ctxp)
+{
+	return tst_syscall(__NR_io_setup, nr, ctxp);
+}
+#endif /* HAVE_IO_SETUP */
+
+#ifndef HAVE_IO_DESTROY
+int io_destroy(io_context_t ctx)
+{
+	return tst_syscall(__NR_io_destroy, ctx);
+}
+#endif /* HAVE_IO_DESTROY */
+
+#ifndef HAVE_IO_SUBMIT
+int io_submit(io_context_t ctx, long nr, struct iocb **iocbpp)
+{
+	return tst_syscall(__NR_io_submit, ctx, nr, iocbpp);
+}
+#endif /* HAVE_IO_SUBMIT */
+
+#ifndef HAVE_IO_PGETEVENTS
+int io_pgetevents(io_context_t ctx, long min_nr, long max_nr,
+		 struct io_event *events, struct timespec *timeout,
+		 sigset_t *sigmask)
+{
+	return syscall(__NR_io_pgetevents, ctx, min_nr, max_nr, events, timeout, sigmask);
+}
+#endif /* HAVE_IO_PGETEVENTS */
+#endif /* HAVE_LIBAIO */
+
+#endif /* IO_PGETEVENTS_H */
diff --git a/runtest/syscalls b/runtest/syscalls
index a28a1f2ecd45..0743cf4e3f74 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -556,6 +556,10 @@ ioprio_set03 ioprio_set03
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
index 000000000000..d685adb48759
--- /dev/null
+++ b/testcases/kernel/syscalls/io_pgetevents/io_pgetevents01.c
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 Viresh Kumar <viresh.kumar@linaro.org>
+ *
+ * Description:
+ * Basic io_pgetevents() test to receive 1 event successfully.
+ */
+#include "lapi/io_pgetevents.h"
+
+#ifdef HAVE_LIBAIO
+static void run(void)
+{
+	struct io_event events[1];
+	struct iocb cb, *cbs[1];
+	io_context_t ctx = 0;
+	sigset_t sigmask;
+	char data[4096];
+	int ret, fd;
+
+	cbs[0] = &cb;
+	sigemptyset(&sigmask);
+
+	fd = SAFE_OPEN("io_pgetevents_file", O_RDWR | O_CREAT);
+	io_prep_pwrite(&cb, fd, data, 4096, 0);
+
+	ret = io_setup(1, &ctx);
+	if (ret < 0) {
+		tst_res(TBROK | TERRNO, "io_setup() failed");
+		goto exit;
+	}
+
+	ret = io_submit(ctx, 1, cbs);
+	if (ret != 1) {
+		tst_res(TBROK | TERRNO, "io_submit() failed");
+		goto exit;
+	}
+
+	/* get the reply */
+	ret = io_pgetevents(ctx, 1, 1, events, NULL, &sigmask);
+
+	if (ret == 1)
+		tst_res(TPASS, "io_pgetevents() works as expected");
+	else
+		tst_res(TFAIL | TERRNO, "io_pgetevents() failed");
+
+	if (io_destroy(ctx) < 0)
+		tst_res(TBROK | TERRNO, "io_destroy() failed");
+
+exit:
+	SAFE_CLOSE(fd);
+}
+
+static struct tst_test test = {
+	.min_kver = "4.18",
+	.test_all = run,
+	.needs_tmpdir = 1,
+};
+
+#else
+TST_TEST_TCONF("test requires libaio and it's development packages");
+#endif
diff --git a/testcases/kernel/syscalls/io_pgetevents/io_pgetevents02.c b/testcases/kernel/syscalls/io_pgetevents/io_pgetevents02.c
new file mode 100644
index 000000000000..c612c3f0a2b2
--- /dev/null
+++ b/testcases/kernel/syscalls/io_pgetevents/io_pgetevents02.c
@@ -0,0 +1,103 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 Viresh Kumar <viresh.kumar@linaro.org>
+ *
+ * Description:
+ * Basic io_pgetevents() test to check various failures.
+ */
+#include "lapi/io_pgetevents.h"
+
+#ifdef HAVE_LIBAIO
+static sigset_t sigmask;
+static struct io_event events[1];
+static io_context_t ctx, invalid_ctx = 0;
+static int fd;
+
+static struct tcase {
+	char *name;
+	io_context_t *ctx;
+	long min_nr;
+	long max_nr;
+	struct io_event *events;
+	struct timespec *timeout;
+	sigset_t *sigmask;
+	int exp_errno;
+} tcases[] = {
+	{"invalid ctx", &invalid_ctx, 1, 1, events, NULL, &sigmask, EINVAL},
+	{"invalid min_nr", &ctx, -1, 1, events, NULL, &sigmask, EINVAL},
+	{"invalid max_nr", &ctx, 1, -1, events, NULL, &sigmask, EINVAL},
+	{"invalid events", &ctx, 1, 1, NULL, NULL, &sigmask, EFAULT},
+	{"invalid timeout", &ctx, 1, 1, events, (void *)(0xDEAD), &sigmask, EFAULT},
+	{"invalid sigmask", &ctx, 1, 1, events, NULL, (void *)(0xDEAD), EFAULT},
+};
+
+static void setup(void)
+{
+	struct iocb cb, *cbs[1];
+	char data[4096];
+	int ret;
+
+	cbs[0] = &cb;
+
+	sigemptyset(&sigmask);
+
+	fd = SAFE_OPEN("io_pgetevents_file", O_RDWR | O_CREAT);
+	io_prep_pwrite(&cb, fd, data, 4096, 0);
+
+	ret = io_setup(1, &ctx);
+	if (ret < 0) {
+		tst_res(TBROK | TERRNO, "io_setup() failed");
+		goto exit;
+	}
+
+	ret = io_submit(ctx, 1, cbs);
+	if (ret != 1) {
+		tst_res(TBROK | TERRNO, "io_submit() failed");
+		goto exit;
+	}
+
+	return;
+
+exit:
+	SAFE_CLOSE(fd);
+}
+
+static void cleanup(void)
+{
+	if (io_destroy(ctx) < 0)
+		tst_res(TBROK | TERRNO, "io_destroy() failed");
+
+	SAFE_CLOSE(fd);
+}
+
+static void run(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+
+	TEST(io_pgetevents(*tc->ctx, tc->min_nr, tc->max_nr, tc->events,
+			   tc->timeout, tc->sigmask));
+
+	if (TST_RET == 1) {
+		tst_res(TFAIL, "%s: io_pgetevents() passed unexpectedly",
+			tc->name);
+	} else if (tc->exp_errno != TST_ERR) {
+		tst_res(TFAIL | TTERRNO, "%s: io_pgetevents() should fail with %s",
+			tc->name, tst_strerrno(tc->exp_errno));
+	} else {
+		tst_res(TPASS | TTERRNO, "%s: io_pgetevents() failed as expected",
+			tc->name);
+	}
+}
+
+static struct tst_test test = {
+	.min_kver = "4.18",
+	.needs_tmpdir = 1,
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = run,
+	.setup = setup,
+	.cleanup = cleanup,
+};
+
+#else
+TST_TEST_TCONF("test requires libaio and it's development packages");
+#endif
-- 
2.21.0.rc0.269.g1a574e7a288b

