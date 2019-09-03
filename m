From: Jinhui huang <huangjh.jy@cn.fujitsu.com>
Date: Tue, 3 Sep 2019 20:48:09 +0800
Subject: [LTP] [PATCH 1/2] kernel/uevents: Fix compiler errors
Message-ID: <1567514890-1216-1-git-send-email-huangjh.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1)Add uevents into "kernel/Makefile".
2)Define "sys/socket.h" in uevent02.c for struct sockaddr, fix incomplete
  types on old relesase.
3)Add "lapi/uinput.h" and define "UI_GET_SYSNAME", then define the header
  file in uevent03.c, fix implicit declaration on old relesase.

Signed-off-by: Jinhui huang <huangjh.jy@cn.fujitsu.com>
---
 include/lapi/uinput.h               | 16 ++++++++++++++++
 testcases/kernel/Makefile           |  1 +
 testcases/kernel/uevents/uevent02.c |  1 +
 testcases/kernel/uevents/uevent03.c |  3 +--
 4 files changed, 19 insertions(+), 2 deletions(-)
 create mode 100644 include/lapi/uinput.h

diff --git a/include/lapi/uinput.h b/include/lapi/uinput.h
new file mode 100644
index 0000000..87e3384
--- /dev/null
+++ b/include/lapi/uinput.h
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2019 FUJITSU LIMITED. All rights reserved.
+ * Authors: Jinhui huang <huangjh.jy@cn.fujitsu.com>
+ */
+
+#ifndef __LAPI_UINPUT_H_
+#define __LAPI_UINPUT_H_
+
+#include <linux/uinput.h>
+
+#ifndef UI_GET_SYSNAME
+#define UI_GET_SYSNAME(len)	_IOC(_IOC_READ, UINPUT_IOCTL_BASE, 44, len)
+#endif
+
+#endif /* __LAPI_UINPUT_H_ */
diff --git a/testcases/kernel/Makefile b/testcases/kernel/Makefile
index 03ea253..3319b31 100644
--- a/testcases/kernel/Makefile
+++ b/testcases/kernel/Makefile
@@ -54,6 +54,7 @@ SUBDIRS			+= connectors \
 			   security \
 			   sound \
 			   tracing \
+			   uevents \
 
 ifeq ($(WITH_POWER_MANAGEMENT_TESTSUITE),yes)
 SUBDIRS			+= power_management
diff --git a/testcases/kernel/uevents/uevent02.c b/testcases/kernel/uevents/uevent02.c
index b94748c..9dd4cd6 100644
--- a/testcases/kernel/uevents/uevent02.c
+++ b/testcases/kernel/uevents/uevent02.c
@@ -14,6 +14,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <sys/wait.h>
+#include <sys/socket.h>
 #include <linux/if.h>
 #include <linux/if_tun.h>
 
diff --git a/testcases/kernel/uevents/uevent03.c b/testcases/kernel/uevents/uevent03.c
index 991737e..9b901dc 100644
--- a/testcases/kernel/uevents/uevent03.c
+++ b/testcases/kernel/uevents/uevent03.c
@@ -16,11 +16,10 @@
 #include <sys/wait.h>
 #include <sys/sysmacros.h>
 
-#include <linux/uinput.h>
-
 #include "tst_test.h"
 #include "tst_uinput.h"
 #include "uevent.h"
+#include "lapi/uinput.h"
 
 static int mouse_fd;
 
-- 
1.8.3.1



