Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zliu@redhat.com>) id 1UGAwO-000312-4x
	for ltp-list@lists.sourceforge.net; Thu, 14 Mar 2013 16:23:40 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UGAwN-00010M-7t
	for ltp-list@lists.sourceforge.net; Thu, 14 Mar 2013 16:23:40 +0000
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r2EGNX3K005315
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 14 Mar 2013 12:23:33 -0400
From: Zhouping Liu <zliu@redhat.com>
Date: Fri, 15 Mar 2013 00:21:37 +0800
Message-Id: <440365316588480d26f3c7c12fb4366e58d87848.1363246555.git.zliu@redhat.com>
In-Reply-To: <1af53e534fc05433ed20488c27d35bbc519af730.1363246555.git.zliu@redhat.com>
References: <cover.1363246555.git.zliu@redhat.com>
	<054d2c7ca1e3c6e4794c0f42f927b555a4273da7.1363246555.git.zliu@redhat.com>
	<1af53e534fc05433ed20488c27d35bbc519af730.1363246555.git.zliu@redhat.com>
In-Reply-To: <cover.1363246555.git.zliu@redhat.com>
References: <cover.1363246555.git.zliu@redhat.com>
Subject: [LTP] [PATCH 3/5] mm/oom0[3|4]: added 'OOM for CPUSET' and updated
	'OOM with MEMCG & numa'
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

OOM with the combination of memcg & numa was moved to oom03,
and the case is re-design to be used to test OOM with CPUSET.

The patch also introduce a new global var ISNUMA, which
is easily used to recognize a NUMA system.

Signed-off-by: Zhouping Liu <zliu@redhat.com>
---
 testcases/kernel/mem/include/mem.h |  2 ++
 testcases/kernel/mem/lib/mem.c     |  2 ++
 testcases/kernel/mem/oom/oom03.c   | 24 +++++++++++++++
 testcases/kernel/mem/oom/oom04.c   | 63 ++++++++++++++++----------------------
 4 files changed, 54 insertions(+), 37 deletions(-)

diff --git a/testcases/kernel/mem/include/mem.h b/testcases/kernel/mem/include/mem.h
index 1233493..de51838 100644
--- a/testcases/kernel/mem/include/mem.h
+++ b/testcases/kernel/mem/include/mem.h
@@ -24,6 +24,8 @@
 #define MLOCK			3
 #define KSM			4
 
+extern int ISNUMA;
+
 long overcommit;
 void oom(int testcase, int mempolicy, int lite);
 void testoom(int mempolicy, int lite, int numa);
diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
index a71bc90..e99dae7 100644
--- a/testcases/kernel/mem/lib/mem.c
+++ b/testcases/kernel/mem/lib/mem.c
@@ -24,6 +24,8 @@
 #include "mem.h"
 #include "numa_helper.h"
 
+int ISNUMA = 0; /* mark a NUMA system */
+
 /* OOM */
 
 static int _alloc_mem(long int length, int testcase)
diff --git a/testcases/kernel/mem/oom/oom03.c b/testcases/kernel/mem/oom/oom03.c
index 95e34d5..4365c2b 100644
--- a/testcases/kernel/mem/oom/oom03.c
+++ b/testcases/kernel/mem/oom/oom03.c
@@ -40,6 +40,10 @@
 char *TCID = "oom03";
 int TST_TOTAL = 1;
 
+#if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
+	&& HAVE_MPOL_CONSTANTS
+#include <numaif.h>
+
 int main(int argc, char *argv[])
 {
 	char *msg;
@@ -76,6 +80,14 @@ int main(int argc, char *argv[])
 			write_file(MEMCG_SW_LIMIT, mem);
 			testoom(0, 1, 0);
 		}
+
+		/* OOM for MEMCG with mempolicy */
+		if (ISNUMA) {
+			tst_resm(TINFO, "OOM on MEMCG & mempolicy...");
+			testoom(MPOL_BIND, 0, 1);
+			testoom(MPOL_INTERLEAVE, 0, 1);
+			testoom(MPOL_PREFERRED, 0, 1);
+		}
 	}
 	cleanup();
 	tst_exit();
@@ -87,6 +99,10 @@ void setup(void)
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 	TEST_PAUSE;
 
+	/* rough estimate a NUMA system by max_node id */
+	if (numa_max_node() > 0)
+		ISNUMA = 1;
+
 	overcommit = get_sys_tune("overcommit_memory");
 	set_sys_tune("overcommit_memory", 1, 1);
 	mount_mem("memcg", "cgroup", "memory", MEMCG_PATH, MEMCG_PATH_NEW);
@@ -99,3 +115,11 @@ void cleanup(void)
 
 	TEST_CLEANUP;
 }
+
+#else
+int main(void)
+{
+	tst_brkm(TCONF, NULL, "no NUMA development packages installed.");
+}
+#endif
+
diff --git a/testcases/kernel/mem/oom/oom04.c b/testcases/kernel/mem/oom/oom04.c
index bc51046..6acc783 100644
--- a/testcases/kernel/mem/oom/oom04.c
+++ b/testcases/kernel/mem/oom/oom04.c
@@ -1,5 +1,5 @@
 /*
- * Out Of Memory (OOM) for Memory Resource Controller and NUMA
+ * Out Of Memory (OOM) for CPUSET
  *
  * The program is designed to cope with unpredictable like amount and
  * system physical memory, swap size and other VMM technology like KSM,
@@ -44,12 +44,12 @@ int TST_TOTAL = 1;
 
 #if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
 	&& HAVE_MPOL_CONSTANTS
+#include <numa.h>
+
 int main(int argc, char *argv[])
 {
 	char *msg;
 	int lc;
-	int swap_acc_on = 1;
-	char buf[BUFSIZ], mem[BUFSIZ];
 
 	msg = parse_opts(argc, argv, NULL, NULL);
 	if (msg != NULL)
@@ -64,38 +64,19 @@ int main(int argc, char *argv[])
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		tst_count = 0;
 
-		snprintf(buf, BUFSIZ, "%d", getpid());
-		write_file(MEMCG_PATH_NEW "/tasks", buf);
-
-		snprintf(mem, BUFSIZ, "%ld", TESTMEM);
-		write_file(MEMCG_PATH_NEW "/memory.limit_in_bytes", mem);
-
-		if (access(MEMCG_SW_LIMIT, F_OK) == -1) {
-			if (errno == ENOENT) {
-				tst_resm(TCONF,
-					 "memcg swap accounting is disabled");
-				swap_acc_on = 0;
-			} else
-				tst_brkm(TBROK | TERRNO, cleanup, "access");
-		}
-
-		tst_resm(TINFO, "process mempolicy.");
-		testoom(1, 0, 1);
-
-		if (swap_acc_on) {
-			write_file(MEMCG_SW_LIMIT, mem);
-			testoom(1, 1, 1);
-		}
-
-		tst_resm(TINFO, "process cpuset.");
-
-		if (swap_acc_on)
-			write_file(MEMCG_SW_LIMIT, "-1");
-		testoom(0, 0, 1);
-
-		if (swap_acc_on) {
-			write_file(MEMCG_SW_LIMIT, mem);
-			testoom(0, 1, 1);
+		tst_resm(TINFO, "OOM on CPUSET...");
+		testoom(0, 0, 0);
+
+		if (ISNUMA) {
+			/*
+			 * Under NUMA system, the migration of cpuset's memory
+			 * is in charge of cpuset.memory_migrate, we can write
+			 * 1 to cpuset.memory_migrate to enable the migration.
+			 */
+			write_cpuset_files(CPATH_NEW,
+					   "memory_migrate", "1");
+			tst_resm(TINFO, "OOM on CPUSET with mem migrate:");
+			testoom(0, 0, 0);
 		}
 	}
 	cleanup();
@@ -111,14 +92,22 @@ void setup(void)
 	overcommit = get_sys_tune("overcommit_memory");
 	set_sys_tune("overcommit_memory", 1, 1);
 	mount_mem("cpuset", "cpuset", NULL, CPATH, CPATH_NEW);
-	mount_mem("memcg", "cgroup", "memory", MEMCG_PATH, MEMCG_PATH_NEW);
+
+	/* rough estimate a NUMA system through max_node */
+	if (numa_max_node() > 0) {
+		ISNUMA = 1;
+		/* For NUMA system, using the first node for cpuset.mems */
+		write_cpusets(get_a_numa_node(cleanup));
+	} else {
+		/* For nonNUMA system, using node0 for cpuset.mems */
+		write_cpusets(0);
+	}
 }
 
 void cleanup(void)
 {
 	set_sys_tune("overcommit_memory", overcommit, 0);
 	umount_mem(CPATH, CPATH_NEW);
-	umount_mem(MEMCG_PATH, MEMCG_PATH_NEW);
 
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
