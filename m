From: Petr Vorel <petr.vorel@gmail.com>
Date: Thu, 21 Mar 2019 23:51:52 +0100
Subject: [LTP] [RFC PATCH 1/1] ltp-testsuite: Enable build under musl
Message-ID: <20190321225152.11335-1-petr.vorel@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

This requires to remove a lot of broken code until it's fixed in upstream.

+ backport upstream patch 6511fcf26 ("Define __SIGRTMIN and __SIGRTMAX
for MUSL") and add 8 upstreamed patches (to be included in a next release
after 20190115) and 1 (10th) not yet upstreamed.

8th patch requires to rerun autotools and also solve the need of
removing cpuset for uClibc.

Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
---
Hi,

I guess this patch is not acceptable due deleting quite a lot of the
code from LTP. Slowly working on fixing MUSL in upstream.

Kind regards,
Petr
---
 ...e-__SIGRTMIN-and-__SIGRTMAX-for-MUSL.patch | 112 ++++
 ...fine-_GNU_SOURCE-to-get-SA_NOMASK-on.patch |  82 +++
 ...eplace-libc-specific-sighandler_t-by.patch |  37 ++
 ...int-instead-of-enum-__ptrace_request.patch |  55 ++
 ...NU_SOURCE-to-get-MREMAP_MAYMOVE-on-M.patch |  90 +++
 .../0007-mallopt-Test-only-on-glibc.patch     |  39 ++
 .../0008-cpuset-Detect-missing-fts.h.patch    |  72 +++
 ...msgrcv-msgrcv08-Rename-struct-msgbuf.patch |  41 ++
 ...-TST_ABI-32-64-to-detect-target-type.patch | 604 ++++++++++++++++++
 package/ltp-testsuite/Config.in               |   3 +-
 package/ltp-testsuite/ltp-testsuite.mk        |  42 +-
 11 files changed, 1172 insertions(+), 5 deletions(-)
 create mode 100644 package/ltp-testsuite/0002-Define-__SIGRTMIN-and-__SIGRTMAX-for-MUSL.patch
 create mode 100644 package/ltp-testsuite/0003-rt_-sigaction-Define-_GNU_SOURCE-to-get-SA_NOMASK-on.patch
 create mode 100644 package/ltp-testsuite/0004-rt_sigaction.h-Replace-libc-specific-sighandler_t-by.patch
 create mode 100644 package/ltp-testsuite/0005-ptrace-Use-int-instead-of-enum-__ptrace_request.patch
 create mode 100644 package/ltp-testsuite/0006-mremap-Define-_GNU_SOURCE-to-get-MREMAP_MAYMOVE-on-M.patch
 create mode 100644 package/ltp-testsuite/0007-mallopt-Test-only-on-glibc.patch
 create mode 100644 package/ltp-testsuite/0008-cpuset-Detect-missing-fts.h.patch
 create mode 100644 package/ltp-testsuite/0009-msgrcv-msgrcv08-Rename-struct-msgbuf.patch
 create mode 100644 package/ltp-testsuite/0010-lapi-Define-TST_ABI-32-64-to-detect-target-type.patch

diff --git a/package/ltp-testsuite/0002-Define-__SIGRTMIN-and-__SIGRTMAX-for-MUSL.patch b/package/ltp-testsuite/0002-Define-__SIGRTMIN-and-__SIGRTMAX-for-MUSL.patch
new file mode 100644
index 0000000000..26e2f08606
--- /dev/null
+++ b/package/ltp-testsuite/0002-Define-__SIGRTMIN-and-__SIGRTMAX-for-MUSL.patch
@@ -0,0 +1,112 @@
+rom 6511fcf26dc251c0b4eb6ec7bb4325b6a1bbcd6b Mon Sep 17 00:00:00 2001
+From: =?UTF-8?q?Daniel=20D=C3=ADaz?= <daniel.diaz@linaro.org>
+Date: Thu, 21 Feb 2019 10:42:13 -0600
+Subject: [PATCH] Define __SIGRTMIN and __SIGRTMAX for MUSL
+MIME-Version: 1.0
+Content-Type: text/plain; charset=UTF-8
+Content-Transfer-Encoding: 8bit
+
+Some libc implementations might differ in the definitions they
+include. Exempli gratia: MUSL does not define __SIGRTMAX nor
+__SIGRTMIN.
+
+These two tests fail to build because of the missing
+definitions:
+  testcases/kernel/syscalls/ptrace/ptrace05.c
+  testcases/kernel/syscalls/sighold/sighold02.c
+
+Out of precaution, these two also include this header:
+  lib/tst_sig.c
+  testcases/kernel/syscalls/rt_sigsuspend/rt_sigsuspend01.c
+
+Signed-off-by: Daniel Díaz <daniel.diaz@linaro.org>
+Signed-off-by: Petr Vorel <pvorel@suse.cz>
+---
+ include/lapi/signal.h                         | 24 +++++++++++++++++++
+ lib/tst_sig.c                                 |  1 +
+ testcases/kernel/syscalls/ptrace/ptrace05.c   |  1 +
+ .../syscalls/rt_sigsuspend/rt_sigsuspend01.c  |  1 +
+ testcases/kernel/syscalls/sighold/sighold02.c |  1 +
+ 5 files changed, 28 insertions(+)
+ create mode 100644 include/lapi/signal.h
+
+diff --git a/include/lapi/signal.h b/include/lapi/signal.h
+new file mode 100644
+index 000000000..d22965a94
+--- /dev/null
++++ b/include/lapi/signal.h
+@@ -0,0 +1,24 @@
++// SPDX-License-Identifier: GPL-2.0-or-later
++/*
++ * Copyright (c) 2019 Linaro Limited. All rights reserved.
++ * Author: Daniel Díaz <daniel.diaz@linaro.org>
++ */
++
++#ifndef LAPI_SIGNAL_H
++#define LAPI_SIGNAL_H
++
++#include <signal.h>
++
++/*
++ * Some libc implementations might differ in the definitions they include. This
++ * covers those differences for all tests to successfully build.
++ */
++
++#ifndef __SIGRTMIN
++# define __SIGRTMIN 32
++#endif
++#ifndef __SIGRTMAX
++# define __SIGRTMAX (_NSIG - 1)
++#endif
++
++#endif
+diff --git a/lib/tst_sig.c b/lib/tst_sig.c
+index 36565e13d..6d77aeafd 100644
+--- a/lib/tst_sig.c
++++ b/lib/tst_sig.c
+@@ -72,6 +72,7 @@
+ #include <signal.h>
+ #include <unistd.h>
+ #include "test.h"
++#include "lapi/signal.h"
+
+ #define MAXMESG 150		/* size of mesg string sent to tst_res */
+
+diff --git a/testcases/kernel/syscalls/ptrace/ptrace05.c b/testcases/kernel/syscalls/ptrace/ptrace05.c
+index 420330029..54cfa4d7b 100644
+--- a/testcases/kernel/syscalls/ptrace/ptrace05.c
++++ b/testcases/kernel/syscalls/ptrace/ptrace05.c
+@@ -38,6 +38,7 @@
+ #include "ptrace.h"
+
+ #include "test.h"
++#include "lapi/signal.h"
+
+ char *TCID = "ptrace05";
+ int TST_TOTAL = 0;
+diff --git a/testcases/kernel/syscalls/rt_sigsuspend/rt_sigsuspend01.c b/testcases/kernel/syscalls/rt_sigsuspend/rt_sigsuspend01.c
+index f17a9aae6..e577cf227 100644
+--- a/testcases/kernel/syscalls/rt_sigsuspend/rt_sigsuspend01.c
++++ b/testcases/kernel/syscalls/rt_sigsuspend/rt_sigsuspend01.c
+@@ -18,6 +18,7 @@
+ #include "tst_test.h"
+ #include "lapi/syscalls.h"
+ #include "lapi/safe_rt_signal.h"
++#include "lapi/signal.h"
+
+ static void sig_handler(int sig)
+ {
+diff --git a/testcases/kernel/syscalls/sighold/sighold02.c b/testcases/kernel/syscalls/sighold/sighold02.c
+index d1d4b0b06..b763142df 100644
+--- a/testcases/kernel/syscalls/sighold/sighold02.c
++++ b/testcases/kernel/syscalls/sighold/sighold02.c
+@@ -49,6 +49,7 @@
+ #include <sys/wait.h>
+ #include "test.h"
+ #include "safe_macros.h"
++#include "lapi/signal.h"
+
+ /* _XOPEN_SOURCE disables NSIG */
+ #ifndef NSIG
+--
+2.21.0
diff --git a/package/ltp-testsuite/0003-rt_-sigaction-Define-_GNU_SOURCE-to-get-SA_NOMASK-on.patch b/package/ltp-testsuite/0003-rt_-sigaction-Define-_GNU_SOURCE-to-get-SA_NOMASK-on.patch
new file mode 100644
index 0000000000..89c587b1c8
--- /dev/null
+++ b/package/ltp-testsuite/0003-rt_-sigaction-Define-_GNU_SOURCE-to-get-SA_NOMASK-on.patch
@@ -0,0 +1,82 @@
+From 1731675dd88d065e4547fa25eeead3e9bf626524 Mon Sep 17 00:00:00 2001
+From: Petr Vorel <petr.vorel@gmail.com>
+Date: Mon, 18 Mar 2019 00:52:55 +0100
+Subject: [PATCH] {rt_,}sigaction: Define _GNU_SOURCE to get SA_NOMASK on MUSL
+
+Unlike glibc and uclibc (which define SA_NOMASK under __USE_MISC)
+MUSL requires _GNU_SOURCE.
+
+_GNU_SOURCE is already used in crash02.c.
+
+Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
+---
+ testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c | 1 +
+ testcases/kernel/syscalls/rt_sigaction/rt_sigaction02.c | 1 +
+ testcases/kernel/syscalls/rt_sigaction/rt_sigaction03.c | 1 +
+ testcases/kernel/syscalls/sigaction/sigaction02.c       | 2 ++
+ testcases/misc/crash/crash01.c                          | 1 +
+ 5 files changed, 6 insertions(+)
+
+diff --git a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c
+index be9e9abb7..fa50af319 100644
+--- a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c
++++ b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c
+@@ -28,6 +28,7 @@
+ /*		sigset_t type.                       			      */
+ /******************************************************************************/
+
++#define _GNU_SOURCE
+ #include <stdio.h>
+ #include <stdlib.h>
+ #include <unistd.h>
+diff --git a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction02.c b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction02.c
+index 2c4d8799b..09e351957 100644
+--- a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction02.c
++++ b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction02.c
+@@ -24,6 +24,7 @@
+ /*		rt_sigaction Expected EFAULT error check                      */
+ /******************************************************************************/
+
++#define _GNU_SOURCE
+ #include <stdio.h>
+ #include <stdlib.h>
+ #include <unistd.h>
+diff --git a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction03.c b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction03.c
+index 823fbe6c2..6e7865c07 100644
+--- a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction03.c
++++ b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction03.c
+@@ -24,6 +24,7 @@
+ /*		rt_sigaction Expected EINVAL error check                      */
+ /******************************************************************************/
+
++#define _GNU_SOURCE
+ #include <stdio.h>
+ #include <stdlib.h>
+ #include <unistd.h>
+diff --git a/testcases/kernel/syscalls/sigaction/sigaction02.c b/testcases/kernel/syscalls/sigaction/sigaction02.c
+index 641a04eca..aaf716b15 100644
+--- a/testcases/kernel/syscalls/sigaction/sigaction02.c
++++ b/testcases/kernel/syscalls/sigaction/sigaction02.c
+@@ -49,6 +49,8 @@
+  *	This test doesn't follow the correct LTP format - PLEASE FIX!
+  */
+ #define DEBUG 0
++
++#define _GNU_SOURCE
+ #include <stdio.h>
+ #include <stdlib.h>
+ #include <unistd.h>
+diff --git a/testcases/misc/crash/crash01.c b/testcases/misc/crash/crash01.c
+index 05745214c..192fbc32c 100644
+--- a/testcases/misc/crash/crash01.c
++++ b/testcases/misc/crash/crash01.c
+@@ -50,6 +50,7 @@ benchmark.
+
+ */
+
++#define _GNU_SOURCE
+ #include <stdio.h>
+ #include <stdlib.h>
+ #include <string.h>
+--
+2.21.0
diff --git a/package/ltp-testsuite/0004-rt_sigaction.h-Replace-libc-specific-sighandler_t-by.patch b/package/ltp-testsuite/0004-rt_sigaction.h-Replace-libc-specific-sighandler_t-by.patch
new file mode 100644
index 0000000000..128f750cbe
--- /dev/null
+++ b/package/ltp-testsuite/0004-rt_sigaction.h-Replace-libc-specific-sighandler_t-by.patch
@@ -0,0 +1,37 @@
+From 14494baf9a148eb5ca7ec4cfb98f95a5d82c3ec7 Mon Sep 17 00:00:00 2001
+From: Petr Vorel <petr.vorel@gmail.com>
+Date: Mon, 18 Mar 2019 19:01:11 +0100
+Subject: [PATCH] rt_sigaction.h: Replace libc specific sighandler_t by POSIX
+
+__sighandler_t is libc implementation specific and should not be relied
+upon. Thus use (*)(int), as specified by POSIX.
+
+This fixes MUSL build.
+
+Suggested-by: Cyril Hrubis <chrubis@suse.cz>
+Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
+---
+ include/lapi/rt_sigaction.h | 4 ++--
+ 1 file changed, 2 insertions(+), 2 deletions(-)
+
+diff --git a/include/lapi/rt_sigaction.h b/include/lapi/rt_sigaction.h
+index 2dbbc7672..29068eb67 100644
+--- a/include/lapi/rt_sigaction.h
++++ b/include/lapi/rt_sigaction.h
+@@ -36,12 +36,12 @@
+ #if defined(__mips__)
+ struct kernel_sigaction {
+	unsigned int sa_flags;
+-	__sighandler_t k_sa_handler;
++	void (* k_sa_handler)(int);
+	sigset_t sa_mask;
+ };
+ #else
+ struct kernel_sigaction {
+-	__sighandler_t k_sa_handler;
++	void (* k_sa_handler)(int);
+	unsigned long sa_flags;
+	void (*sa_restorer) (void);
+	sigset_t sa_mask;
+--
+2.21.0
diff --git a/package/ltp-testsuite/0005-ptrace-Use-int-instead-of-enum-__ptrace_request.patch b/package/ltp-testsuite/0005-ptrace-Use-int-instead-of-enum-__ptrace_request.patch
new file mode 100644
index 0000000000..a095207aa6
--- /dev/null
+++ b/package/ltp-testsuite/0005-ptrace-Use-int-instead-of-enum-__ptrace_request.patch
@@ -0,0 +1,55 @@
+From 1bb61463fd5ca716991e3c4a25057f6c7b5a466f Mon Sep 17 00:00:00 2001
+From: Petr Vorel <petr.vorel@gmail.com>
+Date: Mon, 18 Mar 2019 02:23:03 +0100
+Subject: [PATCH] ptrace: Use int instead of enum  __ptrace_request
+
+enum __ptrace_request is glibc/uclibc specific.
+
+Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
+---
+ testcases/kernel/syscalls/ptrace/ptrace03.c           | 2 +-
+ testcases/kernel/syscalls/ptrace/ptrace06.c           | 2 +-
+ testcases/kernel/syscalls/ptrace/spawn_ptrace_child.h | 2 +-
+ 3 files changed, 3 insertions(+), 3 deletions(-)
+
+diff --git a/testcases/kernel/syscalls/ptrace/ptrace03.c b/testcases/kernel/syscalls/ptrace/ptrace03.c
+index a4028fc26..f326b834d 100644
+--- a/testcases/kernel/syscalls/ptrace/ptrace03.c
++++ b/testcases/kernel/syscalls/ptrace/ptrace03.c
+@@ -102,7 +102,7 @@ static pid_t unused_pid;
+ static pid_t zero_pid;
+
+ struct test_case_t {
+-	enum __ptrace_request request;
++	int request;
+	pid_t *pid;
+	int exp_errno;
+ } test_cases[] = {
+diff --git a/testcases/kernel/syscalls/ptrace/ptrace06.c b/testcases/kernel/syscalls/ptrace/ptrace06.c
+index ba92ed11f..c0cb3b9bd 100644
+--- a/testcases/kernel/syscalls/ptrace/ptrace06.c
++++ b/testcases/kernel/syscalls/ptrace/ptrace06.c
+@@ -38,7 +38,7 @@
+ char *TCID = "ptrace06";
+
+ struct test_case_t {
+-	enum __ptrace_request request;
++	int request;
+	long addr;
+	long data;
+ } test_cases[] = {
+diff --git a/testcases/kernel/syscalls/ptrace/spawn_ptrace_child.h b/testcases/kernel/syscalls/ptrace/spawn_ptrace_child.h
+index ae538e900..83de9b447 100644
+--- a/testcases/kernel/syscalls/ptrace/spawn_ptrace_child.h
++++ b/testcases/kernel/syscalls/ptrace/spawn_ptrace_child.h
+@@ -130,7 +130,7 @@ static char *strings[] = {
+	SPT(KILL)
+	SPT(SINGLESTEP)
+ };
+-static inline char *strptrace(enum __ptrace_request request)
++static inline char *strptrace(int request)
+ {
+	return strings[request];
+ }
+--
+2.21.0
diff --git a/package/ltp-testsuite/0006-mremap-Define-_GNU_SOURCE-to-get-MREMAP_MAYMOVE-on-M.patch b/package/ltp-testsuite/0006-mremap-Define-_GNU_SOURCE-to-get-MREMAP_MAYMOVE-on-M.patch
new file mode 100644
index 0000000000..76eac9b9ee
--- /dev/null
+++ b/package/ltp-testsuite/0006-mremap-Define-_GNU_SOURCE-to-get-MREMAP_MAYMOVE-on-M.patch
@@ -0,0 +1,90 @@
+From 84831a6d6a2cea6d60f4368041746649fe66b82f Mon Sep 17 00:00:00 2001
+From: Petr Vorel <petr.vorel@gmail.com>
+Date: Mon, 18 Mar 2019 02:34:59 +0100
+Subject: [PATCH] mremap: Define _GNU_SOURCE to get MREMAP_MAYMOVE on MUSL
+
+Unlike glibc and uclibc (which define MREMAP_MAYMOVE under __USE_MISC)
+MUSL requires _GNU_SOURCE.
++ Remove __USE_GNU
+
+Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
+---
+ testcases/kernel/syscalls/mremap/mremap01.c | 4 ++--
+ testcases/kernel/syscalls/mremap/mremap02.c | 3 +--
+ testcases/kernel/syscalls/mremap/mremap03.c | 3 +--
+ testcases/kernel/syscalls/mremap/mremap04.c | 3 +--
+ 4 files changed, 5 insertions(+), 8 deletions(-)
+
+diff --git a/testcases/kernel/syscalls/mremap/mremap01.c b/testcases/kernel/syscalls/mremap/mremap01.c
+index 16519a23c..4c795fee5 100644
+--- a/testcases/kernel/syscalls/mremap/mremap01.c
++++ b/testcases/kernel/syscalls/mremap/mremap01.c
+@@ -74,11 +74,11 @@
+  * RESTRICTIONS:
+  *  None.
+  */
++
++#define _GNU_SOURCE
+ #include <unistd.h>
+ #include <errno.h>
+-#define __USE_GNU
+ #include <sys/mman.h>
+-#undef __USE_GNU
+ #include <fcntl.h>
+
+ #include "test.h"
+diff --git a/testcases/kernel/syscalls/mremap/mremap02.c b/testcases/kernel/syscalls/mremap/mremap02.c
+index 5a51b9aff..2dabc6847 100644
+--- a/testcases/kernel/syscalls/mremap/mremap02.c
++++ b/testcases/kernel/syscalls/mremap/mremap02.c
+@@ -72,12 +72,11 @@
+  * RESTRICTIONS:
+  *  None.
+  */
++#define _GNU_SOURCE
+ #include <errno.h>
+ #include <unistd.h>
+ #include <fcntl.h>
+-#define __USE_GNU
+ #include <sys/mman.h>
+-#undef __USE_GNU
+
+ #include "test.h"
+
+diff --git a/testcases/kernel/syscalls/mremap/mremap03.c b/testcases/kernel/syscalls/mremap/mremap03.c
+index 4c9c7b069..02b79bc47 100644
+--- a/testcases/kernel/syscalls/mremap/mremap03.c
++++ b/testcases/kernel/syscalls/mremap/mremap03.c
+@@ -73,12 +73,11 @@
+  * RESTRICTIONS:
+  *  None.
+  */
++#define _GNU_SOURCE
+ #include <errno.h>
+ #include <unistd.h>
+ #include <fcntl.h>
+-#define __USE_GNU
+ #include <sys/mman.h>
+-#undef __USE_GNU
+
+ #include "test.h"
+
+diff --git a/testcases/kernel/syscalls/mremap/mremap04.c b/testcases/kernel/syscalls/mremap/mremap04.c
+index c25dbfeb4..53902df73 100644
+--- a/testcases/kernel/syscalls/mremap/mremap04.c
++++ b/testcases/kernel/syscalls/mremap/mremap04.c
+@@ -77,11 +77,10 @@
+  * RESTRICTIONS:
+  *  None.
+  */
++#define _GNU_SOURCE
+ #include <errno.h>
+ #include <unistd.h>
+-#define __USE_GNU
+ #include <sys/mman.h>
+-#undef __USE_GNU
+ #include <sys/ipc.h>
+ #include <sys/shm.h>
+
+--
+2.21.0
diff --git a/package/ltp-testsuite/0007-mallopt-Test-only-on-glibc.patch b/package/ltp-testsuite/0007-mallopt-Test-only-on-glibc.patch
new file mode 100644
index 0000000000..2a517ecf26
--- /dev/null
+++ b/package/ltp-testsuite/0007-mallopt-Test-only-on-glibc.patch
@@ -0,0 +1,39 @@
+From 642f56cd21f5e5d3bc7cad7a8ffd998c006eb910 Mon Sep 17 00:00:00 2001
+From: Petr Vorel <petr.vorel@gmail.com>
+Date: Mon, 18 Mar 2019 02:49:06 +0100
+Subject: [PATCH] mallopt: Test only on glibc
+
+Test works with is glibc specific definitions M_MXFAST , M_NLBLKS, which
+aren't supported on other libc (uClibc, MUSL, Bionic), probably no other
+libc will ever define.
+uClibc also defines them in headers, that's we explicitly check glibc.
+
+Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
+---
+ testcases/kernel/syscalls/mallopt/mallopt01.c | 6 +++---
+ 1 file changed, 3 insertions(+), 3 deletions(-)
+
+diff --git a/testcases/kernel/syscalls/mallopt/mallopt01.c b/testcases/kernel/syscalls/mallopt/mallopt01.c
+index 416fc48be..14e26dd81 100644
+--- a/testcases/kernel/syscalls/mallopt/mallopt01.c
++++ b/testcases/kernel/syscalls/mallopt/mallopt01.c
+@@ -63,7 +63,7 @@ extern int tst_COUNT;		/* Test Case counter for tst_routines */
+
+ void printinfo();
+
+-#if !defined(UCLINUX)
++#if defined(__GLIBC__)
+ struct mallinfo info;
+
+ int main(int argc, char *argv[])
+@@ -150,6 +150,6 @@ void printinfo(void)
+ #else
+ int main(void)
+ {
+-	tst_brkm(TCONF, NULL, "test is not available on uClinux");
++	tst_brkm(TCONF, NULL, "mallopt defined only for glibc");
+ }
+-#endif /* if !defined(UCLINUX) */
++#endif
+--
+2.21.0
diff --git a/package/ltp-testsuite/0008-cpuset-Detect-missing-fts.h.patch b/package/ltp-testsuite/0008-cpuset-Detect-missing-fts.h.patch
new file mode 100644
index 0000000000..d308bd0882
--- /dev/null
+++ b/package/ltp-testsuite/0008-cpuset-Detect-missing-fts.h.patch
@@ -0,0 +1,72 @@
+From b7b527b329b5027b72efcbfce626f9531c380017 Mon Sep 17 00:00:00 2001
+From: Petr Vorel <petr.vorel@gmail.com>
+Date: Thu, 21 Mar 2019 22:08:31 +0100
+Subject: [PATCH] cpuset: Detect missing fts.h
+
+This fixes build on uClibc with disabled fts.h support and MUSL, which
+does not have fts.h at all.
+
+Reported-by: Vineet Gupta <vgupta@synopsys.com>
+Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
+---
+ configure.ac                          | 1 +
+ include/mk/config.mk.in               | 1 +
+ m4/ltp-fts.m4                         | 7 +++++++
+ testcases/kernel/controllers/Makefile | 4 ++++
+ 4 files changed, 13 insertions(+)
+ create mode 100644 m4/ltp-fts.m4
+
+diff --git a/configure.ac b/configure.ac
+index caea34462..2173c6b5f 100644
+--- a/configure.ac
++++ b/configure.ac
+@@ -231,6 +231,7 @@ LTP_CHECK_TPACKET_V3
+ LTP_CHECK_RLIMIT64
+ LTP_DETECT_HOST_CPU
+ LTP_CHECK_PERF_EVENT
++LTP_CHECK_FTS_H
+
+ if test "x$with_numa" = xyes; then
+	LTP_CHECK_SYSCALL_NUMA
+diff --git a/include/mk/config.mk.in b/include/mk/config.mk.in
+index 01f178bff..d55fe9602 100644
+--- a/include/mk/config.mk.in
++++ b/include/mk/config.mk.in
+@@ -46,6 +46,7 @@ SELINUX_LIBS		:= @SELINUX_LIBS@
+ TIRPC_CPPFLAGS		:= @TIRPC_CPPFLAGS@
+ TIRPC_LIBS		:= @TIRPC_LIBS@
+ KEYUTILS_LIBS		:= @KEYUTILS_LIBS@
++HAVE_FTS_H		:= @HAVE_FTS_H@
+
+ prefix			:= @prefix@
+
+diff --git a/m4/ltp-fts.m4 b/m4/ltp-fts.m4
+new file mode 100644
+index 000000000..0da692f23
+--- /dev/null
++++ b/m4/ltp-fts.m4
+@@ -0,0 +1,7 @@
++dnl SPDX-License-Identifier: GPL-2.0-or-later
++dnl Copyright (c) 2019 Petr Vorel <petr.vorel@gmail.com>
++
++AC_DEFUN([LTP_CHECK_FTS_H],[
++	AC_CHECK_HEADERS(fts.h, [have_fts=1])
++	AC_SUBST(HAVE_FTS_H, $have_fts)
++])
+diff --git a/testcases/kernel/controllers/Makefile b/testcases/kernel/controllers/Makefile
+index 404073947..548692cb8 100644
+--- a/testcases/kernel/controllers/Makefile
++++ b/testcases/kernel/controllers/Makefile
+@@ -29,6 +29,10 @@ LIBDIR			:= libcontrollers
+ LIB			:= $(LIBDIR)/libcontrollers.a
+ FILTER_OUT_DIRS		:= $(LIBDIR)
+
++ifneq ($(HAVE_FTS_H),1)
++	FILTER_OUT_DIRS += cpuset
++endif
++
+ $(LIBDIR):
+	mkdir -p "$@"
+
+--
+2.21.0
diff --git a/package/ltp-testsuite/0009-msgrcv-msgrcv08-Rename-struct-msgbuf.patch b/package/ltp-testsuite/0009-msgrcv-msgrcv08-Rename-struct-msgbuf.patch
new file mode 100644
index 0000000000..4e2c265a5a
--- /dev/null
+++ b/package/ltp-testsuite/0009-msgrcv-msgrcv08-Rename-struct-msgbuf.patch
@@ -0,0 +1,41 @@
+From ad87b4863cdcfad3dc05e2b023e849209473faa8 Mon Sep 17 00:00:00 2001
+From: Petr Vorel <petr.vorel@gmail.com>
+Date: Thu, 21 Mar 2019 21:46:17 +0100
+Subject: [PATCH] msgrcv/msgrcv08: Rename struct msgbuf
+
+According to man msgrcv(3) struct for user buffer should be defined by
+user. Therefore rename it as MUSL defines struct msgbuf in <sys/msg.h>
+under _BSD_SOURCE, so the name conflict.
+
+Reported-by: Dengke Du <dengke.du@windriver.com>
+Suggested-by: Cyril Hrubis <chrubis@suse.cz>
+Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
+---
+ testcases/kernel/syscalls/ipc/msgrcv/msgrcv08.c | 6 +++---
+ 1 file changed, 3 insertions(+), 3 deletions(-)
+
+diff --git a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv08.c b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv08.c
+index a757c0d18..1773a1bf4 100644
+--- a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv08.c
++++ b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv08.c
+@@ -48,15 +48,15 @@ const int TST_TOTAL = 1;
+
+ #if __WORDSIZE == 32
+
+-struct msgbuf {
++struct mbuf {
+	long mtype;     /* message type, must be > 0 */
+	char mtext[16]; /* message data */
+ };
+
+ static void msr(int msqid)
+ {
+-	struct msgbuf msbs;
+-	struct msgbuf msbr;
++	struct mbuf msbs;
++	struct mbuf msbr;
+	ssize_t sret;
+	long mtype = 121;
+
+--
+2.21.0
diff --git a/package/ltp-testsuite/0010-lapi-Define-TST_ABI-32-64-to-detect-target-type.patch b/package/ltp-testsuite/0010-lapi-Define-TST_ABI-32-64-to-detect-target-type.patch
new file mode 100644
index 0000000000..04dcc77ed2
--- /dev/null
+++ b/package/ltp-testsuite/0010-lapi-Define-TST_ABI-32-64-to-detect-target-type.patch
@@ -0,0 +1,604 @@
+From 9d9cfc754862340b918bbd1a83fdb5022edd1629 Mon Sep 17 00:00:00 2001
+From: Petr Vorel <petr.vorel@gmail.com>
+Date: Wed, 20 Mar 2019 21:57:22 +0100
+Subject: [PATCH] lapi: Define TST_ABI{,32,64} to detect target type
+
+and replace __WORDSIZE with them.
+
+Motivation was instead of finding, where all libc define __WORDSIZE,
+which is usually used for detecting target type (at least MUSL
+defines it in different place than other libc) we define our own
+constant.
+
++ change encoding of the comment in mem01.c to utf8 and use SPDX license
+identifier.
+
+Reported-by: Dengke Du <dengke.du@windriver.com>
+Suggested-by: Cyril Hrubis <chrubis@suse.cz>
+Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
+---
+Upstream-status: pending.
+---
+ include/lapi/abisize.h                        | 29 +++++++++----------
+ testcases/kernel/io/disktest/main.h           |  3 +-
+ .../kernel/mem/hugetlb/hugemmap/hugemmap02.c  |  3 +-
+ .../kernel/mem/hugetlb/hugemmap/hugemmap04.c  |  3 +-
+ .../mem/hugetlb/hugeshmat/hugeshmat02.c       |  3 +-
+ testcases/kernel/mem/mem/mem01.c              |  9 +++---
+ testcases/kernel/mem/mtest01/mtest01.c        |  1 +
+ testcases/kernel/mem/oom/oom01.c              |  3 +-
+ testcases/kernel/mem/oom/oom02.c              |  3 +-
+ testcases/kernel/mem/oom/oom03.c              |  3 +-
+ testcases/kernel/mem/oom/oom04.c              |  3 +-
+ testcases/kernel/mem/oom/oom05.c              |  3 +-
+ testcases/kernel/mem/swapping/swapping01.c    |  3 +-
+ .../kernel/mem/tunable/min_free_kbytes.c      |  5 ++--
+ .../kernel/mem/tunable/overcommit_memory.c    |  3 +-
+ testcases/kernel/mem/vma/vma03.c              |  3 +-
+ .../kernel/syscalls/fadvise/posix_fadvise03.c |  3 +-
+ .../kernel/syscalls/fallocate/fallocate02.c   |  3 +-
+ .../kernel/syscalls/fcntl/fcntl_common.h      |  3 +-
+ testcases/kernel/syscalls/fork/fork14.c       |  3 +-
+ .../kernel/syscalls/ipc/msgrcv/msgrcv08.c     |  3 +-
+ testcases/kernel/syscalls/mmap/mmap15.c       |  3 +-
+ testcases/kernel/syscalls/profil/profil01.c   |  3 +-
+ testcases/kernel/syscalls/sbrk/sbrk03.c       |  3 +-
+ .../kernel/syscalls/sendfile/sendfile09.c     |  3 +-
+ 25 files changed, 64 insertions(+), 43 deletions(-)
+
+diff --git a/include/lapi/abisize.h b/include/lapi/abisize.h
+index 897bdfdb6..9e6622ca1 100644
+--- a/include/lapi/abisize.h
++++ b/include/lapi/abisize.h
+@@ -1,25 +1,22 @@
++// SPDX-License-Identifier: GPL-2.0-or-later
+ /*
+- * Copyright (c) 2014 Linux Test Project
++ * Copyright (c) 2014-2019 Linux Test Project
+  *  Cyril Hrubis <chrubis@suse.cz>
+- *
+- * This program is free software; you can redistribute it and/or
+- * modify it under the terms of the GNU General Public License as
+- * published by the Free Software Foundation; either version 2 of
+- * the License, or (at your option) any later version.
+- *
+- * This program is distributed in the hope that it would be useful,
+- * but WITHOUT ANY WARRANTY; without even the implied warranty of
+- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+- * GNU General Public License for more details.
+- *
+- * You should have received a copy of the GNU General Public License
+- * along with this program; if not, write the Free Software Foundation,
+- * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
++ *  Petr Vorel <petr.vorel@gmail.com>
+  */
+
+ #ifndef ABISIZE_H__
+ #define ABISIZE_H__
+
++/* __WORDSIZE replacement */
++#if defined(__LP64__) || defined(_LP64)
++# define TST_ABI64
++# define TST_ABI 64
++#else
++# define TST_ABI32
++# define TST_ABI 32
++#endif
++
+ /*
+  * Determines if we have to split up 64 bit arguments or not
+  *
+@@ -29,6 +26,6 @@
+      (defined(__mips__) && _MIPS_SIM == _ABIN32) || \
+      (defined(__x86_64__) && defined(__ILP32__)) || \
+      (defined(__aarch64__) && defined(__ILP32__)) || \
+-     __WORDSIZE == 64
++     defined(TST_ABI64)
+
+ #endif /* ABISIZE_H__ */
+diff --git a/testcases/kernel/io/disktest/main.h b/testcases/kernel/io/disktest/main.h
+index 41fcd7315..8cab87c66 100644
+--- a/testcases/kernel/io/disktest/main.h
++++ b/testcases/kernel/io/disktest/main.h
+@@ -49,6 +49,7 @@
+ #include <time.h>
+ #include <errno.h>
+ #include "defs.h"
++#include "lapi/abisize.h"
+
+ #define VER_STR "v1.4.2"
+ #define BLKGETSIZE _IO(0x12,96)		/* IOCTL for getting the device size */
+@@ -64,7 +65,7 @@
+ /* the new way we align */
+ #define ALIGN(x, y) (((long long unsigned)x/(long long unsigned)y)*(long long unsigned)y)
+
+-#if __WORDSIZE == 64
++#ifdef TST_ABI64
+ /* the old way we use to align */
+ /* #define ALIGN(x, bs) (((OFF_T)x + ((OFF_T)bs - 1)) & ~((OFF_T)bs - 1)) */
+ #define BUFALIGN(x) (void *) (((unsigned long)x + (OFF_T)(ALIGNSIZE - 1)) & (OFF_T)~(ALIGNSIZE - 1))
+diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
+index 0be753e0d..9b0ab4e37 100644
+--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
++++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
+@@ -39,6 +39,7 @@
+ #include <sys/mount.h>
+ #include <limits.h>
+ #include <sys/param.h>
++#include "lapi/abisize.h"
+ #include "hugetlb.h"
+
+ #define LOW_ADDR       0x80000000
+@@ -100,7 +101,7 @@ static void test_hugemmap(void)
+	/* Attempt to mmap a huge page into a low memory address */
+	addr2 = mmap((void *)low_addr2, map_sz, PROT_READ | PROT_WRITE,
+			MAP_SHARED, fildes, 0);
+-#if __WORDSIZE == 64 /* 64-bit process */
++#ifdef TST_ABI64 /* 64-bit process */
+	if (addr2 == MAP_FAILED) {
+		tst_res(TFAIL | TERRNO, "huge mmap failed unexpectedly"
+				" with %s (64-bit)", TEMPFILE);
+diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
+index 674d367a4..55a3a24f4 100644
+--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
++++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
+@@ -38,6 +38,7 @@
+ #include <stdio.h>
+ #include <limits.h>
+ #include <sys/param.h>
++#include "lapi/abisize.h"
+ #include "hugetlb.h"
+
+ static struct tst_option options[] = {
+@@ -70,7 +71,7 @@ static void test_hugemmap(void)
+	huge_pagesize = SAFE_READ_MEMINFO("Hugepagesize:");
+	tst_res(TINFO, "Size of huge pages is %d KB", huge_pagesize);
+
+-#if __WORDSIZE == 32
++#ifdef TST_ABI32
+	tst_res(TINFO, "Total amount of free huge pages is %d",
+			freepages);
+	tst_res(TINFO, "Max number allowed for 1 mmap file in"
+diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c
+index 1c2c978c8..1cba867e5 100644
+--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c
++++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c
+@@ -36,9 +36,10 @@
+
+ #include <pwd.h>
+ #include <limits.h>
++#include "lapi/abisize.h"
+ #include "hugetlb.h"
+
+-#if __WORDSIZE == 64
++#ifdef TST_ABI64
+ #define NADDR	0x10000000eef	/* a 64bit non alligned address value */
+ #else
+ #define NADDR	0x60000eef	/* a non alligned address value */
+diff --git a/testcases/kernel/mem/mem/mem01.c b/testcases/kernel/mem/mem/mem01.c
+index f7642ab24..1bace3012 100644
+--- a/testcases/kernel/mem/mem/mem01.c
++++ b/testcases/kernel/mem/mem/mem01.c
+@@ -2,7 +2,7 @@
+  * mem01.c - Basic memory and swapper stress test
+  *
+  * Copyright (C) 2001 Stephane Fillod <f4cfe@free.fr>
+- * 	Original idea from Rene Cougnenc (on t'a pas oubli� mec)
++ * 	Original idea from Rene Cougnenc (on t'a pas oublié mec)
+  *
+  * Copyright (C) 2012 Cyril Hrubis <chrubis@suse.cz>
+  *
+@@ -39,6 +39,7 @@
+ #include <time.h>
+ #include <limits.h>
+
++#include "lapi/abisize.h"
+ #include "test.h"
+
+ /* in KB */
+@@ -114,13 +115,13 @@ size_t get_memsize(void)
+	res = res + freeswap;
+
+	tst_resm(TINFO, "Total Free:\t%llu Mb", res / 1024 / 1024);
+-#if defined (__s390__)
++#if defined(__s390__)
+	if (res > 1 * 1024 * 1024 * 1024)
+		res = 500 * 1024 * 1024;	/* s390's unique 31bit architecture needs smaller default */
+-#elif __WORDSIZE == 32
++#elif defined(TST_ABI32)
+	if (res > 1 * 1024 * 1024 * 1024)
+		res = 1 * 1024 * 1024 * 1024;
+-#elif __WORDSIZE == 64
++#elif defined(TST_ABI64)
+	if (res > (unsigned long long)3 * 1024 * 1024 * 1024)
+		res = (unsigned long long)3 *1024 * 1024 * 1024;
+ #endif
+diff --git a/testcases/kernel/mem/mtest01/mtest01.c b/testcases/kernel/mem/mtest01/mtest01.c
+index ca9073a8e..9bec03d00 100644
+--- a/testcases/kernel/mem/mtest01/mtest01.c
++++ b/testcases/kernel/mem/mtest01/mtest01.c
+@@ -42,6 +42,7 @@
+ #include <stdlib.h>
+ #include <unistd.h>
+
++#include "lapi/abisize.h"
+ #include "test.h"
+
+ #define FIVE_HUNDRED_MB (unsigned long long)(500*1024*1024)
+diff --git a/testcases/kernel/mem/oom/oom01.c b/testcases/kernel/mem/oom/oom01.c
+index beb232d45..258bfd89e 100644
+--- a/testcases/kernel/mem/oom/oom01.c
++++ b/testcases/kernel/mem/oom/oom01.c
+@@ -27,11 +27,12 @@
+ #include <stdio.h>
+ #include <stdlib.h>
+ #include <unistd.h>
++#include "lapi/abisize.h"
+ #include "mem.h"
+
+ static void verify_oom(void)
+ {
+-#if __WORDSIZE == 32
++#ifdef TST_ABI32
+	tst_brk(TCONF, "test is not designed for 32-bit system.");
+ #endif
+
+diff --git a/testcases/kernel/mem/oom/oom02.c b/testcases/kernel/mem/oom/oom02.c
+index 866540def..2b9bcb1b2 100644
+--- a/testcases/kernel/mem/oom/oom02.c
++++ b/testcases/kernel/mem/oom/oom02.c
+@@ -30,6 +30,7 @@
+ #include <numa.h>
+ #endif
+
++#include "lapi/abisize.h"
+ #include "numa_helper.h"
+ #include "mem.h"
+
+@@ -37,7 +38,7 @@
+
+ static void verify_oom(void)
+ {
+-#if __WORDSIZE == 32
++#ifdef TST_ABI32
+	tst_brk(TCONF, "test is not designed for 32-bit system.");
+ #endif
+
+diff --git a/testcases/kernel/mem/oom/oom03.c b/testcases/kernel/mem/oom/oom03.c
+index b283b5275..ce0b34c31 100644
+--- a/testcases/kernel/mem/oom/oom03.c
++++ b/testcases/kernel/mem/oom/oom03.c
+@@ -30,6 +30,7 @@
+ #include <numa.h>
+ #endif
+
++#include "lapi/abisize.h"
+ #include "numa_helper.h"
+ #include "mem.h"
+
+@@ -39,7 +40,7 @@ static int memcg_mounted;
+
+ static void verify_oom(void)
+ {
+-#if __WORDSIZE == 32
++#ifdef TST_ABI32
+	tst_brk(TCONF, "test is not designed for 32-bit system.");
+ #endif
+
+diff --git a/testcases/kernel/mem/oom/oom04.c b/testcases/kernel/mem/oom/oom04.c
+index 98b31c74a..7185ef973 100644
+--- a/testcases/kernel/mem/oom/oom04.c
++++ b/testcases/kernel/mem/oom/oom04.c
+@@ -30,6 +30,7 @@
+ #include <numa.h>
+ #endif
+
++#include "lapi/abisize.h"
+ #include "numa_helper.h"
+ #include "mem.h"
+
+@@ -39,7 +40,7 @@ static int cpuset_mounted;
+
+ static void verify_oom(void)
+ {
+-#if __WORDSIZE == 32
++#ifdef TST_ABI32
+	tst_brk(TCONF, "test is not designed for 32-bit system.");
+ #endif
+
+diff --git a/testcases/kernel/mem/oom/oom05.c b/testcases/kernel/mem/oom/oom05.c
+index c5395b0bb..db24df6de 100644
+--- a/testcases/kernel/mem/oom/oom05.c
++++ b/testcases/kernel/mem/oom/oom05.c
+@@ -30,6 +30,7 @@
+ #include <numa.h>
+ #endif
+
++#include "lapi/abisize.h"
+ #include "numa_helper.h"
+ #include "mem.h"
+
+@@ -42,7 +43,7 @@ static void verify_oom(void)
+ {
+	int swap_acc_on = 1;
+
+-#if __WORDSIZE == 32
++#ifdef TST_ABI32
+	tst_brk(TCONF, "test is not designed for 32-bit system.");
+ #endif
+
+diff --git a/testcases/kernel/mem/swapping/swapping01.c b/testcases/kernel/mem/swapping/swapping01.c
+index 6ac802b25..ff40c85c0 100644
+--- a/testcases/kernel/mem/swapping/swapping01.c
++++ b/testcases/kernel/mem/swapping/swapping01.c
+@@ -44,6 +44,7 @@
+ #include <stdlib.h>
+ #include <string.h>
+ #include <unistd.h>
++#include "lapi/abisize.h"
+ #include "mem.h"
+
+ /* allow swapping 1 * phy_mem in maximum */
+@@ -63,7 +64,7 @@ static pid_t pid;
+
+ static void test_swapping(void)
+ {
+-#if __WORDSIZE == 32
++#ifdef TST_ABI32
+	tst_brk(TCONF, "test is not designed for 32-bit system.");
+ #endif
+
+diff --git a/testcases/kernel/mem/tunable/min_free_kbytes.c b/testcases/kernel/mem/tunable/min_free_kbytes.c
+index f114dc493..09741eea3 100644
+--- a/testcases/kernel/mem/tunable/min_free_kbytes.c
++++ b/testcases/kernel/mem/tunable/min_free_kbytes.c
+@@ -34,6 +34,7 @@
+ #include <signal.h>
+ #include <stdio.h>
+ #include <stdlib.h>
++#include "lapi/abisize.h"
+ #include "mem.h"
+
+ #define MAP_SIZE (1UL<<20)
+@@ -126,14 +127,14 @@ static void test_tune(unsigned long overcommit_policy)
+					 status);
+		} else if (overcommit_policy == 1) {
+			if (!WIFSIGNALED(status) || WTERMSIG(status) != SIGKILL)
+-#if __WORDSIZE == 32
++#ifdef TST_ABI32
+			{
+				if (total_mem < 3145728UL)
+ #endif
+					tst_res(TFAIL,
+						 "child unexpectedly failed: %d",
+						 status);
+-#if __WORDSIZE == 32
++#ifdef TST_ABI32
+				/* in 32-bit system, a process allocate about 3Gb memory@most */
+				else
+					tst_res(TINFO, "Child can't allocate "
+diff --git a/testcases/kernel/mem/tunable/overcommit_memory.c b/testcases/kernel/mem/tunable/overcommit_memory.c
+index 07f824328..555298fbf 100644
+--- a/testcases/kernel/mem/tunable/overcommit_memory.c
++++ b/testcases/kernel/mem/tunable/overcommit_memory.c
+@@ -69,6 +69,7 @@
+ #include <stdio.h>
+ #include <stdlib.h>
+ #include <limits.h>
++#include "lapi/abisize.h"
+ #include "mem.h"
+
+ #define DEFAULT_OVER_RATIO	50L
+@@ -146,7 +147,7 @@ static void cleanup(void)
+ static void overcommit_memory_test(void)
+ {
+
+-#if __WORDSIZE == 32
++#ifdef TST_ABI32
+	tst_brk(TCONF, "test is not designed for 32-bit system.");
+ #endif
+	/* start to test overcommit_memory=2 */
+diff --git a/testcases/kernel/mem/vma/vma03.c b/testcases/kernel/mem/vma/vma03.c
+index 4b34ab0a0..65884d9d9 100644
+--- a/testcases/kernel/mem/vma/vma03.c
++++ b/testcases/kernel/mem/vma/vma03.c
+@@ -51,6 +51,7 @@
+ #include "test.h"
+ #include "safe_macros.h"
+ #include "tst_kernel.h"
++#include "lapi/abisize.h"
+
+ char *TCID = "vma03";
+ int TST_TOTAL = 1;
+@@ -72,7 +73,7 @@ int main(int argc, char *argv[])
+	void *map, *remap;
+	off_t pgoff;
+
+-	if (__WORDSIZE != 32 || tst_kernel_bits() != 32) {
++	if (TST_ABI != 32 || tst_kernel_bits() != 32) {
+		tst_brkm(TCONF, NULL,
+			 "test is designed for 32-bit system only.");
+	}
+diff --git a/testcases/kernel/syscalls/fadvise/posix_fadvise03.c b/testcases/kernel/syscalls/fadvise/posix_fadvise03.c
+index 0127a1b04..5bada5f3d 100644
+--- a/testcases/kernel/syscalls/fadvise/posix_fadvise03.c
++++ b/testcases/kernel/syscalls/fadvise/posix_fadvise03.c
+@@ -30,6 +30,7 @@
+
+ #include "tst_test.h"
+ #include "lapi/syscalls.h"
++#include "lapi/abisize.h"
+
+ char fname[] = "/bin/cat";	/* test executable to open */
+ int fd = -1;			/* initialized in open */
+@@ -41,7 +42,7 @@ int defined_advise[] = {
+	POSIX_FADV_SEQUENTIAL,
+	POSIX_FADV_RANDOM,
+	POSIX_FADV_WILLNEED,
+-#if defined(__s390__) && __WORDSIZE == 32
++#if defined(__s390__) && defined(TST_ABI32)
+	/* POSIX_FADV_DONTNEED and POSIX_FADV_NOREUSE are 6,7 on 31bit s390,
+	 * but the kernel accepts 4,5 as well and rewrites them internally,
+	 * see Linux kernel commit 068e1b94bbd268f375349f68531829c8b7c210bc
+diff --git a/testcases/kernel/syscalls/fallocate/fallocate02.c b/testcases/kernel/syscalls/fallocate/fallocate02.c
+index 4840eaf28..750ef4e49 100644
+--- a/testcases/kernel/syscalls/fallocate/fallocate02.c
++++ b/testcases/kernel/syscalls/fallocate/fallocate02.c
+@@ -41,6 +41,7 @@
+ #include "test.h"
+ #include "safe_macros.h"
+ #include "lapi/fallocate.h"
++#include "lapi/abisize.h"
+
+ #define BLOCKS_WRITTEN		12
+ #ifdef TEST_DEFAULT
+@@ -75,7 +76,7 @@ static struct test_data_t {
+	{&fdw, FNAMEW, DEFAULT_TEST_MODE, BLOCKS_WRITTEN, 0, EINVAL},
+	{&fdw, FNAMEW, DEFAULT_TEST_MODE, BLOCKS_WRITTEN, -1, EINVAL},
+	{&fdw, FNAMEW, DEFAULT_TEST_MODE, -(BLOCKS_WRITTEN+OFFSET), 1, EINVAL},
+-#if __WORDSIZE == 64 || _FILE_OFFSET_BITS == 64
++#if defined(TST_ABI64) || _FILE_OFFSET_BITS == 64
+	{&fdw, FNAMEW, DEFAULT_TEST_MODE, MAX_FILESIZE, 1, EFBIG},
+	{&fdw, FNAMEW, DEFAULT_TEST_MODE, 1, MAX_FILESIZE, EFBIG},
+ #endif
+diff --git a/testcases/kernel/syscalls/fcntl/fcntl_common.h b/testcases/kernel/syscalls/fcntl/fcntl_common.h
+index 07229a0f8..92beb0c68 100644
+--- a/testcases/kernel/syscalls/fcntl/fcntl_common.h
++++ b/testcases/kernel/syscalls/fcntl/fcntl_common.h
+@@ -1,4 +1,5 @@
+ #include "lapi/syscalls.h"
++#include "lapi/abisize.h"
+
+ /*
+  * glibc commit:
+@@ -16,7 +17,7 @@
+  * So, to support both version, on 32-bit we use fcntl64 syscall
+  * directly with struct flock64.
+  */
+-#if __WORDSIZE == 64 || _FILE_OFFSET_BITS == 64
++#if defined(TST_ABI64) || _FILE_OFFSET_BITS == 64
+ static int my_fcntl(int fd, int cmd, void *lck)
+ {
+	return SAFE_FCNTL(fd, cmd, lck);
+diff --git a/testcases/kernel/syscalls/fork/fork14.c b/testcases/kernel/syscalls/fork/fork14.c
+index 6ea92e0c2..a92aa46ad 100644
+--- a/testcases/kernel/syscalls/fork/fork14.c
++++ b/testcases/kernel/syscalls/fork/fork14.c
+@@ -35,6 +35,7 @@
+ #include <unistd.h>
+ #include "test.h"
+ #include "safe_macros.h"
++#include "lapi/abisize.h"
+
+ char *TCID = "fork14";
+ int TST_TOTAL = 1;
+@@ -60,7 +61,7 @@ int main(int ac, char **av)
+  * Tested on ppc64/x86_64/i386/s390x. And only 64bit has this issue.
+  * Since a 32bit program can't mmap so many memory.
+  */
+-#if __WORDSIZE == 32
++#ifdef TST_ABI32
+	tst_brkm(TCONF, NULL, "This test is only for 64bit.");
+ #endif
+	setup();
+diff --git a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv08.c b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv08.c
+index a757c0d18..af0f9b978 100644
+--- a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv08.c
++++ b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv08.c
+@@ -42,11 +42,12 @@
+ #include <sys/ipc.h>
+ #include <sys/msg.h>
+ #include "test.h"
++#include "lapi/abisize.h"
+
+ const char *TCID = "msgrcv08";
+ const int TST_TOTAL = 1;
+
+-#if __WORDSIZE == 32
++#ifdef TST_ABI32
+
+ struct msgbuf {
+	long mtype;     /* message type, must be > 0 */
+diff --git a/testcases/kernel/syscalls/mmap/mmap15.c b/testcases/kernel/syscalls/mmap/mmap15.c
+index c8a77873a..443a37eb8 100644
+--- a/testcases/kernel/syscalls/mmap/mmap15.c
++++ b/testcases/kernel/syscalls/mmap/mmap15.c
+@@ -36,6 +36,7 @@
+ #include <unistd.h>
+ #include "test.h"
+ #include "safe_macros.h"
++#include "lapi/abisize.h"
+
+ char *TCID = "mmap15";
+ int TST_TOTAL = 1;
+@@ -56,7 +57,7 @@ int main(int ac, char **av)
+	int lc, fd;
+	void *addr;
+
+-#if __WORDSIZE == 32
++#ifdef TST_ABI32
+	tst_brkm(TCONF, NULL, "This test is only for 64bit");
+ #endif
+
+diff --git a/testcases/kernel/syscalls/profil/profil01.c b/testcases/kernel/syscalls/profil/profil01.c
+index f1164021b..404f71517 100644
+--- a/testcases/kernel/syscalls/profil/profil01.c
++++ b/testcases/kernel/syscalls/profil/profil01.c
+@@ -27,6 +27,7 @@
+ #include <sys/types.h>
+ #include "test.h"
+ #include "safe_macros.h"
++#include "lapi/abisize.h"
+ #include "config.h"
+
+ char *TCID = "profil01";
+@@ -53,7 +54,7 @@ static void alrm_handler(int sig)
+
+ static void __attribute__ ((noinline)) *get_pc(void)
+ {
+-#if defined(__s390__) && __WORDSIZE == 32
++#if defined(__s390__) && defined(TST_ABI32)
+	/* taken from glibc,
+	 *   sysdeps/unix/sysv/linux/s390/s390-32/profil-counter.h
+	 * 31-bit s390 pointers don't use the 32th bit, however integers do,
+diff --git a/testcases/kernel/syscalls/sbrk/sbrk03.c b/testcases/kernel/syscalls/sbrk/sbrk03.c
+index 46fb2d111..85686245f 100644
+--- a/testcases/kernel/syscalls/sbrk/sbrk03.c
++++ b/testcases/kernel/syscalls/sbrk/sbrk03.c
+@@ -46,11 +46,12 @@
+
+ #include <stdio.h>
+ #include <unistd.h>
++#include "lapi/abisize.h"
+ #include "tst_test.h"
+
+ static void sbrk_test(void)
+ {
+-#if defined(__s390__) && __WORDSIZE == 32
++#if defined(__s390__) && defined(TST_ABI32)
+	void *ret1, *ret2;
+
+	/* set bkr to 0x10000000 */
+diff --git a/testcases/kernel/syscalls/sendfile/sendfile09.c b/testcases/kernel/syscalls/sendfile/sendfile09.c
+index 0a9d2553e..b9d9c8407 100644
+--- a/testcases/kernel/syscalls/sendfile/sendfile09.c
++++ b/testcases/kernel/syscalls/sendfile/sendfile09.c
+@@ -51,6 +51,7 @@
+ #include <inttypes.h>
+ #include "test.h"
+ #include "safe_macros.h"
++#include "lapi/abisize.h"
+
+ #ifndef OFF_T
+ #define OFF_T off_t
+@@ -170,7 +171,7 @@ int main(int ac, char **av)
+	int i;
+	int lc;
+
+-#if __WORDSIZE == 32
++#ifdef TST_ABI32
+	tst_brkm(TCONF, NULL, "This test is only for 64bit");
+ #endif
+
+--
+2.21.0
diff --git a/package/ltp-testsuite/Config.in b/package/ltp-testsuite/Config.in
index 711c859e6c..3d70499364 100644
--- a/package/ltp-testsuite/Config.in
+++ b/package/ltp-testsuite/Config.in
@@ -12,7 +12,6 @@ config BR2_PACKAGE_LTP_TESTSUITE
 	bool "ltp-testsuite"
 	depends on BR2_USE_MMU # fork()
 	depends on BR2_TOOLCHAIN_HAS_THREADS_NPTL
-	depends on !BR2_TOOLCHAIN_USES_MUSL
 	depends on BR2_PACKAGE_LTP_TESTSUITE_ARCH_SUPPORTS
 	select BR2_PACKAGE_LIBTIRPC if !BR2_TOOLCHAIN_HAS_NATIVE_RPC
 	help
@@ -23,4 +22,4 @@ config BR2_PACKAGE_LTP_TESTSUITE
 comment "ltp-testsuite needs a glibc or uClibc toolchain w/ NPTL"
 	depends on BR2_PACKAGE_LTP_TESTSUITE_ARCH_SUPPORTS
 	depends on BR2_USE_MMU
-	depends on !BR2_TOOLCHAIN_HAS_THREADS_NPTL || BR2_TOOLCHAIN_USES_MUSL
+	depends on !BR2_TOOLCHAIN_HAS_THREADS_NPTL
diff --git a/package/ltp-testsuite/ltp-testsuite.mk b/package/ltp-testsuite/ltp-testsuite.mk
index ebc386d0cf..5899061e8b 100644
--- a/package/ltp-testsuite/ltp-testsuite.mk
+++ b/package/ltp-testsuite/ltp-testsuite.mk
@@ -59,12 +59,45 @@ LTP_TESTSUITE_CONF_ENV += \
 
 # Requires uClibc fts and bessel support, normally not enabled
 ifeq ($(BR2_TOOLCHAIN_USES_UCLIBC),y)
-define LTP_TESTSUITE_REMOVE_UNSUPPORTED
-	rm -rf $(@D)/testcases/kernel/controllers/cpuset/
+define LTP_TESTSUITE_REMOVE_UNSUPPORTED_UCLIBC
 	rm -rf $(@D)/testcases/misc/math/float/bessel/
 	rm -f $(@D)/testcases/misc/math/float/float_bessel.c
 endef
-LTP_TESTSUITE_POST_PATCH_HOOKS += LTP_TESTSUITE_REMOVE_UNSUPPORTED
+LTP_TESTSUITE_POST_PATCH_HOOKS += LTP_TESTSUITE_REMOVE_UNSUPPORTED_UCLIBC
+else ifeq ($(BR2_TOOLCHAIN_USES_MUSL),y)
+define LTP_TESTSUITE_REMOVE_UNSUPPORTED_MUSL
+	rm -rf $(@D)/testcases/kernel/pty/pty01.c
+	rm -rf $(@D)/testcases/kernel/pty/pty02.c
+	rm -rf $(@D)/testcases/kernel/pty/ptem01.c
+	rm -rf $(@D)/testcases/kernel/sched/process_stress/process.c
+	rm -rf $(@D)/testcases/kernel/syscalls/accept4/accept4_01.c
+	rm -rf $(@D)/testcases/kernel/syscalls/confstr/confstr01.c
+	rm -rf $(@D)/testcases/kernel/syscalls/fmtmsg/fmtmsg01.c
+	rm -rf $(@D)/testcases/kernel/syscalls/getcontext/getcontext01.c
+	rm -rf $(@D)/testcases/kernel/syscalls/getdents/getdents01.c
+	rm -rf $(@D)/testcases/kernel/syscalls/getdents/getdents02.c
+	rm -rf $(@D)/testcases/kernel/syscalls/ioctl/ioctl01.c
+	rm -rf $(@D)/testcases/kernel/syscalls/ioctl/ioctl02.c
+	rm -rf $(@D)/testcases/kernel/syscalls/sched_getaffinity/sched_getaffinity01.c
+	rm -rf $(@D)/testcases/kernel/syscalls/setdomainname/setdomainname01.c
+	rm -rf $(@D)/testcases/kernel/syscalls/setdomainname/setdomainname02.c
+	rm -rf $(@D)/testcases/kernel/syscalls/sethostname/sethostname02.c
+	rm -rf $(@D)/testcases/misc/crash/crash01.c
+	rm -rf $(@D)/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_svcraw_create/
+	rm -rf $(@D)/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_svctcp_create/
+	rm -rf $(@D)/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_svctcp_create/
+	rm -rf $(@D)/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_svcudp_bufcreate/
+	rm -rf $(@D)/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_svcudp_create/
+	rm -rf $(@D)/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_svcudp_create/
+	rm -rf $(@D)/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunreg_registerrpc/
+	rm -rf $(@D)/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunreg_svc_register/
+	rm -rf $(@D)/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunreg_svc_unregister/
+	rm -rf $(@D)/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunreg_xprt_register/
+	rm -rf $(@D)/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunreg_xprt_unregister/
+	rm -rf $(@D)/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_auth_authdes_seccreate/
+	rm -rf $(@D)/utils/benchmark/ebizzy-0.3
+endef
+LTP_TESTSUITE_POST_PATCH_HOOKS += LTP_TESTSUITE_REMOVE_UNSUPPORTED_MUSL
 endif
 
 # ldd command build system tries to build a shared library unconditionally.
@@ -75,4 +108,7 @@ endef
 LTP_TESTSUITE_POST_PATCH_HOOKS += LTP_TESTSUITE_REMOVE_LDD
 endif
 
+# Required by 0008-cpuset-Detect-missing-fts.h.patch
+LTP_TESTSUITE_AUTORECONF = YES
+
 $(eval $(autotools-package))
-- 
2.21.0

