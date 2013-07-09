Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <penght@cn.fujitsu.com>) id 1UwRTu-0002GO-E2
	for ltp-list@lists.sourceforge.net; Tue, 09 Jul 2013 06:32:58 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UwRTr-0001OX-5y
	for ltp-list@lists.sourceforge.net; Tue, 09 Jul 2013 06:32:58 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id r696WbAs010812
	for <ltp-list@lists.sourceforge.net>; Tue, 9 Jul 2013 14:32:37 +0800
From: Peng Haitao <penght@cn.fujitsu.com>
Date: Tue, 9 Jul 2013 14:32:17 +0800
Message-Id: <1373351537-15562-1-git-send-email-penght@cn.fujitsu.com>
Subject: [LTP] [PATCH] cmdlib.sh: fix a bug of restart_daemon
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

start should be replaced with restart in restart_daemon().

Signed-off-by: Peng Haitao <penght@cn.fujitsu.com>
---
 testcases/lib/cmdlib.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/lib/cmdlib.sh b/testcases/lib/cmdlib.sh
index 7819cb7..b1ea15e 100644
--- a/testcases/lib/cmdlib.sh
+++ b/testcases/lib/cmdlib.sh
@@ -198,8 +198,8 @@ status_daemon()
 restart_daemon()
 {
 	if [ $HAVE_SYSTEMCTL -eq 1 ]; then
-		systemctl start $1.service > /dev/null 2>&1
+		systemctl restart $1.service > /dev/null 2>&1
 	else
-		service $1 start > /dev/null 2>&1
+		service $1 restart > /dev/null 2>&1
 	fi
 }
-- 
1.8.3.1


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
