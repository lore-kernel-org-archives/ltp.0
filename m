From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Fri, 20 Jul 2018 18:40:12 +0800
Subject: [LTP] [PATCH v3 1/2] lib: Factor out is_supported() && Add
	tst_supported_fs
In-Reply-To: <20180719122126.GA16703@rei>
References: <20180719122126.GA16703@rei>
Message-ID: <1532083213-4803-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1) Factor out is_supported() and rename it as tst_fs_is_supported(),
   so that some tests can check a specified filesystem by it.

2) Add tst_supported_fs binary for shell tests to check a specified
   filesystem or all supported fielsystems.

   PS: hint messages from tst_supported_fs binary is targeted as stderr,
       so we can filter them by "2> /dev/null".

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 include/tst_fs.h                 |  6 +++++
 lib/tst_supported_fs_types.c     |  4 ++--
 testcases/lib/Makefile           |  2 +-
 testcases/lib/tst_supported_fs.c | 47 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 56 insertions(+), 3 deletions(-)
 create mode 100644 testcases/lib/tst_supported_fs.c

diff --git a/include/tst_fs.h b/include/tst_fs.h
index 73916a6..8d3f1cf 100644
--- a/include/tst_fs.h
+++ b/include/tst_fs.h
@@ -147,6 +147,12 @@ int tst_get_path(const char *prog_name, char *buf, size_t buf_len);
 int tst_fill_file(const char *path, char pattern, size_t bs, size_t bcount);
 
 /*
+ * Return 1 if a specified fiilsystem is supported
+ * Return 0 if a specified fiilsystem isn't supported
+ */
+int tst_fs_is_supported(const char *fs_type);
+
+/*
  * Returns NULL-terminated array of kernel-supported filesystems.
  */
 const char **tst_get_supported_fs_types(void);
diff --git a/lib/tst_supported_fs_types.c b/lib/tst_supported_fs_types.c
index a23b1ed..b7e647f 100644
--- a/lib/tst_supported_fs_types.c
+++ b/lib/tst_supported_fs_types.c
@@ -100,7 +100,7 @@ static int has_kernel_support(const char *fs_type)
 	return 1;
 }
 
-static int is_supported(const char *fs_type)
+int tst_fs_is_supported(const char *fs_type)
 {
 	return has_kernel_support(fs_type) && has_mkfs(fs_type);
 }
@@ -110,7 +110,7 @@ const char **tst_get_supported_fs_types(void)
 	unsigned int i, j = 0;
 
 	for (i = 0; fs_type_whitelist[i]; i++) {
-		if (is_supported(fs_type_whitelist[i]))
+		if (tst_fs_is_supported(fs_type_whitelist[i]))
 			fs_types[j++] = fs_type_whitelist[i];
 	}
 
diff --git a/testcases/lib/Makefile b/testcases/lib/Makefile
index 398150a..14352d5 100644
--- a/testcases/lib/Makefile
+++ b/testcases/lib/Makefile
@@ -26,7 +26,7 @@ include $(top_srcdir)/include/mk/testcases.mk
 
 INSTALL_TARGETS		:= *.sh
 
-MAKE_TARGETS		:= tst_sleep tst_random tst_checkpoint tst_rod tst_kvcmp\
+MAKE_TARGETS		:= tst_supported_fs tst_sleep tst_random tst_checkpoint tst_rod tst_kvcmp\
 			   tst_device tst_net_iface_prefix tst_net_ip_prefix tst_net_vars
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/lib/tst_supported_fs.c b/testcases/lib/tst_supported_fs.c
new file mode 100644
index 0000000..ebebcbb
--- /dev/null
+++ b/testcases/lib/tst_supported_fs.c
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2018 FUJITSU LIMITED. All rights reserved.
+ * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
+ */
+
+#include <stdio.h>
+#include <string.h>
+
+#define TST_NO_DEFAULT_MAIN
+#include "tst_test.h"
+#include "tst_fs.h"
+
+static void usage(void)
+{
+	fprintf(stderr, "Usage: tst_supported_fs [fs_type]\n");
+	fprintf(stderr, "   If fs_type is supported, return 0\n");
+	fprintf(stderr, "   If fs_type isn't supported, return 1\n");
+	fprintf(stderr, "   If fs_type isn't specified, print the list of supported filesystems\n");
+	fprintf(stderr, "   fs_type - a specified filesystem type\n");
+}
+
+int main(int argc, char *argv[])
+{
+	const char *const *filesystems;
+	int i;
+
+	if (argc > 2) {
+		fprintf(stderr, "Can't specify multiple fs_type\n");
+		usage();
+		return 2;
+	}
+
+	if (argv[1] && !strcmp(argv[1], "-h")) {
+		usage();
+		return 0;
+	}
+
+	if (argv[1])
+		return !tst_fs_is_supported(argv[1]);
+
+	filesystems = tst_get_supported_fs_types();
+	for (i = 0; filesystems[i]; i++)
+		printf("%s\n", filesystems[i]);
+
+	return 0;
+}
-- 
1.8.3.1



