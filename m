From: Michael Moese <mmoese@suse.de>
Date: Wed,  1 Aug 2018 15:47:17 +0200
Subject: [LTP] [PATCH] Move getcwd05 to realpath01 and fix for old distro
Message-ID: <20180801134717.29909-1-mmoese@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The testcase getcwd05 is a regression test for cve-2018-1000001 [1].
However, there were changes in the behavior of libc functions, that some older
distributions refused to backport.
The testcase was two testcases, one for getcwd() and one for realpath().
While the behavior of getcwd() changed, it is totally independent from
the thestcase for the vulnerability in realpath. So, this test should be
moved to realpath/realpath01.c. In addition, the test of getcwd() is
totally unneeded here to test realpath() for the fix.

[1] https://sourceware.org/git/gitweb.cgi?p=glibc.git;a=commitdiff;h=52a713fdd0a30e1bd79818e2e3c4ab44ddca1a94

Signed-off-by: Michael Moese <mmoese@suse.de>
---
 runtest/cve                                   |  2 +-
 runtest/syscalls                              |  3 ++-
 testcases/kernel/syscalls/getcwd/.gitignore   |  1 -
 testcases/kernel/syscalls/realpath/.gitignore |  1 +
 testcases/kernel/syscalls/realpath/Makefile   | 23 ++++++++++++++++
 .../getcwd05.c => realpath/realpath01.c}      | 26 +++++--------------
 6 files changed, 33 insertions(+), 23 deletions(-)
 create mode 100644 testcases/kernel/syscalls/realpath/.gitignore
 create mode 100644 testcases/kernel/syscalls/realpath/Makefile
 rename testcases/kernel/syscalls/{getcwd/getcwd05.c => realpath/realpath01.c} (72%)

diff --git a/runtest/cve b/runtest/cve
index 58d8f12b2..b38fb3503 100644
--- a/runtest/cve
+++ b/runtest/cve
@@ -34,4 +34,4 @@ cve-2017-16939 cve-2017-16939
 cve-2017-17053 cve-2017-17053
 cve-2017-18075 pcrypt_aead01
 cve-2018-5803 sctp_big_chunk
-cve-2018-1000001 getcwd05
+cve-2018-1000001 realpath01
diff --git a/runtest/syscalls b/runtest/syscalls
index dc72484cb..4e813e9a7 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -348,7 +348,6 @@ getcwd01 getcwd01
 getcwd02 getcwd02
 getcwd03 getcwd03
 getcwd04 getcwd04
-getcwd05 getcwd05
 
 getdents01 getdents01
 getdents02 getdents02
@@ -895,6 +894,8 @@ readv01 readv01
 readv02 readv02
 readv03 readv03
 
+realpath01 realpath01
+
 reboot01 reboot01
 reboot02 reboot02
 
diff --git a/testcases/kernel/syscalls/getcwd/.gitignore b/testcases/kernel/syscalls/getcwd/.gitignore
index 99b2ba19f..338852b62 100644
--- a/testcases/kernel/syscalls/getcwd/.gitignore
+++ b/testcases/kernel/syscalls/getcwd/.gitignore
@@ -2,4 +2,3 @@
 /getcwd02
 /getcwd03
 /getcwd04
-/getcwd05
diff --git a/testcases/kernel/syscalls/realpath/.gitignore b/testcases/kernel/syscalls/realpath/.gitignore
new file mode 100644
index 000000000..54860c088
--- /dev/null
+++ b/testcases/kernel/syscalls/realpath/.gitignore
@@ -0,0 +1 @@
+/realpath01
diff --git a/testcases/kernel/syscalls/realpath/Makefile b/testcases/kernel/syscalls/realpath/Makefile
new file mode 100644
index 000000000..bd617d806
--- /dev/null
+++ b/testcases/kernel/syscalls/realpath/Makefile
@@ -0,0 +1,23 @@
+#
+#  Copyright (c) International Business Machines  Corp., 2001
+#
+#  This program is free software;  you can redistribute it and/or modify
+#  it under the terms of the GNU General Public License as published by
+#  the Free Software Foundation; either version 2 of the License, or
+#  (at your option) any later version.
+#
+#  This program is distributed in the hope that it will be useful,
+#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
+#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+#  the GNU General Public License for more details.
+#
+#  You should have received a copy of the GNU General Public License
+#  along with this program;  if not, write to the Free Software
+#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+#
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/getcwd/getcwd05.c b/testcases/kernel/syscalls/realpath/realpath01.c
similarity index 72%
rename from testcases/kernel/syscalls/getcwd/getcwd05.c
rename to testcases/kernel/syscalls/realpath/realpath01.c
index f39df4b1d..dcd6785fc 100644
--- a/testcases/kernel/syscalls/getcwd/getcwd05.c
+++ b/testcases/kernel/syscalls/realpath/realpath01.c
@@ -20,36 +20,22 @@ static void setup(void)
 	SAFE_CHROOT(CHROOT_DIR);
 }
 
-static void run(unsigned int i)
+static void run(void)
 {
-	int fail = 0;
-
-	if (i) {
-		tst_res(TINFO, "testing realpath()");
-		TESTPTR(realpath(".", NULL));
-	} else {
-		tst_res(TINFO, "testing getcwd()");
-		TESTPTR(getcwd(NULL, 0));
-	}
+	TESTPTR(realpath(".", NULL));
 
 	if (TST_ERR != ENOENT) {
 		tst_res(TFAIL | TTERRNO, "returned unexpected errno");
-		fail = 1;
-	}
-
-	if (TST_RET_PTR != NULL) {
+	} else	if (TST_RET_PTR != NULL) {
 		tst_res(TFAIL, "syscall didn't return NULL: '%s'",
 				(char *)TST_RET_PTR);
-		fail = 1;
-	}
-
-	if (!fail)
+	} else {
 		tst_res(TPASS, "bug not reproduced");
+	}
 }
 
 static struct tst_test test = {
-	.test = run,
-	.tcnt = 2,
+	.test_all = run,
 	.setup = setup,
 	.needs_root = 1,
 	.needs_tmpdir = 1,
-- 
2.18.0

