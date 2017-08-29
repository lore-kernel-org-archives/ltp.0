From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 29 Aug 2017 17:35:09 +0200
Subject: [LTP] [PATCH v2 2/2] syscalls/mbind: cleanup and rewrite mbind01
	into new API
In-Reply-To: <20170829153509.12613-1-pvorel@suse.cz>
References: <20170829153509.12613-1-pvorel@suse.cz>
Message-ID: <20170829153509.12613-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

+ removed support for NUMA API < 2 (test is compilable, but TCONF
on older API)

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/syscalls/mbind/mbind01.c | 450 ++++++++++++------------------
 1 file changed, 186 insertions(+), 264 deletions(-)

diff --git a/testcases/kernel/syscalls/mbind/mbind01.c b/testcases/kernel/syscalls/mbind/mbind01.c
index d5c93f203..8db1deeb5 100644
--- a/testcases/kernel/syscalls/mbind/mbind01.c
+++ b/testcases/kernel/syscalls/mbind/mbind01.c
@@ -1,317 +1,239 @@
-/******************************************************************************/
-/* Copyright (c) Crackerjack Project., 2007-2008			      */
-/* Author(s):	Takahiro Yasui <takahiro.yasui.mp@hitachi.com>,		      */
-/*		Yumiko Sugita <yumiko.sugita.yf@hitachi.com>,		      */
-/*		Satoshi Fujiwara <sa-fuji@sdl.hitachi.co.jp>		      */
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
-/* File:	mbind01.c						      */
-/*									      */
-/* Description: This tests the mbind() syscall				      */
-/*									      */
-/* Usage:	<for command-line>					      */
-/* mbind01 [-c n] [-e][-i n] [-I x] [-p x] [-t]				      */
-/*	where,	-c n : Run n copies concurrently.			      */
-/*		-e   : Turn on errno logging.				      */
-/*		-i n : Execute test n times.				      */
-/*		-I x : Execute test for x seconds.			      */
-/*		-P x : Pause for x seconds between iterations.		      */
-/*		-t   : Turn on syscall timing.				      */
-/*									      */
-/* Total Tests: 1							      */
-/*									      */
-/* Test Name:	mbind01							      */
-/* History:	Porting from Crackerjack to LTP is done by		      */
-/*		Manas Kumar Nayak maknayak@in.ibm.com>			      */
-/******************************************************************************/
+/*
+ * Copyright (c) Crackerjack Project., 2007-2008, Hitachi, Ltd
+ * Copyright (c) 2017 Petr Vorel <pvorel@suse.cz>
+ *
+ * Authors:
+ * Takahiro Yasui <takahiro.yasui.mp@hitachi.com>,
+ * Yumiko Sugita <yumiko.sugita.yf@hitachi.com>,
+ * Satoshi Fujiwara <sa-fuji@sdl.hitachi.co.jp>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it would be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ */
 
-#include "config.h"
-#include <sys/types.h>
-#include <sys/mman.h>
-#include <sys/syscall.h>
 #include <errno.h>
-#include <getopt.h>
-#include <libgen.h>
-#if HAVE_NUMA_H
-#include <numa.h>
-#endif
-#if HAVE_NUMAIF_H
-#include <numaif.h>
-#endif
-#include <stdio.h>
-#include <stdlib.h>
-#include <string.h>
-#include <unistd.h>
 
-#include "test.h"
-#include "lapi/syscalls.h"
-#include "include_j_h.h"
 #include "numa_helper.h"
 
-char *TCID = "mbind01";
-int TST_TOTAL = 2;
-
 #if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H && \
 	HAVE_MPOL_CONSTANTS
+#if defined(LIBNUMA_API_VERSION) && LIBNUMA_API_VERSION == 2
+#include "tst_test.h"
 
-#define MEM_LENGTH	      (4 * 1024 * 1024)
+#define MEM_LENGTH (4 * 1024 * 1024)
 
-static int testno;
+#define UNKNOWN_POLICY -1
 
-enum test_type {
-	NORMAL,
-	INVALID_POINTER,
-};
+#define POLICY_DESC(x) .policy = x, .desc = #x
+#define POLICY_DESC_TEXT(x, y) .policy = x, .desc = #x" ("y")"
 
-enum from_node {
-	NONE,
-	SELF,
-};
+struct bitmask *nodemask, *getnodemask;
+
+void test_default(unsigned int i, char *p);
+void test_none(unsigned int i, char *p);
+void test_invalid_nodemask(unsigned int i, char *p);
 
 struct test_case {
-	int ttype;
 	int policy;
-	int from_node;
+	const char *desc;
 	unsigned flags;
+	unsigned no_check_nodemask;
 	int ret;
 	int err;
+	void (*test)(unsigned int, char *);
 };
 
-/* Test cases
- *
- *   test status of errors on man page
- *
- *   EFAULT	v (detect unmapped hole or invalid pointer)
- *   EINVAL	v (invalid arguments)
- *   ENOMEM	can't check because it's difficult to create no-memory
- *   EIO	can't check because we don't have N-node NUMA system
- *		(only we can do is simulate 1-node NUMA)
- */
 static struct test_case tcase[] = {
-	{			/* case00 */
-	 .policy = MPOL_DEFAULT,
-	 .from_node = NONE,
-	 .ret = 0,
-	 .err = 0,
-	 },
-	{			/* case01 */
-	 .policy = MPOL_DEFAULT,
-	 .from_node = SELF,	/* target exists */
-	 .ret = -1,
-	 .err = EINVAL,
-	 },
-	{			/* case02 */
-	 .policy = MPOL_BIND,
-	 .from_node = NONE,	/* no target */
-	 .ret = -1,
-	 .err = EINVAL,
-	 },
-	{			/* case03 */
-	 .policy = MPOL_BIND,
-	 .from_node = SELF,
-	 .ret = 0,
-	 .err = 0,
-	 },
-	{			/* case04 */
-	 .policy = MPOL_INTERLEAVE,
-	 .from_node = NONE,	/* no target */
-	 .ret = -1,
-	 .err = EINVAL,
-	 },
-	{			/* case05 */
-	 .policy = MPOL_INTERLEAVE,
-	 .from_node = SELF,
-	 .ret = 0,
-	 .err = 0,
-	 },
-	{			/* case06 */
-	 .policy = MPOL_PREFERRED,
-	 .from_node = NONE,
-	 .ret = 0,
-	 .err = 0,
-	 },
-	{			/* case07 */
-	 .policy = MPOL_PREFERRED,
-	 .from_node = SELF,
-	 .ret = 0,
-	 .err = 0,
-	 },
-	{			/* case08 */
-	 .policy = -1,		/* unknown policy */
-	 .from_node = NONE,
-	 .ret = -1,
-	 .err = EINVAL,
-	 },
-	{			/* case09 */
-	 .policy = MPOL_DEFAULT,
-	 .from_node = NONE,
-	 .flags = -1,		/* invalid flags */
-	 .ret = -1,
-	 .err = EINVAL,
-	 },
-	{			/* case10 */
-	 .ttype = INVALID_POINTER,
-	 .policy = MPOL_PREFERRED,
-	 .from_node = SELF,
-	 .ret = -1,
-	 .err = EFAULT,
-	 },
+	{
+		POLICY_DESC(MPOL_DEFAULT),
+		.ret = 0,
+		.err = 0,
+		.test = test_none,
+	},
+	{
+		POLICY_DESC_TEXT(MPOL_DEFAULT, "target exists"),
+		.ret = -1,
+		.err = EINVAL,
+		.test = test_default,
+	},
+	{
+		POLICY_DESC_TEXT(MPOL_BIND, "no target"),
+		.ret = -1,
+		.err = EINVAL,
+		.test = test_none,
+	},
+	{
+		POLICY_DESC(MPOL_BIND),
+		.ret = 0,
+		.err = 0,
+		.test = test_default,
+	},
+	{
+		POLICY_DESC_TEXT(MPOL_INTERLEAVE, "no target"),
+		.ret = -1,
+		.err = EINVAL,
+		.test = test_none,
+	},
+	{
+		POLICY_DESC(MPOL_INTERLEAVE),
+		.ret = 0,
+		.err = 0,
+		.test = test_default,
+	},
+	{
+		POLICY_DESC(MPOL_PREFERRED),
+		.ret = 0,
+		.no_check_nodemask = 1,
+		.err = 0,
+		.test = test_none,
+	},
+	{
+		POLICY_DESC(MPOL_PREFERRED),
+		.ret = 0,
+		.err = 0,
+		.test = test_default,
+	},
+	{
+		POLICY_DESC(UNKNOWN_POLICY),
+		.ret = -1,
+		.err = EINVAL,
+		.test = test_none,
+	},
+	{
+		POLICY_DESC_TEXT(MPOL_DEFAULT, "invalid flags"),
+		.flags = -1,
+		.ret = -1,
+		.err = EINVAL,
+		.test = test_none,
+	},
+	{
+		POLICY_DESC_TEXT(MPOL_PREFERRED, "invalid nodemask"),
+		.ret = -1,
+		.err = EFAULT,
+		.test = test_invalid_nodemask,
+	},
 };
 
-static int do_test(struct test_case *tc);
-static void setup(void);
-static void cleanup(void);
+void test_default(unsigned int i, char *p) {
+	struct test_case *tc = &tcase[i];
+	TEST(mbind(p, MEM_LENGTH, tc->policy, nodemask->maskp,
+		   nodemask->size, tc->flags));
+}
+
+void test_none(unsigned int i, char *p) {
+	struct test_case *tc = &tcase[i];
+	TEST(mbind(p, MEM_LENGTH, tc->policy, NULL, 0, tc->flags));
+}
+
+void test_invalid_nodemask(unsigned int i, char *p) {
+	struct test_case *tc = &tcase[i];
+	/* use invalid nodemask (64 MiB after heap) */
+	TEST(mbind(p, MEM_LENGTH, tc->policy, sbrk(0) + 64*1024*1024,
+		   NUMA_NUM_NODES, tc->flags));
+}
 
-int main(int argc, char **argv)
+static void setup(void)
 {
-	int lc, i, ret;
+	if (!is_numa(NULL, NH_MEMS, 1))
+		tst_brk(TCONF, "requires NUMA with at least 1 node");
+}
 
-	tst_parse_opts(argc, argv, NULL, NULL);
+static void setup_node(void)
+{
+	int test_node = -1;
 
-	setup();
-	testno = (int)(sizeof(tcase) / sizeof(tcase[0]));
+	if (get_allowed_nodes(NH_MEMS, 1, &test_node) < 0)
+		tst_brk(TBROK | TERRNO, "get_allowed_nodes failed");
 
-	for (lc = 0; TEST_LOOPING(lc); ++lc) {
-		tst_count = 0;
-		for (i = 0; i < testno; i++) {
-			tst_resm(TINFO, "(case%02d) START", i);
-			ret = do_test(&tcase[i]);
-			tst_resm((ret == 0 ? TPASS : TFAIL | TERRNO),
-				 "(case%02d) END", i);
-		}
-	}
-	cleanup();
-	tst_exit();
+	nodemask = numa_allocate_nodemask();
+	getnodemask = numa_allocate_nodemask();
+	numa_bitmask_setbit(nodemask, test_node);
 }
 
-static int do_test(struct test_case *tc)
+static void do_test(unsigned int i)
 {
-	int ret, err, result, cmp_ok = 1;
+	struct test_case *tc = &tcase[i];
 	int policy;
 	char *p = NULL;
-#if !defined(LIBNUMA_API_VERSION) || LIBNUMA_API_VERSION < 2
-	nodemask_t *nodemask, *getnodemask;
-#else
-	struct bitmask *nodemask = numa_allocate_nodemask();
-	struct bitmask *getnodemask = numa_allocate_nodemask();
-#endif
-	unsigned long maxnode = NUMA_NUM_NODES;
-	unsigned long len = MEM_LENGTH;
-	unsigned long *invalid_nodemask;
-	int test_node = -1;
 
-	ret = get_allowed_nodes(NH_MEMS, 1, &test_node);
-	if (ret < 0)
-		tst_brkm(TBROK | TERRNO, cleanup, "get_allowed_nodes: %d", ret);
+	tst_res(TINFO, "case %s", tc->desc);
 
-#if !defined(LIBNUMA_API_VERSION) || LIBNUMA_API_VERSION < 2
-	nodemask = malloc(sizeof(nodemask_t));
-	nodemask_zero(nodemask);
-	nodemask_set(nodemask, test_node);
-	getnodemask = malloc(sizeof(nodemask_t));
-	nodemask_zero(getnodemask);
-#else
-	numa_bitmask_setbit(nodemask, test_node);
-#endif
-	p = mmap(NULL, len, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS,
-		 0, 0);
+	setup_node();
+
+	p = mmap(NULL, MEM_LENGTH, PROT_READ | PROT_WRITE, MAP_PRIVATE |
+			 MAP_ANONYMOUS, 0, 0);
 	if (p == MAP_FAILED)
-		tst_brkm(TBROK | TERRNO, cleanup, "mmap");
+		tst_brk(TBROK | TERRNO, "mmap");
 
-	if (tc->ttype == INVALID_POINTER)
-		invalid_nodemask = (unsigned long *)0xc0000000;
+	tc->test(i, p);
 
-	errno = 0;
-	if (tc->from_node == NONE)
-		TEST(ret = ltp_syscall(__NR_mbind, p, len, tc->policy,
-				   NULL, 0, tc->flags));
-	else if (tc->ttype == INVALID_POINTER)
-		TEST(ret = ltp_syscall(__NR_mbind, p, len, tc->policy,
-				   invalid_nodemask, maxnode, tc->flags));
-	else
-#if !defined(LIBNUMA_API_VERSION) || LIBNUMA_API_VERSION < 2
-		TEST(ret = ltp_syscall(__NR_mbind, p, len, tc->policy,
-				   nodemask, maxnode, tc->flags));
-#else
-		TEST(ret = ltp_syscall(__NR_mbind, p, len, tc->policy,
-				   nodemask->maskp, nodemask->size, tc->flags));
-#endif
+	if (TEST_RETURN >= 0) {
+		/* Check policy of the allocated memory */
+		TEST(get_mempolicy(&policy, getnodemask->maskp,
+				   getnodemask->size, p, MPOL_F_ADDR));
+		if (TEST_RETURN < 0) {
+			tst_res(TFAIL | TERRNO, "get_mempolicy failed");
+			return;
+		}
 
-	err = TEST_ERRNO;
-	if (ret < 0)
-		goto TEST_END;
+		/* get_mempolicy doesn't return nodemask for policy MPOL_DEFAULT */
+		if (tc->policy == MPOL_DEFAULT)
+			numa_bitmask_clearall(nodemask);
 
-	/* Check policy of the allocated memory */
-#if !defined(LIBNUMA_API_VERSION) || LIBNUMA_API_VERSION < 2
-	TEST(ltp_syscall(__NR_get_mempolicy, &policy, getnodemask,
-		     maxnode, p, MPOL_F_ADDR));
-#else
-	TEST(ltp_syscall(__NR_get_mempolicy, &policy, getnodemask->maskp,
-		     getnodemask->size, p, MPOL_F_ADDR));
-#endif
-	if (TEST_RETURN < 0) {
-		tst_resm(TFAIL | TERRNO, "get_mempolicy failed");
-		return -1;
-	}
+		if (tc->policy != policy) {
+			tst_res(TFAIL, "Wrong policy: %d, expected: %d",
+				tc->policy, policy);
+			return;
+		}
 
-	/* If policy == MPOL_DEFAULT, get_mempolicy doesn't return nodemask */
-	if (tc->policy == MPOL_DEFAULT)
-#if !defined(LIBNUMA_API_VERSION) || LIBNUMA_API_VERSION < 2
-		nodemask_zero(nodemask);
-#else
-		numa_bitmask_clearall(nodemask);
-#endif
+		if (!tc->no_check_nodemask && !numa_bitmask_equal(nodemask,
+								  getnodemask)) {
+			tst_res(TFAIL, "masks are not equal");
+			return;
+		}
+	}
 
-	if ((tc->policy == MPOL_PREFERRED) && (tc->from_node == NONE))
-		cmp_ok = (tc->policy == policy);
+	if (TEST_ERRNO != tc->err)
+		tst_res(TFAIL | TERRNO, "test mbind() failed: %d, expected: %d",
+			TEST_ERRNO, tc->err);
+	else if (TEST_RETURN != tc->ret)
+		tst_res(TFAIL | TERRNO,
+			"test mbind() wrong return code: %ld, expected: %d",
+			TEST_RETURN, tc->ret);
 	else
-		cmp_ok = ((tc->policy == policy) &&
-#if !defined(LIBNUMA_API_VERSION) || LIBNUMA_API_VERSION < 2
-			  nodemask_equal(nodemask, getnodemask));
-#else
-			  numa_bitmask_equal(nodemask, getnodemask));
-#endif
-TEST_END:
-	result = ((err != tc->err) || (!cmp_ok));
-	PRINT_RESULT_CMP(0, tc->ret, tc->err, ret, err, cmp_ok);
-	return result;
+		tst_res(TPASS, "Test passed");
 }
 
-static void setup(void)
-{
-	/* check syscall availability */
-	ltp_syscall(__NR_mbind, NULL, 0, 0, NULL, 0, 0);
-
-	if (!is_numa(NULL, NH_MEMS, 1))
-		tst_brkm(TCONF, NULL, "requires NUMA with at least 1 node");
 
-	TEST_PAUSE;
-	tst_tmpdir();
-}
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tcase),
+	.test = do_test,
+	.setup = setup,
+};
 
-static void cleanup(void)
+#else /* libnuma v1 */
+#define TST_NO_DEFAULT_MAIN
+#include "tst_test.h"
+int main(void)
 {
-	tst_rmdir();
+	tst_brk(TCONF, "test is only supported on libnuma v2.");
 }
+#endif
 #else /* no NUMA */
+#define TST_NO_DEFAULT_MAIN
+#include "tst_test.h"
 int main(void)
 {
-	tst_brkm(TCONF, NULL, "System doesn't have required numa support");
+	tst_brk(TCONF, "system doesn't have required numa support");
 }
 #endif
-- 
2.14.0

