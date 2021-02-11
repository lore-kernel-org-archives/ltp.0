From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Thu, 11 Feb 2021 11:03:16 +0000
Subject: [LTP] [PATCH 4/5] API: Add tst_clone
In-Reply-To: <20210211110317.31942-1-rpalethorpe@suse.com>
References: <20210211110317.31942-1-rpalethorpe@suse.com>
Message-ID: <20210211110317.31942-5-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The raw clone system call and clone3 have relatively simple interfaces
if the stack pointer is set to NULL. The libc wrapper complicates
things hugely. So introduce an interface similar to clone3, but that
falls back to clone.

Not all features of clone3 are implemented in clone, but we could
either return TCONF or implement them in user land.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 include/tst_clone.h | 28 +++++++++++++++++++++++++++
 include/tst_test.h  |  2 +-
 lib/tst_clone.c     | 46 +++++++++++++++++++++++++++++++++++++++++++++
 lib/tst_test.c      | 25 ++++++++++++++++++++++++
 4 files changed, 100 insertions(+), 1 deletion(-)
 create mode 100644 lib/tst_clone.c

diff --git a/include/tst_clone.h b/include/tst_clone.h
index 88188525d..9ffdc68d1 100644
--- a/include/tst_clone.h
+++ b/include/tst_clone.h
@@ -5,6 +5,34 @@
 #ifndef TST_CLONE_H__
 #define TST_CLONE_H__
 
+#ifdef TST_TEST_H__
+
+/* The parts of clone3's clone_args we support */
+struct tst_clone_args {
+	uint64_t flags;
+	uint64_t exit_signal;
+};
+
+/* clone3 with fallbacks to clone when possible. Be aware that it
+ * returns -1 if clone3 fails (except ENOSYS), but -2 if clone fails.
+ *
+ * Without CLONE_VM this acts like fork so you may want to set
+ * tst_test.forks_child (safe_clone requires this).
+ *
+ * You should set exit_signal to SIGCHLD for
+ * tst_reap_children. Otherwise you must call wait with the
+ * appropriate parameters.
+ */
+pid_t tst_clone(const struct tst_clone_args *args);
+
+pid_t safe_clone(const char *file, const int lineno,
+		 const struct tst_clone_args *args);
+
+/* "Safe" version of tst_clone */
+#define SAFE_CLONE(args) safe_clone(__FILE__, __LINE__, args)
+
+#endif	/* TST_TEST_H__ */
+
 /* Functions from lib/cloner.c */
 int ltp_clone(unsigned long flags, int (*fn)(void *arg), void *arg,
 		size_t stack_size, void *stack);
diff --git a/include/tst_test.h b/include/tst_test.h
index c87251870..7dab5f761 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -29,7 +29,6 @@
 #include "tst_process_state.h"
 #include "tst_atomic.h"
 #include "tst_kvercmp.h"
-#include "tst_clone.h"
 #include "tst_kernel.h"
 #include "tst_minmax.h"
 #include "tst_get_bad_addr.h"
@@ -94,6 +93,7 @@ pid_t safe_fork(const char *filename, unsigned int lineno);
 #include "tst_safe_macros.h"
 #include "tst_safe_file_ops.h"
 #include "tst_safe_net.h"
+#include "tst_clone.h"
 
 /*
  * Wait for all children and exit with TBROK if
diff --git a/lib/tst_clone.c b/lib/tst_clone.c
new file mode 100644
index 000000000..07e7f0767
--- /dev/null
+++ b/lib/tst_clone.c
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Copyright (c) 2021 SUSE LLC
+ * Richard Palethorpe <rpalethorpe@suse.com>
+ */
+
+#define TST_NO_DEFAULT_MAIN
+
+#include <stddef.h>
+
+#include "tst_test.h"
+#include "lapi/clone.h"
+
+pid_t tst_clone(const struct tst_clone_args *tst_args)
+{
+	struct clone_args args = {
+		.flags = tst_args->flags,
+		.exit_signal = tst_args->exit_signal,
+	};
+	int flags;
+	pid_t pid = -1;
+
+	tst_flush();
+
+	errno = ENOSYS;
+	if (__NR_clone3 != __LTP__NR_INVALID_SYSCALL)
+		pid = syscall(__NR_clone3, &args, sizeof(args));
+
+	if (pid == -1 && errno != ENOSYS)
+		return -1;
+
+	if (pid != -1)
+		return pid;
+
+	flags = args.exit_signal | args.flags;
+
+#ifdef __s390x__
+	pid = syscall(__NR_clone, NULL, flags);
+#else
+	pid = syscall(__NR_clone, flags, NULL);
+#endif
+
+	if (pid == -1)
+		return -2;
+
+	return pid;
+}
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 0714f0a0e..6bbee030b 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -424,6 +424,31 @@ pid_t safe_fork(const char *filename, unsigned int lineno)
 	return pid;
 }
 
+pid_t safe_clone(const char *file, const int lineno,
+		 const struct tst_clone_args *args)
+{
+	pid_t pid;
+
+	if (!tst_test->forks_child)
+		tst_brk(TBROK, "test.forks_child must be set!");
+
+	pid = tst_clone(args);
+
+	switch (pid) {
+	case -1:
+		tst_brk_(file, lineno, TBROK | TERRNO, "clone3 failed");
+		break;
+	case -2:
+		tst_brk_(file, lineno, TBROK | TERRNO, "clone failed");
+		return -1;
+	}
+
+	if (!pid)
+		atexit(tst_free_all);
+
+	return pid;
+}
+
 static struct option {
 	char *optstr;
 	char *help;
-- 
2.30.0

