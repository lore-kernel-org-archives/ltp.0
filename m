From: Jakub Racek <jracek@redhat.com>
Date: Mon,  6 Mar 2017 18:45:40 +0100
Subject: [LTP] [PATCH v2 6/6] syscalls/memfd_create02.c: added new test
In-Reply-To: <1488822340-29259-1-git-send-email-jracek@redhat.com>
References: <1488822340-29259-1-git-send-email-jracek@redhat.com>
Message-ID: <1488822340-29259-7-git-send-email-jracek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Jakub Racek <jracek@redhat.com>
---
 runtest/syscalls                                   |  1 +
 testcases/kernel/syscalls/.gitignore               |  1 +
 .../kernel/syscalls/memfd_create/memfd_create02.c  | 92 ++++++++++++++++++++++
 3 files changed, 94 insertions(+)
 create mode 100644 testcases/kernel/syscalls/memfd_create/memfd_create02.c

diff --git a/runtest/syscalls b/runtest/syscalls
index fd305ce..3d59686 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1450,3 +1450,4 @@ futex_wait_bitset01 futex_wait_bitset01
 futex_wait_bitset02 futex_wait_bitset02
 
 memfd_create01 memfd_create01
+memfd_create02 memfd_create02
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index 915b1b9..75227f9 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -1117,3 +1117,4 @@
 /perf_event_open/perf_event_open01
 /perf_event_open/perf_event_open02
 /memfd_create/memfd_create01
+/memfd_create/memfd_create02
diff --git a/testcases/kernel/syscalls/memfd_create/memfd_create02.c b/testcases/kernel/syscalls/memfd_create/memfd_create02.c
new file mode 100644
index 0000000..b7c2815
--- /dev/null
+++ b/testcases/kernel/syscalls/memfd_create/memfd_create02.c
@@ -0,0 +1,92 @@
+/*
+ * Copyright (C) 2017  Red Hat, Inc.
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
+ /*
+  *  Based on Linux/tools/testing/selftests/memfd/memfd_test.c
+  *  by David Herrmann <dh.herrmann@gmail.com>
+  *
+  *  24/02/2017   Port to LTP    <jracek@redhat.com>
+  */
+
+#define _GNU_SOURCE
+
+#include <tst_test.h>
+
+#include "memfd_create_common.h"
+
+static char buf[2048];
+static char term_buf[2048];
+
+static const struct tcase {
+	char *descr;
+	char *memfd_name;
+	int flags;
+	int memfd_create_exp_err;
+} tcases[] = {
+	/*
+	 * Test memfd_create() syscall
+	 * Verify syscall-argument validation, including name checks,
+	 * flag validation and more.
+	 */
+	{"invalid name fail 1",   NULL,     0,                      EFAULT },
+	{"invalid name fail 2",   buf,      0,                      EINVAL },
+	{"invalid name fail 3",   term_buf, 0,                      EINVAL },
+
+	{"invalid flags fail 1", "test",  -500,                     EINVAL },
+	{"invalid flags fail 2", "test",  0x0100,                   EINVAL },
+	{"invalid flags fail 3", "test",  ~MFD_CLOEXEC,             EINVAL },
+	{"invalid flags fail 4", "test",  ~MFD_ALLOW_SEALING,       EINVAL },
+	{"invalid flags fail 5", "test",  ~0,                       EINVAL },
+	{"invalid flags fail 6", "test",  0x80000000U,              EINVAL },
+
+	{"valid flags 1 pass", "test",  MFD_CLOEXEC,                     0 },
+	{"valid flags 2 pass", "test",  MFD_ALLOW_SEALING,               0 },
+	{"valid flags 3 pass", "test",  MFD_CLOEXEC | MFD_ALLOW_SEALING, 0 },
+	{"valid flags 4 pass", "test",  0,                               0 },
+	{"valid flags 5 pass", "",      0,                               0 },
+};
+
+static void setup(void)
+{
+	ASSERT_HAVE_MEMFD_CREATE();
+
+	memset(buf, 0xff, sizeof(buf));
+
+	memset(term_buf, 0xff, sizeof(term_buf));
+	term_buf[sizeof(term_buf) - 1] = 0;
+}
+
+static void verify_memfd_create_errno(unsigned int n)
+{
+	const struct tcase *tc;
+
+	tc = &tcases[n];
+
+	TEST(mfd_fail_new(tc->memfd_name, tc->flags));
+	if (TEST_ERRNO != tc->memfd_create_exp_err)
+		tst_brk(TFAIL, "test '%s'", tc->descr);
+	else
+		tst_res(TPASS, "test '%s'", tc->descr);
+
+	if (TEST_RETURN > 0)
+		SAFE_CLOSE(TEST_RETURN);
+}
+
+static struct tst_test test = {
+	.tid = "memfd_create02",
+	.test = verify_memfd_create_errno,
+	.tcnt = ARRAY_SIZE(tcases),
+	.setup = setup,
+};
-- 
1.8.3.1

