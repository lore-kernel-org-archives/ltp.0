Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <maninder1.s@samsung.com>) id 1Z8SU5-0008MJ-83
	for ltp-list@lists.sourceforge.net; Fri, 26 Jun 2015 12:11:53 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1Z8SU3-0004Ls-Ad
	for ltp-list@lists.sourceforge.net; Fri, 26 Jun 2015 12:11:53 +0000
Received: from epcpsbgr2.samsung.com
	(u142.gpu120.samsung.co.kr [203.254.230.142])
	by mailout4.samsung.com (Oracle Communications Messaging Server
	7.0.5.31.0 64bit (built May  5 2014))
	with ESMTP id <0NQJ01J7TWJKTYD0@mailout4.samsung.com> for
	ltp-list@lists.sourceforge.net; Fri, 26 Jun 2015 21:11:44 +0900 (KST)
From: Maninder Singh <maninder1.s@samsung.com>
Date: Fri, 26 Jun 2015 17:34:54 +0530
Message-id: <1435320294-45783-14-git-send-email-maninder1.s@samsung.com>
In-reply-to: <1435320294-45783-1-git-send-email-maninder1.s@samsung.com>
References: <1435320294-45783-1-git-send-email-maninder1.s@samsung.com>
Subject: [LTP] [PATCH 13/13] kernel/nft: use ARRAY_SIZE
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
Cc: pankaj.m@samsung.com


Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
Reviewed-by: Akhilesh Kumar <akhilesh.k@samsung.com>
---
 testcases/kernel/syscalls/nftw/nftw.c   |    8 ++++----
 testcases/kernel/syscalls/nftw/nftw64.c |    8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/testcases/kernel/syscalls/nftw/nftw.c b/testcases/kernel/syscalls/nftw/nftw.c
index 451ce77..cefd5bf 100644
--- a/testcases/kernel/syscalls/nftw/nftw.c
+++ b/testcases/kernel/syscalls/nftw/nftw.c
@@ -254,10 +254,10 @@ int main(void)
 {
 	setup();		/* temp file is now open        */
 
-	npathdats = (sizeof(pathdat) / sizeof(pathdat[0]));
-	ngoods = (sizeof(goodlist) / sizeof(goodlist[0]));
-	nbads = (sizeof(badlist) / sizeof(badlist[0]));
-	nmnem = (sizeof(mnem) / sizeof(mnem[0]));
+	npathdats = ARRAY_SIZE(pathdat);
+	ngoods = ARRAY_SIZE(goodlist);
+	nbads = ARRAY_SIZE(badlist);
+	nmnem = ARRAY_SIZE(mnem);
 
 	setup_path();
 
diff --git a/testcases/kernel/syscalls/nftw/nftw64.c b/testcases/kernel/syscalls/nftw/nftw64.c
index a56abc3..417c84b 100644
--- a/testcases/kernel/syscalls/nftw/nftw64.c
+++ b/testcases/kernel/syscalls/nftw/nftw64.c
@@ -251,10 +251,10 @@ int main(void)
 {
 	setup();		/* temp file is now open        */
 
-	npathdats = (sizeof(pathdat) / sizeof(pathdat[0]));
-	ngoods = (sizeof(goodlist) / sizeof(goodlist[0]));
-	nbads = (sizeof(badlist) / sizeof(badlist[0]));
-	nmnem = (sizeof(mnem) / sizeof(mnem[0]));
+	npathdats = ARRAY_SIZE(pathdat);
+	ngoods = ARRAY_SIZE(goodlist);
+	nbads = ARRAY_SIZE(badlist);
+	nmnem = ARRAY_SIZE(mnem);
 
 	setup_path();
 
-- 
1.7.9.5


------------------------------------------------------------------------------
Monitor 25 network devices or servers for free with OpManager!
OpManager is web-based network management software that monitors 
network devices and physical & virtual servers, alerts via email & sms 
for fault. Monitor 25 devices for free with no restriction. Download now
http://ad.doubleclick.net/ddm/clk/292181274;119417398;o
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
