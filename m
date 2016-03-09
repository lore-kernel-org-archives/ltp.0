From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed,  9 Mar 2016 14:02:16 +0300
Subject: [LTP] [PATCH v2] syscalls/fstatat01: fix test on x86_64 arch
Message-ID: <1457521336-31979-1-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Test returns TCONF for x86_64 arch as it tries to invoke a syscall
with __NR_fstatat64 which the arch doesn't have. Test macro checks
that it != 0, then proceed inside the if block. But it skips the
case when it's defined as a stub (-1) for x86_64.

So here are fixes:

* invoke ltp_syscall with __NR_fstatat64/__NR_newfstatat only if
  they are > 0; Try __NR_fstatat if the previous ones not supported.

* use libc wrapper when it's supported (add 'configure' check);

* remove building *_64 test ('utils/newer_64.mk' include);
  TST_USE_NEWER64_SYSCALL seems redundant and build process makes
  the same binary in the end;

* Remove test 'fstatat01_64' from .gitignore and runtest/syscalls.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
v2: * move statbuf to main();
    * add a check for __NR_newfstatat > 0;
    * try ltp_syscall(__NR_fstatat, ...) if fstatat64/newfstatat
      not supported.

 configure.ac                                  |    1 +
 m4/ltp-fstatat.m4                             |   26 +++++++++++++++++
 runtest/syscalls                              |    1 -
 testcases/kernel/syscalls/.gitignore          |    1 -
 testcases/kernel/syscalls/fstatat/Makefile    |    1 -
 testcases/kernel/syscalls/fstatat/fstatat01.c |   38 ++++++++++--------------
 6 files changed, 43 insertions(+), 25 deletions(-)
 create mode 100644 m4/ltp-fstatat.m4

diff --git a/configure.ac b/configure.ac
index b065fe6..2fb1ebc 100644
--- a/configure.ac
+++ b/configure.ac
@@ -161,6 +161,7 @@ LTP_CHECK_XFS_QUOTACTL
 LTP_CHECK_CLONE_SUPPORTS_7_ARGS
 LTP_CHECK_MKDIRAT
 LTP_CHECK_FCHOWNAT
+LTP_CHECK_FSTATAT
 LTP_CHECK_MKNODAT
 LTP_CHECK_READLINKAT
 LTP_CHECK_OPENAT
diff --git a/m4/ltp-fstatat.m4 b/m4/ltp-fstatat.m4
new file mode 100644
index 0000000..8814ade
--- /dev/null
+++ b/m4/ltp-fstatat.m4
@@ -0,0 +1,26 @@
+dnl
+dnl Copyright (c) 2016 Oracle and/or its affiliates. All Rights Reserved.
+dnl
+dnl This program is free software;  you can redistribute it and/or modify
+dnl it under the terms of the GNU General Public License as published by
+dnl the Free Software Foundation; either version 2 of the License, or
+dnl (at your option) any later version.
+dnl
+dnl This program is distributed in the hope that it will be useful,
+dnl but WITHOUT ANY WARRANTY;  without even the implied warranty of
+dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+dnl the GNU General Public License for more details.
+dnl
+dnl You should have received a copy of the GNU General Public License
+dnl along with this program. If not, see <http://www.gnu.org/licenses/>.
+dnl
+dnl Author: Alexey Kodanev <alexey.kodanev@oracle.com>
+dnl
+
+dnl
+dnl LTP_CHECK_FSTATAT
+dnl -----------------
+dnl
+AC_DEFUN([LTP_CHECK_FSTATAT],[
+AC_CHECK_FUNCS(fstatat,,)
+])
diff --git a/runtest/syscalls b/runtest/syscalls
index b41c927..51334d7 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -305,7 +305,6 @@ fstat05_64 fstat05_64
 
 #fstatat64/newfstatat test cases
 fstatat01 fstatat01
-fstatat01_64 fstatat01_64
 
 fstatfs01 fstatfs01
 fstatfs01_64 fstatfs01_64
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index 0540928..8538057 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -261,7 +261,6 @@
 /fstat/fstat05
 /fstat/fstat05_64
 /fstatat/fstatat01
-/fstatat/fstatat01_64
 /fstatfs/fstatfs01
 /fstatfs/fstatfs01_64
 /fstatfs/fstatfs02
diff --git a/testcases/kernel/syscalls/fstatat/Makefile b/testcases/kernel/syscalls/fstatat/Makefile
index 048f8ce..7a1a87a 100644
--- a/testcases/kernel/syscalls/fstatat/Makefile
+++ b/testcases/kernel/syscalls/fstatat/Makefile
@@ -19,5 +19,4 @@
 top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
-include $(abs_srcdir)/../utils/newer_64.mk
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/fstatat/fstatat01.c b/testcases/kernel/syscalls/fstatat/fstatat01.c
index c92a714..8b279fa 100644
--- a/testcases/kernel/syscalls/fstatat/fstatat01.c
+++ b/testcases/kernel/syscalls/fstatat/fstatat01.c
@@ -33,6 +33,7 @@
 #include <errno.h>
 #include <string.h>
 #include <signal.h>
+#include "config.h"
 #include "test.h"
 #include "safe_macros.h"
 #include "linux_syscall_numbers.h"
@@ -58,40 +59,33 @@ static const char *filenames[TEST_CASES];
 static const int expected_errno[] = { 0, 0, ENOTDIR, EBADF, EINVAL, 0 };
 static const int flags[] = { 0, 0, 0, 0, 9999, 0 };
 
-/* TODO (garrcoop): properly port to fstatat64. */
-#if (defined __NR_fstatat64) && (__NR_fstatat64 != 0)
-struct stat64 statbuf;
-#else
-struct stat statbuf;
-#endif
-
-/*
- * XXX (garrcoop): NO NO NO NO NO NO NO NO NO ... use linux_syscall_numbers.h!
- */
-/* __NR_fstatat64 and __NR_fstatat64 if not defined are ALWAYS stubbed by
- *  linux_syscall_numbers.h Need to check for 0 to avoid testing with stubs */
-#if (defined __NR_fstatat64) && (__NR_fstatat64 != 0)
-int myfstatat(int dirfd, const char *filename, struct stat64 *statbuf,
-	      int flags)
+#if !defined(HAVE_FSTATAT)
+#if (__NR_fstatat64 > 0)
+int fstatat(int dirfd, const char *filename, struct stat64 *statbuf, int flags)
 {
 	return ltp_syscall(__NR_fstatat64, dirfd, filename, statbuf, flags);
 }
-#elif (defined __NR_newfstatat) && (__NR_newfstatat != 0)
-int myfstatat(int dirfd, const char *filename, struct stat *statbuf, int flags)
+#elif (__NR_newfstatat > 0)
+int fstatat(int dirfd, const char *filename, struct stat *statbuf, int flags)
 {
 	return ltp_syscall(__NR_newfstatat, dirfd, filename, statbuf, flags);
 }
 #else
-/* stub - will never run */
-int myfstatat(int dirfd, const char *filename, struct stat *statbuf, int flags)
+int fstatat(int dirfd, const char *filename, struct stat *statbuf, int flags)
 {
-	return ltp_syscall(0, dirfd, filename, statbuf, flags);
+	return ltp_syscall(__NR_fstatat, dirfd, filename, statbuf, flags);
 }
 #endif
+#endif
 
 int main(int ac, char **av)
 {
 	int lc, i;
+#if !defined(HAVE_FSTATAT) && (__NR_fstatat64 > 0)
+	static struct stat64 statbuf;
+#else
+	static struct stat statbuf;
+#endif
 
 	if (tst_kvercmp(2, 6, 16) < 0)
 		tst_brkm(TCONF, NULL, "Test must be run with kernel 2.6.16+");
@@ -104,8 +98,7 @@ int main(int ac, char **av)
 		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; i++) {
-			TEST(myfstatat
-			     (fds[i], filenames[i], &statbuf, flags[i]));
+			TEST(fstatat(fds[i], filenames[i], &statbuf, flags[i]));
 
 			if (TEST_ERRNO == expected_errno[i]) {
 				tst_resm(TPASS | TTERRNO,
@@ -156,3 +149,4 @@ void cleanup(void)
 	free(testfile3);
 	tst_rmdir();
 }
+
-- 
1.7.1

