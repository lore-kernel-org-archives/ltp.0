Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <czhang@redhat.com>) id 1QD9hf-0004UN-Ty
	for ltp-list@lists.sourceforge.net; Fri, 22 Apr 2011 06:18:55 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1QD9hd-0002xV-L7
	for ltp-list@lists.sourceforge.net; Fri, 22 Apr 2011 06:18:55 +0000
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p3M6IlR6001725
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 22 Apr 2011 02:18:47 -0400
From: Caspar Zhang <czhang@redhat.com>
Date: Fri, 22 Apr 2011 14:18:38 +0800
Message-Id: <e1b3ebd85b1f628673a0c93a1e93445da1bf1d4b.1303453106.git.czhang@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.1"
Subject: [LTP] [PATCH] hotplug: fix compile
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


commands.c in memory_hotplug uses nodemask_isset and nodemask_set
functions which are already declared in /usr/include/numa.h with NUMA
v1, thus would cause compile error on the system installed NUMA v1 libs
(e.g. RHEL 5). This patch fixes this issue.

Signed-off-by: Caspar Zhang <czhang@redhat.com>
---
 testcases/kernel/hotplug/memory_hotplug/commands.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)


--------------1.7.1
Content-Type: text/x-patch; name="0001-hotplug-fix-compile.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="0001-hotplug-fix-compile.patch"

diff --git a/testcases/kernel/hotplug/memory_hotplug/commands.c b/testcases/kernel/hotplug/memory_hotplug/commands.c
index 683ac92..4f8ab96 100644
--- a/testcases/kernel/hotplug/memory_hotplug/commands.c
+++ b/testcases/kernel/hotplug/memory_hotplug/commands.c
@@ -59,6 +59,7 @@
 #define MPOL_MF_WAIT    (1<<2)  /* Wait for existing pages to migrate */
 #endif
 
+#if defined(LIBNUMA_API_VERSION) && LIBNUMA_API_VERSION == 2
 static inline int nodemask_isset(nodemask_t *mask, int node)
 {
 	if ((unsigned)node >= NUMA_NUM_NODES)
@@ -74,6 +75,7 @@ static inline void nodemask_set(nodemask_t *mask, int node)
 	mask->n[node / (8*sizeof(unsigned long))] |=
 		(1UL<<(node%(8*sizeof(unsigned long))));
 }
+#endif
 
 static char *whitespace = " \t";
 
@@ -1336,4 +1338,4 @@ process_commands()
 
 	} while (1);
 }
-#endif
\ No newline at end of file
+#endif

--------------1.7.1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Fulfilling the Lean Software Promise
Lean software platforms are now widely adopted and the benefits have been 
demonstrated beyond question. Learn why your peers are replacing JEE 
containers with lightweight application servers - and what you can gain 
from the move. http://p.sf.net/sfu/vmware-sfemails
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



