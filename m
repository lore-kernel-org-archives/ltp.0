Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <maninder1.s@samsung.com>) id 1Z2gtw-0004OM-WB
	for ltp-list@lists.sourceforge.net; Wed, 10 Jun 2015 14:22:45 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1Z2gtv-0000za-3k
	for ltp-list@lists.sourceforge.net; Wed, 10 Jun 2015 14:22:44 +0000
Received: from epcpsbgr1.samsung.com
	(u141.gpu120.samsung.co.kr [203.254.230.141])
	by mailout2.samsung.com (Oracle Communications Messaging Server
	7.0.5.31.0 64bit (built May  5 2014))
	with ESMTP id <0NPQ01TBBFXN8X90@mailout2.samsung.com> for
	ltp-list@lists.sourceforge.net; Wed, 10 Jun 2015 23:22:35 +0900 (KST)
Date: Wed, 10 Jun 2015 14:22:35 +0000 (GMT)
From: Maninder Singh <maninder1.s@samsung.com>
MIME-version: 1.0
MIME-version: 1.0
Message-id: <2028116354.832411433946155629.JavaMail.weblogic@epmlwas05b>
Subject: [LTP] [PATCH 1/1] syscall/rename06.c: remove redundant code
Reply-To: maninder1.s@samsung.com
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
To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

There is no use of function do_file_setup in code.

Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
---
 testcases/kernel/syscalls/rename/rename06.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/testcases/kernel/syscalls/rename/rename06.c b/testcases/kernel/syscalls/rename/rename06.c
index 941782c..b9c55c8 100644
--- a/testcases/kernel/syscalls/rename/rename06.c
+++ b/testcases/kernel/syscalls/rename/rename06.c
@@ -66,7 +66,6 @@
 
 void setup();
 void cleanup();
-extern void do_file_setup(char *);
 
 char *TCID = "rename06";
 int TST_TOTAL = 1;
-- 
1.7.9.5
------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
