From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Fri, 5 Apr 2019 11:09:53 +0800
Subject: [LTP] [PATCH v2 3/3] syscalls/sigpending02.c: Add libc sigpending()
	detection && reset sighandler_counter
In-Reply-To: <1554433793-19702-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1554433793-19702-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <1554433793-19702-3-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1) bionic(Android libc) doesn't implement libc sigpending() currently,
   so we can skip it on Android by the detection.

2) Fix sigpending02 -i n by resetting sighandler_counter variable.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 m4/ltp-libc-funcs.m4                                | 1 +
 testcases/kernel/syscalls/sigpending/sigpending02.c | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/m4/ltp-libc-funcs.m4 b/m4/ltp-libc-funcs.m4
index 5b3f1ed..3ac9fc8 100644
--- a/m4/ltp-libc-funcs.m4
+++ b/m4/ltp-libc-funcs.m4
@@ -26,6 +26,7 @@ AC_CHECK_FUNCS([ \
 	readlinkat \
 	renameat \
 	renameat2 \
+	sigpending \
 	splice \
 	stime \
 	syncfs \
diff --git a/testcases/kernel/syscalls/sigpending/sigpending02.c b/testcases/kernel/syscalls/sigpending/sigpending02.c
index ce0d2ff..fd219aa 100644
--- a/testcases/kernel/syscalls/sigpending/sigpending02.c
+++ b/testcases/kernel/syscalls/sigpending/sigpending02.c
@@ -13,6 +13,7 @@
  * Test 2: Call sigpending(sigset_t*=-1), it should return -1 with errno EFAULT.
  */
 
+#include "config.h"
 #include "tst_test.h"
 #include "ltp_signal.h"
 #include "lapi/syscalls.h"
@@ -36,7 +37,11 @@ static int tested_sigpending(sigset_t *sigset)
 {
 	switch (tst_variant) {
 	case 0:
+#ifndef HAVE_SIGPENDING
+		tst_brk(TCONF, "libc sigpending() is not implemented");
+#else
 		return sigpending(sigset);
+#endif
 	break;
 	case 1:
 		return tst_syscall(__NR_sigpending, sigset);
@@ -60,6 +65,8 @@ static void test_sigpending(void)
 
 	int i; /* loop index */
 
+	sighandler_counter = 0;
+
 	/* set up signal mask and handler */
 	sigset_t only_SIGUSR, old_mask;
 	sighandler_t old_sighandler1, old_sighandler2;
-- 
1.8.3.1



