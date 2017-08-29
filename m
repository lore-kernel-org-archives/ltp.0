From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 29 Aug 2017 12:21:02 +0200
Subject: [LTP] [PATCH 2/2] syscalls/mbind: cleanup and rewrite mbind01
 into new API
In-Reply-To: <20170829064309.14383-2-pvorel@suse.cz>
References: <20170829064309.14383-1-pvorel@suse.cz>
 <20170829064309.14383-2-pvorel@suse.cz>
Message-ID: <d5f2d568-8e0b-3c6e-ea78-dfc77594ba36@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

Patch 1/2: I would probably go with cast of max_node to int, to keep
printf format specifiers and function arguments matching, but your
version should work too.

Replying to patch 2/2 produced with "-B", as it makes it easier to read.

<snip>
+#include <errno.h>
+
+#include "numa_helper.h"
+#include "tst_test.h"
+
+#if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H && \
+	HAVE_MPOL_CONSTANTS
+#if defined(LIBNUMA_API_VERSION) && LIBNUMA_API_VERSION == 2
+
+#define MEM_LENGTH (4 * 1024 * 1024)
+#define INVALID_NODEMASK ((unsigned long *)0xc0000000)

This define is unused. We shouldn't be using magic numbers anyway
and assume there's nothing mapped there. You could map/unmap some
larger area and use pointer from middle. Or we could try couple
MiB after heap, e.g.: sbrk(0) + 64*1024*1024.

+
+struct bitmask *nodemask, *getnodemask;

static

+
+void test_none(unsigned int i, char *p);
+void test_invalid_nodemask(unsigned int i, char *p);
+
+struct test_case {
+	int policy;
+	unsigned flags;
+	int ret;
+	int err;
+	void (*pre_test)(unsigned int, char *);

I find this name confusing. Why not call it just "test"
and provide a test function for all cases?

Suggestion: add short description for each testcase as char *

+};
+
+static struct test_case tcase[] = {
+	{
+		.policy = MPOL_DEFAULT,
+		.ret = 0,
+		.err = 0,
+		.pre_test = test_none,
+	},
+	{
+		.policy = MPOL_DEFAULT,
+		.ret = -1, /* target exists */
+		.err = EINVAL,
+	},
+	{
+		.policy = MPOL_BIND,
+		.ret = -1,
+		.err = EINVAL, /* no target */
+		.pre_test = test_none,
+	},
+	{
+		.policy = MPOL_BIND,
+		.ret = 0,
+		.err = 0,
+	},
+	{
+		.policy = MPOL_INTERLEAVE,
+		.ret = -1,
+		.err = EINVAL, /* no target */
+		.pre_test = test_none,
+	},
+	{
+		.policy = MPOL_INTERLEAVE,
+		.ret = 0,
+		.err = 0,
+	},
+	{
+		.policy = MPOL_PREFERRED,
+		.ret = 0,
+		.err = 0,
+		.pre_test = test_none,
+	},
+	{
+		.policy = MPOL_PREFERRED,
+		.ret = 0,
+		.err = 0,
+	},
+	{
+		.policy = -1, /* unknown policy */
+		.ret = -1,
+		.err = EINVAL,
+		.pre_test = test_none,
+	},
+	{
+		.policy = MPOL_DEFAULT,
+		.flags = -1, /* invalid flags */
+		.ret = -1,
+		.err = EINVAL,
+		.pre_test = test_none,
+	},
+	{
+		.policy = MPOL_PREFERRED,
+		.ret = -1,
+		.err = EFAULT,
+		.pre_test = test_invalid_nodemask,
+	},
+};
+
+void test_none(unsigned int i, char *p) {
+	struct test_case *tc = &tcase[i];
+	TEST(mbind(p, MEM_LENGTH, tc->policy, NULL, 0, tc->flags));
+}
+
+void test_invalid_nodemask(unsigned int i, char *p) {
+	struct test_case *tc = &tcase[i];
+	TEST(mbind(p, MEM_LENGTH, tc->policy, (unsigned long *)0xc0000000,
+		   NUMA_NUM_NODES, tc->flags));
+}
+
+static void setup(void)
+{
+	if (!is_numa(NULL, NH_MEMS, 1))
+		tst_brk(TCONF, "requires NUMA with at least 1 node");
+}
+
+static void setup_node(void)
+{
+	int test_node = -1;
+
+	if (get_allowed_nodes(NH_MEMS, 1, &test_node) < 0)
+		tst_brk(TBROK | TERRNO, "get_allowed_nodes failed");
+
+	nodemask = numa_allocate_nodemask();
+	getnodemask = numa_allocate_nodemask();
+	numa_bitmask_setbit(nodemask, test_node);
+}
+
+static void do_test(unsigned int i)
+{
+	struct test_case *tc = &tcase[i];
+	int policy;
+	char *p = NULL;
+
+	setup_node();
+
+	p = mmap(NULL, MEM_LENGTH, PROT_READ | PROT_WRITE, MAP_PRIVATE |
+			 MAP_ANONYMOUS, 0, 0);
+	if (p == MAP_FAILED)
+		tst_brk(TBROK | TERRNO, "mmap");
+
+	if (tc->pre_test)
+		tc->pre_test(i, p);
+	else
+		TEST(mbind(p, MEM_LENGTH, tc->policy, nodemask->maskp,
+			   nodemask->size, tc->flags));

Having just ->test() would make this simpler.
And a short description of current test as TINFO would make it easier to
see what failed.

+
+	if (TEST_RETURN >= 0) {
+		/* Check policy of the allocated memory */
+		TEST(get_mempolicy(&policy, getnodemask->maskp,
+				   getnodemask->size, p, MPOL_F_ADDR));
+		if (TEST_RETURN < 0) {
+			tst_res(TFAIL | TERRNO, "get_mempolicy failed");
+			return;
+		}
+
+		/* get_mempolicy doesn't return nodemask for policy MPOL_DEFAULT */
+		if (tc->policy == MPOL_DEFAULT)
+			numa_bitmask_clearall(nodemask);

Rather than skipping the check, this clears nodemask. If this skipped the check
and didn't touch nodemask, then you wouldn't have to re-initialize it in every
call of do_test().

+
+		if (tc->policy != policy) {
+			tst_res(TFAIL, "Wrong policy: %d, expected: %d",
+				tc->policy, policy);
+			return;
+		}
+
+		if ((tc->policy != MPOL_PREFERRED || tc->pre_test != test_none)
+		    && !numa_bitmask_equal(nodemask, getnodemask)) {
+			tst_res(TFAIL, "masks are not equal");
+			return;
+		}

How about we add a field "check_nodemask" to struct test_case? Then MPOL_DEFAULT
above and this check could be both reduced to:

if (tc->check_nodemask && !numa_bitmask_equal(nodemask, getnodemask))
    tst_res(TFAIL, "masks are not equal");

+	}
+
+	if (TEST_ERRNO != tc->err)
+		tst_res(TFAIL | TERRNO, "test mbind() failed: %d, expected: %d",
+			TEST_ERRNO, tc->err);
+	else if (TEST_RETURN != tc->ret)
+		tst_res(TFAIL | TERRNO,
+			"test mbind() wrong return code: %ld, expected: %d",
+			TEST_RETURN, tc->ret);
+	else
+		tst_res(TPASS, "Test passed");
+}
+
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tcase),
+	.test = do_test,
+	.setup = setup,
+};
+
+#else /* libnuma v1 */
+int main(void)
+{
+	tst_brkm(TCONF, "test is only supported on libnuma v2.");
+}

You need TST_NO_DEFAULT_MAIN before including tst_test.h here.
Also, tst_brkm is oldlib.

+#endif
+#else /* no NUMA */

Same here.

Regards,
Jan

+int main(void)
+{
+	tst_brk(TCONF, "system doesn't have required numa support");
+}
+#endif
