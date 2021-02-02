From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue,  2 Feb 2021 16:34:53 +0300
Subject: [LTP] [PATCH 2/3] lib: add tst_get_median helper binary for use in
 script tests
In-Reply-To: <20210202133454.59224-1-alexey.kodanev@oracle.com>
References: <20210202133454.59224-1-alexey.kodanev@oracle.com>
Message-ID: <20210202133454.59224-3-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

/tst_get_median 10 11 300 8 9 14
output: 10

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/lib/.gitignore       |  1 +
 testcases/lib/Makefile         |  3 ++-
 testcases/lib/tst_get_median.c | 37 ++++++++++++++++++++++++++++++++++
 3 files changed, 40 insertions(+), 1 deletion(-)
 create mode 100644 testcases/lib/tst_get_median.c

diff --git a/testcases/lib/.gitignore b/testcases/lib/.gitignore
index 52f99dc45..bc299b6ee 100644
--- a/testcases/lib/.gitignore
+++ b/testcases/lib/.gitignore
@@ -2,6 +2,7 @@
 /tst_checkpoint
 /tst_device
 /tst_getconf
+/tst_get_median
 /tst_get_unused_port
 /tst_kvcmp
 /tst_net_iface_prefix
diff --git a/testcases/lib/Makefile b/testcases/lib/Makefile
index 4616e24c0..f77da0d56 100644
--- a/testcases/lib/Makefile
+++ b/testcases/lib/Makefile
@@ -28,6 +28,7 @@ INSTALL_TARGETS		:= *.sh
 
 MAKE_TARGETS		:= tst_sleep tst_random tst_checkpoint tst_rod tst_kvcmp\
 			   tst_device tst_net_iface_prefix tst_net_ip_prefix tst_net_vars\
-			   tst_getconf tst_supported_fs tst_check_drivers tst_get_unused_port
+			   tst_getconf tst_supported_fs tst_check_drivers tst_get_unused_port\
+			   tst_get_median
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/lib/tst_get_median.c b/testcases/lib/tst_get_median.c
new file mode 100644
index 000000000..5246f12e0
--- /dev/null
+++ b/testcases/lib/tst_get_median.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Copyright (c) 2021 Oracle and/or its affiliates. All Rights Reserved. */
+
+#include <stdio.h>
+#include <stdlib.h>
+
+static int cmp(const void *a, const void *b)
+{
+   return (*(int *)a - *(int *)b);
+}
+
+int main(int argc, const char *argv[])
+{
+	const size_t size = argc - 1;
+
+	if (!size) {
+		fprintf(stderr, "Please provide a numeric list\n");
+		return 1;
+	}
+	if (size == 1) {
+		printf("%d", atoi(argv[1]));
+		return 0;
+	}
+
+	int arr[size];
+	size_t i;
+
+	for (i = 0; i < size; ++i)
+		arr[i] = atoi(argv[i + 1]);
+
+	qsort(arr, size, sizeof(arr[0]), cmp);
+
+	const size_t size2 = size / 2;
+	printf("%d", (size & 1) ? arr[size2] : ((arr[size2 - 1] + arr[size2]) / 2));
+
+	return 0;
+}
-- 
2.25.1

