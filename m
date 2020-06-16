From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 16 Jun 2020 21:09:18 +0200
Subject: [LTP] [RFC PATCH] lapi: Add posix_types.h
Message-ID: <20200616190918.24761-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

To fix undefined __kernel_ulong_t, which was defined in v3.4-rc1
in afead38d011a ("posix_types: Introduce __kernel_[u]long_t").

This fixed build error:

In file included from /usr/src/ltp/include/lapi/msgbuf.h:13,
                 from /usr/src/ltp/testcases/kernel/syscalls/ipc/msgctl/msgctl05.c:9:
/usr/src/ltp/include/lapi/ipcbuf.h: At top level:
/usr/src/ltp/include/lapi/ipcbuf.h:187: error: expected specifier-qualifier-list before '__kernel_ulong_t'

Fixes: 3e1fc0644 ("include: Add declaration of struct ipc64_perm")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

or is it a time to drop that support?
If I remember we were talking about 3.0, this is 3.4.

Is this correct?
+#ifndef __kernel_long_t
+# if defined(__x86_64__) && defined(__ILP32__)
+typedef long long		__kernel_long_t;
+typedef unsigned long long	__kernel_ulong_t;
+# else
+typedef long			__kernel_long_t;
+typedef unsigned long		__kernel_ulong_t;
+# endif
+#endif

Kind regards,
Petr

 include/lapi/ipcbuf.h      |  2 +-
 include/lapi/msgbuf.h      |  2 +-
 include/lapi/posix_types.h | 21 +++++++++++++++++++++
 include/lapi/sembuf.h      |  2 +-
 include/lapi/shmbuf.h      |  2 +-
 include/tst_timer.h        |  7 +------
 6 files changed, 26 insertions(+), 10 deletions(-)
 create mode 100644 include/lapi/posix_types.h

diff --git a/include/lapi/ipcbuf.h b/include/lapi/ipcbuf.h
index 609b2a346..a0b8e3ce3 100644
--- a/include/lapi/ipcbuf.h
+++ b/include/lapi/ipcbuf.h
@@ -8,7 +8,7 @@
 #define IPCBUF_H
 
 #include "config.h"
-#include <linux/posix_types.h>
+#include "lapi/posix_types.h"
 
 #ifndef HAVE_IPC64_PERM
 
diff --git a/include/lapi/msgbuf.h b/include/lapi/msgbuf.h
index 1e44997c1..f3277270d 100644
--- a/include/lapi/msgbuf.h
+++ b/include/lapi/msgbuf.h
@@ -7,7 +7,7 @@
 #ifndef IPC_MSGBUF_H
 #define IPC_MSGBUF_H
 
-#include <linux/posix_types.h>
+#include "lapi/posix_types.h"
 #include <sys/sem.h>
 #include "tst_timer.h"
 #include "ipcbuf.h"
diff --git a/include/lapi/posix_types.h b/include/lapi/posix_types.h
new file mode 100644
index 000000000..9c0947cca
--- /dev/null
+++ b/include/lapi/posix_types.h
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) Linux Test Project, 2014-2019
+ */
+
+#ifndef POSIX_TYPES_H__
+#define POSIX_TYPES_H__
+
+#include <linux/posix_types.h>
+
+#ifndef __kernel_long_t
+# if defined(__x86_64__) && defined(__ILP32__)
+typedef long long		__kernel_long_t;
+typedef unsigned long long	__kernel_ulong_t;
+# else
+typedef long			__kernel_long_t;
+typedef unsigned long		__kernel_ulong_t;
+# endif
+#endif
+
+#endif /* POSIX_TYPES_H__ */
diff --git a/include/lapi/sembuf.h b/include/lapi/sembuf.h
index 00263abca..4ef0483a0 100644
--- a/include/lapi/sembuf.h
+++ b/include/lapi/sembuf.h
@@ -7,7 +7,7 @@
 #ifndef IPC_SEMBUF_H
 #define IPC_SEMBUF_H
 
-#include <linux/posix_types.h>
+#include "lapi/posix_types.h"
 #include <sys/sem.h>
 #include "tst_timer.h"
 #include "ipcbuf.h"
diff --git a/include/lapi/shmbuf.h b/include/lapi/shmbuf.h
index f8c1294c6..28ee33620 100644
--- a/include/lapi/shmbuf.h
+++ b/include/lapi/shmbuf.h
@@ -7,7 +7,7 @@
 #ifndef IPC_SHMBUF_H
 #define IPC_SHMBUF_H
 
-#include <linux/posix_types.h>
+#include "lapi/posix_types.h"
 #include <sys/sem.h>
 #include "tst_timer.h"
 #include "ipcbuf.h"
diff --git a/include/tst_timer.h b/include/tst_timer.h
index 256e1d71e..cdfddb69a 100644
--- a/include/tst_timer.h
+++ b/include/tst_timer.h
@@ -15,6 +15,7 @@
 #include <sys/time.h>
 #include <time.h>
 #include "tst_test.h"
+#include "lapi/posix_types.h"
 #include "lapi/syscalls.h"
 
 /*
@@ -93,12 +94,6 @@ static inline long long tst_timeval_diff_ms(struct timeval t1,
 
 #ifndef __kernel_timespec
 
-#if defined(__x86_64__) && defined(__ILP32__)
-typedef long long __kernel_long_t;
-#else
-typedef long __kernel_long_t;
-#endif
-
 typedef __kernel_long_t	__kernel_old_time_t;
 
 struct __kernel_old_timespec {
-- 
2.27.0

