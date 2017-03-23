From: Jakub Racek <jracek@redhat.com>
Date: Thu, 23 Mar 2017 19:15:57 +0100
Subject: [LTP] [PATCH v5 6/6] syscalls/memfd_create02.c: added new test
In-Reply-To: <1490292957-26941-1-git-send-email-jracek@redhat.com>
References: <1490292957-26941-1-git-send-email-jracek@redhat.com>
Message-ID: <1490292957-26941-7-git-send-email-jracek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Jakub Racek <jracek@redhat.com>
---
 runtest/syscalls                                   |  1 +
 testcases/kernel/syscalls/.gitignore               |  1 +
 .../kernel/syscalls/memfd_create/memfd_create02.c  | 94 ++++++++++++++++++++++
 3 files changed, 96 insertions(+)
 create mode 100644 testcases/kernel/syscalls/memfd_create/memfd_create02.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 2da5b48..1be9710 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1452,3 +1452,4 @@ futex_wait_bitset01 futex_wait_bitset01
 futex_wait_bitset02 futex_wait_bitset02
 
 memfd_create01 memfd_create01
+memfd_create02 memfd_create02
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index 905badc..9f07273 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -1119,3 +1119,4 @@
 /perf_event_open/perf_event_open01
 /perf_event_open/perf_event_open02
 /memfd_create/memfd_create01
+/memfd_create/memfd_create02
diff --git a/testcases/kernel/syscalls/memfd_create/memfd_create02.c b/testcases/kernel/syscalls/memfd_create/memfd_create02.c
new file mode 100644
index 0000000..1c56156
--- /dev/null
+++ b/testcases/kernel/syscalls/memfd_create/memfd_create02.c
@@ -0,0 +1,94 @@
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
+#include <errno.h>
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
+	TEST(sys_memfd_create(tc->memfd_name, tc->flags));
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

