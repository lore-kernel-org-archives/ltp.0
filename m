From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 18 Mar 2020 16:37:54 +0100
Subject: [LTP] [PATCH v2 2/9] lapi: Add a configure check and fallback for
 setns
In-Reply-To: <20200318153801.3529-1-chrubis@suse.cz>
References: <20200318153801.3529-1-chrubis@suse.cz>
Message-ID: <20200318153801.3529-3-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 configure.ac         |  1 +
 include/lapi/setns.h | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+)
 create mode 100644 include/lapi/setns.h

diff --git a/configure.ac b/configure.ac
index 238d1cde8..ce03b3a55 100644
--- a/configure.ac
+++ b/configure.ac
@@ -111,6 +111,7 @@ AC_CHECK_FUNCS([ \
     renameat2 \
     sched_getcpu \
     sendmmsg \
+    setns \
     sigpending \
     splice \
     statx \
diff --git a/include/lapi/setns.h b/include/lapi/setns.h
new file mode 100644
index 000000000..7b0a7afc4
--- /dev/null
+++ b/include/lapi/setns.h
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+  Copyright (c) 2020 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+#ifndef LAPI_SETNS_H__
+#define LAPI_SETNS_H__
+
+#include "config.h"
+#include "lapi/syscalls.h"
+#include <sched.h>
+
+#ifndef HAVE_SETNS
+int setns(int fd, int nstype)
+{
+	return tst_syscall(__NR_setns, fd, nstype);
+}
+#endif
+
+#endif /* LAPI_SETNS_H__ */
-- 
2.24.1

