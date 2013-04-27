Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zliu@redhat.com>) id 1UVwhX-0006C3-13
	for ltp-list@lists.sourceforge.net; Sat, 27 Apr 2013 04:25:31 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UVwhV-0007yZ-Ij
	for ltp-list@lists.sourceforge.net; Sat, 27 Apr 2013 04:25:31 +0000
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r3R4PNLo023779
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Sat, 27 Apr 2013 00:25:23 -0400
From: Zhouping Liu <zliu@redhat.com>
Date: Sat, 27 Apr 2013 12:23:14 +0800
Message-Id: <bc3a8ce458b93dd36e09ea01c3001513f00462c4.1367036468.git.zliu@redhat.com>
Subject: [LTP] [PATCH v2] mem/oom: fixed a cpuset error
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
sub-cpuset cgroup only contains CPUs or memory in one node, but
that's not permitted in the special machine. The patch fixed it.

Signed-off-by: Zhouping Liu <zliu@redhat.com>
Reviewed-by: Caspar Zhang <caspar@casparzhang.com>
---
Change log:
 v1 - v2:
    fixed some grammar errors, and updated some comments.
   

 testcases/kernel/mem/lib/mem.c   | 14 +++++++++++++-
 testcases/kernel/mem/oom/oom04.c | 19 +++++++++++++------
 testcases/kernel/mem/oom/oom05.c | 25 +++++++++++++++----------
 3 files changed, 41 insertions(+), 17 deletions(-)

diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
index 5397177..62bbc95 100644
--- a/testcases/kernel/mem/lib/mem.c
+++ b/testcases/kernel/mem/lib/mem.c
@@ -792,7 +792,19 @@ void write_cpusets(long nd)
 	write_cpuset_files(CPATH_NEW, "mems", buf);
 
 	gather_node_cpus(cpus, nd);
-	write_cpuset_files(CPATH_NEW, "cpus", cpus);
+	/*
+	 * If the 'nd' node doesn't contain any CPUs,
+	 * the first ID of CPU '0' will be used as
+	 * the value of cpuset.cpus.
+	 */
+	if (strlen(cpus) != 0) {
+		write_cpuset_files(CPATH_NEW, "cpus", cpus);
+	} else {
+		tst_resm(TINFO, "None CPUs in the node%ld", nd);
+		tst_resm(TINFO, "Only use CPU0 in the cpuset cgroup "
+				"for the special scenario");
+		write_cpuset_files(CPATH_NEW, "cpus", "0");
+	}
 
 	SAFE_FILE_PRINTF(NULL, CPATH_NEW "/tasks", "%d", getpid());
 }
diff --git a/testcases/kernel/mem/oom/oom04.c b/testcases/kernel/mem/oom/oom04.c
index 4d3f2f4..dd9acd1 100644
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
+	 * Not any nodes contain memory, so using get_allowed_nodes(NH_MEMS)
+	 * to get a memory node, the operation also applies to Non-NUMA
+	 * system.
+	 */
+	ret = get_allowed_nodes(NH_MEMS, 1, &memnode);
+	if (ret < 0)
+		tst_brkm(TBROK, NULL, "Failed to get a memory node "
+				      "using get_allowed_nodes()");
+	write_cpusets(memnode);
 }
 
 void cleanup(void)
diff --git a/testcases/kernel/mem/oom/oom05.c b/testcases/kernel/mem/oom/oom05.c
index 15feba5..fd1b671 100644
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
+	 * Not any nodes contain memory, so using get_allowed_nodes(NH_MEMS)
+	 * to get a memory node, the operation also applies to Non-NUMA
+	 * system.
+	 */
+	ret = get_allowed_nodes(NH_MEMS, 1, &memnode);
+	if (ret < 0)
+		tst_brkm(TBROK, NULL, "Failed to get a memory node "
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
