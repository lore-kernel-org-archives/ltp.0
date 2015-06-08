Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <ramya@linux.vnet.ibm.com>) id 1Z1sF3-0001iQ-HM
	for ltp-list@lists.sourceforge.net; Mon, 08 Jun 2015 08:17:09 +0000
Received: from e28smtp07.in.ibm.com ([122.248.162.7])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Z1sEz-00081p-Lx
	for ltp-list@lists.sourceforge.net; Mon, 08 Jun 2015 08:17:09 +0000
Received: from /spool/local
	by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <ltp-list@lists.sourceforge.net> from <ramya@linux.vnet.ibm.com>;
	Mon, 8 Jun 2015 13:46:57 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by d28dlp03.in.ibm.com (Postfix) with ESMTP id 022011258059
	for <ltp-list@lists.sourceforge.net>;
	Mon,  8 Jun 2015 13:49:23 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
	by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	t588Grrn1966586
	for <ltp-list@lists.sourceforge.net>; Mon, 8 Jun 2015 13:46:53 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
	by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	t588GZC1032375
	for <ltp-list@lists.sourceforge.net>; Mon, 8 Jun 2015 13:46:35 +0530
From: ramya@linux.vnet.ibm.com
Date: Mon,  8 Jun 2015 03:16:23 -0500
Message-Id: <1433751383-32596-1-git-send-email-ramya@linux.vnet.ibm.com>
Subject: [LTP] [PATCH] Clean up issue
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

From: Ramya BS <ramya@linux.vnet.ibm.com>

Description:
when we run the script for the first time, all the test will run successfully and PASS .
but on the same machine if we run the same script for the 2nd time we see TBROK .

TBROK was seen because the script was not cleaning the files it created during the first run.
so added TWARN "did not properly clean up files" and then removing the files and continuing with the test .

Signed-off-by: Ramya BS <ramya@linux.vnet.ibm.com>
---
 testscripts/test_fs_bind.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/testscripts/test_fs_bind.sh b/testscripts/test_fs_bind.sh
index 792fff2..b6cb58f 100755
--- a/testscripts/test_fs_bind.sh
+++ b/testscripts/test_fs_bind.sh
@@ -343,8 +343,8 @@ save_sandbox()
 
 	if [ -e "$2/files.before" ]; then
 		if [ -e "$2/files.after" ]; then
-			tst_brkm TBROK true "${tname}: stale catalog of \"${sandbox}\""
-			return 1
+			tst_resm TWARN true "${tname}: did not properly clean up files"
+			rm -f "$2/files.after" 
 		fi
 		when="after"
 	fi
-- 
1.7.1




Thanks&Regards,
Ramya BS


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
