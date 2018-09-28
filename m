From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Fri, 28 Sep 2018 16:52:15 +0800
Subject: [LTP] [PATCH 1/2] module: Remove obsolete create_module(2) and
	query_module(2)
Message-ID: <1538124736-1183-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From manpage, create_module(2) or query_module(2) is only present
on Linux up until 2.4 and is removed in Linux 2.6, so we remove
these obsolete syscalls.

Fix: #380

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 include/lapi/syscalls/i386.in                      |   2 -
 include/lapi/syscalls/powerpc.in                   |   2 -
 include/lapi/syscalls/powerpc64.in                 |   2 -
 include/lapi/syscalls/s390.in                      |   2 -
 include/lapi/syscalls/s390x.in                     |   2 -
 include/lapi/syscalls/sh.in                        |   2 -
 include/lapi/syscalls/sparc.in                     |   2 -
 include/lapi/syscalls/sparc64.in                   |   2 -
 include/lapi/syscalls/x86_64.in                    |   2 -
 testcases/kernel/module/README                     |   3 -
 testcases/kernel/module/create_module/Makefile     |  36 --
 .../kernel/module/create_module/create_module01.c  | 162 ---------
 .../kernel/module/create_module/create_module02.c  | 279 ---------------
 testcases/kernel/module/query_module/Makefile      |  49 ---
 .../kernel/module/query_module/dummy_query_mod.c   |  53 ---
 .../module/query_module/dummy_query_mod_dep.c      |  52 ---
 .../kernel/module/query_module/query_module01.c    | 373 ---------------------
 .../kernel/module/query_module/query_module02.c    | 205 -----------
 .../kernel/module/query_module/query_module03.c    | 272 ---------------
 19 files changed, 1502 deletions(-)
 delete mode 100644 testcases/kernel/module/README
 delete mode 100644 testcases/kernel/module/create_module/Makefile
 delete mode 100644 testcases/kernel/module/create_module/create_module01.c
 delete mode 100644 testcases/kernel/module/create_module/create_module02.c
 delete mode 100644 testcases/kernel/module/query_module/Makefile
 delete mode 100644 testcases/kernel/module/query_module/dummy_query_mod.c
 delete mode 100644 testcases/kernel/module/query_module/dummy_query_mod_dep.c
 delete mode 100644 testcases/kernel/module/query_module/query_module01.c
 delete mode 100644 testcases/kernel/module/query_module/query_module02.c
 delete mode 100644 testcases/kernel/module/query_module/query_module03.c

diff --git a/include/lapi/syscalls/i386.in b/include/lapi/syscalls/i386.in
index a000564..5d7bc11 100644
--- a/include/lapi/syscalls/i386.in
+++ b/include/lapi/syscalls/i386.in
@@ -125,7 +125,6 @@ modify_ldt 123
 adjtimex 124
 mprotect 125
 sigprocmask 126
-create_module 127
 init_module 128
 delete_module 129
 get_kernel_syms 130
@@ -163,7 +162,6 @@ mremap 163
 setresuid 164
 getresuid 165
 vm86 166
-query_module 167
 poll 168
 nfsservctl 169
 setresgid 170
diff --git a/include/lapi/syscalls/powerpc.in b/include/lapi/syscalls/powerpc.in
index c0b4226..79d8f58 100644
--- a/include/lapi/syscalls/powerpc.in
+++ b/include/lapi/syscalls/powerpc.in
@@ -125,7 +125,6 @@ modify_ldt 123
 adjtimex 124
 mprotect 125
 sigprocmask 126
-create_module 127
 init_module 128
 delete_module 129
 get_kernel_syms 130
@@ -162,7 +161,6 @@ nanosleep 162
 mremap 163
 setresuid 164
 getresuid 165
-query_module 166
 poll 167
 nfsservctl 168
 setresgid 169
diff --git a/include/lapi/syscalls/powerpc64.in b/include/lapi/syscalls/powerpc64.in
index c0b4226..79d8f58 100644
--- a/include/lapi/syscalls/powerpc64.in
+++ b/include/lapi/syscalls/powerpc64.in
@@ -125,7 +125,6 @@ modify_ldt 123
 adjtimex 124
 mprotect 125
 sigprocmask 126
-create_module 127
 init_module 128
 delete_module 129
 get_kernel_syms 130
@@ -162,7 +161,6 @@ nanosleep 162
 mremap 163
 setresuid 164
 getresuid 165
-query_module 166
 poll 167
 nfsservctl 168
 setresgid 169
diff --git a/include/lapi/syscalls/s390.in b/include/lapi/syscalls/s390.in
index 47a04de..203cbe6 100644
--- a/include/lapi/syscalls/s390.in
+++ b/include/lapi/syscalls/s390.in
@@ -89,7 +89,6 @@ uname 122
 adjtimex 124
 mprotect 125
 sigprocmask 126
-create_module 127
 init_module 128
 delete_module 129
 get_kernel_syms 130
@@ -122,7 +121,6 @@ sched_get_priority_min 160
 sched_rr_get_interval 161
 nanosleep 162
 mremap 163
-query_module 167
 poll 168
 nfsservctl 169
 prctl 172
diff --git a/include/lapi/syscalls/s390x.in b/include/lapi/syscalls/s390x.in
index 83732ff..914d94f 100644
--- a/include/lapi/syscalls/s390x.in
+++ b/include/lapi/syscalls/s390x.in
@@ -89,7 +89,6 @@ uname 122
 adjtimex 124
 mprotect 125
 sigprocmask 126
-create_module 127
 init_module 128
 delete_module 129
 get_kernel_syms 130
@@ -122,7 +121,6 @@ sched_get_priority_min 160
 sched_rr_get_interval 161
 nanosleep 162
 mremap 163
-query_module 167
 poll 168
 nfsservctl 169
 prctl 172
diff --git a/include/lapi/syscalls/sh.in b/include/lapi/syscalls/sh.in
index 407be7a..e1de98c 100644
--- a/include/lapi/syscalls/sh.in
+++ b/include/lapi/syscalls/sh.in
@@ -125,7 +125,6 @@ cacheflush 123
 adjtimex 124
 mprotect 125
 sigprocmask 126
-create_module 127
 init_module 128
 delete_module 129
 get_kernel_syms 130
@@ -163,7 +162,6 @@ mremap 163
 setresuid 164
 getresuid 165
 vm86 166
-query_module 167
 poll 168
 nfsservctl 169
 setresgid 170
diff --git a/include/lapi/syscalls/sparc.in b/include/lapi/syscalls/sparc.in
index 2b06a79..06533d6 100644
--- a/include/lapi/syscalls/sparc.in
+++ b/include/lapi/syscalls/sparc.in
@@ -186,7 +186,6 @@ flistxattr 180
 removexattr 181
 lremovexattr 182
 sigpending 183
-query_module 184
 setpgid 185
 fremovexattr 186
 tkill 187
@@ -223,7 +222,6 @@ clone 217
 ioprio_get 218
 adjtimex 219
 sigprocmask 220
-create_module 221
 delete_module 222
 get_kernel_syms 223
 getpgid 224
diff --git a/include/lapi/syscalls/sparc64.in b/include/lapi/syscalls/sparc64.in
index 8c8a866..ce66c05 100644
--- a/include/lapi/syscalls/sparc64.in
+++ b/include/lapi/syscalls/sparc64.in
@@ -164,7 +164,6 @@ flistxattr 180
 removexattr 181
 lremovexattr 182
 sigpending 183
-query_module 184
 setpgid 185
 fremovexattr 186
 tkill 187
@@ -201,7 +200,6 @@ clone 217
 ioprio_get 218
 adjtimex 219
 sigprocmask 220
-create_module 221
 delete_module 222
 get_kernel_syms 223
 getpgid 224
diff --git a/include/lapi/syscalls/x86_64.in b/include/lapi/syscalls/x86_64.in
index 4ce8477..1726f84 100644
--- a/include/lapi/syscalls/x86_64.in
+++ b/include/lapi/syscalls/x86_64.in
@@ -172,11 +172,9 @@ sethostname 170
 setdomainname 171
 iopl 172
 ioperm 173
-create_module 174
 init_module 175
 delete_module 176
 get_kernel_syms 177
-query_module 178
 quotactl 179
 nfsservctl 180
 getpmsg 181
diff --git a/testcases/kernel/module/README b/testcases/kernel/module/README
deleted file mode 100644
index 95938a0..0000000
--- a/testcases/kernel/module/README
+++ /dev/null
@@ -1,3 +0,0 @@
-Many of these tests have requirements on the test machine.  To ensure proper
-build and execution, the kernel must be build on the test machine and you
-must also do a 'make modules' and 'make modules_install'.
diff --git a/testcases/kernel/module/create_module/Makefile b/testcases/kernel/module/create_module/Makefile
deleted file mode 100644
index af2c873..0000000
--- a/testcases/kernel/module/create_module/Makefile
+++ /dev/null
@@ -1,36 +0,0 @@
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
-#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#
-
-###########################################################################
-# name of file	: Makefile						  #
-###########################################################################
-CFLAGS+=	-Wall -O -g -I../../../../include
-LOADLIBES+=	-L../../../../lib -lltp
-
-SRCS=$(wildcard *.c)
-TARGETS=$(patsubst %.c,%,$(SRCS))
-
-all: $(TARGETS)
-
-install:
-	@set -e; for i in $(TARGETS); do ln -f $$i ../../../bin/$$i ; done
-
-clean:
-	rm -f $(TARGETS)
-
-
diff --git a/testcases/kernel/module/create_module/create_module01.c b/testcases/kernel/module/create_module/create_module01.c
deleted file mode 100644
index 2c72297..0000000
--- a/testcases/kernel/module/create_module/create_module01.c
+++ /dev/null
@@ -1,162 +0,0 @@
-/*
- * Copyright (c) Wipro Technologies Ltd, 2002.  All Rights Reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
- */
-/**********************************************************
- *
- *    TEST IDENTIFIER   : create_module01
- *
- *    EXECUTED BY       : root / superuser
- *
- *    TEST TITLE        : Basic tests for create_module(2)
- *
- *    TEST CASE TOTAL   : 1
- *
- *    AUTHOR            : Madhu T L <madhu.tarikere@wipro.com>
- *
- *    SIGNALS
- *	Uses SIGUSR1 to pause before test if option set.
- *	(See the parse_opts(3) man page).
- *
- *    DESCRIPTION
- *	This is a Phase I test for the create_module(2) system call.
- *	It is intended to provide a limited exposure of the system call.
- *
- *	Setup:
- *	  Setup signal handling.
- *	  Test caller is superuser
- *	  Pause for SIGUSR1 if option specified.
- *	  Initialize modname for each child process
- *
- *	Test:
- *	 Loop if the proper options are given.
- *	  Execute system call
- *	  Check return code, if system call failed (return=-1)
- *		Issue FAIL message with errno.
- *	  Otherwise, Issue PASS message and delete the module entry.
- *
- *	Cleanup:
- *	  Call delete_module system call to remove module entry if exists.
- *	  Print errno log and/or timing stats if options given
- *
- * USAGE:  <for command-line>
- *  create_module01 [-c n] [-e] [-f] [-h] [-i n] [-I x] [-p] [-P x] [-t]
- *		where,  -c n : Run n copies concurrently.
- *			-e   : Turn on errno logging.
- *			-f   : Turn off functional testing
- *			-h   : Show help screen
- *			-i n : Execute test n times.
- *			-I x : Execute test for x seconds.
- *			-p   : Pause for SIGUSR1 before starting
- *			-P x : Pause for x seconds between iterations.
- *			-t   : Turn on syscall timing.
- *
- ****************************************************************/
-#include <errno.h>
-#include <asm/atomic.h>
-#include <linux/module.h>
-#include "test.h"
-
-#define MODSIZE 10000		/* Arbitrarily selected MODSIZE */
-#define BASEMODNAME "dummy"
-
-static void setup(void);
-static void cleanup(void);
-
-char *TCID = "create_module01";	/* Test program identifier.    */
-int TST_TOTAL = 1;		/* Total number of test cases. */
-static char modname[20];	/* Name of the module */
-
-int main(int argc, char **argv)
-{
-	int lc;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		/* reset tst_count in case we are looping */
-		tst_count = 0;
-
-		/* Test the system call */
-		TEST(create_module(modname, MODSIZE));
-
-		/* check return code */
-		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL, "create_module() failed errno=%d : %s",
-				 TEST_ERRNO, strerror(TEST_ERRNO));
-		} else {
-			tst_resm(TPASS, "create_module() returned 0x%x",
-				 TEST_RETURN);
-			if (delete_module(modname) != 0) {
-				tst_brkm(TBROK, NULL, "Failed to delete"
-					 "loadable module entry for %s",
-					 modname);
-			}
-		}
-	}
-
-	/* perform global cleanup and exit */
-	cleanup();
-
-}
-
-/* setup() - performs all ONE TIME setup for this test */
-void setup(void)
-{
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	tst_require_root();
-
-	if (tst_kvercmp(2, 5, 48) >= 0)
-		tst_brkm(TCONF, NULL, "This test will not work on "
-			 "kernels after 2.5.48");
-
-	/* Pause if that option was specified
-	 * TEST_PAUSE contains the code to fork the test with the -c option.
-	 */
-	TEST_PAUSE;
-
-	/* Initialize unique module name for each child process */
-	if (sprintf(modname, "%s_%d", BASEMODNAME, getpid()) == -1) {
-		tst_brkm(TBROK, NULL, "Failed to initialize module name");
-	}
-}
-
-/*
- * cleanup()
- *	performs all ONE TIME cleanup for this test at
- *	completion or premature exit
- */
-void cleanup(void)
-{
-	/*
-	 * If module entry is not removed (possible if create_module()
-	 * succeeds and signal is caught before execution of delete_module())
-	 * attempt to remove it here
-	 */
-	if (delete_module(modname) == -1) {
-		/* With errno, check module exists, if so send msg */
-		if (errno != ENOENT) {
-			tst_resm(TWARN, "Failed to delete loadable module"
-				 "entry for %s errno returned %d", modname,
-				 errno);
-		}
-	}
-
-}
diff --git a/testcases/kernel/module/create_module/create_module02.c b/testcases/kernel/module/create_module/create_module02.c
deleted file mode 100644
index f275adf..0000000
--- a/testcases/kernel/module/create_module/create_module02.c
+++ /dev/null
@@ -1,279 +0,0 @@
-/*
- * Copyright (c) Wipro Technologies Ltd, 2002.  All Rights Reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
- */
-/**********************************************************
- *
- *    TEST IDENTIFIER   : create_module02
- *
- *    EXECUTED BY       : root / superuser
- *
- *    TEST TITLE        : Checking error conditions for create_module(2)
- *
- *    TEST CASE TOTAL   : 8
- *
- *    AUTHOR            : Madhu T L <madhu.tarikere@wipro.com>
- *
- *    SIGNALS
- *      Uses SIGUSR1 to pause before test if option set.
- *      (See the parse_opts(3) man page).
- *
- *    DESCRIPTION
- *      Verify that,
- *      1. create_module(2) returns -1 and sets errno to EPERM, if effective
- *         user id of the caller is not superuser.
- *      2. create_module(2) returns -1 and sets errno to EFAULT, if module
- *         name is outside the  program's  accessible  address space.
- *      3. create_module(2) returns -1 and sets errno to EFAULT, if module
- *         name parameter is NULL.
- *      4. create_module(2) returns -1 and sets errno to EINVAL, if module
- *         name parameter is null terminated (zero length) string.
- *      5. create_module(2) returns -1 and sets errno to EEXIST, if module
- *         entry with the same name already exists.
- *      6. create_module(2) returns -1 and sets errno to EINVAL, if module
- *         size parameter is too small.
- *      7. create_module(2) returns -1 and sets errno to ENAMETOOLONG, if
- *         module name parameter is too long.
- *      8. create_module(2) returns -1 and sets errno to ENOMEM, if module
- *         size parameter is too large.
- *
- *      Setup:
- *        Setup signal handling.
- *        Test caller is super user
- *        Check existances of "nobody" user id.
- *        Initialize  long module name
- *        Set expected errnos for logging
- *        Pause for SIGUSR1 if option specified.
- *	  Initialize modname for each child process
- *
- *      Test:
- *       Loop if the proper options are given.
- *        Execute system call
- *        Check return code and error number, if matching,
- *                   Issue PASS message
- *        Otherwise,
- *                   Issue FAIL message
- *
- *      Cleanup:
- *        Print errno log and/or timing stats if options given
- *
- * USAGE:  <for command-line>
- *  create_module02 [-c n] [-e] [-f] [-h] [-i n] [-I x] [-p] [-P x] [-t]
- *		where,  -c n : Run n copies concurrently.
- *			-e   : Turn on errno logging.
- *			-f   : Turn off functional testing
- *			-h   : Show help screen
- *			-i n : Execute test n times.
- *			-I x : Execute test for x seconds.
- *			-p   : Pause for SIGUSR1 before starting
- *			-P x : Pause for x seconds between iterations.
- *			-t   : Turn on syscall timing.
- *
- ****************************************************************/
-
-#include <errno.h>
-#include <pwd.h>
-#include <sys/types.h>
-#include <unistd.h>
-#include <limits.h>
-#include <asm/atomic.h>
-#include <linux/module.h>
-#include "test.h"
-#include "safe_macros.h"
-
-#ifndef PAGE_SIZE
-#define PAGE_SIZE sysconf(_SC_PAGE_SIZE)
-#endif
-
-#define MODSIZE 10000		/* Arbitrarily selected MODSIZE */
-#define NULLMODNAME ""
-#define MAXMODSIZE  0xffffffffffffffff	/* Max size of size_t */
-#define SMALLMODSIZE  1		/* Arbitrarily selected SMALLMODSIZE */
-#define BASEMODNAME "dummy"
-#define LONGMODNAMECHAR 'm'	/* Arbitrarily selected the alphabet */
-#define MODNAMEMAX (PAGE_SIZE + 1)
-
-struct test_case_t {		/* test case structure */
-	char *modname;
-	size_t size;
-	caddr_t retval;		/* syscall return value */
-	int experrno;		/* expected errno */
-	char *desc;
-	int (*setup) (void);	/* Individual setup routine */
-	void (*cleanup) (void);	/* Individual cleanup routine */
-};
-
-char *TCID = "create_module02";
-static char nobody_uid[] = "nobody";
-struct passwd *ltpuser;
-static char longmodname[MODNAMEMAX];
-static int testno;
-static char modname[20];	/* Name of the module */
-
-static void setup(void);
-static void cleanup(void);
-static int setup1(void);
-static void cleanup1(void);
-static int setup2(void);
-static void cleanup2(void);
-
-static struct test_case_t tdat[] = {
-	{modname, MODSIZE, (caddr_t) - 1, EPERM,
-	 "non-superuser", setup1, cleanup1},
-	{(char *)-1, MODSIZE, (caddr_t) - 1, EFAULT,
-	 "module name outside the  program's  accessible  address space", NULL,
-	 NULL},
-	{NULL, MODSIZE, (caddr_t) - 1, EFAULT,
-	 "NULL module name", NULL, NULL},
-	{NULLMODNAME, MODSIZE, (caddr_t) - 1, EINVAL,
-	 "null terminated module name", NULL, NULL},
-	{modname, MODSIZE, (caddr_t) - 1, EEXIST,
-	 "already existing module", setup2, cleanup2},
-	{modname, SMALLMODSIZE, (caddr_t) - 1, EINVAL,
-	 "insufficient module size", NULL, NULL},
-	{longmodname, MODSIZE, (caddr_t) - 1, ENAMETOOLONG,
-	 "long module name", NULL, NULL},
-
-	/*
-	 *This test case is giving segmentation fault on
-	 * 2.4.* series, but works as expected with 2.5.* series of kernel.
-	 */
-	{modname, MAXMODSIZE, (caddr_t) - 1, ENOMEM,
-	 "large module size", NULL, NULL},
-};
-
-int TST_TOTAL = sizeof(tdat) / sizeof(tdat[0]);
-
-int main(int argc, char **argv)
-{
-	int lc;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset tst_count in case we are looping */
-		tst_count = 0;
-
-		for (testno = 0; testno < TST_TOTAL; ++testno) {
-			if ((tdat[testno].setup) && (tdat[testno].setup())) {
-				/* setup() failed, skip this test */
-				continue;
-			}
-
-			TEST(create_module(tdat[testno].modname,
-					   tdat[testno].size));
-			if ((TEST_RETURN == (int)tdat[testno].retval) &&
-			    (TEST_ERRNO == tdat[testno].experrno)) {
-				tst_resm(TPASS, "Expected results for %s, "
-					 "errno: %d",
-					 tdat[testno].desc, TEST_ERRNO);
-			} else {
-				tst_resm(TFAIL, "Unexpected results for %s ; "
-					 "returned %d (expected %d), errno %d "
-					 "(expected %d)", tdat[testno].desc,
-					 TEST_RETURN, tdat[testno].retval,
-					 TEST_ERRNO, tdat[testno].experrno);
-			}
-			if (tdat[testno].cleanup) {
-				tdat[testno].cleanup();
-			}
-		}
-	}
-	cleanup();
-	tst_exit();
-}
-
-int setup1(void)
-{
-	/* Change effective user id to nodody */
-	if (seteuid(ltpuser->pw_uid) == -1) {
-		tst_resm(TBROK, "seteuid failed to set the effective"
-			 " uid to %d", ltpuser->pw_uid);
-		return 1;
-	}
-	return 0;
-}
-
-void cleanup1(void)
-{
-	/* Change effective user id to root */
-	SAFE_SETEUID(NULL, 0);
-}
-
-int setup2(void)
-{
-	/* Create a loadable module entry */
-	if (create_module(modname, MODSIZE) == -1) {
-		tst_resm(TBROK, "Failed to create module entry"
-			 " for %s", modname);
-		return 1;
-	}
-	return 0;
-}
-
-void cleanup2(void)
-{
-	/* Remove loadable module entry */
-	if (delete_module(modname) == -1) {
-		tst_brkm(TBROK, NULL, "Failed to delete module entry"
-			 " for %s", modname);
-	}
-}
-
-/*
- * setup()
- *	performs all ONE TIME setup for this test
- */
-void setup(void)
-{
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	tst_require_root();
-
-	if (tst_kvercmp(2, 5, 48) >= 0)
-		tst_brkm(TCONF, NULL, "This test will not work on "
-			 "kernels after 2.5.48");
-
-	/* Check for nobody_uid user id */
-	if ((ltpuser = getpwnam(nobody_uid)) == NULL) {
-		tst_brkm(TBROK, NULL, "Required user %s doesn't exists",
-			 nobody_uid);
-	}
-
-	/* Initialize longmodname to LONGMODNAMECHAR character */
-	memset(longmodname, LONGMODNAMECHAR, MODNAMEMAX - 1);
-
-	/* Pause if that option was specified
-	 * TEST_PAUSE contains the code to fork the test with the -c option.
-	 */
-	TEST_PAUSE;
-
-	/* Get unique module name for each child process */
-	if (sprintf(modname, "%s_%d", BASEMODNAME, getpid()) == -1) {
-		tst_brkm(TBROK, NULL, "Failed to initialize module name");
-	}
-}
-
-/*
- * cleanup()
- *	performs all ONE TIME cleanup for this test at
- *	completion or premature exit
- */
-void cleanup(void)
-{
-}
diff --git a/testcases/kernel/module/query_module/Makefile b/testcases/kernel/module/query_module/Makefile
deleted file mode 100644
index 88323b4..0000000
--- a/testcases/kernel/module/query_module/Makefile
+++ /dev/null
@@ -1,49 +0,0 @@
-#
-# Copyright (c) Wipro Technologies Ltd, 2002.  All Rights Reserved.
-#
-# This program is free software; you can redistribute it and/or modify it
-# under the terms of version 2 of the GNU General Public License as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it would be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
-###########################################################################
-# name of file	: Makefile						  #
-# description	: make file for the query_module(2) testcases		  #
-###########################################################################
-
-CFLAGS+=	-I../../../../include -Wall
-MODCFLAGS+=	-I/lib/modules/$(shell uname -r)/build/include -Wall
-LOADLIBES+=	-L../../../../lib -lltp
-
-SRC1=dummy_query_mod.c dummy_query_mod_dep.c
-OBJS=$(SRC1:.c=.o)
-TARGETS=query_module01 query_module02 query_module03 $(OBJS)
-
-all: $(TARGETS)
-	chmod 755 $(OBJS)
-
-$(OBJS): $(SRC1)
-	$(CC) -DEXPORT_SYMTAB $(MODCFLAGS) -c $(SRC1) -Wall
-
-query_module01: query_module01.c
-	$(CC) $(CFLAGS) query_module01.c $(LOADLIBES) -o $@
-
-query_module02: query_module02.c
-	$(CC) $(CFLAGS) query_module02.c $(LOADLIBES) -o $@
-
-query_module03: query_module03.c
-	$(CC) $(CFLAGS) query_module03.c $(LOADLIBES) -o $@
-
-install:
-	@set -e; for i in $(TARGETS); do ln -f $$i ../../../bin/$$i ; done
-
-clean:
-	rm -f $(TARGETS)
-
diff --git a/testcases/kernel/module/query_module/dummy_query_mod.c b/testcases/kernel/module/query_module/dummy_query_mod.c
deleted file mode 100644
index 27f7408..0000000
--- a/testcases/kernel/module/query_module/dummy_query_mod.c
+++ /dev/null
@@ -1,53 +0,0 @@
-/*
- * Copyright (c) Wipro Technologies Ltd, 2002.  All Rights Reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
- */
-/*************************************************************************
- * Description: This is a kernel loadable module programme used by
- *		testcases of query_module(2)
- *************************************************************************/
-
-#define MODULE
-/* #define __KERNEL__    Commented this line out b/c it causes errors with
- *                       module.h when it calls /usr/include/linux/version.h
- *                       -12/03/02 Robbie Williamson <robbiew@us.ibm.com>
- */
-
-#include <asm/atomic.h>
-#include <linux/config.h>
-#include <linux/module.h>
-#include <linux/kernel.h>
-
-void dummy_func_test(void);
-
-/* Initialization routine of module */
-int init_module(void)
-{
-	return 0;
-}
-
-/* Cleanup routine of module */
-void cleanup_module(void)
-{
-	return;
-}
-
-/* Dummy function used by dependent module */
-void dummy_func_test(void)
-{
-	return;
-}
-
-EXPORT_SYMBOL(dummy_func_test);
diff --git a/testcases/kernel/module/query_module/dummy_query_mod_dep.c b/testcases/kernel/module/query_module/dummy_query_mod_dep.c
deleted file mode 100644
index 31c0293..0000000
--- a/testcases/kernel/module/query_module/dummy_query_mod_dep.c
+++ /dev/null
@@ -1,52 +0,0 @@
-/*
- * Copyright (c) Wipro Technologies Ltd, 2002.  All Rights Reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
- */
-/*************************************************************************
- * Description: This is a kernel loadable module programme used by
- *		testcases of query_module(2). This module has dependency
- *		on dummy_query_mod module (calls function of dummy_del_mod
- *		during initialization).
- *************************************************************************/
-
-#define MODULE
-/* #define __KERNEL__    Commented this line out b/c it causes errors with
- *                       module.h when it calls /usr/include/linux/version.h
- *                       -12/03/02 Robbie Williamson <robbiew@us.ibm.com>
- */
-
-#include <linux/config.h>
-#include <asm/atomic.h>
-#include <linux/module.h>
-#include <linux/kernel.h>
-
-extern void dummy_func_test(void);
-
-/* Initialization routine of module */
-int init_module(void)
-{
-	/*
-	 * Call function of other module, does nothing, used to create
-	 * dependency with other module
-	 */
-	dummy_func_test();
-	return 0;
-}
-
-/* Cleanup routine of module */
-void cleanup_module(void)
-{
-	return;
-}
diff --git a/testcases/kernel/module/query_module/query_module01.c b/testcases/kernel/module/query_module/query_module01.c
deleted file mode 100644
index 29f61a8..0000000
--- a/testcases/kernel/module/query_module/query_module01.c
+++ /dev/null
@@ -1,373 +0,0 @@
-/*
- * Copyright (c) Wipro Technologies Ltd, 2002.  All Rights Reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
- */
-/**********************************************************
- *
- *    TEST IDENTIFIER   : query_module01
- *
- *    EXECUTED BY       : root / superuser
- *
- *    TEST TITLE        : Checking functionality of query_module(2)
- *
- *    TEST CASE TOTAL   : 6
- *
- *    AUTHOR            : Madhu T L <madhu.tarikere@wipro.com>
- *
- *    SIGNALS
- *      Uses SIGUSR1 to pause before test if option set.
- *      (See the parse_opts(3) man page).
- *
- *    DESCRIPTION
- *      Verify that,
- *	1. query_module(2) is successful for NULL module name, which argument
- *	   set to 0.
- *	2. query_module(2) is successful for NULL module name, which argument
- *	   set to QM_MODULES.
- *	3. query_module(2) is successful for valid module name, which argument
- *	   set to QM_DEPS.
- *	4. query_module(2) is successful for valid module name, which argument
- *	   set to QM_REFS.
- *	5. query_module(2) is successful for valid module name, which argument
- *	   set to QM_INFO.
- *	6. query_module(2) is successful for valid module name, which argument
- *	   set to QM_SYMBOLS.
- *
- *      Setup:
- *	  Setup signal handling.
- *	  Test caller is superuser
- *	  Initialize  long module name
- *	  Pause for SIGUSR1 if option specified.
- *
- *	Test:
- *	 Loop if the proper options are given.
- *	  Execute system call
- *	  Check return value and functionality, if success,
- *		 Issue PASS message
- *	Otherwise,
- *		Issue FAIL message
- *
- *	Cleanup:
- *	  Print errno log and/or timing stats if options given
- *
- * USAGE:  <for command-line>
- *  query_module01 [-c n] [-e] [-f] [-h] [-i n] [-I x] [-p] [-P x] [-t]
- *		where,  -c n : Run n copies concurrently.
- *			-e   : Turn on errno logging.
- *			-f   : Turn off functional testing
- *			-h   : Show help screen
- *			-i n : Execute test n times.
- *			-I x : Execute test for x seconds.
- *			-p   : Pause for SIGUSR1 before starting
- *			-P x : Pause for x seconds between iterations.
- *			-t   : Turn on syscall timing.
- *
- * RESTRICTIONS
- *	-c option has no effect for this testcase, even if used allows only
- *	one instance to run at a time.
- *
- * CHANGES
- *
- * 12/03/02 Added "force" to insmod to ignore kernel version.
- *          -Robbie Williamson <robbiew@us.ibm.com>
- *
- ****************************************************************/
-
-#include <errno.h>
-#include <pwd.h>
-#include <sys/types.h>
-#include <unistd.h>
-#include <limits.h>
-#include <asm/atomic.h>
-#include <linux/module.h>
-#include "test.h"
-
-#ifndef PAGE_SIZE
-#define PAGE_SIZE sysconf(_SC_PAGE_SIZE)
-#endif
-
-#define LONGMODNAMECHAR	'm'	/* Arbitrarily selected */
-#define MODNAMEMAX	(PAGE_SIZE + 1)
-#define EXP_RET_VAL	0
-#define DUMMY_MOD	"dummy_query_mod"
-#define DUMMY_MOD_DEP	"dummy_query_mod_dep"
-#define QM_INVALID	(QM_INFO + 100)
-
-/* Name of exported function in DUMMY_MOD */
-#define EXP_FUNC_NAME	"dummy_func_test"
-
-struct test_case_t {		/* test case structure */
-	char *modname;
-	int which;
-	char *desc;
-	int (*setup) (void);	/* Individual setup routine */
-	void (*cleanup) (void);	/* Individual cleanup routine */
-};
-
-char *TCID = "query_module01";
-static char longmodname[MODNAMEMAX];
-static int testno;
-static char out_buf[PAGE_SIZE];
-static size_t ret;
-
-static int test_functionality(int, char *, size_t, size_t);
-static void setup(void);
-static void cleanup(void);
-static int setup1(void);
-static void cleanup1(void);
-static int setup2(void);
-static void cleanup2(void);
-
-static struct test_case_t tdat[] = {
-	{NULL, 0, "module name: NULL, which: 0", NULL, NULL},
-
-	{NULL, QM_MODULES, "NULL module name, which: QM_MODULES",
-	 setup1, cleanup1},
-
-	{DUMMY_MOD_DEP, QM_DEPS, "valid module name, which: QM_DEPS",
-	 setup2, cleanup2},
-
-	{DUMMY_MOD, QM_REFS, "valid module name, which: QM_REFS",
-	 setup2, cleanup2},
-
-	{DUMMY_MOD, QM_INFO, "valid module name, which: QM_INFO",
-	 setup1, cleanup1},
-
-	{DUMMY_MOD, QM_SYMBOLS, "valid module name, which: QM_SYMBOLS",
-	 setup1, cleanup1},
-};
-
-int TST_TOTAL = sizeof(tdat) / sizeof(tdat[0]);
-
-int main(int argc, char **argv)
-{
-	int lc;
-	size_t buflen = sizeof(out_buf);
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	tst_tmpdir();
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset tst_count in case we are looping */
-		tst_count = 0;
-
-		for (testno = 0; testno < TST_TOTAL; ++testno) {
-			if ((tdat[testno].setup) && (tdat[testno].setup())) {
-				/* setup() failed, skip this test */
-				continue;
-			}
-
-			TEST(query_module(tdat[testno].modname,
-					  tdat[testno].which, (void *)out_buf,
-					  buflen, &ret));
-
-			if ((TEST_RETURN == EXP_RET_VAL) &&
-			    !test_functionality(tdat[testno].which,
-						out_buf, buflen, ret)) {
-				tst_resm(TPASS, "query_module() successful "
-					 "for %s", tdat[testno].desc);
-			} else {
-				tst_resm(TFAIL, "query_module() failed for "
-					 "%s ; returned"
-					 " %d (expected %d), errno %d (expected"
-					 " 0)", tdat[testno].desc,
-					 TEST_RETURN, EXP_RET_VAL, TEST_ERRNO);
-			}
-			if (tdat[testno].cleanup) {
-				tdat[testno].cleanup();
-			}
-		}
-	}
-	cleanup();
-	tst_exit();
-}
-
-int test_functionality(int which, char *buf, size_t bufsize, size_t ret)
-{
-	int i = 0;
-	char *modname;
-	unsigned long *vals;
-
-	switch (which) {
-	case 0:
-		/* Always return SUCCESS */
-		return 0;
-
-	case QM_MODULES:
-	case QM_DEPS:
-		/* Return SUCCESS if found DUMMY_MOD entry */
-		modname = DUMMY_MOD;
-		break;
-
-	case QM_REFS:
-		/* Return SUCCESS if found DUMMY_MOD_DEP entry */
-		modname = DUMMY_MOD_DEP;
-		break;
-
-	case QM_INFO:
-		/*
-		 * Since module is already loaded, flags should show
-		 * MOD_RUNNING
-		 */
-		if (((struct module_info *)buf)->flags & MOD_RUNNING) {
-			return 0;
-		}
-		return 1;
-
-	case QM_SYMBOLS:
-		vals = (unsigned long *)buf;
-
-		/*
-		 * Find entry for atleast one symbol, checking for
-		 * EXP_FUNC_NAME symbol, if found return SUCCESS.
-		 */
-		for (i = 0; i < ret; i++, vals += 2) {
-
-			/* buf + vals[1] - address of symbol name */
-			if (!strcmp(buf + vals[1], EXP_FUNC_NAME)) {
-				return 0;
-			}
-		}
-		return 1;
-
-	default:
-		/* Unknown which type */
-		return 1;
-	}
-
-	/* Return SUCCESS if found entry */
-	for (i = 0; i != ret; i++) {
-		if (strcmp(buf, modname)) {
-			buf += strlen(buf) + 1;
-		} else {
-			return 0;
-		}
-	}
-	return 1;
-
-}
-
-/* Insert a module of name mod */
-int insert_mod(char *mod)
-{
-	char cmd[80];
-
-	if (sprintf(cmd, "cp `which %s.o` ./", mod) == -1) {
-		tst_resm(TBROK, "sprintf failed");
-		return 1;
-	}
-	if (system(cmd) != 0) {
-		tst_resm(TBROK, "Failed to copy %s module", mod);
-		return 1;
-	}
-
-	/* Should use force to ignore kernel version & insure loading  */
-	/* -RW                                                         */
-	/* if (sprintf(cmd, "insmod %s.o", mod) == -1) {               */
-	if (sprintf(cmd, "insmod --force -q %s.o >/dev/null 2>&1", mod) == -1) {
-		tst_resm(TBROK, "sprintf failed");
-		return 1;
-	}
-	if (system(cmd) != 0) {
-		tst_resm(TBROK, "Failed to load %s module", mod);
-		return 1;
-	}
-	return 0;
-}
-
-int setup1(void)
-{
-	if (insert_mod(DUMMY_MOD)) {
-		/* Failed */
-		return 1;
-	} else {
-		return 0;
-	}
-}
-
-int setup2(void)
-{
-	if (insert_mod(DUMMY_MOD)) {
-		/* Failed */
-		return 1;
-	}
-	if (insert_mod(DUMMY_MOD_DEP)) {
-		/* Falied to load DUMMY_MOD_DEP, unload DUMMY_MOD */
-		cleanup1();
-		return 1;
-	}
-	return 0;
-}
-
-void cleanup1(void)
-{
-	/* Remove the loadable module - DUMMY_MOD */
-	if (system("rmmod " DUMMY_MOD) != 0) {
-		tst_brkm(TBROK, cleanup, "Failed to unload module %s",
-			 DUMMY_MOD);
-	}
-}
-
-void cleanup2(void)
-{
-	/* Remove the loadable module - DUMMY_MOD_DEP */
-	if (system("rmmod " DUMMY_MOD_DEP) != 0) {
-		tst_brkm(TBROK, cleanup, "Failed to unload module %s",
-			 DUMMY_MOD_DEP);
-	}
-	/* Remove the loadable module - DUMMY_MOD */
-	cleanup1();
-}
-
-/*
- * setup()
- *	performs all ONE TIME setup for this test
- */
-void setup(void)
-{
-
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	tst_require_root();
-
-	if (tst_kvercmp(2, 5, 48) >= 0)
-		tst_brkm(TCONF, NULL, "This test will not work on "
-			 "kernels after 2.5.48");
-
-	/* Initialize longmodname to LONGMODNAMECHAR character */
-	memset(longmodname, LONGMODNAMECHAR, MODNAMEMAX - 1);
-
-	/* Pause if that option was specified
-	 * TEST_PAUSE contains the code to fork the test with the -c option.
-	 */
-	TEST_PAUSE;
-}
-
-/*
- * cleanup()
- *	performs all ONE TIME cleanup for this test at
- *	completion or premature exit
- */
-void cleanup(void)
-{
-	/*
-	 * print timing stats if that option was specified.
-	 * print errno log if that option was specified.
-	 */
-
-	tst_rmdir();
-}
diff --git a/testcases/kernel/module/query_module/query_module02.c b/testcases/kernel/module/query_module/query_module02.c
deleted file mode 100644
index fcae25d..0000000
--- a/testcases/kernel/module/query_module/query_module02.c
+++ /dev/null
@@ -1,205 +0,0 @@
-/*
- * Copyright (c) Wipro Technologies Ltd, 2002.  All Rights Reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
- */
-/**********************************************************
- *
- *    TEST IDENTIFIER   : query_module02
- *
- *    EXECUTED BY       : anyone
- *
- *    TEST TITLE        : Checking error conditions for query_module(2)
- *
- *    TEST CASE TOTAL   : 5
- *
- *    AUTHOR            : Madhu T L <madhu.tarikere@wipro.com>
- *
- *    SIGNALS
- *	Uses SIGUSR1 to pause before test if option set.
- *	(See the parse_opts(3) man page).
- *
- *    DESCRIPTION
- *	Verify that,
- *	1. query_module(2) returns -1 and sets errno to ENOENT for non-existing
- *	   module.
- *	2. query_module(2) returns -1 and sets errno to EINVAL for invalid
- *	   which argument.
- *	3. query_module(2) returns -1 and sets errno to EINVAL for NULL
- *	   module name and valid which argument.
- *      4. query_module(2) returns -1 and sets errno to EINVAL, if module
- *         name parameter is null terminated (zero length) string.
- *	5. query_module(2) returns -1 and sets errno to ENAMETOOLONG for long
- *	   module name.
- *
- *	Setup:
- *	  Setup signal handling.
- *	  Initialize  long module name
- *	  Set expected errnos for logging
- *	  Pause for SIGUSR1 if option specified.
- *
- *	Test:
- *	 Loop if the proper options are given.
- *	  Execute system call
- *	  Check return code and error number, if matching,
- *		Issue PASS message
- *	  Otherwise,
- *		Issue FAIL message
- *
- *	Cleanup:
- *	  Print errno log and/or timing stats if options given
- *
- * USAGE:  <for command-line>
- *  query_module02 [-c n] [-e] [-f] [-h] [-i n] [-I x] [-p] [-P x] [-t]
- *		where,  -c n : Run n copies concurrently.
- *			-e   : Turn on errno logging.
- *			-f   : Turn off functional testing
- *			-h   : Show help screen
- *			-i n : Execute test n times.
- *			-I x : Execute test for x seconds.
- *			-p   : Pause for SIGUSR1 before starting
- *			-P x : Pause for x seconds between iterations.
- *			-t   : Turn on syscall timing.
- *
- ****************************************************************/
-
-#include <errno.h>
-#include <pwd.h>
-#include <sys/types.h>
-#include <unistd.h>
-#include <limits.h>
-#include <asm/atomic.h>
-#include <linux/module.h>
-#include "test.h"
-
-#ifndef PAGE_SIZE
-#define PAGE_SIZE sysconf(_SC_PAGE_SIZE)
-#endif
-
-#define NULLMODNAME	""
-#define LONGMODNAMECHAR	'm'	/* Arbitrarily selected */
-#define MODNAMEMAX	(PAGE_SIZE + 1)
-#define EXP_RET_VAL	-1
-#define QM_INVALID	(QM_INFO + 100)
-
-struct test_case_t {		/* test case structure */
-	char *modname;
-	int which;
-	void *buf;
-	size_t bufsize;
-	int experrno;		/* expected errno */
-	char *desc;
-};
-
-char *TCID = "query_module02";
-
-static char longmodname[MODNAMEMAX];
-static int testno;
-static char out_buf[PAGE_SIZE];
-static size_t ret_size;
-
-static void setup(void);
-static void cleanup(void);
-
-static struct test_case_t tdat[] = {
-
-	{"dummy_mod", QM_REFS, (void *)out_buf, sizeof(out_buf), ENOENT,
-	 "results for non-existing module"}
-	,
-
-	{NULL, QM_INVALID, (void *)out_buf, sizeof(out_buf), EINVAL,
-	 "results for invalid which argument"}
-	,
-
-	{NULL, QM_REFS, (void *)out_buf, sizeof(out_buf), EINVAL,
-	 "results for NULL module name and valid which argument"}
-	,
-
-	{NULLMODNAME, QM_REFS, (void *)out_buf, sizeof(out_buf), EINVAL,
-	 "results for null terminated (zero lenght) module name"}
-	,
-
-	{longmodname, QM_REFS, (void *)out_buf, sizeof(out_buf), ENAMETOOLONG,
-	 "results for long module name"}
-	,
-};
-
-int TST_TOTAL = sizeof(tdat) / sizeof(tdat[0]);
-
-int main(int argc, char **argv)
-{
-	int lc;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset tst_count in case we are looping */
-		tst_count = 0;
-
-		for (testno = 0; testno < TST_TOTAL; ++testno) {
-
-			TEST(query_module(tdat[testno].modname,
-					  tdat[testno].which, tdat[testno].buf,
-					  tdat[testno].bufsize, &ret_size));
-			if ((TEST_RETURN == EXP_RET_VAL) &&
-			    (TEST_ERRNO == tdat[testno].experrno)) {
-				tst_resm(TPASS, "Expected %s, errno: %d",
-					 tdat[testno].desc, TEST_ERRNO);
-			} else {
-				tst_resm(TFAIL, "Unexpected %s ; returned"
-					 " %d (expected %d), errno %d (expected"
-					 " %d)", tdat[testno].desc,
-					 TEST_RETURN, EXP_RET_VAL,
-					 TEST_ERRNO, tdat[testno].experrno);
-			}
-		}
-	}
-	cleanup();
-
-	tst_exit();
-}
-
-/*
- * setup()
- *	performs all ONE TIME setup for this test
- */
-void setup(void)
-{
-
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	if (tst_kvercmp(2, 5, 48) >= 0)
-		tst_brkm(TCONF, NULL, "This test will not work on "
-			 "kernels after 2.5.48");
-
-	/* Initialize longmodname to LONGMODNAMECHAR character */
-	memset(longmodname, LONGMODNAMECHAR, MODNAMEMAX - 1);
-
-	/* Pause if that option was specified
-	 * TEST_PAUSE contains the code to fork the test with the -c option.
-	 */
-	TEST_PAUSE;
-}
-
-/*
- * cleanup()
- *	performs all ONE TIME cleanup for this test at
- *	completion or premature exit
- */
-void cleanup(void)
-{
-
-}
diff --git a/testcases/kernel/module/query_module/query_module03.c b/testcases/kernel/module/query_module/query_module03.c
deleted file mode 100644
index cdb0494..0000000
--- a/testcases/kernel/module/query_module/query_module03.c
+++ /dev/null
@@ -1,272 +0,0 @@
-/*
- * Copyright (c) Wipro Technologies Ltd, 2002.  All Rights Reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
- */
-/**********************************************************
- *
- *    TEST IDENTIFIER   : query_module03
- *
- *    EXECUTED BY       : root / superuser
- *
- *    TEST TITLE        : Checking error conditions for query_module(2)
- *
- *    TEST CASE TOTAL   : 4
- *
- *    AUTHOR            : Madhu T L <madhu.tarikere@wipro.com>
- *
- *    SIGNALS
- *	Uses SIGUSR1 to pause before test if option set.
- *	(See the parse_opts(3) man page).
- *
- *    DESCRIPTION
- *	Verify that,
- *	1. query_module(2) returns -1 and sets errno to EFAULT for module name
- *	   argument outside program's accessible address space.
- *	2. query_module(2) returns -1 and sets errno to EFAULT for return size
- *	   argument outside program's accessible address space.
- *	3. query_module(2) returns -1 and sets errno to EFAULT for output buffer
- *	   argument outside program's accessible address space.
- *	4. query_module(2) returns -1 and sets errno to ENOSPC for too small
- *	   buffer size.
- *
- *	Setup:
- *	  Setup signal handling.
- *	  Test caller is superuser
- *	  Set expected errnos for logging
- *	  Pause for SIGUSR1 if option specified.
- *
- *	Test:
- *	 Loop if the proper options are given.
- *	  Execute system call
- *	  Check return code and error number, if matching,
- *		Issue PASS message
- *	  Otherwise,
- *		Issue FAIL message
- *
- *	Cleanup:
- *	  Print errno log and/or timing stats if options given
- *
- * USAGE:  <for command-line>
- *  query_module03 [-c n] [-e] [-f] [-h] [-i n] [-I x] [-p] [-P x] [-t]
- *		where,  -c n : Run n copies concurrently.
- *			-e   : Turn on errno logging.
- *			-f   : Turn off functional testing
- *			-h   : Show help screen
- *			-i n : Execute test n times.
- *			-I x : Execute test for x seconds.
- *			-p   : Pause for SIGUSR1 before starting
- *			-P x : Pause for x seconds between iterations.
- *			-t   : Turn on syscall timing.
- *
- * RESTRICTIONS
- *	-c option has no effect for this testcase, even if used allows only
- *	one instance to run at a time.
- *
- * CHANGES
- *
- * 12/03/02 Added "force" to insmod to ignore kernel version.
- *          -Robbie Williamson <robbiew@us.ibm.com>
- *
- ****************************************************************/
-
-#include <unistd.h>
-#include <errno.h>
-#include <pwd.h>
-#include <sys/types.h>
-#include <unistd.h>
-#include <limits.h>
-#include <asm/atomic.h>
-#include <linux/module.h>
-#include <sys/mman.h>
-#include "test.h"
-
-#ifndef PAGE_SIZE
-#define PAGE_SIZE sysconf(_SC_PAGE_SIZE)
-#endif
-
-#define EXP_RET_VAL	-1
-#define DUMMY_MOD	"dummy_query_mod"
-#define SMALLBUFSIZE	1
-
-struct test_case_t {		/* test case structure */
-	char *modname;
-	int which;
-	void *buf;
-	size_t bufsize;
-	size_t *ret_size;
-	int experrno;		/* expected errno */
-	char *desc;
-	int (*setup) (void);
-	void (*cleanup) (void);
-};
-
-char *TCID = "query_module03";
-
-static int testno;
-static char out_buf[PAGE_SIZE];
-static size_t ret_size;
-
-char *bad_addr = 0;
-
-static void setup(void);
-static void cleanup(void);
-static int setup1(void);
-static void cleanup1(void);
-
-static struct test_case_t tdat[] = {
-
-	{(char *)-1, QM_MODULES, (void *)out_buf, sizeof(out_buf), &ret_size,
-	 EFAULT, "results for module name argument outside program's "
-	 "accessible address space", NULL, NULL}
-	,
-
-	{NULL, QM_MODULES, (void *)out_buf, sizeof(out_buf), (size_t *) - 1,
-	 EFAULT, "results for return size argument outside program's "
-	 "accessible address space", NULL, NULL}
-	,
-
-	{NULL, QM_MODULES, (void *)-1, sizeof(out_buf), &ret_size, EFAULT,
-	 "results for output buffer argument outside program's "
-	 "accessible address space", setup1, cleanup1}
-	,
-
-	{NULL, QM_MODULES, (void *)out_buf, SMALLBUFSIZE, &ret_size, ENOSPC,
-	 "results for too small buffer size", setup1, cleanup1},
-};
-
-int TST_TOTAL = sizeof(tdat) / sizeof(tdat[0]);
-
-int main(int argc, char **argv)
-{
-	int lc;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	tst_tmpdir();
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset tst_count in case we are looping */
-		tst_count = 0;
-
-		for (testno = 0; testno < TST_TOTAL; ++testno) {
-
-			if ((tdat[testno].setup) && (tdat[testno].setup())) {
-				/* setup() failed, skip this test */
-				continue;
-			}
-			TEST(query_module(tdat[testno].modname,
-					  tdat[testno].which, tdat[testno].buf,
-					  tdat[testno].bufsize,
-					  tdat[testno].ret_size));
-			if ((TEST_RETURN == EXP_RET_VAL) &&
-			    (TEST_ERRNO == tdat[testno].experrno)) {
-				tst_resm(TPASS, "Expected %s, errno: %d",
-					 tdat[testno].desc, TEST_ERRNO);
-			} else {
-				tst_resm(TFAIL, "Unexpected %s ; returned"
-					 " %d (expected %d), errno %d (expected"
-					 " %d)", tdat[testno].desc,
-					 TEST_RETURN, EXP_RET_VAL,
-					 TEST_ERRNO, tdat[testno].experrno);
-			}
-			if (tdat[testno].cleanup) {
-				tdat[testno].cleanup();
-			}
-		}
-	}
-	cleanup();
-	tst_exit();
-}
-
-int setup1(void)
-{
-	char cmd[80];
-
-	if (sprintf(cmd, "cp `which %s.o` ./", DUMMY_MOD) == -1) {
-		tst_resm(TBROK, "sprintf failed");
-		return 1;
-	}
-	if (system(cmd) != 0) {
-		tst_resm(TBROK, "Failed to copy %s module", DUMMY_MOD);
-		return 1;
-	}
-
-	/* Should use force to ignore kernel version & insure loading  */
-	/* -RW                                                         */
-	/* if (sprintf(cmd, "insmod %s.o", DUMMY_MOD) == -1) {         */
-	if (sprintf(cmd, "insmod --force -q %s.o >/dev/null 2>&1", DUMMY_MOD) ==
-	    -1) {
-		tst_resm(TBROK, "sprintf failed");
-		return 1;
-	}
-	if (system(cmd) != 0) {
-		tst_resm(TBROK, "Failed to load %s module", DUMMY_MOD);
-		return 1;
-	}
-	return 0;
-}
-
-void cleanup1(void)
-{
-	/* Remove the loadable module - DUMMY_MOD */
-	if (system("rmmod " DUMMY_MOD) != 0) {
-		tst_brkm(TBROK, cleanup, "Failed to unload module %s",
-			 DUMMY_MOD);
-	}
-}
-
-/*
- * setup()
- *	performs all ONE TIME setup for this test
- */
-void setup(void)
-{
-
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	tst_require_root();
-
-	if (tst_kvercmp(2, 5, 48) >= 0)
-		tst_brkm(TCONF, NULL, "This test will not work on "
-			 "kernels after 2.5.48");
-
-	/* Pause if that option was specified
-	 * TEST_PAUSE contains the code to fork the test with the -c option.
-	 */
-	TEST_PAUSE;
-
-	bad_addr = mmap(0, 1, PROT_NONE, MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
-	if (bad_addr == MAP_FAILED) {
-		tst_brkm(TBROK, cleanup, "mmap failed");
-	}
-	tdat[0].modname = bad_addr;
-	tdat[2].buf = (void *)bad_addr;
-
-}
-
-/*
- * cleanup()
- *	performs all ONE TIME cleanup for this test at
- *	completion or premature exit
- */
-void cleanup(void)
-{
-	/*
-	 * print timing stats if that option was specified.
-	 * print errno log if that option was specified.
-	 */
-	tst_rmdir();
-}
-- 
1.8.3.1



