From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 13 Nov 2018 16:17:45 +0100
Subject: [LTP] [PATCH 3/3] syscalls/rt_sigsuspend01: Cleanup && convert to
	newlib
In-Reply-To: <20181113151745.24676-1-chrubis@suse.cz>
References: <20181113151745.24676-1-chrubis@suse.cz>
Message-ID: <20181113151745.24676-4-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Also there is no need to sleep for 5 seconds so we only sleep for 1 now.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
CC: Steve Muckle <smuckle@google.com>
---
 .../syscalls/rt_sigsuspend/rt_sigsuspend01.c       | 135 +++++++--------------
 1 file changed, 43 insertions(+), 92 deletions(-)

diff --git a/testcases/kernel/syscalls/rt_sigsuspend/rt_sigsuspend01.c b/testcases/kernel/syscalls/rt_sigsuspend/rt_sigsuspend01.c
index c8c228a47..14b6bb332 100644
--- a/testcases/kernel/syscalls/rt_sigsuspend/rt_sigsuspend01.c
+++ b/testcases/kernel/syscalls/rt_sigsuspend/rt_sigsuspend01.c
@@ -1,112 +1,63 @@
 /******************************************************************************/
 /* Copyright (c) Crackerjack Project., 2007                                   */
 /*                                                                            */
-/* This program is free software;  you can redistribute it and/or modify      */
-/* it under the terms of the GNU General Public License as published by       */
-/* the Free Software Foundation; either version 2 of the License, or          */
-/* (at your option) any later version.                                        */
-/*                                                                            */
-/* This program is distributed in the hope that it will be useful,            */
-/* but WITHOUT ANY WARRANTY;  without even the implied warranty of            */
-/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                  */
-/* the GNU General Public License for more details.                           */
-/*                                                                            */
-/* You should have received a copy of the GNU General Public License          */
-/* along with this program;  if not, write to the Free Software Foundation,   */
-/* Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA           */
-/*                                                                            */
 /* History:     Porting from Crackerjack to LTP is done by                    */
 /*              Manas Kumar Nayak maknayak@in.ibm.com>                        */
 /******************************************************************************/
 
-/******************************************************************************/
-/* Description: This tests the rt_sigsuspend() syscall.                       */
-/******************************************************************************/
+/*
+ * Description: This tests the rt_sigsuspend() syscall.
+ *
+ * Waits for SIGALRM in rt_sigsuspend() then checks that process mask wasn't
+ * modified.
+ */
 
-#include <stdio.h>
 #include <signal.h>
 #include <errno.h>
-#include <string.h>
 
-#include "test.h"
+#include "tst_test.h"
 #include "lapi/syscalls.h"
-#include "lapi/rt_sigaction.h"
-
-char *TCID = "rt_sigsuspend01";
-int TST_TOTAL = 1;
-
-static void cleanup(void)
-{
-	tst_rmdir();
-}
-
-static void setup(void)
-{
-	TEST_PAUSE;
-	tst_tmpdir();
-}
+#include "lapi/safe_rt_signal.h"
 
 static void sig_handler(int sig)
 {
+	(void) sig;
 }
 
-int main(int ac, char **av)
+static void verify_rt_sigsuspend(void)
 {
 	sigset_t set, set1, set2;
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); ++lc) {
-
-		tst_count = 0;
-
-		if (sigemptyset(&set) < 0)
-			tst_brkm(TFAIL | TERRNO, cleanup, "sigemptyset failed");
-		struct sigaction act, oact;
-		memset(&act, 0, sizeof(act));
-		memset(&oact, 0, sizeof(oact));
-		act.sa_handler = sig_handler;
-
-		TEST(ltp_rt_sigaction(SIGALRM, &act, &oact, SIGSETSIZE));
-		if (TEST_RETURN == -1)
-			tst_brkm(TFAIL | TTERRNO, cleanup,
-				 "rt_sigaction failed");
-
-		TEST(ltp_syscall(__NR_rt_sigprocmask, SIG_UNBLOCK, 0,
-			     &set1, SIGSETSIZE));
-		if (TEST_RETURN == -1)
-			tst_brkm(TFAIL | TTERRNO, cleanup,
-				 "rt_sigprocmask failed");
-
-		TEST(alarm(5));
-		int result;
-		TEST(result = ltp_syscall(__NR_rt_sigsuspend, &set,
-			SIGSETSIZE));
-		TEST(alarm(0));
-		if (result == -1 && TEST_ERRNO != EINTR) {
-			TEST(ltp_syscall(__NR_rt_sigprocmask, SIG_UNBLOCK, 0,
-				&set2, SIGSETSIZE));
-			if (TEST_RETURN == -1) {
-				tst_brkm(TFAIL | TTERRNO, cleanup,
-					 "rt_sigprocmask failed");
-			} else if (memcmp(&set1, &set2,
-				   sizeof(unsigned long))) {
-				tst_brkm(TFAIL | TTERRNO, cleanup,
-					 "rt_sigsuspend failed to "
-					 "preserve signal mask");
-			} else {
-				tst_resm(TPASS, "rt_sigsuspend PASSED");
-			}
-		} else {
-			tst_resm(TFAIL | TTERRNO, "rt_sigsuspend failed");
-		}
-
-	}
-
-	cleanup();
-
-	tst_exit();
+	struct sigaction act = {.sa_handler = sig_handler};
+
+	if (sigemptyset(&set) < 0)
+		tst_brk(TFAIL | TERRNO, "sigemptyset failed");
+
+	SAFE_RT_SIGACTION(SIGALRM, &act, NULL, SIGSETSIZE);
+
+	SAFE_RT_SIGPROCMASK(0, NULL, &set1, SIGSETSIZE);
+
+	alarm(1);
+
+	TEST(tst_syscall(__NR_rt_sigsuspend, &set, SIGSETSIZE));
+
+	alarm(0);
+
+	if (TST_RET != -1)
+		tst_brk(TFAIL, "rt_sigsuspend returned %ld", TST_RET);
+
+	if (TST_ERR != EINTR)
+		tst_brk(TFAIL | TTERRNO, "rt_sigsuspend() failed unexpectedly");
+
+	tst_res(TPASS, "rt_sigsuspend() returned with -1 and EINTR");
+
+	SAFE_RT_SIGPROCMASK(0, NULL, &set2, SIGSETSIZE);
+
+	if (memcmp(&set1, &set2, sizeof(unsigned long)))
+		tst_res(TFAIL, "signal mask not preserved");
+	else
+		tst_res(TPASS, "signal mask preserved");
 }
+
+static struct tst_test test = {
+	.test_all = verify_rt_sigsuspend,
+};
-- 
2.16.4

