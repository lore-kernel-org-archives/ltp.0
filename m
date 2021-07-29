From: Li Wang <liwang@redhat.com>
Date: Thu, 29 Jul 2021 21:25:12 +0800
Subject: [LTP] [PATCH 1/3] mbind01: make use of tst_numa_mode_name
Message-ID: <20210729132514.1699551-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add MPOL_LOCAL and adjust some mempolicy mode modes order.
To prettify the error log of mbind01.

Signed-off-by: Li Wang <liwang@redhat.com>
---
 libs/libltpnuma/tst_numa.c                |  7 +++++--
 testcases/kernel/syscalls/mbind/mbind01.c | 10 ++++++----
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/libs/libltpnuma/tst_numa.c b/libs/libltpnuma/tst_numa.c
index 56c8640ff..d2241eeae 100644
--- a/libs/libltpnuma/tst_numa.c
+++ b/libs/libltpnuma/tst_numa.c
@@ -16,6 +16,7 @@
 #define TST_NO_DEFAULT_MAIN
 #include "tst_test.h"
 #include "tst_numa.h"
+#include "lapi/numaif.h"
 
 void tst_nodemap_print_counters(struct tst_nodemap *nodes)
 {
@@ -50,12 +51,14 @@ const char *tst_numa_mode_name(int mode)
 	switch (mode) {
 	case MPOL_DEFAULT:
 		return "MPOL_DEFAULT";
-	case MPOL_BIND:
-		return "MPOL_BIND";
 	case MPOL_PREFERRED:
 		return "MPOL_PREFERRED";
+	case MPOL_BIND:
+		return "MPOL_BIND";
 	case MPOL_INTERLEAVE:
 		return "MPOL_INTERLEAVE";
+	case MPOL_LOCAL:
+		return "MPOL_LOCAL";
 	default:
 		return "???";
 	}
diff --git a/testcases/kernel/syscalls/mbind/mbind01.c b/testcases/kernel/syscalls/mbind/mbind01.c
index de46c9381..5a2f37307 100644
--- a/testcases/kernel/syscalls/mbind/mbind01.c
+++ b/testcases/kernel/syscalls/mbind/mbind01.c
@@ -17,6 +17,7 @@
 #include "config.h"
 #include "numa_helper.h"
 #include "tst_test.h"
+#include "tst_numa.h"
 #include "lapi/numaif.h"
 
 #ifdef HAVE_NUMA_V2
@@ -124,9 +125,9 @@ static struct test_case tcase[] = {
 static void check_policy_pref_no_target(int policy)
 {
 	if (policy != MPOL_PREFERRED && policy != MPOL_LOCAL) {
-		tst_res(TFAIL, "Wrong policy: %d, "
+		tst_res(TFAIL, "Wrong policy: %s(%d), "
 			"expected MPOL_PREFERRED or MPOL_LOCAL",
-			policy);
+			tst_numa_mode_name(policy), policy);
 	}
 }
 
@@ -200,8 +201,9 @@ static void do_test(unsigned int i)
 		if (tc->check_policy)
 			tc->check_policy(policy);
 		else if (tc->policy != policy) {
-			tst_res(TFAIL, "Wrong policy: %d, expected: %d",
-				policy, tc->policy);
+			tst_res(TFAIL, "Wrong policy: %s(%d), expected: %s(%d)",
+				tst_numa_mode_name(policy), policy,
+				tst_numa_mode_name(tc->policy), tc->policy);
 			fail = 1;
 		}
 		if (tc->exp_nodemask) {
-- 
2.31.1

