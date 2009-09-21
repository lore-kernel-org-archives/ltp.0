Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <serge@us.ibm.com>) id 1MpryH-0000w1-2j
	for ltp-list@lists.sourceforge.net; Mon, 21 Sep 2009 23:07:01 +0000
Received: from e31.co.us.ibm.com ([32.97.110.149])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Mpry5-0007EX-Q8
	for ltp-list@lists.sourceforge.net; Mon, 21 Sep 2009 23:06:56 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n8LN0bLZ020262
	for <ltp-list@lists.sourceforge.net>; Mon, 21 Sep 2009 17:00:37 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n8LN6hse082546
	for <ltp-list@lists.sourceforge.net>; Mon, 21 Sep 2009 17:06:43 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n8LN6hKs017241
	for <ltp-list@lists.sourceforge.net>; Mon, 21 Sep 2009 17:06:43 -0600
Date: Mon, 21 Sep 2009 18:06:44 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
Message-ID: <20090921230644.GA30741@us.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [LTP] [PATCH RFC] ltp: define and use common clone helpers
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
Cc: Nathan T Lynch <natlynch@us.ibm.com>, Mike Frysinger <vapier@gentoo.org>

Define ltp_clone() and ltp_clone_malloc() in libltp, and convert existing
clone usages to them.  (clone04 can't use it bc it wants to pass NULL,
which ltp_clone() will for many arches convert to NULL+stacksize-1).

This seems to pass on my test system, but would need careful review and
ack before considering applying.

Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>
---
 include/test.h                                     |    8 ++
 lib/cloner.c                                       |   92 ++++++++++++++++++++
 testcases/kernel/containers/libclone/libclone.c    |   32 +-------
 testcases/kernel/containers/libclone/libclone.h    |   13 ---
 testcases/kernel/containers/libclone/libnetns.c    |   19 +----
 .../kernel/containers/mqns/check_mqns_enabled.c    |    2 +-
 .../kernel/containers/pidns/check_pidns_enabled.c  |    2 +-
 testcases/kernel/containers/pidns/pidns12.c        |    2 +-
 testcases/kernel/containers/pidns/pidns13.c        |    4 +-
 testcases/kernel/containers/pidns/pidns16.c        |    2 +-
 testcases/kernel/containers/pidns/pidns20.c        |    2 +-
 testcases/kernel/containers/pidns/pidns21.c        |    2 +-
 testcases/kernel/containers/pidns/pidns30.c        |    2 +-
 testcases/kernel/containers/pidns/pidns31.c        |    2 +-
 .../containers/sysvipc/check_ipcns_enabled.c       |   14 +---
 .../containers/utsname/check_utsns_enabled.c       |   16 +---
 .../kernel/controllers/cgroup/clone_platform.h     |   34 -------
 testcases/kernel/controllers/cgroup/test_6_2.c     |   14 +---
 testcases/kernel/fs/fs_bind/bin/Makefile           |   10 +--
 testcases/kernel/fs/fs_bind/bin/nsclone.c          |   19 +---
 .../tests/execshare/selinux_execshare_parent.c     |   18 +----
 testcases/kernel/security/tomoyo/newns.c           |    6 +-
 testcases/kernel/syscalls/clone/clone01.c          |   11 +--
 testcases/kernel/syscalls/clone/clone02.c          |   13 +---
 testcases/kernel/syscalls/clone/clone03.c          |   10 +--
 testcases/kernel/syscalls/clone/clone05.c          |   11 +--
 testcases/kernel/syscalls/clone/clone06.c          |   11 +--
 testcases/kernel/syscalls/clone/clone07.c          |   13 +---
 28 files changed, 140 insertions(+), 244 deletions(-)
 create mode 100644 lib/cloner.c
 delete mode 100644 testcases/kernel/controllers/cgroup/clone_platform.h

diff --git a/include/test.h b/include/test.h
index 864b8de..80ed458 100644
--- a/include/test.h
+++ b/include/test.h
@@ -245,6 +245,14 @@ int tst_cwd_has_free(int required_kib);
 void maybe_run_child(void (*child)(), char *fmt, ...);
 int self_exec(char *argv0, char *fmt, ...);
 
+/*
+ * Functions from lib/cloner.c
+ */
+int ltp_clone(unsigned long clone_flags, void *stack, int stack_size,
+		int (*fn)(void *arg), void *arg);
+int ltp_clone_malloc(unsigned long clone_flags, int (*fn)(void *arg),
+		void *arg);
+
 #ifdef TST_USE_COMPAT16_SYSCALL
 #define TCID_BIT_SUFFIX "_16"
 #elif  TST_USE_NEWER64_SYSCALL
diff --git a/lib/cloner.c b/lib/cloner.c
new file mode 100644
index 0000000..e9de1f4
--- /dev/null
+++ b/lib/cloner.c
@@ -0,0 +1,92 @@
+/*
+ * Copyright (c) International Business Machines Corp., 2009
+ * Some wrappers for clone functionality.  Thrown together by Serge Hallyn
+ * <serue@us.ibm.com> based on existing clone usage in ltp.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
+ * the GNU General Public License for more details.
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#include <stdio.h>
+#include <errno.h>
+#include <unistd.h> /* fork, getpid, sleep */
+#include <string.h>
+#include <stdlib.h> /* exit */
+
+/* copied from several other files under ltp */
+#if defined (__s390__) || (__s390x__)
+#define clone __clone
+extern int __clone(int(void*),void*,int,void*);
+#elif defined(__ia64__)
+#define clone2 __clone2
+/* Prototype provided by David Mosberger				*/
+/* int  __clone2(int (*fn) (void *arg), void *child_stack_base,		*/
+/* 		size_t child_stack_size, int flags, void *arg,		*/
+/*		pid_t *parent_tid, void *tls, pid_t *child_tid)		*/
+extern int  __clone2(int (*fn) (void *arg), void *child_stack_base, 
+		size_t child_stack_size, int flags, void *arg, 
+		pid_t *parent_tid, void *tls, pid_t *child_tid); 
+#endif
+/***********************************************************************
+ * ltp_clone: wrapper for clone to hide the architecture dependencies.
+ *   1. hppa takes bottom of stack and no stacksize
+ *   2. __ia64__ takes bottom of stack and uses clone2
+ *   3. all others take top of stack,
+ ***********************************************************************/
+int
+ltp_clone(unsigned long clone_flags, void *stack, int stack_size,
+		int (*fn)(void *arg), void *arg)
+{
+	int ret;
+
+#if defined(__hppa__)
+	ret = clone(fn, stack, clone_flags, arg);
+#elif defined(__ia64__)
+	ret = clone2(fn, stack, stack_size, clone_flags, arg, NULL, NULL, NULL);
+#else
+	ret = clone(fn, stack + stack_size - 1, clone_flags, arg);
+#endif
+
+	if (ret == -1)
+		perror("clone");
+
+	return ret;
+}
+
+/***********************************************************************
+ * ltp_clone_malloc: also does the memory allocation for clone.
+ * Experience thus far suggests that one page is often insufficient,
+ * while 4*getpagesize() seems adequate.
+ ***********************************************************************/
+int
+ltp_clone_malloc(unsigned long clone_flags, int (*fn)(void *arg), void *arg)
+{
+	int ret;
+	int stack_size = getpagesize() * 4;
+	void *stack = malloc (stack_size);
+
+	if (!stack) {
+		perror("malloc");
+		return -1;
+	}
+
+	ret = ltp_clone(clone_flags, stack, stack_size, fn, arg);
+
+	if (ret == -1) {
+		perror("clone");
+		free(stack);
+	}
+
+	return ret;
+}
+
diff --git a/testcases/kernel/containers/libclone/libclone.c b/testcases/kernel/containers/libclone/libclone.c
index c97d94b..710557b 100644
--- a/testcases/kernel/containers/libclone/libclone.c
+++ b/testcases/kernel/containers/libclone/libclone.c
@@ -16,43 +16,13 @@
 ***************************************************************************/
 #include "libclone.h"
 
-/* Serge: should I be passing in strings for error messages? */
-
-int do_clone(unsigned long clone_flags,
-			int(*fn1)(void *arg), void *arg1)
-{
-	int ret;
-	int stack_size = getpagesize() * 4;
-	void *stack = malloc (stack_size);
-
-	if (!stack) {
-		perror("malloc");
-		return -1;
-	}
-
-#if defined(__hppa__)
-	ret = clone(fn1, stack, clone_flags, arg1);
-#elif defined(__ia64__)
-	ret = clone2(fn1, stack, stack_size, clone_flags, arg1, NULL, NULL, NULL);
-#else
-	ret = clone(fn1, stack + stack_size, clone_flags, arg1);
-#endif
-
-	if (ret == -1) {
-		perror("clone");
-		free(stack);
-	}
-
-	return ret;
-}
-
 int do_clone_tests(unsigned long clone_flags,
 			int(*fn1)(void *arg), void *arg1,
 			int(*fn2)(void *arg), void *arg2)
 {
 	int ret;
 
-	ret = do_clone(clone_flags | SIGCHLD, fn1, arg1);
+	ret = ltp_clone_malloc(clone_flags | SIGCHLD, fn1, arg1);
 
 	if (ret == -1) {
 		return -1;
diff --git a/testcases/kernel/containers/libclone/libclone.h b/testcases/kernel/containers/libclone/libclone.h
index 621b941..7a5aa61 100644
--- a/testcases/kernel/containers/libclone/libclone.h
+++ b/testcases/kernel/containers/libclone/libclone.h
@@ -55,16 +55,6 @@
 #define __NR_unshare SYS_unshare
 #endif
 
-#if defined (__s390__) || (__s390x__)
-#define clone __clone
-extern int __clone(int(void*),void*,int,void*);
-#elif defined(__ia64__)
-#define clone2 __clone2
-extern int  __clone2(int (*fn) (void *arg), void *child_stack_base,
-                size_t child_stack_size, int flags, void *arg,
-                pid_t *parent_tid, void *tls, pid_t *child_tid);
-#endif
-
 #ifndef CLONE_NEWUTS
 #define CLONE_NEWUTS		0x04000000
 #endif
@@ -92,9 +82,6 @@ extern int create_net_namespace(char *, char *);
  * Fn2 may be NULL.
  */
 
-int do_clone(unsigned long clone_flags,
-			int(*fn1)(void *arg), void *arg1);
-
 int do_clone_tests(unsigned long clone_flags,
 			int(*fn1)(void *arg), void *arg1,
 			int(*fn2)(void *arg), void *arg2);
diff --git a/testcases/kernel/containers/libclone/libnetns.c b/testcases/kernel/containers/libclone/libnetns.c
index 821fec1..0a04d69 100644
--- a/testcases/kernel/containers/libclone/libnetns.c
+++ b/testcases/kernel/containers/libclone/libnetns.c
@@ -61,35 +61,20 @@ int create_net_namespace(char *p1, char *c1)
 	int pid, status = 0, ret;
 	char *ltproot, *par;
 	long int clone_flags = 0;
-	int stack_size = getpagesize() * 4;
-	void *childstack, *stack;
 
 	if (tst_kvercmp(2, 6, 19) < 0)
 		return 1;
 
-	stack = malloc(stack_size);
-	if (!stack) {
-		perror("failled to malloc memory for stack...");
-		return -1;
-	}
-	childstack = stack + stack_size;
-
 	clone_flags |= CLONE_NEWNS;
 /* Enable other namespaces too optionally */
 #ifdef CLONE_NEWPID
 	clone_flags |= CLONE_NEWPID;
 #endif
 
-#ifdef __ia64__
-	pid = clone2(child_fn, childstack, getpagesize(), clone_flags | SIGCHLD,
-						(void *)c1, NULL, NULL, NULL);
-#else
-	pid = clone(child_fn, childstack, clone_flags | SIGCHLD, (void *)c1);
-#endif
+	pid = ltp_clone_malloc(clone_flags, child_fn, (void *) c1);
 
 	if (pid == -1) {
-		perror("Failled to do clone...");
-		free(stack);
+		perror("Failed to do clone...");
 		return -1;
 	}
 
diff --git a/testcases/kernel/containers/mqns/check_mqns_enabled.c b/testcases/kernel/containers/mqns/check_mqns_enabled.c
index 169e8c9..dd86b7e 100644
--- a/testcases/kernel/containers/mqns/check_mqns_enabled.c
+++ b/testcases/kernel/containers/mqns/check_mqns_enabled.c
@@ -46,7 +46,7 @@ int main()
 	mq_close(mqd);
 	mq_unlink("/checkmqnsenabled");
 
-	pid = do_clone(CLONE_NEWIPC, dummy, NULL);
+	pid = ltp_clone_malloc(CLONE_NEWIPC, dummy, NULL);
 
 	if (pid == -1)
 		return 5;
diff --git a/testcases/kernel/containers/pidns/check_pidns_enabled.c b/testcases/kernel/containers/pidns/check_pidns_enabled.c
index 209dbb3..2d30de9 100644
--- a/testcases/kernel/containers/pidns/check_pidns_enabled.c
+++ b/testcases/kernel/containers/pidns/check_pidns_enabled.c
@@ -59,7 +59,7 @@ int main()
         if (tst_kvercmp(2,6,24) < 0)
                 return 1;
 
-        pid = do_clone(CLONE_NEWPID, dummy, NULL);
+        pid = ltp_clone_malloc(CLONE_NEWPID, dummy, NULL);
 
 	/* Check for the clone function return value */
         if (pid == -1)
diff --git a/testcases/kernel/containers/pidns/pidns12.c b/testcases/kernel/containers/pidns/pidns12.c
index 9120e82..5acf788 100644
--- a/testcases/kernel/containers/pidns/pidns12.c
+++ b/testcases/kernel/containers/pidns/pidns12.c
@@ -146,7 +146,7 @@ int main(int argc, char *argv[])
 		cleanup();
 	}
 
-	cpid = do_clone(CLONE_NEWPID|SIGCHLD, child_fn, NULL);
+	cpid = ltp_clone_malloc(CLONE_NEWPID|SIGCHLD, child_fn, NULL);
 	if (cpid < 0) {
 		tst_resm(TBROK, "parent: clone() failed(%s).",\
 				strerror(errno));
diff --git a/testcases/kernel/containers/pidns/pidns13.c b/testcases/kernel/containers/pidns/pidns13.c
index 01314b7..14f919b 100644
--- a/testcases/kernel/containers/pidns/pidns13.c
+++ b/testcases/kernel/containers/pidns/pidns13.c
@@ -213,11 +213,11 @@ int main(int argc, char *argv[])
 
 	/* Create container 1 */
 	*cinit_no = 1;
-	cpid1 = do_clone(CLONE_NEWPID|SIGCHLD, child_fn, cinit_no);
+	cpid1 = ltp_clone_malloc(CLONE_NEWPID|SIGCHLD, child_fn, cinit_no);
 
 	/* Create container 2 */
 	*cinit_no = 2;
-	cpid2 = do_clone(CLONE_NEWPID|SIGCHLD, child_fn, cinit_no);
+	cpid2 = ltp_clone_malloc(CLONE_NEWPID|SIGCHLD, child_fn, cinit_no);
 	if (cpid1 < 0 || cpid2 < 0) {
 		tst_resm(TBROK, "parent: clone() failed.");
 		cleanup();
diff --git a/testcases/kernel/containers/pidns/pidns16.c b/testcases/kernel/containers/pidns/pidns16.c
index c76bc22..97fb6c2 100644
--- a/testcases/kernel/containers/pidns/pidns16.c
+++ b/testcases/kernel/containers/pidns/pidns16.c
@@ -129,7 +129,7 @@ int main(int argc, char *argv[])
 
 	globalpid = getpid();
 
-	cpid = do_clone(CLONE_NEWPID | SIGCHLD, child_fn, NULL);
+	cpid = ltp_clone_malloc(CLONE_NEWPID | SIGCHLD, child_fn, NULL);
 
 	if (cpid < 0) {
 		tst_resm(TBROK, "clone() failed.");
diff --git a/testcases/kernel/containers/pidns/pidns20.c b/testcases/kernel/containers/pidns/pidns20.c
index f7bf5a5..4ccfcb3 100644
--- a/testcases/kernel/containers/pidns/pidns20.c
+++ b/testcases/kernel/containers/pidns/pidns20.c
@@ -180,7 +180,7 @@ int main(int argc, char *argv[])
 		cleanup();
 	}
 
-	cpid = do_clone(CLONE_NEWPID|SIGCHLD, child_fn, NULL);
+	cpid = ltp_clone_malloc(CLONE_NEWPID|SIGCHLD, child_fn, NULL);
 	if (cpid < 0) {
 		tst_resm(TBROK, "parent: clone() failed(%s)",\
 				strerror(errno));
diff --git a/testcases/kernel/containers/pidns/pidns21.c b/testcases/kernel/containers/pidns/pidns21.c
index 152349d..ba17a2d 100644
--- a/testcases/kernel/containers/pidns/pidns21.c
+++ b/testcases/kernel/containers/pidns/pidns21.c
@@ -182,7 +182,7 @@ int main(int argc, char *argv[])
 		cleanup();
 	}
 
-	cpid = do_clone(CLONE_NEWPID|SIGCHLD, child_fn, NULL);
+	cpid = ltp_clone_malloc(CLONE_NEWPID|SIGCHLD, child_fn, NULL);
 	if (cpid < 0) {
 		tst_resm(TBROK, "parent: clone() failed(%s)",\
 				strerror(errno));
diff --git a/testcases/kernel/containers/pidns/pidns30.c b/testcases/kernel/containers/pidns/pidns30.c
index 6e5ab3b..1d783c5 100644
--- a/testcases/kernel/containers/pidns/pidns30.c
+++ b/testcases/kernel/containers/pidns/pidns30.c
@@ -299,7 +299,7 @@ int main(int argc, char *argv[])
 	tst_resm(TINFO, "parent: successfully created posix mqueue");
 
 	/* container creation on PID namespace */
-	cpid = do_clone(CLONE_NEWPID|SIGCHLD, child_fn, NULL);
+	cpid = ltp_clone_malloc(CLONE_NEWPID|SIGCHLD, child_fn, NULL);
 	if (cpid < 0) {
 		tst_resm(TBROK, "parent: clone() failed(%s)", strerror(errno));
 		cleanup(TBROK, F_STEP_2, mqd);
diff --git a/testcases/kernel/containers/pidns/pidns31.c b/testcases/kernel/containers/pidns/pidns31.c
index 8459043..b81c744 100644
--- a/testcases/kernel/containers/pidns/pidns31.c
+++ b/testcases/kernel/containers/pidns/pidns31.c
@@ -269,7 +269,7 @@ int main(int argc, char *argv[])
 	tst_resm(TINFO, "parent: successfully created posix mqueue");
 
 	/* container creation on PID namespace */
-	cpid = do_clone(CLONE_NEWPID|SIGCHLD, child_fn, NULL);
+	cpid = ltp_clone_malloc(CLONE_NEWPID|SIGCHLD, child_fn, NULL);
 	if (cpid < 0) {
 		tst_resm(TBROK, "parent: clone() failed(%s)", strerror(errno));
 		cleanup(TBROK, F_STEP_1, mqd);
diff --git a/testcases/kernel/containers/sysvipc/check_ipcns_enabled.c b/testcases/kernel/containers/sysvipc/check_ipcns_enabled.c
index 3d9b74a..4f955fe 100644
--- a/testcases/kernel/containers/sysvipc/check_ipcns_enabled.c
+++ b/testcases/kernel/containers/sysvipc/check_ipcns_enabled.c
@@ -26,24 +26,12 @@ int dummy(void *v)
 }
 int main()
 {
-        void *childstack, *stack;
         int pid;
 
         if (tst_kvercmp(2,6,19) < 0)
                 return 1;
-        stack = malloc(getpagesize());
-        if (!stack) {
-                perror("malloc");
-                return 2;
-        }
 
-        childstack = stack + getpagesize();
-
-#ifdef __ia64__
-        pid = clone2(dummy, childstack, getpagesize(), CLONE_NEWIPC, NULL, NULL, NULL, NULL);
-#else
-        pid = clone(dummy, childstack, CLONE_NEWIPC, NULL);
-#endif
+	pid = ltp_clone_malloc(CLONE_NEWIPC, dummy, NULL);
 
         if (pid == -1)
                 return 3;
diff --git a/testcases/kernel/containers/utsname/check_utsns_enabled.c b/testcases/kernel/containers/utsname/check_utsns_enabled.c
index 80b9f47..385c7be 100644
--- a/testcases/kernel/containers/utsname/check_utsns_enabled.c
+++ b/testcases/kernel/containers/utsname/check_utsns_enabled.c
@@ -61,25 +61,11 @@ int kernel_version_newenough()
 #endif  /* Library is already provided by LTP*/
 int main()
 {
-	void *childstack, *stack;
 	int pid;
 
 	//if (!kernel_version_newenough())
-	if (tst_kvercmp(2,6,19) < 0)
-		return 1;
-	stack = malloc(getpagesize());
-	if (!stack) {
-		perror("malloc");
-		return 2;
-	}
-
-	childstack = stack + getpagesize();
 
-#ifdef __ia64__
-	pid = clone2(dummy, childstack, getpagesize(), CLONE_NEWUTS, NULL, NULL, NULL, NULL);
-#else
-	pid = clone(dummy, childstack, CLONE_NEWUTS, NULL);
-#endif
+	pid = ltp_clone_malloc(CLONE_NEWUTS, dummy, NULL);
 
 	if (pid == -1)
 		return 3;
diff --git a/testcases/kernel/controllers/cgroup/clone_platform.h b/testcases/kernel/controllers/cgroup/clone_platform.h
deleted file mode 100644
index 1785dd1..0000000
--- a/testcases/kernel/controllers/cgroup/clone_platform.h
+++ /dev/null
@@ -1,34 +0,0 @@
-/*
- * Copyright (c) 2003 Silicon Graphics, Inc.  All Rights Reserved.
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
- * with this program; if not, write the Free Software Foundation, Inc., 59
- * Temple Place - Suite 330, Boston MA 02111-1307, USA.
- *
- */
-/* Common platform specific defines for the clone system call tests */
-
-//#define CHILD_STACK_SIZE 8192
-#define CHILD_STACK_SIZE 16384
-
-#if defined (__s390__) || (__s390x__)
-#define clone __clone
-extern int __clone(int(void*),void*,int,void*);
-#elif defined(__ia64__)
-#define clone2 __clone2
-/* Prototype provided by David Mosberger				*/
-/* int  __clone2(int (*fn) (void *arg), void *child_stack_base,		*/
-/* 		size_t child_stack_size, int flags, void *arg,		*/
-/*		pid_t *parent_tid, void *tls, pid_t *child_tid)		*/
-extern int  __clone2(int (*fn) (void *arg), void *child_stack_base, 
-		size_t child_stack_size, int flags, void *arg, 
-		pid_t *parent_tid, void *tls, pid_t *child_tid); 
-#endif
diff --git a/testcases/kernel/controllers/cgroup/test_6_2.c b/testcases/kernel/controllers/cgroup/test_6_2.c
index 79f5c20..da8b5ff 100644
--- a/testcases/kernel/controllers/cgroup/test_6_2.c
+++ b/testcases/kernel/controllers/cgroup/test_6_2.c
@@ -24,8 +24,6 @@
 #include <unistd.h>
 #include <sched.h>
 
-#include "clone_platform.h"
-
 #define DEFAULT_USEC	30000
 
 int foo(void __attribute__((unused)) *arg)
@@ -33,8 +31,6 @@ int foo(void __attribute__((unused)) *arg)
 	return 0;
 }
 
-char *stack[4096];
-
 int main(int argc, char **argv)
 {
 	int usec = DEFAULT_USEC;
@@ -44,15 +40,7 @@ int main(int argc, char **argv)
 
 	while (1) {
 		usleep(usec);
-#if defined(__hppa__)
-		clone(foo, stack, CLONE_NEWNS, NULL);
-#elif defined(__ia64__)
-		clone2(foo, stack,
-			    4096, CLONE_NEWNS, NULL, NULL, NULL, NULL);
-#else
-		clone
-		     (foo, stack + 4096, CLONE_NEWNS, NULL);
-#endif
+		ltp_clone_malloc(CLONE_NEWNS, foo, NULL);
 	}
 
 	return 0;
diff --git a/testcases/kernel/fs/fs_bind/bin/Makefile b/testcases/kernel/fs/fs_bind/bin/Makefile
index 0fac9d6..45bf489 100644
--- a/testcases/kernel/fs/fs_bind/bin/Makefile
+++ b/testcases/kernel/fs/fs_bind/bin/Makefile
@@ -2,10 +2,8 @@
 
 LTP_SRC_ROOT=../../../../..
 LTP_BIN=$(LTP_SRC_ROOT)/testcases/bin
-#CFLAGS+= -I$(LTP_SRC_ROOT)/include -Wall -g
-CFLAGS+= -Wall -g
-#LIBS+= -L$(LTP_SRC_ROOT)/lib -lltp
-LIBS+=
+CFLAGS+= -I$(LTP_SRC_ROOT)/include -Wall -g
+LIBS+= -L$(LTP_SRC_ROOT)/lib -lltp
 
 all: smount nsclone
 
@@ -19,10 +17,10 @@ uninstall:
 	@/bin/true
 
 nsclone: nsclone.c
-	$(CC) $(CFLAGS) $(LIBS) -o nsclone nsclone.c
+	$(CC) $(CFLAGS) -o nsclone nsclone.c $(LIBS)
 
 smount: smount.c
-	$(CC) $(CFLAGS) $(LIBS) -o smount smount.c
+	$(CC) $(CFLAGS) -o smount smount.c
 
 clean:
 	rm -f smount nsclone
diff --git a/testcases/kernel/fs/fs_bind/bin/nsclone.c b/testcases/kernel/fs/fs_bind/bin/nsclone.c
index f3b3eec..c67e5a0 100644
--- a/testcases/kernel/fs/fs_bind/bin/nsclone.c
+++ b/testcases/kernel/fs/fs_bind/bin/nsclone.c
@@ -22,18 +22,10 @@
 #include <sched.h>
 #include <signal.h>
 #include <unistd.h>
+#include <test.h>
 #include <sys/types.h>
 #include <sys/wait.h>
 
-#ifdef __ia64__
-#define clone2 __clone2
-extern int  __clone2(int (*fn) (void *arg), void *child_stack_base,
-		     size_t child_stack_size, int flags, void *arg,
-		     pid_t *parent_tid, void *tls, pid_t *child_tid);
-#endif
-
-char somemem[4096];
-
 int myfunc(void *arg){
 	return system(arg);
 }
@@ -59,12 +51,9 @@ int main(int argc, char *argv[])
 	parent_cmd = (char *)strdup(argv[1]);
 
 	printf("1\n");
-#ifdef __ia64__
-	if (clone2(myfunc, somemem, getpagesize(), CLONE_NEWNS|SIGCHLD,
-		   child_cmd, NULL, NULL, NULL) != -1) {
-#else
-	if (clone(myfunc, somemem, CLONE_NEWNS|SIGCHLD, child_cmd) != -1) {
-#endif
+	ret = ltp_clone_malloc(CLONE_NEWNS|SIGCHLD, myfunc,
+				(void *)child_cmd);
+	if (ret != -1) {
 		system(parent_cmd);
 		wait(&childret);
 	} else {
diff --git a/testcases/kernel/security/selinux-testsuite/tests/execshare/selinux_execshare_parent.c b/testcases/kernel/security/selinux-testsuite/tests/execshare/selinux_execshare_parent.c
index dc02f02..031f86f 100644
--- a/testcases/kernel/security/selinux-testsuite/tests/execshare/selinux_execshare_parent.c
+++ b/testcases/kernel/security/selinux-testsuite/tests/execshare/selinux_execshare_parent.c
@@ -28,8 +28,6 @@ int clone_fn(char **argv)
 
 int main(int argc, char **argv)
 {
-	int pagesize;
-	void *clone_stack, *page;
 	int pid, rc, len, status, cloneflags;
 	security_context_t context_s;
 	context_t context;
@@ -45,14 +43,6 @@ int main(int argc, char **argv)
 		exit(-1);
 	}
 
-	pagesize = getpagesize();
-	page = malloc(pagesize);
-	if (!page) {
-		perror("malloc");
-		exit(-1);
-	}
-	clone_stack = page + pagesize;
-
 	rc = getcon(&context_s);
 	if (rc < 0) {
 		fprintf(stderr, "%s:  unable to get my context\n", argv[0]);
@@ -83,13 +73,7 @@ int main(int argc, char **argv)
 		fprintf(stderr, "%s:  unable to set exec context to %s\n", argv[0], context_s);
 		exit(-1);
 	}
-#if defined(__hppa__)
-	pid = clone(clone_fn, page, cloneflags | SIGCHLD, argv);
-#elif defined(__ia64__)
-	pid = __clone2(clone_fn, clone_stack, pagesize, cloneflags | SIGCHLD, argv, NULL, NULL, NULL);
-#else
-	pid = clone(clone_fn, clone_stack, cloneflags | SIGCHLD, argv);
-#endif
+	pid = ltp_clone_malloc(cloneflags | SIGCHLD, child_fn, argv);
 	if (pid < 0) {
 		perror("clone");
 		exit(-1);
diff --git a/testcases/kernel/security/tomoyo/newns.c b/testcases/kernel/security/tomoyo/newns.c
index a212e47..60ede96 100644
--- a/testcases/kernel/security/tomoyo/newns.c
+++ b/testcases/kernel/security/tomoyo/newns.c
@@ -38,9 +38,9 @@ static int child(void *arg)
 int main(int argc, char *argv[])
 {
 	char c = 0;
-	char *stack = malloc(8192);
-	const pid_t pid = clone(child, stack + (8192 / 2), CLONE_NEWNS,
-				(void *) argv);
+	const pid_t pid;
+	
+	pid = ltp_clone_malloc(CLONE_NEWNS, child, (void *) argv);
 	while (waitpid(pid, NULL, __WALL) == EOF && errno == EINTR)
 		c++; /* Dummy. */
 	return 0;
diff --git a/testcases/kernel/syscalls/clone/clone01.c b/testcases/kernel/syscalls/clone/clone01.c
index 1ebe411..4eae155 100644
--- a/testcases/kernel/syscalls/clone/clone01.c
+++ b/testcases/kernel/syscalls/clone/clone01.c
@@ -120,15 +120,8 @@ int main(int ac, char **av)
 		/*
 		 * Call clone(2)
 		 */
-#if defined(__hppa__)
-		TEST(clone(do_child, child_stack, SIGCHLD, NULL));
-#elif defined(__ia64__)
-		TEST(clone2(do_child, child_stack,
-			    CHILD_STACK_SIZE, SIGCHLD, NULL, NULL, NULL, NULL));
-#else
-		TEST(clone
-		     (do_child, child_stack + CHILD_STACK_SIZE, SIGCHLD, NULL));
-#endif
+		TEST(ltp_clone(SIGCHLD, child_stack, CHILD_STACK_SIZE,
+			do_child, NULL));
 
 again:
 		if ((child_pid = wait(&status)) == -1)
diff --git a/testcases/kernel/syscalls/clone/clone02.c b/testcases/kernel/syscalls/clone/clone02.c
index 03de57f..25112d6 100644
--- a/testcases/kernel/syscalls/clone/clone02.c
+++ b/testcases/kernel/syscalls/clone/clone02.c
@@ -190,17 +190,8 @@ int main(int ac, char **av)
 			}
 
 			/* Test the system call */
-#if defined(__hppa__)
-			TEST(clone(child_fn, child_stack,
-				   test_cases[i].flags, NULL));
-#elif defined(__ia64__)
-			TEST(clone2(child_fn, child_stack,
-				    CHILD_STACK_SIZE, test_cases[i].flags, NULL,
-				    NULL, NULL, NULL));
-#else
-			TEST(clone(child_fn, child_stack + CHILD_STACK_SIZE,
-				   test_cases[i].flags, NULL));
-#endif
+			TEST(ltp_clone(test_cases[i].flags, child_stack,
+				CHILD_STACK_SIZE, child_fn, NULL));
 
 			/* check return code */
 			if (TEST_RETURN == -1) {
diff --git a/testcases/kernel/syscalls/clone/clone03.c b/testcases/kernel/syscalls/clone/clone03.c
index 9ffff52..d93be12 100644
--- a/testcases/kernel/syscalls/clone/clone03.c
+++ b/testcases/kernel/syscalls/clone/clone03.c
@@ -125,14 +125,8 @@ int main(int ac, char **av)
 		/*
 		 * Call clone(2)
 		 */
-#if defined(__hppa__)
-		TEST(clone(child_fn, child_stack, 0, NULL));
-#elif defined(__ia64__)
-		TEST(clone2(child_fn, child_stack,
-			    CHILD_STACK_SIZE, 0, NULL, NULL, NULL, NULL));
-#else
-		TEST(clone(child_fn, child_stack + CHILD_STACK_SIZE, 0, NULL));
-#endif
+		TEST(ltp_clone(0, child_stack, CHILD_STACK_SIZE, child_fn,
+				NULL));
 
 		/* check return code */
 		if (TEST_RETURN == -1) {
diff --git a/testcases/kernel/syscalls/clone/clone05.c b/testcases/kernel/syscalls/clone/clone05.c
index d4baeef..369d433 100644
--- a/testcases/kernel/syscalls/clone/clone05.c
+++ b/testcases/kernel/syscalls/clone/clone05.c
@@ -119,15 +119,8 @@ int main(int ac, char **av)
 		/*
 		 * Call clone(2)
 		 */
-#if defined(__hppa__)
-		TEST(clone(child_fn, child_stack, FLAG, NULL));
-#elif defined(__ia64__)
-		TEST(clone2(child_fn, child_stack,
-			    CHILD_STACK_SIZE, FLAG, NULL, NULL, NULL, NULL));
-#else
-		TEST(clone
-		     (child_fn, child_stack + CHILD_STACK_SIZE, FLAG, NULL));
-#endif
+		TEST(ltp_clone(FLAG, child_stack, CHILD_STACK_SIZE, child_fn,
+				NULL));
 
 		/* check return code & parent_variable */
 		if ((TEST_RETURN != -1) && (parent_variable)) {
diff --git a/testcases/kernel/syscalls/clone/clone06.c b/testcases/kernel/syscalls/clone/clone06.c
index 1414fe6..6b1b038 100644
--- a/testcases/kernel/syscalls/clone/clone06.c
+++ b/testcases/kernel/syscalls/clone/clone06.c
@@ -132,15 +132,8 @@ int main(int ac, char **av)
 		/*
 		 * Call clone(2)
 		 */
-#if defined(__hppa__)
-		TEST(clone(child_environ, child_stack, 0, NULL));
-#elif defined(__ia64__)
-		TEST(clone2(child_environ, child_stack,
-			    CHILD_STACK_SIZE, 0, NULL, NULL, NULL, NULL));
-#else
-		TEST(clone
-		     (child_environ, child_stack + CHILD_STACK_SIZE, 0, NULL));
-#endif
+		TEST(ltp_clone(0, child_stack, CHILD_STACK_SIZE,
+			child_environ, NULL));
 
 		/* check return code */
 		if (TEST_RETURN == -1) {
diff --git a/testcases/kernel/syscalls/clone/clone07.c b/testcases/kernel/syscalls/clone/clone07.c
index 03434f5..3ac9a4d 100644
--- a/testcases/kernel/syscalls/clone/clone07.c
+++ b/testcases/kernel/syscalls/clone/clone07.c
@@ -126,17 +126,8 @@ int main(int ac, char **av)
 		/*
 		 * Call clone(2)
 		 */
-#if defined(__hppa__)
-		child_pid = clone(do_child, child_stack, SIGCHLD, NULL);
-#elif defined(__ia64__)
-		child_pid = clone2(do_child, child_stack,
-				   CHILD_STACK_SIZE, SIGCHLD, NULL,
-				   NULL, NULL, NULL);
-#else
-		child_pid =
-		    (clone
-		     (do_child, child_stack + CHILD_STACK_SIZE, SIGCHLD, NULL));
-#endif
+		child_pid = ltp_clone(SIGCHLD, child_stack, CHILD_STACK_SIZE,
+			do_child, NULL);
 		wait(NULL);
 		free(child_stack);
 	}			/* End for TEST_LOOPING */
-- 
1.6.1.1


------------------------------------------------------------------------------
Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#33;
http://p.sf.net/sfu/devconf
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
