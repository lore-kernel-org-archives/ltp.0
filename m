From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 29 Oct 2020 15:27:43 +0100
Subject: [LTP] [PATCH] [COMMITTED] openposix: Fix two test failures
Message-ID: <20201029142743.11871-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Two testcases started to fail after the patch that added static modifier
to all global varibles. The cause was simple in these tests a variable
is changed in a signal handler while the value is used in a conditional
in the main loop. This code was incorrect to begin with, but the global
visibility avoided compiler optimizations to assume anything about the
variable value so it wasn't optimized out. Because of that it started to
fail only as a side efect of the patch.

The fix is also simple, all variables changed asynchrounously from a
signal handler has to be volatile.

Fixes: 8c22a59107dc (openposix: add "static" to all global variables and functions)
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 .../conformance/interfaces/pthread_atfork/3-3.c                 | 2 +-
 .../open_posix_testsuite/conformance/interfaces/sigqueue/5-1.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_atfork/3-3.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_atfork/3-3.c
index d34f5706f..2a3d6c47c 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_atfork/3-3.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_atfork/3-3.c
@@ -77,7 +77,7 @@
 /*****************************    Test case   *********************************/
 /******************************************************************************/
 
-static char do_it = 1;
+static volatile char do_it = 1;
 static unsigned long count_ope = 0;
 #ifdef WITH_SYNCHRO
 static sem_t semsig1;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigqueue/5-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sigqueue/5-1.c
index 3ca4b663c..a38897086 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigqueue/5-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigqueue/5-1.c
@@ -29,7 +29,7 @@
 #include <errno.h>
 #include "posixtest.h"
 
-static int counter = 0;
+static volatile int counter = 0;
 
 static void myhandler(int signo LTP_ATTRIBUTE_UNUSED)
 {
-- 
2.26.2

