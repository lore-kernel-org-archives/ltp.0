Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1SZHpT-0008Pc-4s
	for ltp-list@lists.sourceforge.net; Tue, 29 May 2012 08:30:59 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SZHpN-0003Om-R3
	for ltp-list@lists.sourceforge.net; Tue, 29 May 2012 08:30:59 +0000
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q4T8Ulmd005129
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 29 May 2012 04:30:47 -0400
Message-ID: <4FC48935.6040109@redhat.com>
Date: Tue, 29 May 2012 10:30:45 +0200
From: Jan Stancek <jstancek@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050205090601080104080105"
Subject: [LTP] [PATCH v2 2/4] mbind01: dont use hardcoded NUMA node ids
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
--------------050205090601080104080105
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/mbind/Makefile  |    3 +--
 testcases/kernel/syscalls/mbind/mbind01.c |    9 +++++++--
 2 files changed, 8 insertions(+), 4 deletions(-)



--------------050205090601080104080105
Content-Type: text/x-patch;
	name="0002-mbind01-dont-use-hardcoded-NUMA-node-ids.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="0002-mbind01-dont-use-hardcoded-NUMA-node-ids.patch"

diff --git a/testcases/kernel/syscalls/mbind/Makefile b/testcases/kernel/syscalls/mbind/Makefile
index bc50178..932037f 100644
--- a/testcases/kernel/syscalls/mbind/Makefile
+++ b/testcases/kernel/syscalls/mbind/Makefile
@@ -31,6 +31,5 @@ endif
 
 CPPFLAGS		+= -I$(abs_srcdir)/../utils/
 
-LDLIBS			+= $(NUMA_LIBS)
-
+include $(abs_srcdir)/../numa/Makefile.inc
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/mbind/mbind01.c b/testcases/kernel/syscalls/mbind/mbind01.c
index 4b25db0..1148324 100644
--- a/testcases/kernel/syscalls/mbind/mbind01.c
+++ b/testcases/kernel/syscalls/mbind/mbind01.c
@@ -63,6 +63,7 @@
 #include "usctest.h"
 #include "linux_syscall_numbers.h"
 #include "include_j_h.h"
+#include "numa_helper.h"
 
 char *TCID = "mbind01";
 int  TST_TOTAL = 2;
@@ -217,15 +218,19 @@ static int do_test(struct test_case *tc)
 	unsigned long maxnode = NUMA_NUM_NODES;
 	unsigned long len = MEM_LENGTH;
 	unsigned long *invalid_nodemask;
+	int test_node = -1;
+
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
 	p = mmap(NULL, len, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS,
 		    0, 0);


--------------050205090601080104080105
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
--------------050205090601080104080105
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------050205090601080104080105--

