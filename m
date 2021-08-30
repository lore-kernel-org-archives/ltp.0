From: zhanglianjie <zhanglianjie@uniontech.com>
Date: Mon, 30 Aug 2021 15:35:44 +0800
Subject: [LTP] [PATCH] tst_test_macros: Add test_macros06 tests
Message-ID: <20210830073544.19620-1-zhanglianjie@uniontech.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Test the TST_EXP_VAL and TST_EXP_VAL_SILENT macros.

Signed-off-by: zhanglianjie <zhanglianjie@uniontech.com>

diff --git a/lib/newlib_tests/.gitignore b/lib/newlib_tests/.gitignore
index a0bad78c1..cf467b5a0 100644
--- a/lib/newlib_tests/.gitignore
+++ b/lib/newlib_tests/.gitignore
@@ -42,6 +42,7 @@ test_macros02
 test_macros03
 test_macros04
 test_macros05
+test_macros06
 tst_fuzzy_sync01
 tst_fuzzy_sync02
 tst_fuzzy_sync03
diff --git a/lib/newlib_tests/test_macros06.c b/lib/newlib_tests/test_macros06.c
new file mode 100644
index 000000000..626f233d2
--- /dev/null
+++ b/lib/newlib_tests/test_macros06.c
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2021 zhanglianjie <zhanglianjie@uniontech.com>
+ */
+
+/*
+ * Test TST_EXP_VAL and TST_EXP_VAL_SILENT macro.
+ */
+
+#include "tst_test.h"
+
+static int fail_val(void)
+{
+	errno = EINVAL;
+	return 42;
+}
+
+static int pass_val(void)
+{
+	return 42;
+}
+
+static void do_test(void)
+{
+	tst_res(TINFO, "Testing TST_EXP_VAL macro");
+	TST_EXP_VAL(fail_val(), 40, "fail_val()");
+	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
+	TST_EXP_VAL(pass_val(), 42, "fail_val()");
+	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
+
+	tst_res(TINFO, "Testing TST_EXP_PID_SILENT macro");
+	TST_EXP_VAL_SILENT(fail_val(), 40, "fail_val()");
+	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
+	TST_EXP_VAL_SILENT(pass_val(), 42, "%s", "pass_val()");
+	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
+}
+
+static struct tst_test test = {
+	.test_all = do_test,
+};
--
2.20.1



