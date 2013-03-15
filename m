Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zliu@redhat.com>) id 1UGWC6-0003Rb-8v
	for ltp-list@lists.sourceforge.net; Fri, 15 Mar 2013 15:05:18 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UGWC1-0004Wc-99
	for ltp-list@lists.sourceforge.net; Fri, 15 Mar 2013 15:05:18 +0000
Received: from int-mx01.intmail.prod.int.phx2.redhat.com
	(int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r2FF577h001901
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 15 Mar 2013 11:05:07 -0400
From: Zhouping Liu <zliu@redhat.com>
Date: Fri, 15 Mar 2013 23:03:07 +0800
Message-Id: <fd2789e70f79cb525ca7317061adab90f6387530.1363358877.git.zliu@redhat.com>
In-Reply-To: <610d014b3e51b301d3f2adca6e8b068e62aba626.1363358877.git.zliu@redhat.com>
References: <cover.1363358877.git.zliu@redhat.com>
	<610d014b3e51b301d3f2adca6e8b068e62aba626.1363358877.git.zliu@redhat.com>
In-Reply-To: <cover.1363358877.git.zliu@redhat.com>
References: <cover.1363358877.git.zliu@redhat.com>
Subject: [LTP] [PATCH v2 2/7] mm/oom02: modified 'OOM for NUMA' as 'OOM for
	mempolicy'
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
To: LTP List <ltp-list@lists.sourceforge.net>

NUMA mechanism can be interpreted as 'memory policy', there are
several mempolicys, such as MPOL_BIND, MPOL_INTERLEAVE,
MPOL_PREFERRED etc, not only MPOL_BIND, so the patch extended OOM
on NUMA system, added MPOL_INTERLEAVE and MPOL_PREFERRED mempolicy.

And the patch also moved 'set_mempolicy()' from child process, and
made it executed inside testoom() func, which is easy to control.

Signed-off-by: Zhouping Liu <zliu@redhat.com>
---
 testcases/kernel/mem/lib/mem.c   | 56 ++++++++++++++++++++++++++++------------
 testcases/kernel/mem/oom/oom02.c | 20 +++++++++-----
 2 files changed, 52 insertions(+), 24 deletions(-)

diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
index 72ac06d..15666fb 100644
--- a/testcases/kernel/mem/lib/mem.c
+++ b/testcases/kernel/mem/lib/mem.c
@@ -65,32 +65,17 @@ void oom(int testcase, int mempolicy, int lite)
 {
 	pid_t pid;
 	int status;
-#if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
-	&& HAVE_MPOL_CONSTANTS
-	unsigned long nmask = 0;
-	unsigned int node;
-
-	if (mempolicy)
-		node = get_a_numa_node(cleanup);
-	nmask += 1 << node;
-#endif
 
 	switch (pid = fork()) {
 	case -1:
 		tst_brkm(TBROK | TERRNO, cleanup, "fork");
 	case 0:
-#if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
-	&& HAVE_MPOL_CONSTANTS
-		if (mempolicy)
-			if (set_mempolicy(MPOL_BIND, &nmask, MAXNODES) == -1)
-				tst_brkm(TBROK | TERRNO, cleanup,
-					 "set_mempolicy");
-#endif
 		_test_alloc(testcase, lite);
 		exit(0);
 	default:
 		break;
 	}
+
 	tst_resm(TINFO, "expected victim is %d.", pid);
 	if (waitpid(-1, &status, 0) == -1)
 		tst_brkm(TBROK | TERRNO, cleanup, "waitpid");
@@ -108,7 +93,44 @@ void oom(int testcase, int mempolicy, int lite)
 
 void testoom(int mempolicy, int lite, int numa)
 {
-	long nodes[MAXNODES];
+#if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
+	&& HAVE_MPOL_CONSTANTS
+	unsigned long nmask = 0;
+	unsigned int num_nodes, *nodes;
+	int ret;
+
+	if (mempolicy) {
+		ret = get_allowed_nodes_arr(NH_MEMS|NH_CPUS, &num_nodes, &nodes);
+		if (ret != 0)
+			tst_brkm(TBROK|TERRNO, cleanup,
+				 "get_allowed_nodes_arr");
+		if (num_nodes < 2) {
+			tst_resm(TINFO, "mempolicy need NUMA system support");
+			return;
+		}
+		switch(mempolicy) {
+		case MPOL_BIND:
+			/* bind the second node */
+			nmask = 1 << nodes[1];
+			break;
+		case MPOL_INTERLEAVE:
+		case MPOL_PREFERRED:
+			if (num_nodes == 2) {
+				tst_resm(TINFO, "The mempolicy need "
+					 "more than 2 numa nodes");
+				return;
+			} else {
+				/* Using the 2nd,3rd node */
+				nmask = (1 << nodes[1]) | (1 << nodes[2]);
+			}
+			break;
+		default:
+			tst_brkm(TBROK|TERRNO, cleanup, "Bad mempolicy mode");
+		}
+		if (set_mempolicy(mempolicy, &nmask, MAXNODES) == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "set_mempolicy");
+	}
+#endif
 
 	if (numa && !mempolicy)
 		write_cpusets(get_a_numa_node(cleanup));
diff --git a/testcases/kernel/mem/oom/oom02.c b/testcases/kernel/mem/oom/oom02.c
index abd8aa2..31ec73f 100644
--- a/testcases/kernel/mem/oom/oom02.c
+++ b/testcases/kernel/mem/oom/oom02.c
@@ -1,5 +1,5 @@
 /*
- * Out Of Memory (OOM) for NUMA
+ * Out Of Memory (OOM) for mempolicy - need NUMA system support
  *
  * The program is designed to cope with unpredictable like amount and
  * system physical memory, swap size and other VMM technology like KSM,
@@ -44,6 +44,8 @@ int TST_TOTAL = 1;
 
 #if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
 	&& HAVE_MPOL_CONSTANTS
+#include <numaif.h>
+
 int main(int argc, char *argv[])
 {
 	char *msg;
@@ -62,11 +64,14 @@ int main(int argc, char *argv[])
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		tst_count = 0;
 
-		tst_resm(TINFO, "process mempolicy.");
-		testoom(1, 0, 1);
+		tst_resm(TINFO, "OOM on MPOL_BIND mempolicy...");
+		testoom(MPOL_BIND, 0, 1);
+
+		tst_resm(TINFO, "OOM on MPOL_INTERLEAVE mempolicy...");
+		testoom(MPOL_INTERLEAVE, 0, 1);
 
-		tst_resm(TINFO, "process cpuset.");
-		testoom(0, 0, 1);
+		tst_resm(TINFO, "OOM on MPOL_PREFERRED mempolicy...");
+		testoom(MPOL_PREFERRED, 0, 1);
 	}
 	cleanup();
 	tst_exit();
@@ -78,15 +83,16 @@ void setup(void)
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 	TEST_PAUSE;
 
+	/* Judge a NUMA system through get_a_numa_node */
+	get_a_numa_node(NULL);
+
 	overcommit = get_sys_tune("overcommit_memory");
 	set_sys_tune("overcommit_memory", 1, 1);
-	mount_mem("cpuset", "cpuset", NULL, CPATH, CPATH_NEW);
 }
 
 void cleanup(void)
 {
 	set_sys_tune("overcommit_memory", overcommit, 0);
-	umount_mem(CPATH, CPATH_NEW);
 
 	TEST_CLEANUP;
 }
-- 
1.7.11.7


------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_mar
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
