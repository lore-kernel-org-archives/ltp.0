Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1SZHpS-0006uy-7x
	for ltp-list@lists.sourceforge.net; Tue, 29 May 2012 08:30:58 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SZHpR-00074I-Ie
	for ltp-list@lists.sourceforge.net; Tue, 29 May 2012 08:30:58 +0000
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q4T8UqIh032309
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 29 May 2012 04:30:52 -0400
Message-ID: <4FC4893A.6030909@redhat.com>
Date: Tue, 29 May 2012 10:30:50 +0200
From: Jan Stancek <jstancek@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050501050306020901090306"
Subject: [LTP] [PATCH v2 3/4] get_mempolicy01: dont use hardcoded NUMA node
	ids
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
To: ltp-list@lists.sourceforge.net
Cc: Jeffrey Burke <jburke@redhat.com>

This is a multi-part message in MIME format.
--------------050501050306020901090306
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/get_mempolicy/Makefile   |    7 ++-----
 .../syscalls/get_mempolicy/get_mempolicy01.c       |    8 ++++++--
 2 files changed, 8 insertions(+), 7 deletions(-)



--------------050501050306020901090306
Content-Type: text/x-patch;
	name="0003-get_mempolicy01-dont-use-hardcoded-NUMA-node-ids.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0003-get_mempolicy01-dont-use-hardcoded-NUMA-node-ids.patch"

diff --git a/testcases/kernel/syscalls/get_mempolicy/Makefile b/testcases/kernel/syscalls/get_mempolicy/Makefile
index 2791e85..333ad21 100644
--- a/testcases/kernel/syscalls/get_mempolicy/Makefile
+++ b/testcases/kernel/syscalls/get_mempolicy/Makefile
@@ -20,10 +20,7 @@ top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 
-CPPFLAGS		+= -g
-
-CPPFLAGS		+= -I$(abs_srcdir)/../utils $(NUMA_CPPFLAGS)
-
-LDLIBS			+= $(NUMA_LIBS)
+CPPFLAGS		+= -I$(abs_srcdir)/../utils
 
+include $(abs_srcdir)/../numa/Makefile.inc
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c b/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c
index 0565d6f..9011980 100644
--- a/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c
+++ b/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c
@@ -63,6 +63,7 @@
 #include "linux_syscall_numbers.h"
 #include "include_j_h.h"
 #include "common_j_h.c"
+#include "numa_helper.h"
 
 char *TCID = "get_mempolicy01";  /* Test program identifier.*/
 int  TST_TOTAL = 1;		   /* total number of tests in this file.   */
@@ -231,15 +232,18 @@ static int do_test(struct test_case *tc)
 #endif
 	char *p = NULL;
 	unsigned long len = MEM_LENGTH;
+	int test_node = -1;
 
+	if ((ret = get_allowed_nodes(1, &test_node)) < 0)
+		tst_brkm(TBROK|TERRNO, cleanup, "get_allowed_nodes(): %d", ret);
 #if !defined(LIBNUMA_API_VERSION) || LIBNUMA_API_VERSION < 2
 	nodemask = malloc(sizeof(nodemask_t));
 	nodemask_zero(nodemask);
-	nodemask_set(nodemask, 0);
+	nodemask_set(nodemask, test_node);
 	getnodemask = malloc(sizeof(nodemask_t));
 	nodemask_zero(getnodemask);
 #else
-	numa_bitmask_setbit(nodemask, 0);
+	numa_bitmask_setbit(nodemask, test_node);
 #endif
 	switch (tc->ttype) {
 	case DEFAULT:


--------------050501050306020901090306
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
--------------050501050306020901090306
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------050501050306020901090306--

