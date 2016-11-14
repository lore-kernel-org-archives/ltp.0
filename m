From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Mon, 14 Nov 2016 17:44:54 +0800
Subject: [LTP] [PATCH 4/4] syscalls/setpriority02: Reconstruct && Convert to
	new API
In-Reply-To: <1479116694-23167-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
References: <1479116694-23167-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
Message-ID: <1479116694-23167-4-git-send-email-fenggw-fnst@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

* merge setpriority03, 04 and 05 into setpriority02
* add test for EACCES with PRIO_PGRP flag
* add tests for ESRCH with PRIO_PGRP and PRIO_USER flag

Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
---
 runtest/ltplite                                    |   3 -
 runtest/stress.part3                               |   3 -
 runtest/syscalls                                   |   3 -
 .../kernel/syscalls/setpriority/setpriority02.c    | 222 ++++++++++-----------
 .../kernel/syscalls/setpriority/setpriority03.c    | 133 ------------
 .../kernel/syscalls/setpriority/setpriority04.c    | 134 -------------
 .../kernel/syscalls/setpriority/setpriority05.c    | 143 -------------
 7 files changed, 106 insertions(+), 535 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/setpriority/setpriority03.c
 delete mode 100644 testcases/kernel/syscalls/setpriority/setpriority04.c
 delete mode 100644 testcases/kernel/syscalls/setpriority/setpriority05.c

diff --git a/runtest/ltplite b/runtest/ltplite
index c8d0ebf..a05d3ed 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -787,9 +787,6 @@ setpgrp02 setpgrp02
 
 setpriority01 setpriority01
 setpriority02 setpriority02
-setpriority03 setpriority03
-setpriority04 setpriority04
-setpriority05 setpriority05
 
 setregid01 setregid01
 setregid02 setregid02
diff --git a/runtest/stress.part3 b/runtest/stress.part3
index aac1c00..274c8a4 100644
--- a/runtest/stress.part3
+++ b/runtest/stress.part3
@@ -678,9 +678,6 @@ setpgrp02 setpgrp02
 
 setpriority01 setpriority01
 setpriority02 setpriority02
-setpriority03 setpriority03
-setpriority04 setpriority04
-setpriority05 setpriority05
 
 setregid01 setregid01
 setregid02 setregid02
diff --git a/runtest/syscalls b/runtest/syscalls
index 64d09b2..2f2dde5 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1068,9 +1068,6 @@ setpgrp02 setpgrp02
 
 setpriority01 setpriority01
 setpriority02 setpriority02
-setpriority03 setpriority03
-setpriority04 setpriority04
-setpriority05 setpriority05
 
 setregid01 setregid01
 setregid01_16 setregid01_16
diff --git a/testcases/kernel/syscalls/setpriority/setpriority02.c b/testcases/kernel/syscalls/setpriority/setpriority02.c
index e49b5f2..c6b2e99 100644
--- a/testcases/kernel/syscalls/setpriority/setpriority02.c
+++ b/testcases/kernel/syscalls/setpriority/setpriority02.c
@@ -1,143 +1,133 @@
 /*
+ * Copyright (c) International Business Machines  Corp., 2001
+ *  03/2001 Written by Wayne Boyer
+ *  11/2016 Modified by Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
  *
- *   Copyright (c) International Business Machines  Corp., 2001
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
  *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
  *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 /*
- * NAME
- *	setpriority02.c
- *
- * DESCRIPTION
- *	setpriority02 - test for an expected failure by trying to raise
- *			the priority for the test process while not having
- *			permissions to do so.
- *
- * ALGORITHM
- *	loop if that option was specified
- *	issue the system call
- *	check the errno value
- *	  issue a PASS message if we get EACCESS - errno 13
- *	otherwise, the tests fails
- *	  issue a FAIL message
- *	  break any remaining tests
- *	  call cleanup
- *
- * USAGE:  <for command-line>
- *  setpriority02 [-c n] [-e] [-i n] [-I x] [-p x] [-t]
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
+ * Verify that,
+ *  1) setpriority(2) fails with -1 and sets errno to EINVAL if 'which'
+ *     argument was not one of PRIO_PROCESS, PRIO_PGRP, or PRIO_USER.
+ *  2) setpriority(2) fails with -1 and sets errno to ESRCH if no
+ *     process was located for 'which' and 'who' arguments.
+ *  3) setpriority(2) fails with -1 and sets errno to EACCES if an
+ *     unprivileged user attempted to lower a process priority.
+ *  4) setpriority(2) fails with -1 and sets errno to EPERM if an
+ *     unprivileged user attempted to change a process which ID is
+ *     different from the test process.
  */
 
-#include "test.h"
-
 #include <errno.h>
-#include <sys/time.h>
-#include <sys/resource.h>
 #include <pwd.h>
-
-void cleanup(void);
-void setup(void);
-
-char *TCID = "setpriority02";
-int TST_TOTAL = 1;
-char nobody_uid[] = "nobody";
-struct passwd *ltpuser;
-
-int main(int ac, char **av)
+#include <stdlib.h>
+#include <sys/resource.h>
+#include <sys/time.h>
+#include <sys/types.h>
+#include "tst_test.h"
+
+#define NEW_PRIO	-2
+#define INVAL_FLAG	-1
+#define INVAL_ID	-1
+#define INIT_PID	1
+
+static uid_t uid;
+
+static struct tcase {
+	int which;
+	int who;
+	int prio;
+	int exp_errno;
+	int unprivil;
+} tcases[] = {
+	/* test 1 */
+	{INVAL_FLAG, 0, NEW_PRIO, EINVAL, 0},
+
+	/* test 2 */
+	{PRIO_PROCESS, INVAL_ID, NEW_PRIO, ESRCH, 0},
+	{PRIO_PGRP, INVAL_ID, NEW_PRIO, ESRCH, 0},
+	{PRIO_USER, INVAL_ID, NEW_PRIO, ESRCH, 0},
+
+	/* test 3 */
+	{PRIO_PROCESS, 0, NEW_PRIO, EACCES, 1},
+	{PRIO_PGRP, 0, NEW_PRIO, EACCES, 1},
+
+	/* test 4 */
+	{PRIO_PROCESS, INIT_PID, NEW_PRIO, EPERM, 1}
+};
+
+static void setpriority_test(struct tcase *tc)
 {
-	int lc;
-	int new_val = -2;
-
-	tst_parse_opts(ac, av, NULL, NULL);
+	char *desc = "";
 
-	setup();		/* global setup */
+	if (tc->unprivil)
+		desc = "as unprivileged user ";
 
-	/* The following loop checks looping state if -i option given */
+	TEST(setpriority(tc->which, tc->who, tc->prio));
 
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset tst_count in case we are looping */
-		tst_count = 0;
-
-		/*
-		 * Try to raise the priority of this process from a default of
-		 * 0 to a new value of -2.  This should give an EACCES error.
-		 */
-
-		/* call the system call with the TEST() macro */
-		TEST(setpriority(PRIO_PROCESS, 0, new_val));
-
-		if (TEST_RETURN == 0) {
-			tst_resm(TFAIL, "call failed to produce expected error "
-				 "- errno = %d - %s", TEST_ERRNO,
-				 strerror(TEST_ERRNO));
-			continue;
-		}
+	if (TEST_RETURN != -1) {
+		tst_res(TFAIL,
+			"setpriority(%d, %d, %d) %ssucceeds unexpectedly",
+			tc->which, tc->who, tc->prio, desc);
+		return;
+	}
 
-		switch (TEST_ERRNO) {
-		case EACCES:
-			tst_resm(TPASS, "expected failure - errno = %d - %s",
-				 TEST_ERRNO, strerror(TEST_ERRNO));
-			break;
-		default:
-			tst_resm(TFAIL, "call failed to produce expected error "
-				 "- errno = %d - %s", TEST_ERRNO,
-				 strerror(TEST_ERRNO));
-		}
+	if (TEST_ERRNO != tc->exp_errno) {
+		tst_res(TFAIL | TTERRNO,
+			"setpriority(%d, %d, %d) %sshould fail with %s",
+			tc->which, tc->who, tc->prio, desc,
+			tst_strerrno(tc->exp_errno));
+		return;
 	}
-	cleanup();
-	tst_exit();
 
+	tst_res(TPASS | TTERRNO,
+		"setpriority(%d, %d, %d) %sfails as expected",
+		tc->which, tc->who, tc->prio, desc);
 }
 
-/*
- * setup() - performs all the ONE TIME setup for this test.
- */
-void setup(void)
+static void verify_setpriority(unsigned int n)
 {
-	tst_require_root();
-
-	/* Switch to nobody user for correct error code collection */
-	ltpuser = getpwnam(nobody_uid);
-	if (seteuid(ltpuser->pw_uid) == -1) {
-		tst_resm(TINFO, "setreuid failed to "
-			 "to set the effective uid to %d", ltpuser->pw_uid);
-		perror("setreuid");
-	}
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+	struct tcase *tc = &tcases[n];
+
+	if (tc->unprivil) {
+		if (!SAFE_FORK()) {
+			SAFE_SETUID(uid);
+			SAFE_SETPGID(0, 0);
+			setpriority_test(tc);
+			exit(0);
+		}
 
-	TEST_PAUSE;
+		tst_reap_children();
+	} else {
+		setpriority_test(tc);
+	}
 }
 
-/*
- * cleanup() - performs all the ONE TIME cleanup for this test at completion
- *	       or premature exit.
- */
-void cleanup(void)
+static void setup(void)
 {
+	struct passwd *ltpuser;
 
+	ltpuser = SAFE_GETPWNAM("nobody");
+	uid = ltpuser->pw_uid;
 }
+
+static struct tst_test test = {
+	.tid = "setpriority02",
+	.tcnt = ARRAY_SIZE(tcases),
+	.needs_root = 1,
+	.forks_child = 1,
+	.setup = setup,
+	.test = verify_setpriority,
+};
diff --git a/testcases/kernel/syscalls/setpriority/setpriority03.c b/testcases/kernel/syscalls/setpriority/setpriority03.c
deleted file mode 100644
index e61899e..0000000
--- a/testcases/kernel/syscalls/setpriority/setpriority03.c
+++ /dev/null
@@ -1,133 +0,0 @@
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
- *	setpriority03.c
- *
- * DESCRIPTION
- *	setpriority03 - test for an expected failure by using an invalid
- *			PRIO value
- *
- * CALLS
- *	setpriority()
- *
- * ALGORITHM
- *	loop if that option was specified
- *	issue the system call
- *	check the errno value
- *	  issue a PASS message if we get EINVAL - errno 22
- *	otherwise, the tests fails
- *	  issue a FAIL message
- *	  break any remaining tests
- *	  call cleanup
- *
- * USAGE:  <for command-line>
- *  setpriority03 [-c n] [-e] [-i n] [-I x] [-p x] [-t]
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
- */
-
-#include "test.h"
-
-#include <errno.h>
-#include <sys/time.h>
-#include <sys/resource.h>
-
-void cleanup(void);
-void setup(void);
-
-char *TCID = "setpriority03";
-int TST_TOTAL = 1;
-
-int main(int ac, char **av)
-{
-	int lc;
-	int new_val = 2;
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
-		 * Use an invalid PRIO value by making it negative.
-		 * This should give an EINVAL error.
-		 * PRIO_PROCESS = 0, PRIO_PGRP = 1, PRIO_USER = 2
-		 */
-
-		/* call the system call with the TEST() macro */
-		TEST(setpriority(-PRIO_PGRP, 0, new_val));
-
-		if (TEST_RETURN == 0) {
-			tst_resm(TFAIL, "call failed to produce expected error "
-				 "- errno = %d - %s", TEST_ERRNO,
-				 strerror(TEST_ERRNO));
-		}
-
-		switch (TEST_ERRNO) {
-		case EINVAL:
-			tst_resm(TPASS, "expected failure - errno = %d - %s",
-				 TEST_ERRNO, strerror(TEST_ERRNO));
-			break;
-		default:
-			tst_resm(TFAIL, "call failed to produce expected error "
-				 "- errno = %d - %s", TEST_ERRNO,
-				 strerror(TEST_ERRNO));
-		}
-	}
-	cleanup();
-	tst_exit();
-
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
-}
-
-/*
- * cleanup() - performs all the ONE TIME cleanup for this test at completion
- *	       or premature exit.
- */
-void cleanup(void)
-{
-
-}
diff --git a/testcases/kernel/syscalls/setpriority/setpriority04.c b/testcases/kernel/syscalls/setpriority/setpriority04.c
deleted file mode 100644
index 162a364..0000000
--- a/testcases/kernel/syscalls/setpriority/setpriority04.c
+++ /dev/null
@@ -1,134 +0,0 @@
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
- *	setpriority04.c
- *
- * DESCRIPTION
- *	setpriority04 - test for an expected failure by using an invalid
- *			process id
- *
- * ALGORITHM
- *	loop if that option was specified
- *	issue the system call with an invalid process id
- *	check the errno value
- *	  issue a PASS message if we get ESRCH - errno 3
- *	otherwise, the tests fails
- *	  issue a FAIL message
- *	  break any remaining tests
- *	  call cleanup
- *
- * USAGE:  <for command-line>
- *  setpriority04 [-c n] [-e] [-i n] [-I x] [-p x] [-t]
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
- */
-
-#include "test.h"
-
-#include <errno.h>
-#include <sys/time.h>
-#include <sys/resource.h>
-
-void cleanup(void);
-void setup(void);
-
-char *TCID = "setpriority04";
-int TST_TOTAL = 1;
-
-int main(int ac, char **av)
-{
-	int lc;
-	int new_val = 2;
-	pid_t unused_pid;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();		/* global setup */
-
-	unused_pid = tst_get_unused_pid(cleanup);
-
-	/* The following loop checks looping state if -i option given */
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset tst_count in case we are looping */
-		tst_count = 0;
-
-		/*
-		 * Try to access an invalid process.
-		 * This should give an ESRCH error.
-		 */
-
-		/* call the system call with the TEST() macro */
-		TEST(setpriority(PRIO_PROCESS, unused_pid, new_val));
-
-		if (TEST_RETURN == 0) {
-			tst_resm(TFAIL, "call failed to produce expected error "
-				 "- errno = %d - %s", TEST_ERRNO,
-				 strerror(TEST_ERRNO));
-			continue;
-		}
-
-		switch (TEST_ERRNO) {
-		case ESRCH:
-			tst_resm(TPASS, "expected failure - errno = %d - %s",
-				 TEST_ERRNO, strerror(TEST_ERRNO));
-			break;
-		default:
-			tst_resm(TFAIL, "call failed to produce expected error "
-				 "- errno = %d - %s", TEST_ERRNO,
-				 strerror(TEST_ERRNO));
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
-}
-
-/*
- * cleanup() - performs all the ONE TIME cleanup for this test at completion
- *	       or premature exit.
- */
-void cleanup(void)
-{
-
-}
diff --git a/testcases/kernel/syscalls/setpriority/setpriority05.c b/testcases/kernel/syscalls/setpriority/setpriority05.c
deleted file mode 100644
index 04ffea4..0000000
--- a/testcases/kernel/syscalls/setpriority/setpriority05.c
+++ /dev/null
@@ -1,143 +0,0 @@
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
- *	setpriority05.c
- *
- * DESCRIPTION
- *	setpriority05 - test for an expected failure by trying to change
- *			a process with an ID that is different from the
- *			test process
- *
- * ALGORITHM
- *	loop if that option was specified
- *	issue the system call with init's process id (1)
- *	check the errno value
- *	  issue a PASS message if we get EPERM - errno 1
- *	otherwise, the tests fails
- *	  issue a FAIL message
- *	  break any remaining tests
- *	  call cleanup
- *
- * USAGE:  <for command-line>
- *  setpriority05 [-c n] [-e] [-i n] [-I x] [-p x] [-t]
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
- */
-
-#include "test.h"
-
-#include <errno.h>
-#include <sys/time.h>
-#include <sys/resource.h>
-#include <pwd.h>
-
-void cleanup(void);
-void setup(void);
-
-char *TCID = "setpriority05";
-int TST_TOTAL = 1;
-char nobody_uid[] = "nobody";
-struct passwd *ltpuser;
-
-int main(int ac, char **av)
-{
-	int lc;
-	int new_val = 2;
-	int init_val = 1;	/* the init process = id 1 */
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
-		 * Try to access the init process.
-		 * This should give an EPERM error.
-		 */
-
-		/* call the system call with the TEST() macro */
-		TEST(setpriority(PRIO_PROCESS, init_val, new_val));
-
-		if (TEST_RETURN == 0) {
-			tst_resm(TFAIL, "call failed to produce expected error "
-				 "- errno = %d - %s", TEST_ERRNO,
-				 strerror(TEST_ERRNO));
-		}
-
-		switch (TEST_ERRNO) {
-		case EPERM:
-			tst_resm(TPASS, "expected failure - errno = %d - %s",
-				 TEST_ERRNO, strerror(TEST_ERRNO));
-			break;
-		default:
-			tst_resm(TFAIL, "call failed to produce expected error "
-				 "- errno = %d - %s", TEST_ERRNO,
-				 strerror(TEST_ERRNO));
-		}
-	}
-	cleanup();
-	tst_exit();
-
-}
-
-/*
- * setup() - performs all the ONE TIME setup for this test.
- */
-void setup(void)
-{
-	tst_require_root();
-
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
-}
-
-/*
- * cleanup() - performs all the ONE TIME cleanup for this test at completion
- *	       or premature exit.
- */
-void cleanup(void)
-{
-
-}
-- 
1.8.4.2



