From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu,  5 Apr 2018 16:50:13 +0200
Subject: [LTP] [RFC PATCH 4/6] syscalls/alarm01: Remove
In-Reply-To: <20180405145015.7633-1-chrubis@suse.cz>
References: <20180405145015.7633-1-chrubis@suse.cz>
Message-ID: <20180405145015.7633-5-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The test was simply wrong alarm() does not return a failure at all.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 runtest/ltplite                           |   1 -
 runtest/quickhit                          |   2 -
 runtest/stress.part3                      |   1 -
 runtest/syscalls                          |   1 -
 testcases/kernel/syscalls/.gitignore      |   1 -
 testcases/kernel/syscalls/alarm/alarm01.c | 176 ------------------------------
 6 files changed, 182 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/alarm/alarm01.c

diff --git a/runtest/ltplite b/runtest/ltplite
index 15dc0c20f..001325d65 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -71,7 +71,6 @@ acct01 acct01
 adjtimex01 adjtimex01
 adjtimex02 adjtimex02
 
-alarm01 alarm01
 alarm02 alarm02
 alarm03 alarm03
 alarm05 alarm05
diff --git a/runtest/quickhit b/runtest/quickhit
index 99e7c4779..2a1056971 100644
--- a/runtest/quickhit
+++ b/runtest/quickhit
@@ -3,8 +3,6 @@ access01 access01
 # Basic test for access(2) using F_OK, R_OK, W_OK and X_OK arguments.
 access03 access03
 # EFAULT error testing for access(2)
-alarm01 alarm01
-# Basic test for alarm(2)
 alarm02 alarm02
 # Boundary Value Test for alarm(2)
 #    TEST CASES
diff --git a/runtest/stress.part3 b/runtest/stress.part3
index 2a7747ce3..0d5951454 100644
--- a/runtest/stress.part3
+++ b/runtest/stress.part3
@@ -13,7 +13,6 @@ acct01 acct01
 adjtimex01 adjtimex01
 adjtimex02 adjtimex02
 
-alarm01 alarm01
 alarm02 alarm02
 alarm03 alarm03
 alarm05 alarm05
diff --git a/runtest/syscalls b/runtest/syscalls
index 76ab082be..71cfd2d6f 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -19,7 +19,6 @@ add_key04 add_key04
 adjtimex01 adjtimex01
 adjtimex02 adjtimex02
 
-alarm01 alarm01
 alarm02 alarm02
 alarm03 alarm03
 alarm05 alarm05
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index eea606e61..cd80cfc8f 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -12,7 +12,6 @@
 /add_key/add_key04
 /adjtimex/adjtimex01
 /adjtimex/adjtimex02
-/alarm/alarm01
 /alarm/alarm02
 /alarm/alarm03
 /alarm/alarm05
diff --git a/testcases/kernel/syscalls/alarm/alarm01.c b/testcases/kernel/syscalls/alarm/alarm01.c
deleted file mode 100644
index f17207b0a..000000000
--- a/testcases/kernel/syscalls/alarm/alarm01.c
+++ /dev/null
@@ -1,176 +0,0 @@
-/*
- * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * Further, this software is distributed without any warranty that it is
- * free of the rightful claim of any third person regarding infringement
- * or the like.  Any license provided herein, whether implied or
- * otherwise, applies only to this software file.  Patent licenses, if
- * any, provided herein do not apply to combinations of this program with
- * other software, or any other product whatsoever.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
- * Contact information: Silicon Graphics, Inc., 1600 Amphitheatre Pkwy,
- * Mountain View, CA  94043, or:
- *
- * http://www.sgi.com
- *
- * For further information regarding this notice, see:
- *
- * http://oss.sgi.com/projects/GenInfo/NoticeExplan/
- */
-/* $Id: alarm01.c,v 1.6 2009/08/28 10:57:29 vapier Exp $ */
-/**********************************************************
- *
- *    OS Test - Silicon Graphics, Inc.
- *
- *    TEST IDENTIFIER	: alarm01
- *
- *    EXECUTED BY	: anyone
- *
- *    TEST TITLE	: Basic test for alarm(2)
- *
- *    PARENT DOCUMENT	: usctpl01
- *
- *    TEST CASE TOTAL	: 1
- *
- *    WALL CLOCK TIME	: 1
- *
- *    CPU TYPES		: ALL
- *
- *    AUTHOR		: William Roske
- *
- *    CO-PILOT		: Dave Fenner
- *
- *    DATE STARTED	: 03/30/92
- *
- *    INITIAL RELEASE	: UNICOS 7.0
- *
- *    TEST CASES
- *
- * 	1.) alarm(2) returns...(See Description)
- *
- *    INPUT SPECIFICATIONS
- * 	The standard options for system call tests are accepted.
- *	(See the parse_opts(3) man page).
- *
- *    OUTPUT SPECIFICATIONS
- *$
- *    DURATION
- * 	Terminates - with frequency and infinite modes.
- *
- *    SIGNALS
- * 	Uses SIGUSR1 to pause before test if option set.
- * 	(See the parse_opts(3) man page).
- *
- *    RESOURCES
- * 	None
- *
- *    ENVIRONMENTAL NEEDS
- * 	The libcuts.a and libsys.a libraries must be included in
- *	the compilation of this test.
- *
- *    SPECIAL PROCEDURAL REQUIREMENTS
- * 	None
- *
- *    INTERCASE DEPENDENCIES
- * 	None
- *
- *    DETAILED DESCRIPTION
- *	This is a Phase I test for the alarm(2) system call.  It is intended
- *	to provide a limited exposure of the system call, for now.  It
- *	should/will be extended when full functional tests are written for
- *	alarm(2).
- *
- * 	Setup:
- * 	  Setup signal handling.
- *	  Pause for SIGUSR1 if option specified.
- *
- * 	Test:
- *	 Loop if the proper options are given.
- * 	  Execute system call
- *	  Check return code, if system call failed (return=-1)
- *		Log the errno and Issue a FAIL message.
- *	  Otherwise, Issue a PASS message.
- *
- * 	Cleanup:
- * 	  Print errno log and/or timing stats if options given
- *
- *
- *#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#**/
-
-#include <errno.h>
-#include <string.h>
-#include <signal.h>
-#include "test.h"
-
-void setup();
-void cleanup();
-
-char *TCID = "alarm01";
-int TST_TOTAL = 1;
-
-int main(int ac, char **av)
-{
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-
-		/*
-		 * Call alarm(2)
-		 */
-		TEST(alarm(1));
-
-		/* check return code */
-		if (TEST_RETURN == -1)
-			tst_resm(TFAIL | TTERRNO, "alarm(1) failed");
-		else {
-			tst_resm(TPASS, "alarm(1) returned %ld",
-				 TEST_RETURN);
-		}
-
-	}
-
-	cleanup();
-	tst_exit();
-}
-
-void setup(void)
-{
-	void trapper();
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	signal(SIGALRM, trapper);
-
-	TEST_PAUSE;
-}
-
-/***************************************************************
- * cleanup() - performs all ONE TIME cleanup for this test at
- *		completion or premature exit.
- ***************************************************************/
-void cleanup(void)
-{
-}
-
-void trapper(int sig)
-{
-	signal(SIGALRM, trapper);
-}
-- 
2.13.6

