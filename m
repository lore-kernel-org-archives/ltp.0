Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MXjsh-0003Sq-Bm
	for ltp-list@lists.sourceforge.net; Sun, 02 Aug 2009 22:50:19 +0000
Received: from qw-out-1920.google.com ([74.125.92.146])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MXjsc-0001Ev-8r
	for ltp-list@lists.sourceforge.net; Sun, 02 Aug 2009 22:50:19 +0000
Received: by qw-out-1920.google.com with SMTP id 5so1431089qwc.4
	for <ltp-list@lists.sourceforge.net>;
	Sun, 02 Aug 2009 15:50:08 -0700 (PDT)
MIME-Version: 1.0
Date: Sun, 2 Aug 2009 15:50:08 -0700
Message-ID: <364299f40908021550s16364c1au9b955af027ec32e0@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: [LTP] [PATCH] delete_module* testcase cleanup
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

1. Fix oodles of bad indentation.
2. Get rid of C++ style comments (--std=c89 fix).
3. Get rid of PAGE_SIZE #define because it fails to compile on my
machine, and it's marked `forbidden' for access from userland apps.
Replace it with a better constant value as per the URI contained.
4. Use dirname(3) call instead of /tmp when loading dummy modules.

This patch is PURELY for reviewing and shouldn't be committed to HEAD
without Makefile revisions, as the original Makefile still installs
the dummy modules into /tmp.

Signed-off-by: Garrett Cooper <yanegomi@gmail.com>
Index: testcases/kernel/module/delete_module/delete_module01.c
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/module/delete_module/delete_module01.c,v
retrieving revision 1.7
diff -u -r1.7 delete_module01.c
--- testcases/kernel/module/delete_module/delete_module01.c	26 Feb
2009 12:14:53 -0000	1.7
+++ testcases/kernel/module/delete_module/delete_module01.c	2 Aug 2009
22:48:59 -0000
@@ -32,7 +32,7 @@
  *
  *    DESCRIPTION
  *		 This is a Phase I test for the delete_module(2) system call.
- *		 It is intended to provide a limited exposure of the system call.
+ *		 It is intended to provide limited exposure of the system call.
  *
  *		 Setup:
  *		   Setup signal handling.
@@ -44,8 +44,8 @@
  *		  Loop if the proper options are given.
  *		   Create module entry
  *		   Execute system call
- *		   Check return code, if system call failed (return=-1)
- *		 		 Issue FAIL message with errno.
+ *		   Check return code, if system call failed (return=-1),
+ *		   	issue a FAIL message with the errno.
  *		   Otherwise, Issue PASS message.
  *
  *		 Cleanup:
@@ -54,128 +54,132 @@
  * USAGE:  <for command-line>
  *  delete_module01 [-c n] [-e] [-f] [-h] [-i n] [-I x] [-p] [-P x] [-t]
  *		 		 where,  -c n : Run n copies concurrently.
- *		 		 		 -e   : Turn on errno logging.
- *		 		 		 -f   : Turn off functional testing
- *		 		 		 -h   : Show help screen
- *		 		 		 -i n : Execute test n times.
- *		 		 		 -I x : Execute test for x seconds.
- *		 		 		 -p   : Pause for SIGUSR1 before starting
- *		 		 		 -P x : Pause for x seconds between iterations.
- *		 		 		 -t   : Turn on syscall timing.
+ *			 		 -e   : Turn on errno logging.
+ *		 	 		 -f   : Turn off functional testing
+ *		 	 		 -h   : Show help screen
+ *		 	 		 -i n : Execute test n times.
+ *		 	 		 -I x : Execute test for x seconds.
+ *		 	 		 -p   : Pause for SIGUSR1 before
+ *		 	 		 	starting test.
+ *		 	 		 -P x : Pause for x seconds between
+ *		 	 		 	iterations.
+ *		 	 		 -t   : Turn on syscall timing.
  *
  ****************************************************************/
+
+#include <libgen.h>
 #include <errno.h>
-//#include <linux/module.h>
 #include "test.h"
 #include "usctest.h"

-extern int Tst_count;		 		 /* Test Case counter for tst_* routines */
+extern int Tst_count;			/* TC counter for tst_* routines */

 static void setup(void);
 static void cleanup(void);

 char *TCID = "delete_module01";		 /* Test program identifier.    */
-int TST_TOTAL=1;		 		 /* Total number of test cases. */
-//static char modname[20];		 /* Name of the module */
-	
+int TST_TOTAL = 1;			/* Total number of test cases. */

 int
 main(int argc, char **argv)
 {
-		 int lc;		 		 		 /* loop counter */
-		 char *msg;		 		 /* message returned from parse_opts */
-		 char cmd[PATH_MAX];
-		 char *module_name = "dummy_del_mod";
-
-		 /* parse standard options */
-		 if ((msg = parse_opts(argc, argv, (option_t *)NULL, NULL)) !=
-		 		 		 (char *)NULL) {
-		 		 tst_brkm(TBROK, tst_exit, "OPTION PARSING ERROR - %s", msg);
-		 }
-
-		 /* perform global setup for test */
-		 setup();
-
-		 /* check looping state if -i option is given */
-		 for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		 		 /* reset Tst_count in case we are looping */
-		 		 Tst_count = 0;
-
-		 		 // Execute system call
-		 		 sprintf(cmd, "/sbin/insmod /tmp/%s.ko", module_name);
-
-		 		 // Insmod the module
-		 		 if ( (system( cmd )) != 0 ) {
-						 tst_resm(TBROK, "Failed to load %s module", module_name);
-		 		 		 printf("system() failed; cannot test init_module: errno=%i\n",
-                                errno);
-		 		 		 goto EXIT;
-		 		 }
-
-		 		 /* Test the system call */
-		 		 TEST(delete_module(module_name));
-
-		 		 /* check return code */
-		 		 if (TEST_RETURN == -1) {
-		 		 		 tst_resm(TFAIL, "delete_module() failed to remove"
-		 		 		 		 " module entry for %s, errno=%d : %s",
-		 		 		 		 module_name, TEST_ERRNO, strerror(TEST_ERRNO));
-		 		 } else {
-		 		 		 tst_resm(TPASS, "delete_module() successful, returned"
-		 		 		 		 " %d", TEST_RETURN);
-		 		 }
-		 }
+	int lc;				/* loop counter */
+	char *msg;			/* message returned from parse_opts */
+	char cmd[PATH_MAX];
+	char *module_name = "dummy_del_mod";
+
+	/* parse standard options */
+	if ((msg = parse_opts(argc, argv, (option_t *)NULL, NULL)) !=
+		(char *) NULL) {
+		tst_brkm(TBROK, tst_exit, "OPTION PARSING ERROR - %s", msg);
+	}
+
+	/* perform global setup for test */
+	setup();
+
+	/* check looping state if -i option is given */
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+
+		/* reset Tst_count in case we are looping */
+		Tst_count = 0;
+
+		/* Execute system call */
+		sprintf(cmd, "/sbin/insmod %s/%s.ko", dirname(argv[0]),
+			module_name);
+
+		/* Insmod the module */
+ 		if ( (system( cmd )) != 0 ) {
+			tst_resm(TBROK, "Failed to load %s module",
+					module_name);
+			printf("system() failed; cannot test init_module: "
+			       "errno=%i\n", errno);
+			goto EXIT;
+		}
+
+		/* Test the system call */
+		TEST(delete_module(module_name));
+
+		/* check return code */
+		if (TEST_RETURN == -1) {
+			tst_resm(TFAIL, "delete_module() failed to remove"
+		 			" module entry for %s, errno=%d : %s",
+		 		 	module_name, TEST_ERRNO,
+					strerror(TEST_ERRNO));
+		} else {
+			tst_resm(TPASS, "delete_module() successful, returned"
+	 				" %d", TEST_RETURN);
+	 	}

-		 /* perform global cleanup and exit */
-EXIT:
-		 cleanup();
+	}

-		 /*NOTREACHED*/
-		 return 0;
+	/* perform global cleanup and exit */
+EXIT:
+	cleanup();
+	/*NOTREACHED*/
+	return 0;

-}		 /* End main */
+}		/* End main */

 /* setup() - performs all ONE TIME setup for this test */
 void
 setup(void)
 {
-		 /* capture signals */
-		 tst_sig(FORK, DEF_HANDLER, cleanup);
+	/* capture signals */
+	tst_sig(FORK, DEF_HANDLER, cleanup);

-		 /* Check whether we are root  */
-		 if (geteuid() != 0) {
-		 		 tst_brkm(TBROK, tst_exit, "Must be root for this test!");
-		 		 /*NOTREACHED*/
-		 }
-
-		 //if (tst_kvercmp(2,5,48) >= 0)
-		 		 //tst_brkm(TCONF, tst_exit, "This test will not work on "
-		 		 		 		 //"kernels after 2.5.48");
-
-		 /* Pause if that option was specified
-		  * TEST_PAUSE contains the code to fork the test with the -c option.
-		  */
-		 TEST_PAUSE;
+	/* Check whether we are root  */
+	if (geteuid() != 0) {
+		tst_brkm(TBROK, tst_exit, "Must be root for this test!");
+		/*NOTREACHED*/
+	}
+
+	/*
+	 * if (tst_kvercmp(2,5,48) >= 0)
+	 * tst_brkm(TCONF, tst_exit, "This test will not work on "
+	 *				"kernels after 2.5.48");
+	 */
+	/* Pause if that option was specified
+	 * TEST_PAUSE contains the code to fork the test with the -c option.
+	 */
+	TEST_PAUSE;

 }

 /*
  * cleanup()
- *		 performs all ONE TIME cleanup for this test at
- *		 completion or premature exit
+ *	performs all ONE TIME cleanup for this test at
+ *	completion or premature exit
  */
 void
 cleanup(void)
 {
-		 /*
-		  * print timing stats if that option was specified.
-		  * print errno log if that option was specified.
-		  */
-		 TEST_CLEANUP;
-
-		 /* exit with return code appropriate for results */
-		 tst_exit();
-		 /*NOTREACHED*/
+	/*
+	 * print timing stats if that option was specified.
+	 * print errno log if that option was specified.
+	 */
+	TEST_CLEANUP;
+
+	/* exit with return code appropriate for results */
+	tst_exit();
+	/*NOTREACHED*/
 }
-
Index: testcases/kernel/module/delete_module/delete_module02.c
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/module/delete_module/delete_module02.c,v
retrieving revision 1.6
diff -u -r1.6 delete_module02.c
--- testcases/kernel/module/delete_module/delete_module02.c	26 Feb
2009 12:02:28 -0000	1.6
+++ testcases/kernel/module/delete_module/delete_module02.c	2 Aug 2009
22:48:59 -0000
@@ -32,8 +32,8 @@
  *
  *    DESCRIPTION
  *      Verify that,
- *      1. delete_module(2) returns -1 and sets errno to ENOENT for
non-existing
- *		    module entry.
+ *      1. delete_module(2) returns -1 and sets errno to ENOENT for nonexistent
+ *	   module entry.
  *      2. delete_module(2) returns -1 and sets errno to EINVAL, if module
  *         name parameter is null terminated (zero length) string.
  *      3. delete_module(2) returns -1 and sets errno to EFAULT, if
@@ -68,14 +68,16 @@
  * USAGE:  <for command-line>
  *  delete_module02 [-c n] [-e] [-f] [-h] [-i n] [-I x] [-p] [-P x] [-t]
  *		 		 where,  -c n : Run n copies concurrently.
- *		 		 		 -e   : Turn on errno logging.
- *		 		 		 -f   : Turn off functional testing
- *		 		 		 -h   : Show help screen
- *		 		 		 -i n : Execute test n times.
- *		 		 		 -I x : Execute test for x seconds.
- *		 		 		 -p   : Pause for SIGUSR1 before starting
- *		 		 		 -P x : Pause for x seconds between iterations.
- *		 		 		 -t   : Turn on syscall timing.
+ *	 		 		 -e   : Turn on errno logging.
+ *	 		 		 -f   : Turn off functional testing
+ *	 		 		 -h   : Show help screen
+ *	 		 		 -i n : Execute test n times.
+ *	 		 		 -I x : Execute test for x seconds.
+ *	 		 		 -p   : Pause for SIGUSR1 before
+ *	 		 		 	starting test.
+ *	 		 		 -P x : Pause for x seconds between
+ *	 		 		 	iterations.
+ *	 		 		 -t   : Turn on syscall timing.
  *
  ****************************************************************/

@@ -84,38 +86,43 @@
 #include <sys/types.h>
 #include <unistd.h>
 #include <limits.h>
-//#include <linux/module.h>
+#if HAVE_LINUX_MODULE_H
+#include <linux/module.h>
+#else
+/* As per http://tomoyo.sourceforge.jp/cgi-bin/lxr/source/include/linux/moduleparam.h?a=ppc#L17
... */
+#define MODULE_NAME_LEN	( 64 - sizeof(unsigned long) )
+#endif
 #include <sys/mman.h>
 #include "test.h"
 #include "usctest.h"

-#ifndef PAGE_SIZE
-#define PAGE_SIZE sysconf(_SC_PAGE_SIZE)
-#endif
-
 extern int Tst_count;

 #define NULLMODNAME ""
 #define BASEMODNAME "dummy"
-#define LONGMODNAMECHAR 'm'		 		 /* Arbitrarily selected */
-#define MODNAMEMAX (PAGE_SIZE + 1)
+#define LONGMODNAMECHAR 'm'			/* Arbitrarily selected */
 #define EXP_RET_VAL -1

-struct test_case_t {		 		 		 /* test case structure */
-		 char 		 *modname;
-		 int		 experrno;		 		 /* expected errno */
-		 char		 *desc;
-		 int		 (*setup)(void);		 		 /* Individual setup routine */
-		 void		 (*cleanup)(void);		 /* Individual cleanup routine */
+/* Test case structure */
+struct test_case_t {
+	char 		 *modname;
+	/* Expected errno. */
+	int		 experrno;
+	char		 *desc;
+	/* Individual setup routine. */
+	int		 (*setup)(void);
+	/* Individual cleanup routine */
+	void		 (*cleanup)(void);
 };

 char *TCID = "delete_module02";
-static int exp_enos[] = {EPERM, EINVAL, ENOENT, EFAULT, ENAMETOOLONG, 0};
+static int exp_enos[] = { EPERM, EINVAL, ENOENT, EFAULT, ENAMETOOLONG, 0 };
 static char nobody_uid[] = "nobody";
 struct passwd *ltpuser;
-static char longmodname[MODNAMEMAX];
+static char longmodname[MODULE_NAME_LEN];
 static int testno;
-static char modname[20];		 		 /* Name of the module */
+/* Name of the module */
+static char modname[20];

 char * bad_addr = 0;

@@ -124,17 +131,20 @@
 static int setup1(void);
 static void cleanup1(void);

+struct test_case_t;
+
 static struct test_case_t  tdat[] = {
 		 { modname, ENOENT,
-		 		 "non-existing module", NULL, NULL},
+		 	"nonexistent module", NULL, NULL},
 		 { NULLMODNAME, ENOENT,
-		 		 "null terminated module name", NULL, NULL},
-		 { (char *) -1, EFAULT, "module name outside program's "
-		 		 "accessible address space", NULL, NULL},
+		 	"null terminated module name", NULL, NULL},
+		 { (char *) -1, EFAULT,
+			"module name outside program's "
+			"accessible address space", NULL, NULL},
 		 { longmodname, ENOENT,
-		 		 "long module name", NULL, NULL},
+		 	"long module name", NULL, NULL},
 		 { modname, EPERM,
-		 		 "non-superuser", setup1, cleanup1},
+		 	"non-superuser", setup1, cleanup1},
 };

 int TST_TOTAL = sizeof(tdat) / sizeof(tdat[0]);
@@ -142,145 +152,146 @@
 int
 main(int argc, char **argv)
 {
-		 int lc;		 		 		 		 /* loop counter */
-		 char *msg;		 		 		 /* message returned from parse_opts */
+	int lc; 		 /* loop counter */
+	char *msg; 		 /* message returned from parse_opts */

-		 /* parse standard options */
-		 if ((msg = parse_opts(argc, argv, (option_t *)NULL, NULL)) !=
-		     (char *)NULL) {
-		 		 tst_brkm(TBROK, tst_exit, "OPTION PARSING ERROR - %s", msg);
-		 }
-
-		 setup();
-
-		 /* check looping state if -i option is given */
-		 for (lc = 0; TEST_LOOPING(lc); lc++) {
-		 		 /* reset Tst_count in case we are looping */
-		 		 Tst_count = 0;
-
-		 		 for (testno = 0; testno < TST_TOTAL; ++testno) {
-		 		 		 if( (tdat[testno].setup) && (tdat[testno].setup()) ) {
-		 		 		 		 /* setup() failed, skip this test */
-		 		 		 		 continue;
-		 		 		 }
-
-		 		 		 /* Test the system call */
-		 		 		 TEST(delete_module(tdat[testno].modname));
-		 		 		 TEST_ERROR_LOG(TEST_ERRNO);
-		 		 		 printf("TEST_RETURN is %d, TEST_ERRNO is %d\n", TEST_RETURN,
TEST_ERRNO);
-		 		 		 if ( (TEST_RETURN == EXP_RET_VAL) &&
-		 		 		 		 (TEST_ERRNO == tdat[testno].experrno) ) {
-		 		 		 		 tst_resm(TPASS, "Expected results for %s, "
-		 		 		 		 		 "errno: %d", tdat[testno].desc,
-		 		 		 		 		 TEST_ERRNO);
-		 		 		 } else {
-		 		 		 		 tst_resm(TFAIL, "Unexpected results for %s ; "
-		 		 		 		 		 "returned %d (expected %d), errno %d "
-		 		 		 		 		 "(expected %d)", tdat[testno].desc,
-		 		 		 		 		 TEST_RETURN, EXP_RET_VAL,
-		 		 		 		 		 TEST_ERRNO, tdat[testno].experrno);
-		 		 		 }
-		 		 		 if(tdat[testno].cleanup) {
-		 		 		 		 tdat[testno].cleanup();
-		 		 		 }
-		 		 }
-		 }
-		 cleanup();
+	/* parse standard options */
+	if ((msg = parse_opts(argc, argv, (option_t *)NULL, NULL)) !=
+	     (char *)NULL) {
+		tst_brkm(TBROK, tst_exit, "OPTION PARSING ERROR - %s", msg);
+	}
+
+	setup();
+
+	/* check looping state if -i option is given */
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		/* reset Tst_count in case we are looping */
+		Tst_count = 0;
+
+		for (testno = 0; testno < TST_TOTAL; ++testno) {
+			if( (tdat[testno].setup) && (tdat[testno].setup()) ) {
+		 		/* setup() failed, skip this test */
+		 		continue;
+		 	}
+			/* Test the system call */
+		 	TEST(delete_module(tdat[testno].modname));
+		 	TEST_ERROR_LOG(TEST_ERRNO);
+		 	printf("TEST_RETURN is %d, TEST_ERRNO is %d\n",
+				TEST_RETURN, TEST_ERRNO);
+		 	if ( (TEST_RETURN == EXP_RET_VAL) &&
+		 	     (TEST_ERRNO == tdat[testno].experrno) ) {
+		 		tst_resm(TPASS, "Expected results for %s, "
+		 				"errno: %d", tdat[testno].desc,
+		 		 		TEST_ERRNO);
+		 	} else {
+				tst_resm(TFAIL, "Unexpected results for %s ; "
+						"returned %d (expected %d), "
+						"errno %d (expected %d)",
+						tdat[testno].desc,
+						TEST_RETURN, EXP_RET_VAL,
+						TEST_ERRNO,
+						tdat[testno].experrno);
+			}
+			if(tdat[testno].cleanup) {
+				tdat[testno].cleanup();
+			}
+		}
+	}
+	cleanup();

-		 /*NOTREACHED*/
-		 return 0;
+	/*NOTREACHED*/
+	return 0;
 }

 int
 setup1(void)
 {
-		 /* Change effective user id to nodody */
-		 if (seteuid(ltpuser->pw_uid) == -1) {
-		 		 tst_resm(TBROK, "seteuid failed to set the effective"
-		 		 		 		 " uid to %d", ltpuser->pw_uid);
-		 		 return 1;
-		 }
-		 return 0;
+	/* Change effective user id to nodody */
+	if (seteuid(ltpuser->pw_uid) == -1) {
+		tst_resm(TBROK, "seteuid failed to set the effective"
+				" uid to %d", ltpuser->pw_uid);
+		return 1;
+	}
+	return 0;
 }

 void
 cleanup1(void)
 {
-		  /* Change effective user id to root */
-         if (seteuid(0) == -1) {
-		 		 tst_brkm(TBROK, tst_exit, "seteuid failed to set the effective"
-		 		 		 " uid to root");
-         }
+	/* Change effective user id to root */
+	if (seteuid(0) == -1) {
+		tst_brkm(TBROK, tst_exit, "seteuid failed to set the effective"
+					  " uid to root");
+	}
 }


 /*
  * setup()
- *		 performs all ONE TIME setup for this test
+ *	performs all ONE TIME setup for this test
  */
 void
 setup(void)
 {
-		 /* capture signals */
-		 tst_sig(NOFORK, DEF_HANDLER, cleanup);
+	/* capture signals */
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);

-		 /* Check whether it is root  */
-		 if (geteuid() != 0) {
-		 		 tst_brkm(TBROK, tst_exit, "Must be root for this test!");
-		 		 /*NOTREACHED*/
-		 }
-
-		 /*if (tst_kvercmp(2,5,48) >= 0)
-		 		 tst_brkm(TCONF, tst_exit, "This test will not work on "
-		 		 		 		 "kernels after 2.5.48");
-		 */
-
-        /* Check for nobody_uid user id */
-		  if( (ltpuser = getpwnam(nobody_uid)) == NULL) {
-		 		 tst_brkm(TBROK, tst_exit, "Required user %s doesn't exists",
-		 		 		 		 nobody_uid);
-		 		 /*NOTREACHED*/
-		  }
-
-		 /* Initialize longmodname to LONGMODNAMECHAR character */
-		 memset(longmodname, LONGMODNAMECHAR, MODNAMEMAX - 1);
-
-		 /* set the expected errnos... */
-		 TEST_EXP_ENOS(exp_enos);
-
-		 /* Pause if that option was specified
-		  * TEST_PAUSE contains the code to fork the test with the -c option.
-		  */
-		 TEST_PAUSE;
-
-		 /* Get unique module name for each child process */
-		 if( sprintf(modname, "%s_%d",BASEMODNAME, getpid()) <= 0) {
-		 		 tst_brkm(TBROK, tst_exit, "Failed to initialize module name");
-		 }
-        bad_addr = mmap(0, 1, PROT_NONE, MAP_PRIVATE|MAP_ANONYMOUS, 0, 0);
+	/* Check whether it is root  */
+	if (geteuid() != 0) {
+		tst_brkm(TBROK, tst_exit, "Must be root for this test!");
+		/*NOTREACHED*/
+	}
+
+	/*if (tst_kvercmp(2,5,48) >= 0)
+		tst_brkm(TCONF, tst_exit, "This test will not work on "
+					  "kernels after 2.5.48");
+	 */
+
+	/* Check for nobody_uid user id */
+	if( (ltpuser = getpwnam(nobody_uid)) == NULL) {
+		tst_brkm(TBROK, tst_exit, "Required user %s doesn't exists",
+			 nobody_uid);
+		/*NOTREACHED*/
+	}
+
+	/* Initialize longmodname to LONGMODNAMECHAR character */
+	memset(longmodname, LONGMODNAMECHAR, MODULE_NAME_LEN - 1);
+
+	/* set the expected errnos... */
+	TEST_EXP_ENOS(exp_enos);
+
+	/* Pause if that option was specified
+	 * TEST_PAUSE contains the code to fork the test with the -c option.
+	 */
+	TEST_PAUSE;
+
+	/* Get unique module name for each child process */
+	if( sprintf(modname, "%s_%d", BASEMODNAME, getpid()) <= 0) {
+		tst_brkm(TBROK, tst_exit, "Failed to initialize module name");
+	}
+        bad_addr = mmap(0, 1, PROT_NONE, MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
         if (bad_addr == MAP_FAILED) {
-                tst_brkm(TBROK, cleanup, "mmap failed");
-    		 }
-		 tdat[2].modname = bad_addr;
+		tst_brkm(TBROK, cleanup, "mmap failed");
+	}
+	tdat[2].modname = bad_addr;

 }

 /*
  * cleanup()
- *		 performs all ONE TIME cleanup for this test at
- *		 completion or premature exit
+ *	performs all ONE TIME cleanup for this test at
+ *	completion or premature exit
  */
 void
 cleanup(void)
 {
-		 /*
-		  * print timing stats if that option was specified.
-		  * print errno log if that option was specified.
-		  */
-		 TEST_CLEANUP;
-
-		 /* exit with return code appropriate for results */
-		 tst_exit();
-		 /*NOTREACHED*/
+	/*
+	 * print timing stats if that option was specified.
+	 * print errno log if that option was specified.
+	 */
+	TEST_CLEANUP;
+
+	/* exit with return code appropriate for results */
+	tst_exit();
+	/*NOTREACHED*/
 }
-
Index: testcases/kernel/module/delete_module/delete_module03.c
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/module/delete_module/delete_module03.c,v
retrieving revision 1.6
diff -u -r1.6 delete_module03.c
--- testcases/kernel/module/delete_module/delete_module03.c	26 Feb
2009 12:02:28 -0000	1.6
+++ testcases/kernel/module/delete_module/delete_module03.c	2 Aug 2009
22:48:59 -0000
@@ -54,32 +54,35 @@
  *
  * USAGE:  <for command-line>
  *  delete_module03 [-c n] [-e] [-f] [-h] [-i n] [-I x] [-p] [-P x] [-t]
- *		 		 where,  -c n : Run n copies concurrently. (no effect)
- *		 		 		 -e   : Turn on errno logging.
- *		 		 		 -f   : Turn off functional testing
- *		 		 		 -h   : Show help screen
- *		 		 		 -i n : Execute test n times.
- *		 		 		 -I x : Execute test for x seconds.
- *		 		 		 -p   : Pause for SIGUSR1 before starting
- *		 		 		 -P x : Pause for x seconds between iterations.
- *		 		 		 -t   : Turn on syscall timing.
+ *		 		 where,  -c n : Run n copies concurrently. (no
+ *		 		 		effect)
+ *	 		 		 -e   : Turn on errno logging.
+ *	 		 		 -f   : Turn off functional testing
+ *	 		 		 -h   : Show help screen
+ *	 		 		 -i n : Execute test n times.
+ *	 		 		 -I x : Execute test for x seconds.
+ *	 		 		 -p   : Pause for SIGUSR1 before
+ *	 		 		 	starting
+ *	 		 		 -P x : Pause for x seconds between
+ *	 		 		 	iterations.
+ *	 		 		 -t   : Turn on syscall timing.
  *
  * RESTRICTIONS
- *		 -c option has no effect for this testcase, even if used allows only
- *		 one instance to run at a time.
+ *		 -c option has no effect for this testcase, even if used allows
+ *		 only one instance to run at a time.
  *
  * CHANGELOG
  *
- *  11/22/02 - Added "--force" to insmod options and redirected
output to /dev/null.
- *             This was done to allow kernel mismatches, b/c it
doesn't matter in
- *             this case.
- *           Robbie Williamson <robbiew@us.ibm.com>
+ *  11/22/02 -	Added "--force" to insmod options and redirected output to
+ *  		/dev/null. This was done to allow kernel mismatches, b/c it
+ *  		doesn't matter in this case.
+ *		Robbie Williamson <robbiew@us.ibm.com>
  *
  ****************************************************************/

+#include <libgen.h>
 #include <errno.h>
 #include <pwd.h>
-//#include <linux/module.h>
 #include "test.h"
 #include "usctest.h"

@@ -89,10 +92,10 @@
 #define DUMMY_MOD_DEP		 "dummy_del_mod_dep"
 #define EXP_RET_VAL		 -1
 #define EXP_ERRNO		 EWOULDBLOCK
-//#define EXP_ERRNO		 EBUSY
+/*#define EXP_ERRNO		 EBUSY */

 char *TCID = "delete_module03";
-//static int exp_enos[] = {EBUSY, 0};
+/*static int exp_enos[] = {EBUSY, 0}; */
 static int exp_enos[] = {EWOULDBLOCK, 0};
 int TST_TOTAL = 1;

@@ -102,137 +105,138 @@
 int
 main(int argc, char **argv)
 {
-		 int lc;		 		 		 		 /* loop counter */
-		 char *msg;		 		 		 /* message returned from parse_opts */
-		 char cmd[50];
-
-		 /* parse standard options */
-		 if ((msg = parse_opts(argc, argv, (option_t *)NULL, NULL)) !=
-		     (char *)NULL) {
-		 		 tst_brkm(TBROK, tst_exit, "OPTION PARSING ERROR - %s", msg);
-		 }
-
-		 if(STD_COPIES != 1) {
-		 		 tst_resm(TINFO, "-c option has no effect for this testcase - "
-		 		 		 "doesn't allow running more than one instance "
-		 		 		 "at a time");
-		 		 STD_COPIES = 1;
-		 }
-
-		 /* Load first kernel module */
-        if( sprintf(cmd, "/sbin/insmod /tmp/%s.ko", DUMMY_MOD) <= 0) {
-                tst_resm(TBROK, "sprintf failed");
-                return 1;
-        }
-        if( (system(cmd)) != 0 ) {
-                tst_resm(TBROK, "Failed to load %s module", DUMMY_MOD);
-                return 1;
-        }
-
-		 /* Load dependant kernel module */
-        if( sprintf(cmd, "/sbin/insmod /tmp/%s.ko", DUMMY_MOD_DEP) <= 0) {
-                tst_resm(TBROK, "sprintf failed");
-                goto END;
-        }
+	int lc;		 		 /* loop counter */
+	char *msg;	 		 /* message returned from parse_opts */
+	char cmd[50];
+
+	/* parse standard options */
+	if ((msg = parse_opts(argc, argv, (option_t*) NULL, NULL)) !=
+	    (char *) NULL) {
+		tst_brkm(TBROK, tst_exit, "OPTION PARSING ERROR - %s", msg);
+	}
+
+	if(STD_COPIES != 1) {
+		tst_resm(TINFO, "-c option has no effect for this testcase - "
+				"doesn't allow running more than one instance "
+		 		"at a time");
+		STD_COPIES = 1;
+	}
+
+	/* Load first kernel module */
+	if( sprintf(cmd, "/sbin/insmod %s/%s.ko", dirname(argv[0]),
+		DUMMY_MOD) <= 0) {
+		tst_resm(TBROK, "sprintf failed");
+		return 1;
+	}
+	if( (system(cmd)) != 0 ) {
+		tst_resm(TBROK, "Failed to load %s module", DUMMY_MOD);
+		return 1;
+	}
+
+	/* Load dependant kernel module */
+        if( sprintf(cmd, "/sbin/insmod %s/%s.ko", dirname(argv[0]),
+		DUMMY_MOD_DEP) <= 0) {
+		tst_resm(TBROK, "sprintf failed");
+		goto END;
+	}
         if( (system(cmd)) != 0 ) {
-                tst_resm(TBROK, "Failed to load %s module", DUMMY_MOD_DEP);
-                goto END;
+		tst_resm(TBROK, "Failed to load %s module", DUMMY_MOD_DEP);
+		goto END;
         }

-		 tst_tmpdir();
-		 if(setup() != 0) {
-		 		 return 1;
-		 }
-
-		 /* check looping state if -i option is given */
-		 for (lc = 0; TEST_LOOPING(lc); lc++) {
-		 		 /* reset Tst_count in case we are looping */
-		 		 Tst_count = 0;
-
-		 		 /* Test the system call */
-		 		 TEST(delete_module(DUMMY_MOD));
-
-		 		 TEST_ERROR_LOG(TEST_ERRNO);
-		 		 if ( (TEST_RETURN == (int) EXP_RET_VAL ) &&
-		 		 		 		 (TEST_ERRNO == EXP_ERRNO) ) {
-		 		 		 tst_resm(TPASS, "Expected failure for module in-use, "
-		 		 		 		 "errno: %d", TEST_ERRNO);
-		 		 } else {
-		 		 		 tst_resm(TFAIL, "Unexpected results for module in-use; "
-		 		 		 		 "returned %d (expected %d), errno %d "
-		 		 		 		 "(expected %d)", TEST_RETURN, EXP_RET_VAL,
-		 		 		 		 TEST_ERRNO, EXP_ERRNO);
-		 		 }
-		 }
-		 cleanup();
+	tst_tmpdir();
+	if(setup() != 0) {
+		return 1;
+	}
+
+	/* check looping state if -i option is given */
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		/* reset Tst_count in case we are looping */
+		Tst_count = 0;
+
+		/* Test the system call */
+		TEST(delete_module(DUMMY_MOD));
+
+		TEST_ERROR_LOG(TEST_ERRNO);
+		if ( (TEST_RETURN == (int) EXP_RET_VAL ) &&
+		     (TEST_ERRNO == EXP_ERRNO) ) {
+			tst_resm(TPASS, "Expected failure for module in-use, "
+		 			"errno: %d", TEST_ERRNO);
+		} else {
+			tst_resm(TFAIL, "Unexpected results for module in-use; "
+		 			"returned %d (expected %d), errno %d "
+					"(expected %d)", TEST_RETURN,
+					EXP_RET_VAL, TEST_ERRNO, EXP_ERRNO);
+		}
+	}
+	cleanup();
 END:
-		 if(system("rmmod "DUMMY_MOD) != 0) {
-		 		 tst_resm(TBROK, "Failed to unload %s module", DUMMY_MOD);
-		 		 return 1;
-		 }
+	if(system("rmmod "DUMMY_MOD) != 0) {
+		tst_resm(TBROK, "Failed to unload %s module", DUMMY_MOD);
+		return 1;
+	}

-		 /*NOTREACHED*/
-		 return 0;
+	/*NOTREACHED*/
+	return 0;
 }

 /*
  * setup()
- *		 performs all ONE TIME setup for this test
+ *	performs all ONE TIME setup for this test
  */
 int
 setup(void)
 {
-		 /* capture signals */
-		 tst_sig(FORK, DEF_HANDLER, cleanup);
+	/* capture signals */
+	tst_sig(FORK, DEF_HANDLER, cleanup);

-		 /* Check whether it is root  */
-		 if (geteuid() != 0) {
-		 		 tst_resm(TBROK, "Must be root for this test!");
-		 		 return 1;
-		 }
-
-		 /*
-		 if (tst_kvercmp(2,5,48) >= 0)
-		 		 tst_brkm(TCONF, tst_exit, "This test will not work on "
-		 		 		 		 "kernels after 2.5.48");
-		 */
-
-		 /* set the expected errnos... */
-		 TEST_EXP_ENOS(exp_enos);
-
-		 /* Pause if that option was specified
-		  * TEST_PAUSE contains the code to fork the test with the -c option.
-		  */
-		 TEST_PAUSE;
-		 return 0;
+	/* Check whether it is root  */
+	if (geteuid() != 0) {
+		tst_resm(TBROK, "Must be root for this test!");
+		return 1;
+	}
+
+	/*
+	if (tst_kvercmp(2,5,48) >= 0)
+		tst_brkm(TCONF, tst_exit, "This test will not work on "
+					  "kernels after 2.5.48");
+	*/
+
+	/* set the expected errnos... */
+	TEST_EXP_ENOS(exp_enos);
+
+	/* Pause if that option was specified
+	 * TEST_PAUSE contains the code to fork the test with the -c option.
+	 */
+	TEST_PAUSE;
+	return 0;

 }

 /*
  * cleanup()
- *		 performs all ONE TIME cleanup for this test at
- *		 completion or premature exit
+ *	performs all ONE TIME cleanup for this test at
+ *	completion or premature exit
  */
 void
 cleanup(void)
 {
-		 /* Unload dependent kernel module */
-		 if(system("rmmod "DUMMY_MOD_DEP) != 0) {
-		 		 tst_resm(TBROK, "Failed to unload %s module",
-		 		 		 DUMMY_MOD_DEP);
-		 }
-		 /* Unload first kernel module */
-		 if(system("rmmod "DUMMY_MOD) != 0) {
-		 		 tst_resm(TBROK, "Failed to unload %s module",
-		 		 		 DUMMY_MOD);
-		 }
-		 /*
-		  * print timing stats if that option was specified.
-		  * print errno log if that option was specified.
-		  */
-		 TEST_CLEANUP;
-		 tst_rmdir();
-		 /* exit with return code appropriate for results */
-		 tst_exit();
-		 /*NOTREACHED*/
+	/* Unload dependent kernel module */
+	if(system("rmmod "DUMMY_MOD_DEP) != 0) {
+		tst_resm(TBROK, "Failed to unload %s module", DUMMY_MOD_DEP);
+	}
+	/* Unload first kernel module */
+	if(system("rmmod "DUMMY_MOD) != 0) {
+		tst_resm(TBROK, "Failed to unload %s module",
+		DUMMY_MOD);
+	}
+	/*
+	 * print timing stats if that option was specified.
+	 * print errno log if that option was specified.
+	 */
+	TEST_CLEANUP;
+	tst_rmdir();
+	/* exit with return code appropriate for results */
+	tst_exit();
+	/*NOTREACHED*/
 }

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
