From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Fri, 24 Jan 2020 15:23:29 +0530
Subject: [LTP] [PATCH V2 2/2] syscalls/io_pgetevents
In-Reply-To: <d3a4f3d5740a64a51752bba89f2b8e2c5326b78c.1579859350.git.viresh.kumar@linaro.org>
References: <d3a4f3d5740a64a51752bba89f2b8e2c5326b78c.1579859350.git.viresh.kumar@linaro.org>
Message-ID: <2d23f3a542bbd04179aba828e28d37f5c7be7b45.1579859350.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add tests to check working of io_pgetevents() syscall.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V1->V2:
- Do the failure testing with help of array and .tcnt.
- Use tst_syscall().
- Removed cleanup() routines.
- Improved print messages and few more minor changes.

 configure.ac                                  |   1 +
 include/lapi/io_pgetevents.h                  |  49 ++++++++
 runtest/syscalls                              |   4 +
 .../kernel/syscalls/io_pgetevents/.gitignore  |   2 +
 .../kernel/syscalls/io_pgetevents/Makefile    |   6 +
 .../syscalls/io_pgetevents/io_pgetevents01.c  |  69 +++++++++++
 .../syscalls/io_pgetevents/io_pgetevents02.c  | 111 ++++++++++++++++++
 7 files changed, 242 insertions(+)
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
index 000000000000..c498db83e7d0
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
index f083758bc637..33ec1e59e51d 100644
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
index 000000000000..9b34f973c424
--- /dev/null
+++ b/testcases/kernel/syscalls/io_pgetevents/io_pgetevents01.c
@@ -0,0 +1,69 @@
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
+		tst_res(TPASS, "io_pgetevents() worked as expected");
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
index 000000000000..35722c4b21d6
--- /dev/null
+++ b/testcases/kernel/syscalls/io_pgetevents/io_pgetevents02.c
@@ -0,0 +1,111 @@
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
+static struct tcase {
+	char *name;
+	int invalid_ctx;
+	long min_nr;
+	long max_nr;
+	int invalid_events;
+	int invalid_timeout;
+	int invalid_sigmask;
+	int exp_errno;
+} tcases[] = {
+	{"test-invalid-ctx", 1, 1, 1, 0, 0, 0, EINVAL},
+	{"test-invalid-min_nr", 0, -1, 1, 0, 0, 0, EINVAL},
+	{"test-invalid-max_nr", 0, 1, -1, 0, 0, 0, EINVAL},
+	{"test-invalid-events", 0, 1, 1, 1, 0, 0, EFAULT},
+	{"test-invalid-timeout", 0, 1, 1, 0, 1, 0, EFAULT},
+	{"test-invalid-sigmask", 0, 1, 1, 0, 0, 1, EFAULT},
+};
+
+static void run(unsigned int n)
+{
+	struct io_event events[1], *events_ptr = NULL;
+	sigset_t sigmask, *psigmask = (void *)(0xDEAD);
+	struct timespec *timeout = (void *)(0xDEAD);
+	struct tcase *tc = &tcases[n];
+	struct iocb cb, *cbs[1];
+	io_context_t ctx = 0;
+	char data[4096];
+	int ret, fd;
+
+	cbs[0] = &cb;
+
+	if (!tc->invalid_timeout)
+		timeout = NULL;
+
+	if (!tc->invalid_sigmask) {
+		psigmask = &sigmask;
+		sigemptyset(psigmask);
+	}
+
+	if (!tc->invalid_events)
+		events_ptr = events;
+
+	fd = SAFE_OPEN("io_pgetevents_file", O_RDWR | O_CREAT);
+	io_prep_pwrite(&cb, fd, data, 4096, 0);
+
+	if (!tc->invalid_ctx) {
+		ret = io_setup(1, &ctx);
+		if (ret < 0) {
+			tst_res(TBROK | TERRNO, "io_setup() failed");
+			goto exit;
+		}
+
+		ret = io_submit(ctx, 1, cbs);
+		if (ret != 1) {
+			tst_res(TBROK | TERRNO, "io_submit() failed");
+			goto exit;
+		}
+	}
+
+	/* Invalid Max event count */
+	TEST(io_pgetevents(ctx, tc->min_nr, tc->max_nr, events_ptr, timeout,
+			   psigmask));
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
+
+	if (!tc->invalid_ctx) {
+		if (io_destroy(ctx) < 0)
+			tst_res(TBROK | TERRNO, "io_destroy() failed");
+	}
+
+exit:
+	SAFE_CLOSE(fd);
+}
+
+static struct tst_test test = {
+	.min_kver = "4.18",
+	.needs_tmpdir = 1,
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = run,
+};
+
+#else
+TST_TEST_TCONF("test requires libaio and it's development packages");
+#endif
-- 
2.21.0.rc0.269.g1a574e7a288b

