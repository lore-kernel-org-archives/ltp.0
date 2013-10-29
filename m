Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vincent.hsu@linaro.org>) id 1VbHel-0005nY-8g
	for ltp-list@lists.sourceforge.net; Tue, 29 Oct 2013 22:20:59 +0000
Received: from mail-ob0-f173.google.com ([209.85.214.173])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1VbHek-00065S-IJ
	for ltp-list@lists.sourceforge.net; Tue, 29 Oct 2013 22:20:59 +0000
Received: by mail-ob0-f173.google.com with SMTP id gq1so625057obb.18
	for <ltp-list@lists.sourceforge.net>;
	Tue, 29 Oct 2013 15:20:53 -0700 (PDT)
From: Vincent Hsu <vincent.hsu@linaro.org>
Date: Tue, 29 Oct 2013 15:20:37 -0700
Message-Id: <1383085243-5833-4-git-send-email-vincent.hsu@linaro.org>
In-Reply-To: <1383085243-5833-1-git-send-email-vincent.hsu@linaro.org>
References: <1383085243-5833-1-git-send-email-vincent.hsu@linaro.org>
Subject: [LTP] [LNG][PATCH 3/9] ltp-networking/tcp_cmds/finger: finger an
	unknown host test will return 1 even if execution success on
	Ubuntu 12.04
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

for example:
    $ finger @xxxx || echo "test fail"
    finger: unknown host: xxxx
    getaddrinfo: No address associated with hostname
    test fail
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
Android is increasing in popularity, but the open development platform that
developers love is also attractive to malware creators. Download this white
paper to learn more about secure code signing practices that can help keep
Android apps secure.
http://pubads.g.doubleclick.net/gampad/clk?id=65839951&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
