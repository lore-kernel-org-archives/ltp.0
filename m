From: Petr Vorel <petr.vorel@gmail.com>
Date: Mon, 18 Mar 2019 04:23:26 +0100
Subject: [LTP] [PATCH 1/5] rt_sigaction.h: Check for type sighandler_t and
	use if present
In-Reply-To: <20190318032330.3346-1-petr.vorel@gmail.com>
References: <20190318032330.3346-1-petr.vorel@gmail.com>
Message-ID: <20190318032330.3346-2-petr.vorel@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

__sighandler_t is libc implementation specific and should not be relied
upon. Instead, we fall back upon void (*)(int), as specified by POSIX.

This fixes MUSL build.

Credits: taken from util-linux

Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
---
 include/lapi/rt_sigaction.h | 8 ++++++++
 m4/ltp-sighandler_t.m4      | 8 ++++++++
 2 files changed, 16 insertions(+)
 create mode 100644 m4/ltp-sighandler_t.m4

diff --git a/include/lapi/rt_sigaction.h b/include/lapi/rt_sigaction.h
index 2dbbc7672..ff1a7314d 100644
--- a/include/lapi/rt_sigaction.h
+++ b/include/lapi/rt_sigaction.h
@@ -36,12 +36,20 @@
 #if defined(__mips__)
 struct kernel_sigaction {
 	unsigned int sa_flags;
+# ifdef HAVE_SIGHANDLER_T
 	__sighandler_t k_sa_handler;
+# else
+void (* k_sa_handler)(int);
+# endif
 	sigset_t sa_mask;
 };
 #else
 struct kernel_sigaction {
+# ifdef HAVE_SIGHANDLER_T
 	__sighandler_t k_sa_handler;
+# else
+void (* k_sa_handler)(int);
+# endif
 	unsigned long sa_flags;
 	void (*sa_restorer) (void);
 	sigset_t sa_mask;
diff --git a/m4/ltp-sighandler_t.m4 b/m4/ltp-sighandler_t.m4
new file mode 100644
index 000000000..97c70a269
--- /dev/null
+++ b/m4/ltp-sighandler_t.m4
@@ -0,0 +1,8 @@
+dnl SPDX-License-Identifier: GPL-2.0-or-later
+dnl Copyright (c) 2019 Petr Vorel <petr.vorel@gmail.com>
+
+AC_DEFUN([LTP_CHECK_SIGHANDLER_T],[
+AC_CHECK_TYPES([sighandler_t], [], [], [[
+#include <signal.h>
+]])
+])
-- 
2.20.1

