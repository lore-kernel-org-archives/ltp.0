Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <ramya@linux.vnet.ibm.com>) id 1YqbYb-0006Ju-3o
	for ltp-list@lists.sourceforge.net; Fri, 08 May 2015 06:14:45 +0000
Received: from e23smtp06.au.ibm.com ([202.81.31.148])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YqbYZ-0007qM-TN
	for ltp-list@lists.sourceforge.net; Fri, 08 May 2015 06:14:45 +0000
Received: from /spool/local
	by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <ltp-list@lists.sourceforge.net> from <ramya@linux.vnet.ibm.com>;
	Fri, 8 May 2015 16:14:35 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
	by d23dlp03.au.ibm.com (Postfix) with ESMTP id 35C913578048
	for <ltp-list@lists.sourceforge.net>;
	Fri,  8 May 2015 16:14:33 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	t486EOHM29949966
	for <ltp-list@lists.sourceforge.net>; Fri, 8 May 2015 16:14:33 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	t486E0P4005178
	for <ltp-list@lists.sourceforge.net>; Fri, 8 May 2015 16:14:00 +1000
From: ramya@linux.vnet.ibm.com
Date: Fri,  8 May 2015 01:13:15 -0500
Message-Id: <1431065595-23843-1-git-send-email-ramya@linux.vnet.ibm.com>
Subject: [LTP] test_fs_bind.sh testcase fails to clean up files which it had
	created during the first run
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

From: ramya BS <ramya@linux.vnet.ibm.com>

Description:
when we run the script for the first time, all the test will run successfully and PASS .
but on the same machine if we run the same script for the 2nd time we see TBROK .

TBROK was seen because the script was not cleaning the files it created during the first run.
so added TWARN "did not properly clean up files" and then removing the files and continuing with the test .

Signed-off-by: ramya BS <ramya@linux.vnet.ibm.com>
---
 testscripts/test_fs_bind.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/testscripts/test_fs_bind.sh b/testscripts/test_fs_bind.sh
index 792fff2..348f320 100755
--- a/testscripts/test_fs_bind.sh
+++ b/testscripts/test_fs_bind.sh
@@ -343,8 +343,8 @@ save_sandbox()
 
 	if [ -e "$2/files.before" ]; then
 		if [ -e "$2/files.after" ]; then
-			tst_brkm TBROK true "${tname}: stale catalog of \"${sandbox}\""
-			return 1
+			tst_resm TWARN true "${tname}: did not properly clean up files"
+                        rm -f "$2/files.after" 
 		fi
 		when="after"
 	fi
-- 
1.7.1


------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
