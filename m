From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 28 Jan 2020 16:23:51 +0100
Subject: [LTP] [COMMITTED] [PATCH] pty03: Add fallback definition for
 TIOCVHANGUP
Message-ID: <20200128152351.31779-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Introduce lapi/ioctl.h with fallback definition for TIOCVHANGUP and make
use of that in pty03 test.

This fixes build on Centos 6.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/lapi/ioctl.h         | 15 +++++++++++++++
 testcases/kernel/pty/pty03.c |  2 +-
 2 files changed, 16 insertions(+), 1 deletion(-)
 create mode 100644 include/lapi/ioctl.h

diff --git a/include/lapi/ioctl.h b/include/lapi/ioctl.h
new file mode 100644
index 000000000..a6ef811cd
--- /dev/null
+++ b/include/lapi/ioctl.h
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+#ifndef IOCTL_H__
+#define IOCTL_H__
+
+#include <sys/ioctl.h>
+
+#ifndef TIOCVHANGUP
+# define TIOCVHANGUP 0x5437
+#endif
+
+#endif /* IOCTL_H__ */
diff --git a/testcases/kernel/pty/pty03.c b/testcases/kernel/pty/pty03.c
index 8514aa43d..757d0bf2a 100644
--- a/testcases/kernel/pty/pty03.c
+++ b/testcases/kernel/pty/pty03.c
@@ -28,7 +28,7 @@
 #include <stdio.h>
 #include <errno.h>
 #include <termios.h>
-#include <sys/ioctl.h>
+#include "lapi/ioctl.h"
 
 #include "tst_test.h"
 #include "tst_safe_stdio.h"
-- 
2.23.0

