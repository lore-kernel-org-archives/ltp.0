From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 23 Oct 2019 15:56:04 +0200
Subject: [LTP] [PATCH] timer_create01: accept kernel ENOTSUPP
Message-ID: <cb6173ec393a23949ec40c9747fc7f75fed2591f.1571838908.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

ENOTSUP in userspace is alias for EOPNOTSUPP, so the test still fails.
Add definition of kernel's ENOTSUPP and use that.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 include/lapi/errno.h                                    | 11 +++++++++++
 testcases/kernel/syscalls/timer_create/timer_create01.c |  3 ++-
 2 files changed, 13 insertions(+), 1 deletion(-)
 create mode 100644 include/lapi/errno.h

diff --git a/include/lapi/errno.h b/include/lapi/errno.h
new file mode 100644
index 000000000000..22c2d4d279d8
--- /dev/null
+++ b/include/lapi/errno.h
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2019 Linux Test Project
+ */
+
+#ifndef _LAPI_ERRNO_H_
+#define _LAPI_ERRNO_H_
+
+#define K_ENOTSUPP	524	/* Operation is not supported */
+
+#endif
diff --git a/testcases/kernel/syscalls/timer_create/timer_create01.c b/testcases/kernel/syscalls/timer_create/timer_create01.c
index 1d0e400d3260..968f917e7876 100644
--- a/testcases/kernel/syscalls/timer_create/timer_create01.c
+++ b/testcases/kernel/syscalls/timer_create/timer_create01.c
@@ -27,6 +27,7 @@
 #include <time.h>
 #include "tst_test.h"
 #include "tst_safe_macros.h"
+#include "lapi/errno.h"
 #include "lapi/common_timers.h"
 
 static struct notif_type {
@@ -81,7 +82,7 @@ static void run(unsigned int n)
 
 		if (TST_RET != 0) {
 			if (possibly_unsupported(clock) &&
-			    (TST_ERR == EINVAL || TST_ERR == ENOTSUP)) {
+			    (TST_ERR == EINVAL || TST_ERR == K_ENOTSUPP)) {
 				tst_res(TPASS | TTERRNO,
 					"%s unsupported, failed as expected",
 					get_clock_str(clock));
-- 
1.8.3.1

