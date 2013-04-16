Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zliu@redhat.com>) id 1US38H-0007hj-1k
	for ltp-list@lists.sourceforge.net; Tue, 16 Apr 2013 10:29:01 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1US38G-0002RA-A0
	for ltp-list@lists.sourceforge.net; Tue, 16 Apr 2013 10:29:01 +0000
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r3GASsmA031399
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 16 Apr 2013 06:28:54 -0400
From: Zhouping Liu <zliu@redhat.com>
Date: Tue, 16 Apr 2013 18:26:32 +0800
Message-Id: <231291fe0dff5b700bdd3f3a01c9cb7c9a96f73a.1366107814.git.zliu@redhat.com>
In-Reply-To: <4c3dabc00aa1d0ff3b4cf06b8b5004e39f76199c.1366107814.git.zliu@redhat.com>
References: <cover.1366107814.git.zliu@redhat.com>
	<4c3dabc00aa1d0ff3b4cf06b8b5004e39f76199c.1366107814.git.zliu@redhat.com>
In-Reply-To: <cover.1366107814.git.zliu@redhat.com>
References: <cover.1366107814.git.zliu@redhat.com>
Subject: [LTP] [PATCH v5 2/3] lib/mem: introduce a new function
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
 testcases/kernel/mem/include/mem.h |  3 ++-
 testcases/kernel/mem/lib/mem.c     | 13 +++++++++++--
 testcases/kernel/mem/thp/thp04.c   |  2 +-
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/mem/include/mem.h b/testcases/kernel/mem/include/mem.h
index cc8b86c..c9e0540 100644
--- a/testcases/kernel/mem/include/mem.h
+++ b/testcases/kernel/mem/include/mem.h
@@ -39,7 +39,8 @@ void testoom(int mempolicy, int lite);
 
 int opt_nr_children, opt_nr_thps;
 char *opt_nr_children_str, *opt_nr_thps_str;
-void test_transparent_hugepage(int nr_children, int nr_thps, int hg_aligned);
+void test_transparent_hugepage(int nr_children, int nr_thps,
+			       int hg_aligned, int mempolicy);
 void check_thp_options(int *nr_children, int *nr_thps);
 void thp_usage(void);
 
diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
index fa5694a..f6aa351 100644
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
@@ -613,12 +618,16 @@ static void verify_thp_size(int *children, int nr_children, int nr_thps)
 	}
 }
 
-void test_transparent_hugepage(int nr_children, int nr_thps, int hg_aligned)
+void test_transparent_hugepage(int nr_children, int nr_thps,
+			       int hg_aligned, int mempolicy)
 {
 	unsigned long hugepagesize, memfree;
 	int i, *pids, ret, status;
 	char path[BUFSIZ];
 
+	if (mempolicy)
+		set_global_mempolicy(mempolicy);
+
 	memfree = read_meminfo("MemFree:");
 	tst_resm(TINFO, "The current MemFree is %luMB", memfree / KB);
 	if (memfree < MB)
diff --git a/testcases/kernel/mem/thp/thp04.c b/testcases/kernel/mem/thp/thp04.c
index 7988c8b..4232cf0 100644
--- a/testcases/kernel/mem/thp/thp04.c
+++ b/testcases/kernel/mem/thp/thp04.c
@@ -83,7 +83,7 @@ int main(int argc, char *argv[])
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		tst_count = 0;
 
-		test_transparent_hugepage(nr_children, nr_thps, 1);
+		test_transparent_hugepage(nr_children, nr_thps, 1, 0);
 	}
 
 	cleanup();
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
