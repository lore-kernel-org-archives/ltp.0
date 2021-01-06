From: Feiyu Zhu <zhufy.jy@cn.fujitsu.com>
Date: Wed, 6 Jan 2021 02:27:42 -0500
Subject: [LTP] [PATCH 4/5] syscalls/ipc: semctl05: Convert to new API and
 cleanup
In-Reply-To: <1609918063-15810-1-git-send-email-zhufy.jy@cn.fujitsu.com>
References: <1609918063-15810-1-git-send-email-zhufy.jy@cn.fujitsu.com>
Message-ID: <1609918063-15810-4-git-send-email-zhufy.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Also make use of TST_EXP_FAIL

Signed-off-by: Feiyu Zhu <zhufy.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/ipc/semctl/Makefile   |   4 +-
 testcases/kernel/syscalls/ipc/semctl/semctl05.c | 169 +++++-------------------
 2 files changed, 34 insertions(+), 139 deletions(-)

diff --git a/testcases/kernel/syscalls/ipc/semctl/Makefile b/testcases/kernel/syscalls/ipc/semctl/Makefile
index 2a379d9..4923010 100644
--- a/testcases/kernel/syscalls/ipc/semctl/Makefile
+++ b/testcases/kernel/syscalls/ipc/semctl/Makefile
@@ -7,7 +7,7 @@ LTPLIBS = ltpipc ltpnewipc
 
 include $(top_srcdir)/include/mk/testcases.mk
 
-semctl01 semctl05 semctl06 semctl07: LTPLDLIBS = -lltpipc
-semctl02 semctl03 semctl04 semctl08 semctl09: LTPLDLIBS = -lltpnewipc
+semctl01 semctl06 semctl07: LTPLDLIBS = -lltpipc
+semctl02 semctl03 semctl04 semctl05 semctl08 semctl09: LTPLDLIBS = -lltpnewipc
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/ipc/semctl/semctl05.c b/testcases/kernel/syscalls/ipc/semctl/semctl05.c
index 84dace4..86297e2 100644
--- a/testcases/kernel/syscalls/ipc/semctl/semctl05.c
+++ b/testcases/kernel/syscalls/ipc/semctl/semctl05.c
@@ -1,59 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- *
- *   Copyright (c) International Business Machines  Corp., 2001
- *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * Copyright (c) International Business Machines  Corp., 2001
  */
-
 /*
- * NAME
- *	semctl05.c
- *
  * DESCRIPTION
  *	semctl05 - test for ERANGE error
  *
- * ALGORITHM
- *	create a semaphore set with read and alter permissions
- *	loop if that option was specified
- *	call semctl() with three different invalid cases
- *	check the errno value
- *	  issue a PASS message if we get ERANGE
- *	otherwise, the tests fails
- *	  issue a FAIL message
- *	call cleanup
- *
- * USAGE:  <for command-line>
- *  semctl05 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -e   : Turn on errno logging.
- *	       -i n : Execute test n times.
- *	       -I x : Execute test for x seconds.
- *	       -P x : Pause for x seconds between iterations.
- *	       -t   : Turn on syscall timing.
- *
  * HISTORY
  *	03/2001 - Written by Wayne Boyer
- *
- * RESTRICTIONS
- *	none
  */
 
-#include "ipcsem.h"
-
-char *TCID = "semctl05";
-int TST_TOTAL = 3;
+#include "tst_safe_sysv_ipc.h"
+#include "tst_test.h"
+#include "lapi/sem.h"
+#include "libnewipc.h"
 
 #ifdef _XLC_COMPILER
 #define SEMUN_CAST
@@ -61,118 +21,53 @@ int TST_TOTAL = 3;
 #define SEMUN_CAST (union semun)
 #endif
 
-int sem_id_1 = -1;
+static int sem_id = -1;
 
 #define BIGV	65535		/* a number ((2^16)-1) that should be larger */
 				/* than the maximum for a semaphore value    */
 
-#ifdef _XLC_COMPILER
-#define SEMUN_CAST
-#else
-#define SEMUN_CAST (union semun)
-#endif
-
 unsigned short big_arr[] = { BIGV, BIGV, BIGV, BIGV, BIGV, BIGV, BIGV, BIGV,
 	BIGV, BIGV
 };
 
-struct test_case_t {
+static struct tcases {
 	int count;
 	int cmd;
 	union semun t_arg;
-} TC[] = {
-	/* ERANGE - the value to set is less than zero - SETVAL */
-	{
-	5, SETVAL, SEMUN_CAST - 1},
-	    /* ERANGE - the values to set are too large, > semaphore max value */
-	{
-	0, SETALL, SEMUN_CAST big_arr},
-	    /* ERANGE - the value to set is too large, > semaphore max value */
-	{
-	5, SETVAL, SEMUN_CAST BIGV}
+	char *message;
+} tests[] = {
+	{5, SETVAL, SEMUN_CAST - 1, "the value to set is less than zero"},
+	{0, SETALL, SEMUN_CAST big_arr, "the value to set are too large"},
+	{5, SETVAL, SEMUN_CAST BIGV, "the value to set is too large"}
 };
 
-int main(int ac, char **av)
+static void verify_semctl(unsigned int n)
 {
-	int lc;
-	int i;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();		/* global setup */
+	struct tcases *tc = &tests[n];
 
-	/* The following loop checks looping state if -i option given */
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset tst_count in case we are looping */
-		tst_count = 0;
-
-		for (i = 0; i < TST_TOTAL; i++) {
-
-			TEST(semctl(sem_id_1, TC[i].count,
-				    TC[i].cmd, TC[i].t_arg));
-
-			if (TEST_RETURN != -1) {
-				tst_resm(TFAIL, "call succeeded unexpectedly");
-				continue;
-			}
-
-			switch (TEST_ERRNO) {
-			case ERANGE:
-				tst_resm(TPASS, "expected failure - errno = "
-					 "%d : %s", TEST_ERRNO,
-					 strerror(TEST_ERRNO));
-				break;
-			default:
-				tst_resm(TFAIL, "unexpected error "
-					 "- %d : %s", TEST_ERRNO,
-					 strerror(TEST_ERRNO));
-				break;
-			}
-		}
-	}
-
-	cleanup();
-
-	tst_exit();
+	TST_EXP_FAIL(semctl(sem_id, tc->count, tc->cmd, tc->t_arg), ERANGE,
+		     "semctl() with %s", tc->message);
 }
 
-/*
- * setup() - performs all the ONE TIME setup for this test.
- */
-void setup(void)
+static void setup(void)
 {
+	static key_t semkey;
 
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+	semkey = GETIPCKEY();
 
-	TEST_PAUSE;
-
-	/*
-	 * Create a temporary directory and cd into it.
-	 * This helps to ensure that a unique msgkey is created.
-	 * See libs/libltpipc/libipc.c for more information.
-	 */
-	tst_tmpdir();
-
-	/* get an IPC resource key */
-	semkey = getipckey();
-
-	/* create a semaphore set with read and alter permissions */
-	if ((sem_id_1 =
-	     semget(semkey, PSEMS, IPC_CREAT | IPC_EXCL | SEM_RA)) == -1) {
-		tst_brkm(TBROK, cleanup, "couldn't create semaphore in setup");
-	}
+	sem_id = SAFE_SEMGET(semkey, PSEMS, IPC_CREAT | IPC_EXCL | SEM_RA);
 }
 
-/*
- * cleanup() - performs all the ONE TIME cleanup for this test at completion
- * 	       or premature exit.
- */
-void cleanup(void)
+static void cleanup(void)
 {
-	/* if it exists, remove the semaphore resouce */
-	rm_sema(sem_id_1);
-
-	tst_rmdir();
-
+	if (sem_id != -1)
+		SAFE_SEMCTL(sem_id, 0, IPC_RMID);
 }
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_root = 1,
+	.test = verify_semctl,
+	.tcnt = ARRAY_SIZE(tests),
+};
-- 
1.8.3.1



