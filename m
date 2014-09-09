Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <shuang.qiu@oracle.com>) id 1XREwH-0003Qu-AG
	for ltp-list@lists.sourceforge.net; Tue, 09 Sep 2014 06:30:05 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XREwG-0005Dl-D7
	for ltp-list@lists.sourceforge.net; Tue, 09 Sep 2014 06:30:05 +0000
Received: from acsinet22.oracle.com (acsinet22.oracle.com [141.146.126.238])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s896Twsc029874
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 9 Sep 2014 06:29:58 GMT
Received: from userz7022.oracle.com (userz7022.oracle.com [156.151.31.86])
	by acsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s896TvAM027359
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Tue, 9 Sep 2014 06:29:58 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
	by userz7022.oracle.com (8.14.5+Sun/8.14.4) with ESMTP id
	s896TuqK029807
	for <ltp-list@lists.sourceforge.net>; Tue, 9 Sep 2014 06:29:56 GMT
From: shuang.qiu@oracle.com
Date: Tue,  9 Sep 2014 14:29:26 +0800
Message-Id: <1410244166-5559-1-git-send-email-shuang.qiu@oracle.com>
Subject: [LTP] [PATCH] pan/ltp-pan.c: TCONF testcases should not be written
	to failcmdfile
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

From: Shuang Qiu <shuang.qiu@oracle.com>

After commit patch 6f6878f4e1406d79cae53564777c5e1245d2a124,the
testcases which retrun TCONF should not be written to failcmdfile.

Signed-off-by: Shuang Qiu <shuang.qiu@oracle.com>
---
 pan/ltp-pan.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/pan/ltp-pan.c b/pan/ltp-pan.c
index 957199a..711c16a 100644
--- a/pan/ltp-pan.c
+++ b/pan/ltp-pan.c
@@ -802,7 +802,7 @@ check_pids(struct tag_pgrp *running, int *num_active, int keep_active,
 					fflush(logfile);
 				}
 
-				if ((failcmdfile != NULL) && (w != 0)) {
+				if ((failcmdfile != NULL) && (w != 0) && (w != TCONF)) {
 					fprintf(failcmdfile, "%s %s\n",
 						running[i].cmd->name,
 						running[i].cmd->cmdline);
-- 
1.7.7


------------------------------------------------------------------------------
Want excitement?
Manually upgrade your production database.
When you want reliability, choose Perforce.
Perforce version control. Predictably reliable.
http://pubads.g.doubleclick.net/gampad/clk?id=157508191&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
