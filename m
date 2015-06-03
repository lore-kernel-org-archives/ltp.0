Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Chuang.Dong@windriver.com>) id 1Z01uA-0007Ol-Bl
	for Ltp-list@lists.sourceforge.net; Wed, 03 Jun 2015 06:11:58 +0000
Received: from mail.windriver.com ([147.11.1.11])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Z01u9-0000Rv-4x
	for Ltp-list@lists.sourceforge.net; Wed, 03 Jun 2015 06:11:58 +0000
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.15.1/8.15.1) with ESMTPS id t536Bo27012683
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <Ltp-list@lists.sourceforge.net>;
	Tue, 2 Jun 2015 23:11:51 -0700 (PDT)
Message-ID: <556E9A9E.7080202@windriver.com>
Date: Wed, 3 Jun 2015 14:11:42 +0800
From: cdong <chuang.dong@windriver.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040207040104010202010203"
Subject: [LTP] ltp: vma03 fix the alginment of page size
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
To: Ltp-list@lists.sourceforge.net

--------------040207040104010202010203
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit

Hi,
        There is a patch to fix vma03 test case,the below information is 
detail it:

        the offset the parameter of mmap2() doesn't align the page 
size,but,this parameter
        allow must be a multiple of the page size as returned by 
sysconf(_SC_PAGE_SIZE).
        meanwhile offset * 4096 must be a multiple of the system page 
size,so modify
        the input param of offset pgoff = (ULONG_MAX - 1)&(~((pgsz-1)>>12));

     Regards,
     Apollo

--------------040207040104010202010203
Content-Type: text/x-patch;
	name="0001-ltp-vma03-fix-the-alginment-of-page-size.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="0001-ltp-vma03-fix-the-alginment-of-page-size.patch"

From 6e60e9d4f27d36cdd369e7d7a046da49e3f17fd6 Mon Sep 17 00:00:00 2001
From: Chuang Dong <Chuang.Dong@windriver.com>
Date: Wed, 3 Jun 2015 13:27:53 +0800
Subject: [PATCH] ltp: vma03 fix the alginment of page size

the offset the param of mmap2() doesn't align the page size,but,
this param allow must be a multiple of the page size as returned
by sysconf(_SC_PAGE_SIZE).meanwhile offset * 4096 must be a
multiple of the system page size,so modify the input param of offset
pgoff = (ULONG_MAX - 1)&(~((pgsz-1)>>12));

Upstream-Status: Submitted

Signed-off-by: Chuang Dong <Chuang.Dong@windriver.com>
---
 testcases/kernel/mem/vma/vma03.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/mem/vma/vma03.c b/testcases/kernel/mem/vma/vma03.c
index ad8a7b4..a539233 100644
--- a/testcases/kernel/mem/vma/vma03.c
+++ b/testcases/kernel/mem/vma/vma03.c
@@ -85,7 +85,7 @@ int main(int argc, char *argv[])
 		if (fd == -1)
 			tst_brkm(TBROK | TERRNO, NULL, "open %s", TESTFILE);
 
-		pgoff = ULONG_MAX - 1;
+		pgoff = (ULONG_MAX - 1)&(~((pgsz-1)>>12));
 		map = mmap2(NULL, pgsz, PROT_READ | PROT_WRITE, MAP_PRIVATE,
 			    fd, pgoff);
 		if (map == MAP_FAILED)
-- 
1.8.5.2.233.g932f7e4


--------------040207040104010202010203
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--------------040207040104010202010203
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------040207040104010202010203--

