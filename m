Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vincent.hsu@linaro.org>) id 1VgoDu-0004TV-IL
	for ltp-list@lists.sourceforge.net; Thu, 14 Nov 2013 04:08:06 +0000
Received: from mail-pd0-f178.google.com ([209.85.192.178])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1VgoDs-0003qb-Se
	for ltp-list@lists.sourceforge.net; Thu, 14 Nov 2013 04:08:06 +0000
Received: by mail-pd0-f178.google.com with SMTP id p10so1384789pdj.23
	for <ltp-list@lists.sourceforge.net>;
	Wed, 13 Nov 2013 20:07:59 -0800 (PST)
From: Vincent Hsu <vincent.hsu@linaro.org>
Date: Thu, 14 Nov 2013 11:38:37 +0800
Message-Id: <1384400319-30776-6-git-send-email-vincent.hsu@linaro.org>
In-Reply-To: <1384400319-30776-1-git-send-email-vincent.hsu@linaro.org>
References: <1384400319-30776-1-git-send-email-vincent.hsu@linaro.org>
Subject: [LTP] [LNG][PATCH 6/8] ltp-networking/tcp_cmds/finger: fix finger
	test
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
return nonzero on Ubuntu 12.04 even if execution success.

for example:
in Ubuntu
    finger @xxx 2>&1 1>/dev/null ; echo $?
will return
    finger: unknown host: xxx
    getaddrinfo: No address associated with hostname
    1
in CentOS
    finger @xxx 2>&1 1>/dev/null ; echo $?
will return
    finger: xxx: nodename nor servname provided, or not known
    0

Signed-off-by: Vincent Hsu <vincent.hsu@linaro.org>
---
 testcases/network/tcp_cmds/finger/finger01 |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/network/tcp_cmds/finger/finger01 b/testcases/network/tcp_cmds/finger/finger01
index 6a72c8f..a5206be 100755
--- a/testcases/network/tcp_cmds/finger/finger01
+++ b/testcases/network/tcp_cmds/finger/finger01
@@ -116,8 +116,8 @@ do_test2()

     tst_resm TINFO "finger -bad user "
     finger $BADUSER 2>&1 1>/dev/null || end_testcase "finger $BADUSER"
-    finger @$BADHOST 2>&1 1>/dev/null || end_testcase "finger @$BADHOST"
-    if ! finger $BADUSER@$BADHOST 2>&1 1>/dev/null; then
+    finger @$BADHOST 2>&1 1>/dev/null | grep "finger: unknown host" || end_testcase "finger @$BADHOST"
+    if ! finger $BADUSER@$BADHOST 2>&1 1>/dev/null | grep "finger: unknown host"; then
         end_testcase "finger $BADUSER@$BADHOST"
     fi
 }
--
1.7.9.5


------------------------------------------------------------------------------
DreamFactory - Open Source REST & JSON Services for HTML5 & Native Apps
OAuth, Users, Roles, SQL, NoSQL, BLOB Storage and External API Access
Free app hosting. Or install the open source package on any LAMP server.
Sign up and see examples for AngularJS, jQuery, Sencha Touch and Native!
http://pubads.g.doubleclick.net/gampad/clk?id=63469471&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
