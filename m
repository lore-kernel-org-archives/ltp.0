From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu,  9 Aug 2018 18:23:43 +0300
Subject: [LTP] [PATCH RFC 1/4] lib/tst_test.c: add 'needs_drivers' option
	with tst_check_drivers cmd
Message-ID: <1533828226-24753-1-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The drivers are checked with modprobe. If modrpobe is not available
on the system, the checks are silently skipped.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 include/tst_test.h                |    5 +++++
 lib/tst_test.c                    |   26 ++++++++++++++++++++++++++
 testcases/lib/.gitignore          |    1 +
 testcases/lib/Makefile            |    2 +-
 testcases/lib/tst_check_drivers.c |   24 ++++++++++++++++++++++++
 5 files changed, 57 insertions(+), 1 deletions(-)
 create mode 100644 testcases/lib/tst_check_drivers.c

diff --git a/include/tst_test.h b/include/tst_test.h
index 98dacf3..221796d 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -170,6 +170,9 @@ struct tst_test {
 
 	/* NULL terminated array of resource file names */
 	const char *const *resource_files;
+
+	/* NULL terminated array of needed kernel drivers */
+	const char * const *needs_drivers;
 };
 
 /*
@@ -219,6 +222,8 @@ const char *tst_strstatus(int status);
 
 void tst_set_timeout(int timeout);
 
+int tst_check_drivers(void);
+
 #ifndef TST_NO_DEFAULT_MAIN
 
 static struct tst_test test;
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 2f3d357..6cb74cf 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -645,6 +645,29 @@ static int needs_tmpdir(void)
 	       tst_test->needs_checkpoints;
 }
 
+int tst_check_drivers(void)
+{
+	const char *name;
+	int i, res;
+
+	for (i = 0; (name = tst_test->needs_drivers[i]); ++i) {
+		const char * const argv[] = { "modprobe", name, NULL };
+
+		res = tst_run_cmd_(NULL, argv, "/dev/null", "/dev/null", 1);
+		if (res == 255)
+			return res; /* it looks like modprobe not available */
+		if (res) {
+			if (tst_test->test || tst_test->test_all) {
+				tst_brk(TCONF, "%s driver not available", name);
+			} else {
+				fprintf(stderr, "%s", name);
+				return res;
+			}
+		}
+	}
+	return 0;
+}
+
 static void copy_resources(void)
 {
 	unsigned int i;
@@ -767,6 +790,9 @@ static void do_setup(int argc, char *argv[])
 	if (tst_test->min_kver)
 		check_kver();
 
+	if (tst_test->needs_drivers)
+		tst_check_drivers();
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
index 0000000..3f722f2
--- /dev/null
+++ b/testcases/lib/tst_check_drivers.c
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later
+ * Copyright (c) 2018 Oracle and/or its affiliates. All Rights Reserved.
+ */
+
+#include <stdio.h>
+#define TST_NO_DEFAULT_MAIN
+#include "tst_test.h"
+
+struct tst_test *tst_test;
+
+int main(int argc, const char *argv[])
+{
+	if (argc < 2) {
+		fprintf(stderr, "Please provide kernel driver list\n");
+		return 1;
+	}
+
+	struct tst_test test = {
+		.needs_drivers = &argv[1]
+	};
+
+	tst_test = &test;
+	return tst_check_drivers();
+}
-- 
1.7.1

