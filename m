From: QI Fuli <fukuri.sai@gmail.com>
Date: Sat, 27 Mar 2021 19:32:21 +0900
Subject: [LTP] [PATCH 1/6] libs/libltpswap: Add libs/libltpswap by using the
 new API
In-Reply-To: <20210327103226.99073-1-qi.fuli@fujitsu.com>
References: <20210327103226.99073-1-qi.fuli@fujitsu.com>
Message-ID: <20210327103226.99073-2-qi.fuli@fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: QI Fuli <qi.fuli@fujitsu.com>

Signed-off-by: QI Fuli <qi.fuli@fujitsu.com>
---
 include/libswap.h         | 24 +++++++++++++++
 libs/libltpswap/Makefile  | 12 ++++++++
 libs/libltpswap/libswap.c | 63 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 99 insertions(+)
 create mode 100644 include/libswap.h
 create mode 100644 libs/libltpswap/Makefile
 create mode 100644 libs/libltpswap/libswap.c

diff --git a/include/libswap.h b/include/libswap.h
new file mode 100644
index 000000000..d4b5301a5
--- /dev/null
+++ b/include/libswap.h
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
+ * Author: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
+ */
+
+/*
+ * Contains common content for all swapon/swapoff tests
+ */
+
+#ifndef __LIBSWAP_H__
+#define __LIBSWAP_H__
+
+/*
+ * Make a swap file
+ */
+int make_swapfile(const char *swapfile, int safe);
+
+/*
+ * Check swapon/swapoff support status of filesystems or files
+ * we are testing on.
+ */
+void is_swap_supported(const char *filename);
+#endif /* __LIBSWAP_H__ */
diff --git a/libs/libltpswap/Makefile b/libs/libltpswap/Makefile
new file mode 100644
index 000000000..d8e692d17
--- /dev/null
+++ b/libs/libltpswap/Makefile
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) Richard Purdie <richard.purdie@linuxfoundation.org>
+
+top_srcdir		?= ../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+
+INTERNAL_LIB		:= libltpswap.a
+
+include $(top_srcdir)/include/mk/lib.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/libs/libltpswap/libswap.c b/libs/libltpswap/libswap.c
new file mode 100644
index 000000000..658960c67
--- /dev/null
+++ b/libs/libltpswap/libswap.c
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
+ * Author: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
+ */
+
+#include <errno.h>
+#include "lapi/syscalls.h"
+#define TST_NO_DEFAULT_MAIN
+#include "tst_test.h"
+#include "libswap.h"
+
+/*
+ * Make a swap file
+ */
+int make_swapfile(const char *swapfile, int safe)
+{
+	if (!tst_fs_has_free(".", sysconf(_SC_PAGESIZE) * 10, TST_BYTES))
+		tst_brk(TBROK, "Insufficient disk space to create swap file");
+
+	/* create file */
+	if (tst_fill_file(swapfile, 0, sysconf(_SC_PAGESIZE), 10) != 0)
+		tst_brk(TBROK, "Failed to create swapfile");
+
+	/* make the file swapfile */
+	const char *argv[2 + 1];
+	argv[0] = "mkswap";
+	argv[1] = swapfile;
+	argv[2] = NULL;
+
+	return tst_cmd(argv, "/dev/null", "/dev/null", safe);
+}
+
+/*
+ * Check swapon/swapoff support status of filesystems or files
+ * we are testing on.
+ */
+void is_swap_supported(const char *filename)
+{
+	int fibmap = tst_fibmap(filename);
+	long fs_type = tst_fs_type(filename);
+	const char *fstype = tst_fs_type_name(fs_type);
+
+	int ret = make_swapfile(filename, 1);
+	if (ret != 0) {
+		if (fibmap == 1)
+			tst_brk(TCONF, "mkswap on %s not supported", fstype);
+		else
+			tst_brk(TFAIL, "mkswap on %s failed", fstype);
+	}
+
+	TEST(tst_syscall(__NR_swapon, filename, 0));
+	if (TST_RET == -1) {
+		if (fibmap == 1 && errno == EINVAL)
+			tst_brk(TCONF, "Swapfile on %s not implemented", fstype);
+		else
+			tst_brk(TFAIL | TERRNO, "swapon on %s failed", fstype);
+	}
+
+	TEST(tst_syscall(__NR_swapoff, filename, 0));
+	if (TST_RET == -1)
+		tst_brk(TFAIL | TTERRNO, "swapoff on %s failed", fstype);
+}
-- 
2.30.2

