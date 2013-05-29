Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <li.dan@cn.fujitsu.com>) id 1UhcGA-0003wJ-Ds
	for ltp-list@lists.sourceforge.net; Wed, 29 May 2013 09:01:30 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UhcG7-0002UW-W7
	for ltp-list@lists.sourceforge.net; Wed, 29 May 2013 09:01:30 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id r4T91GgZ027919
	for <ltp-list@lists.sourceforge.net>; Wed, 29 May 2013 17:01:16 +0800
Message-ID: <51A5C347.4020202@cn.fujitsu.com>
Date: Wed, 29 May 2013 16:58:47 +0800
From: DAN LI <li.dan@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] shmget/shmget01.c: cleanup and attach SHM_NORESERVE
 to shmflg
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


1. Remove useless comments

2. Revise code to follow ltp-code-style

3. Add SHM_NORESERVE to shmflg to test

Signed-off-by: DAN LI <li.dan@cn.fujitsu.com>
---
 testcases/kernel/syscalls/ipc/shmget/shmget01.c | 87 +++++++------------------
 1 file changed, 22 insertions(+), 65 deletions(-)

diff --git a/testcases/kernel/syscalls/ipc/shmget/shmget01.c b/testcases/kernel/syscalls/ipc/shmget/shmget01.c
index 38dbee7..c36fb8e 100644
--- a/testcases/kernel/syscalls/ipc/shmget/shmget01.c
+++ b/testcases/kernel/syscalls/ipc/shmget/shmget01.c
@@ -1,20 +1,19 @@
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
@@ -33,27 +32,12 @@
  *	  if doing functionality testing
  *		stat the shared memory resource
  *		check the size, creator pid and mode
- *	  	if correct,
+ *		if correct,
  *			issue a PASS message
  *		otherwise
  *			issue a FAIL message
  *	  else issue a PASS message
  *	call cleanup
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
  */

 #include "ipcshm.h"
@@ -61,31 +45,25 @@
 char *TCID = "shmget01";
 int TST_TOTAL = 1;

-int shm_id_1 = -1;
+static int shm_id_1 = -1;

-int main(int ac, char **av)
+int main(int argc, char *argv[])
 {
 	int lc;
 	char *msg;
 	struct shmid_ds buf;

-	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL) {
+	msg = parse_opts(argc, argv, NULL, NULL);
+	if (msg != NULL)
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
-	}

-	setup();		/* global setup */
-
-	/* The following loop checks looping state if -i option given */
+	setup();

 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset tst_count in case we are looping */
 		tst_count = 0;

-		/*
-		 * Use TEST macro to make the call
-		 */
-
-		TEST(shmget(shmkey, SHM_SIZE, (IPC_CREAT | IPC_EXCL | SHM_RW)));
+		TEST(shmget(shmkey, SHM_SIZE,
+			    (IPC_CREAT | IPC_EXCL | SHM_RW | SHM_NORESERVE)));

 		if (TEST_RETURN == -1) {
 			tst_resm(TFAIL, "%s call failed - errno = %d : %s",
@@ -131,11 +109,10 @@ int main(int ac, char **av)
 		/*
 		 * clean up things in case we are looping
 		 */
-		if (shmctl(shm_id_1, IPC_RMID, NULL) == -1) {
+		if (shmctl(shm_id_1, IPC_RMID, NULL) == -1)
 			tst_resm(TBROK, "couldn't remove shared memory");
-		} else {
+		else
 			shm_id_1 = -1;
-		}
 	}

 	cleanup();
@@ -143,42 +120,22 @@ int main(int ac, char **av)
 	tst_exit();
 }

-/*
- * setup() - performs all the ONE TIME setup for this test.
- */
 void setup(void)
 {
-
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);

 	TEST_PAUSE;

-	/*
-	 * Create a temporary directory and cd into it.
-	 * This helps to ensure that a unique msgkey is created.
-	 * See ../lib/libipc.c for more information.
-	 */
 	tst_tmpdir();

-	/* get an IPC resource key */
 	shmkey = getipckey();
 }

-/*
- * cleanup() - performs all the ONE TIME cleanup for this test at completion
- * 	       or premature exit.
- */
 void cleanup(void)
 {
-	/* if it exists, remove the shared memory resource */
 	rm_shm(shm_id_1);

 	tst_rmdir();

-	/*
-	 * print timing stats if that option was specified.
-	 * print errno log if that option was specified.
-	 */
 	TEST_CLEANUP;
-
 }
-- 
1.8.1

------------------------------------------------------------------------------
Introducing AppDynamics Lite, a free troubleshooting tool for Java/.NET
Get 100% visibility into your production application - at no cost.
Code-level diagnostics for performance bottlenecks with <2% overhead
Download for free and get started troubleshooting in minutes.
http://p.sf.net/sfu/appdyn_d2d_ap1
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
