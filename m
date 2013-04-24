Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <li.dan@cn.fujitsu.com>) id 1UUtx5-00030p-2h
	for ltp-list@lists.sourceforge.net; Wed, 24 Apr 2013 07:17:15 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UUtx1-0004Df-A1
	for ltp-list@lists.sourceforge.net; Wed, 24 Apr 2013 07:17:15 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id r3O7H4I2011856
	for <ltp-list@lists.sourceforge.net>; Wed, 24 Apr 2013 15:17:04 +0800
Message-ID: <5177866B.8040606@cn.fujitsu.com>
Date: Wed, 24 Apr 2013 15:14:51 +0800
From: DAN LI <li.dan@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP]  [PATCH 1/2] syscalls/getitimer: cleanup
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: LTP list <ltp-list@lists.sourceforge.net>


cleanup syscalls/getitimer01.c getitimer02.c

Signed-off-by: DAN LI <li.dan@cn.fujitsu.com>
---
 testcases/kernel/syscalls/getitimer/getitimer01.c | 106 ++++++----------------
 testcases/kernel/syscalls/getitimer/getitimer02.c |  96 +++++---------------
 2 files changed, 53 insertions(+), 149 deletions(-)

diff --git a/testcases/kernel/syscalls/getitimer/getitimer01.c b/testcases/kernel/syscalls/getitimer/getitimer01.c
index 56c56e0..54aa5bb 100644
--- a/testcases/kernel/syscalls/getitimer/getitimer01.c
+++ b/testcases/kernel/syscalls/getitimer/getitimer01.c
@@ -1,55 +1,28 @@
 /*
+ * Copyright (c) International Business Machines  Corp., 2001
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
- *	getitimer01.c
- *
- * DESCRIPTION
- *	getitimer01 - check that a correct call to getitimer() succeeds
- *
- * ALGORITHM
- *	loop if that option was specified
- *	allocate needed space
- *	issue the system call
- *	check the errno value
- *	  issue a PASS message if we get zero
- *	otherwise, the tests fails
- *	  issue a FAIL message
- *	  break any remaining tests
- *	  call cleanup
- *
- * USAGE:  <for command-line>
- *  getitimer01 [-c n] [-f] [-i n] [-I x] [-P x] [-t]
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
+  HISTORY
+    03/2001 - Written by Wayne Boyer
+
+  TEST ITEMS:
+    Check that a correct call to getitimer() succeeds.
+*/

 #include "test.h"
 #include "usctest.h"
@@ -57,8 +30,8 @@
 #include <errno.h>
 #include <sys/time.h>

-void cleanup(void);
-void setup(void);
+static void cleanup(void);
+static void setup(void);

 char *TCID = "getitimer01";
 int TST_TOTAL = 1;
@@ -69,35 +42,25 @@ int main(int ac, char **av)
 	char *msg;
 	struct itimerval *value;

-	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL) {
+	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL)
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
-	}
-
-	setup();		/* global setup */

-	/* The following loop checks looping state if -i option given */
+	setup();

 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset tst_count in case we are looping */
 		tst_count = 0;

 		/* allocate space for the itimerval structure */
-
-		if ((value = (struct itimerval *)malloc((size_t)
-							sizeof(struct
-							       itimerval))) ==
-		    NULL) {
+		value = (struct itimerval *)malloc(
+					(size_t)sizeof(struct itimerval));
+		if (value == NULL)
 			tst_brkm(TBROK, cleanup, "value malloc failed");
-		}
-
-		/* call the system call with the TEST() macro */

 		TEST(getitimer(ITIMER_REAL, value));

-		if (TEST_RETURN != 0) {
+		if (TEST_RETURN != 0)
 			tst_resm(TFAIL, "call failed - errno = %d - %s",
 				 TEST_ERRNO, strerror(TEST_ERRNO));
-		}

 		if (STD_FUNCTIONAL_TEST) {

@@ -122,27 +85,14 @@ int main(int ac, char **av)
 	tst_exit();
 }

-/*
- * setup() - performs all the ONE TIME setup for this test.
- */
-void setup(void)
+static void setup(void)
 {
-
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);

 	TEST_PAUSE;
 }

-/*
- * cleanup() - performs all the ONE TIME cleanup for this test at completion
- * 	       or premature exit.
- */
-void cleanup(void)
+static void cleanup(void)
 {
-	/*
-	 * print timing stats if that option was specified.
-	 * print errno log if that option was specified.
-	 */
 	TEST_CLEANUP;
-
 }
diff --git a/testcases/kernel/syscalls/getitimer/getitimer02.c b/testcases/kernel/syscalls/getitimer/getitimer02.c
index fcb3d6c..eab40ae 100644
--- a/testcases/kernel/syscalls/getitimer/getitimer02.c
+++ b/testcases/kernel/syscalls/getitimer/getitimer02.c
@@ -1,55 +1,30 @@
 /*
+ * Copyright (c) International Business Machines  Corp., 2001
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
- *	getitimer02.c
- *
- * DESCRIPTION
- *	getitimer02 - check that a getitimer() call fails as expected
- *		      with an incorrect second argument.
- *
- * ALGORITHM
- *	loop if that option was specified
- *	call getitimer() with an incorrect second argument.
- *	check the errno value
- *	  issue a PASS message if we get EFAULT - errno 14
- *	otherwise, the tests fails
- *	  issue a FAIL message
- *	  break any remaining tests
- *	  call cleanup
- *
- * USAGE:  <for command-line>
- *  getitimer02 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
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
+  HISTORY
+  03/2001 - Written by Wayne Boyer
+
+  TEST ITEMS:
+  Check that a getitimer() call fails as expected
+  with an incorrect second argument.
+*/
+

 #include "test.h"
 #include "usctest.h"
@@ -62,8 +37,8 @@ int TST_TOTAL = 1;

 #if !defined(UCLINUX)

-void cleanup(void);
-void setup(void);
+static void cleanup(void);
+static void setup(void);

 int exp_enos[] = { EFAULT, 0 };

@@ -76,19 +51,11 @@ int main(int ac, char **av)
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
 	}

-	setup();		/* global setup */
-
-	/* The following loop checks looping state if -i option given */
+	setup();

 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset tst_count in case we are looping */
 		tst_count = 0;

-		/*
-		 * issue the system call with the TEST() macro
-		 * ITIMER_REAL = 0, ITIMER_VIRTUAL = 1 and ITIMER_PROF = 2
-		 */
-
 		/* call with a bad address */
 		TEST(getitimer(ITIMER_REAL, (struct itimerval *)-1));

@@ -118,12 +85,8 @@ int main(int ac, char **av)
 	tst_exit();
 }

-/*
- * setup() - performs all the ONE TIME setup for this test.
- */
-void setup(void)
+static void setup(void)
 {
-
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);

 	TEST_EXP_ENOS(exp_enos);
@@ -131,18 +94,9 @@ void setup(void)
 	TEST_PAUSE;
 }

-/*
- * cleanup() - performs all the ONE TIME cleanup for this test at completion
- * 	       or premature exit.
- */
-void cleanup(void)
+static void cleanup(void)
 {
-	/*
-	 * print timing stats if that option was specified.
-	 * print errno log if that option was specified.
-	 */
 	TEST_CLEANUP;
-
 }

 #else
-- 
1.8.1

------------------------------------------------------------------------------
Try New Relic Now & We'll Send You this Cool Shirt
New Relic is the only SaaS-based application performance monitoring service 
that delivers powerful full stack analytics. Optimize and monitor your
browser, app, & servers with just a few lines of code. Try New Relic
and get this awesome Nerd Life shirt! http://p.sf.net/sfu/newrelic_d2d_apr
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
