From: Yang Xu <xuyang2018.jy@fujitsu.com>
Date: Tue, 22 Jun 2021 16:31:28 +0800
Subject: [LTP] [PATCH v2] syscalls/shmget*: Convert into new api
In-Reply-To: <YMytkmBZb5zDBLGi@yuki>
References: <YMytkmBZb5zDBLGi@yuki>
Message-ID: <1624350688-31627-1-git-send-email-xuyang2018.jy@fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1) merge shmget05.c into shmget02.c
2) Use SHMMIN -1 and SHMMAX + 1 to trigger EINVAL error
3) Use SHM_RD, SHM_WR, SHM_RW to trigger EACCES error under unpriviledged user
4) add EPERM error test
5) Use TST_EXP_FAIL macro

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 include/lapi/shm.h                            |  14 +
 runtest/syscalls                              |   1 -
 runtest/syscalls-ipc                          |   1 -
 .../kernel/syscalls/ipc/shmget/.gitignore     |   1 -
 testcases/kernel/syscalls/ipc/shmget/Makefile |   4 +-
 .../kernel/syscalls/ipc/shmget/shmget02.c     | 244 ++++++------------
 .../kernel/syscalls/ipc/shmget/shmget03.c     | 204 ++++-----------
 .../kernel/syscalls/ipc/shmget/shmget04.c     | 188 ++++----------
 .../kernel/syscalls/ipc/shmget/shmget05.c     | 185 -------------
 9 files changed, 206 insertions(+), 636 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/ipc/shmget/shmget05.c

diff --git a/include/lapi/shm.h b/include/lapi/shm.h
index 61c4e37bf..bb280fc44 100644
--- a/include/lapi/shm.h
+++ b/include/lapi/shm.h
@@ -6,8 +6,22 @@
 #ifndef LAPI_SHM_H__
 #define LAPI_SHM_H__
 
+#include <limits.h>
+
 #ifndef SHM_STAT_ANY
 # define SHM_STAT_ANY 15
 #endif
 
+#ifndef SHMMIN
+# define SHMMIN 1
+#endif
+
+#ifndef SHMMAX
+# define SHMMAX (ULONG_MAX - (1UL << 24))
+#endif
+
+#ifndef SHMMNI
+# define SHMMNI 4096
+#endif
+
 #endif /* LAPI_SHM_H__ */
diff --git a/runtest/syscalls b/runtest/syscalls
index c989427c0..e1e932836 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1407,7 +1407,6 @@ shmdt02 shmdt02
 shmget02 shmget02
 shmget03 shmget03
 shmget04 shmget04
-shmget05 shmget05
 
 sigaction01 sigaction01
 sigaction02 sigaction02
diff --git a/runtest/syscalls-ipc b/runtest/syscalls-ipc
index ff0364704..b3bd37923 100644
--- a/runtest/syscalls-ipc
+++ b/runtest/syscalls-ipc
@@ -67,4 +67,3 @@ shmdt02 shmdt02
 shmget02 shmget02
 shmget03 shmget03
 shmget04 shmget04
-shmget05 shmget05
diff --git a/testcases/kernel/syscalls/ipc/shmget/.gitignore b/testcases/kernel/syscalls/ipc/shmget/.gitignore
index 6f08529f8..c57df68f5 100644
--- a/testcases/kernel/syscalls/ipc/shmget/.gitignore
+++ b/testcases/kernel/syscalls/ipc/shmget/.gitignore
@@ -1,4 +1,3 @@
 /shmget02
 /shmget03
 /shmget04
-/shmget05
diff --git a/testcases/kernel/syscalls/ipc/shmget/Makefile b/testcases/kernel/syscalls/ipc/shmget/Makefile
index 26b9f264d..b1201281d 100644
--- a/testcases/kernel/syscalls/ipc/shmget/Makefile
+++ b/testcases/kernel/syscalls/ipc/shmget/Makefile
@@ -3,10 +3,10 @@
 
 top_srcdir              ?= ../../../../..
 
-LTPLIBS = ltpipc
+LTPLIBS = ltpnewipc
 
 include $(top_srcdir)/include/mk/testcases.mk
 
-LTPLDLIBS  = -lltpipc
+LTPLDLIBS = -lltpnewipc
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/ipc/shmget/shmget02.c b/testcases/kernel/syscalls/ipc/shmget/shmget02.c
index 4436ca7f8..46ebea118 100644
--- a/testcases/kernel/syscalls/ipc/shmget/shmget02.c
+++ b/testcases/kernel/syscalls/ipc/shmget/shmget02.c
@@ -1,184 +1,106 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
+ * Copyright (c) International Business Machines  Corp., 2001
+ *  03/2001 - Written by Wayne Boyer
  *
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
+ * Copyright (c) 2008 Renaud Lottiaux (Renaud.Lottiaux@kerlabs.com)
  */
 
-/*
- * NAME
- *	shmget02.c
- *
- * DESCRIPTION
- *	shmget02 - check for ENOENT, EEXIST and EINVAL errors
+/*\
+ * [Description]
  *
- * ALGORITHM
- *	create a shared memory segment with read & write permissions
- *	loop if that option was specified
- *	  call shmget() using five different invalid cases
- *	  check the errno value
- *	    issue a PASS message if we get ENOENT, EEXIST or EINVAL
- *	  otherwise, the tests fails
- *	    issue a FAIL message
- *	call cleanup
+ * Test for ENOENT, EEXIST, EINVAL, EACCES, EPERM errors.
  *
- * USAGE:  <for command-line>
- *  shmget02 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -e   : Turn on errno logging.
- *	       -i n : Execute test n times.
- *	       -I x : Execute test for x seconds.
- *	       -P x : Pause for x seconds between iterations.
- *	       -t   : Turn on syscall timing.
- *
- * HISTORY
- *	03/2001 - Written by Wayne Boyer
- *
- *      06/03/2008 Renaud Lottiaux (Renaud.Lottiaux@kerlabs.com)
- *      - Fix concurrency issue. The second key used for this test could
- *        conflict with the key from another task.
- *
- * RESTRICTIONS
- *	none
+ * ENOENT - No segment exists for the given key and IPC_CREAT was not specified.
+ * EEXIST - the segment exists and IPC_CREAT | IPC_EXCL is given.
+ * EINVAL - A new segment was to be created and size is less than SHMMIN or
+ * greater than SHMMAX. Or a segment for the given key exists, but size is
+ * gran eater than the size of that segment.
+ * EACCES - The user does not have permission to access the shared memory segment.
+ * EPERM - The SHM_HUGETLB flag was specified, but the caller was not privileged
+ * (did not have the CAP_IPC_LOCK capability) and is not a member of the
+ * sysctl_hugetlb_shm_group group.
  */
 
-#include "ipcshm.h"
-
-char *TCID = "shmget02";
-int TST_TOTAL = 4;
-
-int shm_id_1 = -1;
-int shm_nonexisting_key = -1;
-key_t shmkey2;
-
-struct test_case_t {
-	int *skey;
-	int size;
+#include <errno.h>
+#include <sys/types.h>
+#include <sys/ipc.h>
+#include <stdlib.h>
+#include <pwd.h>
+#include <sys/shm.h>
+#include "tst_safe_sysv_ipc.h"
+#include "tst_test.h"
+#include "libnewipc.h"
+#include "lapi/shm.h"
+
+static int shm_id = -1;
+static key_t shmkey, shmkey1;
+static struct passwd *pw;
+
+static struct tcase {
+	int *shmkey;
+	size_t size;
 	int flags;
-	int error;
-} TC[] = {
-	/* EINVAL - size is 0 */
-	{
-	&shmkey2, 0, IPC_CREAT | IPC_EXCL | SHM_RW, EINVAL},
-	    /* EINVAL - size is negative */
-//      {&shmkey2, -1, IPC_CREAT | IPC_EXCL | SHM_RW, EINVAL},
-	    /* EINVAL - size is larger than created segment */
-	{
-	&shmkey, SHM_SIZE * 2, SHM_RW, EINVAL},
-	    /* EEXIST - the segment exists and IPC_CREAT | IPC_EXCL is given */
-	{
-	&shmkey, SHM_SIZE, IPC_CREAT | IPC_EXCL | SHM_RW, EEXIST},
-	    /* ENOENT - no segment exists for the key and IPC_CREAT is not given */
-	    /* use shm_id_2 (-1) as the key */
-	{
-	&shm_nonexisting_key, SHM_SIZE, SHM_RW, ENOENT}
+	/*1: nobody expected  0: root expected */
+	int exp_user;
+	int exp_err;
+} tcases[] = {
+	{&shmkey1, SHM_SIZE, IPC_EXCL, 0, ENOENT},
+	{&shmkey, SHM_SIZE, IPC_CREAT | IPC_EXCL, 0, EEXIST},
+	{&shmkey1, SHMMIN - 1, IPC_CREAT | IPC_EXCL, 0, EINVAL},
+	{&shmkey1, SHMMAX + 1, IPC_CREAT | IPC_EXCL, 0, EINVAL},
+	{&shmkey, SHM_SIZE * 2, IPC_EXCL, 0, EINVAL},
+	{&shmkey, SHM_SIZE, SHM_RD, 1, EACCES},
+	{&shmkey1, SHM_SIZE, IPC_CREAT | SHM_HUGETLB, 1, EPERM}
 };
 
-int main(int ac, char **av)
+static void do_test(unsigned int n)
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
+	struct tcase *tc = &tcases[n];
+	pid_t pid;
 
-		/* loop through the test cases */
-		for (i = 0; i < TST_TOTAL; i++) {
-			/*
-			 * Look for a failure ...
-			 */
-
-			TEST(shmget(*(TC[i].skey), TC[i].size, TC[i].flags));
-
-			if (TEST_RETURN != -1) {
-				tst_resm(TFAIL, "call succeeded unexpectedly");
-				continue;
-			}
-
-			if (TEST_ERRNO == TC[i].error) {
-				tst_resm(TPASS, "expected failure - errno = "
-					 "%d : %s", TEST_ERRNO,
-					 strerror(TEST_ERRNO));
-			} else {
-				tst_resm(TFAIL, "call failed with an "
-					 "unexpected error - %d : %s",
-					 TEST_ERRNO, strerror(TEST_ERRNO));
-			}
-		}
+	if (tc->exp_user == 0) {
+		TST_EXP_FAIL(shmget(*tc->shmkey, tc->size, tc->flags), tc->exp_err,
+			"shmget(%i, %lu, %i)", *tc->shmkey, tc->size, tc->flags);
+		return;
 	}
 
-	cleanup();
-
-	tst_exit();
+	pid = SAFE_FORK();
+	if (pid == 0) {
+		SAFE_SETUID(pw->pw_uid);
+		TST_EXP_FAIL(shmget(*tc->shmkey, tc->size, tc->flags), tc->exp_err,
+			"shmget(%i, %lu, %i)", *tc->shmkey, tc->size, tc->flags);
+		exit(0);
+	}
+	tst_reap_children();
 }
 
-/*
- * setup() - performs all the ONE TIME setup for this test.
- */
-void setup(void)
+static void setup(void)
 {
+	shmkey = GETIPCKEY();
+	shmkey1 = GETIPCKEY();
 
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
-
-	/* Get an new IPC resource key. */
-	shmkey2 = getipckey();
-
-	if ((shm_id_1 = shmget(shmkey, SHM_SIZE, IPC_CREAT | IPC_EXCL |
-			       SHM_RW)) == -1) {
-		tst_brkm(TBROK, cleanup, "couldn't create shared memory "
-			 "segment in setup()");
-	}
-
-	/* Make sure shm_nonexisting_key is a nonexisting key */
-	while (1) {
-		while (-1 != shmget(shm_nonexisting_key, 1, SHM_RD)) {
-			shm_nonexisting_key--;
-		}
-		if (errno == ENOENT)
-			break;
-	}
+	SAFE_FILE_PRINTF("/proc/sys/vm/hugetlb_shm_group", "1");
+	shm_id = SAFE_SHMGET(shmkey, SHM_SIZE, IPC_CREAT | IPC_EXCL);
+	pw = SAFE_GETPWNAM("nobody");
 }
 
-/*
- * cleanup() - performs all the ONE TIME cleanup for this test at completion
- * 	       or premature exit.
- */
-void cleanup(void)
+static void cleanup(void)
 {
-	/* if it exists, remove the shared memory resource */
-	rm_shm(shm_id_1);
-
-	tst_rmdir();
-
+	if (shm_id >= 0)
+		SAFE_SHMCTL(shm_id, IPC_RMID, NULL);
 }
+
+static struct tst_test test = {
+	.needs_tmpdir = 1,
+	.needs_root = 1,
+	.forks_child = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test = do_test,
+	.tcnt = ARRAY_SIZE(tcases),
+	.save_restore = (const char * const[]) {
+		"?/proc/sys/vm/hugetlb_shm_group",
+		NULL,
+	}
+};
diff --git a/testcases/kernel/syscalls/ipc/shmget/shmget03.c b/testcases/kernel/syscalls/ipc/shmget/shmget03.c
index 96ebf3608..d2e850b2a 100644
--- a/testcases/kernel/syscalls/ipc/shmget/shmget03.c
+++ b/testcases/kernel/syscalls/ipc/shmget/shmget03.c
@@ -1,171 +1,75 @@
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
+ *  03/2001 - Written by Wayne Boyer
  */
 
-/*
- * NAME
- *	shmget03.c
+/*\
+ * [Description]
  *
- * DESCRIPTION
- *	shmget03 - test for ENOSPC error
+ * Test for ENOSPC error.
  *
- * ALGORITHM
- *	create shared memory segments in a loop until reaching the system limit
- *	loop if that option was specified
- *	  attempt to create yet another shared memory segment
- *	  check the errno value
- *	    issue a PASS message if we get ENOSPC
- *	  otherwise, the tests fails
- *	    issue a FAIL message
- *	call cleanup
- *
- * USAGE:  <for command-line>
- *  shmget03 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -e   : Turn on errno logging.
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
+ * ENOSPC -  All possible shared memory segments have been taken (SHMMNI).
  */
-
-#include "ipcshm.h"
-
-char *TCID = "shmget03";
-int TST_TOTAL = 1;
-
-/*
- * The MAXIDS value is somewhat arbitrary and may need to be increased
- * depending on the system being tested.
- */
-#define MAXIDS	8192
-
-int shm_id_1 = -1;
-int num_shms = 0;
-
-int shm_id_arr[MAXIDS];
-
-int main(int ac, char **av)
+#include <errno.h>
+#include <sys/types.h>
+#include <sys/ipc.h>
+#include <stdlib.h>
+#include <pwd.h>
+#include <sys/shm.h>
+#include "tst_test.h"
+#include "tst_safe_sysv_ipc.h"
+#include "libnewipc.h"
+
+static int *queues;
+static int maxshms;
+static key_t shmkey;
+
+static void verify_shmget(void)
 {
-	int lc;
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
-		 * use the TEST() macro to make the call
-		 */
-
-		TEST(shmget(IPC_PRIVATE, SHM_SIZE, IPC_CREAT | IPC_EXCL
-			    | SHM_RW));
-
-		if (TEST_RETURN != -1) {
-			tst_resm(TFAIL, "call succeeded when error expected");
-			continue;
-		}
-
-		switch (TEST_ERRNO) {
-		case ENOSPC:
-			tst_resm(TPASS, "expected failure - errno = "
-				 "%d : %s", TEST_ERRNO, strerror(TEST_ERRNO));
-			break;
-		default:
-			tst_resm(TFAIL, "call failed with an "
-				 "unexpected error - %d : %s",
-				 TEST_ERRNO, strerror(TEST_ERRNO));
-			break;
-		}
-	}
-
-	cleanup();
-
-	tst_exit();
+	TST_EXP_FAIL(shmget(shmkey + maxshms, SHM_SIZE, IPC_CREAT | IPC_EXCL | SHM_RW), ENOSPC,
+		"shmget(%i, %i, %i)", shmkey + maxshms, SHM_SIZE, IPC_CREAT | IPC_EXCL | SHM_RW);
 }
 
-/*
- * setup() - performs all the ONE TIME setup for this test.
- */
-void setup(void)
+static void setup(void)
 {
+	int res, num;
 
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+	shmkey = GETIPCKEY();
 
-	TEST_PAUSE;
+	SAFE_FILE_SCANF("/proc/sys/kernel/shmmni", "%i", &maxshms);
 
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
-	/*
-	 * Use a while loop to create the maximum number of memory segments.
-	 * If the loop exceeds MAXIDS, then break the test and cleanup.
-	 */
-	while ((shm_id_1 = shmget(IPC_PRIVATE, SHM_SIZE, IPC_CREAT |
-				  IPC_EXCL | SHM_RW)) != -1) {
-		shm_id_arr[num_shms++] = shm_id_1;
-		if (num_shms == MAXIDS) {
-			tst_brkm(TBROK, cleanup, "The maximum number of shared "
-				 "memory ID's has been\n\t reached.  Please "
-				 "increase the MAXIDS value in the test.");
-		}
-	}
-
-	/*
-	 * If the errno is other than ENOSPC, then something else is wrong.
-	 */
-	if (errno != ENOSPC) {
-		tst_resm(TINFO, "errno = %d : %s", errno, strerror(errno));
-		tst_brkm(TBROK, cleanup, "Didn't get ENOSPC in test setup");
+	queues = SAFE_MALLOC(maxshms * sizeof(int));
+	for (num = 0; num < maxshms; num++) {
+		queues[num] = -1;
+		res = shmget(shmkey + num, SHM_SIZE, IPC_CREAT | IPC_EXCL | SHM_RW);
+		if (res != -1)
+			queues[num] = res;
+		else
+			tst_brk(TBROK | TERRNO, "shmget failed unexpectedly");
 	}
+	tst_res(TINFO, "The maximum number of memory segments (%d) has been reached",
+		maxshms);
 }
 
-/*
- * cleanup() - performs all the ONE TIME cleanup for this test@completion
- * 	       or premature exit.
- */
-void cleanup(void)
+static void cleanup(void)
 {
-	int i;
+	int num;
 
-	/* remove the shared memory resources that were created */
-	for (i = 0; i < num_shms; i++) {
-		rm_shm(shm_id_arr[i]);
-	}
+	if (!queues)
+		return;
 
-	tst_rmdir();
+	for (num = 0; num < maxshms; num++) {
+		if (queues[num] != -1)
+			SAFE_SHMCTL(queues[num], IPC_RMID, NULL);
+	}
 
+	free(queues);
 }
+
+static struct tst_test test = {
+	.needs_tmpdir = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = verify_shmget,
+};
diff --git a/testcases/kernel/syscalls/ipc/shmget/shmget04.c b/testcases/kernel/syscalls/ipc/shmget/shmget04.c
index 60a263c77..d92dfe635 100644
--- a/testcases/kernel/syscalls/ipc/shmget/shmget04.c
+++ b/testcases/kernel/syscalls/ipc/shmget/shmget04.c
@@ -1,153 +1,71 @@
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
+ *  03/2001 - Written by Wayne Boyer
  */
 
-/*
- * NAME
- *	shmget04.c
- *
- * DESCRIPTION
- *	shmget04 - test for EACCES error
- *
- * ALGORITHM
- *	create a shared memory segment without read or write permissions
- *	loop if that option was specified
- *	  call shmget() with SHM_RW flag using TEST() macro
- *	  check the errno value
- *	    issue a PASS message if we get EACCES
- *	  otherwise, the tests fails
- *	    issue a FAIL message
- *	call cleanup
- *
- * USAGE:  <for command-line>
- *  shmget04 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -e   : Turn on errno logging.
- *	       -i n : Execute test n times.
- *	       -I x : Execute test for x seconds.
- *	       -P x : Pause for x seconds between iterations.
- *	       -t   : Turn on syscall timing.
+/*\
+ * [Description]
  *
- * HISTORY
- *	03/2001 - Written by Wayne Boyer
+ * Test for EACCES error.
  *
- * RESTRICTIONS
- *	none
+ * Create a shared memory segment without read or write permissions under
+ * unpriviledged user and call shmget() with SHM_RD/SHM_WR/SHM_RW flag to
+ * trigger EACCES error.
  */
+#include <errno.h>
+#include <sys/types.h>
+#include <sys/ipc.h>
+#include <stdlib.h>
 #include <pwd.h>
-#include "ipcshm.h"
-
-char *TCID = "shmget04";
-int TST_TOTAL = 1;
-
-char nobody_uid[] = "nobody";
-struct passwd *ltpuser;
-
-int shm_id_1 = -1;
-
-int main(int ac, char **av)
+#include <sys/shm.h>
+#include "tst_safe_sysv_ipc.h"
+#include "tst_test.h"
+#include "libnewipc.h"
+#include "lapi/shm.h"
+
+static int shm_id = -1;
+static key_t shmkey;
+static struct tcase {
+	char *message;
+	int flag;
+} tcases[] = {
+	{"Testing SHM_RD flag", SHM_RD},
+	{"Testing SHM_WR flag", SHM_WR},
+	{"Testing SHM_RW flag", SHM_RW},
+};
+
+static void verify_shmget(unsigned int n)
 {
-	int lc;
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
+	struct tcase *tc = &tcases[n];
 
-		/*
-		 * use the TEST() macro to make the call
-		 */
-
-		TEST(shmget(shmkey, SHM_SIZE, SHM_RW));
-
-		if (TEST_RETURN != -1) {
-			tst_resm(TFAIL, "call succeeded when error expected");
-			continue;
-		}
-
-		switch (TEST_ERRNO) {
-		case EACCES:
-			tst_resm(TPASS, "expected failure - errno = "
-				 "%d : %s", TEST_ERRNO, strerror(TEST_ERRNO));
-			break;
-		default:
-			tst_resm(TFAIL, "call failed with an "
-				 "unexpected error - %d : %s",
-				 TEST_ERRNO, strerror(TEST_ERRNO));
-			break;
-		}
-	}
-
-	cleanup();
-
-	tst_exit();
+	tst_res(TINFO, "%s", tc->message);
+	TST_EXP_FAIL(shmget(shmkey, SHM_SIZE, tc->flag), EACCES, "shmget(%i, %i, %i)",
+		shmkey, SHM_SIZE, tc->flag);
 }
 
-/*
- * setup() - performs all the ONE TIME setup for this test.
- */
-void setup(void)
+static void setup(void)
 {
-	tst_require_root();
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+	struct passwd *pw;
 
-	TEST_PAUSE;
+	pw = SAFE_GETPWNAM("nobody");
+	SAFE_SETUID(pw->pw_uid);
+	shmkey = GETIPCKEY();
 
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
-	shmkey = getipckey();
-
-	/* create a shared memory segment without read or access permissions */
-	if ((shm_id_1 = shmget(shmkey, SHM_SIZE, IPC_CREAT | IPC_EXCL)) == -1) {
-		tst_brkm(TBROK, cleanup, "Failed to create shared memory "
-			 "segment in setup");
-	}
+	shm_id = SAFE_SHMGET(shmkey, SHM_SIZE, IPC_CREAT | IPC_EXCL);
 }
 
-/*
- * cleanup() - performs all the ONE TIME cleanup for this test at completion
- * 	       or premature exit.
- */
-void cleanup(void)
+static void cleanup(void)
 {
-	/* if it exists, remove the shared memory resource */
-	rm_shm(shm_id_1);
-
-	tst_rmdir();
-
+	if (shm_id >= 0)
+		SAFE_SHMCTL(shm_id, IPC_RMID, NULL);
 }
+
+static struct tst_test test = {
+	.needs_tmpdir = 1,
+	.needs_root = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test = verify_shmget,
+	.tcnt = ARRAY_SIZE(tcases),
+};
diff --git a/testcases/kernel/syscalls/ipc/shmget/shmget05.c b/testcases/kernel/syscalls/ipc/shmget/shmget05.c
deleted file mode 100644
index de9544591..000000000
--- a/testcases/kernel/syscalls/ipc/shmget/shmget05.c
+++ /dev/null
@@ -1,185 +0,0 @@
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
- *	shmget05.c
- *
- * DESCRIPTION
- *	shmget05 - test for EACCES error
- *
- * ALGORITHM
- *	create a shared memory segment with root only read & write permissions
- *	fork a child process
- *	if child
- *	  set the ID of the child process to that of "nobody"
- *	  loop if that option was specified
- *	    call shmget() using the TEST() macro
- *	    check the errno value
- *	      issue a PASS message if we get EACCES
- *	    otherwise, the tests fails
- *	      issue a FAIL message
- *	  call cleanup
- *	if parent
- *	  wait for child to exit
- *	  remove the shared memory segment
- *
- * USAGE:  <for command-line>
- *  shmget05 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -e   : Turn on errno logging.
- *	       -i n : Execute test n times.
- *	       -I x : Execute test for x seconds.
- *	       -P x : Pause for x seconds between iterations.
- *	       -t   : Turn on syscall timing.
- *
- * HISTORY
- *	03/2001 - Written by Wayne Boyer
- *
- * RESTRICTIONS
- *	test must be run at root
- */
-
-#include "ipcshm.h"
-#include <sys/types.h>
-#include <sys/wait.h>
-#include "safe_macros.h"
-
-char *TCID = "shmget05";
-int TST_TOTAL = 1;
-
-int shm_id_1 = -1;
-
-uid_t ltp_uid;
-char *ltp_user = "nobody";
-
-int main(int ac, char **av)
-{
-	int pid;
-	void do_child(void);
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();		/* global setup */
-
-	if ((pid = FORK_OR_VFORK()) == -1) {
-		tst_brkm(TBROK, cleanup, "could not fork");
-	}
-
-	if (pid == 0) {		/* child */
-		/* set the user ID of the child to the non root user */
-		if (setuid(ltp_uid) == -1) {
-			tst_resm(TBROK, "setuid() failed");
-			exit(1);
-		}
-
-		do_child();
-
-		cleanup();
-
-	} else {		/* parent */
-		/* wait for the child to return */
-		SAFE_WAITPID(cleanup, pid, NULL, 0);
-
-		/* if it exists, remove the shared memory resource */
-		rm_shm(shm_id_1);
-
-		tst_rmdir();
-	}
-	tst_exit();
-}
-
-/*
- * do_child - make the TEST call as the child process
- */
-void do_child(void)
-{
-	int lc;
-
-	/* The following loop checks looping state if -i option given */
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset tst_count in case we are looping */
-		tst_count = 0;
-
-		/*
-		 * Look for a failure ...
-		 */
-
-		TEST(shmget(shmkey, SHM_SIZE, SHM_RW));
-
-		if (TEST_RETURN != -1) {
-			tst_resm(TFAIL, "call succeeded when error expected");
-			continue;
-		}
-
-		switch (TEST_ERRNO) {
-		case EACCES:
-			tst_resm(TPASS, "expected failure - errno = "
-				 "%d : %s", TEST_ERRNO, strerror(TEST_ERRNO));
-			break;
-		default:
-			tst_resm(TFAIL, "call failed with an "
-				 "unexpected error - %d : %s",
-				 TEST_ERRNO, strerror(TEST_ERRNO));
-			break;
-		}
-	}
-}
-
-/*
- * setup() - performs all the ONE TIME setup for this test.
- */
-void setup(void)
-{
-	tst_require_root();
-
-	tst_sig(FORK, DEF_HANDLER, cleanup);
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
-
-	/* create a shared memory segment with read and write permissions */
-	if ((shm_id_1 = shmget(shmkey, SHM_SIZE,
-			       SHM_RW | IPC_CREAT | IPC_EXCL)) == -1) {
-		tst_brkm(TBROK, cleanup, "Failed to create shared memory "
-			 "segment in setup");
-	}
-
-	/* get the userid for a non root user */
-	ltp_uid = getuserid(ltp_user);
-}
-
-/*
- * cleanup() - performs all the ONE TIME cleanup for this test at completion
- * 	       or premature exit.
- */
-void cleanup(void)
-{
-
-}
-- 
2.23.0

