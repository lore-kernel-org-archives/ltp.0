From: Chunyu Hu <chuhu@redhat.com>
Date: Mon, 18 Apr 2016 16:04:13 +0800
Subject: [LTP] [PATCH V2 6/9] testcases/lib: Add tst_random decmical integer
	generator
In-Reply-To: <1460966656-28328-6-git-send-email-chuhu@redhat.com>
References: <1460966656-28328-1-git-send-email-chuhu@redhat.com>
 <1460966656-28328-2-git-send-email-chuhu@redhat.com>
 <1460966656-28328-3-git-send-email-chuhu@redhat.com>
 <1460966656-28328-4-git-send-email-chuhu@redhat.com>
 <1460966656-28328-5-git-send-email-chuhu@redhat.com>
 <1460966656-28328-6-git-send-email-chuhu@redhat.com>
Message-ID: <1460966656-28328-7-git-send-email-chuhu@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

It parse the input range and get one decimical integer in the range.
Tests can use it to determin a random action.

+ documentation in the test-writing-guidelines

Signed-off-by: Chunyu Hu <chuhu@redhat.com>
---
 doc/test-writing-guidelines.txt |  12 +++++
 testcases/lib/.gitignore        |   1 +
 testcases/lib/Makefile          |   4 +-
 testcases/lib/tst_random.c      | 104 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 119 insertions(+), 2 deletions(-)
 create mode 100644 testcases/lib/tst_random.c

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index d0b1408..a6b4c2d 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -1203,6 +1203,18 @@ that can sleep for defined amount of seconds, milliseconds or microseconds.
 tst_sleep 100ms
 -------------------------------------------------------------------------------
 
+tst_random
++++++++++
+
+There may be test such as ftrace_test using random integer to determin the test action.
+here includes 'tst_random' to support it, avoid the `date+%N` action.
+
+[source,sh]
+-------------------------------------------------------------------------------
+# get random integer between 0 and 1000 (include 0 and 1000)
+tst_random 0 1000
+-------------------------------------------------------------------------------
+
 ROD and ROD_SILENT
 ++++++++++++++++++
 
diff --git a/testcases/lib/.gitignore b/testcases/lib/.gitignore
index 8886b34..15a04df 100644
--- a/testcases/lib/.gitignore
+++ b/testcases/lib/.gitignore
@@ -1 +1,2 @@
 tst_sleep
+tst_random
diff --git a/testcases/lib/Makefile b/testcases/lib/Makefile
index 0bfb149..be3a720 100644
--- a/testcases/lib/Makefile
+++ b/testcases/lib/Makefile
@@ -24,8 +24,8 @@ top_srcdir		?= ../..
 
 include $(top_srcdir)/include/mk/env_pre.mk
 
-INSTALL_TARGETS		:= *.sh tst_sleep
+INSTALL_TARGETS		:= *.sh tst_sleep tst_random
 
-MAKE_TARGETS		:= tst_sleep
+MAKE_TARGETS		:= tst_sleep tst_random
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/lib/tst_random.c b/testcases/lib/tst_random.c
new file mode 100644
index 0000000..91a5247
--- /dev/null
+++ b/testcases/lib/tst_random.c
@@ -0,0 +1,104 @@
+/*
+ * Copyright (c) 2016 Red Hat Inc.
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
+ *
+ * Author: Chunyu Hu <chuhu@redhat.com>
+ *
+ */
+
+#include <stdio.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/time.h>
+
+static void print_help(void)
+{
+	printf("Usage: tst_random <value1> [value2]\n");
+	printf("       Generated random will be between value1 and value2.\n");
+	printf("       If only value1 is specified, value2 will treated as 0.\n");
+}
+
+static int get_seed(void)
+{
+	struct timeval tv;
+	gettimeofday(&tv, NULL);
+	return tv.tv_usec;
+}
+
+static long rand_range(long min, long max)
+{
+	return rand() % (max - min + 1) + min;
+}
+
+int main(int argc, char *argv[])
+{
+	int opt;
+	long min = 0, max = 0, tmp = 0;
+	long rval = 0;
+	char *end;
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
+	if (argc < 2 || argc > 3) {
+		print_help();
+		return 1;
+	}
+
+	if (optind >= argc) {
+		fprintf(stderr, "ERROR: Expected one or two range_val arguments\n\n");
+		print_help();
+		return 1;
+	}
+
+	max = strtol(argv[optind], &end, 10);
+	if (argv[optind] == end) {
+		fprintf(stderr, "ERROR: Invalid range value1 '%s'\n\n",
+			argv[optind]);
+		print_help();
+		return 1;
+	}
+
+	if (argc == 3) {
+		min = strtol(argv[optind+1], &end, 10);
+		if (argv[optind+1] == end) {
+			fprintf(stderr, "ERROR: Invalid range value2 '%s'\n\n",
+				argv[optind+1]);
+			print_help();
+			return 1;
+		}
+		if (min > max) {
+			tmp = min;
+			min = max;
+			max = tmp;
+		}
+	}
+
+	srand(get_seed());
+	rval = rand_range(min, max);
+	printf("%ld\n", rval);
+
+	return rval;
+}
-- 
1.8.3.1

