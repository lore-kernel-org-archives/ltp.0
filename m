From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon,  9 Nov 2020 13:30:49 +0100
Subject: [LTP] [PATCH] [COMMITTED] openposix: Fix (hopefully) last two
 failures
Message-ID: <20201109123049.13421-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This is a continuation of:

commit 38cc030092a54067a9f08dea0173a0d032a15820
Author: Cyril Hrubis <chrubis@suse.cz>
Date:   Thu Oct 29 15:16:30 2020 +0100

    openposix: Fix two test failures

Hopefully this is a last two, but there may be more cases where we
haven't hit compiler optimization triggering the bug yet.

Fixes: 8c22a59107dc (openposix: add "static" to all global variables and functions)
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 .../conformance/interfaces/pthread_kill/8-1.c                   | 2 +-
 .../open_posix_testsuite/conformance/interfaces/sigwait/6-1.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_kill/8-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_kill/8-1.c
index f71c02c93..bc0138bd5 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_kill/8-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_kill/8-1.c
@@ -75,7 +75,7 @@
 /***********************************    Test cases  *****************************************/
 /********************************************************************************************/
 
-static char do_it = 1;
+static volatile char do_it = 1;
 static unsigned long count_ope = 0;
 #ifdef WITH_SYNCHRO
 static sem_t semsig1;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigwait/6-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sigwait/6-1.c
index 826eb2776..3b9004635 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigwait/6-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigwait/6-1.c
@@ -81,7 +81,7 @@
 /***************************    Test case   ***********************************/
 /******************************************************************************/
 
-static int n_awaken = 0;
+static volatile int n_awaken = 0;
 static sigset_t setusr;
 
 /* Thread function */
-- 
2.26.2

