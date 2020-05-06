From: Petr Vorel <pvorel@suse.cz>
Date: Wed,  6 May 2020 15:48:58 +0200
Subject: [LTP] [PATCH 1/1] pty04: Fix build for kernel headers < v4.2-rc1
Message-ID: <20200506134858.23919-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
https://travis-ci.org/github/pevik/ltp/builds/683787204

 configure.ac                 |  1 +
 include/lapi/tty.h           | 17 +++++++++++++++++
 testcases/kernel/pty/pty04.c | 17 ++++++++++-------
 3 files changed, 28 insertions(+), 7 deletions(-)
 create mode 100644 include/lapi/tty.h

diff --git a/configure.ac b/configure.ac
index e1069b57e..e352e18e8 100644
--- a/configure.ac
+++ b/configure.ac
@@ -55,6 +55,7 @@ AC_CHECK_HEADERS([ \
     linux/netlink.h \
     linux/seccomp.h \
     linux/securebits.h \
+    linux/tty.h \
     linux/types.h \
     linux/userfaultfd.h \
     mm.h \
diff --git a/include/lapi/tty.h b/include/lapi/tty.h
new file mode 100644
index 000000000..353a103f1
--- /dev/null
+++ b/include/lapi/tty.h
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 Petr Vorel <pvorel@suse.cz>
+ */
+
+#ifndef LAPI_TTY_H
+#define LAPI_TTY_H
+
+#ifdef HAVE_LINUX_TTY_H
+# include <linux/tty.h>
+#endif
+
+#ifndef N_SLCAN
+# define N_SLCAN		17	/* Serial / USB serial CAN Adaptors */
+#endif
+
+#endif /* LAPI_TTY_H */
diff --git a/testcases/kernel/pty/pty04.c b/testcases/kernel/pty/pty04.c
index eaf172504..239d2a870 100644
--- a/testcases/kernel/pty/pty04.c
+++ b/testcases/kernel/pty/pty04.c
@@ -34,9 +34,10 @@
  */
 
 #define _GNU_SOURCE
+#include "config.h"
 #include "tst_test.h"
 #include "tst_buffers.h"
-#include "config.h"
+#include "lapi/tty.h"
 
 #if defined(HAVE_LINUX_IF_PACKET_H) && defined(HAVE_LINUX_IF_ETHER_H)
 
@@ -44,11 +45,14 @@
 #include <linux/if_ether.h>
 #include <linux/tty.h>
 
-#ifdef HAVE_LINUX_CAN_H
-# include <linux/can.h>
-#else
-# define CAN_MTU 16
-# define CAN_MAX_DLEN 8
+/*
+ * define instead of including <linux/can.h> to support kernel headers
+ * before change from v4.2-rc1
+ * a2f11835994e ("can.h: make padding given by gcc explicit").
+ */
+
+#define CAN_MTU 16
+#define CAN_MAX_DLEN 8
 
 typedef uint32_t canid_t;
 
@@ -60,7 +64,6 @@ struct can_frame {
 	uint32_t __res1;
 	uint32_t data[CAN_MAX_DLEN] __attribute__((aligned(8)));
 };
-#endif
 
 #include <stddef.h>
 #include <stdlib.h>
-- 
2.26.2

