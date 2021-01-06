From: Feiyu Zhu <zhufy.jy@cn.fujitsu.com>
Date: Wed, 6 Jan 2021 02:27:39 -0500
Subject: [LTP] [PATCH 1/5] syscalls/ipc: semctl02: Convert to new API and
 cleanup
Message-ID: <1609918063-15810-1-git-send-email-zhufy.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Also make use of TST_EXP_FAIL

Signed-off-by: Feiyu Zhu <zhufy.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/ipc/semctl/Makefile   |   4 +-
 testcases/kernel/syscalls/ipc/semctl/semctl02.c | 155 ++++--------------------
 2 files changed, 28 insertions(+), 131 deletions(-)

diff --git a/testcases/kernel/syscalls/ipc/semctl/Makefile b/testcases/kernel/syscalls/ipc/semctl/Makefile
index c6d8597..f04983d 100644
--- a/testcases/kernel/syscalls/ipc/semctl/Makefile
+++ b/testcases/kernel/syscalls/ipc/semctl/Makefile
@@ -7,7 +7,7 @@ LTPLIBS = ltpipc ltpnewipc
 
 include $(top_srcdir)/include/mk/testcases.mk
 
-semctl01 semctl02 semctl03 semctl04 semctl05 semctl06 semctl07: LTPLDLIBS = -lltpipc
-semctl08 semctl09: LTPLDLIBS = -lltpnewipc
+semctl01 semctl03 semctl04 semctl05 semctl06 semctl07: LTPLDLIBS = -lltpipc
+semctl02 semctl08 semctl09: LTPLDLIBS = -lltpnewipc
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/ipc/semctl/semctl02.c b/testcases/kernel/syscalls/ipc/semctl/semctl02.c
index 35051f6..f39b214 100644
--- a/testcases/kernel/syscalls/ipc/semctl/semctl02.c
+++ b/testcases/kernel/syscalls/ipc/semctl/semctl02.c
@@ -1,157 +1,54 @@
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
- */
-
-/*
- * NAME
- *	semctl02.c
+ * Copyright (c) International Business Machines  Corp., 2001
  *
  * DESCRIPTION
  *	semctl02 - test for EACCES error
  *
- * ALGORITHM
- *	create a semaphore set without read/alter permissions
- *	loop if that option was specified
- *	call semctl() attempting an IPC_STAT command
- *	check the errno value
- *	  issue a PASS message if we get EACCES
- *	otherwise, the tests fails
- *	  issue a FAIL message
- *	call cleanup
- *
- * USAGE:  <for command-line>
- *  semctl02 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
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
 #include <pwd.h>
+#include "tst_safe_sysv_ipc.h"
+#include "tst_test.h"
+#include "lapi/sem.h"
+#include "libnewipc.h"
 
-char *TCID = "semctl02";
-int TST_TOTAL = 1;
-
-char nobody_uid[] = "nobody";
-struct passwd *ltpuser;
-
-int sem_id_1 = -1;
+static int sem_id = -1;
 
-int main(int ac, char **av)
+static void verify_semctl(void)
 {
-	int lc;
-
 	struct semid_ds sem_ds;
 	union semun un_arg;
 
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();		/* global setup */
-
-	/* The following loop checks looping state if -i option given */
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset tst_count in case we are looping */
-		tst_count = 0;
+	un_arg.buf = &sem_ds;
 
-		un_arg.buf = &sem_ds;
-
-		/*
-		 * use the TEST macro to make the call
-		 */
-
-		TEST(semctl(sem_id_1, 0, IPC_STAT, un_arg));
-
-		if (TEST_RETURN != -1) {
-			tst_resm(TFAIL, "call succeeded when error expected");
-			continue;
-		}
-
-		switch (TEST_ERRNO) {
-		case EACCES:
-			tst_resm(TPASS, "expected failure - errno = %d : %s",
-				 TEST_ERRNO, strerror(TEST_ERRNO));
-			break;
-		default:
-			tst_resm(TFAIL, "unexpected error - %d : %s",
-				 TEST_ERRNO, strerror(TEST_ERRNO));
-			break;
-		}
-	}
-
-	cleanup();
-
-	tst_exit();
+	TST_EXP_FAIL(semctl(sem_id, 0, IPC_STAT, un_arg), EACCES,
+		     "semctl(IPC_STAT) with nobody user");
 }
 
-/*
- * setup() - performs all the ONE TIME setup for this test.
- */
-void setup(void)
+static void setup(void)
 {
-	tst_require_root();
+	static key_t semkey;
+	struct passwd *ltpuser = SAFE_GETPWNAM("nobody");
 
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+	SAFE_SETUID(ltpuser->pw_uid);
 
-	TEST_PAUSE;
+	semkey = GETIPCKEY();
 
-	/* Switch to nobody user for correct error code collection */
-	ltpuser = getpwnam(nobody_uid);
-	if (setuid(ltpuser->pw_uid) == -1) {
-		tst_resm(TINFO, "setuid failed to "
-			 "to set the effective uid to %d", ltpuser->pw_uid);
-		perror("setuid");
-	}
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
-	/* create a semaphore set without read or alter permissions */
-	if ((sem_id_1 = semget(semkey, PSEMS, IPC_CREAT | IPC_EXCL)) == -1) {
-		tst_brkm(TBROK, cleanup, "couldn't create semaphore in setup");
-	}
+	sem_id = SAFE_SEMGET(semkey, PSEMS, IPC_CREAT | IPC_EXCL);
 }
 
-/*
- * cleanup() - performs all the ONE TIME cleanup for this test at completion
- * 	       or premature exit.
- */
 void cleanup(void)
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
+	.test_all = verify_semctl,
+};
-- 
1.8.3.1



