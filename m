From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 17 Jul 2019 19:31:20 +0200
Subject: [LTP] [PATCH 1/1] sethostname: Convert to new API
Message-ID: <20190717173120.4700-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

by using code of setdomainname() tests

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .../syscalls/setdomainname/setdomainname.h    |  28 ++-
 .../syscalls/setdomainname/setdomainname01.c  |  10 +-
 .../kernel/syscalls/sethostname/Makefile      |  33 ++-
 .../syscalls/sethostname/sethostname01.c      | 155 --------------
 .../syscalls/sethostname/sethostname02.c      | 191 ------------------
 .../syscalls/sethostname/sethostname03.c      | 179 ----------------
 6 files changed, 41 insertions(+), 555 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/sethostname/sethostname01.c
 delete mode 100644 testcases/kernel/syscalls/sethostname/sethostname02.c
 delete mode 100644 testcases/kernel/syscalls/sethostname/sethostname03.c

diff --git a/testcases/kernel/syscalls/setdomainname/setdomainname.h b/testcases/kernel/syscalls/setdomainname/setdomainname.h
index 76a72df22..12c8a088f 100644
--- a/testcases/kernel/syscalls/setdomainname/setdomainname.h
+++ b/testcases/kernel/syscalls/setdomainname/setdomainname.h
@@ -13,6 +13,18 @@
 
 #define TST_VALID_DOMAIN_NAME "test_dom"
 
+#ifdef TEST_SETHOSTNAME
+# define GET_SYSCALL gethostname
+# define SET_SYSCALL sethostname
+# define SYSCALL_NAME "hostname"
+# define SYSCALL_NR __NR_sethostname
+#else
+# define GET_SYSCALL getdomainname
+# define SET_SYSCALL setdomainname
+# define SYSCALL_NAME "domainname"
+# define SYSCALL_NR __NR_setdomainname
+#endif
+
 static char backup[_UTSNAME_DOMAIN_LENGTH];
 
 #define TEST_VARIANTS 2
@@ -21,10 +33,10 @@ static void setdomainname_info(void)
 {
 	switch (tst_variant) {
 	case 0:
-		tst_res(TINFO, "Testing libc setdomainname()");
+		tst_res(TINFO, "Testing libc set" SYSCALL_NAME "()");
 		break;
 	case 1:
-		tst_res(TINFO, "Testing __NR_setdomainname syscall");
+		tst_res(TINFO, "Testing __NR_set" SYSCALL_NAME " syscall");
 		break;
 	}
 }
@@ -33,10 +45,10 @@ static int do_setdomainname(char *new, size_t len)
 {
 	switch (tst_variant) {
 	case 0:
-		return setdomainname(new, len);
+		return SET_SYSCALL(new, len);
 	break;
 	case 1:
-		return tst_syscall(__NR_setdomainname, new, len);
+		return tst_syscall(SYSCALL_NR, new, len);
 	}
 
 	return -1;
@@ -45,14 +57,14 @@ static int do_setdomainname(char *new, size_t len)
 static void setup(void)
 {
 	setdomainname_info();
-	if ((getdomainname(backup, sizeof(backup))) < 0)
-		tst_brk(TBROK | TERRNO, "getdomainname() failed");
+	if ((GET_SYSCALL(backup, sizeof(backup))) < 0)
+		tst_brk(TBROK | TERRNO, "get" SYSCALL_NAME "() failed");
 }
 
 static void cleanup(void)
 {
-	if ((setdomainname(backup, strlen(backup))) < 0)
-		tst_res(TWARN | TERRNO, "setdomainname() failed ('%s')", backup);
+	if ((SET_SYSCALL(backup, strlen(backup))) < 0)
+		tst_res(TWARN | TERRNO, "set" SYSCALL_NAME "() failed ('%s')", backup);
 }
 
 #endif /* SETDOMAINNAME_H__ */
diff --git a/testcases/kernel/syscalls/setdomainname/setdomainname01.c b/testcases/kernel/syscalls/setdomainname/setdomainname01.c
index 57d58ab42..5423c2b2b 100644
--- a/testcases/kernel/syscalls/setdomainname/setdomainname01.c
+++ b/testcases/kernel/syscalls/setdomainname/setdomainname01.c
@@ -15,15 +15,15 @@ static void do_test(void)
 	TEST(do_setdomainname(new, sizeof(new)));
 
 	if (TST_RET != 0)
-		tst_brk(TFAIL | TTERRNO, "setdomainname() failed: %d", TST_ERR);
+		tst_brk(TFAIL | TTERRNO, "set" SYSCALL_NAME "() failed: %d", TST_ERR);
 
-	if (getdomainname(tmp, sizeof(tmp)) != 0)
-		tst_brk(TFAIL | TERRNO, "getdomainname() failed");
+	if (GET_SYSCALL(tmp, sizeof(tmp)) != 0)
+		tst_brk(TFAIL | TERRNO, "get" SYSCALL_NAME "() failed");
 
 	if (strcmp(tmp, new))
-		tst_res(TFAIL, "getdomainname() returned wrong domainname: '%s'", tmp);
+		tst_res(TFAIL, "get" SYSCALL_NAME "() returned wrong domainname: '%s'", tmp);
 	else
-		tst_res(TPASS, "setdomainname() succeed");
+		tst_res(TPASS, "set" SYSCALL_NAME "() succeed");
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/syscalls/sethostname/Makefile b/testcases/kernel/syscalls/sethostname/Makefile
index bd617d806..71d21c5ab 100644
--- a/testcases/kernel/syscalls/sethostname/Makefile
+++ b/testcases/kernel/syscalls/sethostname/Makefile
@@ -1,23 +1,22 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
+# Copyright (c) 2019 Petr Vorel <petr.vorel@gmail.com>
 
 top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 
+CPPFLAGS += -DTEST_SETHOSTNAME
+
+sethostname01: $(abs_srcdir)/../setdomainname/setdomainname01.c
+	$(LINK.c) $^ $(LOADLIBES) $(LDLIBS) $(OUTPUT_OPTION)
+
+sethostname02: $(abs_srcdir)/../setdomainname/setdomainname02.c
+	$(LINK.c) $^ $(LOADLIBES) $(LDLIBS) $(OUTPUT_OPTION)
+
+sethostname03: $(abs_srcdir)/../setdomainname/setdomainname03.c
+	$(LINK.c) $^ $(LOADLIBES) $(LDLIBS) $(OUTPUT_OPTION)
+
+MAKE_TARGETS := sethostname01 sethostname02 sethostname03
+
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/sethostname/sethostname01.c b/testcases/kernel/syscalls/sethostname/sethostname01.c
deleted file mode 100644
index 5468068b8..000000000
--- a/testcases/kernel/syscalls/sethostname/sethostname01.c
+++ /dev/null
@@ -1,155 +0,0 @@
-/*
- *
- *   Copyright (c) Wipro Technologies, 2002.  All Rights Reserved.
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
- *
- */
-
-/*********************************************************************
- *    TEST IDENTIFIER	: sethostname01
- *
- *    EXECUTED BY	: root / superuser
- *
- *    TEST TITLE	: Basic test for sethostname(2)
- *
- *    TEST CASE TOTAL	: 1
- *
- *    AUTHOR		: Suresh Babu V. <suresh.babu@wipro.com>
- *
- *    SIGNALS
- *	Uses SIGUSR1 to pause before test if option set.
- *	(See the parse_opts(3) man page).
- *
- *    DESCRIPTION$
- *      This is a Phase I test for the sethostname(2) system call.
- *      It is intended to provide a limited exposure of the system call.
- *
- *      Setup:
- *        Setup signal handling.
- *        Save the current hostname.
- *        Pause for SIGUSR1 if option specified.
- *
- *      Test:
- *       Loop if the proper options are given.
- *        Execute system call
- *        Check return code, if system call failed (return=-1)
- *              Log the errno and Issue a FAIL message.
- *        Otherwise, Issue a PASS message.
- *      Cleanup:
- *        Restore old host name.
- *        Print errno log and/or timing stats if options given
- *
- * Usage:  <for command-line>
- *  sethostname01 [-c n] [-i n] [-I x] [-P x] [-p] [-t] [-h]
- *	where,  -c n : Run n copies concurrently.
- *		-i n : Execute test n times.
- *		-I x : Execute test for x seconds.
- *		-p   : Pause for SIGUSR1 before starting
- *		-P x : Pause for x seconds between iterations.
- *		-t   : Turn on syscall timing.
- *		-h   : Display usage information
- *
- *
- ******************************************************************/
-
-#include <string.h>
-#include <errno.h>
-#include <linux/utsname.h>
-
-#include "test.h"
-
-#define MAX_LENGTH __NEW_UTS_LEN
-
-static void setup();
-static void cleanup();
-
-char *TCID = "sethostname01";
-int TST_TOTAL = 1;
-static char hname[MAX_LENGTH];	/* host name */
-
-int main(int ac, char **av)
-{
-	int lc;
-
-	char ltphost[] = "ltphost";	/* temporary host name to set */
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	/* Do initial setup. */
-	setup();
-
-	/* check -c option for looping. */
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-
-		/* Call sethostname(2) */
-		TEST(sethostname(ltphost, sizeof(ltphost)));
-
-		/* check return code */
-		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL, "sethostname() failed , errno=%d : %s",
-				 TEST_ERRNO, strerror(TEST_ERRNO));
-		} else {
-			tst_resm(TPASS, "sethostname() returned %ld,"
-				 " Hostname set to \"%s\"", TEST_RETURN,
-				 ltphost);
-		}
-
-	}
-
-	/* cleanup and exit */
-	cleanup();
-	tst_exit();
-
-}
-
-/*
- * setup() - performs all one time setup for this test.
- */
-void setup(void)
-{
-	int ret;
-
-	tst_require_root();
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	/* Store the existing hostname to retain it before exiting */
-	if ((ret = gethostname(hname, sizeof(hname))) < 0) {
-		tst_brkm(TBROK, NULL, "gethostname() failed while getting"
-			 " current host name");
-	}
-
-	TEST_PAUSE;
-
-}
-
-/*
- * cleanup() -	performs all one time cleanup for this test
- *		completion or premature exit.
- */
-void cleanup(void)
-{
-	int ret;
-
-	/* Set the host name back to original name */
-	if ((ret = sethostname(hname, strlen(hname))) < 0) {
-		tst_resm(TWARN, "sethostname() failed while restoring"
-			 " hostname to \"%s\": %s", hname, strerror(errno));
-	}
-
-}
diff --git a/testcases/kernel/syscalls/sethostname/sethostname02.c b/testcases/kernel/syscalls/sethostname/sethostname02.c
deleted file mode 100644
index c63e6a05c..000000000
--- a/testcases/kernel/syscalls/sethostname/sethostname02.c
+++ /dev/null
@@ -1,191 +0,0 @@
-/*
- *
- *   Copyright (c) Wipro Technologies, 2002. All Rights Reserved.
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
-/****************************************************************************
- *
- *    TEST IDENTIFIER	: sethostname02
- *
- *    EXECUTED BY	: root / superuser
- *
- *    TEST TITLE	: test for checking error conditions for sethostname(2)
- *
- *    TEST CASE TOTAL	: 3
- *
- *    AUTHOR		: Suresh Babu V. <suresh.babu@wipro.com>
- *
- *    SIGNALS
- *      Uses SIGUSR1 to pause before test if option set.
- *      (See the parse_opts(3) man page).
- *
- * DESCRIPTION
- *      Verify that,
- *   1) sethostname(2) returns -1 and sets errno to EINVAL if the parameter,
- *	len is less than zero.
- *   2) sethostname(2) returns -1 and sets errno to EINVAL if len is greater
- *	than the maximum allowed size.
- *   3) sethostname(2) returns -1 and sets errno to EFAULT if an invalid
- *	address is given for name.
- *
- * Setup:
- *   Setup signal handling.
- *   Save current hostname
- *   Pause for SIGUSR1 if option specified.
- *
- *  Test:
- *   Loop if the proper options are given.
- *   Execute system call
- *   Check return code, if system call failed and errno set == expected errno
- *		Issue sys call fails with expected return value and errno.
- *      Otherwise,
- *		Issue sys call failed to produce expected error.
- *
- *   Cleanup:
- *	Restore old hostname.
- *	Print errno log and/or timing stats if options given
- *
- *   Side Effects :
- *	sethostname() is resetting value to NULL, if an invalid address
- *	is given for name. So, to overcome this problem, hostname is
- *	resetting to original value as part of cleanup() routine.
- *
- * USAGE:  <for command-line>
- *  sethostname02 [-c n] [-e] [-i n] [-I x] [-P x] [-p] [-t] [-h]
- *     where,  -c n  : Run n copies concurrently.
- *		-e   : Turn on errno logging.
- *		-i n : Execute test n times.
- *		-I x : Execute test for x seconds.
- *		-P x : Pause for x seconds between iterations.
- *		-p   : Pause for SIGUSR1 before startingt
- *		-t   : Turn on syscall timing.
- *		-h   : Display usage information.
- *
- ***************************************************************************/
-#include <stdio.h>
-#include <string.h>
-#include <errno.h>
-#include <sys/utsname.h>
-#include "test.h"
-
-#define LARGE_LENGTH MAX_LENGTH + 1
-#define MAX_LENGTH _UTSNAME_LENGTH - 1
-
-static void cleanup(void);
-static void setup(void);
-
-char *TCID = "sethostname02";
-static char hostname[MAX_LENGTH];
-static char hname[MAX_LENGTH];
-static char largehost[LARGE_LENGTH];
-static struct test_case_t {
-	char *err_desc;		/* error description            */
-	int exp_errno;		/* Expected error no            */
-	char *exp_errval;	/* Expected error value string  */
-	char *name;		/* hostname                     */
-	int len;		/* length                       */
-} testcases[] = {
-	{
-	"Length is -ve", EINVAL, "EINVAL", hostname, -1}, {
-	"Length > max allowed size", EINVAL, "EINVAL", largehost,
-		    sizeof(largehost)}
-	,
-#ifndef UCLINUX
-	    /* Skip since uClinux does not implement memory protection */
-	{
-	"Invalid address ", EFAULT, "EFAULT", (void *)-1,
-		    sizeof(hostname)}
-#endif
-};
-
-int TST_TOTAL = ARRAY_SIZE(testcases);
-
-int main(int ac, char **av)
-{
-	int i;
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	/* Do initial setup */
-	setup();
-
-	/* check for looping state if -i option is given */
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		for (i = 0; i < TST_TOTAL; ++i) {
-
-			/*
-			 * Test the system call.
-			 */
-			TEST(sethostname(testcases[i].name, testcases[i].len));
-
-			if ((TEST_RETURN == -1) &&
-			    (TEST_ERRNO == testcases[i].exp_errno)) {
-				tst_resm(TPASS, "expected failure; Got %s",
-					 testcases[i].exp_errval);
-			} else {
-				tst_resm(TFAIL, "call failed to produce "
-					 "expected error;  errno: %d : %s",
-					 TEST_ERRNO, strerror(TEST_ERRNO));
-			}
-		}
-	}
-	/* do cleanup and exit */
-	cleanup();
-
-	tst_exit();
-}
-
-/*
- * setup() - performs all one time setup for this test.
- */
-void setup(void)
-{
-	int ret;
-
-	tst_require_root();
-
-	/* capture the signals */
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	/* Keep the host name before starting the test */
-	if ((ret = gethostname(hname, sizeof(hname))) < 0) {
-		tst_brkm(TBROK, NULL, "gethostname() failed while"
-			 " getting current host name");
-	}
-
-	/* Pause if the option was specified */
-	TEST_PAUSE;
-}
-
-/*
- * cleanup()  - performs all one time cleanup for this test
- *		completion or premature exit.
- */
-void cleanup(void)
-{
-	int ret;
-
-	/* Set the host name back to original name */
-	if ((ret = sethostname(hname, strlen(hname))) < 0) {
-		tst_resm(TWARN, "sethostname() failed while restoring"
-			 " hostname to \"%s\"", hname);
-	}
-
-}
diff --git a/testcases/kernel/syscalls/sethostname/sethostname03.c b/testcases/kernel/syscalls/sethostname/sethostname03.c
deleted file mode 100644
index b5c77adb8..000000000
--- a/testcases/kernel/syscalls/sethostname/sethostname03.c
+++ /dev/null
@@ -1,179 +0,0 @@
-/*
- *
- *   Copyright (c) Wipro Technologies, 2002.  All Rights Reserved.
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
-/****************************************************************************
- *    TEST IDENTIFIER	: sethostname03
- *
- *    EXECUTED BY	: root / superuser
- *
- *    TEST TITLE	: test for EPERM error value when sethostname(2) is
- *                        called from as non superuser
- *
- *    TEST CASE TOTAL	: 1
- *
- *    AUTHOR		: Suresh Babu V. <suresh.babu@wipro.com>
- *
- *    SIGNALS
- *      Uses SIGUSR1 to pause before test if option set.
- *      (See the parse_opts(3) man page).
- *
- *    DESCRIPTION
- *      Verify that, sethostname(2) returns -1 and sets errno to EPERM
- *      if the effective userid id of the caller is not super-user.
- *
- *  Setup:
- *   Setup signal handling.
- *   Save the current host name.
- *   Pause for SIGUSR1 if option specified.
- *
- *  Test:
- *   Loop if the proper options are given.
- *   Execute system call
- *   Check return code, if system call failed (return=-1)
- *	if errno set == expected errno
- *		Issue sys call fails with expected return value and errno.
- *	Otherwise,
- *		Issue sys call fails with unexpected errno.
- *
- *  Cleanup:
- *   Restore old hostname
- *   Print errno log and/or timing stats if options given
- *
- * Usage:  <for command-line>
- *  sethostname03 [-c n] [-e] [-i n] [-I x] [-P x] [-p] [-t]
- *	where,  -c n : Run n copies concurrently.
- *		-e   : Turn on errno logging.
- *		-i n : Execute test n times.
- *		-I x : Execute test for x seconds.
- *		-P x : Pause for x seconds between iterations.
- *		-p   : Pause for SIGUSR1 before starting
- *		-t   : Turn on syscall timing.
- *
- *************************************************************************/
-
-#include <stdio.h>
-#include <string.h>
-#include <errno.h>
-#include <pwd.h>
-#include <linux/utsname.h>
-
-#include "test.h"
-
-#define MAX_LENGTH __NEW_UTS_LEN
-
-char *TCID = "sethostname03";
-int TST_TOTAL = 1;
-
-static char ltpthost[] = "ltphost";
-static char hname[MAX_LENGTH];
-
-static char nobody_uid[] = "nobody";
-struct passwd *ltpuser;
-
-static void setup(void);
-static void cleanup(void);
-
-int main(int ac, char **av)
-{
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	/* Do initial setup */
-	setup();
-
-	/* Check for looping state if -i option is given */
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-
-		/* call sethostname() */
-		TEST(sethostname(ltpthost, sizeof(ltpthost)));
-
-		if ((TEST_RETURN == -1) && (TEST_ERRNO == EPERM)) {
-			tst_resm(TPASS, "Expected Failure; Got EPERM");
-		} else {
-			tst_resm(TFAIL, "call failed to produce "
-				 "expected error;  errno: %d : %s",
-				 TEST_ERRNO, strerror(TEST_ERRNO));
-		}
-
-	}
-
-	/* cleanup and exit */
-	cleanup();
-	tst_exit();
-
-}
-
-/*
- * setup() - performs all one time setup for this test.
- */
-void setup(void)
-{
-	int ret;
-
-	tst_require_root();
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	/* Switch to nobody user for correct error code collection */
-	if ((ltpuser = getpwnam(nobody_uid)) == NULL) {
-		tst_brkm(TBROK, NULL, "Required user \"nobody\" not"
-			 " present");
-	}
-
-	if (seteuid(ltpuser->pw_uid) == -1) {
-		tst_resm(TWARN, "seteuid failed to "
-			 "to set the effective uid to %d", ltpuser->pw_uid);
-		perror("seteuid");
-	}
-
-	/* Keep current hostname */
-	if ((ret = gethostname(hname, sizeof(hname))) < 0) {
-		tst_brkm(TBROK, NULL, "gethostname() failed while"
-			 " getting current host name");
-	}
-
-	TEST_PAUSE;
-
-}
-
-/*
- * cleanup()  - performs all one time cleanup for this test
- *		completion or premature exit.
- */
-void cleanup(void)
-{
-	int ret;
-
-	/* Set effective user id back to root/super user */
-	if (seteuid(0) == -1) {
-		tst_resm(TWARN, "seteuid failed to "
-			 "to set the effective uid to root");
-		perror("seteuid");
-	}
-
-	/* Restore host name */
-	if ((ret = sethostname(hname, strlen(hname))) < 0) {
-		tst_resm(TWARN, "sethostname() failed while restoring"
-			 " hostname to \"%s\"", hname);
-	}
-
-}
-- 
2.22.0

