From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Fri, 17 Feb 2017 11:37:25 +0100
Subject: [LTP] [PATCH 1/1] security: Test for uname26 exploit cve-2012-0957
Message-ID: <20170217113725.221f1fba@linux-v3j5>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Attempt to exploit the uname kernel memory leak which occurred when the
UNAME26 personality was set.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 testcases/kernel/security/uname/.gitignore      |  1 +
 testcases/kernel/security/uname/Makefile        | 20 ++++++
 testcases/kernel/security/uname/cve-2012-0957.c | 86 +++++++++++++++++++++++++
 3 files changed, 107 insertions(+)
 create mode 100644 testcases/kernel/security/uname/.gitignore
 create mode 100644 testcases/kernel/security/uname/Makefile
 create mode 100644 testcases/kernel/security/uname/cve-2012-0957.c

diff --git a/testcases/kernel/security/uname/.gitignore b/testcases/kernel/security/uname/.gitignore
new file mode 100644
index 000000000..e61b3fd25
--- /dev/null
+++ b/testcases/kernel/security/uname/.gitignore
@@ -0,0 +1 @@
+cve-2012-0957
diff --git a/testcases/kernel/security/uname/Makefile b/testcases/kernel/security/uname/Makefile
new file mode 100644
index 000000000..c4b6ce36b
--- /dev/null
+++ b/testcases/kernel/security/uname/Makefile
@@ -0,0 +1,20 @@
+# Copyright (c) 2017 Linux Test Project
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation; either version 2 of
+# the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it would be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write the Free Software Foundation,
+# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/security/uname/cve-2012-0957.c b/testcases/kernel/security/uname/cve-2012-0957.c
new file mode 100644
index 000000000..e5fb9c96d
--- /dev/null
+++ b/testcases/kernel/security/uname/cve-2012-0957.c
@@ -0,0 +1,86 @@
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
+ * Check that memory after the string terminator in all the utsname fields has
+ * been zeroed. cve-2012-0957 leaked kernel memory through the release field
+ * when the UNAME26 personality was set.
+ */
+
+#include <string.h>
+#include <sys/utsname.h>
+#include <sys/personality.h>
+#include "tst_test.h"
+
+#define UNAME26 0x0020000
+
+static int check_field(char *bytes, size_t length, char *field)
+{
+	size_t i = strlen(bytes) + 1;
+
+	for (; i < length; i++) {
+		if (bytes[i]) {
+			tst_res(TFAIL, "Bytes leaked in %s!", field);
+			return 1;
+		}
+	}
+	return 0;
+}
+
+
+static void try_leak_bytes(void)
+{
+	struct utsname buf;
+
+	if (uname(&buf))
+		tst_brk(TBROK | TERRNO, "Call to uname failed");
+
+#define CHECK_FIELD(field_name) \
+	(check_field(buf.field_name, ARRAY_SIZE(buf.field_name), #field_name))
+
+	if (!(CHECK_FIELD(release) |
+	    CHECK_FIELD(sysname) |
+	    CHECK_FIELD(nodename) |
+	    CHECK_FIELD(version) |
+	    CHECK_FIELD(machine) |
+#ifdef _GNU_SOURCE
+	    CHECK_FIELD(domainname) |
+#endif
+		    0)) {
+		tst_res(TPASS, "All fields zeroed after string terminator");
+	}
+#undef CHECK_FIELD
+}
+
+static void run(unsigned int test_nr)
+{
+	if (!test_nr) {
+		tst_res(TINFO, "Calling uname with default personality");
+		try_leak_bytes();
+	} else {
+		if (personality(PER_LINUX | UNAME26) < 0)
+			tst_brk(TCONF | TERRNO,
+				"Could not change personality to UNAME26");
+		tst_res(TINFO, "Calling uname with UNAME26 personality");
+		try_leak_bytes();
+	}
+}
+
+static struct tst_test test = {
+	.tid = "cve-2012-0957",
+	.test = run,
+	.tcnt = 2,
+};
-- 
2.11.0
