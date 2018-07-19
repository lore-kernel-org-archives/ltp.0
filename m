From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 19 Jul 2018 15:31:09 +0800
Subject: [LTP] [PATCH v2 1/2] lib: Factor out is_supported() && Add
	tst_supported_fs for shell
In-Reply-To: <20180718124638.GD7117@rei>
References: <20180718124638.GD7117@rei>
Message-ID: <1531985470-25203-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1) Factor out is_supported() and rename it as tst_fs_is_supported(),
   so that some tests can check a specified filesystem by it.

2) Shell tests can check a specified filesystem or all supported
   fielsystems by tst_supported_fs binary.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 include/tst_fs.h                 |  8 ++++++
 lib/tst_supported_fs_types.c     |  6 ++--
 testcases/lib/Makefile           |  2 +-
 testcases/lib/tst_supported_fs.c | 61 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 73 insertions(+), 4 deletions(-)
 create mode 100644 testcases/lib/tst_supported_fs.c

diff --git a/include/tst_fs.h b/include/tst_fs.h
index 73916a6..599f28f 100644
--- a/include/tst_fs.h
+++ b/include/tst_fs.h
@@ -49,6 +49,8 @@ enum {
 	TST_GB = 1073741824,
 };
 
+extern const char *const fs_type_whitelist[];
+
 /*
  * @path: path is the pathname of any file within the mounted file system
  * @mult: mult should be TST_KB, TST_MB or TST_GB
@@ -147,6 +149,12 @@ int tst_get_path(const char *prog_name, char *buf, size_t buf_len);
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
index a23b1ed..c7123b2 100644
--- a/lib/tst_supported_fs_types.c
+++ b/lib/tst_supported_fs_types.c
@@ -25,7 +25,7 @@
 #include "tst_test.h"
 #include "tst_fs.h"
 
-static const char *const fs_type_whitelist[] = {
+const char *const fs_type_whitelist[] = {
 	"ext2",
 	"ext3",
 	"ext4",
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
index 0000000..df9ea48
--- /dev/null
+++ b/testcases/lib/tst_supported_fs.c
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2018 FUJITSU LIMITED. All rights reserved.
+ * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
+ */
+
+#include <errno.h>
+#include <stdio.h>
+#include <string.h>
+
+#define TST_NO_DEFAULT_MAIN
+#include "tst_test.h"
+#include "tst_fs.h"
+
+static void usage(void)
+{
+	printf("Usage: tst_supported_fs [fs_type]\n");
+	printf("   If a specified fs_type is supported, return 1\n");
+	printf("   If a specified fs_type isn't supported, return 0\n");
+	printf("   If a fs_type isn't specified, print the list of supported filesystems\n");
+	printf("   fs_type - a specified filesystem type\n");
+}
+
+int main(int argc, char *argv[])
+{
+	const char *const *filesystems;
+	int i, valid_flag = 0;
+
+	if (argc > 2) {
+		printf("Can't specify multiple fs_type\n");
+		usage();
+		return 2;
+	}
+
+	if (argv[1] && !strcmp(argv[1], "-h")) {
+		usage();
+		return 2;
+	}
+
+	if (argv[1]) {
+		for (i = 0; fs_type_whitelist[i]; i++) {
+			if (!strcmp(argv[1], fs_type_whitelist[i])) {
+				valid_flag = 1;
+				break;
+			}
+		}
+
+		if (valid_flag)
+			return tst_fs_is_supported(argv[1]);
+
+		printf("An invalid specified fs_type is %s\n", argv[1]);
+		return 2;
+	}
+
+	printf("List of supported fs_type:\n");
+	filesystems = tst_get_supported_fs_types();
+	for (i = 0; filesystems[i]; i++)
+		printf("%s\n", filesystems[i]);
+
+	return 2;
+}
-- 
1.8.3.1



