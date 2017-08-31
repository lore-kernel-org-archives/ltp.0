From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Thu, 31 Aug 2017 15:44:04 +0800
Subject: [LTP] [PATCH] Test for CVE-2017-2618 in setprocattr
Message-ID: <20170831074404.26337-1-fenggw-fnst@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
---
 runtest/cve                   |  1 +
 testcases/cve/.gitignore      |  1 +
 testcases/cve/cve-2017-2618.c | 59 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 61 insertions(+)
 create mode 100644 testcases/cve/cve-2017-2618.c

diff --git a/runtest/cve b/runtest/cve
index 5b16e9e..e789b66 100644
--- a/runtest/cve
+++ b/runtest/cve
@@ -11,6 +11,7 @@ cve-2016-4997 cve-2016-4997
 cve-2016-5195 dirtyc0w
 cve-2016-7042 cve-2016-7042
 cve-2016-7117 cve-2016-7117
+cve-2017-2618 cve-2017-2618
 cve-2017-2671 cve-2017-2671
 cve-2017-5669 cve-2017-5669
 cve-2017-6951 cve-2017-6951
diff --git a/testcases/cve/.gitignore b/testcases/cve/.gitignore
index ea9036d..24036bc 100644
--- a/testcases/cve/.gitignore
+++ b/testcases/cve/.gitignore
@@ -3,6 +3,7 @@ cve-2014-0196
 cve-2016-4997
 cve-2016-7042
 cve-2016-7117
+cve-2017-2618
 cve-2017-2671
 cve-2017-6951
 cve-2017-5669
diff --git a/testcases/cve/cve-2017-2618.c b/testcases/cve/cve-2017-2618.c
new file mode 100644
index 0000000..e6b30e8
--- /dev/null
+++ b/testcases/cve/cve-2017-2618.c
@@ -0,0 +1,59 @@
+/*
+ * Copyright (c) 2017 Fujitsu Ltd.
+ * Author: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program, if not, see <http://www.gnu.org/licenses/>.
+ */
+
+/*
+ * Test for CVE-2017-2618, this regression test can crash
+ * the buggy kernel, and the bug was fixed in:
+ *
+ *  commit 0c461cb727d146c9ef2d3e86214f498b78b7d125
+ *  Author: Stephen Smalley <sds@tycho.nsa.gov>
+ *  Date:   Tue Jan 31 11:54:04 2017 -0500
+ *
+ *  selinux: fix off-by-one in setprocattr
+ */
+
+#include <errno.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include "tst_test.h"
+
+#define LOOPS	100
+#define PATH_ATTRFS	"/proc/self/attr/fscreate"
+
+static void do_test(void)
+{
+	int i, fd;
+
+	for (i = 0; i < LOOPS; i++) {
+		if (!SAFE_FORK()) {
+			fd = SAFE_OPEN(PATH_ATTRFS, O_WRONLY);
+			write(fd, "\n", 1);
+			SAFE_CLOSE(fd);
+			exit(0);
+		}
+
+		tst_reap_children();
+	}
+
+	tst_res(TPASS, "Bug not reproduced");
+}
+
+static struct tst_test test = {
+	.forks_child = 1,
+	.test_all = do_test,
+};
-- 
2.9.4



