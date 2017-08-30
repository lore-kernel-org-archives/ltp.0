From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 30 Aug 2017 12:57:59 +0200
Subject: [LTP] [PATCH v2 2/2] syscalls/mbind: cleanup and rewrite
 mbind01 into new API
In-Reply-To: <20170829153509.12613-2-pvorel@suse.cz>
References: <20170829153509.12613-1-pvorel@suse.cz>
 <20170829153509.12613-2-pvorel@suse.cz>
Message-ID: <4aff45ce-f45f-147d-e9c2-80eca59d74ec@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Petr,

I suggest changes below on top of your v2:
- drop HAVE_LINUX_MEMPOLICY_H, as it's not used by test
- replace no_check_nodemask with "expected nodemask",
- drop zero-ing of "nodemask" for MPOL_DEFAULT case, it's not needed anymore
- add "static" to global variables/functions
- print masks if comparison fails (tst_res_hexd)
- collapse no numa and numa == v1 into single main() function

No need to re-post if you are OK with the changes.

Regards,
Jan

diff --git a/testcases/kernel/syscalls/mbind/mbind01.c b/testcases/kernel/syscalls/mbind/mbind01.c
index 8db1deeb579c..648cdab97880 100644
--- a/testcases/kernel/syscalls/mbind/mbind01.c
+++ b/testcases/kernel/syscalls/mbind/mbind01.c
@@ -25,9 +25,8 @@

 #include "numa_helper.h"

-#if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H && \
-	HAVE_MPOL_CONSTANTS
-#if defined(LIBNUMA_API_VERSION) && LIBNUMA_API_VERSION == 2
+#if HAVE_NUMA_H && HAVE_NUMAIF_H && HAVE_MPOL_CONSTANTS && \
+	defined(LIBNUMA_API_VERSION) && LIBNUMA_API_VERSION >= 2
 #include "tst_test.h"

 #define MEM_LENGTH (4 * 1024 * 1024)
@@ -37,20 +36,20 @@
 #define POLICY_DESC(x) .policy = x, .desc = #x
 #define POLICY_DESC_TEXT(x, y) .policy = x, .desc = #x" ("y")"

-struct bitmask *nodemask, *getnodemask;
+static struct bitmask *nodemask, *getnodemask, *empty_nodemask;

-void test_default(unsigned int i, char *p);
-void test_none(unsigned int i, char *p);
-void test_invalid_nodemask(unsigned int i, char *p);
+static void test_default(unsigned int i, char *p);
+static void test_none(unsigned int i, char *p);
+static void test_invalid_nodemask(unsigned int i, char *p);

 struct test_case {
 	int policy;
 	const char *desc;
 	unsigned flags;
-	unsigned no_check_nodemask;
 	int ret;
 	int err;
 	void (*test)(unsigned int, char *);
+	struct bitmask **exp_nodemask;
 };

 static struct test_case tcase[] = {
@@ -59,6 +58,7 @@ static struct test_case tcase[] = {
 		.ret = 0,
 		.err = 0,
 		.test = test_none,
+		.exp_nodemask = &empty_nodemask,
 	},
 	{
 		POLICY_DESC_TEXT(MPOL_DEFAULT, "target exists"),
@@ -77,6 +77,7 @@ static struct test_case tcase[] = {
 		.ret = 0,
 		.err = 0,
 		.test = test_default,
+		.exp_nodemask = &nodemask,
 	},
 	{
 		POLICY_DESC_TEXT(MPOL_INTERLEAVE, "no target"),
@@ -89,11 +90,11 @@ static struct test_case tcase[] = {
 		.ret = 0,
 		.err = 0,
 		.test = test_default,
+		.exp_nodemask = &nodemask,
 	},
 	{
-		POLICY_DESC(MPOL_PREFERRED),
+		POLICY_DESC_TEXT(MPOL_PREFERRED, "no target"),
 		.ret = 0,
-		.no_check_nodemask = 1,
 		.err = 0,
 		.test = test_none,
 	},
@@ -102,6 +103,7 @@ static struct test_case tcase[] = {
 		.ret = 0,
 		.err = 0,
 		.test = test_default,
+		.exp_nodemask = &nodemask,
 	},
 	{
 		POLICY_DESC(UNKNOWN_POLICY),
@@ -124,19 +126,25 @@ static struct test_case tcase[] = {
 	},
 };

-void test_default(unsigned int i, char *p) {
+static void test_default(unsigned int i, char *p)
+{
 	struct test_case *tc = &tcase[i];
+
 	TEST(mbind(p, MEM_LENGTH, tc->policy, nodemask->maskp,
 		   nodemask->size, tc->flags));
 }

-void test_none(unsigned int i, char *p) {
+static void test_none(unsigned int i, char *p)
+{
 	struct test_case *tc = &tcase[i];
+
 	TEST(mbind(p, MEM_LENGTH, tc->policy, NULL, 0, tc->flags));
 }

-void test_invalid_nodemask(unsigned int i, char *p) {
+static void test_invalid_nodemask(unsigned int i, char *p)
+{
 	struct test_case *tc = &tcase[i];
+
 	/* use invalid nodemask (64 MiB after heap) */
 	TEST(mbind(p, MEM_LENGTH, tc->policy, sbrk(0) + 64*1024*1024,
 		   NUMA_NUM_NODES, tc->flags));
@@ -146,6 +154,7 @@ static void setup(void)
 {
 	if (!is_numa(NULL, NH_MEMS, 1))
 		tst_brk(TCONF, "requires NUMA with at least 1 node");
+	empty_nodemask = numa_allocate_nodemask();
 }

 static void setup_node(void)
@@ -163,7 +172,7 @@ static void setup_node(void)
 static void do_test(unsigned int i)
 {
 	struct test_case *tc = &tcase[i];
-	int policy;
+	int policy, fail = 0;
 	char *p = NULL;

 	tst_res(TINFO, "case %s", tc->desc);
@@ -182,58 +191,53 @@ static void do_test(unsigned int i)
 		TEST(get_mempolicy(&policy, getnodemask->maskp,
 				   getnodemask->size, p, MPOL_F_ADDR));
 		if (TEST_RETURN < 0) {
-			tst_res(TFAIL | TERRNO, "get_mempolicy failed");
+			tst_res(TFAIL | TTERRNO, "get_mempolicy failed");
 			return;
 		}
-
-		/* get_mempolicy doesn't return nodemask for policy MPOL_DEFAULT */
-		if (tc->policy == MPOL_DEFAULT)
-			numa_bitmask_clearall(nodemask);
-
 		if (tc->policy != policy) {
 			tst_res(TFAIL, "Wrong policy: %d, expected: %d",
 				tc->policy, policy);
-			return;
+			fail = 1;
 		}
-
-		if (!tc->no_check_nodemask && !numa_bitmask_equal(nodemask,
-								  getnodemask)) {
-			tst_res(TFAIL, "masks are not equal");
-			return;
+		if (tc->exp_nodemask) {
+			struct bitmask *exp_mask = *(tc->exp_nodemask);
+
+			if (!numa_bitmask_equal(exp_mask, getnodemask)) {
+				tst_res(TFAIL, "masks are not equal");
+				tst_res_hexd(TINFO, exp_mask->maskp,
+					exp_mask->size / 8, "exp_mask: ");
+				tst_res_hexd(TINFO, getnodemask->maskp,
+					getnodemask->size / 8, "returned: ");
+				fail = 1;
+			}
 		}
 	}

-	if (TEST_ERRNO != tc->err)
-		tst_res(TFAIL | TERRNO, "test mbind() failed: %d, expected: %d",
-			TEST_ERRNO, tc->err);
-	else if (TEST_RETURN != tc->ret)
-		tst_res(TFAIL | TERRNO,
-			"test mbind() wrong return code: %ld, expected: %d",
+	if (TEST_RETURN != tc->ret) {
+		tst_res(TFAIL, "wrong return code: %ld, expected: %d",
 			TEST_RETURN, tc->ret);
-	else
+		fail = 1;
+	}
+	if (TEST_RETURN == -1 && TEST_ERRNO != tc->err) {
+		tst_res(TFAIL | TTERRNO, "expected errno: %s, got",
+			tst_strerrno(tc->err));
+		fail = 1;
+	}
+	if (!fail)
 		tst_res(TPASS, "Test passed");
 }

-
 static struct tst_test test = {
 	.tcnt = ARRAY_SIZE(tcase),
 	.test = do_test,
 	.setup = setup,
 };

-#else /* libnuma v1 */
-#define TST_NO_DEFAULT_MAIN
-#include "tst_test.h"
-int main(void)
-{
-	tst_brk(TCONF, "test is only supported on libnuma v2.");
-}
-#endif
-#else /* no NUMA */
+#else /* libnuma >= 2 */
 #define TST_NO_DEFAULT_MAIN
 #include "tst_test.h"
 int main(void)
 {
-	tst_brk(TCONF, "system doesn't have required numa support");
+	tst_brk(TCONF, "test requires libnuma >= 2.");
 }
 #endif

