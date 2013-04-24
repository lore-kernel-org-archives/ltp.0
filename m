Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zliu@redhat.com>) id 1UUq0J-0001Ph-Jp
	for ltp-list@lists.sourceforge.net; Wed, 24 Apr 2013 03:04:19 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UUq0H-0001lb-Hj
	for ltp-list@lists.sourceforge.net; Wed, 24 Apr 2013 03:04:19 +0000
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r3O34Bxt012341
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 23 Apr 2013 23:04:11 -0400
From: Zhouping Liu <zliu@redhat.com>
Date: Wed, 24 Apr 2013 11:02:04 +0800
Message-Id: <78191d90d19975e03308f3c05d0bf66fd1471ba5.1366772430.git.zliu@redhat.com>
Subject: [LTP] [PATCH] mem/oom: fixed a cpuset error
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

For the below special NUMA system, oom0[4|5] failed:
 # numactl -H
 available: 2 nodes (0-1)
 node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27
 node 0 size: 0 MB
 node 0 free: 0 MB
 node 1 cpus:
 node 1 size: 16384 MB
 node 1 free: 14173 MB
 node distances:
 node   0   1
   0:  10  40
   1:  40  10

failed log:
 oom04       1  TBROK  :  write /dev/cpuset/1/cpuset.mems: errno=EINVAL(22): Invalid argument

The reason is that node0 only contains all CPUs, no any memory,
and node1 contains all memory, but no CPUs, in the previous codes,
we only do cpuset testing on a independent node, which caused the
sub-cpuset only contains CPUs or memory in one node, that's not
permitted. The patch fixed it.

Signed-off-by: Zhouping Liu <zliu@redhat.com>

Tested on serveral machines, all PASSed.
---
 testcases/kernel/mem/lib/mem.c   | 13 ++++++++++++-
 testcases/kernel/mem/oom/oom04.c | 19 +++++++++++++------
 testcases/kernel/mem/oom/oom05.c | 25 +++++++++++++++----------
 3 files changed, 40 insertions(+), 17 deletions(-)

diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
index 5397177..b2ad562 100644
--- a/testcases/kernel/mem/lib/mem.c
+++ b/testcases/kernel/mem/lib/mem.c
@@ -792,7 +792,18 @@ void write_cpusets(long nd)
 	write_cpuset_files(CPATH_NEW, "mems", buf);
 
 	gather_node_cpus(cpus, nd);
-	write_cpuset_files(CPATH_NEW, "cpus", cpus);
+	/*
+	 * If the 'nd' node didn't contains any CPUs,
+	 * the CPU0 will be used as the cpuset.cpus.
+	 */
+	if (strlen(cpus) != 0) {
+		write_cpuset_files(CPATH_NEW, "cpus", cpus);
+	} else {
+		tst_resm(TINFO, "No any CPUs in node%ld", nd);
+		tst_resm(TINFO, "Using CPU0 to cpuset.cpus "
+				"for the special scenario");
+		write_cpuset_files(CPATH_NEW, "cpus", "0");
+	}
 
 	SAFE_FILE_PRINTF(NULL, CPATH_NEW "/tasks", "%d", getpid());
 }
diff --git a/testcases/kernel/mem/oom/oom04.c b/testcases/kernel/mem/oom/oom04.c
index 4d3f2f4..40c1198 100644
--- a/testcases/kernel/mem/oom/oom04.c
+++ b/testcases/kernel/mem/oom/oom04.c
@@ -85,6 +85,8 @@ int main(int argc, char *argv[])
 
 void setup(void)
 {
+	int memnode, ret;
+
 	tst_require_root(NULL);
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 	TEST_PAUSE;
@@ -93,12 +95,17 @@ void setup(void)
 	set_sys_tune("overcommit_memory", 1, 1);
 
 	mount_mem("cpuset", "cpuset", NULL, CPATH, CPATH_NEW);
-	if (is_numa(cleanup) > 0)
-		/* For NUMA system, using the first node for cpuset.mems */
-		write_cpusets(get_a_numa_node(cleanup));
-	else
-		/* For nonNUMA system, using node0 for cpuset.mems */
-		write_cpusets(0);
+
+	/*
+	 * Not any nodes contains memory, so using get_allowed_nodes()
+	 * to get a memory node, the operation is also appropriate for
+	 * NonNUMA system.
+	 */
+	ret = get_allowed_nodes(NH_MEMS, 1, &memnode);
+	if (ret < 0)
+		tst_brkm(TBROK, NULL, "Got one memory node failed "
+				      "using get_allowed_nodes()");
+	write_cpusets(memnode);
 }
 
 void cleanup(void)
diff --git a/testcases/kernel/mem/oom/oom05.c b/testcases/kernel/mem/oom/oom05.c
index 15feba5..520d657 100644
--- a/testcases/kernel/mem/oom/oom05.c
+++ b/testcases/kernel/mem/oom/oom05.c
@@ -108,24 +108,29 @@ int main(int argc, char *argv[])
 
 void setup(void)
 {
+	int ret, memnode;
+
 	tst_require_root(NULL);
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 	TEST_PAUSE;
 
+	overcommit = get_sys_tune("overcommit_memory");
+	set_sys_tune("overcommit_memory", 1, 1);
+
 	mount_mem("memcg", "cgroup", "memory", MEMCG_PATH, MEMCG_PATH_NEW);
 	mount_mem("cpuset", "cpuset", NULL, CPATH, CPATH_NEW);
 	write_memcg();
 
-	set_sys_tune("overcommit_memory", 1, 1);
-
-	if (is_numa(cleanup))
-		/* For NUMA system, using the first node for cpuset.mems */
-		write_cpusets(get_a_numa_node(cleanup));
-	else
-		/* For nonNUMA system, using node0 for cpuset.mems */
-		write_cpusets(0);
-
-	overcommit = get_sys_tune("overcommit_memory");
+        /*
+	 * Not any nodes contains memory, so using get_allowed_nodes()
+	 * to get a memory node, the operation is also appropriate for
+	 * NonNUMA system.
+	 */
+	ret = get_allowed_nodes(NH_MEMS, 1, &memnode);
+	if (ret < 0)
+		tst_brkm(TBROK, NULL, "Got one memory node failed "
+				      "using get_allowed_nodes()");
+	write_cpusets(memnode);
 }
 
 void cleanup(void)
-- 
1.7.11.7


------------------------------------------------------------------------------
Try New Relic Now & We'll Send You this Cool Shirt
New Relic is the only SaaS-based application performance monitoring service 
that delivers powerful full stack analytics. Optimize and monitor your
browser, app, & servers with just a few lines of code. Try New Relic
and get this awesome Nerd Life shirt! http://p.sf.net/sfu/newrelic_d2d_apr
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
