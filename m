From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Fri, 19 May 2017 14:31:54 +0200
Subject: [LTP] [PATCH 08/10] Test for CVE-2017-6951 in request_key
In-Reply-To: <20170519123156.8462-1-rpalethorpe@suse.com>
References: <20170519123156.8462-1-rpalethorpe@suse.com>
Message-ID: <20170519123156.8462-8-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 runtest/syscalls              |  1 +
 testcases/cve/.gitignore      |  1 +
 testcases/cve/cve-2017-6951.c | 47 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 49 insertions(+)
 create mode 100644 testcases/cve/cve-2017-6951.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 0f3c45ada..271d1e684 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -919,6 +919,7 @@ renameat202 renameat202 -i 10
 
 request_key01 request_key01
 request_key02 request_key02
+cve-2017-6951 cve-2017-6951
 
 rmdir01 rmdir01
 rmdir02 rmdir02
diff --git a/testcases/cve/.gitignore b/testcases/cve/.gitignore
index 715cbab38..979d18369 100644
--- a/testcases/cve/.gitignore
+++ b/testcases/cve/.gitignore
@@ -3,3 +3,4 @@ cve-2014-0196
 cve-2016-4997
 cve-2016-7117
 cve-2017-5669
+cve-2017-6951
diff --git a/testcases/cve/cve-2017-6951.c b/testcases/cve/cve-2017-6951.c
new file mode 100644
index 000000000..0879345b9
--- /dev/null
+++ b/testcases/cve/cve-2017-6951.c
@@ -0,0 +1,47 @@
+/*
+ * Copyright (c) 2017 Richard Palethorpe <rpalethorpe@suse.com>
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
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ */
+/*
+ * Test for CVE-2016-6951, original reproducer can be found here:
+ * http://www.spinics.net/lists/keyrings/msg01845.html
+ *
+ * request_key() is not in glibc, so we just use the syscall directly instead
+ * of linking to keyutils.
+ */
+
+#include <unistd.h>
+#include <sys/syscall.h>
+
+#include "tst_test.h"
+#include "linux_syscall_numbers.h"
+
+#define ATTEMPTS 0x100
+
+static void run(void)
+{
+	int i;
+
+	tst_res(TINFO, "Requesting dead key");
+	for (i = 0; i < ATTEMPTS; i++)
+		tst_syscall(__NR_request_key, "dead", "abc", "abc", 0, 0, 0);
+
+	tst_res(TPASS, "No crash after %d attempts", ATTEMPTS);
+}
+
+static struct tst_test test = {
+	.tid = "cve-2017-6951",
+	.test_all = run,
+};
-- 
2.12.2

