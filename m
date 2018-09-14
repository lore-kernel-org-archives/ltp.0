From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Fri, 14 Sep 2018 18:02:08 +0300
Subject: [LTP] [PATCH v3 1/2] lib/tst_test.c: add 'needs_drivers' option
	with tst_check_drivers cmd
Message-ID: <1536937329-13902-1-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The drivers are checked with modprobe. If modprobe is not available
on the system, the checks are silently skipped.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
v3: * Changed the docs according to the Cyril's comment
    * Added curly braces in tst_check_drivers.c
    * Added dry-run option to modprobe

v2: * moved tst_check_driver() from tst_test.h to tst_kernel.h
    * added the new option description to the doc and comment to tst_kernel.h
    * iterating over the driver list moved out from tst_check_drivers(), the
      function renamed accordingly.

 doc/test-writing-guidelines.txt   |   11 +++++++++++
 include/tst_kernel.h              |    8 ++++++++
 include/tst_test.h                |    3 +++
 lib/tst_kernel.c                  |    9 +++++++++
 lib/tst_test.c                    |    9 +++++++++
 testcases/lib/.gitignore          |    1 +
 testcases/lib/Makefile            |    2 +-
 testcases/lib/tst_check_drivers.c |   25 +++++++++++++++++++++++++
 8 files changed, 67 insertions(+), 1 deletions(-)
 create mode 100644 testcases/lib/tst_check_drivers.c

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index aae2b38..78c524f 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -1457,6 +1457,17 @@ https://www.kernel.org/doc/html/latest/admin-guide/tainted-kernels.html
 CRC32c checksum generation is supported by LTP. In order to use it, the
 test should include "tst_checksum.h" header, then can call tst_crc32c().
 
+2.2.26 Checking kernel for the driver support
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+Some tests may need specific kernel drivers, either compiled in, or built
+as a module. If .need_drivers points to a NULL-terminated array of kernel
+module names these are all checked and the test exits with TCONF on the
+first missing driver.
+
+Since it relies on modprobe command, the check will be skipped if the command
+itself is not available on the system.
+
 2.3 Writing a testcase in shell
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/include/tst_kernel.h b/include/tst_kernel.h
index 5d5c04c..88941e1 100644
--- a/include/tst_kernel.h
+++ b/include/tst_kernel.h
@@ -23,4 +23,12 @@
  */
 int tst_kernel_bits(void);
 
+/**
+ * Checks support for the kernel driver.
+ *
+ * @param name The name of the driver.
+ * @return Returns 0 if the kernel has the driver or modprobe is missing.
+ */
+int tst_check_driver(const char *name);
+
 #endif	/* TST_KERNEL_H__ */
diff --git a/include/tst_test.h b/include/tst_test.h
index ea23c8b..080b017 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -172,6 +172,9 @@ struct tst_test {
 
 	/* NULL terminated array of resource file names */
 	const char *const *resource_files;
+
+	/* NULL terminated array of needed kernel drivers */
+	const char * const *needs_drivers;
 };
 
 /*
diff --git a/lib/tst_kernel.c b/lib/tst_kernel.c
index 42d64cb..4206e3c 100644
--- a/lib/tst_kernel.c
+++ b/lib/tst_kernel.c
@@ -45,3 +45,12 @@ int tst_kernel_bits(void)
 
 	return kernel_bits;
 }
+
+int tst_check_driver(const char *name)
+{
+	const char * const argv[] = { "modprobe", "-n", name, NULL };
+	int res = tst_run_cmd_(NULL, argv, "/dev/null", "/dev/null", 1);
+
+	/* 255 - it looks like modprobe not available */
+	return (res == 255) ? 0 : res;
+}
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 1280400..117e614 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -784,6 +784,15 @@ static void do_setup(int argc, char *argv[])
 	if (tst_test->min_kver)
 		check_kver();
 
+	if (tst_test->needs_drivers) {
+		const char *name;
+		int i;
+
+		for (i = 0; (name = tst_test->needs_drivers[i]); ++i)
+			if (tst_check_driver(name))
+				tst_brk(TCONF, "%s driver not available", name);
+	}
+
 	if (tst_test->format_device)
 		tst_test->needs_device = 1;
 
diff --git a/testcases/lib/.gitignore b/testcases/lib/.gitignore
index a9034e4..d83a48e 100644
--- a/testcases/lib/.gitignore
+++ b/testcases/lib/.gitignore
@@ -1,5 +1,6 @@
 /tst_sleep
 /tst_random
+/tst_check_drivers
 /tst_checkpoint
 /tst_rod
 /tst_kvcmp
diff --git a/testcases/lib/Makefile b/testcases/lib/Makefile
index 3547e16..e1dea3b 100644
--- a/testcases/lib/Makefile
+++ b/testcases/lib/Makefile
@@ -28,6 +28,6 @@ INSTALL_TARGETS		:= *.sh
 
 MAKE_TARGETS		:= tst_sleep tst_random tst_checkpoint tst_rod tst_kvcmp\
 			   tst_device tst_net_iface_prefix tst_net_ip_prefix tst_net_vars\
-			   tst_getconf tst_supported_fs
+			   tst_getconf tst_supported_fs tst_check_drivers
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/lib/tst_check_drivers.c b/testcases/lib/tst_check_drivers.c
new file mode 100644
index 0000000..e21bdab
--- /dev/null
+++ b/testcases/lib/tst_check_drivers.c
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Copyright (c) 2018 Oracle and/or its affiliates. All Rights Reserved. */
+
+#include <stdio.h>
+#include "tst_kernel.h"
+
+int main(int argc, const char *argv[])
+{
+	const char *name;
+	int i;
+
+	if (argc < 2) {
+		fprintf(stderr, "Please provide kernel driver list\n");
+		return 1;
+	}
+
+	for (i = 1; (name = argv[i]); ++i) {
+		if (tst_check_driver(name)) {
+			fprintf(stderr, "%s", name);
+			return 1;
+		}
+	}
+
+	return 0;
+}
-- 
1.7.1

