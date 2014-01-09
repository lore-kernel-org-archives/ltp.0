Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1W1Ic4-0004vL-4Y
	for ltp-list@lists.sourceforge.net; Thu, 09 Jan 2014 16:37:44 +0000
Date: Thu, 9 Jan 2014 17:37:16 +0100
From: chrubis@suse.cz
Message-ID: <20140109163716.GA8938@rei>
References: <1387358991.1664.37.camel@G08JYZSD130126>
	<20140109113619.GB5125@rei.Home>
	<1389269411.2149.8.camel@G08JYZSD130126>
	<201401090947.12749.vapier@gentoo.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
In-Reply-To: <201401090947.12749.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH???v3] lib/cloner.c: add function ltp_clone7 when
 clone supports???7 arguments
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Mike Frysinger <vapier@gentoo.org>
Cc: ltp-list@lists.sourceforge.net


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!
And here is a patch. (note that it should be applied over the two
allready commited patches)

-- 
Cyril Hrubis
chrubis@suse.cz

--OXfL5xGRrasGEqWY
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline;
	filename="0001-lib-cloner.c-add-ltp_clone7-and-fix-build.patch"

From eeb4ae48cb0dfcb3b89d1a368a8870dc5f35aae2 Mon Sep 17 00:00:00 2001
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Thu, 9 Jan 2014 20:10:11 +0800
Subject: [PATCH 1/2] lib/cloner.c: add ltp_clone7() and fix build

The seven argument clone breaks compilation on older distributions
(SLES10, RHEL4, etc.). It was introduced by commit 5f5cb63b7ddb.

This commit adds a configure check and ltp_clone7() library function.

Now the ltp_clone() is the same old ltp_clone() with five arguments and
ltp_clone7() is the new one with eight arguments (but it calls clone
with seven arguments, thus the name).

Tests that does not need the additional arguments should call the
ltp_clone() the rest should call ltp_clone7(). If seven argument clone
is not supproted the ltp_clone7() will return -1 and set errno to
ENOSYS.

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 configure.ac                              |  1 +
 include/test.h                            |  4 ++-
 lib/cloner.c                              | 55 ++++++++++++++++++++++---------
 m4/ltp-clone7args.m4                      | 38 +++++++++++++++++++++
 testcases/kernel/syscalls/clone/clone08.c |  9 +++--
 5 files changed, 88 insertions(+), 19 deletions(-)
 create mode 100644 m4/ltp-clone7args.m4

diff --git a/configure.ac b/configure.ac
index 4af7662..9e3df00 100644
--- a/configure.ac
+++ b/configure.ac
@@ -171,5 +171,6 @@ LTP_CHECK_FS_IOC_FLAGS
 LTP_CHECK_MREMAP_FIXED
 LTP_CHECK_KERNEL_DEVEL
 LTP_CHECK_XFS_QUOTACTL
+LTP_CHECK_CLONE_SUPPORTS_7_ARGS
 
 AC_OUTPUT
diff --git a/include/test.h b/include/test.h
index ffc1c8c..5211aea 100644
--- a/include/test.h
+++ b/include/test.h
@@ -199,7 +199,9 @@ void maybe_run_child(void (*child)(), char *fmt, ...);
 int self_exec(char *argv0, char *fmt, ...);
 
 /* Functions from lib/cloner.c */
-int ltp_clone(unsigned long clone_flags, int (*fn)(void *arg), void *arg,
+int ltp_clone(unsigned long flags, int (*fn)(void *arg), void *arg,
+		size_t stack_size, void *stack);
+int ltp_clone7(unsigned long flags, int (*fn)(void *arg), void *arg,
 		size_t stack_size, void *stack, ...);
 int ltp_clone_malloc(unsigned long clone_flags, int (*fn)(void *arg),
 		void *arg, size_t stacksize);
diff --git a/lib/cloner.c b/lib/cloner.c
index cb4dc6e..d6aa428 100644
--- a/lib/cloner.c
+++ b/lib/cloner.c
@@ -18,7 +18,7 @@
  */
 
 #ifndef _GNU_SOURCE
-#define _GNU_SOURCE
+# define _GNU_SOURCE
 #endif
 
 #include <stdio.h>
@@ -29,6 +29,7 @@
 #include <sched.h>
 #include <stdarg.h>
 #include "test.h"
+#include "config.h"
 
 #undef clone			/* we want to use clone() */
 
@@ -39,30 +40,25 @@ extern int __clone2(int (*fn) (void *arg), void *child_stack_base,
 		    pid_t *parent_tid, void *tls, pid_t *child_tid);
 #endif
 
+#ifndef CLONE_SUPPORTS_7_ARGS
+# define clone(fn, stack, flags, arg, ptid, tls, ctid) \
+         clone(fn, stack, flags, arg)
+#endif
+
 /*
  * ltp_clone: wrapper for clone to hide the architecture dependencies.
  *   1. hppa takes bottom of stack and no stacksize (stack grows up)
  *   2. __ia64__ takes bottom of stack and uses clone2
  *   3. all others take top of stack (stack grows down)
  */
-int
-ltp_clone(unsigned long clone_flags, int (*fn) (void *arg), void *arg,
-	  size_t stack_size, void *stack, ...)
+static int
+ltp_clone_(unsigned long flags, int (*fn)(void *arg), void *arg,
+	   size_t stack_size, void *stack, pid_t *ptid, void *tls, pid_t *ctid)
 {
 	int ret;
-	pid_t *parent_tid, *child_tid;
-	void *tls;
-	va_list arg_clone;
-
-	va_start(arg_clone, stack);
-	parent_tid = va_arg(arg_clone, pid_t *);
-	tls = va_arg(arg_clone, void *);
-	child_tid = va_arg(arg_clone, pid_t *);
-	va_end(arg_clone);
 
 #if defined(__ia64__)
-	ret = clone2(fn, stack, stack_size, clone_flags, arg,
-		     parent_tid, tls, child_tid);
+	ret = clone2(fn, stack, stack_size, flags, arg, ptid, tls, ctid);
 #else
 # if defined(__hppa__) || defined(__metag__)
 	/*
@@ -78,12 +74,39 @@ ltp_clone(unsigned long clone_flags, int (*fn) (void *arg), void *arg,
 		stack += stack_size;
 # endif
 
-	ret = clone(fn, stack, clone_flags, arg, parent_tid, tls, child_tid);
+	ret = clone(fn, stack, flags, arg, ptid, tls, ctid);
 #endif
 
 	return ret;
 }
 
+int ltp_clone(unsigned long flags, int (*fn)(void *arg), void *arg,
+              size_t stack_size, void *stack)
+{
+	return ltp_clone_(flags, fn, arg, stack_size, stack, NULL, NULL, NULL);
+}
+
+int ltp_clone7(unsigned long flags, int (*fn)(void *arg), void *arg,
+               size_t stack_size, void *stack, ...)
+{
+	pid_t *ptid, *ctid;
+	void *tls;
+	va_list arg_clone;
+
+	va_start(arg_clone, stack);
+	ptid = va_arg(arg_clone, pid_t *);
+	tls = va_arg(arg_clone, void *);
+	ctid = va_arg(arg_clone, pid_t *);
+	va_end(arg_clone);
+
+#ifdef CLONE_SUPPORTS_7_ARGS
+	return ltp_clone_(flags, fn, arg, stack_size, stack, ptid, tls, ctid);
+#else
+	errno = ENOSYS;
+	return -1;
+#endif
+}
+
 /*
  * ltp_clone_malloc: also does the memory allocation for clone with a
  * caller-specified size.
diff --git a/m4/ltp-clone7args.m4 b/m4/ltp-clone7args.m4
new file mode 100644
index 0000000..5857575
--- /dev/null
+++ b/m4/ltp-clone7args.m4
@@ -0,0 +1,38 @@
+dnl
+dnl Copyright (c) Linux Test Project, 2014
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
+dnl along with this program;  if not, write to the Free Software
+dnl Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+dnl
+
+dnl
+dnl LTP_CHECK_CLONE_SUPPORTS_7_ARGS
+dnl -------------------------------
+dnl
+AC_DEFUN([LTP_CHECK_CLONE_SUPPORTS_7_ARGS],[
+AH_TEMPLATE(CLONE_SUPPORTS_7_ARGS,
+[Define to 1 if clone() supports 7 arguments.])
+AC_MSG_CHECKING([if clone() supports 7 args])
+AC_TRY_LINK([#define _GNU_SOURCE
+		#include <sched.h>
+		#include <stdlib.h>],
+		[
+		#ifdef __ia64__
+		__clone2(NULL, NULL, 0, 0, NULL, NULL, NULL, NULL);
+		#else
+		clone(NULL, NULL, 0, NULL, NULL, NULL, NULL);
+		#endif
+		],
+		AC_DEFINE(CLONE_SUPPORTS_7_ARGS) AC_MSG_RESULT(yes), AC_MSG_RESULT(no))
+])
diff --git a/testcases/kernel/syscalls/clone/clone08.c b/testcases/kernel/syscalls/clone/clone08.c
index b098f4a..1258b4e 100644
--- a/testcases/kernel/syscalls/clone/clone08.c
+++ b/testcases/kernel/syscalls/clone/clone08.c
@@ -24,6 +24,8 @@
 #include "safe_macros.h"
 #include "linux_syscall_numbers.h"
 
+char *TCID = "clone08";
+
 static pid_t ptid, ctid, tgid;
 static void *child_stack;
 
@@ -76,7 +78,6 @@ static struct test_case {
 	 test_clone_thread, child_clone_thread},
 };
 
-char *TCID = "clone08";
 int TST_TOTAL = ARRAY_SIZE(test_cases);
 
 int main(int ac, char **av)
@@ -122,8 +123,12 @@ static void cleanup(void)
 
 static long clone_child(const struct test_case *t, int use_tst)
 {
-	TEST(ltp_clone(t->flags, t->do_child, NULL, CHILD_STACK_SIZE,
+	TEST(ltp_clone7(t->flags, t->do_child, NULL, CHILD_STACK_SIZE,
 		child_stack, &ptid, NULL, &ctid));
+
+	if (TEST_RETURN == -1 && TTERRNO == ENOSYS)
+		tst_brmk(TCONF, cleanup, "clone does not support 7 args");
+
 	if (TEST_RETURN == -1) {
 		if (use_tst) {
 			tst_brkm(TBROK | TTERRNO, cleanup, "%s clone() failed",
-- 
1.8.3.2


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
CenturyLink Cloud: The Leader in Enterprise Cloud Services.
Learn Why More Businesses Are Choosing CenturyLink Cloud For
Critical Workloads, Development Environments & Everything In Between.
Get a Quote or Start a Free Trial Today. 
http://pubads.g.doubleclick.net/gampad/clk?id=119420431&iu=/4140/ostg.clktrk
--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--OXfL5xGRrasGEqWY--

