From: Junchi Chen <junchi.chen@intel.com>
Date: Wed, 29 Aug 2018 16:23:20 +0800
Subject: [LTP] [PATCH v2 ltp] syscalls/munlockall02: remove deprecated test
Message-ID: <20180829082320.6903-1-junchi.chen@intel.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it

ISSUE:
  This TCONF message: "Some distros... support
   non-superuser munlockall calls."
   has unnecessarily shown for years.

REASON=EF=BC=9A
  The test is expecting EPERM error when calling munlockall with user
   nobody. However, the unprivileged calling of munlockall has been
   allowed at least since v2.6.

Signed-off-by: Junchi Chen <junchi.chen@intel.com>
---
 runtest/ltplite                               |   1 -
 runtest/stress.part3                          |   1 -
 runtest/syscalls                              |   1 -
 .../kernel/syscalls/munlockall/.gitignore     |   1 -
 .../kernel/syscalls/munlockall/munlockall02.c | 157 ------------------
 5 files changed, 161 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/munlockall/munlockall02.c

diff --git a/runtest/ltplite b/runtest/ltplite
index 9ca6c421f..a3d4f54e0 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -510,7 +510,6 @@ munlock01 munlock01
 munlock02 munlock02
=20
 munlockall01 munlockall01
-munlockall02 munlockall02
=20
 munmap01 munmap01
 munmap02 munmap02
diff --git a/runtest/stress.part3 b/runtest/stress.part3
index ec18dcf73..f9eed15ed 100644
--- a/runtest/stress.part3
+++ b/runtest/stress.part3
@@ -427,7 +427,6 @@ munlock01 munlock01
 munlock02 munlock02
=20
 munlockall01 munlockall01
-munlockall02 munlockall02
=20
 munmap01 munmap01
 munmap02 munmap02
diff --git a/runtest/syscalls b/runtest/syscalls
index ccc3eff59..eb1de2d30 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -730,7 +730,6 @@ munlock01 munlock01
 munlock02 munlock02
=20
 munlockall01 munlockall01
-munlockall02 munlockall02
=20
 munmap01 munmap01
 munmap02 munmap02
diff --git a/testcases/kernel/syscalls/munlockall/.gitignore b/testcases/ke=
rnel/syscalls/munlockall/.gitignore
index 5fb852410..b45b4ad06 100644
--- a/testcases/kernel/syscalls/munlockall/.gitignore
+++ b/testcases/kernel/syscalls/munlockall/.gitignore
@@ -1,2 +1 @@
 /munlockall01
-/munlockall02
diff --git a/testcases/kernel/syscalls/munlockall/munlockall02.c b/testcase=
s/kernel/syscalls/munlockall/munlockall02.c
deleted file mode 100644
index f97905473..000000000
--- a/testcases/kernel/syscalls/munlockall/munlockall02.c
+++ /dev/null
@@ -1,157 +0,0 @@
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
-/**************************************************************************
- *
- *    TEST IDENTIFIER	: munlockall02
- *
- *    EXECUTED BY	: root / superuser
- *
- *    TEST TITLE	: test for EPERM error value when run as non superuser
- *
- *    TEST CASE TOTAL	: 1
- *
- *    AUTHOR		: sowmya adiga<sowmya.adiga@wipro.com>
- *
- *    SIGNALS
- * 	Uses SIGUSR1 to pause before test if option set.
- * 	(See the parse_opts(3) man page).
- *
- *    DESCRIPTION
- *	Verify munlockall(2) returns -1 and sets errno to EPERM
- *	if the effective userid of the caller is not super-user.
- *	$
- * 	Setup:
- *	  Setup signal handling.
- *	  Pause for SIGUSR1 if option specified.
- *        Change effective user id to "nobody" user
- *     $
- * 	Test:
- *	 Loop if the proper options are given.
- *	  Execute system call
- *	  Check return code, if system call failed (return=3D-1) &&
- *	                    (errno set =3D=3D expected errno)
- *	 Issue sys call pass with expected return value and errno.
- *	 otherwise,
- *	  Issue sys call fails with unexpected errno.
- *
- *
- * 	Cleanup:
- *      change effective user id to root
- * 	Print errno log and/or timing stats if options given
- *
- * USAGE:  <for command-line>
- *  munlockall02 [-c n] [-e] [-i n] [-I x] [-p x] [-t]
- *		where,		-c n : Run n copies concurrently
- *				-e   : Turn on errno logging.
- *				-h   : Show this help screen
- *				-i n : Execute test n times.
- *				-I x : Execute test for x seconds.
- *				-p   : Pause for SIGUSR1 before starting
- *                      	-P x : Pause for x seconds between iterations.
- *                       	 t   : Turn on syscall timing.
- *
- *
- *************************************************************************=
****/
-#include <errno.h>
-#include <pwd.h>
-#include <sys/mman.h>
-#include "test.h"
-#include "safe_macros.h"
-
-void setup();
-void cleanup();
-
-char *TCID =3D "munlockall02";
-int TST_TOTAL =3D 1;
-
-static char nobody_uid[] =3D "nobody";
-struct passwd *ltpuser;
-
-#if !defined(UCLINUX)
-
-int main(int ac, char **av)
-{
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	/* check looping state */
-	for (lc =3D 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count =3D 0;
-
-		TEST(munlockall());
-		/* check return code */
-		if ((TEST_RETURN =3D=3D -1) && (TEST_ERRNO =3D=3D EPERM)) {
-			tst_resm(TPASS, "munlockall() failed"
-				 " as expected for non-superuser" ":GOT EPERM");
-		} else {
-			tst_resm(TCONF, "munlockall() failed to produce "
-				 "expected errno :%d Got : %d, %s. ***Some distros, such as Red Hat En=
terprise Linux, support non-superuser munlockall calls.***",
-				 EPERM, TEST_ERRNO, strerror(TEST_ERRNO));
-
-		}
-	}
-
-	/* cleanup and exit */
-	cleanup();
-	tst_exit();
-
-}
-
-/* setup() - performs all ONE TIME setup for this test. */
-void setup(void)
-{
-	tst_require_root();
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	/* switch to nobody user */
-	if ((ltpuser =3D getpwnam(nobody_uid)) =3D=3D NULL) {
-		tst_brkm(TBROK, NULL, "\"nobody\"user not present");
-	}
-
-	SAFE_SETEUID(NULL, ltpuser->pw_uid);
-
-	TEST_PAUSE;
-}
-
-#else
-
-int main(void)
-{
-	tst_resm(TINFO, "test is not available on uClinux");
-	tst_exit();
-}
-
-#endif /* if !defined(UCLINUX) */
-
-/*
- * cleanup() - performs all ONE TIME cleanup for this test at
- *		completion or premature exit.
- */
-void cleanup(void)
-{
-	if (seteuid(0) =3D=3D -1) {
-		tst_resm(TWARN, "seteuid failed to "
-			 "to set the effective uid to root");
-		perror("setuid");
-	}
-
-}
--=20
2.17.1

