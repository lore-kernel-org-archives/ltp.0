Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <czhang@redhat.com>) id 1QHYGi-00040b-Rd
	for ltp-list@lists.sourceforge.net; Wed, 04 May 2011 09:21:16 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1QHYGe-0005C2-VL
	for ltp-list@lists.sourceforge.net; Wed, 04 May 2011 09:21:16 +0000
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p449L7X9029041
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 4 May 2011 05:21:07 -0400
From: Caspar Zhang <czhang@redhat.com>
Date: Wed,  4 May 2011 17:21:00 +0800
Message-Id: <dba8a1fa92ed925df7774c7be07f85407f0bea0c.1304500580.git.czhang@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.1"
Subject: [LTP] [PATCH] mem_hotplug: more compile err fix against NUMA v1
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
--------------1.7.1
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


commands.c still fail to compile under RHEL5 since it used a compat
function from NUMA API v2.

Signed-off-by: Caspar Zhang <czhang@redhat.com>
---
 testcases/kernel/hotplug/memory_hotplug/commands.c |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)


--------------1.7.1
Content-Type: text/x-patch;
	name="0001-mem_hotplug-more-compile-err-fix-against-NUMA-v1.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="0001-mem_hotplug-more-compile-err-fix-against-NUMA-v1.patch"

diff --git a/testcases/kernel/hotplug/memory_hotplug/commands.c b/testcases/kernel/hotplug/memory_hotplug/commands.c
index 4f8ab96..5216339 100644
--- a/testcases/kernel/hotplug/memory_hotplug/commands.c
+++ b/testcases/kernel/hotplug/memory_hotplug/commands.c
@@ -394,7 +394,11 @@ get_arg_nodeid_list(char *args, unsigned int *list)
 	int         node, count = 0;
 
         gcp = &glctx;
-        my_allowed_nodes = numa_get_membind_compat();
+#if defined(LIBNUMA_API_VERSION) && LIBNUMA_API_VERSION == 2
+	my_allowed_nodes = numa_get_membind_compat();
+#else
+	my_allowed_nodes = numa_get_membind();
+#endif
 	while (*args != '\0') {
 		if (!isdigit(*args)) {
 			fprintf(stderr, "%s:  expected digit for <node/list>\n",
@@ -452,7 +456,11 @@ get_current_nodeid_list(unsigned int *fromids)
 	int        node;
 
         gcp = &glctx;
-        my_allowed_nodes = numa_get_membind_compat();
+#if defined(LIBNUMA_API_VERSION) && LIBNUMA_API_VERSION == 2
+	my_allowed_nodes = numa_get_membind_compat();
+#else
+	my_allowed_nodes = numa_get_membind();
+#endif
 	for (node=0; node <= max_node; ++node) {
 		if (nodemask_isset(&my_allowed_nodes, node))
 			*(fromids + nr_nodes++) = node;

--------------1.7.1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
WhatsUp Gold - Download Free Network Management Software
The most intuitive, comprehensive, and cost-effective network 
management toolset available today.  Delivers lowest initial 
acquisition cost and overall TCO of any competing solution.
http://p.sf.net/sfu/whatsupgold-sd
--------------1.7.1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------1.7.1--



