From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue,  3 Nov 2020 14:18:13 +0100
Subject: [LTP] [PATCH] [COMMITTED] openposix: Fix another three failures
Message-ID: <20201103131813.9098-1-chrubis@suse.cz>
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

Where I missed three more testcases that depended on variable being
changed from a different thread or signal handler.

Fixes: 8c22a59107dc (openposix: add "static" to all global variables and functions)
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 .../conformance/interfaces/pthread_setschedparam/5-1.c          | 2 +-
 .../conformance/interfaces/pthread_sigmask/18-1.c               | 2 +-
 .../conformance/interfaces/sem_unlink/9-1.c                     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_setschedparam/5-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_setschedparam/5-1.c
index 52b7ff629..db155d033 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_setschedparam/5-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_setschedparam/5-1.c
@@ -76,7 +76,7 @@
 /*****************************    Test case   *********************************/
 /******************************************************************************/
 
-static char do_it = 1;
+static volatile char do_it = 1;
 static unsigned long count_ope = 0;
 #ifdef WITH_SYNCHRO
 static sem_t semsig1;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_sigmask/18-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_sigmask/18-1.c
index 0617210bf..7e2906c7d 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_sigmask/18-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_sigmask/18-1.c
@@ -75,7 +75,7 @@
 /***********************************    Test cases  *****************************************/
 /********************************************************************************************/
 
-static char do_it = 1;
+static volatile char do_it = 1;
 static unsigned long count_ope = 0;
 #ifdef WITH_SYNCHRO
 static sem_t semsig1;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sem_unlink/9-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sem_unlink/9-1.c
index 288f1224f..24a575ff9 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sem_unlink/9-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sem_unlink/9-1.c
@@ -82,7 +82,7 @@
 /******************************************************************************/
 /***************************    Test case   ***********************************/
 /******************************************************************************/
-static int thread_state = 0;
+static int volatile thread_state = 0;
 
 static void *threaded(void *arg)
 {
-- 
2.26.2

