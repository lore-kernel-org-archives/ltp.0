Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Markos.Chandras@imgtec.com>) id 1S4reS-0008CK-97
	for ltp-list@lists.sourceforge.net; Tue, 06 Mar 2012 10:29:52 +0000
Received: from multi.imgtec.com ([194.200.65.239])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1S4reM-0006Rh-3D
	for ltp-list@lists.sourceforge.net; Tue, 06 Mar 2012 10:29:51 +0000
From: Markos Chandras <markos.chandras@imgtec.com>
Date: Tue, 6 Mar 2012 10:28:59 +0000
Message-ID: <1331029739-32353-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] runltp: Remove excess quotes from final message
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

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 runltp |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/runltp b/runltp
index 4ef8b38..fc3515b 100755
--- a/runltp
+++ b/runltp
@@ -948,11 +948,11 @@ main()
     {
     cat <<-EOF >&1
         
-       ###############################################################"
+       ###############################################################
         
-            Done executing testcases."
+            Done executing testcases.
             LTP Version:  $version_date
-       ###############################################################"
+       ###############################################################
        
 	EOF
     }
-- 
1.7.1



------------------------------------------------------------------------------
Keep Your Developer Skills Current with LearnDevNow!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
