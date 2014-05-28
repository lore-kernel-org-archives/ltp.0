Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <liwang@redhat.com>) id 1WpSj9-00069s-QW
	for ltp-list@lists.sourceforge.net; Wed, 28 May 2014 01:32:23 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WpSj8-0003rU-Hl
	for ltp-list@lists.sourceforge.net; Wed, 28 May 2014 01:32:23 +0000
From: Li Wang <liwang@redhat.com>
Date: Wed, 28 May 2014 09:32:09 +0800
Message-Id: <1401240729-15260-1-git-send-email-liwang@redhat.com>
Subject: [LTP] [PATCH] hugemmap/hugemmap03.c: fix the ppc64 FAILED situation
	procedure
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
To: ltp-list@lists.sourceforge.net
Cc: liwan@redhat.com, Li Wang <wangli.ahau@gmail.com>

From: Li Wang <wangli.ahau@gmail.com>

	When testing on ppc64 arch, `./hugemmap03 -s 64` failed message as:
	  hugemmap03    1  TFAIL  :  mmap into high region failed unexpectedly - expect errno=ENOMEM, got: errno=EINVAL(22): Invalid

	But it is not the system issue,  MMAP(2) Programmer's Manual define the mmap() error return value like:
	  EINVAL We don't like addr, length, or offset (e.g., they are too large, or not aligned on a page boundary).
	  ENOMEM No memory is available, or the process's maximum number of mappings would have been exceeded.
	So, we should consider the EINVAL return situation on ppc64.

Signed-off-by: Li Wang <wangli.ahau@gmail.com>
---
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap03.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap03.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap03.c
index 0287ec9..3c1ccdd 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap03.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap03.c
@@ -100,7 +100,7 @@ int main(int ac, char **av)
 
 		tst_count = 0;
 
-		/* Attempt to mmap into highmem addr, should get ENOMEM */
+		/* Attempt to mmap into highmem addr, should get ENOMEM or EINVAL (on arch ppc64) */
 		addr = mmap(HIGH_ADDR, map_sz, PROT_READ,
 			    MAP_SHARED | MAP_FIXED, fildes, 0);
 		if (addr != MAP_FAILED) {
@@ -108,13 +108,13 @@ int main(int ac, char **av)
 				 "succeeded unexpectedly");
 			goto fail;
 		}
-		if (errno != ENOMEM)
-			tst_resm(TFAIL | TERRNO, "mmap into high region "
-				 "failed unexpectedly - expect "
-				 "errno=ENOMEM, got");
-		else
+		if (errno == ENOMEM || errno == EINVAL)
 			tst_resm(TPASS | TERRNO, "mmap into high region "
 				 "failed as expected");
+		else
+			tst_resm(TFAIL | TERRNO, "mmap into high region "
+				 "failed unexpectedly - expect "
+				 "errno=ENOMEM or EINVAL, got");
 fail:
 		close(fildes);
 	}
-- 
1.8.1.2


------------------------------------------------------------------------------
Time is money. Stop wasting it! Get your web API in 5 minutes.
www.restlet.com/download
http://p.sf.net/sfu/restlet
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
