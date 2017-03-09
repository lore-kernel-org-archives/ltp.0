From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu,  9 Mar 2017 16:13:04 +0100
Subject: [LTP] [COMMITTED] [PATCH 2/6] syscalls/gettimeofday02: Cleanup &
	convert to new library.
In-Reply-To: <20170309151308.17512-1-chrubis@suse.cz>
References: <20170309151308.17512-1-chrubis@suse.cz>
Message-ID: <20170309151308.17512-2-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 .../kernel/syscalls/gettimeofday/gettimeofday02.c  | 140 ++++++++++-----------
 1 file changed, 65 insertions(+), 75 deletions(-)

diff --git a/testcases/kernel/syscalls/gettimeofday/gettimeofday02.c b/testcases/kernel/syscalls/gettimeofday/gettimeofday02.c
index 8cb1f54..5c2d5a9 100644
--- a/testcases/kernel/syscalls/gettimeofday/gettimeofday02.c
+++ b/testcases/kernel/syscalls/gettimeofday/gettimeofday02.c
@@ -1,120 +1,110 @@
 /*
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
+ * Copyright (C) 2002 Andi Kleen
+ * Copyright (C) 2017 Cyril Hrubis <chrubis@suse.cz>
  *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
+ * This program is free software;  you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
  *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ * the GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program;  if not, write to the Free Software Foundation,
+ * Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
 
 /*
- * NAME
- *	gettimeofday02.c
- *
  * DESCRIPTION
  *	Check if gettimeofday is monotonous
  *
  * ALGORITHM
  *	Call gettimeofday() to get a t1 (fist value)
- *	call it again to get t2, see if t2 < t1, set t2 = t1, repeat for 30 sec
- *
- * USAGE:  <for command-line>
- *  gettimeofday02 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -e   : Turn on errno logging.
- *             -i n : Execute test n times.
- *             -I x : Execute test for x seconds.
- *             -P x : Pause for x seconds between iterations.
- *             -t   : Turn on syscall timing.
- *             -T   : Seconds to test gettimeofday (default 30)
- *
- * HISTORY
- *	05/2002 Written by Andi Kleen
- *
+ *	call it again to get t2, see if t2 < t1, set t2 = t1, repeat for 10 sec
  */
 
 #include <stdint.h>
-#include <stdio.h>
 #include <sys/time.h>
-#include <signal.h>
 #include <stdlib.h>
-#include "test.h"
 #include <sys/syscall.h>
 #include <unistd.h>
 #include <time.h>
 #include <errno.h>
 
-#define gettimeofday(a,b)  syscall(__NR_gettimeofday,a,b)
+#include "tst_test.h"
 
-char *TCID = "gettimeofday02";
-int TST_TOTAL = 1;
-
-int Tflag;
-char *tlen = "30";
-
-sig_atomic_t done;
-
-option_t opts[] = { {"T:", &Tflag, &tlen}, {} };
+#define gettimeofday(a,b)  syscall(__NR_gettimeofday,a,b)
 
-void breakout(int sig)
-{
-	done = 1;
-}
+static volatile sig_atomic_t done;
+static char *str_rtime;
+static int rtime = 30;
 
-void cleanup(void)
-{
-}
+static struct tst_option options[] = {
+	{"T:", &str_rtime, "-T len   Test iteration runtime in seconds"},
+	{NULL, NULL, NULL},
+};
 
-void help(void)
+static void breakout(int sig)
 {
-	printf("  -T len  seconds to test gettimeofday (default %s)\n", tlen);
+	done = sig;
 }
 
-int main(int ac, char **av)
+static void verify_gettimeofday(void)
 {
 	struct timeval tv1, tv2;
+	unsigned long long cnt = 0;
 
-	tst_parse_opts(ac, av, opts, help);
+	done = 0;
 
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-	TEST_PAUSE;
+	alarm(rtime);
 
-	tst_resm(TINFO, "checking if gettimeofday is monotonous, takes %ss",
-		 tlen);
-	signal(SIGALRM, breakout);
-	alarm(atoi(tlen));
+	if (gettimeofday(&tv1, NULL)) {
+		tst_res(TBROK | TERRNO, "gettimeofday() failed");
+		return;
+	}
 
-	if (gettimeofday(&tv1, NULL) != 0)
-		tst_brkm(TBROK, cleanup, "first gettimeofday() failed: %s\n",
-			 strerror(errno));
 	while (!done) {
-		if (gettimeofday(&tv2, NULL) != 0)
-			tst_brkm(TBROK, cleanup,
-				 "loop gettimeofday() failed: %s\n",
-				 strerror(errno));
+		if (gettimeofday(&tv2, NULL)) {
+			tst_res(TBROK | TERRNO, "gettimeofday() failed");
+			return;
+		}
 
 		if (tv2.tv_sec < tv1.tv_sec ||
 		    (tv2.tv_sec == tv1.tv_sec && tv2.tv_usec < tv1.tv_usec)) {
-			tst_resm(TFAIL,
-				 "Time is going backwards: old %jd.%jd vs new %jd.%jd!",
-				 (intmax_t) tv1.tv_sec, (intmax_t) tv1.tv_usec,
-				 (intmax_t) tv2.tv_sec, (intmax_t) tv2.tv_usec);
-			cleanup();
-			return 1;
+			tst_res(TFAIL,
+				"Time is going backwards: old %jd.%jd vs new %jd.%jd!",
+				(intmax_t) tv1.tv_sec, (intmax_t) tv1.tv_usec,
+				(intmax_t) tv2.tv_sec, (intmax_t) tv2.tv_usec);
+			return;
 		}
 
 		tv1 = tv2;
+		cnt++;
 	}
 
-	tst_resm(TPASS, "gettimeofday monotonous in %s seconds", tlen);
 
-	cleanup();
-	tst_exit();
+	tst_res(TINFO, "gettimeofday() called %llu times", cnt);
+	tst_res(TPASS, "gettimeofday() monotonous in %i seconds", rtime);
 }
+
+static void setup(void)
+{
+	if (str_rtime) {
+		rtime = atoi(str_rtime);
+		if (rtime <= 0)
+			tst_brk(TBROK, "Invalid runtime '%s'", str_rtime);
+		tst_set_timeout(rtime + 60);
+	}
+
+	SAFE_SIGNAL(SIGALRM, breakout);
+}
+
+static struct tst_test test = {
+	.tid = "gettimeofday02",
+	.setup = setup,
+	.options = options,
+	.test_all = verify_gettimeofday,
+};
-- 
2.10.2

