Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zliu@redhat.com>) id 1UHnS2-0003o6-9N
	for ltp-list@lists.sourceforge.net; Tue, 19 Mar 2013 03:43:02 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UHnS1-0003FM-Gv
	for ltp-list@lists.sourceforge.net; Tue, 19 Mar 2013 03:43:02 +0000
Received: from int-mx02.intmail.prod.int.phx2.redhat.com
	(int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r2J3gue4007965
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 18 Mar 2013 23:42:56 -0400
From: Zhouping Liu <zliu@redhat.com>
Date: Tue, 19 Mar 2013 11:40:51 +0800
Message-Id: <60167c77dc6892bb5a1ae232782cffc107368db8.1363664213.git.zliu@redhat.com>
In-Reply-To: <ebfb6ab9d3fba5067be674e22118c4cd4cea4ba8.1363664213.git.zliu@redhat.com>
References: <cover.1363664213.git.zliu@redhat.com>
	<610d014b3e51b301d3f2adca6e8b068e62aba626.1363664213.git.zliu@redhat.com>
	<ebfb6ab9d3fba5067be674e22118c4cd4cea4ba8.1363664213.git.zliu@redhat.com>
In-Reply-To: <cover.1363664213.git.zliu@redhat.com>
References: <cover.1363664213.git.zliu@redhat.com>
Subject: [LTP] [PATCH v4 3/7] numa_helper: added a new function is_numa()
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

Added a new function is_numa(), which is desinged to judge
whether a system contains more than 1 available numa nodes
or not, and lots of cases need it.

Signed-off-by: Zhouping Liu <zliu@redhat.com>
---
 testcases/kernel/include/numa_helper.h |  1 +
 testcases/kernel/lib/numa_helper.c     | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/testcases/kernel/include/numa_helper.h b/testcases/kernel/include/numa_helper.h
index 8e82d7b..251fd54 100644
--- a/testcases/kernel/include/numa_helper.h
+++ b/testcases/kernel/include/numa_helper.h
@@ -34,5 +34,6 @@ unsigned long get_max_node(void);
 int get_allowed_nodes_arr(int flag, int *num_nodes, int **nodes);
 int get_allowed_nodes(int flag, int count, ...);
 void nh_dump_nodes();
+int is_numa(void (*cleanup_fn)(void));
 
 #endif
diff --git a/testcases/kernel/lib/numa_helper.c b/testcases/kernel/lib/numa_helper.c
index 4ab8e3c..4157816 100644
--- a/testcases/kernel/lib/numa_helper.c
+++ b/testcases/kernel/lib/numa_helper.c
@@ -265,3 +265,27 @@ void nh_dump_nodes()
 	print_node_info(NH_CPUS);
 	print_node_info(NH_MEMS | NH_CPUS);
 }
+
+/*
+ * is_numa - judge a system is NUMA system or not
+ * NOTE: the function is designed to try to find more than
+ *       1 available node, at least each node contains memory.
+ * WARN: Don't use this func in child, as it calls tst_brkm()
+ * RETURNS:
+ *     0 - it's not a NUMA system
+ *     1 - it's a NUMA system
+ */
+int is_numa(void (*cleanup_fn)(void))
+{
+	int ret;
+	int numa_nodes = 0;
+
+	ret = get_allowed_nodes_arr(NH_MEMS, &numa_nodes, NULL);
+	if (ret < 0)
+		tst_brkm(TBROK | TERRNO, cleanup_fn, "get_allowed_nodes_arr");
+
+	if (numa_nodes > 1)
+		return 1;
+	else
+		return 0;
+}
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
