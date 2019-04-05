From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Fri, 5 Apr 2019 16:07:40 +0800
Subject: [LTP] [PATCH v3 3/3] syscalls/sigpending02.c: Add libc sigpending()
	detection && reset sighandler_counter
In-Reply-To: <1554451660-30245-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1554451660-30245-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <1554451660-30245-3-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1) bionic(Android libc) doesn't implement libc sigpending() currently,
   so we can skip it on Android by the detection.  Also add break to
   avoid potential compiler warnings.

2) Fix sigpending02 -i n by resetting sighandler_counter variable.

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 configure.ac                                        | 1 +
 testcases/kernel/syscalls/sigpending/sigpending02.c | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/configure.ac b/configure.ac
index 4208ae7..de12499 100644
--- a/configure.ac
+++ b/configure.ac
@@ -77,6 +77,7 @@ AC_CHECK_FUNCS([ \
     readlinkat \
     renameat \
     renameat2 \
+    sigpending \
     splice \
     stime \
     syncfs \
diff --git a/testcases/kernel/syscalls/sigpending/sigpending02.c b/testcases/kernel/syscalls/sigpending/sigpending02.c
index d75807d..0a1ba25 100644
--- a/testcases/kernel/syscalls/sigpending/sigpending02.c
+++ b/testcases/kernel/syscalls/sigpending/sigpending02.c
@@ -13,6 +13,7 @@
  * Test 2: Call sigpending(sigset_t*=-1), it should return -1 with errno EFAULT.
  */
 
+#include "config.h"
 #include "tst_test.h"
 #include "ltp_signal.h"
 #include "lapi/syscalls.h"
@@ -36,7 +37,12 @@ static int tested_sigpending(sigset_t *sigset)
 {
 	switch (tst_variant) {
 	case 0:
+#ifndef HAVE_SIGPENDING
+		tst_brk(TCONF, "libc sigpending() is not implemented");
+#else
 		return sigpending(sigset);
+#endif
+		break;
 	case 1:
 		return tst_syscall(__NR_sigpending, sigset);
 	case 2:
@@ -57,6 +63,8 @@ static void test_sigpending(void)
 
 	int i; /* loop index */
 
+	sighandler_counter = 0;
+
 	/* set up signal mask and handler */
 	sigset_t only_SIGUSR, old_mask;
 	sighandler_t old_sighandler1, old_sighandler2;
-- 
1.8.3.1



