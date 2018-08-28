From: Junchi Chen <junchi.chen@intel.com>
Date: Tue, 28 Aug 2018 23:52:53 +0800
Subject: [LTP] [PATCH ltp] syscalls/munlockall02: fix the outdated TCONF
	message
Message-ID: <20180828155253.30621-1-junchi.chen@intel.com>
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
  EPERM is the error expected, which, by man page, is occurring due
   to the lack of privilege (CAP_IPC_LOCK).
   The intersection of munlockall syscall and CAP_IPC_LOCK macro is only
   in /mm/mlock.c file.

  From v2.6, in /mm/mlock.c, there are no privilege check when using
   munlockall syscall.
   - For older version, the execution of do_mlockall()
   with flag 0 is done right after the request for the semlock.
   By comparison, mlockall syscall checked via capable(CAP_IPC_LOCK)
   before do_mlockall() with flags.
   - For newer version, apply_mlockall_flags()
   substituted do_mlockall(), but nothing changed regarding privilege check.

ACTION:
  Add tst_kvercmp() to test kernel version.

Signed-off-by: Junchi Chen <junchi.chen@intel.com>
---
 .../kernel/syscalls/munlockall/munlockall02.c | 30 ++++++++++++++-----
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/syscalls/munlockall/munlockall02.c b/testcase=
s/kernel/syscalls/munlockall/munlockall02.c
index f97905473..2e2695c52 100644
--- a/testcases/kernel/syscalls/munlockall/munlockall02.c
+++ b/testcases/kernel/syscalls/munlockall/munlockall02.c
@@ -48,6 +48,8 @@
  *	 otherwise,
  *	  Issue sys call fails with unexpected errno.
  *
+ *	 Since V2.6.11, the mainline kernel support none-superuser
+ *	  munlockall calls. So the test pass with a success.
  *
  * 	Cleanup:
  *      change effective user id to root
@@ -69,6 +71,7 @@
 #include <errno.h>
 #include <pwd.h>
 #include <sys/mman.h>
+#include "tst_kvercmp.h"
 #include "test.h"
 #include "safe_macros.h"
=20
@@ -98,14 +101,27 @@ int main(int ac, char **av)
=20
 		TEST(munlockall());
 		/* check return code */
-		if ((TEST_RETURN =3D=3D -1) && (TEST_ERRNO =3D=3D EPERM)) {
-			tst_resm(TPASS, "munlockall() failed"
-				 " as expected for non-superuser" ":GOT EPERM");
+		if (tst_kvercmp(2, 6, 11) < 0) {
+			if ((TEST_RETURN =3D=3D -1) && (TEST_ERRNO =3D=3D EPERM)) {
+				tst_resm(TPASS, "munlockall() failed"
+						" as expected for non-superuser"
+						":GOT EPERM");
+			} else {
+				tst_resm(TCONF, "munlockall() failed to produce "
+						"expected errno :%d Got : %d, %s. ***Some distros, "
+						"such as Red Hat Enterprise Linux, support "
+						"non-superuser munlockall calls.***",
+						EPERM, TEST_ERRNO, strerror(TEST_ERRNO));
+			}
 		} else {
-			tst_resm(TCONF, "munlockall() failed to produce "
-				 "expected errno :%d Got : %d, %s. ***Some distros, such as Red Hat En=
terprise Linux, support non-superuser munlockall calls.***",
-				 EPERM, TEST_ERRNO, strerror(TEST_ERRNO));
-
+			if (TEST_RETURN =3D=3D 0) {
+				tst_resm(TPASS, "munlockall() succeeded"
+						" as expected for non-superuser");
+			} else {
+				tst_resm(TFAIL, "munlockall() failed to run"
+						" as non-superuser, Got : %d, %s.",
+						TEST_ERRNO, strerror(TEST_ERRNO));
+			}
 		}
 	}
=20
--=20
2.17.1

