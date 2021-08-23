From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 23 Aug 2021 17:05:20 +0200
Subject: [LTP] [PATCH 3/3] tst_test_macros: Add test_macros05 tests
In-Reply-To: <20210823150520.25614-1-chrubis@suse.cz>
References: <20210823150520.25614-1-chrubis@suse.cz>
Message-ID: <20210823150520.25614-4-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

That tests the two corner cases with default message and macro
stringification.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 lib/newlib_tests/.gitignore      |  1 +
 lib/newlib_tests/test_macros05.c | 46 ++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)
 create mode 100644 lib/newlib_tests/test_macros05.c

diff --git a/lib/newlib_tests/.gitignore b/lib/newlib_tests/.gitignore
index 807e510ee..a0bad78c1 100644
--- a/lib/newlib_tests/.gitignore
+++ b/lib/newlib_tests/.gitignore
@@ -41,6 +41,7 @@ test_macros01
 test_macros02
 test_macros03
 test_macros04
+test_macros05
 tst_fuzzy_sync01
 tst_fuzzy_sync02
 tst_fuzzy_sync03
diff --git a/lib/newlib_tests/test_macros05.c b/lib/newlib_tests/test_macros05.c
new file mode 100644
index 000000000..a164f23ac
--- /dev/null
+++ b/lib/newlib_tests/test_macros05.c
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2021 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+/*
+ * Tests various corner conditions:
+ *
+ * - default message, i.e. first argument stringification
+ * - macro indirection, i.e. we have to stringify early
+ *
+ * The output should include the MACRO_FAIL() as the either fail of pass
+ * message. If it's missing or if it has been replaced by the function name
+ * there is a bug in the TST_EXP_*() macro.
+ */
+
+#include "tst_test.h"
+
+static int fail_fn_should_not_be_seen_in_output(void)
+{
+	errno = EINVAL;
+	return -1;
+}
+
+#define MACRO_FAIL() fail_fn_should_not_be_seen_in_output()
+
+static void do_test(void)
+{
+	TST_EXP_FAIL(MACRO_FAIL(), EINVAL);
+	TST_EXP_FAIL2(MACRO_FAIL(), EINVAL);
+
+	TST_EXP_PASS(MACRO_FAIL());
+	TST_EXP_PASS_SILENT(MACRO_FAIL());
+
+	TST_EXP_PID(MACRO_FAIL());
+	TST_EXP_PID_SILENT(MACRO_FAIL());
+
+	TST_EXP_FD(MACRO_FAIL());
+	TST_EXP_FD_SILENT(MACRO_FAIL());
+
+	TST_EXP_POSITIVE(MACRO_FAIL());
+}
+
+static struct tst_test test = {
+	.test_all = do_test,
+};
-- 
2.31.1

