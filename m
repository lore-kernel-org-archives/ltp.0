Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1VoAMs-0007KX-H4
	for ltp-list@lists.sourceforge.net; Wed, 04 Dec 2013 11:11:46 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VoAMq-00066q-9F
	for ltp-list@lists.sourceforge.net; Wed, 04 Dec 2013 11:11:46 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id rB4BBZiY007470
	for <ltp-list@lists.sourceforge.net>; Wed, 4 Dec 2013 19:11:35 +0800
Message-ID: <1386155493.1544.8.camel@G08JYZSD130126>
From: "zenglg.jy" <zenglg.jy@cn.fujitsu.com>
Date: Wed, 04 Dec 2013 19:11:33 +0800
Mime-Version: 1.0
Subject: [LTP] [PATCH 1/2] fpathconf/fpathconf01.c: cleanup
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
To: ltp-list <ltp-list@lists.sourceforge.net>

cleanup of fpathconf01.c

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/fpathconf/fpathconf01.c | 176 ++++++----------------
 1 file changed, 43 insertions(+), 133 deletions(-)

diff --git a/testcases/kernel/syscalls/fpathconf/fpathconf01.c b/testcases/kernel/syscalls/fpathconf/fpathconf01.c
index 2fcedea..b551d5a 100644
--- a/testcases/kernel/syscalls/fpathconf/fpathconf01.c
+++ b/testcases/kernel/syscalls/fpathconf/fpathconf01.c
@@ -1,5 +1,7 @@
 /*
  * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
+ * Author: William Roske
+ * Co-pilot: Dave Fenner
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of version 2 of the GNU General Public License as
@@ -30,84 +32,10 @@
  * http://oss.sgi.com/projects/GenInfo/NoticeExplan/
  *
  */
-/* $Id: fpathconf01.c,v 1.6 2009/10/26 14:55:47 subrata_modak Exp $ */
-/**********************************************************
- *
- *    OS Test - Silicon Graphics, Inc.
- *
- *    TEST IDENTIFIER	: fpathconf01
- *
- *    EXECUTED BY	: anyone
- *
- *    TEST TITLE	: Basic test for fpathconf(2)
- *
- *    PARENT DOCUMENT	: usctpl01
- *
- *    TEST CASE TOTAL	: 7
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
- * 	1.) fpathconf(2) returns...(See Description)
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
- *      No run-time environmental needs.
- *
- *    SPECIAL PROCEDURAL REQUIREMENTS
- * 	None
- *
- *    INTERCASE DEPENDENCIES
- * 	None
- *
- *    DETAILED DESCRIPTION
- *	This is a Phase I test for the fpathconf(2) system call.  It is intended
- *	to provide a limited exposure of the system call, for now.  It
- *	should/will be extended when full functional tests are written for
- *	fpathconf(2).
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
+
+/*
+ * Testcase to test the basic functionality of fpathconf(2) systemm call.
+ */
 
 #include <fcntl.h>
 #include <unistd.h>
@@ -116,71 +44,62 @@
 #include <signal.h>
 #include "test.h"
 #include "usctest.h"
+#include "safe_macros.h"
 
-void setup();
-void cleanup();
-
-char *TCID = "fpathconf01";
-
-#define FILENAME	"fpafile01"
-
-int exp_enos[] = { 0, 0 };
+static void setup(void);
+static void cleanup(void);
 
-int i;
-
-struct pathconf_args {
-	char *define_tag;
+static struct pathconf_args {
+	char *name;
 	int value;
-	int defined;		/* Some of these are undefined on regular files.
-				 * Cancer does a slightly better job with these already,
-				 * so this is all I'll do to this test.  11/19/98 roehrich
-				 */
-} args[] = {
-	{
-	"_PC_MAX_CANON", _PC_MAX_CANON, 0}, {
-	"_PC_MAX_INPUT", _PC_MAX_INPUT, 0}, {
-	"_PC_VDISABLE", _PC_VDISABLE, 0}, {
-	"_PC_LINK_MAX", _PC_LINK_MAX, 1}, {
-	"_PC_NAME_MAX", _PC_NAME_MAX, 1}, {
-	"_PC_PATH_MAX", _PC_PATH_MAX, 1}, {
-	"_PC_PIPE_BUF", _PC_PIPE_BUF, 0}
+} test_cases[] = {
+	{"_PC_MAX_CANON", _PC_MAX_CANON},
+	{"_PC_MAX_INPUT", _PC_MAX_INPUT},
+	{"_PC_VDISABLE", _PC_VDISABLE},
+	{"_PC_LINK_MAX", _PC_LINK_MAX},
+	{"_PC_NAME_MAX", _PC_NAME_MAX},
+	{"_PC_PATH_MAX", _PC_PATH_MAX},
+	{"_PC_PIPE_BUF", _PC_PIPE_BUF},
 };
 
-int TST_TOTAL = (sizeof(args) / sizeof(args[0]));
-int fd = -1;			/* temp file for fpathconf */
+char *TCID = "fpathconf01";
+int TST_TOTAL = ARRAY_SIZE(test_cases);
+
+static int fd;
 
 int main(int ac, char **av)
 {
 	int lc;
 	char *msg;
+	int i;
 
 	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL)
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
 
 	setup();
 
-	TEST_EXP_ENOS(exp_enos);
-
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
 		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; i++) {
 
-			TEST(fpathconf(fd, args[i].value));
-
-			if (TEST_RETURN == -1 && args[i].defined) {
-				TEST_ERROR_LOG(TEST_ERRNO);
-				tst_resm(TFAIL | TTERRNO,
-					 "fpathconf(fd, %s) failed",
-					 args[i].define_tag);
-			} else {
-				if (STD_FUNCTIONAL_TEST) {
-					tst_resm(TPASS,
-						 "fpathconf(fd, %s) returned %ld",
-						 args[i].define_tag,
-						 TEST_RETURN);
+			TEST(fpathconf(fd, test_cases[i].value));
+
+			if (TEST_RETURN == -1) {
+				if (TEST_ERRNO == 0) {
+					tst_resm(TINFO,
+						 "fpathconf has NO the limit: "
+						 "%s", test_cases[i].name);
+				} else {
+					tst_resm(TFAIL | TTERRNO,
+						 "fpathconf(fd, %s) failed",
+						 test_cases[i].name);
 				}
+			} else {
+				tst_resm(TPASS,
+					 "fpathconf(fd, %s) returned %ld",
+					 test_cases[i].name, TEST_RETURN);
 			}
 		}
 	}
@@ -190,31 +109,22 @@ int main(int ac, char **av)
 	tst_exit();
 }
 
-void setup()
+static void setup(void)
 {
-
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 
 	TEST_PAUSE;
 
 	tst_tmpdir();
 
-	if ((fd = open(FILENAME, O_RDWR | O_CREAT, 0700)) == -1)
-		tst_brkm(TBROK, cleanup, "Unable to open temp file %s!",
-			 FILENAME);
-
+	fd = SAFE_OPEN(cleanup, "fpafile01", O_RDWR | O_CREAT, 0700);
 }
 
-void cleanup()
+static void cleanup(void)
 {
 	TEST_CLEANUP;
 
-	if (fd != -1) {
-		if (close(fd) == -1)
-			tst_resm(TWARN | TERRNO, "close failed");
-		fd = -1;
-	}
+	SAFE_CLOSE(NULL, fd);
 
 	tst_rmdir();
-
 }
-- 
1.8.2.1




------------------------------------------------------------------------------
Sponsored by Intel(R) XDK 
Develop, test and display web and hybrid apps with a single code base.
Download it for free now!
http://pubads.g.doubleclick.net/gampad/clk?id=111408631&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
