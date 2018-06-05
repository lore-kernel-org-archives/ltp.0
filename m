From: =?unknown-8bit?q?Myl=C3=A8ne?= Josserand <mylene.josserand@bootlin.com>
Date: Tue,  5 Jun 2018 16:06:23 +0200
Subject: [LTP] [PATCH 1/2] testcase: lib: Create tst_getconf to replace
	"getconf"
In-Reply-To: <20180605140624.7114-1-mylene.josserand@bootlin.com>
References: <20180605140624.7114-1-mylene.josserand@bootlin.com>
Message-ID: <20180605140624.7114-2-mylene.josserand@bootlin.com>
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
---
 doc/test-writing-guidelines.txt | 14 ++++++++++
 testcases/lib/.gitignore        |  1 +
 testcases/lib/Makefile          |  3 ++-
 testcases/lib/tst_getconf.c     | 57 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 74 insertions(+), 1 deletion(-)
 create mode 100644 testcases/lib/tst_getconf.c

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index fb7dcb591..e42451fae 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -1630,6 +1630,20 @@ passed directly to the script in '$1', '$2', ..., '$n'.
 2.3.4 Usefull library functions
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
+Retrieving configuration variables
+++++++++++++++++++++++++++++++++++
+
+You may need to retrieve some variable configuration such as PAGESIZE.
+There is "getconf" application that allows that but as some system may not
+have it, a "tst_getconf" library allows to retrieve these variables by using
+"sysconf()" function.
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
index 000000000..72abcc413
--- /dev/null
+++ b/testcases/lib/tst_getconf.c
@@ -0,0 +1,57 @@
+/*
+ * Copyright (c) 2018 Mylène Josserand <mylene.josserand@bootlin.com>
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
+#include <stdio.h>
+#include <unistd.h>
+#include <string.h>
+
+static void print_help(void)
+{
+	printf("Usage: tst_getconf variable\n\n");
+	printf("       variable: can be PAGESIZE or _NPROCESSORS_ONLN (for the moment)\n");
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
+	if (optind >= argc) {
+		fprintf(stderr, "ERROR: Expected variable argument\n\n");
+		print_help();
+		return 1;
+	}
+
+	if (!strcmp(argv[optind], "_NPROCESSORS_ONLN"))
+		printf("%ld", sysconf(_SC_NPROCESSORS_ONLN));
+	else if (!strcmp(argv[optind],"PAGESIZE"))
+		printf("%ld", sysconf(_SC_PAGE_SIZE));
+
+	return 0;
+}
-- 
2.11.0

