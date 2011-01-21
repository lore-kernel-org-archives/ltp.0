Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <penght@cn.fujitsu.com>) id 1PgCTN-0008Er-Uj
	for ltp-list@lists.sourceforge.net; Fri, 21 Jan 2011 08:35:57 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PgCTL-0008Ls-Ve
	for ltp-list@lists.sourceforge.net; Fri, 21 Jan 2011 08:35:57 +0000
Message-ID: <4D39456D.4040308@cn.fujitsu.com>
Date: Fri, 21 Jan 2011 16:35:57 +0800
From: Peng Haitao <penght@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] fix error of wrong return code in cases
 rt_sigsuspend01, sched_getaffinity01, ftest06, sem02 and hugemmap03
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi Garrett,

"return 1" should be replaced with "tst_exit()" in the following cases.

Signed-off-by: Peng Haitao <penght@cn.fujitsu.com>

---
 testcases/kernel/fs/ftest/ftest06.c                |    4 ++--
 testcases/kernel/ipc/semaphore/sem02.c             |    4 ++--
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap03.c |    4 ++--
 .../syscalls/rt_sigsuspend/rt_sigsuspend01.c       |    4 ++--
 .../sched_getaffinity/sched_getaffinity01.c        |    5 ++---
 5 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/testcases/kernel/fs/ftest/ftest06.c b/testcases/kernel/fs/ftest/ftest06.c
index b985a1d..d8ff8b6 100644
--- a/testcases/kernel/fs/ftest/ftest06.c
+++ b/testcases/kernel/fs/ftest/ftest06.c
@@ -249,7 +249,7 @@ int main(int ac, char *av[])
 		tst_resm(TPASS, "Test passed.");
 
 	cleanup();
-	return 1;
+	tst_exit();
 }
 
 #define	warn(val,m1,m2)	if ((val) < 0) dowarn(me,m1,m2)
@@ -479,4 +479,4 @@ static void cleanup(void)
 	}
 	tst_rmdir();
 
-}
\ No newline at end of file
+}
diff --git a/testcases/kernel/ipc/semaphore/sem02.c b/testcases/kernel/ipc/semaphore/sem02.c
index 17645d8..5b9c58d 100644
--- a/testcases/kernel/ipc/semaphore/sem02.c
+++ b/testcases/kernel/ipc/semaphore/sem02.c
@@ -126,7 +126,7 @@ int main(int argc, char **argv)
 	tst_resm(TPASS, "passed");
     cleanup();
 
-    return 1;
+    tst_exit();
 }
 
 /* This thread sleeps 10 seconds then waits on the semaphore.  As long
@@ -169,4 +169,4 @@ void cleanup(void)
 {
 	TEST_CLEANUP;
 
-}
\ No newline at end of file
+}
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap03.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap03.c
index 209e40e..c1479fe 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap03.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap03.c
@@ -134,7 +134,7 @@ main(int ac, char **av)
 
 	cleanup();
 
-	return 1;
+	tst_exit();
 #endif
 }
 
@@ -178,4 +178,4 @@ cleanup()
 
 	unlink(TEMPFILE);
 
-}
\ No newline at end of file
+}
diff --git a/testcases/kernel/syscalls/rt_sigsuspend/rt_sigsuspend01.c b/testcases/kernel/syscalls/rt_sigsuspend/rt_sigsuspend01.c
index f9e3b34..60f63dd 100644
--- a/testcases/kernel/syscalls/rt_sigsuspend/rt_sigsuspend01.c
+++ b/testcases/kernel/syscalls/rt_sigsuspend/rt_sigsuspend01.c
@@ -182,5 +182,5 @@ int main(int ac, char **av) {
 
 	cleanup();
 
-	return 1;
-}
\ No newline at end of file
+	tst_exit();
+}
diff --git a/testcases/kernel/syscalls/sched_getaffinity/sched_getaffinity01.c b/testcases/kernel/syscalls/sched_getaffinity/sched_getaffinity01.c
index d5182da..014acf2 100644
--- a/testcases/kernel/syscalls/sched_getaffinity/sched_getaffinity01.c
+++ b/testcases/kernel/syscalls/sched_getaffinity/sched_getaffinity01.c
@@ -236,6 +236,5 @@ realloc:
 
 	cleanup();
 
-	return (1);
-
-}
\ No newline at end of file
+	tst_exit();
+}
-- 
1.7.3.1


-- 
Best Regards,
Peng Haitao


------------------------------------------------------------------------------
Special Offer-- Download ArcSight Logger for FREE (a $49 USD value)!
Finally, a world-class log management solution at an even better price-free!
Download using promo code Free_Logger_4_Dev2Dev. Offer expires 
February 28th, so secure your free ArcSight Logger TODAY! 
http://p.sf.net/sfu/arcsight-sfd2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
