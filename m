Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1S5vU8-0005rk-IC
	for ltp-list@lists.sourceforge.net; Fri, 09 Mar 2012 08:47:36 +0000
Received: from mail-tul01m020-f175.google.com ([209.85.214.175])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1S5vU7-0007xg-NK
	for ltp-list@lists.sourceforge.net; Fri, 09 Mar 2012 08:47:36 +0000
Received: by obqv19 with SMTP id v19so2442967obq.34
	for <ltp-list@lists.sourceforge.net>;
	Fri, 09 Mar 2012 00:47:30 -0800 (PST)
From: Caspar Zhang <caspar@casparzhang.com>
Date: Fri,  9 Mar 2012 16:46:21 +0800
Message-Id: <1331282781-31469-1-git-send-email-caspar@casparzhang.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.8.4"
Subject: [LTP] [PATCH 2/2] get_mempolicy: enable libnuma API == 2
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
To: LTP List <ltp-list@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------1.7.8.4
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


This patch enables get_mempolicy01 test when libnuma API version is 2.

Signed-off-by: Caspar Zhang <caspar@casparzhang.com>
---
 .../syscalls/get_mempolicy/get_mempolicy01.c       |   73 +++++++++++++-------
 1 files changed, 47 insertions(+), 26 deletions(-)


--------------1.7.8.4
Content-Type: text/x-patch;
	name="0002-get_mempolicy-enable-libnuma-API-2.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="0002-get_mempolicy-enable-libnuma-API-2.patch"

diff --git a/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c b/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c
index bea681b..75164d0 100644
--- a/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c
+++ b/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c
@@ -70,14 +70,8 @@ int  TST_TOTAL = 1;		   /* total number of tests in this file.   */
 
 #if HAVE_NUMA_H && HAVE_NUMAIF_H && HAVE_MPOL_CONSTANTS
 
-#if !defined(LIBNUMA_API_VERSION) || LIBNUMA_API_VERSION < 2
-
 #define MEM_LENGTH	(4 * 1024 * 1024)
 
-static int  do_test(struct test_case *tc);
-static void setup(void);
-static void cleanup(void);
-
 static int  testno;
 
 enum test_type {
@@ -198,6 +192,10 @@ static struct test_case tcase[] = {
 	},
 };
 
+static int  do_test(struct test_case *tc);
+static void setup(void);
+static void cleanup(void);
+
 int main(int argc, char **argv)
 {
 	int i, ret, lc;
@@ -225,16 +223,23 @@ static int do_test(struct test_case *tc)
 {
 	int ret, err, result, cmp_ok;
 	int policy, flags;
-	nodemask_t nodemask, getnodemask;
+#if !defined(LIBNUMA_API_VERSION) || LIBNUMA_API_VERSION < 2
+	nodemask_t *nodemask, *getnodemask;
 	unsigned long maxnode = NUMA_NUM_NODES;
+#else
+	struct bitmask *nodemask = numa_allocate_nodemask();
+	struct bitmask *getnodemask = numa_allocate_nodemask();
+#endif
 	char *p = NULL;
 	unsigned long len = MEM_LENGTH;
 
-	/* We assume that there is only one node(node0). */
-	nodemask_zero(&nodemask); /* Segfaults here with libnuma v2. */
-	nodemask_set(&nodemask, 0);
-	nodemask_zero(&getnodemask);
-
+#if !defined(LIBNUMA_API_VERSION) || LIBNUMA_API_VERSION < 2
+	nodemask_zero(nodemask);
+	nodemask_set(nodemask, 0);
+	nodemask_zero(getnodemask);
+#else
+	numa_bitmask_setbit(nodemask, 0);
+#endif
 	switch (tc->ttype) {
 	case DEFAULT:
 		flags = 0;
@@ -243,12 +248,18 @@ static int do_test(struct test_case *tc)
 			TEST(syscall(__NR_set_mempolicy, tc->policy,
 					    NULL, 0));
 		else
+#if !defined(LIBNUMA_API_VERSION) || LIBNUMA_API_VERSION < 2
+			TEST(syscall(__NR_set_mempolicy, tc->policy,
+					    nodemask, maxnode));
+#else
 			TEST(syscall(__NR_set_mempolicy, tc->policy,
-					    &nodemask, maxnode));
-		if (TESET_RETURN < 0) {
+					    nodemask->maskp, nodemask->size));
+#endif
+		if (TEST_RETURN < 0) {
 			tst_resm(TBROK|TERRNO, "set_mempolicy");
 			return -1;
 		}
+
 		break;
 	default:
 		flags = MPOL_F_ADDR;
@@ -260,32 +271,49 @@ static int do_test(struct test_case *tc)
 			TEST(syscall(__NR_mbind, p, len, tc->policy,
 					    NULL, 0, 0));
 		else
+#if !defined(LIBNUMA_API_VERSION) || LIBNUMA_API_VERSION < 2
+			TEST(syscall(__NR_mbind, p, len, tc->policy,
+					    nodemask, maxnode, 0));
+#else
 			TEST(syscall(__NR_mbind, p, len, tc->policy,
-					    &nodemask, maxnode, 0));
+					    nodemask->maskp, nodemask->size,
+					    0));
+#endif
 		if (TEST_RETURN < 0) {
 			tst_brkm(TBROK|TERRNO, cleanup, "mbind");
 			return -1;
 		}
 
 		if (tc->ttype == INVALID_POINTER)
-			p = NULL;
+			p = 0;
 
 		if (tc->ttype == INVALID_FLAGS)
 			flags = -1;
 	}
 	errno  = 0;
 	cmp_ok = 1;
-	TEST(ret = syscall(__NR_get_mempolicy, &policy, &getnodemask,
+#if !defined(LIBNUMA_API_VERSION) || LIBNUMA_API_VERSION < 2
+	TEST(ret = syscall(__NR_get_mempolicy, &policy, getnodemask,
 			    maxnode, p, flags));
+#else
+	TEST(ret = syscall(__NR_get_mempolicy, &policy, getnodemask->maskp,
+			    getnodemask->size, p, flags));
+#endif
 	err = errno;
 	if (ret < 0)
 		goto TEST_END;
 
 	/* if policy == MPOL_DEFAULT, get_mempolicy doesn't return nodemask */
 	if (tc->policy == MPOL_DEFAULT)
-		nodemask_zero(&nodemask);
+#if !defined(LIBNUMA_API_VERSION) || LIBNUMA_API_VERSION < 2
+		nodemask_zero(nodemask);
+	cmp_ok = (tc->policy == policy && (tc->from_node == NONE ||
+			    nodemask_equal(nodemask, getnodemask)));
+#else
+		numa_bitmask_clearall(nodemask);
 	cmp_ok = (tc->policy == policy && (tc->from_node == NONE ||
-			    nodemask_equal(&nodemask, &getnodemask)));
+			    numa_bitmask_equal(nodemask, getnodemask)));
+#endif
 TEST_END:
 	result = (err != tc->err) || !cmp_ok;
 	PRINT_RESULT_CMP(0, tc->ret, tc->err, ret, err, cmp_ok);
@@ -307,13 +335,6 @@ static void setup(void)
 #else
 int main(void)
 {
-	tst_brkm(TCONF, NULL, "XXX: test is broken on libnuma v2 "
-			"(read numa_helpers.h for more details).");
-}
-#endif
-#else
-int main(void)
-{
 	tst_brkm(TCONF, NULL, "System doesn't have required numa support");
 }
 #endif

--------------1.7.8.4
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Virtualization & Cloud Management Using Capacity Planning
Cloud computing makes use of virtualization - but cloud computing 
also focuses on allowing computing to be delivered as a service.
http://www.accelacomm.com/jaw/sfnl/114/51521223/
--------------1.7.8.4
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------1.7.8.4--



