Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zliu@redhat.com>) id 1UP87n-0001OE-Vm
	for ltp-list@lists.sourceforge.net; Mon, 08 Apr 2013 09:12:28 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UP87i-00059L-KT
	for ltp-list@lists.sourceforge.net; Mon, 08 Apr 2013 09:12:27 +0000
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r389CGCZ004600
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 8 Apr 2013 05:12:16 -0400
From: Zhouping Liu <zliu@redhat.com>
Date: Mon,  8 Apr 2013 17:10:08 +0800
Message-Id: <bb0b8c0247c4e123703a1d7cbb95f74257ba650c.1365411883.git.zliu@redhat.com>
In-Reply-To: <3bc25be7511978a5ccb9faad218e397743d1820b.1365411883.git.zliu@redhat.com>
References: <cover.1365411883.git.zliu@redhat.com>
	<3bc25be7511978a5ccb9faad218e397743d1820b.1365411883.git.zliu@redhat.com>
In-Reply-To: <cover.1365411883.git.zliu@redhat.com>
References: <cover.1365411883.git.zliu@redhat.com>
Subject: [LTP] [PATCH v2 2/3] lib/mem: introduce a new function
	set_global_mempolicy()
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

Fork out a new function set_global_mempolicy() from the
previous testoom() func, which will be useful for other func.

Signed-off-by: Zhouping Liu <zliu@redhat.com>
---
 testcases/kernel/mem/lib/mem.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
index 84b36bc..509bb59 100644
--- a/testcases/kernel/mem/lib/mem.c
+++ b/testcases/kernel/mem/lib/mem.c
@@ -91,7 +91,7 @@ void oom(int testcase, int lite)
 	}
 }
 
-void testoom(int mempolicy, int lite)
+static void set_global_mempolicy(int mempolicy)
 {
 #if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
 	&& HAVE_MPOL_CONSTANTS
@@ -133,6 +133,11 @@ void testoom(int mempolicy, int lite)
 			tst_brkm(TBROK|TERRNO, cleanup, "set_mempolicy");
 	}
 #endif
+}
+
+void testoom(int mempolicy, int lite)
+{
+	set_global_mempolicy(mempolicy);
 
 	tst_resm(TINFO, "start normal OOM testing.");
 	oom(NORMAL, lite);
-- 
1.7.11.7


------------------------------------------------------------------------------
Minimize network downtime and maximize team effectiveness.
Reduce network management and security costs.Learn how to hire 
the most talented Cisco Certified professionals. Visit the 
Employer Resources Portal
http://www.cisco.com/web/learning/employer_resources/index.html
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
