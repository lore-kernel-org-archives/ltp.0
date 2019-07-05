From: Li Wang <liwang@redhat.com>
Date: Fri,  5 Jul 2019 13:16:03 +0800
Subject: [LTP] [PATCH v3] lib: add tst_no_corefile()
Message-ID: <20190705051603.24599-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Adds a simple helper to avoid corefile dump.

If crash is expected in a testcase, we can avoid dumping core file
in calling this function.

Signed-off-by: Li Wang <liwang@redhat.com>
Cc: Jan Stancek <jstancek@redhat.com>
---
 doc/test-writing-guidelines.txt               | 12 +++++-
 include/tst_coredump.h                        | 18 +++++++++
 include/tst_test.h                            |  1 +
 lib/tst_coredump.c                            | 40 +++++++++++++++++++
 .../kernel/security/umip/umip_basic_test.c    |  2 +
 testcases/kernel/syscalls/ipc/shmat/shmat01.c | 16 ++------
 6 files changed, 74 insertions(+), 15 deletions(-)
 create mode 100644 include/tst_coredump.h
 create mode 100644 lib/tst_coredump.c

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index c6d4e001d..a0f9cea71 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -826,8 +826,8 @@ The 'TST_PROCESS_STATE_WAIT()' waits until process 'pid' is in requested
 It's mostly used with state 'S' which means that process is sleeping in kernel
 for example in 'pause()' or any other blocking syscall.
 
-2.2.10 Signal handlers
-^^^^^^^^^^^^^^^^^^^^^^
+2.2.10 Signals and signal handlers
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
 If you need to use signal handlers, keep the code short and simple. Don't
 forget that the signal handler is called asynchronously and can interrupt the
@@ -859,6 +859,14 @@ type defined in C99 but this one *DOES NOT* imply 'volatile' (it's just a
 'typedef' to 'int'). So the correct type for a flag that is changed from a
 signal handler is either 'volatile int' or 'volatile sig_atomic_t'.
 
+If a crash (e.g. triggered by signal SIGSEGV) is expected in testing, you
+can avoid creation of core files by calling tst_no_corefile() function.
+This takes effect for process (and its children) which invoked it, unless
+they subsequently modify RLIMIT_CORE.
+
+Note that LTP library will reap any processes that test didn't reap itself,
+and report any non-zero exit code as failure.
+
 2.2.11 Kernel Modules
 ^^^^^^^^^^^^^^^^^^^^^
 
diff --git a/include/tst_coredump.h b/include/tst_coredump.h
new file mode 100644
index 000000000..e1f892544
--- /dev/null
+++ b/include/tst_coredump.h
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2019 Red Hat, Inc.
+ */
+
+#ifndef TST_COREDUMP__
+#define TST_COREDUMP__
+
+/*
+ * If crash is expected, avoid dumping corefile.
+ * 1 is a special value, that disables core-to-pipe.
+ * At the same time it is small enough value for
+ * core-to-file, so it skips creating cores as well.
+ */
+void tst_no_corefile(int verbose);
+
+#endif /* TST_COREDUMP_H */
+
diff --git a/include/tst_test.h b/include/tst_test.h
index 2e8e36352..b50e88b60 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -33,6 +33,7 @@
 #include "tst_get_bad_addr.h"
 #include "tst_path_has_mnt_flags.h"
 #include "tst_sys_conf.h"
+#include "tst_coredump.h"
 
 /*
  * Reports testcase result.
diff --git a/lib/tst_coredump.c b/lib/tst_coredump.c
new file mode 100644
index 000000000..907c06dca
--- /dev/null
+++ b/lib/tst_coredump.c
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2019 Red Hat, Inc.
+ */
+
+#define TST_NO_DEFAULT_MAIN
+
+#include <sys/time.h>
+#include <sys/resource.h>
+
+#include "tst_test.h"
+#include "tst_coredump.h"
+
+void tst_no_corefile(int verbose)
+{
+	struct rlimit new_r, old_r;
+
+	new_r.rlim_cur = 1;
+	new_r.rlim_max = 1;
+
+	if (setrlimit(RLIMIT_CORE, &new_r) == -1) {
+		if (getrlimit(RLIMIT_CORE, &old_r) == -1) {
+			tst_res(TWARN | TERRNO,
+				"Failed to disable core dump, "
+				"getrlimit failed in process(%d)",
+				getpid());
+			return;
+		}
+
+		tst_res(TWARN,
+			"Failed to disable core dump in process(pid=%d), "
+			"current limits: soft=%lld; hard=%lld", getpid(),
+			(long long) old_r.rlim_cur,
+			(long long) old_r.rlim_max);
+		return;
+	}
+
+	if (verbose)
+		tst_res(TINFO, "Avoid dumping corefile for process(pid=%d)", getpid());
+}
diff --git a/testcases/kernel/security/umip/umip_basic_test.c b/testcases/kernel/security/umip/umip_basic_test.c
index c34d4a1f6..37850ef9f 100644
--- a/testcases/kernel/security/umip/umip_basic_test.c
+++ b/testcases/kernel/security/umip/umip_basic_test.c
@@ -86,6 +86,8 @@ static void verify_umip_instruction(unsigned int n)
 
 	pid = SAFE_FORK();
 	if (pid == 0) {
+		tst_no_corefile(0);
+
 		switch (n) {
 		case 0:
 			asm_sgdt();
diff --git a/testcases/kernel/syscalls/ipc/shmat/shmat01.c b/testcases/kernel/syscalls/ipc/shmat/shmat01.c
index aa9dfd4e5..f75914799 100644
--- a/testcases/kernel/syscalls/ipc/shmat/shmat01.c
+++ b/testcases/kernel/syscalls/ipc/shmat/shmat01.c
@@ -59,19 +59,9 @@ static void *expected_addr(void *in_addr, void *out_addr)
 
 static void do_child(int *in_addr, int expect_crash)
 {
-	if (expect_crash) {
-		/*
-		 * Crash is expected, avoid dumping corefile.
-		 * 1 is a special value, that disables core-to-pipe.
-		 * At the same time it is small enough value for
-		 * core-to-file, so it skips creating cores as well.
-		*/
-		struct rlimit r;
-
-		r.rlim_cur = 1;
-		r.rlim_max = 1;
-		SAFE_SETRLIMIT(RLIMIT_CORE, &r);
-	}
+	if (expect_crash)
+		tst_no_corefile(1);
+
 	*in_addr = 10;
 
 	exit(0);
-- 
2.20.1

