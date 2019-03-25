From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 25 Mar 2019 16:14:38 +0100
Subject: [LTP] [PATCH 1/1] sigpending: Use 3 variants via test_multiplex()
Message-ID: <20190325151438.3712-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

We're now testing sigpending() libc wrapper, __NR_sigpending and
__NR_rt_sigpending syscalls.

This brings again testing libc sigpending() implementation, which was
removed in
63f8a3f77 ("sigpending: use direct syscall")

and removes sharing code and directory rt_sigpending introduced in
b03885fff ("rt_sigpending02: reuse code from sigpending02")

+ removed unused headers.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

this patch expects Cyril's multiplex function [1] be merged.

Kind regards,
Petr

[1] https://patchwork.ozlabs.org/project/ltp/list/?series=98725&state=*
---
 runtest/syscalls                              |  1 -
 .../kernel/syscalls/rt_sigpending/.gitignore  |  1 -
 .../kernel/syscalls/rt_sigpending/Makefile    | 15 ----
 .../kernel/syscalls/sigpending/sigpending02.c | 74 +++++++++++--------
 4 files changed, 44 insertions(+), 47 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/rt_sigpending/.gitignore
 delete mode 100644 testcases/kernel/syscalls/rt_sigpending/Makefile

diff --git a/runtest/syscalls b/runtest/syscalls
index a13d51918..e52f80bef 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1001,7 +1001,6 @@ rmdir03A symlink01 -T rmdir03
 rt_sigaction01 rt_sigaction01
 rt_sigaction02 rt_sigaction02
 rt_sigaction03 rt_sigaction03
-rt_sigpending02 rt_sigpending02
 rt_sigprocmask01 rt_sigprocmask01
 rt_sigprocmask02 rt_sigprocmask02
 rt_sigqueueinfo01 rt_sigqueueinfo01
diff --git a/testcases/kernel/syscalls/rt_sigpending/.gitignore b/testcases/kernel/syscalls/rt_sigpending/.gitignore
deleted file mode 100644
index 85905fc83..000000000
--- a/testcases/kernel/syscalls/rt_sigpending/.gitignore
+++ /dev/null
@@ -1 +0,0 @@
-/rt_sigpending02
diff --git a/testcases/kernel/syscalls/rt_sigpending/Makefile b/testcases/kernel/syscalls/rt_sigpending/Makefile
deleted file mode 100644
index 57ba3dac2..000000000
--- a/testcases/kernel/syscalls/rt_sigpending/Makefile
+++ /dev/null
@@ -1,15 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-or-later
-# Copyright (c) 2019, Linux Test Project
-
-top_srcdir		?= ../../../..
-
-include $(top_srcdir)/include/mk/testcases.mk
-
-CPPFLAGS += -DTEST_RT_SIGPENDING
-
-rt_sigpending02: $(abs_srcdir)/../sigpending/sigpending02.c
-	$(LINK.c) $^ $(LOADLIBES) $(LDLIBS) $(OUTPUT_OPTION)
-
-MAKE_TARGETS := rt_sigpending02
-
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/sigpending/sigpending02.c b/testcases/kernel/syscalls/sigpending/sigpending02.c
index 94e51bb16..ce0d2ff79 100644
--- a/testcases/kernel/syscalls/sigpending/sigpending02.c
+++ b/testcases/kernel/syscalls/sigpending/sigpending02.c
@@ -1,40 +1,52 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- *  Copyright (c) International Business Machines  Corp., 2002
+ * Copyright (c) International Business Machines  Corp., 2002
+ * Copyright (c) Linux Test Project, 2009-2019
  *
  * AUTHORS
- *	Paul Larson
- *	Matthias Maennich
+ * Paul Larson
+ * Matthias Maennich
  *
  * DESCRIPTION
- *	Test to assert basic functionality of sigpending. All the tests can also be
- *	compiled to use the rt_sigpending syscall instead. To simplify the
- *	documentation, only sigpending() is usually mentioned below.
- *
- *	Test 1:
- *		Suppress handling SIGUSR1 and SIGUSR1, raise them and assert their
- *		signal pending.
- *
- *	Test 2:
- *		Call sigpending(sigset_t*=-1), it should return -1 with errno EFAULT
+ * Test 1: Suppress handling SIGUSR1 and SIGUSR1, raise them and assert their
+ * signal pending.
+ * Test 2: Call sigpending(sigset_t*=-1), it should return -1 with errno EFAULT.
  */
 
-#include <errno.h>
-#include <signal.h>
-#include <sys/types.h>
-
 #include "tst_test.h"
 #include "ltp_signal.h"
 #include "lapi/syscalls.h"
 
-#if defined(TEST_SIGPENDING)
-#define tested_sigpending(sigset) TEST(tst_syscall(__NR_sigpending, sigset))
-#elif defined(TEST_RT_SIGPENDING)
-#define tested_sigpending(sigset)                                              \
-	TEST(tst_syscall(__NR_rt_sigpending, sigset, SIGSETSIZE))
-#else
-#error Neither TEST_SIGPENDING nor TEST_RT_SIGPENDING is defined!
-#endif
+static void sigpending_info(void)
+{
+	switch (tst_variant) {
+	case 0:
+		tst_res(TINFO, "Testing libc sigpending()");
+	break;
+	case 1:
+		tst_res(TINFO, "Testing __NR_sigpending syscall");
+	break;
+	case 2:
+		tst_res(TINFO, "Testing __NR_rt_sigpending syscall");
+	break;
+	}
+}
+
+static int tested_sigpending(sigset_t *sigset)
+{
+	switch (tst_variant) {
+	case 0:
+		return sigpending(sigset);
+	break;
+	case 1:
+		return tst_syscall(__NR_sigpending, sigset);
+	break;
+	case 2:
+		return tst_syscall(__NR_rt_sigpending, sigset, SIGSETSIZE);
+	break;
+	}
+	return -1;
+}
 
 static int sighandler_counter;
 static void sighandler(int signum LTP_ATTRIBUTE_UNUSED)
@@ -62,7 +74,7 @@ static void test_sigpending(void)
 	/* Initially no signal should be pending */
 	sigset_t pending;
 	sigemptyset(&pending);
-	tested_sigpending(&pending);
+	TEST(tested_sigpending(&pending));
 
 	for (i = 1; i < SIGMAX; ++i)
 		if (sigismember(&pending, i))
@@ -78,7 +90,7 @@ static void test_sigpending(void)
 
 	/* now we should have exactly one pending signal (SIGUSR1) */
 	sigemptyset(&pending);
-	tested_sigpending(&pending);
+	TEST(tested_sigpending(&pending));
 	for (i = 1; i < SIGMAX; ++i)
 		if ((i == SIGUSR1) != sigismember(&pending, i))
 			tst_brk(TFAIL, "only SIGUSR1 should be pending by now");
@@ -92,7 +104,7 @@ static void test_sigpending(void)
 
 	/* now we should have exactly two pending signals (SIGUSR1, SIGUSR2) */
 	sigemptyset(&pending);
-	tested_sigpending(&pending);
+	TEST(tested_sigpending(&pending));
 	for (i = 1; i < SIGMAX; ++i)
 		if ((i == SIGUSR1 || i == SIGUSR2) != sigismember(&pending, i))
 			tst_brk(TFAIL,
@@ -119,7 +131,7 @@ static void test_efault_on_invalid_sigset(void)
 	/* set sigset to point to an invalid location */
 	sigset_t *sigset = tst_get_bad_addr(NULL);
 
-	tested_sigpending(sigset);
+	TEST(tested_sigpending(sigset));
 
 	/* check return code */
 	if (TST_RET == -1) {
@@ -139,10 +151,12 @@ static void test_efault_on_invalid_sigset(void)
 
 static void run(void)
 {
+	sigpending_info();
 	test_sigpending();
 	test_efault_on_invalid_sigset();
 }
 
 static struct tst_test test = {
-	.test_all = run
+	.test_all = run,
+	.test_variants = 3,
 };
-- 
2.21.0

