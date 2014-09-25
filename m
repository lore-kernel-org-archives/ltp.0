Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <liuhangbin@gmail.com>) id 1XX8eU-0003wc-Ro
	for ltp-list@lists.sourceforge.net; Thu, 25 Sep 2014 13:00:06 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XX8eT-0003Ui-Om
	for ltp-list@lists.sourceforge.net; Thu, 25 Sep 2014 13:00:06 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
Date: Thu, 25 Sep 2014 20:59:35 +0800
Message-Id: <1411649975-17339-1-git-send-email-liuhangbin@gmail.com>
Subject: [LTP] [PATCH v2] ltp-networking/tcp_cmds/finger: fix finger bad
	user and host test
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
To: LTP List <ltp-list@lists.sourceforge.net>
Cc: vasily.isaenko@oracle.com, Vincent Hsu <vincent.hsu@linaro.org>

Finger always return 0 with bad user and host test. And it also return
different error message on different distros. So let's only check stderr
message and decide whether the test pass or fail.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 testcases/network/tcp_cmds/finger/finger01 | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/testcases/network/tcp_cmds/finger/finger01 b/testcases/network/tcp_cmds/finger/finger01
index 203d746..89693ff 100755
--- a/testcases/network/tcp_cmds/finger/finger01
+++ b/testcases/network/tcp_cmds/finger/finger01
@@ -115,13 +115,10 @@ do_test2()
     finger -x 2>&1 1>/dev/null && end_testcase "finger -x should fail"
 
     tst_resm TINFO "finger -bad user "
-    finger $BADUSER 2>&1 1>/dev/null || end_testcase "finger $BADUSER"
-    finger @$BADHOST 2>&1 1>/dev/null | grep "finger: unknown host" \
-        || end_testcase "finger @$BADHOST"
-    if ! finger $BADUSER@$BADHOST 2>&1 1>/dev/null \
-        | grep "finger: unknown host"; then
+    [ "finger $BADUSER 2>&1 1>/dev/null" ] || end_testcase "finger $BADUSER"
+    [ "finger @$BADHOST 2>&1 1>/dev/null" ] || end_testcase "finger @$BADHOST"
+    [ "finger $BADUSER@$BADHOST 2>&1 1>/dev/null" ] || \
         end_testcase "finger $BADUSER@$BADHOST"
-    fi
 }
 
 #-----------------------------------------------------------------------
-- 
1.9.3


------------------------------------------------------------------------------
Meet PCI DSS 3.0 Compliance Requirements with EventLog Analyzer
Achieve PCI DSS 3.0 Compliant Status with Out-of-the-box PCI DSS Reports
Are you Audit-Ready for PCI DSS 3.0 Compliance? Download White paper
Comply to PCI DSS 3.0 Requirement 10 and 11.5 with EventLog Analyzer
http://pubads.g.doubleclick.net/gampad/clk?id=154622311&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
