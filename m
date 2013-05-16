Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <li.dan@cn.fujitsu.com>) id 1UcoUK-0006XD-BQ
	for ltp-list@lists.sourceforge.net; Thu, 16 May 2013 03:04:16 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UcoUI-0004WC-6L
	for ltp-list@lists.sourceforge.net; Thu, 16 May 2013 03:04:16 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id r4G344Lj007944
	for <ltp-list@lists.sourceforge.net>; Thu, 16 May 2013 11:04:04 +0800
Message-ID: <51944C16.5080607@cn.fujitsu.com>
Date: Thu, 16 May 2013 11:01:42 +0800
From: DAN LI <li.dan@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP]  [PATCH 1/2] shmat/shmat01.c: cleanup
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

Signed-off-by: DAN LI <li.dan@cn.fujitsu.com>
---
 testcases/kernel/syscalls/ipc/shmat/shmat01.c | 114 +++++++-------------------
 1 file changed, 31 insertions(+), 83 deletions(-)

diff --git a/testcases/kernel/syscalls/ipc/shmat/shmat01.c b/testcases/kernel/syscalls/ipc/shmat/shmat01.c
index 51e25c5..3461782 100644
--- a/testcases/kernel/syscalls/ipc/shmat/shmat01.c
+++ b/testcases/kernel/syscalls/ipc/shmat/shmat01.c
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
@@ -38,79 +37,54 @@
  *		otherwise
  *			issue a FAIL message
  *	call cleanup
- *
- * USAGE:  <for command-line>
- *  shmat01 [-c n] [-f] [-i n] [-I x] [-P x] [-t]
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
 #include "shmat_common.h"

-char *TCID = "shmat01";
-
-static void check_functionality(int);
+#define CASE0		10
+#define CASE1		20

-#define CASE0		10	/* values to write into the shared */
-#define CASE1		20	/* memory location.                */
+char *TCID = "shmat01";
+int TST_TOTAL = 3;

 int shm_id_1 = -1;

-void *base_addr;		/* By probing this address first, we can make
-				 * non-aligned addresses from it for different
-				 * architectures without explicitly code it.
-				 */
-
-void *addr;			/* for result of shmat-call */
+/*
+ * By probing this address first, we can make
+ * non-aligned addresses from it for different
+ * architectures without explicitly code it.
+ */
+void *base_addr;
+void *addr;

-struct test_case_t {
+static struct test_case_t {
 	int *shmid;
 	int offset;
 	int flags;
-};
+} *TC;

-int TST_TOTAL = 3;
-
-struct test_case_t *TC;
+static void check_functionality(int);

-int main(int ac, char **av)
+int main(int argc, char *argv[])
 {
-	int lc;
+	int lc, i;
 	char *msg;
-	int i;

-	msg = parse_opts(ac, av, NULL, NULL);
+	msg = parse_opts(argc, argv, NULL, NULL);
 	if (msg != NULL)
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);

-	setup();		/* global setup */
-
-	/* The following loop checks looping state if -i option given */
+	setup();

 	for (lc = 0; TEST_LOOPING(lc); lc++) {

-		/* reset tst_count in case we are looping */
 		tst_count = 0;

-		/* loop through the test cases */
 		for (i = 0; i < TST_TOTAL; i++) {

-			/*
-			 * Use TEST macro to make the call
-			 */
 			base_addr = probe_free_addr();
-			errno = 0;
+
 			addr = shmat(*(TC[i].shmid), base_addr + TC[i].offset,
 				     TC[i].flags);
 			TEST_ERRNO = errno;
@@ -125,10 +99,6 @@ int main(int ac, char **av)
 					tst_resm(TPASS, "call succeeded");
 			}

-			/*
-			 * clean up things in case we are looping - in
-			 * this case, detach the shared memory
-			 */
 			if (shmdt(addr) == -1)
 				tst_brkm(TBROK, cleanup,
 					 "Couldn't detach shared memory");
@@ -215,12 +185,8 @@ static void check_functionality(int i)
 		tst_resm(TPASS, "conditions and functionality are correct");
 }

-/*
- * setup() - performs all the ONE TIME setup for this test.
- */
 void setup(void)
 {
-
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);

 	TEST_PAUSE;
@@ -244,31 +210,18 @@ void setup(void)
 	TC[2].offset = 0;
 	TC[2].flags = SHM_RDONLY;

-	/*
-	 * Create a temporary directory and cd into it.
-	 * This helps to ensure that a unique msgkey is created.
-	 * See ../lib/libipc.c for more information.
-	 */
 	tst_tmpdir();

-	/* Get an IPC resouce key */
 	shmkey = getipckey();

-	/* create a shared memory resource with read and write permissions */
 	shm_id_1 = shmget(shmkey++, INT_SIZE, SHM_RW | IPC_CREAT | IPC_EXCL);
 	if (shm_id_1 == -1)
 		tst_brkm(TBROK, cleanup, "Failed to create shared memory "
 			 "resource 1 in setup()");
 }

-/*
- * cleanup() - performs all the ONE TIME cleanup for this test at completion
- *		or premature exit.
- */
 void cleanup(void)
 {
-
-	/* if it exists, remove the shared memory resource */
 	rm_shm(shm_id_1);

 	if (TC != NULL)
@@ -276,10 +229,5 @@ void cleanup(void)

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
AlienVault Unified Security Management (USM) platform delivers complete
security visibility with the essential security capabilities. Easily and
efficiently configure, manage, and operate all of your security controls
from a single console and one unified framework. Download a free trial.
http://p.sf.net/sfu/alienvault_d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
