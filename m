From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Thu, 9 Apr 2020 18:44:37 +0800
Subject: [LTP] [PATCH v2 02/10] syscalls/ioctl:add common c file for loop
 ioctl
In-Reply-To: <1586429086-22975-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <20200409075506.GA2828@yuki.lan>
 <1586429086-22975-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <1586429086-22975-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/ioctl/Makefile      |  5 +++
 .../syscalls/ioctl/ioctl_loop_support.c       | 40 +++++++++++++++++++
 .../syscalls/ioctl/ioctl_loop_support.h       | 12 ++++++
 3 files changed, 57 insertions(+)
 create mode 100644 testcases/kernel/syscalls/ioctl/ioctl_loop_support.c
 create mode 100644 testcases/kernel/syscalls/ioctl/ioctl_loop_support.h

diff --git a/testcases/kernel/syscalls/ioctl/Makefile b/testcases/kernel/syscalls/ioctl/Makefile
index c2ff6c8e7..7bdc7daf0 100644
--- a/testcases/kernel/syscalls/ioctl/Makefile
+++ b/testcases/kernel/syscalls/ioctl/Makefile
@@ -7,6 +7,11 @@ include $(top_srcdir)/include/mk/testcases.mk
 
 INSTALL_TARGETS		+= test_ioctl
 
+FILTER_OUT_MAKE_TARGETS += ioctl_loop_support
+
+LOOP_TARGETS            := $(patsubst $(abs_srcdir)/%.c,%,$(wildcard $(abs_srcdir)/ioctl_loop[0-9]*.c))
+$(LOOP_TARGETS): %: ioctl_loop_support.o
+
 ifeq ($(ANDROID),1)
 FILTER_OUT_MAKE_TARGETS	+= ioctl02
 endif
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop_support.c b/testcases/kernel/syscalls/ioctl/ioctl_loop_support.c
new file mode 100644
index 000000000..75c7b1b9a
--- /dev/null
+++ b/testcases/kernel/syscalls/ioctl/ioctl_loop_support.c
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 FUJITSU LIMITED. All rights reserved.
+ * Author: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
+ */
+#define TST_NO_DEFAULT_MAIN
+#include "ioctl_loop_support.h"
+#include "tst_test.h"
+
+void check_sys_value(char *path, int setvalue)
+{
+	int getvalue;
+
+	SAFE_FILE_SCANF(path, "%d", &getvalue);
+	if (setvalue == getvalue)
+		tst_res(TPASS, "%s value is %d", path, setvalue);
+	else
+		tst_res(TFAIL, "%s value expected %d got %d", path, setvalue, getvalue);
+}
+
+void check_sys_string(char *path, char *setmessage)
+{
+	char getmessage[1024];
+
+	SAFE_FILE_SCANF(path, "%s", getmessage);
+	if (strcmp(setmessage, getmessage))
+		tst_res(TFAIL, "%s expected %s got %s", path, setmessage, getmessage);
+	else
+		tst_res(TPASS, "%s string is %s", path, getmessage);
+}
+
+void check_support_cmd(int dev_fd, int ioctl_flag, int value, char *message)
+{
+	int ret = 0;
+
+	ret = ioctl(dev_fd, ioctl_flag, value);
+	if (ret && errno == EINVAL)
+		tst_brk(TCONF, "Current environment doesn't support this flag(%s)",
+				message);
+}
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop_support.h b/testcases/kernel/syscalls/ioctl/ioctl_loop_support.h
new file mode 100644
index 000000000..ade64e82e
--- /dev/null
+++ b/testcases/kernel/syscalls/ioctl/ioctl_loop_support.h
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 FUJITSU LIMITED. All rights reserved.
+ * Author: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
+ */
+#ifndef IOCTL_LOOP_H
+#define IOCTL_lOOP_H
+#include <linux/loop.h>
+void check_sys_value(char *path, int setvalue);
+void check_sys_string(char *path, char *setmessage);
+void check_support_cmd(int dev_fd, int ioctl_flag, int value, char *message);
+#endif
-- 
2.23.0



