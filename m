From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon,  7 Sep 2020 17:01:48 +0200
Subject: [LTP] [PATCH v2 01/10] syscalls/ipc: shmctl02: Convert to the new
 library
In-Reply-To: <20200907150157.23886-1-chrubis@suse.cz>
References: <20200907150157.23886-1-chrubis@suse.cz>
Message-ID: <20200907150157.23886-2-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
Reviewed-by: Li Wang <liwang@redhat.com>
Reviewed-by: Martin Doucha <mdoucha@suse.cz>
---
 testcases/kernel/syscalls/ipc/shmctl/Makefile |   4 +-
 .../kernel/syscalls/ipc/shmctl/shmctl02.c     | 263 ++++++------------
 2 files changed, 89 insertions(+), 178 deletions(-)

diff --git a/testcases/kernel/syscalls/ipc/shmctl/Makefile b/testcases/kernel/syscalls/ipc/shmctl/Makefile
index 2e0ed0ceb..10db57fcc 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/Makefile
+++ b/testcases/kernel/syscalls/ipc/shmctl/Makefile
@@ -10,7 +10,7 @@ shmctl05: LDLIBS += -lrt
 
 include $(top_srcdir)/include/mk/testcases.mk
 
-shmctl01 shmctl02 shmctl03 shmctl04 shmctl05: LTPLDLIBS = -lltpipc
-shmctl06: LTPLDLIBS = -lltpnewipc
+shmctl01 shmctl03 shmctl04 shmctl05: LTPLDLIBS = -lltpipc
+shmctl02 shmctl06: LTPLDLIBS = -lltpnewipc
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl02.c b/testcases/kernel/syscalls/ipc/shmctl/shmctl02.c
index 0b97bb240..677b15d40 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/shmctl02.c
+++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl02.c
@@ -1,213 +1,124 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
+ * Copyright (c) International Business Machines  Corp., 2001
+ *  03/2001 - Written by Wayne Boyer
  *
- *   Copyright (c) International Business Machines  Corp., 2001
+ * Copyright (c) 2008 Renaud Lottiaux (Renaud.Lottiaux@kerlabs.com)
  *
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
+ * Copyright (C) 2020 Cyril Hrubis <chrubis@suse.cz>
  */
 
 /*
- * NAME
- *	shmctl02.c
- *
- * DESCRIPTION
- *	shmctl02 - check for EACCES, EFAULT and EINVAL errors
- *
- * ALGORITHM
- *	create a shared memory segment without read or write permissions
- *	create a shared memory segment with read & write permissions
- *	loop if that option was specified
- *	  call shmctl() using five different invalid cases
- *	  check the errno value
- *	    issue a PASS message if we get EACCES, EFAULT or EINVAL
- *	  otherwise, the tests fails
- *	    issue a FAIL message
- *	call cleanup
- *
- * USAGE:  <for command-line>
- *  shmctl02 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -e   : Turn on errno logging.
- *	       -i n : Execute test n times.
- *	       -I x : Execute test for x seconds.
- *	       -P x : Pause for x seconds between iterations.
- *	       -t   : Turn on syscall timing.
- *
- * HISTORY
- *	03/2001 - Written by Wayne Boyer
+ * Test for EACCES, EFAULT and EINVAL errors.
  *
- *      06/03/2008 Renaud Lottiaux (Renaud.Lottiaux@kerlabs.com)
- *      - Fix concurrency issue. The second key used for this test could
- *        conflict with the key from another task.
+ * * EACCES - segment has no read or write permissions
+ * * EFAULT - IPC_SET & buf isn't valid
+ * * EFAULT - IPC_STAT & buf isn't valid
+ * * EINVAL - the command is not valid
+ * * EINVAL - the shmid is not valid
+ * * EINVAL - the shmid belongs to removed shm
  *
- * RESTRICTIONS
- *	none
+ * * EACCES - attempt to stat root-owned shm
+ * * EPERM  - attempt to delete root-owned shm
+ * * EPERM  - attempt to change root-owned shm
+ * * EPERM  - attempt to lock root-owned shm
+ * * EPERM  - attempt to unlock root-owned shm
  */
 
-#include "ipcshm.h"
 #include <pwd.h>
 
-char *TCID = "shmctl02";
-char nobody_uid[] = "nobody";
-struct passwd *ltpuser;
+#include "tst_test.h"
+#include "tst_safe_sysv_ipc.h"
+#include "libnewipc.h"
 
-int shm_id_1 = -1;
-int shm_id_2 = -1;
-int shm_id_3 = -1;
+#define SHM_SIZE 2048
 
-struct shmid_ds buf;
+static int shm_id1 = -1;
+static int shm_id2 = -1;
+static int shm_id3 = -1;
+static int shm_bad = -1;
+static int shm_rem;
 
-struct test_case_t {
-	int *shmid;
+static struct shmid_ds buf;
+
+static struct tcase {
+	int *shm_id;
 	int cmd;
-	struct shmid_ds *sbuf;
+	struct shmid_ds *buf;
 	int error;
-} TC[] = {
-	/* EACCES - segment has no read or write permissions */
-	{
-	&shm_id_1, IPC_STAT, &buf, EACCES},
-	    /* EFAULT - IPC_SET & buf isn't valid */
-	{
-	&shm_id_2, IPC_SET, (struct shmid_ds *)-1, EFAULT},
-	    /* EFAULT - IPC_STAT & buf isn't valid */
-	{
-	&shm_id_2, IPC_STAT, (struct shmid_ds *)-1, EFAULT},
-	    /* EINVAL - the shmid is not valid */
-	{
-	&shm_id_3, IPC_STAT, &buf, EINVAL},
-	    /* EINVAL - the command is not valid */
-	{
-	&shm_id_2, -1, &buf, EINVAL},
-	    /* EPERM - the command is only valid for the super-user */
-	{
-	&shm_id_2, SHM_LOCK, &buf, EPERM},
-	    /* EPERM - the command is only valid for the super-user */
-	{
-	&shm_id_2, SHM_UNLOCK, &buf, EPERM}
+} tc[] = {
+	{&shm_id1, IPC_STAT, &buf, EACCES},
+	{&shm_id2, IPC_SET, (struct shmid_ds *)-1, EFAULT},
+	{&shm_id2, IPC_STAT, (struct shmid_ds *)-1, EFAULT},
+	{&shm_id2, -1, &buf, EINVAL},
+	{&shm_bad, IPC_STAT, &buf, EINVAL},
+	{&shm_rem, IPC_STAT, &buf, EINVAL},
+	/* Operations on root-owned shm */
+	{&shm_id3, IPC_STAT, &buf, EACCES},
+	{&shm_id3, IPC_RMID, NULL, EPERM},
+	{&shm_id3, IPC_SET, &buf, EPERM},
+	{&shm_id3, SHM_LOCK, &buf, EPERM},
+	{&shm_id3, SHM_UNLOCK, &buf, EPERM}
 };
 
-int TST_TOTAL = ARRAY_SIZE(TC);
-
-int main(int ac, char **av)
+static void verify_shmctl(unsigned int i)
 {
-	int lc;
-	int i;
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
-		/* loop through the test cases */
-		for (i = 0; i < TST_TOTAL; i++) {
-			/*
-			 * use the TEST() macro to make the call
-			 */
-
-			TEST(shmctl(*(TC[i].shmid), TC[i].cmd, TC[i].sbuf));
-
-			if ((TEST_RETURN != -1) && (i < 5)) {
-				tst_resm(TFAIL, "call succeeded unexpectedly");
-				continue;
-			}
-
-			if (TEST_ERRNO == TC[i].error) {
-				tst_resm(TPASS, "expected failure - errno = "
-					 "%d : %s", TEST_ERRNO,
-					 strerror(TEST_ERRNO));
-			} else {
-				if (i >= 5)
-					tst_resm(TCONF,
-						 "shmctl() did not fail for non-root user."
-						 "This may be okay for your distribution.");
-				else
-					tst_resm(TFAIL, "call failed with an "
-						 "unexpected error - %d : %s",
-						 TEST_ERRNO,
-						 strerror(TEST_ERRNO));
-			}
-		}
+	TEST(shmctl(*(tc[i].shm_id), tc[i].cmd, tc[i].buf));
+
+	if (TST_RET != -1) {
+		tst_res(TFAIL, "shmctl() returned %li", TST_RET);
+		return;
 	}
 
-	cleanup();
+	if (TST_ERR == tc[i].error) {
+		tst_res(TPASS | TTERRNO, "shmctl(%i, %i, %p)",
+		        *tc[i].shm_id, tc[i].cmd, tc[i].buf);
+		return;
+	}
 
-	tst_exit();
+	tst_res(TFAIL | TTERRNO, "shmctl(%i, %i, %p) expected %s",
+		*tc[i].shm_id, tc[i].cmd, tc[i].buf, tst_strerrno(tc[i].error));
 }
 
-/*
- * setup() - performs all the ONE TIME setup for this test.
- */
-void setup(void)
+static void setup(void)
 {
-	key_t shmkey2;
+	key_t shmkey1, shmkey2;
+	struct passwd *ltpuser;
+	int tmp;
 
-	tst_require_root();
+	shm_id3 = SAFE_SHMGET(IPC_PRIVATE, SHM_SIZE, IPC_CREAT | SHM_RW);
 
-	/* Switch to nobody user for correct error code collection */
-	ltpuser = getpwnam(nobody_uid);
-	if (setuid(ltpuser->pw_uid) == -1) {
-		tst_resm(TINFO, "setuid failed to "
-			 "to set the effective uid to %d", ltpuser->pw_uid);
-		perror("setuid");
-	}
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
+	ltpuser = SAFE_GETPWNAM("nobody");
+	SAFE_SETEUID(ltpuser->pw_uid);
 
-	/*
-	 * Create a temporary directory and cd into it.
-	 * This helps to ensure that a unique msgkey is created.
-	 * See libs/libltpipc/libipc.c for more information.
-	 */
-	tst_tmpdir();
-
-	/* get an IPC resource key */
-	shmkey = getipckey();
-
-	/* create a shared memory segment without read or write permissions */
-	if ((shm_id_1 = shmget(shmkey, SHM_SIZE, IPC_CREAT | IPC_EXCL)) == -1) {
-		tst_brkm(TBROK, cleanup, "couldn't create shared memory "
-			 "segment #1 in setup()");
-	}
+	shmkey1 = GETIPCKEY();
+	shmkey2 = GETIPCKEY();
 
-	/* Get an new IPC resource key. */
-	shmkey2 = getipckey();
+	shm_id1 = SAFE_SHMGET(shmkey1, SHM_SIZE, IPC_CREAT | IPC_EXCL);
+	shm_id2 = SAFE_SHMGET(shmkey2, SHM_SIZE, IPC_CREAT | IPC_EXCL | SHM_RW);
 
-	/* create a shared memory segment with read and write permissions */
-	if ((shm_id_2 = shmget(shmkey2, SHM_SIZE, IPC_CREAT | IPC_EXCL |
-			       SHM_RW)) == -1) {
-		tst_brkm(TBROK, cleanup, "couldn't create shared memory "
-			 "segment #2 in setup()");
-	}
+	tmp = shm_rem = SAFE_SHMGET(IPC_PRIVATE, SHM_SIZE, IPC_CREAT | SHM_RW);
+	SAFE_SHMCTL(tmp, IPC_RMID, NULL);
 }
 
-/*
- * cleanup() - performs all the ONE TIME cleanup for this test at completion
- * 	       or premature exit.
- */
-void cleanup(void)
+static void cleanup(void)
 {
-	/* if they exist, remove the shared memory resources */
-	rm_shm(shm_id_1);
-	rm_shm(shm_id_2);
+	if (shm_id1 >= 0)
+		SAFE_SHMCTL(shm_id1, IPC_RMID, NULL);
 
-	tst_rmdir();
+	if (shm_id2 >= 0)
+		SAFE_SHMCTL(shm_id2, IPC_RMID, NULL);
 
+	if (shm_id3 >= 0) {
+		SAFE_SETEUID(0);
+		SAFE_SHMCTL(shm_id3, IPC_RMID, NULL);
+	}
 }
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test = verify_shmctl,
+	.tcnt = ARRAY_SIZE(tc),
+	.needs_root = 1,
+};
-- 
2.26.2

