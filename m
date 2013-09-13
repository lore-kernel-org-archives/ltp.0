Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1VKQ9u-0007WH-Oc
	for ltp-list@lists.sourceforge.net; Fri, 13 Sep 2013 09:59:26 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VKQ9s-0005LX-AS
	for ltp-list@lists.sourceforge.net; Fri, 13 Sep 2013 09:59:26 +0000
Received: from acsinet21.oracle.com (acsinet21.oracle.com [141.146.126.237])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id r8D9xIE0024335
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 13 Sep 2013 09:59:18 GMT
Received: from aserz7021.oracle.com (aserz7021.oracle.com [141.146.126.230])
	by acsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r8D9xHvV007193
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Fri, 13 Sep 2013 09:59:17 GMT
Received: from abhmt112.oracle.com (abhmt112.oracle.com [141.146.116.64])
	by aserz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r8D9xHWv007186
	for <ltp-list@lists.sourceforge.net>; Fri, 13 Sep 2013 09:59:17 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Fri, 13 Sep 2013 13:59:10 +0400
Message-Id: <1379066350-20317-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH] setfsgid, setfsuid: clean up and 16-bit version fixes
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: vasily.isaenko@oracle.com

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 testcases/kernel/syscalls/setfsgid/setfsgid01.c |   97 ++++--------
 testcases/kernel/syscalls/setfsgid/setfsgid02.c |   95 ++++--------
 testcases/kernel/syscalls/setfsgid/setfsgid03.c |  118 ++++++---------
 testcases/kernel/syscalls/setfsuid/setfsuid01.c |   97 ++++--------
 testcases/kernel/syscalls/setfsuid/setfsuid02.c |   96 ++++--------
 testcases/kernel/syscalls/setfsuid/setfsuid03.c |  118 +++++----------
 testcases/kernel/syscalls/setfsuid/setfsuid04.c |  183 +++++++++-------------
 testcases/kernel/syscalls/utils/compat_16.h     |   13 ++
 8 files changed, 297 insertions(+), 520 deletions(-)

diff --git a/testcases/kernel/syscalls/setfsgid/setfsgid01.c b/testcases/kernel/syscalls/setfsgid/setfsgid01.c
index fc2af5b..da21cd3 100644
--- a/testcases/kernel/syscalls/setfsgid/setfsgid01.c
+++ b/testcases/kernel/syscalls/setfsgid/setfsgid01.c
@@ -1,62 +1,41 @@
 /*
+ * Copyright (c) International Business Machines  Corp., 2001
+ * Ported by Wayne Boyer
  *
- *   Copyright (c) International Business Machines  Corp., 2001
+ * This program is free software;  you can redistribute it and/or modify
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
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ * the GNU General Public License for more details.
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
+ * along with this program;  if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
 
 /*
- * NAME
- *	setfsgid01.c
- *
- * DESCRIPTION
- *	Testcase to check the basic functionality of setfsgid(2) system
- *	call.
- *
- * ALGORITHM
- *	Call setfsgid() and test the return value.
- *	If this value is not same as that of the user's gid, then fail.
- *
- * USAGE:  <for command-line>
- *  setfsgid01 [-c n] [-f] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -f   : Turn off functionality Testing.
- *             -i n : Execute test n times.
- *             -I x : Execute test for x seconds.
- *             -P x : Pause for x seconds between iterations.
- *             -t   : Turn on syscall timing.
- *
- * HISTORY
- *	07/2001 Ported by Wayne Boyer
- *
- * RESTRICTIONS
- *	None
+ * Testcase to check the basic functionality of setfsgid(2) system call.
  */
+
 #include <stdio.h>
 #include <unistd.h>
 #include <sys/fsuid.h>
 #include <sys/types.h>
 #include <errno.h>
+
 #include "test.h"
 #include "usctest.h"
+#include "compat_16.h"
 
-char *TCID = "setfsgid01";
+TCID_DEFINE(setfsgid01);
 int TST_TOTAL = 1;
 
-void setup(void);
-void cleanup(void);
+static void setup(void);
+static void cleanup(void);
 
 int main(int ac, char **av)
 {
@@ -71,23 +50,22 @@ int main(int ac, char **av)
 
 	setup();
 
-	/* Check for looping state if -i option is given */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset tst_count in case we are looping */
 		tst_count = 0;
 
 		gid = getegid();
+		GID16_CHECK(gid, setfsgid, cleanup);
 
-		TEST(setfsgid(gid));
+		TEST(SETFSGID(cleanup, gid));
 
 		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL, "call failed unexpectedly - errno %d",
-				 TEST_ERRNO);
+			tst_resm(TFAIL | TERRNO,
+				"setfsgid() failed unexpectedly");
 			continue;
 		}
 
 		if (!STD_FUNCTIONAL_TEST) {
-			tst_resm(TPASS, "call succeeded");
+			tst_resm(TPASS, "setfsgid() succeeded");
 			continue;
 		}
 
@@ -95,37 +73,24 @@ int main(int ac, char **av)
 			tst_resm(TFAIL, "setfsgid() returned %ld, expected %d",
 				 TEST_RETURN, gid);
 		} else {
-			tst_resm(TPASS, "setfsgid() returned expected value : "
-				 "%d", gid);
+			tst_resm(TPASS,
+				"setfsgid() returned expected value : %ld",
+				TEST_RETURN);
 		}
 	}
+
 	cleanup();
 	tst_exit();
-	tst_exit();
-
 }
 
-/*
- * setup() - performs all ONE TIME setup for this test.
- */
-void setup()
+static void setup()
 {
-
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	TEST_PAUSE;
 }
 
-/*
- * cleanup() - performs all ONE TIME cleanup for this test at
- *	       completion or premature exit.
- */
-void cleanup()
+static void cleanup()
 {
-	/*
-	 * print timing stats if that option was specified.
-	 * print errno log if that option was specified.
-	 */
 	TEST_CLEANUP;
-
 }
diff --git a/testcases/kernel/syscalls/setfsgid/setfsgid02.c b/testcases/kernel/syscalls/setfsgid/setfsgid02.c
index c4c6880..296adc1 100644
--- a/testcases/kernel/syscalls/setfsgid/setfsgid02.c
+++ b/testcases/kernel/syscalls/setfsgid/setfsgid02.c
@@ -1,49 +1,28 @@
 /*
+ * Copyright (C) International Business Machines  Corp., 2001
+ * Ported by Wayne Boyer
+ * Adapted by Dustin Kirkland (k1rkland@us.ibm.com)
  *
- *   Copyright (C) International Business Machines  Corp., 2001
+ * This program is free software;  you can redistribute it and/or modify
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
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ * the GNU General Public License for more details.
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
+ * along with this program;  if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
 
 /*
- * NAME
- *	setfsgid02.c
- *
- * DESCRIPTION
- *	Testcase to check the basic functionality of setfsgid(2) system
- *	call failures.
- *
- * ALGORITHM
- *	Call setfsgid() and test the return value when invalid gid used.
- *
- * USAGE:  <for command-line>
- *  setfsgid01 [-c n] [-f] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -f   : Turn off functionality Testing.
- *             -i n : Execute test n times.
- *             -I x : Execute test for x seconds.
- *             -P x : Pause for x seconds between iterations.
- *             -t   : Turn on syscall timing.
- *
- * HISTORY
- *	07/2001 Ported by Wayne Boyer
- *      04/2003 Adapted by Dustin Kirkland (k1rkland@us.ibm.com)
- *
- * RESTRICTIONS
- *	None
+ *     Testcase to check the basic functionality of setfsgid(2) system
+ *     call failures.
  */
+
 #include <stdio.h>
 #include <unistd.h>
 #include <grp.h>
@@ -53,14 +32,16 @@
 #ifdef __GLIBC__
 #include <sys/fsuid.h>
 #endif
+
 #include "test.h"
 #include "usctest.h"
+#include "compat_16.h"
 
-char *TCID = "setfsgid02";
+TCID_DEFINE(setfsgid02);
 int TST_TOTAL = 1;
 
-void setup(void);
-void cleanup(void);
+static void setup(void);
+static void cleanup(void);
 
 int main(int ac, char **av)
 {
@@ -75,26 +56,25 @@ int main(int ac, char **av)
 
 	setup();
 
-	/* Check for looping state if -i option is given */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset tst_count in case we are looping */
 		tst_count = 0;
 
 		gid = 1;
 		while (getgrgid(gid)) {
 			gid++;
 		}
+		GID16_CHECK(gid, setfsgid, cleanup);
 
-		TEST(setfsgid(gid));
+		TEST(SETFSGID(cleanup, gid));
 
 		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL, "call failed unexpectedly - errno %d",
-				 TEST_ERRNO);
+			tst_resm(TFAIL | TERRNO,
+				"setfsgid() failed unexpectedly");
 			continue;
 		}
 
 		if (!STD_FUNCTIONAL_TEST) {
-			tst_resm(TPASS, "call succeeded");
+			tst_resm(TPASS, "setfsgid() succeeded");
 			continue;
 		}
 
@@ -106,32 +86,19 @@ int main(int ac, char **av)
 				 "%ld", TEST_RETURN);
 		}
 	}
-	cleanup();
 
-	return EXIT_SUCCESS;
+	cleanup();
+	tst_exit();
 }
 
-/*
- * setup() - performs all ONE TIME setup for this test.
- */
-void setup()
+static void setup()
 {
-
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	TEST_PAUSE;
 }
 
-/*
- * cleanup() - performs all ONE TIME cleanup for this test at
- *	       completion or premature exit.
- */
-void cleanup()
+static void cleanup()
 {
-	/*
-	 * print timing stats if that option was specified.
-	 * print errno log if that option was specified.
-	 */
 	TEST_CLEANUP;
-
 }
diff --git a/testcases/kernel/syscalls/setfsgid/setfsgid03.c b/testcases/kernel/syscalls/setfsgid/setfsgid03.c
index 8345160..a38b685 100644
--- a/testcases/kernel/syscalls/setfsgid/setfsgid03.c
+++ b/testcases/kernel/syscalls/setfsgid/setfsgid03.c
@@ -1,49 +1,28 @@
 /*
+ * Copyright (C) International Business Machines  Corp., 2001
+ * Ported by Wayne Boyer
+ * Adapted by Dustin Kirkland (k1rkland@us.ibm.com)
  *
- *   Copyright (C) International Business Machines  Corp., 2001
+ * This program is free software;  you can redistribute it and/or modify
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
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ * the GNU General Public License for more details.
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
+ * along with this program;  if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
 
 /*
- * NAME
- *	setfsgid03.c
- *
- * DESCRIPTION
- *	Testcase to check the basic functionality of setfsgid(2) system
- *	call fails when called by a non-root user.
- *
- * ALGORITHM
- *	Call setfsgid() and test the return value.
- *
- * USAGE:  <for command-line>
- *  setfsgid01 [-c n] [-f] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -f   : Turn off functionality Testing.
- *             -i n : Execute test n times.
- *             -I x : Execute test for x seconds.
- *             -P x : Pause for x seconds between iterations.
- *             -t   : Turn on syscall timing.
- *
- * HISTORY
- *	07/2001 Ported by Wayne Boyer
- *      04/2003 Adapted by Dustin Kirkland (k1rkland@us.ibm.com)
- *
- * RESTRICTIONS
- *	None
+ * Testcase to check the basic functionality of setfsgid(2) system
+ * call fails when called by a non-root user.
  */
+
 #include <stdio.h>
 #include <unistd.h>
 #include <sys/types.h>
@@ -53,16 +32,19 @@
 #ifdef __GLIBC__
 #include <sys/fsuid.h>
 #endif
+
 #include "test.h"
 #include "usctest.h"
+#include "compat_16.h"
 
-char *TCID = "setfsgid03";
+TCID_DEFINE(setfsgid03);
 int TST_TOTAL = 1;
-char nobody_uid[] = "nobody";
-struct passwd *ltpuser;
 
-void setup(void);
-void cleanup(void);
+static char nobody_uid[] = "nobody";
+static struct passwd *ltpuser;
+
+static void setup(void);
+static void cleanup(void);
 
 int main(int ac, char **av)
 {
@@ -77,26 +59,25 @@ int main(int ac, char **av)
 
 	setup();
 
-	/* Check for looping state if -i option is given */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset tst_count in case we are looping */
 		tst_count = 0;
 
 		gid = 1;
 		while (!getgrgid(gid)) {
 			gid++;
 		}
+		GID16_CHECK(gid, setfsgid, cleanup);
 
-		TEST(setfsgid(gid));
+		TEST(SETFSGID(cleanup, gid));
 
 		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL, "call failed unexpectedly - errno %d",
-				 TEST_ERRNO);
+			tst_resm(TFAIL | TERRNO,
+				"setfsgid() failed unexpectedly");
 			continue;
 		}
 
 		if (!STD_FUNCTIONAL_TEST) {
-			tst_resm(TPASS, "call succeeded");
+			tst_resm(TPASS, "setfsgid() succeeded");
 			continue;
 		}
 
@@ -109,42 +90,31 @@ int main(int ac, char **av)
 				 "%ld", TEST_RETURN);
 		}
 	}
-	cleanup();
 
-	return EXIT_SUCCESS;
+	cleanup();
+	tst_exit();
 }
 
-/*
- * setup() - performs all ONE TIME setup for this test.
- */
-void setup()
+static void setup()
 {
-	/* Switch to nobody user for correct error code collection */
-	if (geteuid() != 0) {
-		tst_brkm(TBROK, NULL, "Test must be run as root");
-	}
+	tst_require_root(NULL);
+
 	ltpuser = getpwnam(nobody_uid);
-	if (setuid(ltpuser->pw_uid) == -1) {
-		tst_resm(TINFO, "setuid failed to "
-			 "to set the effective uid to %d", ltpuser->pw_uid);
-		perror("setuid");
-	}
+	if (ltpuser == NULL)
+		tst_brkm(TBROK, cleanup, "getpwnam failed for user id %s",
+			nobody_uid);
+
+	if (setuid(ltpuser->pw_uid) == -1)
+		tst_resm(TINFO | TERRNO,
+			"setuid failed to set the effective uid to %d",
+			ltpuser->pw_uid);
 
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	TEST_PAUSE;
 }
 
-/*
- * cleanup() - performs all ONE TIME cleanup for this test at
- *	       completion or premature exit.
- */
-void cleanup()
+static void cleanup()
 {
-	/*
-	 * print timing stats if that option was specified.
-	 * print errno log if that option was specified.
-	 */
 	TEST_CLEANUP;
-
 }
diff --git a/testcases/kernel/syscalls/setfsuid/setfsuid01.c b/testcases/kernel/syscalls/setfsuid/setfsuid01.c
index 0fa1629..3d3896d 100644
--- a/testcases/kernel/syscalls/setfsuid/setfsuid01.c
+++ b/testcases/kernel/syscalls/setfsuid/setfsuid01.c
@@ -1,62 +1,40 @@
 /*
+ * Copyright (c) International Business Machines  Corp., 2001
+ * Ported by Wayne Boyer
  *
- *   Copyright (c) International Business Machines  Corp., 2001
+ * This program is free software;  you can redistribute it and/or modify
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
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ * the GNU General Public License for more details.
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
+ * along with this program;  if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
 
 /*
- * NAME
- *	setfsuid01.c
- *
- * DESCRIPTION
- *	Testcase to test the basic functionality of the setfsuid(2) system
- *	call.
- *
- * ALGORITHM
- *	Call setfsuid(2) and test the uid returned by setfsuid(2).
- *	If the returned value doesn't match the uid of the process,
- *	then the testcase fails.
- *
- * USAGE:  <for command-line>
- *  setfsuid01 [-c n] [-f] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -f   : Turn off functionality Testing.
- *             -i n : Execute test n times.
- *             -I x : Execute test for x seconds.
- *             -P x : Pause for x seconds between iterations.
- *             -t   : Turn on syscall timing.
- *
- * HISTORY
- *	07/2001 Ported by Wayne Boyer
- *
- * RESTRICTIONS
- *	None
+ * Testcase to test the basic functionality of the setfsuid(2) system call.
  */
+
 #include <sys/types.h>
 #include <sys/fsuid.h>
 #include <stdio.h>
 #include <unistd.h>
 #include <errno.h>
+
 #include "test.h"
 #include "usctest.h"
+#include "compat_16.h"
 
-void setup(void);
-void cleanup(void);
+static void setup(void);
+static void cleanup(void);
 
-char *TCID = "setfsuid01";
+TCID_DEFINE(setfsuid01);
 int TST_TOTAL = 1;
 
 int main(int ac, char **av)
@@ -73,23 +51,22 @@ int main(int ac, char **av)
 	setup();
 
 	uid = geteuid();
+	UID16_CHECK(uid, setfsuid, cleanup);
 
-	/* Check for looping state if -i option is given */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		/* reset tst_count in case we are looping */
 		tst_count = 0;
 
-		TEST(setfsuid(uid));
+		TEST(SETFSUID(cleanup, uid));
 
 		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL, "call failed unexpectedly - errno %d",
-				 TEST_ERRNO);
+			tst_resm(TFAIL | TERRNO,
+				"setfsuid() failed unexpectedly");
 			continue;
 		}
 
 		if (!STD_FUNCTIONAL_TEST) {
-			tst_resm(TPASS, "call succeeded");
+			tst_resm(TPASS, "setfsuid() succeeded");
 			continue;
 		}
 
@@ -97,36 +74,24 @@ int main(int ac, char **av)
 			tst_resm(TFAIL, "setfsuid() returned %ld, expected %d",
 				 TEST_RETURN, uid);
 		} else {
-			tst_resm(TPASS, "setfsuid() returned expected value : "
-				 "%d", uid);
+			tst_resm(TPASS,
+				"setfsuid() returned expected value : %ld",
+				TEST_RETURN);
 		}
 	}
+
 	cleanup();
 	tst_exit();
-	tst_exit();
-
 }
 
-/*
- * setup() - performs all ONE TIME setup for this test.
- */
-void setup()
+static void setup()
 {
-
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	TEST_PAUSE;
 }
 
-/*
- * cleanup() - performs all ONE TIME cleanup for this test at
- *	       completion or premature exit.
- */
-void cleanup()
+static void cleanup()
 {
-	/*
-	 * print timing stats if that option was specified.
-	 * print errno log if that option was specified.
-	 */
 	TEST_CLEANUP;
 }
diff --git a/testcases/kernel/syscalls/setfsuid/setfsuid02.c b/testcases/kernel/syscalls/setfsuid/setfsuid02.c
index dce6191..baf1993 100644
--- a/testcases/kernel/syscalls/setfsuid/setfsuid02.c
+++ b/testcases/kernel/syscalls/setfsuid/setfsuid02.c
@@ -1,52 +1,28 @@
 /*
+ * Copyright (C) International Business Machines  Corp., 2001
+ * Ported by Wayne Boyer
+ * Adapted by Dustin Kirkland (k1rkland@us.ibm.com)
  *
- *   Copyright (C) International Business Machines  Corp., 2001
+ * This program is free software;  you can redistribute it and/or modify
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
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ * the GNU General Public License for more details.
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
+ * along with this program;  if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
 
 /*
- * NAME
- *	setfsuid02.c
- *
- * DESCRIPTION
- *	Testcase to test the basic functionality of the setfsuid(2) system
- *	call to fail on invalid uid.
- *
- * ALGORITHM
- *	Call setfsuid(2) and test the uid returned by setfsuid(2) when
- *      an invalid uid is used.
- *	If the returned value matches the invalid uid of the process,
- *	then the testcase fails.
- *
- * USAGE:  <for command-line>
- *  setfsuid01 [-c n] [-f] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -f   : Turn off functionality Testing.
- *             -i n : Execute test n times.
- *             -I x : Execute test for x seconds.
- *             -P x : Pause for x seconds between iterations.
- *             -t   : Turn on syscall timing.
- *
- * HISTORY
- *	07/2001 Ported by Wayne Boyer
- *      04/2003 Adapted by Dustin Kirkland (k1rkland@us.ibm.com)
- *
- * RESTRICTIONS
- *	None
+ * Testcase to test the basic functionality of the setfsuid(2) system
+ * call to fail on invalid uid.
  */
+
 #include <stdio.h>
 #include <unistd.h>
 #include <pwd.h>
@@ -55,13 +31,15 @@
 #endif
 #include <sys/types.h>
 #include <errno.h>
+
 #include "test.h"
 #include "usctest.h"
+#include "compat_16.h"
 
-void setup(void);
-void cleanup(void);
+static void setup(void);
+static void cleanup(void);
 
-char *TCID = "setfsuid02";
+TCID_DEFINE(setfsuid02);
 int TST_TOTAL = 1;
 
 int main(int ac, char **av)
@@ -81,23 +59,22 @@ int main(int ac, char **av)
 	while (getpwuid(uid)) {
 		uid++;
 	}
+	UID16_CHECK(uid, setfsuid, cleanup);
 
-	/* Check for looping state if -i option is given */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		/* reset tst_count in case we are looping */
 		tst_count = 0;
 
-		TEST(setfsuid(uid));
+		TEST(SETFSUID(cleanup, uid));
 
 		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL, "call failed unexpectedly - errno %d",
-				 TEST_ERRNO);
+			tst_resm(TFAIL | TERRNO,
+				"setfsuid() failed unexpectedly");
 			continue;
 		}
 
 		if (!STD_FUNCTIONAL_TEST) {
-			tst_resm(TPASS, "call succeeded");
+			tst_resm(TPASS, "setfsuid() succeeded");
 			continue;
 		}
 
@@ -109,32 +86,19 @@ int main(int ac, char **av)
 				 "%ld", TEST_RETURN);
 		}
 	}
+
 	cleanup();
 	tst_exit();
-	tst_exit();
-
 }
 
-/*
- * setup() - performs all ONE TIME setup for this test.
- */
-void setup()
+static void setup()
 {
-
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	TEST_PAUSE;
 }
 
-/*
- * cleanup() - performs all ONE TIME cleanup for this test at
- *	       completion or premature exit.
- */
-void cleanup()
+static void cleanup()
 {
-	/*
-	 * print timing stats if that option was specified.
-	 * print errno log if that option was specified.
-	 */
 	TEST_CLEANUP;
 }
diff --git a/testcases/kernel/syscalls/setfsuid/setfsuid03.c b/testcases/kernel/syscalls/setfsuid/setfsuid03.c
index ecd9381..a065d78 100644
--- a/testcases/kernel/syscalls/setfsuid/setfsuid03.c
+++ b/testcases/kernel/syscalls/setfsuid/setfsuid03.c
@@ -1,51 +1,28 @@
 /*
+ * Copyright (C) International Business Machines  Corp., 2001
+ * Ported by Wayne Boyer
+ * Adapted by Dustin Kirkland (k1rkland@us.ibm.com)
  *
- *   Copyright (C) International Business Machines  Corp., 2001
+ * This program is free software;  you can redistribute it and/or modify
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
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ * the GNU General Public License for more details.
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
+ * along with this program;  if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
 
 /*
- * NAME
- *	setfsuid03.c
- *
- * DESCRIPTION
- *	Testcase to test the basic functionality of the setfsuid(2) system
- *	call when called by a user other than root.
- *
- * ALGORITHM
- *	Call setfsuid(2) and test the uid returned by setfsuid(2).
- *	If the action are allowed,
- *	then the testcase fails.
- *
- * USAGE:  <for command-line>
- *  setfsuid01 [-c n] [-f] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -f   : Turn off functionality Testing.
- *             -i n : Execute test n times.
- *             -I x : Execute test for x seconds.
- *             -P x : Pause for x seconds between iterations.
- *             -t   : Turn on syscall timing.
- *
- * HISTORY
- *	07/2001 Ported by Wayne Boyer
- *      04/2003 Adapted by Dustin Kirkland (k1rkland@us.ibm.com)
- *
- * RESTRICTIONS
- *	None
+ * Testcase to test the basic functionality of the setfsuid(2) system
+ * call when called by a user other than root.
  */
+
 #include <stdio.h>
 #include <unistd.h>
 #ifdef __GLIBC__
@@ -53,17 +30,20 @@
 #endif
 #include <sys/types.h>
 #include <errno.h>
+#include <pwd.h>
+
 #include "test.h"
 #include "usctest.h"
-#include <pwd.h>
+#include "compat_16.h"
 
-void setup(void);
-void cleanup(void);
+static void setup(void);
+static void cleanup(void);
 
-char *TCID = "setfsuid03";
+TCID_DEFINE(setfsuid03);
 int TST_TOTAL = 1;
-char nobody_uid[] = "nobody";
-struct passwd *ltpuser;
+
+static char nobody_uid[] = "nobody";
+static struct passwd *ltpuser;
 
 int main(int ac, char **av)
 {
@@ -78,28 +58,26 @@ int main(int ac, char **av)
 
 	setup();
 
-	uid = geteuid();
 	uid = 1;
 	while (!getpwuid(uid)) {
 		uid++;
 	}
+	UID16_CHECK(uid, setfsuid, cleanup);
 
-	/* Check for looping state if -i option is given */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		/* reset tst_count in case we are looping */
 		tst_count = 0;
 
-		TEST(setfsuid(uid));
+		TEST(SETFSUID(cleanup, uid));
 
 		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL, "call failed unexpectedly - errno %d",
-				 TEST_ERRNO);
+			tst_resm(TFAIL | TERRNO,
+				"setfsuid() failed unexpectedly");
 			continue;
 		}
 
 		if (!STD_FUNCTIONAL_TEST) {
-			tst_resm(TPASS, "call succeeded");
+			tst_resm(TPASS, "setfsuid() succeeded");
 			continue;
 		}
 
@@ -112,42 +90,30 @@ int main(int ac, char **av)
 				 "%ld", TEST_RETURN);
 		}
 	}
+
 	cleanup();
 	tst_exit();
-	tst_exit();
-
 }
 
-/*
- * setup() - performs all ONE TIME setup for this test.
- */
-void setup()
+static void setup()
 {
-	/* Switch to nobody user for correct error code collection */
-	if (geteuid() != 0) {
-		tst_brkm(TBROK, NULL, "Test must be run as root");
-	}
+	tst_require_root(NULL);
+
 	ltpuser = getpwnam(nobody_uid);
-	if (setuid(ltpuser->pw_uid) == -1) {
-		tst_resm(TINFO, "setuid failed to "
+	if (ltpuser == NULL)
+		tst_brkm(TBROK, cleanup, "getpwnam failed for user id %s",
+			nobody_uid);
+
+	if (setuid(ltpuser->pw_uid) == -1)
+		tst_resm(TINFO | TERRNO, "setuid failed to "
 			 "to set the effective uid to %d", ltpuser->pw_uid);
-		perror("setuid");
-	}
 
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	TEST_PAUSE;
 }
 
-/*
- * cleanup() - performs all ONE TIME cleanup for this test at
- *	       completion or premature exit.
- */
-void cleanup()
+static void cleanup()
 {
-	/*
-	 * print timing stats if that option was specified.
-	 * print errno log if that option was specified.
-	 */
 	TEST_CLEANUP;
 }
diff --git a/testcases/kernel/syscalls/setfsuid/setfsuid04.c b/testcases/kernel/syscalls/setfsuid/setfsuid04.c
index 4ee2e22..03ea551 100644
--- a/testcases/kernel/syscalls/setfsuid/setfsuid04.c
+++ b/testcases/kernel/syscalls/setfsuid/setfsuid04.c
@@ -1,48 +1,31 @@
-/******************************************************************************/
-/* Copyright (c) Kerlabs 2008.                                                */
-/* Copyright (c) International Business Machines  Corp., 2008                 */
-/*                                                                            */
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
-/* along with this program;  if not, write to the Free Software               */
-/* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    */
-/*                                                                            */
-/******************************************************************************/
+/*****************************************************************************
+ * Copyright (c) Kerlabs 2008.                                               *
+ * Copyright (c) International Business Machines  Corp., 2008                *
+ * Created by Renaud Lottiaux                                                *
+ *                                                                           *
+ * This program is free software;  you can redistribute it and/or modify     *
+ * it under the terms of the GNU General Public License as published by      *
+ * the Free Software Foundation; either version 2 of the License, or         *
+ * (at your option) any later version.                                       *
+ *                                                                           *
+ * This program is distributed in the hope that it will be useful,           *
+ * but WITHOUT ANY WARRANTY;  without even the implied warranty of           *
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                 *
+ * the GNU General Public License for more details.                          *
+ *                                                                           *
+ * You should have received a copy of the GNU General Public License         *
+ * along with this program;  if not, write to the Free Software Foundation,  *
+ * Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA          *
+ *****************************************************************************/
+
 /*
- * NAME
- * 	setfsuid04.c
- *
- * DESCRIPTION
- * 	Check if setfsuid behaves correctly with file permissions.
- *      The test creates a file as ROOT with permissions 0644, does a setfsuid
- *      and then tries to open the file with RDWR permissions.
- *      The same test is done in a fork to check if new UIDs are correctly
- *      passed to the son.
- *
- * USAGE:  <for command-line>
- *  setfsuid04 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -e   : Turn on errno logging.
- *             -i n : Execute test n times.
- *             -I x : Execute test for x seconds.
- *             -P x : Pause for x seconds between iterations.
- *             -t   : Turn on syscall timing.
- *
- * HISTORY
- *	07/2001 Created by Renaud Lottiaux
- *
- * RESTRICTIONS
- * 	Must be run as root.
+ * Check if setfsuid behaves correctly with file permissions.
+ * The test creates a file as ROOT with permissions 0644, does a setfsuid
+ * and then tries to open the file with RDWR permissions.
+ * The same test is done in a fork to check if new UIDs are correctly
+ * passed to the son.
  */
+
 #include <sys/types.h>
 #ifdef __GLIBC__
 #include <sys/fsuid.h>
@@ -56,22 +39,23 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
+
 #include "test.h"
 #include "usctest.h"
+#include "compat_16.h"
 
-char *TCID = "setfsuid04";
+TCID_DEFINE(setfsuid04);
 int TST_TOTAL = 1;
-char nobody_uid[] = "nobody";
-char testfile[256] = "";
-struct passwd *ltpuser;
 
-int exp_enos[] = { EACCES, 0 };
+static char nobody_uid[] = "nobody";
+static char testfile[] = "setfsuid04_testfile";
+struct passwd *ltpuser;
 
-int fd = -1;
+static int fd = -1;
 
-void setup(void);
-void cleanup(void);
-void do_master_child();
+static void setup(void);
+static void cleanup(void);
+static void do_master_child();
 
 int main(int ac, char **av)
 {
@@ -84,8 +68,6 @@ int main(int ac, char **av)
 
 	setup();
 
-	TEST_EXP_ENOS(exp_enos);
-
 	pid = FORK_OR_VFORK();
 	if (pid < 0)
 		tst_brkm(TBROK, cleanup, "Fork failed");
@@ -102,36 +84,32 @@ int main(int ac, char **av)
 	tst_exit();
 }
 
-/*
- * do_master_child()
- */
-void do_master_child()
+static void do_master_child()
 {
 	int pid;
 	int status;
 	int tst_fd;
 
-	if (setfsuid(ltpuser->pw_uid) == -1) {
-		perror("setfsuid failed");
-		exit(1);
-	}
+	if (SETFSUID(NULL, ltpuser->pw_uid) == -1)
+		tst_brkm(TBROK | TERRNO, NULL, "setfsuid failed");
 
 	/* Test 1: Check the process with new uid cannot open the file
 	 *         with RDWR permissions.
 	 */
-	tst_fd = open(testfile, O_RDWR);
+	TEST(tst_fd = open(testfile, O_RDWR));
 
-	if (tst_fd != -1) {
-		printf("open succeeded unexpectedly");
+	if (TEST_RETURN != -1) {
 		close(tst_fd);
-		exit(1);
+		tst_brkm(TFAIL, NULL, "open succeeded unexpectedly");
 	}
 
-	if (errno == EACCES)
-		printf("open failed with EACCES as expected");
+	if (TEST_ERRNO == EACCES)
+		tst_resm(TPASS,
+			"open failed with EACCESS as expected");
 	else {
-		perror("open failed unexpectedly");
-		exit(1);
+		tst_brkm(TFAIL, NULL,
+			"open returned unexpected errno - %d",
+			TEST_ERRNO);
 	}
 
 	/* Test 2: Check a son process cannot open the file
@@ -139,31 +117,32 @@ void do_master_child()
 	 */
 	pid = FORK_OR_VFORK();
 	if (pid < 0)
-		tst_brkm(TBROK, cleanup, "Fork failed");
+		tst_brkm(TBROK, NULL, "Fork failed");
 
 	if (pid == 0) {
 		int tst_fd2;
 
 		/* Test to open the file in son process */
-		tst_fd2 = open(testfile, O_RDWR);
+		TEST(tst_fd2 = open(testfile, O_RDWR));
 
-		if (tst_fd2 != -1) {
-			printf("call succeeded unexpectedly\n");
+		if (TEST_RETURN != -1) {
 			close(tst_fd2);
-			exit(1);
+			tst_brkm(TFAIL, NULL,
+				"open succeeded unexpectedly");
 		}
 
-		if (errno == EACCES)
-			printf("open failed with EACCES as expected\n");
+		if (TEST_ERRNO == EACCES)
+			tst_resm(TPASS,
+				"open failed with EACCESS as expected");
 		else {
-			printf("open failed unexpectedly\n");
-			exit(1);
+			tst_brkm(TFAIL, NULL,
+				"open returned unexpected errno - %d",
+				TEST_ERRNO);
 		}
 	} else {
 		/* Wait for son completion */
 		if (waitpid(pid, &status, 0) == -1) {
-			perror("waitpid failed");
-			exit(1);
+			tst_brkm(TFAIL, NULL, "waitpid failed");
 		}
 		if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
 			exit(WEXITSTATUS(status));
@@ -173,35 +152,33 @@ void do_master_child()
 	 *         the file with RDWR permissions.
 	 */
 	tst_count++;
-	if (setfsuid(0) == -1) {
-		perror("setfsuid failed");
-		exit(1);
-	}
+	if (SETFSUID(NULL, 0) == -1)
+		tst_brkm(TFAIL | TERRNO, NULL, "setfsuid failed");
 
-	tst_fd = open(testfile, O_RDWR);
+	TEST(tst_fd = open(testfile, O_RDWR));
 
-	if (tst_fd == -1) {
-		perror("open failed unexpectedly");
-		exit(1);
+	if (TEST_RETURN == -1) {
+		tst_brkm(TFAIL | TERRNO, NULL,
+			"open failed unexpectedly");
 	} else {
-		printf("open call succeeded");
+		tst_resm(TPASS, "open call succeeded");
 		close(tst_fd);
 	}
 	exit(0);
 }
 
-/*
- * setup() - performs all ONE TIME setup for this test
- */
-void setup(void)
+static void setup(void)
 {
 	tst_require_root(NULL);
 
 	ltpuser = getpwnam(nobody_uid);
+	if (ltpuser == NULL)
+		tst_brkm(TBROK, cleanup, "getpwnam failed for user id %s",
+			nobody_uid);
 
-	tst_tmpdir();
+	UID16_CHECK(ltpuser->pw_uid, setfsuid, cleanup);
 
-	sprintf(testfile, "setfsuid04file%d.tst", getpid());
+	tst_tmpdir();
 
 	/* Create test file */
 	fd = open(testfile, O_CREAT | O_RDWR, 0644);
@@ -213,20 +190,10 @@ void setup(void)
 	TEST_PAUSE;
 }
 
-/*
- * cleanup() - performs all the ONE TIME cleanup for this test at completion
- * 	       or premature exit
- */
-void cleanup(void)
+static void cleanup(void)
 {
 	close(fd);
-
-	/*
-	 * print timing status if that option was specified
-	 * print errno log if that option was specified
-	 */
-	TEST_CLEANUP;
-
 	tst_rmdir();
 
+	TEST_CLEANUP;
 }
diff --git a/testcases/kernel/syscalls/utils/compat_16.h b/testcases/kernel/syscalls/utils/compat_16.h
index 2fdb6dc..fa1217d 100644
--- a/testcases/kernel/syscalls/utils/compat_16.h
+++ b/testcases/kernel/syscalls/utils/compat_16.h
@@ -24,6 +24,9 @@
 
 #include <errno.h>
 #include <grp.h>
+#ifdef __GLIBC__
+#include <sys/fsuid.h>
+#endif
 #include <sys/types.h>
 #include <unistd.h>
 
@@ -103,4 +106,14 @@ GID_T GETEGID(void (cleanup)(void))
 {
 	LTP_CREATE_SYSCALL(getegid, cleanup);
 }
+
+int SETFSUID(void (cleanup)(void), UID_T uid)
+{
+	LTP_CREATE_SYSCALL(setfsuid, cleanup, uid);
+}
+
+int SETFSGID(void (cleanup)(void), GID_T gid)
+{
+	LTP_CREATE_SYSCALL(setfsgid, cleanup, gid);
+}
 #endif /* __LTP_COMPAT_16_H__ */
-- 
1.7.1


------------------------------------------------------------------------------
How ServiceNow helps IT people transform IT departments:
1. Consolidate legacy IT systems to a single system of record for IT
2. Standardize and globalize service processes across IT
3. Implement zero-touch automation to replace manual, redundant tasks
http://pubads.g.doubleclick.net/gampad/clk?id=51271111&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
