From: Petr Vorel <pvorel@suse.cz>
Date: Tue,  8 Dec 2020 14:28:14 +0100
Subject: [LTP] [PATCH 1/1] syscalls/get_mempolicy01: Rewrite to new API
Message-ID: <20201208132814.16497-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Also finally remove common_j_h.c and include_j_h.h,
which are no longer needed.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

not sure if invalid address is no longer meaningful (after removing
fix for ia64 and use NULL).

I also removed check for __NR_get_mempolicy. Originally added in LTP in
07e750af6 (2012), but that was added in kernel before 2.6.12-rc2.

Kind regards,
Petr

 .../syscalls/get_mempolicy/get_mempolicy01.c  | 489 ++++++++----------
 testcases/kernel/syscalls/utils/common_j_h.c  | 260 ----------
 testcases/kernel/syscalls/utils/include_j_h.h | 143 -----
 3 files changed, 216 insertions(+), 676 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/utils/common_j_h.c
 delete mode 100644 testcases/kernel/syscalls/utils/include_j_h.h

diff --git a/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c b/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c
index fcb677986..d530e2bad 100644
--- a/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c
+++ b/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c
@@ -1,320 +1,263 @@
-/******************************************************************************/
-/* Copyright (c) Crackerjack Project., 2007-2008 ,Hitachi, Ltd		      */
-/*	Author(s): Takahiro Yasui <takahiro.yasui.mp@hitachi.com>,	      */
-/*		   Yumiko Sugita <yumiko.sugita.yf@hitachi.com>,	      */
-/*		   Satoshi Fujiwara <sa-fuji@sdl.hitachi.co.jp>		      */
-/*									      */
-/* This program is free software;  you can redistribute it and/or modify      */
-/* it under the terms of the GNU General Public License as published by	      */
-/* the Free Software Foundation; either version 2 of the License, or	      */
-/* (at your option) any later version.					      */
-/*									      */
-/* This program is distributed in the hope that it will be useful,	      */
-/* but WITHOUT ANY WARRANTY;  without even the implied warranty of	      */
-/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See		      */
-/* the GNU General Public License for more details.			      */
-/*									      */
-/* You should have received a copy of the GNU General Public License	      */
-/* along with this program;  if not, write to the Free Software		      */
-/* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    */
-/*									      */
-/******************************************************************************/
-/******************************************************************************/
-/*									      */
-/* File:	get_mempolicy01.c					      */
-/*									      */
-/* Description: This tests the get_mempolicy() syscall			      */
-/*									      */
-/* Usage:  <for command-line>						      */
-/* get_mempolicy01 [-c n] [-e][-i n] [-I x] [-p x] [-t]			      */
-/*	where,	-c n : Run n copies concurrently.			      */
-/*		-e   : Turn on errno logging.				      */
-/*		-i n : Execute test n times.				      */
-/*		-I x : Execute test for x seconds.			      */
-/*		-P x : Pause for x seconds between iterations.		      */
-/*		-t   : Turn on syscall timing.				      */
-/*									      */
-/* Total Tests: 1							      */
-/*									      */
-/* Test Name:	get_mempolicy01						      */
-/* History:	Porting from Crackerjack to LTP is done by		      */
-/*		Manas Kumar Nayak maknayak@in.ibm.com>			      */
-/******************************************************************************/
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 Petr Vorel <pvorel@suse.cz>
+ * Copyright (c) Linux Test Project, 2009-2020
+ * Copyright (c) Crackerjack Project, 2007-2008, Hitachi, Ltd
+ *
+ * Authors:
+ * Takahiro Yasui <takahiro.yasui.mp@hitachi.com>
+ * Yumiko Sugita <yumiko.sugita.yf@hitachi.com>
+ * Satoshi Fujiwara <sa-fuji@sdl.hitachi.co.jp>
+ * Manas Kumar Nayak <maknayak@in.ibm.com> (original port to the legacy API)
+ */
 
 #include "config.h"
-#include <sys/types.h>
-#include <sys/mman.h>
-#include <getopt.h>
-#include <string.h>
-#include <stdlib.h>
-#include <errno.h>
-#include <stdio.h>
-#include <unistd.h>
-#include <libgen.h>
-#if HAVE_NUMA_H
+#include "tst_test.h"
+
+#ifdef HAVE_NUMA_V2
 #include <numa.h>
-#endif
-#if HAVE_NUMAIF_H
 #include <numaif.h>
-#endif
 
-#include "test.h"
-#include "lapi/syscalls.h"
-#include "include_j_h.h"
-#include "common_j_h.c"
+#include <errno.h>
 #include "numa_helper.h"
-
-char *TCID = "get_mempolicy01";
-int TST_TOTAL = 1;
-
-#ifdef HAVE_NUMA_V2
+#include "tst_numa.h"
+#include "lapi/syscalls.h"
 
 #define MEM_LENGTH	(4 * 1024 * 1024)
 
-static int testno;
+#define POLICY_DESC(x) .policy = x, .desc = "policy: "#x
+#define POLICY_DESC_TEXT(x, y) .policy = x, .desc = "policy: "#x", "y
+#define POLICY_DESC_FLAGS(x, y) .policy = x, .flags = y, .desc = "policy: "#x", flags: "#y
+#define POLICY_DESC_FLAGS_TEXT(x, y, z) .policy = x, .flags = y, .desc = "policy: "#x", flags: "#y", "z
 
-enum test_type {
-	DEFAULT,		/* get default policy */
-	ADDR,			/* get policy of memory which include mapped address */
-	INVALID_POINTER,
-	INVALID_FLAGS,
-};
+static struct bitmask *nodemask, *getnodemask, *empty_nodemask;
 
-enum from_node {
-	NONE,
-	SELF,
-};
+static void test_set_mempolicy_default(unsigned int i);
+static void test_set_mempolicy_none(unsigned int i);
+static int test_mbind_none(unsigned int i);
+static int test_mbind_default(unsigned int i);
+static int set_invalid_addr(unsigned int i);
 
 struct test_case {
-	int ttype;
 	int policy;
-	int from_node;
+	const char *desc;
+	unsigned int flags;
 	int ret;
 	int err;
+	char *addr;
+	int (*pre_test)(unsigned int i);
+	void (*test)(unsigned int i);
+	struct bitmask **exp_nodemask;
 };
 
-/* Test cases
- *
- *   test status of errors on man page
- *
- *   (NONE)	     man page hadn't been completed.
- *
- *   test status of errors NOT on man page
- *
- *   EFAULT	     v (invalid address)
- *   EINVAL	     v (invalid parameters)
- */
 static struct test_case tcase[] = {
-	{			/* case00 */
-	 .ttype = DEFAULT,
-	 .policy = MPOL_DEFAULT,
-	 .from_node = NONE,
-	 .ret = 0,
-	 .err = 0,
-	 },
-	{			/* case01 */
-	 .ttype = DEFAULT,
-	 .policy = MPOL_BIND,
-	 .from_node = SELF,
-	 .ret = 0,
-	 .err = 0,
-	 },
-	{			/* case02 */
-	 .ttype = DEFAULT,
-	 .policy = MPOL_INTERLEAVE,
-	 .from_node = SELF,
-	 .ret = 0,
-	 .err = 0,
-	 },
-	{			/* case03 */
-	 .ttype = DEFAULT,
-	 .policy = MPOL_PREFERRED,
-	 .from_node = NONE,
-	 .ret = 0,
-	 .err = 0,
-	 },
-	{			/* case04 */
-	 .ttype = DEFAULT,
-	 .policy = MPOL_PREFERRED,
-	 .from_node = SELF,
-	 .ret = 0,
-	 .err = 0,
-	 },
-	{			/* case05 */
-	 .ttype = ADDR,
-	 .policy = MPOL_DEFAULT,
-	 .from_node = NONE,
-	 .ret = 0,
-	 .err = 0,
-	 },
-	{			/* case06 */
-	 .ttype = ADDR,
-	 .policy = MPOL_BIND,
-	 .from_node = SELF,
-	 .ret = 0,
-	 .err = 0,
-	 },
-	{			/* case07 */
-	 .ttype = ADDR,
-	 .policy = MPOL_INTERLEAVE,
-	 .from_node = SELF,
-	 .ret = 0,
-	 .err = 0,
-	 },
-	{			/* case08 */
-	 .ttype = ADDR,
-	 .policy = MPOL_PREFERRED,
-	 .from_node = NONE,
-	 .ret = 0,
-	 .err = 0,
-	 },
-	{			/* case09 */
-	 .ttype = ADDR,
-	 .policy = MPOL_PREFERRED,
-	 .from_node = SELF,
-	 .ret = 0,
-	 .err = 0,
-	 },
-	{			/* case10 */
-	 .ttype = INVALID_POINTER,
-	 .policy = MPOL_DEFAULT,
-	 .from_node = NONE,
-	 .ret = -1,
-	 .err = EFAULT,
-	 },
-	{			/* case11 */
-	 .ttype = INVALID_FLAGS,
-	 .policy = MPOL_DEFAULT,
-	 .from_node = NONE,
-	 .ret = -1,
-	 .err = EINVAL,
-	 },
+	{
+		POLICY_DESC_TEXT(MPOL_DEFAULT, "no target"),
+		.ret = 0,
+		.err = 0,
+		.test = test_set_mempolicy_none,
+		.exp_nodemask = &empty_nodemask,
+	},
+	{
+		POLICY_DESC(MPOL_BIND),
+		.ret = 0,
+		.err = 0,
+		.test = test_set_mempolicy_default,
+	},
+	{
+		POLICY_DESC(MPOL_INTERLEAVE),
+		.ret = 0,
+		.err = 0,
+		.test = test_set_mempolicy_default,
+		.exp_nodemask = &nodemask,
+	},
+	{
+		POLICY_DESC_TEXT(MPOL_PREFERRED, "no target"),
+		.ret = 0,
+		.err = 0,
+		.test = test_set_mempolicy_none,
+		.exp_nodemask = &nodemask,
+	},
+	{
+		.test = test_set_mempolicy_default,
+		POLICY_DESC(MPOL_PREFERRED),
+		.ret = 0,
+		.err = 0,
+	},
+	{
+		POLICY_DESC_FLAGS_TEXT(MPOL_DEFAULT, MPOL_F_ADDR, "no target"),
+		.ret = 0,
+		.err = 0,
+		.pre_test = test_mbind_none,
+		.test = test_set_mempolicy_none,
+		.exp_nodemask = &nodemask,
+	},
+	{
+		POLICY_DESC_FLAGS(MPOL_BIND, MPOL_F_ADDR),
+		.pre_test = test_mbind_default,
+		.ret = 0,
+		.err = 0,
+	},
+	{
+		POLICY_DESC_FLAGS(MPOL_INTERLEAVE, MPOL_F_ADDR),
+		.ret = 0,
+		.err = 0,
+		.pre_test = test_mbind_default,
+		.test = test_set_mempolicy_default,
+		.exp_nodemask = &nodemask,
+	},
+	{
+		POLICY_DESC_FLAGS_TEXT(MPOL_PREFERRED, MPOL_F_ADDR, "no target"),
+		.ret = 0,
+		.err = 0,
+		.pre_test = test_mbind_none,
+		.test = test_set_mempolicy_none,
+		.exp_nodemask = &nodemask,
+	},
+	{
+		POLICY_DESC_FLAGS(MPOL_PREFERRED, MPOL_F_ADDR),
+		.ret = 0,
+		.err = 0,
+		.pre_test = test_mbind_default,
+		.test = test_set_mempolicy_default,
+	},
+	{
+		.flags = MPOL_F_ADDR,
+		POLICY_DESC_TEXT(MPOL_DEFAULT, "invalid address"),
+		.ret = -1,
+		.err = EFAULT,
+		.pre_test = set_invalid_addr,
+		.exp_nodemask = &nodemask,
+	},
+	{
+		POLICY_DESC_TEXT(MPOL_DEFAULT, "invalid flags, no target"),
+		.flags = -1,
+		.ret = -1,
+		.err = EINVAL,
+		.test = test_set_mempolicy_none,
+		.exp_nodemask = &nodemask,
+	},
 };
 
-static int do_test(struct test_case *tc);
-static void setup(void);
-static void cleanup(void);
+static void test_set_mempolicy_default(unsigned int i)
+{
+	struct test_case *tc = &tcase[i];
+
+	TEST(set_mempolicy(tc->policy, nodemask->maskp, nodemask->size));
+}
 
-int main(int argc, char **argv)
+static void test_set_mempolicy_none(unsigned int i)
 {
-	int i, ret, lc;
+	struct test_case *tc = &tcase[i];
 
-	setup();
+	TEST(set_mempolicy(tc->policy, NULL, 0));
+}
+
+static int test_mbind(unsigned int i, unsigned long *maskp, unsigned long size)
+{
+	struct test_case *tc = &tcase[i];
 
-	ret = 0;
-	testno = (int)ARRAY_SIZE(tcase);
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
+	tc->addr = SAFE_MMAP(NULL, MEM_LENGTH, PROT_READ | PROT_WRITE,
+			     MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
 
-		for (i = 0; i < testno; i++) {
-			tst_resm(TINFO, "(case%02d) START", i);
-			ret = do_test(&tcase[i]);
-			tst_resm((ret == 0 ? TPASS : TFAIL | TERRNO),
-				 "(case%02d) END", i);
-		}
+	TEST(mbind(tc->addr, MEM_LENGTH, tc->policy, maskp, size, 0));
+
+	if (TST_RET < 0) {
+		tst_res(TFAIL | TERRNO, "mbind() failed");
+		return -1;
 	}
 
-	cleanup();
-	tst_exit();
+	return 0;
 }
 
-static int do_test(struct test_case *tc)
+static int test_mbind_none(unsigned int i)
 {
-	int ret, err, result, cmp_ok;
-	int policy, flags;
-	struct bitmask *nodemask = numa_allocate_nodemask();
-	struct bitmask *getnodemask = numa_allocate_nodemask();
-	char *p = NULL;
-	unsigned long len = MEM_LENGTH;
-	int test_node = -1;
+	return test_mbind(i, NULL, 0);
+}
 
-	ret = get_allowed_nodes(NH_MEMS, 1, &test_node);
-	if (ret < 0)
-		tst_brkm(TBROK | TERRNO, cleanup, "get_allowed_nodes: %d", ret);
-	numa_bitmask_setbit(nodemask, test_node);
-	switch (tc->ttype) {
-	case DEFAULT:
-		flags = 0;
-		p = NULL;
-		if (tc->from_node == NONE)
-			TEST(ltp_syscall(__NR_set_mempolicy, tc->policy,
-				NULL, 0));
-		else
-			TEST(ltp_syscall(__NR_set_mempolicy, tc->policy,
-				nodemask->maskp, nodemask->size));
-		if (TEST_RETURN < 0) {
-			tst_resm(TBROK | TERRNO, "set_mempolicy");
-			return -1;
-		}
+static int test_mbind_default(unsigned int i)
+{
+	return test_mbind(i, nodemask->maskp, nodemask->size);
+}
 
-		break;
-	default:
-		flags = MPOL_F_ADDR;
-		p = mmap(NULL, len, PROT_READ | PROT_WRITE,
-			 MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
-		if (p == MAP_FAILED)
-			tst_brkm(TBROK | TERRNO, cleanup, "mmap");
-		if (tc->from_node == NONE)
-			TEST(ltp_syscall(__NR_mbind, p, len, tc->policy,
-				NULL, 0, 0));
-		else
-			TEST(ltp_syscall(__NR_mbind, p, len, tc->policy,
-				nodemask->maskp, nodemask->size, 0));
-		if (TEST_RETURN < 0) {
-			tst_resm(TBROK | TERRNO, "mbind");
-			return -1;
-		}
+static int set_invalid_addr(unsigned int i)
+{
+	struct test_case *tc = &tcase[i];
+	int ret;
 
-		if (tc->ttype == INVALID_POINTER)
-#ifdef __ia64__
-			p = (char *)0x8000000000000000UL;
-#else
-			p = 0;
-#endif
+	ret = test_mbind_none(i);
+	tc->addr = NULL;
 
-		if (tc->ttype == INVALID_FLAGS)
-			flags = -1;
-	}
-	errno = 0;
-	cmp_ok = 1;
-	TEST(ret = ltp_syscall(__NR_get_mempolicy, &policy, getnodemask->maskp,
-			   getnodemask->size, p, flags));
-	err = TEST_ERRNO;
-	if (ret < 0)
-		goto TEST_END;
-
-	/* if policy == MPOL_DEFAULT, get_mempolicy doesn't return nodemask */
-	if (tc->policy == MPOL_DEFAULT)
-		numa_bitmask_clearall(nodemask);
-	cmp_ok = (tc->policy == policy && (tc->from_node == NONE ||
-					   numa_bitmask_equal(nodemask,
-							      getnodemask)));
-TEST_END:
-	result = (err != tc->err) || !cmp_ok;
-	PRINT_RESULT_CMP(0, tc->ret, tc->err, ret, err, cmp_ok);
-	return result;
+	return ret;
 }
 
-static void cleanup(void)
+
+static void setup(void)
 {
-	tst_rmdir();
+	if (!is_numa(NULL, NH_MEMS, 1))
+		tst_brk(TCONF, "requires NUMA with at least 1 node");
 }
 
-static void setup(void)
+static void setup_node(void)
 {
-	/* check syscall availability */
-	ltp_syscall(__NR_get_mempolicy, NULL, NULL, 0, NULL, 0);
+	int test_node = -1;
 
-	if (!is_numa(NULL, NH_MEMS, 1))
-		tst_brkm(TCONF, NULL, "requires NUMA with at least 1 node");
+	if (get_allowed_nodes(NH_MEMS, 1, &test_node) < 0)
+		tst_brk(TBROK | TERRNO, "get_allowed_nodes failed");
 
-	TEST_PAUSE;
-	tst_tmpdir();
+	nodemask = numa_allocate_nodemask();
+	getnodemask = numa_allocate_nodemask();
+	numa_bitmask_setbit(nodemask, test_node);
 }
 
-#else
-int main(void)
+static void do_test(unsigned int i)
 {
-	tst_brkm(TCONF, NULL, NUMA_ERROR_MSG);
+	struct test_case *tc = &tcase[i];
+	int policy;
+
+	tst_res(TINFO, "test #%d: %s", (i+1), tc->desc);
+
+	setup_node();
+
+	if (tc->pre_test)
+		if (tc->pre_test(i) == -1)
+			return;
+
+	if (tc->test) {
+		tc->test(i);
+
+		if (TST_RET < 0) {
+			tst_res(TFAIL | TERRNO, ".test failed");
+			return;
+		}
+	}
+
+	TEST(get_mempolicy(&policy, getnodemask->maskp, getnodemask->size,
+			   tc->addr, tc->flags));
+
+	if (TST_RET == -1 && tc->policy == MPOL_DEFAULT)
+		numa_bitmask_clearall(nodemask);
+
+	if (tc->ret != TST_RET) {
+		tst_res(TFAIL, "wrong return code: %ld, expected: %d",
+			TST_RET, tc->ret);
+		return;
+	}
+	if (TST_RET == -1 && TST_ERR != tc->err) {
+		tst_res(TFAIL | TTERRNO, "expected errno: %s, got",
+			tst_strerrno(tc->err));
+		return;
+	}
+
+	tst_res(TPASS, "Test passed");
 }
-#endif
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tcase),
+	.test = do_test,
+	.setup = setup,
+};
+
+#else
+TST_TEST_TCONF(NUMA_ERROR_MSG);
+#endif /* HAVE_NUMA_V2 */
diff --git a/testcases/kernel/syscalls/utils/common_j_h.c b/testcases/kernel/syscalls/utils/common_j_h.c
deleted file mode 100644
index dbdbc117a..000000000
--- a/testcases/kernel/syscalls/utils/common_j_h.c
+++ /dev/null
@@ -1,260 +0,0 @@
-/*
- * Crackerjack Project
- *
- * Copyright (C) 2007-2008, Hitachi, Ltd.
- * Author(s): Yumiko Sugita <yumiko.sugita.yf@hitachi.com>,
- *            Satoshi Fujiwara <sa-fuji@sdl.hitachi.co.jp>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version 2
- * of the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
- *
- * $Id: common_j_h.c,v 1.5 2009/11/20 06:48:31 yaberauneya Exp $
- *
- */
-#include <stdio.h>
-#include <unistd.h>
-#include <sys/types.h>
-#include <sys/wait.h>
-#include <sys/stat.h>
-#include <sys/time.h>
-#include <sys/resource.h>
-#include <fcntl.h>
-#include <pwd.h>
-#include <signal.h>
-#include <stdlib.h>
-#include <string.h>
-#include <errno.h>
-#include <mqueue.h>
-#include "include_j_h.h"
-#include "test.h"
-
-#define barrier() __asm__ __volatile__("": : :"memory")
-#define WITH_SIGNALS_BLOCKED(code) {					\
-		sigset_t held_sigs_;					\
-		sigfillset(&held_sigs_);				\
-		sigprocmask(SIG_SETMASK, &held_sigs_, &held_sigs_);	\
-		barrier();						\
-		code;							\
-		barrier();						\
-		sigprocmask(SIG_SETMASK, &held_sigs_, NULL);		\
-	}
-
-/*
- * Change user ID
- *
- *   We assume 'test' executable is executed with 'root' permission.
- *   So, if you use this function, you can not return 'root' uid.
- */
-int setup_uid(char *uname)
-{
-	struct passwd *pw;
-	int rc;
-
-	pw = getpwnam(uname);
-	if (!pw) {
-		EPRINTF("getpwnam failed.\n");
-		return -1;
-	}
-	rc = setuid(pw->pw_uid);
-	if (rc < 0) {
-		EPRINTF("setuid failed.\n");
-		return -1;
-	}
-	return 0;
-}
-
-/*
- * Change effective user ID
- */
-int setup_euid(char *uname, uid_t * old_uid)
-{
-	struct passwd *pw;
-	int rc;
-
-	*old_uid = geteuid();
-	pw = getpwnam(uname);
-	if (!pw) {
-		EPRINTF("getpwnam failed.\n");
-		return -1;
-	}
-	rc = seteuid(pw->pw_uid);
-	if (rc < 0) {
-		EPRINTF("seteuid failed.\n");
-		return -1;
-	}
-	return 0;
-}
-
-int cleanup_euid(uid_t old_uid)
-{
-	int rc;
-
-	rc = seteuid(old_uid);
-	if (rc < 0) {
-		EPRINTF("seteuid failed.\n");
-		return -1;
-	}
-	return 0;
-}
-
-static void sigterm_handler(int sig)
-{
-	_exit(0);
-}
-
-/*
- * Generate a child process which will send a signal
- */
-pid_t create_sig_proc(unsigned long usec, int sig, unsigned count)
-{
-	pid_t pid, cpid;
-
-	pid = getpid();
-	WITH_SIGNALS_BLOCKED(if ((cpid = fork()) == 0) {
-			     tst_sig(NOFORK, SIG_DFL, NULL);
-			     signal(SIGTERM, sigterm_handler);}
-	) ;
-	switch (cpid) {
-	case 0:
-		while (count-- > 0) {
-			usleep(usec);
-			if (kill(pid, sig) == -1)
-				break;
-		}
-		_exit(0);
-		break;
-	case -1:
-		EPRINTF("fork failed.\n");
-		return cpid;
-	default:
-		return cpid;
-	}
-}
-
-/*
- * Create and delete test file
- */
-int setup_file(char *testdir, char *fname, char *path)
-{
-	return _setup_file(testdir, fname, path,
-			   O_CREAT | O_EXCL | O_RDWR, S_IRUSR | S_IWUSR);
-}
-
-int _setup_file(char *testdir, char *fname, char *path, int flags, mode_t mode)
-{
-	int rc;
-
-	sprintf(path, "%s/%s", testdir, fname);
-	rc = open(path, flags, mode);
-	if (rc < 0) {
-		EPRINTF("open failed.\n");
-		return -1;
-	}
-	return rc;
-}
-
-int cleanup_file(char *path)
-{
-	unlink(path);
-	return 0;
-}
-
-/*
- * Create and delete swap file
- */
-/* swap file needs to be more than 40KB */
-#define MIN_SWAPFILE_SIZE	(64 * 1024)
-int setup_swapfile(char *testdir, char *fname, char *path, size_t size)
-{
-	int fd = -1, rc;
-	size_t r_sz;
-	int cmdlen = 256;
-	char cmd[cmdlen];
-	char *p = NULL;
-
-	sprintf(path, "%s/%s", testdir, fname);
-	fd = open(path, O_CREAT | O_EXCL | O_RDWR, S_IRUSR | S_IWUSR);
-	if (fd < 0) {
-		EPRINTF("open failed.\n");
-		goto ERR_EXIT;
-	}
-	if (size < MIN_SWAPFILE_SIZE) {
-		EPRINTF("size too short.\n");
-		goto ERR_EXIT;
-	}
-	p = malloc(size);
-	if (!p) {
-		EPRINTF("malloc failed.\n");
-		goto ERR_EXIT;
-	}
-	/* Swap file must not have hole area */
-	memset(p, 0x5a, size);
-	r_sz = (size_t) write(fd, p, size);
-	if (r_sz != size) {
-		EPRINTF("write failed.\n");
-		goto ERR_EXIT;
-	}
-	snprintf(cmd, cmdlen, "/sbin/mkswap %s > /dev/null 2>&1", path);
-	rc = system(cmd);
-	if (rc != 0) {
-		EPRINTF("system(%s) failed.\n", cmd);
-		goto ERR_EXIT;
-	}
-	return fd;
-
-ERR_EXIT:
-	if (fd >= 0)
-		close(fd);
-	if (p)
-		free(p);
-	return -1;
-}
-
-int cleanup_swapfile(char *path)
-{
-	unlink(path);
-	return 0;
-}
-
-#if 0
-/*
- * Check max nodes from /sys/devices/system/node/node* files (for NUMA)
- */
-int get_max_nodes(void)
-{
-	/* We assume that there is only one node */
-	return 1;
-}
-#endif
-
-/*
- * Get unexist pid
- */
-pid_t get_unexist_pid(void)
-{
-	pid_t pid;
-	int st;
-
-	pid = fork();
-	switch (pid) {
-	case -1:
-		EPRINTF("fork failed.\n");
-		return -1;
-	case 0:
-		_exit(0);
-	default:
-		wait(&st);
-		return pid;
-	}
-}
diff --git a/testcases/kernel/syscalls/utils/include_j_h.h b/testcases/kernel/syscalls/utils/include_j_h.h
deleted file mode 100644
index 742d96401..000000000
--- a/testcases/kernel/syscalls/utils/include_j_h.h
+++ /dev/null
@@ -1,143 +0,0 @@
-/*
- * Crackerjack Project
- *
- * Copyright (C) 2007-2008, Hitachi, Ltd.
- * Author(s): Takahiro Yasui <takahiro.yasui.mp@hitachi.com>,
- *            Yumiko Sugita <yumiko.sugita.yf@hitachi.com>,
- *            Satoshi Fujiwara <sa-fuji@sdl.hitachi.co.jp>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version 2
- * of the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
- *
- * $Id: include_j_h.h,v 1.2 2009/09/27 17:34:22 subrata_modak Exp $
- *
- */
-#ifndef __CJK_SYSCALL_J_H__
-#define __CJK_SYSCALL_J_H__
-
-#include <sys/time.h>
-#include <sys/resource.h>
-
-
-#define REG_RESULT_LOG_FP	stdout
-#define REG_DETAIL_LOG_FP	stderr
-
-
-/*
- * RPRINTF : macro to output test result
- */
-#define RPRINTF(...)						\
-	do {							\
-		fprintf(REG_RESULT_LOG_FP, __VA_ARGS__);	\
-	} while (0)
-
-
-/*
- * PRINTF : macro to output detail log
- */
-#define PRINTF(...)						\
-	do {							\
-		fprintf(REG_DETAIL_LOG_FP, __VA_ARGS__);	\
-	} while (0)
-
-
-/*
- * EPRINTF : macro to output error message
- */
-#define EPRINTF(...)						\
-	do {							\
-		fprintf(REG_DETAIL_LOG_FP, __VA_ARGS__);	\
-	} while (0)
-
-/*
- * PRINT_XXX : macro to output test result and expect
- */
-#define __PRINT_EXPECT(rc_has_range, rc, errno)				\
-	do {								\
-		if (rc_has_range)					\
-			PRINTF("EXPECT: return value(ret)=%s",		\
-			       (rc) >= 0 ? "(N >= 0)" : "(N <  0)");	\
-		else							\
-			PRINTF("EXPECT: return value(ret)=%d", rc);	\
-		PRINTF(" errno=%d (%s)", errno, strerror(errno));	\
-	} while (0)
-
-#define __PRINT_RESULT(rc_has_range, rc, errno)				\
-	do {								\
-		if (rc_has_range)					\
-			PRINTF("RESULT: return value(ret)=%8d", rc);	\
-		else							\
-			PRINTF("RESULT: return value(ret)=%d", rc);	\
-		PRINTF(" errno=%d (%s)", errno, strerror(errno));	\
-	} while (0)
-
-#define PRINT_RESULT(rc_has_range, e_rc, e_errno, r_rc, r_errno)	\
-	do {								\
-		__PRINT_EXPECT(rc_has_range, e_rc, e_errno);		\
-		PRINTF("\n");						\
-		__PRINT_RESULT(rc_has_range, r_rc, r_errno);		\
-		PRINTF("\n");						\
-	} while (0)
-
-#define PRINT_RESULT_EXTRA(rc_has_range, e_rc, e_errno, r_rc, r_errno,	\
-			   str, extra_ok)				\
-	do {								\
-		__PRINT_EXPECT(rc_has_range, e_rc, e_errno);		\
-		if ((extra_ok))						\
-			PRINTF("\n");					\
-		else							\
-			PRINTF(", %s=OK\n", str);			\
-		__PRINT_RESULT(rc_has_range, r_rc, r_errno);		\
-		if ((extra_ok))						\
-			PRINTF("\n");					\
-		else							\
-			PRINTF(", %s=NG\n", str);			\
-	} while (0)
-
-#define PRINT_RESULT_CMP(rc_has_range, e_rc, e_errno, r_rc, r_errno, cmp_ok) \
-	PRINT_RESULT_EXTRA(rc_has_range, e_rc, e_errno, r_rc, r_errno,	\
-			   "r/w check", cmp_ok)
-
-
-/*
- * Definitions
- */
-enum result_val {
-	RESULT_OK,
-	RESULT_NG
-};
-
-
-/*
- * Prototype
- */
-int setup_uid(char *uname);
-int setup_euid(char *uname, uid_t *old_uid);
-int cleanup_euid(uid_t old_uid);
-
-pid_t create_sig_proc(unsigned long usec, int sig, unsigned count);
-
-int _setup_file(char *testdir, char *fname, char *path, int flags, mode_t mode);
-int setup_file(char *testdir, char *fname, char *path);
-int cleanup_file(char *path);
-
-int setup_swapfile(char *testdir, char *fname, char *path, size_t size);
-int cleanup_swapfile(char *path);
-
-#define QUEUE_NAME	"/test_mqueue"
-pid_t create_echo_msg_proc(void);
-
-pid_t get_unexist_pid(void);
-
-#endif /* __CJK_SYSCALL_J_H__ */
-- 
2.29.2

