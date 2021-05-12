From: Yang Xu <xuyang2018.jy@fujitsu.com>
Date: Wed, 12 May 2021 16:52:18 +0800
Subject: [LTP] [PATCH v1 1/4] syscalls/shmget01: Remove it
Message-ID: <1620809541-6891-1-git-send-email-xuyang2018.jy@fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Since shmct01.c and shmctl08.c has covered this case, we don't need this any more.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 runtest/syscalls                              |   1 -
 runtest/syscalls-ipc                          |   1 -
 .../kernel/syscalls/ipc/shmget/.gitignore     |   1 -
 .../kernel/syscalls/ipc/shmget/shmget01.c     | 171 ------------------
 4 files changed, 174 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/ipc/shmget/shmget01.c

diff --git a/runtest/syscalls b/runtest/syscalls
index aa7fa24dd..63d821e53 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1399,7 +1399,6 @@ shmctl08 shmctl08
 shmdt01 shmdt01
 shmdt02 shmdt02
 
-shmget01 shmget01
 shmget02 shmget02
 shmget03 shmget03
 shmget04 shmget04
diff --git a/runtest/syscalls-ipc b/runtest/syscalls-ipc
index 68fff4038..ff0364704 100644
--- a/runtest/syscalls-ipc
+++ b/runtest/syscalls-ipc
@@ -64,7 +64,6 @@ shmctl08 shmctl08
 shmdt01 shmdt01
 shmdt02 shmdt02
 
-shmget01 shmget01
 shmget02 shmget02
 shmget03 shmget03
 shmget04 shmget04
diff --git a/testcases/kernel/syscalls/ipc/shmget/.gitignore b/testcases/kernel/syscalls/ipc/shmget/.gitignore
index 728e4344f..6f08529f8 100644
--- a/testcases/kernel/syscalls/ipc/shmget/.gitignore
+++ b/testcases/kernel/syscalls/ipc/shmget/.gitignore
@@ -1,4 +1,3 @@
-/shmget01
 /shmget02
 /shmget03
 /shmget04
diff --git a/testcases/kernel/syscalls/ipc/shmget/shmget01.c b/testcases/kernel/syscalls/ipc/shmget/shmget01.c
deleted file mode 100644
index 586f4c263..000000000
--- a/testcases/kernel/syscalls/ipc/shmget/shmget01.c
+++ /dev/null
@@ -1,171 +0,0 @@
-/*
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
- *	shmget01.c
- *
- * DESCRIPTION
- *	shmget01 - test that shmget() correctly creates a shared memory segment
- *
- * ALGORITHM
- *	loop if that option was specified
- *	use the TEST() macro to call shmget()
- *	check the return code
- *	  if failure, issue a FAIL message.
- *	otherwise,
- *	  if doing functionality testing
- *		stat the shared memory resource
- *		check the size, creator pid and mode
- *	  	if correct,
- *			issue a PASS message
- *		otherwise
- *			issue a FAIL message
- *	  else issue a PASS message
- *	call cleanup
- *
- * USAGE:  <for command-line>
- *  shmget01 [-c n] [-f] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -f   : Turn off functionality Testing.
- *	       -i n : Execute test n times.
- *	       -I x : Execute test for x seconds.
- *	       -P x : Pause for x seconds between iterations.
- *	       -t   : Turn on syscall timing.
- *
- * HISTORY
- *	03/2001 - Written by Wayne Boyer
- *
- * RESTRICTIONS
- *	none
- */
-
-#include "ipcshm.h"
-
-char *TCID = "shmget01";
-int TST_TOTAL = 1;
-
-int shm_id_1 = -1;
-
-int main(int ac, char **av)
-{
-	int lc;
-	struct shmid_ds buf;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();		/* global setup */
-
-	/* The following loop checks looping state if -i option given */
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset tst_count in case we are looping */
-		tst_count = 0;
-
-		/*
-		 * Use TEST macro to make the call
-		 */
-
-		TEST(shmget(shmkey, SHM_SIZE, (IPC_CREAT | IPC_EXCL | SHM_RW)));
-
-		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL, "%s call failed - errno = %d : %s",
-				 TCID, TEST_ERRNO, strerror(TEST_ERRNO));
-		} else {
-			shm_id_1 = TEST_RETURN;
-			/* do a STAT and check some info */
-			if (shmctl(shm_id_1, IPC_STAT, &buf) == -1) {
-				tst_resm(TBROK, "shmctl failed in "
-					 "functional test");
-				continue;
-			}
-			/* check the seqment size */
-			if (buf.shm_segsz != SHM_SIZE) {
-				tst_resm(TFAIL, "seqment size is not "
-					 "correct");
-				continue;
-			}
-			/* check the pid of the creator */
-			if (buf.shm_cpid != getpid()) {
-				tst_resm(TFAIL, "creator pid is not "
-					 "correct");
-				continue;
-			}
-			/*
-			 * check the mode of the seqment
-			 * mask out all but the lower 9 bits
-			 */
-			if ((buf.shm_perm.mode & MODE_MASK) !=
-			    ((SHM_RW) & MODE_MASK)) {
-				tst_resm(TFAIL, "segment mode is not "
-					 "correct");
-				continue;
-			}
-			/* if we get here, everything looks good */
-			tst_resm(TPASS, "size, pid & mode are correct");
-		}
-
-		/*
-		 * clean up things in case we are looping
-		 */
-		if (shmctl(shm_id_1, IPC_RMID, NULL) == -1) {
-			tst_resm(TBROK, "couldn't remove shared memory");
-		} else {
-			shm_id_1 = -1;
-		}
-	}
-
-	cleanup();
-
-	tst_exit();
-}
-
-/*
- * setup() - performs all the ONE TIME setup for this test.
- */
-void setup(void)
-{
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
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
-	shmkey = getipckey();
-}
-
-/*
- * cleanup() - performs all the ONE TIME cleanup for this test at completion
- * 	       or premature exit.
- */
-void cleanup(void)
-{
-	/* if it exists, remove the shared memory resource */
-	rm_shm(shm_id_1);
-
-	tst_rmdir();
-
-}
-- 
2.23.0

