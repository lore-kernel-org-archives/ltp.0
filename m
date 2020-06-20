From: Nirav Parmar <niravparmar@zilogic.com>
Date: Sat, 20 Jun 2020 06:37:13 -0000
Subject: [LTP] [PATCH v1] Add test case for CVE-2018-11508
Message-ID: <20200620063713.5330-1-niravparmar@zilogic.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


This patch adds a new test case for adjtimex syscall. It checks if there
is any data leak from kernel while on calling adjtimex or not. This code
will pass the struct timex buffer filled with zero with some INVALID mode
to the system call adjtimex and therefore, it tends to fail. None of the
attributes will get initialized and before that, it must throw an error.
on reading the last attribute tai of the struct, if the attribute is non-
zero the test is considered to have failed, else the test is considered
to have passed.

Resolves #321
Signed-off-by: Nirav Parmar <niravparmar@zilogic.com>
Reviewed-by: Vijay Kumar B. <vijaykumar@zilogic.com>

---
 runtest/syscalls                              |   1 +
 testcases/kernel/syscalls/adjtimex/.gitignore |   1 +
 .../kernel/syscalls/adjtimex/adjtimex03.c     | 112 ++++++++++++++++++
 3 files changed, 114 insertions(+)
 create mode 100644 testcases/kernel/syscalls/adjtimex/adjtimex03.c

diff --git a/runtest/syscalls b/runtest/syscalls
index ee7e2a0d2..21a81cb4c 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -22,6 +22,7 @@ add_key05 add_key05
 
 adjtimex01 adjtimex01
 adjtimex02 adjtimex02
+adjtimex03 adjtimex03
 
 alarm02 alarm02
 alarm03 alarm03
diff --git a/testcases/kernel/syscalls/adjtimex/.gitignore b/testcases/kernel/syscalls/adjtimex/.gitignore
index d0c6dea83..bb3508855 100644
--- a/testcases/kernel/syscalls/adjtimex/.gitignore
+++ b/testcases/kernel/syscalls/adjtimex/.gitignore
@@ -1,2 +1,3 @@
 /adjtimex01
 /adjtimex02
+/adjtimex03
diff --git a/testcases/kernel/syscalls/adjtimex/adjtimex03.c b/testcases/kernel/syscalls/adjtimex/adjtimex03.c
new file mode 100644
index 000000000..d6c8d67e5
--- /dev/null
+++ b/testcases/kernel/syscalls/adjtimex/adjtimex03.c
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) Zilogic Systems Pvt. Ltd, 2020. All Rights Reserved.
+ * Email: <code@zilogic.com>
+ *
+ * Based on testcases/kernel/syscalls/adjtimex/adjtimex01.c
+ * Copyright (c) Wipro Technologies Ltd, 2002.
+ *
+ * CVE-2018-11508
+ *
+ * Test 4-byte kernel data leak via adjtimex
+ *
+ * On calling the adjtimex() function call with invalid mode (let's say
+ * 0x8000), ideally all the parameters should return with null data. But,
+ * when we read the last parameter we will receive 4 bytes of kernel data.
+ * This proves that there are 4 bytes of info leaked. The bug was fixed in
+ * Kernel Version 4.16.9. Therefore, the below test case will only be
+ * applicable for the kernel version 4.16.9 and above.
+ *
+ * So basically, this test shall check whether there is any data leak.
+ * To test that, Pass struct timex buffer filled with zero with
+ * some INVALID mode to the system call adjtimex. Passing an invalid
+ * parameters will not call do_adjtimex() and before that, it shall throw
+ * an error(On error test shall not break). Therefore, none of the parameters
+ * will get initialized.
+ *
+ * On reading the last attribute tai of the struct, if the attribute is non-
+ * zero the test is considered to have failed, else the test is considered
+ * to have passed.
+ */
+
+#include <errno.h>
+#include <sys/timex.h>
+#include "tst_test.h"
+
+#define SET_MODE (ADJ_OFFSET | ADJ_FREQUENCY | ADJ_MAXERROR | ADJ_ESTERROR | \
+		ADJ_STATUS | ADJ_TIMECONST | ADJ_TICK)
+
+#define ADJ_ADJTIME 0x8000
+#define LOOPS 10
+
+static struct timex *tim_save;
+static struct timex *buf;
+
+void verify_adjtimex(void)
+{
+	int i;
+	int data_leak = 0;
+
+	for (i = 0; i < LOOPS; i++) {
+		memset(buf, 0, sizeof(struct timex));
+		buf->modes = ADJ_ADJTIME; /* Invalid mode */
+		TEST(adjtimex(buf));
+		if ((TST_RET == -1) && (TST_ERR == EINVAL)) {
+			tst_res(TINFO,
+				"expecting adjtimex() to fail with EINVAL"
+				"with mode 0x%x", ADJ_ADJTIME);
+		} else {
+			tst_brk(TBROK | TERRNO,
+					"adjtimex(): Unexpeceted error,"
+					"expecting EINVAL with mode 0x%x",
+					ADJ_ADJTIME);
+		}
+
+		tst_res(TINFO, "tai : 0x%08x", buf->tai);
+
+		if (buf->tai != 0) {
+			data_leak = 1;
+			break;
+		}
+	}
+	if (data_leak != 0)
+		tst_res(TFAIL, "Data leak observed");
+	else
+		tst_res(TPASS, "Data leak not observed");
+}
+
+static void setup(void)
+{
+	tim_save->modes = 0;
+	/* Save current parameters */
+	if ((adjtimex(tim_save)) == -1) {
+		tst_brk(TBROK | TERRNO,
+				"adjtimex(): failed to save current params");
+	}
+}
+
+static void cleanup(void)
+{
+	tim_save->modes = SET_MODE;
+
+	/* Restore saved parameters */
+	if ((adjtimex(tim_save)) == -1)
+		tst_res(TWARN, "Failed to restore saved parameters");
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.min_kver = "4.16.9",
+	.test_all = verify_adjtimex,
+	.bufs = (struct tst_buffers []) {
+		{&buf, .size = sizeof(*buf)},
+		{&tim_save, .size = sizeof(*tim_save)},
+		{},
+	},
+	.tags = (const struct tst_tag[]) {
+		{"CVE", "2018-11508"},
+		{"linux-git", "3a4d44b61625"},
+		{},
+	}
+};
-- 
2.20.1

