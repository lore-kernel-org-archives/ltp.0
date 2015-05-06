Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <ramya@linux.vnet.ibm.com>) id 1YpxGj-0005Rx-Mm
	for ltp-list@lists.sourceforge.net; Wed, 06 May 2015 11:13:37 +0000
Received: from e28smtp06.in.ibm.com ([122.248.162.6])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YpxGi-0007pA-6c
	for ltp-list@lists.sourceforge.net; Wed, 06 May 2015 11:13:37 +0000
Received: from /spool/local
	by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <ltp-list@lists.sourceforge.net> from <ramya@linux.vnet.ibm.com>;
	Wed, 6 May 2015 16:43:27 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
	by d28dlp02.in.ibm.com (Postfix) with ESMTP id 357B63940048
	for <ltp-list@lists.sourceforge.net>;
	Wed,  6 May 2015 16:43:25 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
	by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	t46BDLJx35782726
	for <ltp-list@lists.sourceforge.net>; Wed, 6 May 2015 16:43:21 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
	by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	t46BDLH1002800
	for <ltp-list@lists.sourceforge.net>; Wed, 6 May 2015 16:43:21 +0530
Received: from [9.124.158.31] (ramya.in.ibm.com [9.124.158.31])
	by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
	t46BDLXe002792
	for <ltp-list@lists.sourceforge.net>; Wed, 6 May 2015 16:43:21 +0530
Message-ID: <5549F751.3070503@linux.vnet.ibm.com>
Date: Wed, 06 May 2015 16:43:21 +0530
From: Ramya <ramya@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: [LTP] test_fs_bind.sh testcase fails to clean up files which it had
 created during the first run .
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
To: ltp-list@lists.sourceforge.net

Description:
when we run the script for the first time, all the test will run 
successfully and PASS .
but on the same machine if we run the same script for the 2nd time we 
see TBROK .

TBROK was seen because the script was not cleaning the files it created 
during the first run.
so added TWARN "did not properly clean up files" and then removing the 
files and continuing with the test .

Signed-off-by: ramya BS <ramya@linux.vnet.ibm.com>

++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 


patch1

  testscripts/test_fs_bind.sh |    4 ++--
  1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/testscripts/test_fs_bind.sh b/testscripts/test_fs_bind.sh
index 792fff2..348f320 100755
--- a/testscripts/test_fs_bind.sh
+++ b/testscripts/test_fs_bind.sh
@@ -343,8 +343,8 @@ save_sandbox()

      if [ -e "$2/files.before" ]; then
          if [ -e "$2/files.after" ]; then
-            tst_brkm TBROK true "${tname}: stale catalog of 
\"${sandbox}\""
-            return 1
+            tst_resm TWARN true "${tname}: did not properly clean up 
files"
+                        rm -f "$2/files.after"
          fi
          when="after"
      fi
-- 
1.7.1

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 


Thanks&Regards,
RamyaBS


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
