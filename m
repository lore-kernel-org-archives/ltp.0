Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zliu@redhat.com>) id 1URcTt-0000lU-He
	for ltp-list@lists.sourceforge.net; Mon, 15 Apr 2013 06:01:33 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1URcTr-00010k-Nt
	for ltp-list@lists.sourceforge.net; Mon, 15 Apr 2013 06:01:33 +0000
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r3F61QP8024100
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 15 Apr 2013 02:01:26 -0400
From: Zhouping Liu <zliu@redhat.com>
Date: Mon, 15 Apr 2013 13:59:04 +0800
Message-Id: <46f33c4487df720dad01cffe653530263154e9e7.1366005109.git.zliu@redhat.com>
In-Reply-To: <0537e2f47474c0f220fb3acafed4e2e4c1b2399f.1366005109.git.zliu@redhat.com>
References: <cover.1366005109.git.zliu@redhat.com>
	<0537e2f47474c0f220fb3acafed4e2e4c1b2399f.1366005109.git.zliu@redhat.com>
In-Reply-To: <cover.1366005109.git.zliu@redhat.com>
References: <cover.1366005109.git.zliu@redhat.com>
Subject: [LTP] [PATCH v3 2/3] lib/mem: introduce a new function
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

Tested-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Signed-off-by: Zhouping Liu <zliu@redhat.com>
---
 testcases/kernel/mem/lib/mem.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
index 589f3a2..4a06581 100644
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
Precog is a next-generation analytics platform capable of advanced
analytics on semi-structured data. The platform includes APIs for building
apps and a phenomenal toolset for data science. Developers can use
our toolset for easy data analysis & visualization. Get a free account!
http://www2.precog.com/precogplatform/slashdotnewsletter
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
