Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vincent.hsu@linaro.org>) id 1VbHem-0005ny-Pz
	for ltp-list@lists.sourceforge.net; Tue, 29 Oct 2013 22:21:00 +0000
Received: from mail-ob0-f178.google.com ([209.85.214.178])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1VbHem-0006t5-47
	for ltp-list@lists.sourceforge.net; Tue, 29 Oct 2013 22:21:00 +0000
Received: by mail-ob0-f178.google.com with SMTP id wm4so618012obc.23
	for <ltp-list@lists.sourceforge.net>;
	Tue, 29 Oct 2013 15:20:54 -0700 (PDT)
From: Vincent Hsu <vincent.hsu@linaro.org>
Date: Tue, 29 Oct 2013 15:20:38 -0700
Message-Id: <1383085243-5833-5-git-send-email-vincent.hsu@linaro.org>
In-Reply-To: <1383085243-5833-1-git-send-email-vincent.hsu@linaro.org>
References: <1383085243-5833-1-git-send-email-vincent.hsu@linaro.org>
Subject: [LTP] [LNG][PATCH 4/9] ltp-networking/tcp_cmds/netstat: netstat
	cmds will return 1 even if no output in stderr on Ubuntu 12.04
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
    $ netstat -s 1>netstat/dev/null 2>&1 ; echo $?
    1

This if condition would have worng result.
    if ! netstat $flag 1>/dev/null 2>&1; then
        end_testcase "netstat $flag failed"
    fi
---
 testcases/network/tcp_cmds/netstat/netstat01 |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/testcases/network/tcp_cmds/netstat/netstat01 b/testcases/network/tcp_cmds/netstat/netstat01
index 3c2d1bb..6d4682a 100755
--- a/testcases/network/tcp_cmds/netstat/netstat01
+++ b/testcases/network/tcp_cmds/netstat/netstat01
@@ -58,7 +58,8 @@ do_test() {
     while [ $TST_COUNT -le $NUMLOOPS ]; do

         for flag in "-s" "-rn" "-i" "-gn" "-apn"; do
-            if ! netstat $flag 1>/dev/null 2>&1; then
+            var=$(netstat $flag 1>/dev/null 2>&1);
+            if [ "$var" != "" ]; then
                 end_testcase "netstat $flag failed"
             fi
         done
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
