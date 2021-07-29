From: Li Wang <liwang@redhat.com>
Date: Thu, 29 Jul 2021 21:25:13 +0800
Subject: [LTP] [PATCH 2/3] libs: rename tst_numa_mode_name to
 tst_mempolicy_mode_name
In-Reply-To: <20210729132514.1699551-1-liwang@redhat.com>
References: <20210729132514.1699551-1-liwang@redhat.com>
Message-ID: <20210729132514.1699551-2-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

To be precise describe the MPOL_* mempolicy mode and be consistent
with kernel's consuetude.

Signed-off-by: Li Wang <liwang@redhat.com>
---
 include/tst_numa.h                                        | 2 +-
 libs/libltpnuma/tst_numa.c                                | 2 +-
 testcases/kernel/syscalls/mbind/mbind01.c                 | 6 +++---
 testcases/kernel/syscalls/mbind/mbind02.c                 | 6 +++---
 testcases/kernel/syscalls/mbind/mbind03.c                 | 4 ++--
 testcases/kernel/syscalls/mbind/mbind04.c                 | 4 ++--
 testcases/kernel/syscalls/set_mempolicy/set_mempolicy01.c | 4 ++--
 testcases/kernel/syscalls/set_mempolicy/set_mempolicy03.c | 4 ++--
 8 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/include/tst_numa.h b/include/tst_numa.h
index 846e093a9..3af311e5e 100644
--- a/include/tst_numa.h
+++ b/include/tst_numa.h
@@ -38,7 +38,7 @@ void tst_nodemap_print_counters(struct tst_nodemap *nodes);
  *
  * @mode Numa mempolicy mode.
  */
-const char *tst_numa_mode_name(int mode);
+const char *tst_mempolicy_mode_name(int mode);
 
 /**
  * Maps pages into memory, if path is NULL the mapping is anonymous otherwise is backed by the file.
diff --git a/libs/libltpnuma/tst_numa.c b/libs/libltpnuma/tst_numa.c
index d2241eeae..e3e80f229 100644
--- a/libs/libltpnuma/tst_numa.c
+++ b/libs/libltpnuma/tst_numa.c
@@ -46,7 +46,7 @@ void tst_nodemap_free(struct tst_nodemap *nodes)
 
 #ifdef HAVE_NUMA_V2
 
-const char *tst_numa_mode_name(int mode)
+const char *tst_mempolicy_mode_name(int mode)
 {
 	switch (mode) {
 	case MPOL_DEFAULT:
diff --git a/testcases/kernel/syscalls/mbind/mbind01.c b/testcases/kernel/syscalls/mbind/mbind01.c
index 5a2f37307..d2cf13c8f 100644
--- a/testcases/kernel/syscalls/mbind/mbind01.c
+++ b/testcases/kernel/syscalls/mbind/mbind01.c
@@ -127,7 +127,7 @@ static void check_policy_pref_no_target(int policy)
 	if (policy != MPOL_PREFERRED && policy != MPOL_LOCAL) {
 		tst_res(TFAIL, "Wrong policy: %s(%d), "
 			"expected MPOL_PREFERRED or MPOL_LOCAL",
-			tst_numa_mode_name(policy), policy);
+			tst_mempolicy_mode_name(policy), policy);
 	}
 }
 
@@ -202,8 +202,8 @@ static void do_test(unsigned int i)
 			tc->check_policy(policy);
 		else if (tc->policy != policy) {
 			tst_res(TFAIL, "Wrong policy: %s(%d), expected: %s(%d)",
-				tst_numa_mode_name(policy), policy,
-				tst_numa_mode_name(tc->policy), tc->policy);
+				tst_mempolicy_mode_name(policy), policy,
+				tst_mempolicy_mode_name(tc->policy), tc->policy);
 			fail = 1;
 		}
 		if (tc->exp_nodemask) {
diff --git a/testcases/kernel/syscalls/mbind/mbind02.c b/testcases/kernel/syscalls/mbind/mbind02.c
index 01b3b3c69..4b0851e57 100644
--- a/testcases/kernel/syscalls/mbind/mbind02.c
+++ b/testcases/kernel/syscalls/mbind/mbind02.c
@@ -74,18 +74,18 @@ static void verify_policy(int mode)
 	if (TST_RET != -1) {
 		tst_res(TFAIL,
 		        "mbind(%s, MPOL_MF_STRICT) node %u returned %li, expected -1",
-		        tst_numa_mode_name(mode), node, TST_RET);
+		        tst_mempolicy_mode_name(mode), node, TST_RET);
 		return;
 	}
 
 	if (TST_ERR == EIO) {
 		tst_res(TPASS | TTERRNO,
 		        "mbind(%s, MPOL_MF_STRICT) node %u",
-		        tst_numa_mode_name(mode), node);
+		        tst_mempolicy_mode_name(mode), node);
 	} else {
 		tst_res(TFAIL | TTERRNO,
 			"mbind(%s, MPOL_MF_STRICT) node %u expected EIO",
-		        tst_numa_mode_name(mode), node);
+		        tst_mempolicy_mode_name(mode), node);
 	}
 }
 
diff --git a/testcases/kernel/syscalls/mbind/mbind03.c b/testcases/kernel/syscalls/mbind/mbind03.c
index c0750c804..392f89787 100644
--- a/testcases/kernel/syscalls/mbind/mbind03.c
+++ b/testcases/kernel/syscalls/mbind/mbind03.c
@@ -68,11 +68,11 @@ static void verify_policy(int mode, unsigned flag)
 	if (TST_RET) {
 		tst_res(TFAIL | TTERRNO,
 		        "mbind(%s, %s) node %u",
-		        tst_numa_mode_name(mode), mbind_flag_name(flag), node);
+		        tst_mempolicy_mode_name(mode), mbind_flag_name(flag), node);
 		goto exit;
 	} else {
 		tst_res(TPASS, "mbind(%s, %s) node %u succeded",
-		        tst_numa_mode_name(mode), mbind_flag_name(flag), node);
+		        tst_mempolicy_mode_name(mode), mbind_flag_name(flag), node);
 	}
 
 	tst_nodemap_reset_counters(nodes);
diff --git a/testcases/kernel/syscalls/mbind/mbind04.c b/testcases/kernel/syscalls/mbind/mbind04.c
index ea9966622..e7603691a 100644
--- a/testcases/kernel/syscalls/mbind/mbind04.c
+++ b/testcases/kernel/syscalls/mbind/mbind04.c
@@ -61,12 +61,12 @@ static void verify_policy(unsigned int node, int mode, unsigned flag)
 	if (TST_RET) {
 		tst_res(TFAIL | TTERRNO,
 		        "mbind(%s, %s) node %u",
-		        tst_numa_mode_name(mode), mbind_flag_name(flag), node);
+		        tst_mempolicy_mode_name(mode), mbind_flag_name(flag), node);
 		return;
 	}
 
 	tst_res(TPASS, "mbind(%s, %s) node %u",
-	        tst_numa_mode_name(mode), mbind_flag_name(flag), node);
+	        tst_mempolicy_mode_name(mode), mbind_flag_name(flag), node);
 
 	const char *prefix = "child: ";
 
diff --git a/testcases/kernel/syscalls/set_mempolicy/set_mempolicy01.c b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy01.c
index 96a275411..3f36fbe62 100644
--- a/testcases/kernel/syscalls/set_mempolicy/set_mempolicy01.c
+++ b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy01.c
@@ -55,12 +55,12 @@ static void verify_mempolicy(unsigned int node, int mode)
 	if (TST_RET) {
 		tst_res(TFAIL | TTERRNO,
 		        "set_mempolicy(%s) node %u",
-		        tst_numa_mode_name(mode), node);
+		        tst_mempolicy_mode_name(mode), node);
 		return;
 	}
 
 	tst_res(TPASS, "set_mempolicy(%s) node %u",
-	        tst_numa_mode_name(mode), node);
+	        tst_mempolicy_mode_name(mode), node);
 
 	numa_free_nodemask(bm);
 
diff --git a/testcases/kernel/syscalls/set_mempolicy/set_mempolicy03.c b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy03.c
index 24775de10..2fb43e98d 100644
--- a/testcases/kernel/syscalls/set_mempolicy/set_mempolicy03.c
+++ b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy03.c
@@ -54,12 +54,12 @@ static void verify_mempolicy(unsigned int node, int mode)
 	if (TST_RET) {
 		tst_res(TFAIL | TTERRNO,
 		        "set_mempolicy(%s) node %u",
-		        tst_numa_mode_name(mode), node);
+		        tst_mempolicy_mode_name(mode), node);
 		return;
 	}
 
 	tst_res(TPASS, "set_mempolicy(%s) node %u",
-	        tst_numa_mode_name(mode), node);
+	        tst_mempolicy_mode_name(mode), node);
 
 	numa_free_nodemask(bm);
 
-- 
2.31.1

