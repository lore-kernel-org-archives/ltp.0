From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Tue, 30 Jul 2019 13:45:33 +0800
Subject: [LTP] [PATCH v3 5/5] m4: clean up ltp-signalfd.m4
In-Reply-To: <1564465533-2475-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <20190729144227.GA8824@dell5510>
 <1564465533-2475-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <1564465533-2475-5-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Since patch[1] in 2007.10, the signo had been rename as ssi_signo. The
code is so old we can remove signo detection.
Also since patch[2] in 2009.1, the linux/type.h had been include. we can
remove this detection.
I don't find "signalfd.h" in /usr/include on different distros, so I think
we can only use two ways(glibc or tst_syscall) to call it.

[1]:https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=96358de6
[2]:https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a788fd53

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 m4/ltp-signalfd.m4                            | 62 +++----------------
 .../kernel/syscalls/signalfd/signalfd01.c     | 22 ++-----
 2 files changed, 13 insertions(+), 71 deletions(-)

diff --git a/m4/ltp-signalfd.m4 b/m4/ltp-signalfd.m4
index a435123ef..5aac395bd 100644
--- a/m4/ltp-signalfd.m4
+++ b/m4/ltp-signalfd.m4
@@ -1,65 +1,17 @@
 dnl SPDX-License-Identifier: GPL-2.0-or-later
 dnl Copyright (c) Red Hat Inc., 2008
+dnl Copyright (c) 2019 Fujitsu Ltd.
 dnl Author: Masatake YAMATO <yamato@redhat.com>
 
-dnl LTP_CHECK_SYSCALL_SIGNALFD
-dnl --------------------------
-dnl * Checking the existence of the libc wrapper for signalfd.
-dnl   If it exists, a shell variable LTP_SYSCALL_SIGNALFD_FUNCTION is set to "yes".
-dnl
-dnl * Checking the existence of signalfd.h.
-dnl   If it exists, a shell variable LTP_SYSCALL_SIGNALFD_HEADER is set to "yes".
-dnl
-dnl * Checking the prefix used in fileds for signalfd_siginfo structure.
-dnl   If it exists, a shell variable LTP_SYSCALL_SIGNALFD_FIELD_PREFIX is set to "given".
-dnl
-dnl About cpp macros defined in this macro,
-dnl see testcases/kernel/syscalls/signalfd/signalfd01.c of ltp.
-AC_DEFUN([LTP_CHECK_SYSCALL_SIGNALFD],
-[
-_LTP_CHECK_SYSCALL_SIGNALFD_FUNCTION
-_LTP_CHECK_SYSCALL_SIGNALFD_HEADER
+AC_DEFUN([LTP_CHECK_SYSCALL_SIGNALFD],[
 
-if test x"$LTP_SYSCALL_SIGNALFD_HEADER" = xyes; then
-   _LTP_CHECK_SYSCALL_SIGNALFD_FIELD_PREFIX
-fi]
-)
-
-dnl _LTP_CHECK_SYSCALL_SIGNALFD_FUNCTION
-dnl ------------------------------------
-AC_DEFUN([_LTP_CHECK_SYSCALL_SIGNALFD_FUNCTION],[
-AC_CHECK_FUNCS(signalfd,[LTP_SYSCALL_SIGNALFD_FUNCTION=yes])])
-
-dnl _LTP_CHECK_SYSCALL_SIGNALFD_HEADER
-dnl ----------------------------------
-AC_DEFUN([_LTP_CHECK_SYSCALL_SIGNALFD_HEADER],
-[
-AC_CHECK_HEADERS([sys/signalfd.h linux/types.h])
-AC_CHECK_HEADERS([linux/signalfd.h signalfd.h],[
-LTP_SYSCALL_SIGNALFD_HEADER=yes],,[
-#ifdef HAVE_LINUX_TYPES_H
-#include <linux/types.h>
-#endif
-]
-)
-]
-)
-
-dnl _LTP_CHECK_SYSCALL_SIGNALFD_FIELD_PREFIX
-dnl ----------------------------------------
-AC_DEFUN([_LTP_CHECK_SYSCALL_SIGNALFD_FIELD_PREFIX],
-[
-AC_CHECK_MEMBERS([struct signalfd_siginfo.ssi_signo, struct signalfd_siginfo.signo],[
-LTP_SYSCALL_SIGNALFD_FIELD_PREFIX=given],,[
+AC_CHECK_FUNCS(signalfd,,)
+AC_CHECK_HEADERS([sys/signalfd.h],,)
+AC_CHECK_HEADERS([linux/signalfd.h],,)
+AC_CHECK_MEMBERS([struct signalfd_siginfo.ssi_signo],,,[
 #if defined HAVE_SYS_SIGNALFD_H
 #include <sys/signalfd.h>
 #elif defined HAVE_LINUX_SIGNALFD_H
-#ifdef HAVE_LINUX_TYPES_H
-#include <linux/types.h>
-#endif
 #include <linux/signalfd.h>
-#elif defined HAVE_SIGNALFD_H
-#include <signalfd.h>
 #endif])
-]
-)
+])
diff --git a/testcases/kernel/syscalls/signalfd/signalfd01.c b/testcases/kernel/syscalls/signalfd/signalfd01.c
index 72901ff6a..1a62156ff 100644
--- a/testcases/kernel/syscalls/signalfd/signalfd01.c
+++ b/testcases/kernel/syscalls/signalfd/signalfd01.c
@@ -56,22 +56,13 @@ int TST_TOTAL = 1;
 #if defined HAVE_SYS_SIGNALFD_H
 #include <sys/signalfd.h>
 #elif defined HAVE_LINUX_SIGNALFD_H
-#if defined HAVE_LINUX_TYPES_H
-#include <linux/types.h>
-#endif
 #include <linux/signalfd.h>
 #define USE_OWNIMPL
-#elif defined HAVE_SIGNALFD_H
-#include <signalfd.h>
 #else
 #define  USE_STUB
 #endif
 
-#if defined HAVE_STRUCT_SIGNALFD_SIGINFO_SSI_SIGNO
-#define SIGNALFD_PREFIX(FIELD) ssi_##FIELD
-#elif defined HAVE_STRUCT_SIGNALFD_SIGINFO_SIGNO
-#define SIGNALFD_PREFIX(FIELD) FIELD
-#else
+#ifndef HAVE_STRUCT_SIGNALFD_SIGINFO_SSI_SIGNO
 #define USE_STUB
 #endif
 
@@ -170,14 +161,13 @@ int do_test1(uint32_t sig)
 		goto out;
 	}
 
-	if (fdsi.SIGNALFD_PREFIX(signo) == sig) {
+	if (fdsi.ssi_signo == sig) {
 		tst_resm(TPASS, "got expected signal");
 		sfd_for_next = sfd;
 		goto out;
 	} else {
 		tst_resm(TFAIL, "got unexpected signal: signal=%d : %s",
-			 fdsi.SIGNALFD_PREFIX(signo),
-			 strsignal(fdsi.SIGNALFD_PREFIX(signo)));
+			 fdsi.ssi_signo, strsignal(fdsi.ssi_signo));
 		sfd_for_next = -1;
 		close(sfd);
 		goto out;
@@ -254,13 +244,13 @@ void do_test2(int fd, uint32_t sig)
 		goto out;
 	}
 
-	if (fdsi.SIGNALFD_PREFIX(signo) == sig) {
+	if (fdsi.ssi_signo == sig) {
 		tst_resm(TPASS, "got expected signal");
 		goto out;
 	} else {
 		tst_resm(TFAIL, "got unexpected signal: signal=%d : %s",
-			 fdsi.SIGNALFD_PREFIX(signo),
-			 strsignal(fdsi.SIGNALFD_PREFIX(signo)));
+			 fdsi.ssi_signo),
+			 strsignal(fdsi.ssi_signo);
 		goto out;
 	}
 
-- 
2.18.1



