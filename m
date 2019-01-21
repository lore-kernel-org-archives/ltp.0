From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Mon, 21 Jan 2019 15:18:29 +0800
Subject: [LTP] [PATCH v2] openposix/20-1-buildonly: Remove test for sigstack
	structure
In-Reply-To: <5C3EF3A1.30503@cn.fujitsu.com>
References: <5C3EF3A1.30503@cn.fujitsu.com>
Message-ID: <1548055109-4960-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Since glibc 2.26, the __USE_XOPEN2K8 macro defined by default _POSIX_C_SOURCE = 200809L
&& _XOPEN_SOURCE = 700 in CFLAGS triggered the following compiler errors, because both
sigstack structure and bsd_signal function are only declared if __USE_XOPEN_EXTENDED is
defined and __USE_XOPEN2K8 is not defined:
-------------------------------------------------------------------------------
20-1-buildonly.c:13:8: error: invalid use of undefined type 'struct sigstack'
  sp = t.ss_sp;
...
signal_h/23-1.c:15:13: error: 'bsd_signal' undeclared (first use in this function); did you mean 'psignal'?
  dummyvar = bsd_signal;
-------------------------------------------------------------------------------

signal_h/23-1.c has been removed by commit d256a97, so just remove obsolete
signal_h/20-1-buildonly.c as well.

References:
https://sourceware.org/git/?p=glibc.git;a=commit;h=666c0c5efa6db73632a6894bf028fef9f3b60d71
https://sourceware.org/git/?p=glibc.git;a=commit;h=4c3992fc459322a7c712700ba3244fcb125163d7

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 .../conformance/definitions/signal_h/20-1-buildonly.c   | 17 -----------------
 1 file changed, 17 deletions(-)
 delete mode 100644 testcases/open_posix_testsuite/conformance/definitions/signal_h/20-1-buildonly.c

diff --git a/testcases/open_posix_testsuite/conformance/definitions/signal_h/20-1-buildonly.c b/testcases/open_posix_testsuite/conformance/definitions/signal_h/20-1-buildonly.c
deleted file mode 100644
index 21d8cb4..0000000
--- a/testcases/open_posix_testsuite/conformance/definitions/signal_h/20-1-buildonly.c
+++ /dev/null
@@ -1,17 +0,0 @@
-  /*
-     Test the definition of sigstack.
-   */
-
-#include <signal.h>
-
-struct sigstack this_type_should_exist, t;
-int onstack;
-void *sp;
-
-int dummyfcn(void)
-{
-	sp = t.ss_sp;
-	onstack = t.ss_onstack;
-
-	return 0;
-}
-- 
1.8.3.1



