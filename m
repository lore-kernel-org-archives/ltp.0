From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Wed, 19 Jul 2017 11:08:31 +0200
Subject: [LTP] [PATCH v2 3/3] Test for CVE-2016-10044 mark AIO pseudo-fs
	noexec
In-Reply-To: <20170719090831.2326-1-rpalethorpe@suse.com>
References: <20170719090831.2326-1-rpalethorpe@suse.com>
Message-ID: <20170719090831.2326-3-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 runtest/cve                    |  1 +
 testcases/cve/.gitignore       |  1 +
 testcases/cve/cve-2016-10044.c | 77 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 79 insertions(+)
 create mode 100644 testcases/cve/cve-2016-10044.c

diff --git a/runtest/cve b/runtest/cve
index 32a39cf80..c8b90de70 100644
--- a/runtest/cve
+++ b/runtest/cve
@@ -4,6 +4,7 @@ cve-2014-0196 cve-2014-0196
 cve-2016-4997 cve-2016-4997
 cve-2016-5195 dirtyc0w
 cve-2016-7117 cve-2016-7117
+cve-2016-10044 cve-2016-10044
 cve-2017-2671 cve-2017-2671
 cve-2017-5669 cve-2017-5669
 cve-2017-6951 cve-2017-6951
diff --git a/testcases/cve/.gitignore b/testcases/cve/.gitignore
index b83372b08..9bbf7bdb2 100644
--- a/testcases/cve/.gitignore
+++ b/testcases/cve/.gitignore
@@ -2,6 +2,7 @@ cve-2012-0957
 cve-2014-0196
 cve-2016-4997
 cve-2016-7117
+cve-2016-10044
 cve-2017-2671
 cve-2017-5669
 cve-2017-6951
diff --git a/testcases/cve/cve-2016-10044.c b/testcases/cve/cve-2016-10044.c
new file mode 100644
index 000000000..85db87052
--- /dev/null
+++ b/testcases/cve/cve-2016-10044.c
@@ -0,0 +1,77 @@
+/*
+ * Copyright (c) 2017 Richard Palethorpe <rpalethorpe@suse.com>
+ * Copyright (c) 2016 Jan Horn <jann@thejh.net>
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
+ * Test for CVE-2016-10044, which was fixed in commit
+ * 22f6b4d34fcf039c aio: mark AIO pseudo-fs noexec.
+ *
+ * The test checks that we can not implicitly mark AIO mappings as
+ * executable using the READ_IMPLIES_EXEC personality.
+ */
+
+#include <stdio.h>
+#include <stdint.h>
+#include <string.h>
+#include <linux_syscall_numbers.h>
+#include <linux/aio_abi.h>
+#include "tst_test.h"
+#include "tst_personality.h"
+#include "tst_safe_stdio.h"
+
+#define CONV_STR "%*x-%*x %s7"
+
+static FILE *f;
+
+static void cleanup(void)
+{
+	if (f != NULL)
+		SAFE_FCLOSE(f);
+}
+
+static void run(void)
+{
+	uint64_t ctx = 0;
+	pid_t pid = getpid();
+	char perms[8], line[BUFSIZ];
+	char maps_path[256];
+
+	SAFE_PERSONALITY(READ_IMPLIES_EXEC);
+	if (tst_syscall(__NR_io_setup, 1, &ctx))
+		tst_brk(TBROK | TERRNO, "Failed to create AIO context");
+
+	snprintf(maps_path, sizeof(maps_path), "/proc/%d/maps", pid);
+	f = SAFE_FOPEN(maps_path, "r");
+	while (fgets(line, BUFSIZ, f) != NULL) {
+		if (strstr(line, "/[aio]") != NULL)
+			goto found_mapping;
+	}
+	tst_brk(TBROK, "Could not find mapping in %s", maps_path);
+
+found_mapping:
+	if (sscanf(line, CONV_STR, perms) < 0)
+		tst_brk(TBROK, "failed find permission string in %s", line);
+	if (strchr(perms, (int)'x'))
+		tst_res(TFAIL, "AIO mapping is executable: %s!", perms);
+	else
+		tst_res(TPASS, "AIO mapping is not executable: %s", perms);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.cleanup = cleanup,
+	.min_kver = "2.6.8",
+};
-- 
2.13.2

