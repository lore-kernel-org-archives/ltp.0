Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <maninder1.s@samsung.com>) id 1Z8SQN-0005Is-5Z
	for ltp-list@lists.sourceforge.net; Fri, 26 Jun 2015 12:08:03 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1Z8SQL-0008TO-Kb
	for ltp-list@lists.sourceforge.net; Fri, 26 Jun 2015 12:08:03 +0000
Received: from epcpsbgr3.samsung.com
	(u143.gpu120.samsung.co.kr [203.254.230.143])
	by mailout3.samsung.com (Oracle Communications Messaging Server
	7.0.5.31.0 64bit (built May  5 2014))
	with ESMTP id <0NQJ00J1YWD7J140@mailout3.samsung.com> for
	ltp-list@lists.sourceforge.net; Fri, 26 Jun 2015 21:07:55 +0900 (KST)
From: Maninder Singh <maninder1.s@samsung.com>
Date: Fri, 26 Jun 2015 17:34:44 +0530
Message-id: <1435320294-45783-4-git-send-email-maninder1.s@samsung.com>
In-reply-to: <1435320294-45783-1-git-send-email-maninder1.s@samsung.com>
References: <1435320294-45783-1-git-send-email-maninder1.s@samsung.com>
Subject: [LTP] [PATCH 03/13] kernel/fs: use ARRAY_SIZE
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
 testcases/kernel/fs/ftest/ftest02.c |    2 +-
 testcases/kernel/fs/ftest/ftest06.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/fs/ftest/ftest02.c b/testcases/kernel/fs/ftest/ftest02.c
index ec70d9b..f205961 100644
--- a/testcases/kernel/fs/ftest/ftest02.c
+++ b/testcases/kernel/fs/ftest/ftest02.c
@@ -384,7 +384,7 @@ struct ino_thing {
 } ino_thing[] = {
 THING(crfile), THING(unlfile), THING(fussdir), THING(sync),};
 
-#define	NTHING	(sizeof(ino_thing) / sizeof(ino_thing[0]))
+#define	NTHING	ARRAY_SIZE(ino_thing)
 
 int thing_cnt[NTHING];
 int thing_last[NTHING];
diff --git a/testcases/kernel/fs/ftest/ftest06.c b/testcases/kernel/fs/ftest/ftest06.c
index 780cdbc..2ca7c88 100644
--- a/testcases/kernel/fs/ftest/ftest06.c
+++ b/testcases/kernel/fs/ftest/ftest06.c
@@ -402,7 +402,7 @@ struct ino_thing {
 } ino_thing[] = {
 THING(crfile), THING(unlfile), THING(fussdir), THING(sync),};
 
-#define	NTHING	(sizeof(ino_thing) / sizeof(ino_thing[0]))
+#define	NTHING	ARRAY_SIZE(ino_thing)
 
 int thing_cnt[NTHING];
 int thing_last[NTHING];
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
