From: =?unknown-8bit?q?Myl=C3=A8ne?= Josserand <mylene.josserand@bootlin.com>
Date: Fri, 13 Jul 2018 11:09:32 +0200
Subject: [LTP] [PATCH v3 1/2] testcase: lib: Create tst_getconf to replace
	"getconf"
In-Reply-To: <20180713090933.11409-1-mylene.josserand@bootlin.com>
References: <20180713090933.11409-1-mylene.josserand@bootlin.com>
Message-ID: <20180713090933.11409-2-mylene.josserand@bootlin.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

In some system, "getconf" application may not be installed.
Some tests are using it to retrieve some variables such as the
page size (PAGESIZE).

Create a tst_getconf binary that use sysconf() function to retrieve
these variables instead of relying on "getconf" application that
may not be available.
Add also this new helper in the documentation.

Example:
pagesize=`tst_getconf PAGESIZE`

Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>
Reviewed-by: Li Wang <liwang@redhat.com>
---
 doc/test-writing-guidelines.txt | 14 +++++++++++
 testcases/lib/.gitignore        |  1 +
 testcases/lib/Makefile          |  3 ++-
 testcases/lib/tst_getconf.c     | 51 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 68 insertions(+), 1 deletion(-)
 create mode 100644 testcases/lib/tst_getconf.c

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index 953cf6267..2de6ba99d 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -1695,6 +1695,20 @@ passed directly to the script in '$1', '$2', ..., '$n'.
 2.3.4 Usefull library functions
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
+Retrieving configuration variables
+++++++++++++++++++++++++++++++++++
+
+You may need to retrieve configuration values such as PAGESIZE, there is
+'getconf' but as some system may not have it, you are advised to use
+'tst_getconf' instead. Note that it implements subset of 'getconf'
+system variables used by the testcases only.
+
+[source,sh]
+-------------------------------------------------------------------------------
+# retrieve PAGESIZE
+pagesize=`tst_getconf PAGESIZE`
+-------------------------------------------------------------------------------
+
 Sleeping for subsecond intervals
 ++++++++++++++++++++++++++++++++
 
diff --git a/testcases/lib/.gitignore b/testcases/lib/.gitignore
index f36ed99fa..997940006 100644
--- a/testcases/lib/.gitignore
+++ b/testcases/lib/.gitignore
@@ -7,3 +7,4 @@
 /tst_net_iface_prefix
 /tst_net_ip_prefix
 /tst_net_vars
+/tst_getconf
\ No newline at end of file
diff --git a/testcases/lib/Makefile b/testcases/lib/Makefile
index 398150ae0..77b7b2ef1 100644
--- a/testcases/lib/Makefile
+++ b/testcases/lib/Makefile
@@ -27,6 +27,7 @@ include $(top_srcdir)/include/mk/testcases.mk
 INSTALL_TARGETS		:= *.sh
 
 MAKE_TARGETS		:= tst_sleep tst_random tst_checkpoint tst_rod tst_kvcmp\
-			   tst_device tst_net_iface_prefix tst_net_ip_prefix tst_net_vars
+			   tst_device tst_net_iface_prefix tst_net_ip_prefix tst_net_vars\
+			   tst_getconf
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/lib/tst_getconf.c b/testcases/lib/tst_getconf.c
new file mode 100644
index 000000000..0cb8eb23a
--- /dev/null
+++ b/testcases/lib/tst_getconf.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2018 Mylène Josserand <mylene.josserand@bootlin.com>
+ *
+ */
+
+#include <stdio.h>
+#include <unistd.h>
+#include <string.h>
+
+static void print_help(void)
+{
+	printf("Usage: tst_getconf variable\n\n");
+	printf("       variable: can be PAGESIZE/PAGE_SIZE");
+	printf(" or _NPROCESSORS_ONLN (for the moment)\n\n");
+	printf("example: tst_getconf PAGESIZE\n");
+}
+
+int main(int argc, char *argv[])
+{
+	int opt;
+
+	while ((opt = getopt(argc, argv, ":h")) != -1) {
+		switch (opt) {
+		case 'h':
+			print_help();
+			return 0;
+		default:
+			print_help();
+			return 1;
+		}
+	}
+
+	if (argc != 2) {
+		print_help();
+		return 1;
+	}
+
+	if (!strcmp(argv[optind], "_NPROCESSORS_ONLN")) {
+		printf("%ld\n", sysconf(_SC_NPROCESSORS_ONLN));
+	} else if (!strcmp(argv[optind], "PAGESIZE") ||
+		   !strcmp(argv[optind], "PAGE_SIZE")) {
+		printf("%ld\n", sysconf(_SC_PAGE_SIZE));
+	} else {
+		printf("tst_getconf: Unrecognized variable \'%s\'\n",
+		       argv[optind]);
+		return -1;
+	}
+
+	return 0;
+}
-- 
2.11.0

