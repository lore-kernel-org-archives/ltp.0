From: Matthias Maennich <maennich@google.com>
Date: Fri,  8 Mar 2019 16:38:32 +0000
Subject: [LTP] [PATCH v1] rt_sigpending02: reuse code from sigpending02
Message-ID: <20190308163832.212631-1-maennich@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Rather than forking the code of sigpending02 completely, reuse its code
for rt_sigpending02 by conditionally compiling the syscalls accordingly.

That way we ensure tests written for either rt_sigpending or sigpending
are also considered for the respective other.

Signed-off-by: Matthias Maennich <maennich@google.com>
---
 .../kernel/syscalls/rt_sigpending/Makefile    |  8 ++++
 .../syscalls/rt_sigpending/rt_sigpending02.c  | 48 -------------------
 testcases/kernel/syscalls/sigpending/Makefile |  2 +
 .../kernel/syscalls/sigpending/sigpending02.c | 16 +++++--
 4 files changed, 23 insertions(+), 51 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/rt_sigpending/rt_sigpending02.c

diff --git a/testcases/kernel/syscalls/rt_sigpending/Makefile b/testcases/kernel/syscalls/rt_sigpending/Makefile
index 60c2e0140d85..57ba3dac2e41 100644
--- a/testcases/kernel/syscalls/rt_sigpending/Makefile
+++ b/testcases/kernel/syscalls/rt_sigpending/Makefile
@@ -4,4 +4,12 @@
 top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
+
+CPPFLAGS += -DTEST_RT_SIGPENDING
+
+rt_sigpending02: $(abs_srcdir)/../sigpending/sigpending02.c
+	$(LINK.c) $^ $(LOADLIBES) $(LDLIBS) $(OUTPUT_OPTION)
+
+MAKE_TARGETS := rt_sigpending02
+
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/rt_sigpending/rt_sigpending02.c b/testcases/kernel/syscalls/rt_sigpending/rt_sigpending02.c
deleted file mode 100644
index 06d1c1578f4d..000000000000
--- a/testcases/kernel/syscalls/rt_sigpending/rt_sigpending02.c
+++ /dev/null
@@ -1,48 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- *  Copyright (c) International Business Machines  Corp., 2002
- *
- * AUTHORS
- *	Paul Larson
- *
- * DESCRIPTION
- *	Test to see that the proper errors are returned by rt_sigpending
- *
- *	Test 1:
- *		Call rt_sigpending(sigset_t*=-1, SIGSETSIZE),
- *		it should return -1 with errno EFAULT
- */
-
-#include <errno.h>
-#include <signal.h>
-#include <sys/types.h>
-
-#include "tst_test.h"
-#include "ltp_signal.h"
-#include "lapi/syscalls.h"
-
-static void run(void)
-{
-	/* set sigset to point to an invalid location */
-	sigset_t *sigset = (sigset_t *) - 1;
-
-	TEST(tst_syscall(__NR_rt_sigpending, sigset, SIGSETSIZE));
-
-	/* check return code */
-	if (TST_RET == -1) {
-		if (TST_ERR != EFAULT) {
-			tst_res(TFAIL | TTERRNO,
-				"rt_sigpending() Failed with wrong errno, "
-				"expected errno=%d, got ", EFAULT);
-		} else {
-			tst_res(TPASS | TTERRNO, "expected failure");
-		}
-	} else {
-		tst_res(TFAIL,
-			"rt_sigpending() Failed, expected return value=-1, got %ld", TST_RET);
-	}
-}
-
-static struct tst_test test = {
-	.test_all = run
-};
diff --git a/testcases/kernel/syscalls/sigpending/Makefile b/testcases/kernel/syscalls/sigpending/Makefile
index bd617d806675..00a7d5e2b538 100644
--- a/testcases/kernel/syscalls/sigpending/Makefile
+++ b/testcases/kernel/syscalls/sigpending/Makefile
@@ -20,4 +20,6 @@ top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 
+CPPFLAGS += -DTEST_SIGPENDING
+
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/sigpending/sigpending02.c b/testcases/kernel/syscalls/sigpending/sigpending02.c
index e7ec0d6819bd..cc50870b107a 100644
--- a/testcases/kernel/syscalls/sigpending/sigpending02.c
+++ b/testcases/kernel/syscalls/sigpending/sigpending02.c
@@ -6,7 +6,10 @@
  *	Paul Larson
  *
  * DESCRIPTION
- *	Test to see that the proper errors are returned by sigpending
+ *	Test to see that the proper errors are returned by sigpending. All the
+ *	tests can also be compiled to use the rt_sigpending syscall instead. To
+ *	simplify the documentation, only sigpending() is usually mentioned
+ *	below.
  *
  *	Test 1:
  *		Call sigpending(sigset_t*=-1), it should return -1 with errno EFAULT
@@ -17,6 +20,7 @@
 #include <sys/types.h>
 
 #include "tst_test.h"
+#include "ltp_signal.h"
 #include "lapi/syscalls.h"
 
 static void run(void)
@@ -24,20 +28,26 @@ static void run(void)
 	/* set sigset to point to an invalid location */
 	sigset_t *sigset = (sigset_t *) - 1;
 
+#if defined(TEST_SIGPENDING)
 	TEST(tst_syscall(__NR_sigpending, sigset));
+#elif defined(TEST_RT_SIGPENDING)
+	TEST(tst_syscall(__NR_rt_sigpending, sigset, SIGSETSIZE));
+#else
+#error Neither TEST_SIGPENDING nor TEST_RT_SIGPENDING is defined!
+#endif
 
 	/* check return code */
 	if (TST_RET == -1) {
 		if (TST_ERR != EFAULT) {
 			tst_res(TFAIL | TTERRNO,
-				"sigpending() Failed with wrong errno, "
+				"syscall failed with wrong errno, "
 				"expected errno=%d, got ", EFAULT);
 		} else {
 			tst_res(TPASS | TTERRNO, "expected failure");
 		}
 	} else {
 		tst_res(TFAIL,
-			"sigpending() Failed, expected return value=-1, got %ld", TST_RET);
+			"syscall failed, expected return value=-1, got %ld", TST_RET);
 	}
 }
 
-- 
2.21.0.360.g471c308f928-goog

