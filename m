Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <maninder1.s@samsung.com>) id 1Z8SSl-0002hA-33
	for ltp-list@lists.sourceforge.net; Fri, 26 Jun 2015 12:10:31 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1Z8SSj-0006xt-HS
	for ltp-list@lists.sourceforge.net; Fri, 26 Jun 2015 12:10:31 +0000
Received: from epcpsbgr1.samsung.com
	(u141.gpu120.samsung.co.kr [203.254.230.141])
	by mailout3.samsung.com (Oracle Communications Messaging Server
	7.0.5.31.0 64bit (built May  5 2014))
	with ESMTP id <0NQJ00HI0WHAQB40@mailout3.samsung.com> for
	ltp-list@lists.sourceforge.net; Fri, 26 Jun 2015 21:10:22 +0900 (KST)
From: Maninder Singh <maninder1.s@samsung.com>
Date: Fri, 26 Jun 2015 17:34:50 +0530
Message-id: <1435320294-45783-10-git-send-email-maninder1.s@samsung.com>
In-reply-to: <1435320294-45783-1-git-send-email-maninder1.s@samsung.com>
References: <1435320294-45783-1-git-send-email-maninder1.s@samsung.com>
Subject: [LTP] [PATCH 09/13] kernel/fadvise: use ARRAY_SIZE
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
 .../kernel/syscalls/fadvise/posix_fadvise01.c      |    2 +-
 .../kernel/syscalls/fadvise/posix_fadvise03.c      |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/fadvise/posix_fadvise01.c b/testcases/kernel/syscalls/fadvise/posix_fadvise01.c
index fa966e6..835c3ca 100644
--- a/testcases/kernel/syscalls/fadvise/posix_fadvise01.c
+++ b/testcases/kernel/syscalls/fadvise/posix_fadvise01.c
@@ -71,7 +71,7 @@ int defined_advise[] = {
 	POSIX_FADV_DONTNEED,
 };
 
-#define defined_advise_total (sizeof(defined_advise) / sizeof(defined_advise[0]))
+#define defined_advise_total ARRAY_SIZE(defined_advise)
 
 int TST_TOTAL = defined_advise_total;
 
diff --git a/testcases/kernel/syscalls/fadvise/posix_fadvise03.c b/testcases/kernel/syscalls/fadvise/posix_fadvise03.c
index 9d8a08e..25c57be 100644
--- a/testcases/kernel/syscalls/fadvise/posix_fadvise03.c
+++ b/testcases/kernel/syscalls/fadvise/posix_fadvise03.c
@@ -86,7 +86,7 @@ int defined_advise[] = {
 #endif
 };
 
-#define defined_advise_total (sizeof(defined_advise) / sizeof(defined_advise[0]))
+#define defined_advise_total ARRAY_SIZE(defined_advise)
 
 #if 0
 /* Too many test cases. */
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
