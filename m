From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed,  8 Feb 2017 12:02:52 +0100
Subject: [LTP] [PATCH 3/6] lib: Add new tst_device for shell
In-Reply-To: <20170208110255.443-1-chrubis@suse.cz>
References: <20170208110255.443-1-chrubis@suse.cz>
Message-ID: <20170208110255.443-3-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The motivation is to have a single place where we handle device
creation/deletion.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/lib/.gitignore   |   1 +
 testcases/lib/Makefile     |   3 +-
 testcases/lib/tst_device.c | 106 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 109 insertions(+), 1 deletion(-)
 create mode 100644 testcases/lib/tst_device.c

diff --git a/testcases/lib/.gitignore b/testcases/lib/.gitignore
index 77acb57..920817c 100644
--- a/testcases/lib/.gitignore
+++ b/testcases/lib/.gitignore
@@ -3,3 +3,4 @@ tst_random
 tst_checkpoint
 tst_rod
 tst_kvcmp
+tst_device
diff --git a/testcases/lib/Makefile b/testcases/lib/Makefile
index 0bb0bce..6282578 100644
--- a/testcases/lib/Makefile
+++ b/testcases/lib/Makefile
@@ -26,6 +26,7 @@ include $(top_srcdir)/include/mk/testcases.mk
 
 INSTALL_TARGETS		:= *.sh
 
-MAKE_TARGETS		:= tst_sleep tst_random tst_checkpoint tst_rod tst_kvcmp
+MAKE_TARGETS		:= tst_sleep tst_random tst_checkpoint tst_rod tst_kvcmp\
+			   tst_device
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/lib/tst_device.c b/testcases/lib/tst_device.c
new file mode 100644
index 0000000..d33cac6
--- /dev/null
+++ b/testcases/lib/tst_device.c
@@ -0,0 +1,106 @@
+/*
+ * Copyright (c) 2017 Cyril Hrubis <chrubis@suse.cz>
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
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write the Free Software Foundation,
+ * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#include <errno.h>
+#include <limits.h>
+#include <stdio.h>
+#include <stdlib.h>
+#define TST_NO_DEFAULT_MAIN
+#include "tst_test.h"
+#include "old/old_device.h"
+
+extern struct tst_test *tst_test;
+
+static struct tst_test test = {
+	.tid = "tst_device"
+};
+
+static void print_help(void)
+{
+	printf("\nUsage: tst_device acquire [size]\n");
+	printf("   or: tst_device release /path/to/device\n\n");
+}
+
+static int acquire_device(int argc, char *argv[])
+{
+	unsigned int size = 0;
+	const char *device;
+
+	if (argc > 3)
+		return 1;
+
+	if (argc == 3) {
+		size = atoi(argv[2]);
+
+		if (!size) {
+			fprintf(stderr, "ERROR: Invalid device size '%s'",
+				argv[2]);
+			return 1;
+		}
+	}
+
+	device = tst_acquire_device__(size);
+
+	if (!device)
+		return 1;
+
+	printf("%s", device);
+
+	return 0;
+}
+
+static int release_device(int argc, char *argv[])
+{
+	if (argc != 3)
+		return 1;
+
+	return tst_release_device(argv[2]);
+}
+
+int main(int argc, char *argv[])
+{
+	/*
+	 * Force messages to be printed from the new library i.e. tst_test.c
+	 *
+	 * The new library prints messages into stderr while the old one prints
+	 * them into stdout. When messages are printed into stderr we can
+	 * safely do:
+	 *
+	 * DEV=$(tst_device acquire)
+	 */
+	tst_test = &test;
+
+	if (argc < 2)
+		goto help;
+
+	if (!strcmp(argv[1], "acquire")) {
+		if (acquire_device(argc, argv))
+			goto help;
+	} else if (!strcmp(argv[1], "release")) {
+		if (release_device(argc, argv))
+			goto help;
+	} else {
+		fprintf(stderr, "ERROR: Invalid COMMAND '%s'\n", argv[1]);
+		goto help;
+	}
+
+	return 0;
+help:
+	print_help();
+	return 1;
+}
-- 
2.10.2

