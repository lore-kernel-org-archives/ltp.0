From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue,  3 Oct 2017 17:40:55 +0200
Subject: [LTP] [COMMITTED] [PATCH 08/13] Make use of SAFE_SYSCONF()
In-Reply-To: <20171003154100.807-1-chrubis@suse.cz>
References: <20171003154100.807-1-chrubis@suse.cz>
Message-ID: <20171003154100.807-8-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/adjtimex/adjtimex02.c                   | 5 +----
 testcases/kernel/syscalls/sched_getaffinity/sched_getaffinity01.c | 5 ++---
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/syscalls/adjtimex/adjtimex02.c b/testcases/kernel/syscalls/adjtimex/adjtimex02.c
index 577387d92..492225f19 100644
--- a/testcases/kernel/syscalls/adjtimex/adjtimex02.c
+++ b/testcases/kernel/syscalls/adjtimex/adjtimex02.c
@@ -206,10 +206,7 @@ void setup(void)
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	/* set the HZ from sysconf */
-	hz = sysconf(_SC_CLK_TCK);
-	if (hz == -1) {
-		tst_brkm(TBROK, NULL, "Failed to read the HZ from sysconf\n");
-	}
+	hz = SAFE_SYSCONF(NULL, _SC_CLK_TCK);
 
 	TEST_PAUSE;
 
diff --git a/testcases/kernel/syscalls/sched_getaffinity/sched_getaffinity01.c b/testcases/kernel/syscalls/sched_getaffinity/sched_getaffinity01.c
index 7e1146532..02f04b909 100644
--- a/testcases/kernel/syscalls/sched_getaffinity/sched_getaffinity01.c
+++ b/testcases/kernel/syscalls/sched_getaffinity/sched_getaffinity01.c
@@ -50,6 +50,7 @@
 #include <unistd.h>
 
 #include "test.h"
+#include "safe_macros.h"
 #include "lapi/syscalls.h"
 
 char *TCID = "sched_getaffinity01";
@@ -162,9 +163,7 @@ static void setup(void)
 	TEST_PAUSE;
 	tst_tmpdir();
 
-	num = sysconf(_SC_NPROCESSORS_CONF);
-	if (num == -1)
-		tst_brkm(TBROK | TERRNO, NULL, "sysconf");
+	num = SAFE_SYSCONF(NULL, _SC_NPROCESSORS_CONF);
 	tst_resm(TINFO, "system has %ld processor(s).", num);
 }
 
-- 
2.13.5

