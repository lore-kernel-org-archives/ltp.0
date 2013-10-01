Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1VR0GK-00043c-Gb
	for ltp-list@lists.sourceforge.net; Tue, 01 Oct 2013 13:45:16 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VR0GJ-0006xK-Gv
	for ltp-list@lists.sourceforge.net; Tue, 01 Oct 2013 13:45:16 +0000
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Tue,  1 Oct 2013 17:44:50 +0400
Message-Id: <1380635095-21403-4-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <1380635095-21403-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1380635095-21403-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH V2 3/8] cpuset/cpuset_syscall_test: fixes
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: vasily.isaenko@oracle.com, miaox@cn.fujitsu.com

cpuset_syscall_test.c:
I suppose that now there is no need in many '#if' and explicit
definition of functions get_mempolicy, set_mempolicy, mbind.
Including numa.h and numaif.h (as we do in the other testcases)
should be sufficient.

cpuset_syscall_testset.sh:
Since linux kernel 3.8.0 (commit 5606e3877ad8baea42f3a71ebde0a03622bbb551
"mm: numa: Migrate on reference policy") default task memory policy and
its output in /proc/<pid>/numa_maps changed.

For example in 3.7.10 for stack vma /proc/<pid>/numa_maps show:
 7fff81e01000 default stack anon=3 dirty=3 N3=3
but in 3.8.0:
 7fff08950000 prefer:3 stack anon=5 dirty=5 N2=4 N3=1

So modified a check in test 10 and removed unnessesary checks for "default"
memory policy from tests 14, 15, 16.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 .../cpuset/cpuset_syscall_test/Makefile            |    1 +
 .../cpuset_syscall_test/cpuset_syscall_test.c      |   61 +++++---------------
 .../cpuset_syscall_test/cpuset_syscall_testset.sh  |   16 +++--
 3 files changed, 25 insertions(+), 53 deletions(-)

diff --git a/testcases/kernel/controllers/cpuset/cpuset_syscall_test/Makefile b/testcases/kernel/controllers/cpuset/cpuset_syscall_test/Makefile
index 6565631..54393e7 100644
--- a/testcases/kernel/controllers/cpuset/cpuset_syscall_test/Makefile
+++ b/testcases/kernel/controllers/cpuset/cpuset_syscall_test/Makefile
@@ -26,6 +26,7 @@ include $(top_srcdir)/include/mk/testcases.mk
 include $(abs_srcdir)/../Makefile.inc
 
 LDLIBS                  += $(NUMA_LIBS)
+CPPFLAGS                += $(NUMA_CPPFLAGS)
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
 
diff --git a/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_test.c b/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_test.c
index 5c30763..dd35cd0 100644
--- a/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_test.c
+++ b/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_test.c
@@ -22,6 +22,7 @@
 
 #define _GNU_SOURCE
 
+#include "config.h"
 #include <sched.h>
 #include <unistd.h>
 #include <stdlib.h>
@@ -38,49 +39,29 @@
 #include <sys/shm.h>
 #include <syscall.h>
 #include <inttypes.h>
-#include "config.h"
-#include "linux_syscall_numbers.h"
+#if HAVE_NUMA_H
+#include <numa.h>
+#endif
+#if HAVE_NUMAIF_H
+#include <numaif.h>
+#endif
+
 #include "test.h"
 #include "usctest.h"
 
 char *TCID = "cpuset_syscall_test";
+int TST_TOTAL = 1;
 
-#if HAVE_LINUX_MEMPOLICY_H
-#include <linux/mempolicy.h>
+#if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
+	&& HAVE_MPOL_CONSTANTS
 
 #include "../cpuset_lib/cpuset.h"
 #include "../cpuset_lib/bitmask.h"
 
-int TST_TOTAL = 1;
-
-unsigned long mask;
-int test = -1;
-int flag_exit;
-int ret;
-
-#if HAVE_DECL_MPOL_F_MEMS_ALLOWED
-static int get_mempolicy(int *policy, unsigned long *nmask,
-			 unsigned long maxnode, void *addr, int flags)
-{
-	return ltp_syscall(__NR_get_mempolicy, policy, nmask, maxnode, addr,
-		flags);
-}
-#endif
-
-#if HAVE_DECL_MPOL_BIND
-static int mbind(void *start, unsigned long len, int policy,
-		 unsigned long *nodemask, unsigned long maxnode, unsigned flags)
-{
-	return ltp_syscall(__NR_mbind, start, len, policy, nodemask, maxnode,
-		       flags);
-}
-
-static int set_mempolicy(int policy, unsigned long *nodemask,
-			 unsigned long maxnode)
-{
-	return ltp_syscall(__NR_set_mempolicy, policy, nodemask, maxnode);
-}
-#endif
+static unsigned long mask;
+static int test = -1;
+static int flag_exit;
+static int ret;
 
 #define OPT_setaffinity		(SCHAR_MAX + 1)
 #define OPT_getaffinity		(SCHAR_MAX + 2)
@@ -178,20 +159,12 @@ void test_mbind(void)
 		return;
 	}
 	printf("%p\n", addr);
-#if HAVE_DECL_MPOL_BIND
 	ret = mbind(addr, len, MPOL_BIND, &mask, 8 * sizeof(mask), 0);
-#else
-	ret = 1;
-#endif
 }
 
 void test_set_mempolicy(void)
 {
-#if HAVE_DECL_MPOL_BIND
 	ret = set_mempolicy(MPOL_BIND, &mask, 8 * sizeof(mask));
-#else
-	ret = -1;
-#endif
 }
 
 void test_get_mempolicy(void)
@@ -213,12 +186,8 @@ void test_get_mempolicy(void)
 		ret = 1;
 		return;
 	}
-#if HAVE_DECL_MPOL_F_MEMS_ALLOWED
 	ret = get_mempolicy(NULL, bitmask_mask(nmask), bitmask_nbits(nmask), 0,
 			    MPOL_F_MEMS_ALLOWED);
-#else
-	ret = -1;
-#endif
 
 	bitmask_displaylist(str, 256, nmask);
 	puts(str);
diff --git a/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_testset.sh b/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_testset.sh
index 35e368c..af92373 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_testset.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_testset.sh
@@ -230,15 +230,20 @@ test10()
 	allowed_list=$(cat $TEST_PROCNUMA | grep "$memory_addr" | \
 			awk '{print $2}')
 	allowed_list="$(echo $allowed_list | sed -e s/bind://)"
-	test "$allowed_list" = "default"
+
+	task_policy=$(cat $TEST_PROCNUMA | grep -e "\s\+stack\s\+anon" | \
+			awk '{print $2}')
+
+	test "$allowed_list" = "$task_policy"
 	if [ $? -ne 0 ]; then
-		tst_resm TFAIL "Result(/proc/<pid>/status) = \"$allowed_list\", expect = \"default\")"
+		tst_resm TFAIL "Result(/proc/<pid>/status) = \"$allowed_list\",\
+			expect = \"$task_policy\")"
 		return 1
 	fi
 	return 0
 }
 
-# this function is used by case 11-16
+# this function is used by case 11-13
 # check_result <expect>
 check_result()
 {
@@ -279,8 +284,7 @@ test13()
 test14()
 {
 	do_syscall_test 0 0 --set_mempolicy=6 1 || return 1
-	check_result "default"
-	return $?
+	return 0
 }
 
 test15()
@@ -297,7 +301,6 @@ test15()
 		tst_resm TFAIL "Result(/proc/<pid>/status) = \"$allowed_list\", expect = \"0\")"
 		return 1
 	fi
-	check_result "default" || return 1
 	return 0
 }
 
@@ -315,7 +318,6 @@ test16()
 		tst_resm TFAIL "Result(/proc/<pid>/status) = \"$allowed_list\", expect = \"0-1\")"
 		return 1
 	fi
-	check_result "default" || return 1
 	return 0
 }
 
-- 
1.7.1


------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60134791&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
