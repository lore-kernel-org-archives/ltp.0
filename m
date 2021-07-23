From: Yang Xu <xuyang2018.jy@fujitsu.com>
Date: Fri, 23 Jul 2021 13:19:43 +0800
Subject: [LTP] [PATCH 1/2] lib/tst_hugepage: Fix .request_hugepages = 0 bug
Message-ID: <1627017584-30405-1-git-send-email-xuyang2018.jy@fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Since ltp library doesn't call tst_request_hugepages
when using zero value, we don't set this value successfully.

Fix this by introducing TST_NO_HUGEPAGES flag. If you want to
keep zero hugepage for some ENOMEM case(like shmget02), please
use this flag instead of using 0 directly.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 doc/c-test-api.txt                     |  3 ++-
 include/tst_test.h                     |  5 +++-
 lib/newlib_tests/.gitignore            |  1 +
 lib/newlib_tests/test_zero_hugepage.c  | 35 ++++++++++++++++++++++++++
 lib/newlib_tests/test_zero_hugepage.sh | 13 ++++++++++
 lib/tst_hugepage.c                     |  6 +++++
 6 files changed, 61 insertions(+), 2 deletions(-)
 create mode 100644 lib/newlib_tests/test_zero_hugepage.c
 create mode 100755 lib/newlib_tests/test_zero_hugepage.sh

diff --git a/doc/c-test-api.txt b/doc/c-test-api.txt
index 45784195b..6ec0a47eb 100644
--- a/doc/c-test-api.txt
+++ b/doc/c-test-api.txt
@@ -1908,7 +1908,8 @@ expected number of hugepage for testing in setup phase. If system does not
 have enough hpage for using, it will try the best to reserve 80% available
 number of hpages. With success test stores the reserved hugepage number in
 'tst_hugepages'. For the system without hugetlb supporting, variable
-'tst_hugepages' will be set to 0.
+'tst_hugepages' will be set to 0. If need zero hugepage on supported hugetlb
+system, please use '.request_hugepages = TST_NO_HUGEPAGES'.
 
 Also, we do cleanup and restore work for the hpages resetting automatically.
 
diff --git a/include/tst_test.h b/include/tst_test.h
index c7d77eb09..40c725995 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -125,6 +125,8 @@ struct tst_tag {
 
 extern unsigned int tst_variant;
 
+#define TST_NO_HUGEPAGES ((unsigned long)-1)
+
 struct tst_test {
 	/* number of tests available in test() function */
 	unsigned int tcnt;
@@ -175,7 +177,8 @@ struct tst_test {
 	 * have enough hpage for using, it will try the best to reserve 80% available
 	 * number of hpages. With success test stores the reserved hugepage number in
 	 * 'tst_hugepages. For the system without hugetlb supporting, variable
-	 * 'tst_hugepages' will be set to 0.
+	 * 'tst_hugepages' will be set to 0. If need zero hugepage on supported hugetlb
+	 * system, please use '.request_hugepages = TST_NO_HUGEPAGES'.
 	 *
 	 * Also, we do cleanup and restore work for the hpages resetting automatically.
 	 */
diff --git a/lib/newlib_tests/.gitignore b/lib/newlib_tests/.gitignore
index b51f6a679..807e510ee 100644
--- a/lib/newlib_tests/.gitignore
+++ b/lib/newlib_tests/.gitignore
@@ -44,3 +44,4 @@ test_macros04
 tst_fuzzy_sync01
 tst_fuzzy_sync02
 tst_fuzzy_sync03
+test_zero_hugepage
diff --git a/lib/newlib_tests/test_zero_hugepage.c b/lib/newlib_tests/test_zero_hugepage.c
new file mode 100644
index 000000000..0d85ce866
--- /dev/null
+++ b/lib/newlib_tests/test_zero_hugepage.c
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2021 Yang Xu <xuyang2018.jy@fujitsu.com>
+ */
+
+/*
+ * Tests .request_hugepages = TST_NO_HUGEPAGES
+ */
+
+#include "tst_test.h"
+#include "tst_hugepage.h"
+#include "tst_sys_conf.h"
+
+static void do_test(void)
+{
+	unsigned long val, hpages;
+
+	SAFE_FILE_SCANF(PATH_NR_HPAGES, "%lu", &val);
+	if (val != 0)
+		tst_brk(TBROK, "nr_hugepages = %lu, but expect 0", val);
+	else
+		tst_res(TPASS, "test .request_hugepages = TST_NO_HUGEPAGES");
+
+	hpages = tst_request_hugepages(3);
+	SAFE_FILE_SCANF(PATH_NR_HPAGES, "%lu", &val);
+	if (val != hpages)
+		tst_brk(TBROK, "nr_hugepages = %lu, but expect %lu", val, hpages);
+	else
+		tst_res(TPASS, "tst_request_hugepages");
+}
+
+static struct tst_test test = {
+	.test_all = do_test,
+	.request_hugepages = TST_NO_HUGEPAGES,
+};
diff --git a/lib/newlib_tests/test_zero_hugepage.sh b/lib/newlib_tests/test_zero_hugepage.sh
new file mode 100755
index 000000000..10113006b
--- /dev/null
+++ b/lib/newlib_tests/test_zero_hugepage.sh
@@ -0,0 +1,13 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2021 Yang Xu <xuyang2018.jy@fujitsu.com>
+
+echo "Testing .request_hugepages = TST_NO_HUGEPAGES"
+
+orig_value=`cat /proc/sys/vm/nr_hugepages`
+
+echo "128" > /proc/sys/vm/nr_hugepages
+
+./test_zero_hugepage
+
+echo $orig_value > /proc/sys/vm/nr_hugepages
diff --git a/lib/tst_hugepage.c b/lib/tst_hugepage.c
index 1d0e62e5b..a7585bc3d 100644
--- a/lib/tst_hugepage.c
+++ b/lib/tst_hugepage.c
@@ -34,6 +34,11 @@ unsigned long tst_request_hugepages(unsigned long hpages)
 	else
 		tst_hugepages = hpages;
 
+	if (hpages == TST_NO_HUGEPAGES) {
+		tst_hugepages = 0;
+		goto set_hugepages;
+	}
+
 	SAFE_FILE_PRINTF("/proc/sys/vm/drop_caches", "3");
 	max_hpages = SAFE_READ_MEMINFO("MemFree:") / SAFE_READ_MEMINFO("Hugepagesize:");
 
@@ -47,6 +52,7 @@ unsigned long tst_request_hugepages(unsigned long hpages)
 			goto out;
 	}
 
+set_hugepages:
 	tst_sys_conf_save("?/proc/sys/vm/nr_hugepages");
 	SAFE_FILE_PRINTF(PATH_NR_HPAGES, "%lu", tst_hugepages);
 	SAFE_FILE_SCANF(PATH_NR_HPAGES, "%lu", &val);
-- 
2.23.0

