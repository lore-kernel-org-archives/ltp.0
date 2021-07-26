From: Martin Doucha <mdoucha@suse.cz>
Date: Mon, 26 Jul 2021 17:17:35 +0200
Subject: [LTP] [PATCH 1/2] Add tst_hexdump utility
Message-ID: <20210726151736.14299-1-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

tst_hexdump implements conversion between binary and hexadecimal values in both
directions for shell tests.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 testcases/lib/Makefile      |  2 +-
 testcases/lib/tst_hexdump.c | 55 +++++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+), 1 deletion(-)
 create mode 100644 testcases/lib/tst_hexdump.c

diff --git a/testcases/lib/Makefile b/testcases/lib/Makefile
index 98d9e4613..38813e640 100644
--- a/testcases/lib/Makefile
+++ b/testcases/lib/Makefile
@@ -11,6 +11,6 @@ INSTALL_TARGETS		:= *.sh
 MAKE_TARGETS		:= tst_sleep tst_random tst_checkpoint tst_rod tst_kvcmp\
 			   tst_device tst_net_iface_prefix tst_net_ip_prefix tst_net_vars\
 			   tst_getconf tst_supported_fs tst_check_drivers tst_get_unused_port\
-			   tst_get_median
+			   tst_get_median tst_hexdump
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/lib/tst_hexdump.c b/testcases/lib/tst_hexdump.c
new file mode 100644
index 000000000..f83b8bfbf
--- /dev/null
+++ b/testcases/lib/tst_hexdump.c
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2021 SUSE LLC <mdoucha@suse.cz>
+ *
+ * Convert bytes from standard input to hexadecimal representation.
+ *
+ * Parameters:
+ * -d   Convert hexadecimal values from standard input to binary representation
+ *      instead.
+ */
+
+#include <stdio.h>
+#include <unistd.h>
+
+int decode_hex(void)
+{
+	int ret;
+	unsigned int val;
+
+	while ((ret = scanf("%2x", &val)) == 1)
+		putchar(val);
+
+	return ret != EOF || ferror(stdin);
+}
+
+int encode_hex(void)
+{
+	int val;
+
+	for (val = getchar(); val >= 0 && val <= 0xff; val = getchar())
+		printf("%02x", val);
+
+	return val != EOF || ferror(stdin);
+}
+
+int main(int argc, char **argv)
+{
+	int ret, decode = 0;
+
+	while ((ret = getopt(argc, argv, "d"))) {
+		if (ret < 0)
+			break;
+
+		switch (ret) {
+		case 'd':
+			decode = 1;
+			break;
+		}
+	}
+
+	if (decode)
+		return decode_hex();
+	else
+		return encode_hex();
+}
-- 
2.32.0

