Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zliu@redhat.com>) id 1UGWC8-0004V6-Q3
	for ltp-list@lists.sourceforge.net; Fri, 15 Mar 2013 15:05:20 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UGWC7-00064S-M9
	for ltp-list@lists.sourceforge.net; Fri, 15 Mar 2013 15:05:20 +0000
Received: from int-mx01.intmail.prod.int.phx2.redhat.com
	(int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r2FF5DMX016418
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 15 Mar 2013 11:05:13 -0400
From: Zhouping Liu <zliu@redhat.com>
Date: Fri, 15 Mar 2013 23:03:09 +0800
Message-Id: <a5ee11cc800fc73683472eeb2ba71cea7472035c.1363358877.git.zliu@redhat.com>
In-Reply-To: <5de33faa5b15f22e96d68d1b543eb4bcfc64cfb7.1363358877.git.zliu@redhat.com>
References: <cover.1363358877.git.zliu@redhat.com>
	<610d014b3e51b301d3f2adca6e8b068e62aba626.1363358877.git.zliu@redhat.com>
	<fd2789e70f79cb525ca7317061adab90f6387530.1363358877.git.zliu@redhat.com>
	<5de33faa5b15f22e96d68d1b543eb4bcfc64cfb7.1363358877.git.zliu@redhat.com>
In-Reply-To: <cover.1363358877.git.zliu@redhat.com>
References: <cover.1363358877.git.zliu@redhat.com>
Subject: [LTP] [PATCH v2 4/7] mm/oom0[3|4]: added 'OOM for CPUSET' and moved
	'OOM with MEMCG & numa' to oom03
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
and oom04 is re-design to be used to test 'OOM with CPUSET'.

also used is_numa() instead of the old method.

Signed-off-by: Zhouping Liu <zliu@redhat.com>
---
 testcases/kernel/mem/oom/oom02.c |  6 ++--
 testcases/kernel/mem/oom/oom03.c | 20 ++++++++++++++
 testcases/kernel/mem/oom/oom04.c | 60 +++++++++++++++-------------------------
 3 files changed, 46 insertions(+), 40 deletions(-)

diff --git a/testcases/kernel/mem/oom/oom02.c b/testcases/kernel/mem/oom/oom02.c
index 31ec73f..3bc8567 100644
--- a/testcases/kernel/mem/oom/oom02.c
+++ b/testcases/kernel/mem/oom/oom02.c
@@ -35,6 +35,7 @@
 #include <errno.h>
 #include <fcntl.h>
 #include <stdio.h>
+#include "numa_helper.h"
 #include "test.h"
 #include "usctest.h"
 #include "mem.h"
@@ -44,7 +45,6 @@ int TST_TOTAL = 1;
 
 #if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
 	&& HAVE_MPOL_CONSTANTS
-#include <numaif.h>
 
 int main(int argc, char *argv[])
 {
@@ -83,8 +83,8 @@ void setup(void)
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 	TEST_PAUSE;
 
-	/* Judge a NUMA system through get_a_numa_node */
-	get_a_numa_node(NULL);
+	if (!is_numa(NULL))
+		tst_brkm(TCONF, NULL, "The case need a NUMA system.");
 
 	overcommit = get_sys_tune("overcommit_memory");
 	set_sys_tune("overcommit_memory", 1, 1);
diff --git a/testcases/kernel/mem/oom/oom03.c b/testcases/kernel/mem/oom/oom03.c
index 95e34d5..c2171fd 100644
--- a/testcases/kernel/mem/oom/oom03.c
+++ b/testcases/kernel/mem/oom/oom03.c
@@ -33,6 +33,7 @@
 #include <errno.h>
 #include <fcntl.h>
 #include <stdio.h>
+#include "numa_helper.h"
 #include "test.h"
 #include "usctest.h"
 #include "mem.h"
@@ -40,6 +41,9 @@
 char *TCID = "oom03";
 int TST_TOTAL = 1;
 
+#if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
+	&& HAVE_MPOL_CONSTANTS
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
+		if (is_numa(cleanup)) {
+			tst_resm(TINFO, "OOM on MEMCG & mempolicy...");
+			testoom(MPOL_BIND, 0, 1);
+			testoom(MPOL_INTERLEAVE, 0, 1);
+			testoom(MPOL_PREFERRED, 0, 1);
+		}
 	}
 	cleanup();
 	tst_exit();
@@ -99,3 +111,11 @@ void cleanup(void)
 
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
index bc51046..1ad7334 100644
--- a/testcases/kernel/mem/oom/oom04.c
+++ b/testcases/kernel/mem/oom/oom04.c
@@ -1,5 +1,5 @@
 /*
- * Out Of Memory (OOM) for Memory Resource Controller and NUMA
+ * Out Of Memory (OOM) for CPUSET
  *
  * The program is designed to cope with unpredictable like amount and
  * system physical memory, swap size and other VMM technology like KSM,
@@ -35,6 +35,7 @@
 #include <errno.h>
 #include <fcntl.h>
 #include <stdio.h>
+#include "numa_helper.h"
 #include "test.h"
 #include "usctest.h"
 #include "mem.h"
@@ -44,12 +45,11 @@ int TST_TOTAL = 1;
 
 #if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
 	&& HAVE_MPOL_CONSTANTS
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
+		if (is_numa(cleanup)) {
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
@@ -110,15 +91,20 @@ void setup(void)
 
 	overcommit = get_sys_tune("overcommit_memory");
 	set_sys_tune("overcommit_memory", 1, 1);
+
 	mount_mem("cpuset", "cpuset", NULL, CPATH, CPATH_NEW);
-	mount_mem("memcg", "cgroup", "memory", MEMCG_PATH, MEMCG_PATH_NEW);
+	if (is_numa(cleanup) > 0)
+		/* For NUMA system, using the first node for cpuset.mems */
+		write_cpusets(get_a_numa_node(cleanup));
+	else
+		/* For nonNUMA system, using node0 for cpuset.mems */
+		write_cpusets(0);
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
