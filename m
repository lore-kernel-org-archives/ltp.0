From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 9 Dec 2020 14:19:26 +0100
Subject: [LTP] [PATCH 1/1] syscalls/get_mempolicy01: Rewrite to new API
In-Reply-To: <20201208132814.16497-1-pvorel@suse.cz>
References: <20201208132814.16497-1-pvorel@suse.cz>
Message-ID: <X9DO3uytgBaTrVwi@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2020 Petr Vorel <pvorel@suse.cz>
> + * Copyright (c) Linux Test Project, 2009-2020
> + * Copyright (c) Crackerjack Project, 2007-2008, Hitachi, Ltd
> + *
> + * Authors:
> + * Takahiro Yasui <takahiro.yasui.mp@hitachi.com>
> + * Yumiko Sugita <yumiko.sugita.yf@hitachi.com>
> + * Satoshi Fujiwara <sa-fuji@sdl.hitachi.co.jp>
> + * Manas Kumar Nayak <maknayak@in.ibm.com> (original port to the legacy API)
> + */

Missing test description?

>  #include "config.h"
> -#include <sys/types.h>
> -#include <sys/mman.h>
> -#include <getopt.h>
> -#include <string.h>
> -#include <stdlib.h>
> -#include <errno.h>
> -#include <stdio.h>
> -#include <unistd.h>
> -#include <libgen.h>
> -#if HAVE_NUMA_H
> +#include "tst_test.h"
> +
> +#ifdef HAVE_NUMA_V2
>  #include <numa.h>
> -#endif
> -#if HAVE_NUMAIF_H
>  #include <numaif.h>
> -#endif
>  
> -#include "test.h"
> -#include "lapi/syscalls.h"
> -#include "include_j_h.h"
> -#include "common_j_h.c"
> +#include <errno.h>
>  #include "numa_helper.h"
> -
> -char *TCID = "get_mempolicy01";
> -int TST_TOTAL = 1;
> -
> -#ifdef HAVE_NUMA_V2
> +#include "tst_numa.h"
> +#include "lapi/syscalls.h"
>  
>  #define MEM_LENGTH	(4 * 1024 * 1024)
>  
> -static int testno;
> +#define POLICY_DESC(x) .policy = x, .desc = "policy: "#x
> +#define POLICY_DESC_TEXT(x, y) .policy = x, .desc = "policy: "#x", "y
> +#define POLICY_DESC_FLAGS(x, y) .policy = x, .flags = y, .desc = "policy: "#x", flags: "#y
> +#define POLICY_DESC_FLAGS_TEXT(x, y, z) .policy = x, .flags = y, .desc = "policy: "#x", flags: "#y", "z
>  
> -enum test_type {
> -	DEFAULT,		/* get default policy */
> -	ADDR,			/* get policy of memory which include mapped address */
> -	INVALID_POINTER,
> -	INVALID_FLAGS,
> -};
> +static struct bitmask *nodemask, *getnodemask, *empty_nodemask;
>  
> -enum from_node {
> -	NONE,
> -	SELF,
> -};
> +static void test_set_mempolicy_default(unsigned int i);
> +static void test_set_mempolicy_none(unsigned int i);
> +static int test_mbind_none(unsigned int i);
> +static int test_mbind_default(unsigned int i);
> +static int set_invalid_addr(unsigned int i);
>  
>  struct test_case {
> -	int ttype;
>  	int policy;
> -	int from_node;
> +	const char *desc;
> +	unsigned int flags;
>  	int ret;
>  	int err;
> +	char *addr;
> +	int (*pre_test)(unsigned int i);
> +	void (*test)(unsigned int i);
> +	struct bitmask **exp_nodemask;
>  };
>  
> -/* Test cases
> - *
> - *   test status of errors on man page
> - *
> - *   (NONE)	     man page hadn't been completed.
> - *
> - *   test status of errors NOT on man page
> - *
> - *   EFAULT	     v (invalid address)
> - *   EINVAL	     v (invalid parameters)
> - */
>  static struct test_case tcase[] = {
> -	{			/* case00 */
> -	 .ttype = DEFAULT,
> -	 .policy = MPOL_DEFAULT,
> -	 .from_node = NONE,
> -	 .ret = 0,
> -	 .err = 0,
> -	 },
> -	{			/* case01 */
> -	 .ttype = DEFAULT,
> -	 .policy = MPOL_BIND,
> -	 .from_node = SELF,
> -	 .ret = 0,
> -	 .err = 0,
> -	 },
> -	{			/* case02 */
> -	 .ttype = DEFAULT,
> -	 .policy = MPOL_INTERLEAVE,
> -	 .from_node = SELF,
> -	 .ret = 0,
> -	 .err = 0,
> -	 },
> -	{			/* case03 */
> -	 .ttype = DEFAULT,
> -	 .policy = MPOL_PREFERRED,
> -	 .from_node = NONE,
> -	 .ret = 0,
> -	 .err = 0,
> -	 },
> -	{			/* case04 */
> -	 .ttype = DEFAULT,
> -	 .policy = MPOL_PREFERRED,
> -	 .from_node = SELF,
> -	 .ret = 0,
> -	 .err = 0,
> -	 },
> -	{			/* case05 */
> -	 .ttype = ADDR,
> -	 .policy = MPOL_DEFAULT,
> -	 .from_node = NONE,
> -	 .ret = 0,
> -	 .err = 0,
> -	 },
> -	{			/* case06 */
> -	 .ttype = ADDR,
> -	 .policy = MPOL_BIND,
> -	 .from_node = SELF,
> -	 .ret = 0,
> -	 .err = 0,
> -	 },
> -	{			/* case07 */
> -	 .ttype = ADDR,
> -	 .policy = MPOL_INTERLEAVE,
> -	 .from_node = SELF,
> -	 .ret = 0,
> -	 .err = 0,
> -	 },
> -	{			/* case08 */
> -	 .ttype = ADDR,
> -	 .policy = MPOL_PREFERRED,
> -	 .from_node = NONE,
> -	 .ret = 0,
> -	 .err = 0,
> -	 },
> -	{			/* case09 */
> -	 .ttype = ADDR,
> -	 .policy = MPOL_PREFERRED,
> -	 .from_node = SELF,
> -	 .ret = 0,
> -	 .err = 0,
> -	 },
> -	{			/* case10 */
> -	 .ttype = INVALID_POINTER,
> -	 .policy = MPOL_DEFAULT,
> -	 .from_node = NONE,
> -	 .ret = -1,
> -	 .err = EFAULT,
> -	 },
> -	{			/* case11 */
> -	 .ttype = INVALID_FLAGS,
> -	 .policy = MPOL_DEFAULT,
> -	 .from_node = NONE,
> -	 .ret = -1,
> -	 .err = EINVAL,
> -	 },
> +	{
> +		POLICY_DESC_TEXT(MPOL_DEFAULT, "no target"),
> +		.ret = 0,
> +		.err = 0,
> +		.test = test_set_mempolicy_none,
> +		.exp_nodemask = &empty_nodemask,
> +	},
> +	{
> +		POLICY_DESC(MPOL_BIND),
> +		.ret = 0,
> +		.err = 0,
> +		.test = test_set_mempolicy_default,
> +	},
> +	{
> +		POLICY_DESC(MPOL_INTERLEAVE),
> +		.ret = 0,
> +		.err = 0,
> +		.test = test_set_mempolicy_default,
> +		.exp_nodemask = &nodemask,
> +	},
> +	{
> +		POLICY_DESC_TEXT(MPOL_PREFERRED, "no target"),
> +		.ret = 0,
> +		.err = 0,
> +		.test = test_set_mempolicy_none,
> +		.exp_nodemask = &nodemask,
> +	},
> +	{
> +		.test = test_set_mempolicy_default,
> +		POLICY_DESC(MPOL_PREFERRED),
> +		.ret = 0,
> +		.err = 0,
> +	},
> +	{
> +		POLICY_DESC_FLAGS_TEXT(MPOL_DEFAULT, MPOL_F_ADDR, "no target"),
> +		.ret = 0,
> +		.err = 0,
> +		.pre_test = test_mbind_none,
> +		.test = test_set_mempolicy_none,
> +		.exp_nodemask = &nodemask,
> +	},
> +	{
> +		POLICY_DESC_FLAGS(MPOL_BIND, MPOL_F_ADDR),
> +		.pre_test = test_mbind_default,
> +		.ret = 0,
> +		.err = 0,
> +	},
> +	{
> +		POLICY_DESC_FLAGS(MPOL_INTERLEAVE, MPOL_F_ADDR),
> +		.ret = 0,
> +		.err = 0,
> +		.pre_test = test_mbind_default,
> +		.test = test_set_mempolicy_default,
> +		.exp_nodemask = &nodemask,
> +	},
> +	{
> +		POLICY_DESC_FLAGS_TEXT(MPOL_PREFERRED, MPOL_F_ADDR, "no target"),
> +		.ret = 0,
> +		.err = 0,
> +		.pre_test = test_mbind_none,
> +		.test = test_set_mempolicy_none,
> +		.exp_nodemask = &nodemask,
> +	},
> +	{
> +		POLICY_DESC_FLAGS(MPOL_PREFERRED, MPOL_F_ADDR),
> +		.ret = 0,
> +		.err = 0,
> +		.pre_test = test_mbind_default,
> +		.test = test_set_mempolicy_default,
> +	},
> +	{
> +		.flags = MPOL_F_ADDR,
> +		POLICY_DESC_TEXT(MPOL_DEFAULT, "invalid address"),
> +		.ret = -1,
> +		.err = EFAULT,
> +		.pre_test = set_invalid_addr,
> +		.exp_nodemask = &nodemask,
> +	},
> +	{
> +		POLICY_DESC_TEXT(MPOL_DEFAULT, "invalid flags, no target"),
> +		.flags = -1,
> +		.ret = -1,
> +		.err = EINVAL,
> +		.test = test_set_mempolicy_none,
> +		.exp_nodemask = &nodemask,
> +	},
>  };
>  
> -static int do_test(struct test_case *tc);
> -static void setup(void);
> -static void cleanup(void);
> +static void test_set_mempolicy_default(unsigned int i)
> +{
> +	struct test_case *tc = &tcase[i];
> +
> +	TEST(set_mempolicy(tc->policy, nodemask->maskp, nodemask->size));
> +}
>  
> -int main(int argc, char **argv)
> +static void test_set_mempolicy_none(unsigned int i)
>  {
> -	int i, ret, lc;
> +	struct test_case *tc = &tcase[i];
>  
> -	setup();
> +	TEST(set_mempolicy(tc->policy, NULL, 0));
> +}
> +
> +static int test_mbind(unsigned int i, unsigned long *maskp, unsigned long size)
> +{
> +	struct test_case *tc = &tcase[i];
>  
> -	ret = 0;
> -	testno = (int)ARRAY_SIZE(tcase);
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -		tst_count = 0;
> +	tc->addr = SAFE_MMAP(NULL, MEM_LENGTH, PROT_READ | PROT_WRITE,
> +			     MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
>  
> -		for (i = 0; i < testno; i++) {
> -			tst_resm(TINFO, "(case%02d) START", i);
> -			ret = do_test(&tcase[i]);
> -			tst_resm((ret == 0 ? TPASS : TFAIL | TERRNO),
> -				 "(case%02d) END", i);
> -		}
> +	TEST(mbind(tc->addr, MEM_LENGTH, tc->policy, maskp, size, 0));
> +
> +	if (TST_RET < 0) {
> +		tst_res(TFAIL | TERRNO, "mbind() failed");
> +		return -1;
>  	}
>  
> -	cleanup();
> -	tst_exit();
> +	return 0;
>  }
>  
> -static int do_test(struct test_case *tc)
> +static int test_mbind_none(unsigned int i)
>  {
> -	int ret, err, result, cmp_ok;
> -	int policy, flags;
> -	struct bitmask *nodemask = numa_allocate_nodemask();
> -	struct bitmask *getnodemask = numa_allocate_nodemask();
> -	char *p = NULL;
> -	unsigned long len = MEM_LENGTH;
> -	int test_node = -1;
> +	return test_mbind(i, NULL, 0);
> +}
>  
> -	ret = get_allowed_nodes(NH_MEMS, 1, &test_node);
> -	if (ret < 0)
> -		tst_brkm(TBROK | TERRNO, cleanup, "get_allowed_nodes: %d", ret);
> -	numa_bitmask_setbit(nodemask, test_node);
> -	switch (tc->ttype) {
> -	case DEFAULT:
> -		flags = 0;
> -		p = NULL;
> -		if (tc->from_node == NONE)
> -			TEST(ltp_syscall(__NR_set_mempolicy, tc->policy,
> -				NULL, 0));
> -		else
> -			TEST(ltp_syscall(__NR_set_mempolicy, tc->policy,
> -				nodemask->maskp, nodemask->size));
> -		if (TEST_RETURN < 0) {
> -			tst_resm(TBROK | TERRNO, "set_mempolicy");
> -			return -1;
> -		}
> +static int test_mbind_default(unsigned int i)
> +{
> +	return test_mbind(i, nodemask->maskp, nodemask->size);
> +}
>  
> -		break;
> -	default:
> -		flags = MPOL_F_ADDR;
> -		p = mmap(NULL, len, PROT_READ | PROT_WRITE,
> -			 MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
> -		if (p == MAP_FAILED)
> -			tst_brkm(TBROK | TERRNO, cleanup, "mmap");
> -		if (tc->from_node == NONE)
> -			TEST(ltp_syscall(__NR_mbind, p, len, tc->policy,
> -				NULL, 0, 0));
> -		else
> -			TEST(ltp_syscall(__NR_mbind, p, len, tc->policy,
> -				nodemask->maskp, nodemask->size, 0));
> -		if (TEST_RETURN < 0) {
> -			tst_resm(TBROK | TERRNO, "mbind");
> -			return -1;
> -		}
> +static int set_invalid_addr(unsigned int i)
> +{
> +	struct test_case *tc = &tcase[i];
> +	int ret;
>  
> -		if (tc->ttype == INVALID_POINTER)
> -#ifdef __ia64__
> -			p = (char *)0x8000000000000000UL;
> -#else
> -			p = 0;
> -#endif
> +	ret = test_mbind_none(i);
> +	tc->addr = NULL;
>  
> -		if (tc->ttype == INVALID_FLAGS)
> -			flags = -1;
> -	}
> -	errno = 0;
> -	cmp_ok = 1;
> -	TEST(ret = ltp_syscall(__NR_get_mempolicy, &policy, getnodemask->maskp,
> -			   getnodemask->size, p, flags));
> -	err = TEST_ERRNO;
> -	if (ret < 0)
> -		goto TEST_END;
> -
> -	/* if policy == MPOL_DEFAULT, get_mempolicy doesn't return nodemask */
> -	if (tc->policy == MPOL_DEFAULT)
> -		numa_bitmask_clearall(nodemask);
> -	cmp_ok = (tc->policy == policy && (tc->from_node == NONE ||
> -					   numa_bitmask_equal(nodemask,
> -							      getnodemask)));
> -TEST_END:
> -	result = (err != tc->err) || !cmp_ok;
> -	PRINT_RESULT_CMP(0, tc->ret, tc->err, ret, err, cmp_ok);
> -	return result;
> +	return ret;
>  }
>  
> -static void cleanup(void)
> +
> +static void setup(void)
>  {
> -	tst_rmdir();
> +	if (!is_numa(NULL, NH_MEMS, 1))
> +		tst_brk(TCONF, "requires NUMA with at least 1 node");
>  }
>  
> -static void setup(void)
> +static void setup_node(void)
>  {
> -	/* check syscall availability */
> -	ltp_syscall(__NR_get_mempolicy, NULL, NULL, 0, NULL, 0);
> +	int test_node = -1;
>  
> -	if (!is_numa(NULL, NH_MEMS, 1))
> -		tst_brkm(TCONF, NULL, "requires NUMA with at least 1 node");
> +	if (get_allowed_nodes(NH_MEMS, 1, &test_node) < 0)
> +		tst_brk(TBROK | TERRNO, "get_allowed_nodes failed");

The is_numa() and get_allowed_nodes() is deprecated API, we do have new
tst_get_nodemap() function that replaces them. See set_mempolicy()
testcases for reference.

> -	TEST_PAUSE;
> -	tst_tmpdir();
> +	nodemask = numa_allocate_nodemask();
> +	getnodemask = numa_allocate_nodemask();
> +	numa_bitmask_setbit(nodemask, test_node);
>  }
>  
> -#else
> -int main(void)
> +static void do_test(unsigned int i)
>  {
> -	tst_brkm(TCONF, NULL, NUMA_ERROR_MSG);
> +	struct test_case *tc = &tcase[i];
> +	int policy;
> +
> +	tst_res(TINFO, "test #%d: %s", (i+1), tc->desc);
> +
> +	setup_node();
> +
> +	if (tc->pre_test)
> +		if (tc->pre_test(i) == -1)
> +			return;
> +
> +	if (tc->test) {
> +		tc->test(i);
> +
> +		if (TST_RET < 0) {
> +			tst_res(TFAIL | TERRNO, ".test failed");
> +			return;
> +		}
> +	}

We call test_mbind() here for each iteration which calls mmap()
and the memory is never freed. Which means that this will fail sooner or
later with the -i option.

Why can't we allocate all the blocks with different mempolicy and
or/bind the memory once in the test setup instead? We can keep the
callback in-place as they are we just need to loop over them in the
setup() instead. Also I would rename them to alloc, setup, or something
like that so that it's clear that they are just preparing the
environment and not doing the actuall test.

Also I would pass the struct test_case pointer to these instead of i
since they convert the i to the testcase pointer as the first thing
anyways.

-- 
Cyril Hrubis
chrubis@suse.cz
