Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jungsoo.son@lge.com>) id 1Uyyx5-0000Rp-70
	for ltp-list@lists.sourceforge.net; Tue, 16 Jul 2013 06:41:35 +0000
Received: from lgeamrelo02.lge.com ([156.147.1.126])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Uyyx3-0007On-Ah
	for ltp-list@lists.sourceforge.net; Tue, 16 Jul 2013 06:41:35 +0000
From: "Jungsoo Son" <jungsoo.son@lge.com>
Date: Tue, 16 Jul 2013 15:41:26 +0900
Message-ID: <005001ce81ef$7ea7dc20$7bf79460$@lge.com>
MIME-Version: 1.0
Content-Language: ko
Subject: [LTP] [PATCH] Fix the bug of the temp-files removing
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

The shell command to remove all the temp-files created had a bug that
try to remove /dev/null. If the ltp is run with root permission the
/dev/null will be removed.

Signed-off-by: jungsoo.son <jungsoo.son@lge.com>
---
 testscripts/test_robind.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testscripts/test_robind.sh b/testscripts/test_robind.sh
index 142678a..4c01f4e 100755
--- a/testscripts/test_robind.sh
+++ b/testscripts/test_robind.sh
@@ -193,7 +193,7 @@ function testdir
         echo >> $PASSLOG
     fi
     # Remove all the temp-files created.
-    eval rm -rf ${TMPDIR}/${dir}/* > /dev/null 2>&1 /dev/null || true
+    eval rm -rf ${TMPDIR}/${dir}/* > /dev/null 2>&1 || true
     unset TDIRECTORY
     popd
 }
-- 
1.7.9.5


------------------------------------------------------------------------------
See everything from the browser to the database with AppDynamics
Get end-to-end visibility with application monitoring from AppDynamics
Isolate bottlenecks and diagnose root cause in seconds.
Start your free trial of AppDynamics Pro today!
http://pubads.g.doubleclick.net/gampad/clk?id=48808831&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
