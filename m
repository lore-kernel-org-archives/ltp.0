From: xiao yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 4 Jan 2018 17:26:57 +0800
Subject: [LTP] [PATCH v3 1/2] lib/mem.c: factor out wait_ksmd_full_scan()
In-Reply-To: <20180103143836.GA7370@rei>
References: <20180103143836.GA7370@rei>
Message-ID: <1515058018-19913-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Move common wait_ksmd_full_scan() to kernel/lib/ksm_helper.c
and create accompanying kernel/include/ksm_helper.h.

Signed-off-by: xiao yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/include/ksm_helper.h | 26 +++++++++++++++++++
 testcases/kernel/lib/ksm_helper.c     | 49 +++++++++++++++++++++++++++++++++++
 testcases/kernel/mem/lib/mem.c        | 28 +-------------------
 3 files changed, 76 insertions(+), 27 deletions(-)
 create mode 100644 testcases/kernel/include/ksm_helper.h
 create mode 100644 testcases/kernel/lib/ksm_helper.c

diff --git a/testcases/kernel/include/ksm_helper.h b/testcases/kernel/include/ksm_helper.h
new file mode 100644
index 0000000..0b35218
--- /dev/null
+++ b/testcases/kernel/include/ksm_helper.h
@@ -0,0 +1,26 @@
+/*
+ * Copyright (c) 2018 FUJITSU LIMITED. All rights reserved.
+ * Author(s): Xiao Yang <yangx.jy@cn.fujitsu.com>
+ *
+ * This program is free software;  you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ * the GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program, if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef KSM_HELPER_H
+#define KSM_HELPER_H
+
+#define PATH_KSM	"/sys/kernel/mm/ksm/"
+
+void wait_ksmd_full_scan(void);
+
+#endif /* KSM_HELPER_H */
diff --git a/testcases/kernel/lib/ksm_helper.c b/testcases/kernel/lib/ksm_helper.c
new file mode 100644
index 0000000..eba28d4
--- /dev/null
+++ b/testcases/kernel/lib/ksm_helper.c
@@ -0,0 +1,49 @@
+/*
+ * Copyright (c) 2018 FUJITSU LIMITED. All rights reserved.
+ * Author(s): Xiao Yang <yangx.jy@cn.fujitsu.com>
+ *
+ * This program is free software;  you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ * the GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program, if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#define TST_NO_DEFAULT_MAIN
+
+#include <unistd.h>
+#include "tst_test.h"
+#include "ksm_helper.h"
+
+void wait_ksmd_full_scan(void)
+{
+	unsigned long full_scans, at_least_one_full_scan;
+	int count = 0;
+
+	SAFE_FILE_SCANF(PATH_KSM "full_scans", "%lu", &full_scans);
+	/*
+	 * The current scan is already in progress so we can't guarantee that
+	 * the get_user_pages() is called on every existing rmap_item if we
+	 * only waited for the remaining part of the scan.
+	 *
+	 * The actual merging happens after the unstable tree has been built so
+	 * we need to wait at least two full scans to guarantee merging, hence
+	 * wait full_scans to increment by 3 so that at least two full scans
+	 * will run.
+	 */
+	at_least_one_full_scan = full_scans + 3;
+	while (full_scans < at_least_one_full_scan) {
+		sleep(1);
+		count++;
+		SAFE_FILE_SCANF(PATH_KSM "full_scans", "%lu", &full_scans);
+	}
+
+	tst_res(TINFO, "ksm daemon takes %ds to run two full scans", count);
+}
diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
index 7f2099b..4275f63 100644
--- a/testcases/kernel/mem/lib/mem.c
+++ b/testcases/kernel/mem/lib/mem.c
@@ -23,6 +23,7 @@
 #include <unistd.h>
 
 #include "mem.h"
+#include "ksm_helper.h"
 #include "numa_helper.h"
 
 /* OOM */
@@ -268,33 +269,6 @@ static void check(char *path, long int value)
 		tst_res(TPASS, "%s is %ld.", path, actual_val);
 }
 
-static void wait_ksmd_full_scan(void)
-{
-	unsigned long full_scans, at_least_one_full_scan;
-	int count = 0;
-
-	SAFE_FILE_SCANF(PATH_KSM "full_scans", "%lu", &full_scans);
-	/*
-	 * The current scan is already in progress so we can't guarantee that
-	 * the get_user_pages() is called on every existing rmap_item if we
-	 * only waited for the remaining part of the scan.
-	 *
-	 * The actual merging happens after the unstable tree has been built so
-	 * we need to wait at least two full scans to guarantee merging, hence
-	 * wait full_scans to increment by 3 so that at least two full scans
-	 * will run.
-	 */
-	at_least_one_full_scan = full_scans + 3;
-	while (full_scans < at_least_one_full_scan) {
-		sleep(1);
-		count++;
-		SAFE_FILE_SCANF(PATH_KSM "full_scans", "%lu", &full_scans);
-	}
-
-	tst_res(TINFO, "ksm daemon takes %ds to run two full scans",
-		count);
-}
-
 static void final_group_check(int run, int pages_shared, int pages_sharing,
 			  int pages_volatile, int pages_unshared,
 			  int sleep_millisecs, int pages_to_scan)
-- 
1.8.3.1



