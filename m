Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vincent.hsu@linaro.org>) id 1VlYn9-0005Ly-9F
	for ltp-list@lists.sourceforge.net; Wed, 27 Nov 2013 06:40:07 +0000
Received: from mail-pb0-f52.google.com ([209.85.160.52])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1VlYn7-0004p7-I7
	for ltp-list@lists.sourceforge.net; Wed, 27 Nov 2013 06:40:07 +0000
Received: by mail-pb0-f52.google.com with SMTP id uo5so9729906pbc.11
	for <ltp-list@lists.sourceforge.net>;
	Tue, 26 Nov 2013 22:39:59 -0800 (PST)
From: Vincent Hsu <vincent.hsu@linaro.org>
Date: Wed, 27 Nov 2013 14:37:51 +0800
Message-Id: <1385534272-32414-2-git-send-email-vincent.hsu@linaro.org>
In-Reply-To: <1385534272-32414-1-git-send-email-vincent.hsu@linaro.org>
References: <1385534272-32414-1-git-send-email-vincent.hsu@linaro.org>
Subject: [LTP] [LNG][PATCH V2 1/2] ltp-networking/tcp_cmds/finger: fix
	finger test
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
Cc: linaro-networking@linaro.org

Ubuntu use modified finger command. finger an unknown host test will
return nonzero on Ubuntu 12.04 even if successful execution.

for example:
on Ubuntu
    finger @xxx 2>&1 1>/dev/null ; echo $?
will return
    finger: unknown host: xxx
    getaddrinfo: No address associated with hostname
    1
on CentOS
    finger @xxx 2>&1 1>/dev/null ; echo $?
will return
    finger: xxx: nodename nor servname provided, or not known
    0

Signed-off-by: Vincent Hsu <vincent.hsu@linaro.org>
---
 testcases/network/tcp_cmds/finger/finger01 |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/testcases/network/tcp_cmds/finger/finger01 b/testcases/network/tcp_cmds/finger/finger01
index 6a72c8f..81da3e0 100755
--- a/testcases/network/tcp_cmds/finger/finger01
+++ b/testcases/network/tcp_cmds/finger/finger01
@@ -116,8 +116,10 @@ do_test2()

     tst_resm TINFO "finger -bad user "
     finger $BADUSER 2>&1 1>/dev/null || end_testcase "finger $BADUSER"
-    finger @$BADHOST 2>&1 1>/dev/null || end_testcase "finger @$BADHOST"
-    if ! finger $BADUSER@$BADHOST 2>&1 1>/dev/null; then
+    finger @$BADHOST 2>&1 1>/dev/null | grep "finger: unknown host" \
+        || end_testcase "finger @$BADHOST"
+    if ! finger $BADUSER@$BADHOST 2>&1 1>/dev/null \
+        | grep "finger: unknown host"; then
         end_testcase "finger $BADUSER@$BADHOST"
     fi
 }
@@ -158,7 +160,8 @@ do_test3()
         end_testcase "finger -m $RUSER@$RHOST"
     fi

-    tst_resm TINFO "finger -p : suppresses printing of .plan files on long and brief long formats"
+    tst_resm TINFO "finger -p : suppresses printing of .plan files on long and \
+        brief long formats"
     finger -p  2>&1 1>/dev/null || end_testcase "finger -p"
     finger -p $LUSER  2>&1 1>/dev/null || end_testcase "finger -p $LUSER"
     finger -p @$LHOST  2>&1 1>/dev/null || end_testcase "finger -p @$LHOST"
--
1.7.9.5


------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349351&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
