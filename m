From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 26 Jul 2021 14:53:05 +0200
Subject: [LTP] [PATCH] mbind01: accept MPOL_LOCAL when passing empty set for
 MPOL_PREFERRED
Message-ID: <3d693985aafc13fba1cd7c4fa807bbbddd015c7b.1627303875.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

When empty set is passed to MPOL_PREFERRED, memory is allocated
on the node of the CPU that triggered the allocation.

After kernel commit:
  7858d7bca7fb ("mm/mempolicy: don't handle MPOL_LOCAL like a fake MPOL_PREFERRED policy")
kernel returns stored policy as MPOL_LOCAL.

Per mhocko@suse.com in https://lists.linux.it/pipermail/ltp/2021-June/023037.html
  Strictly speaking this is breaking user interface but I am wondering
  whether this really matter or is completely unexpected ... I would
  be inclined to keep this inconsistency and see whether anybody
  actually complains and have a relevant use for this behavior.

Modify the test to accept either MPOL_PREFERRED or MPOL_LOCAL.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 include/lapi/numaif.h                     | 13 +++++++++++++
 testcases/kernel/syscalls/mbind/mbind01.c | 18 +++++++++++++++++-
 2 files changed, 30 insertions(+), 1 deletion(-)
 create mode 100644 include/lapi/numaif.h

diff --git a/include/lapi/numaif.h b/include/lapi/numaif.h
new file mode 100644
index 000000000000..32dfb565223e
--- /dev/null
+++ b/include/lapi/numaif.h
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2021 Linux Test Project
+ */
+
+#ifndef NUMAIF_H__
+#define NUMAIF_H__
+
+#ifndef MPOL_LOCAL
+# define MPOL_LOCAL	4
+#endif
+
+#endif /* NUMAIF_H__ */
diff --git a/testcases/kernel/syscalls/mbind/mbind01.c b/testcases/kernel/syscalls/mbind/mbind01.c
index bc713d78b5c8..0f9f7d3e62b7 100644
--- a/testcases/kernel/syscalls/mbind/mbind01.c
+++ b/testcases/kernel/syscalls/mbind/mbind01.c
@@ -17,6 +17,7 @@
 #include "config.h"
 #include "numa_helper.h"
 #include "tst_test.h"
+#include "lapi/numaif.h"
 
 #ifdef HAVE_NUMA_V2
 
@@ -32,6 +33,7 @@ static struct bitmask *nodemask, *getnodemask, *empty_nodemask;
 static void test_default(unsigned int i, char *p);
 static void test_none(unsigned int i, char *p);
 static void test_invalid_nodemask(unsigned int i, char *p);
+static void check_policy_pref_no_target(int);
 
 struct test_case {
 	int policy;
@@ -39,6 +41,7 @@ struct test_case {
 	unsigned flags;
 	int ret;
 	int err;
+	void (*check_policy)(int);
 	void (*test)(unsigned int, char *);
 	struct bitmask **exp_nodemask;
 };
@@ -88,6 +91,7 @@ static struct test_case tcase[] = {
 		.ret = 0,
 		.err = 0,
 		.test = test_none,
+		.check_policy = check_policy_pref_no_target,
 	},
 	{
 		POLICY_DESC(MPOL_PREFERRED),
@@ -117,6 +121,15 @@ static struct test_case tcase[] = {
 	},
 };
 
+static void check_policy_pref_no_target(int policy)
+{
+	if (policy != MPOL_PREFERRED && policy != MPOL_LOCAL) {
+		tst_res(TFAIL, "Wrong policy: %d, "
+			"expected MPOL_PREFERRED or MPOL_LOCAL",
+			policy);
+	}
+}
+
 static void test_default(unsigned int i, char *p)
 {
 	struct test_case *tc = &tcase[i];
@@ -183,7 +196,10 @@ static void do_test(unsigned int i)
 			tst_res(TFAIL | TTERRNO, "get_mempolicy failed");
 			return;
 		}
-		if (tc->policy != policy) {
+
+		if (tc->check_policy)
+			tc->check_policy(policy);
+		else if (tc->policy != policy) {
 			tst_res(TFAIL, "Wrong policy: %d, expected: %d",
 				tc->policy, policy);
 			fail = 1;
-- 
2.27.0

