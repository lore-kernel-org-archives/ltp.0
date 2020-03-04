From: Petr Vorel <pvorel@suse.cz>
Date: Wed,  4 Mar 2020 19:38:06 +0100
Subject: [LTP] [PATCH 2/2] timerfd: Use safe macros
In-Reply-To: <20200304183806.17672-1-pvorel@suse.cz>
References: <20200304183806.17672-1-pvorel@suse.cz>
Message-ID: <20200304183806.17672-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

SAFE_TIMERFD_CREATE() and SAFE_TIMERFD_SETTIME()

Reviewed-by: Martin Doucha <mdoucha@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes v1->v2: NONE

 testcases/kernel/syscalls/timerfd/timerfd01.c        |  9 +++------
 .../kernel/syscalls/timerfd/timerfd_settime02.c      | 12 ++----------
 2 files changed, 5 insertions(+), 16 deletions(-)

diff --git a/testcases/kernel/syscalls/timerfd/timerfd01.c b/testcases/kernel/syscalls/timerfd/timerfd01.c
index af19b4399..7bbde7283 100644
--- a/testcases/kernel/syscalls/timerfd/timerfd01.c
+++ b/testcases/kernel/syscalls/timerfd/timerfd01.c
@@ -19,7 +19,7 @@
 #include <poll.h>
 #include "tst_test.h"
 #include "tst_timer.h"
-#include "lapi/timerfd.h"
+#include "tst_safe_timerfd.h"
 
 static struct tcase {
 	int id;
@@ -47,8 +47,7 @@ static void settime(int tfd, struct itimerspec *tmr, int tflags,
 	tmr->it_value = tst_us_to_timespec(tvalue);
 	tmr->it_interval = tst_us_to_timespec(tinterval);
 
-	if (timerfd_settime(tfd, tflags, tmr, NULL))
-		tst_brk(TBROK | TERRNO, "timerfd_settime() failed");
+	SAFE_TIMERFD_SETTIME(tfd, tflags, tmr, NULL);
 }
 
 static void waittmr(int tfd, unsigned int exp_ticks)
@@ -87,9 +86,7 @@ static void run(unsigned int n)
 
 	tst_res(TINFO, "testing %s", clks->name);
 
-	tfd = timerfd_create(clks->id, 0);
-	if (tfd == -1)
-		tst_brk(TFAIL | TERRNO, "timerfd_create() failed");
+	tfd = SAFE_TIMERFD_CREATE(clks->id, 0);
 
 	tst_res(TINFO, "relative timer (100 ms)");
 	settime(tfd, &tmr, 0, 100 * 1000, 0);
diff --git a/testcases/kernel/syscalls/timerfd/timerfd_settime02.c b/testcases/kernel/syscalls/timerfd/timerfd_settime02.c
index 7fa26de62..0565802f4 100644
--- a/testcases/kernel/syscalls/timerfd/timerfd_settime02.c
+++ b/testcases/kernel/syscalls/timerfd/timerfd_settime02.c
@@ -15,7 +15,7 @@
  *  timerfd: Protect the might cancel mechanism proper
  */
 #include <unistd.h>
-#include <lapi/timerfd.h>
+#include "tst_safe_timerfd.h"
 #include "tst_test.h"
 #include "tst_fuzzy_sync.h"
 #include "tst_taint.h"
@@ -32,16 +32,8 @@ static struct tst_fzsync_pair fzsync_pair;
 
 static void setup(void)
 {
-	int ttype;
-
 	tst_taint_init(TST_TAINT_W | TST_TAINT_D);
-	errno = 0;
-	fd = timerfd_create(CLOCK_REALTIME, 0);
-
-	if (fd < 0) {
-		ttype = (errno == ENOTSUP ? TCONF : TBROK);
-		tst_brk(ttype | TERRNO, "Cannot create timer");
-	}
+	fd = SAFE_TIMERFD_CREATE(CLOCK_REALTIME, 0);
 
 	fzsync_pair.exec_loops = 1000000;
 	tst_fzsync_pair_init(&fzsync_pair);
-- 
2.25.1

