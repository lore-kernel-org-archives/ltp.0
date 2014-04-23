Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1WcoEX-0005bg-OZ
	for ltp-list@lists.sourceforge.net; Wed, 23 Apr 2014 03:52:29 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WcoET-0006Tx-L4
	for ltp-list@lists.sourceforge.net; Wed, 23 Apr 2014 03:52:29 +0000
Message-ID: <1398225094.3850.1.camel@G08JYZSD130126>
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Wed, 23 Apr 2014 11:51:34 +0800
In-Reply-To: <64087164.7823458.1398172479616.JavaMail.zimbra@redhat.com>
References: <1398159613.2772.7.camel@G08JYZSD130126>
	<1398159660.2772.8.camel@G08JYZSD130126>
	<64087164.7823458.1398172479616.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v2 1/2] sbrk/sbrk01.c: cleanup
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

* Delete some useless commtents.
* Move the test body from main() to sbrk_verify().
* Remove tst_tmpdir().
* Some cleanup.

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/sbrk/sbrk01.c | 235 +++++++-------------------------
 1 file changed, 51 insertions(+), 184 deletions(-)

diff --git a/testcases/kernel/syscalls/sbrk/sbrk01.c b/testcases/kernel/syscalls/sbrk/sbrk01.c
index b2db42c..0840467 100644
--- a/testcases/kernel/syscalls/sbrk/sbrk01.c
+++ b/testcases/kernel/syscalls/sbrk/sbrk01.c
@@ -1,5 +1,7 @@
 /*
  * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
+ *  AUTHOR		: William Roske
+ *  CO-PILOT		: Dave Fenner
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of version 2 of the GNU General Public License as
@@ -30,84 +32,11 @@
  * http://oss.sgi.com/projects/GenInfo/NoticeExplan/
  *
  */
-/* $Id: sbrk01.c,v 1.8 2009/06/09 16:01:21 subrata_modak Exp $ */
-/**********************************************************
- *
- *    OS Test - Silicon Graphics, Inc.
- *
- *    TEST IDENTIFIER	: sbrk01
- *
- *    EXECUTED BY	: anyone
- *
- *    TEST TITLE	: Basic test for sbrk(2)
- *
- *    PARENT DOCUMENT	: usctpl01
- *
- *    TEST CASE TOTAL	: 2
- *
- *    WALL CLOCK TIME	: 1
- *
- *    CPU TYPES		: ALL
- *
- *    AUTHOR		: William Roske
- *
- *    CO-PILOT		: Dave Fenner
- *
- *    DATE STARTED	: 06/05/92
- *
- *    INITIAL RELEASE	: UNICOS 7.0
- *
- *    TEST CASES
- *
- * 	1.) sbrk(2) returns...(See Description)
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
- *	This is a Phase I test for the sbrk(2) system call.  It is intended
- *	to provide a limited exposure of the system call, for now.  It
- *	should/will be extended when full functional tests are written for
- *	sbrk(2).
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
+/*
+ * DESCRIPTION
+ *	1.) test sbrk(8192) should return successfully.
+ *	2.) test sbrk(-8192) should return successfully.
+ */
 
 #include <unistd.h>
 #include <errno.h>
@@ -118,146 +47,84 @@
 #include "test.h"
 #include "usctest.h"
 
-void setup();
-void cleanup();
-
 char *TCID = "sbrk01";
-int TST_TOTAL = 2;
-
-int Increment;			/* Amount to make change size by */
 
 #if !defined(UCLINUX)
 
+static struct test_case_t {
+	long increment;
+} test_cases[] = {
+	{8192},
+	{-8192},
+};
+
+static void setup(void);
+static void sbrk_verify(const struct test_case_t *);
+static void cleanup(void);
+
+int TST_TOTAL = ARRAY_SIZE(test_cases);
+
 int main(int ac, char **av)
 {
 	int lc;
 	char *msg;
-	void *tret;
+	int i;
 
-    /***************************************************************
-     * parse standard options
-     ***************************************************************/
-	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL) {
+	msg = parse_opts(ac, av, NULL, NULL);
+	if (msg != NULL)
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
 
-	}
-
-    /***************************************************************
-     * perform global setup for test
-     ***************************************************************/
 	setup();
 
-    /***************************************************************
-     * check looping state if -c option given
-     ***************************************************************/
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
 		tst_count = 0;
 
-		/*
-		 * TEST CASE:
-		 * Increase by 8192 bytes
-		 */
-		Increment = 8192;
-
-		/* Call sbrk(2) */
-		errno = 0;
-		tret = sbrk(Increment);	/* Remove -64 IRIX compiler warning */
-		TEST_ERRNO = errno;
-
-		/* check return code */
-		if (tret == (void *)-1) {
-			TEST_ERROR_LOG(TEST_ERRNO);
-			tst_resm(TFAIL,
-				 "sbrk - Increase by 8192 bytes failed, errno=%d : %s",
-				 TEST_ERRNO, strerror(TEST_ERRNO));
-		} else {
-	    /***************************************************************
-	     * only perform functional verification if flag set (-f not given)
-	     ***************************************************************/
-			if (STD_FUNCTIONAL_TEST) {
-				/* No Verification test, yet... */
-				tst_resm(TPASS,
-					 "sbrk - Increase by 8192 bytes returned %p",
-					 tret);
-			}
-		}
-
-		/*
-		 * TEST CASE:
-		 * Decrease to original size
-		 */
-		Increment = (Increment * -1);
-
-		/* Call sbrk(2) */
-		errno = 0;
-		tret = sbrk(Increment);
-		TEST_ERRNO = errno;
-
-		/* check return code */
-		if (tret == (void *)-1) {
-			TEST_ERROR_LOG(TEST_ERRNO);
-			tst_resm(TFAIL,
-				 "sbrk - Decrease to original size failed, errno=%d : %s",
-				 TEST_ERRNO, strerror(TEST_ERRNO));
-		} else {
-	    /***************************************************************
-	     * only perform functional verification if flag set (-f not given)
-	     ***************************************************************/
-			if (STD_FUNCTIONAL_TEST) {
-				/* No Verification test, yet... */
-				tst_resm(TPASS,
-					 "sbrk - Decrease to original size returned %p",
-					 tret);
-			}
-		}
-
+		for (i = 0; i < TST_TOTAL; i++)
+			sbrk_verify(&test_cases[i]);
 	}
 
-    /***************************************************************
-     * cleanup and exit
-     ***************************************************************/
 	cleanup();
 	tst_exit();
 
 }
 
-#else
-
-int main(void)
+static void setup(void)
 {
-	tst_resm(TINFO, "test is not available on uClinux");
-	tst_exit();
-}
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
-#endif /* if !defined(UCLINUX) */
+	TEST_PAUSE;
+}
 
-/***************************************************************
- * setup() - performs all ONE TIME setup for this test.
- ***************************************************************/
-void setup(void)
+static void sbrk_verify(const struct test_case_t *test)
 {
+	void *tret;
 
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
+	tret = sbrk(test->increment);
+	TEST_ERRNO = errno;
 
-	/* make a temp dir and cd to it */
-	tst_tmpdir();
+	if (tret == (void *)-1) {
+		tst_resm(TFAIL | TTERRNO, "sbrk - Increase by %ld bytes failed",
+			 test->increment);
+	} else {
+		tst_resm(TPASS, "sbrk - Increase by %ld bytes returned %p",
+			 test->increment, tret);
+	}
 }
 
-/***************************************************************
- * cleanup() - performs all ONE TIME cleanup for this test at
- *		completion or premature exit.
- ***************************************************************/
-void cleanup(void)
+static void cleanup(void)
 {
-	/*
-	 * print timing stats if that option was specified.
-	 * print errno log if that option was specified.
-	 */
 	TEST_CLEANUP;
+}
 
-	tst_rmdir();
+#else
+
+int TST_TOTAL = 1;
 
+int main(void)
+{
+	tst_resm(TINFO, "test is not available on uClinux");
+	tst_exit();
 }
+
+#endif /* if !defined(UCLINUX) */
-- 
1.8.4.2




------------------------------------------------------------------------------
Start Your Social Network Today - Download eXo Platform
Build your Enterprise Intranet with eXo Platform Software
Java Based Open Source Intranet - Social, Extensible, Cloud Ready
Get Started Now And Turn Your Intranet Into A Collaboration Platform
http://p.sf.net/sfu/ExoPlatform
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
