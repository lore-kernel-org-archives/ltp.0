Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <xu.simon@oracle.com>) id 1Vfkfm-0005v6-CN
	for ltp-list@lists.sourceforge.net; Mon, 11 Nov 2013 06:08:30 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Vfkfk-0005KB-4g
	for ltp-list@lists.sourceforge.net; Mon, 11 Nov 2013 06:08:30 +0000
Received: from ucsinet21.oracle.com (ucsinet21.oracle.com [156.151.31.93])
	by userp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id rAB68LoK027224
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 11 Nov 2013 06:08:22 GMT
Received: from aserz7022.oracle.com (aserz7022.oracle.com [141.146.126.231])
	by ucsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rAB68KcM022564
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Mon, 11 Nov 2013 06:08:21 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
	by aserz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rAB68KoP011525
	for <ltp-list@lists.sourceforge.net>; Mon, 11 Nov 2013 06:08:20 GMT
From: Simon Xu <xu.simon@oracle.com>
Date: Mon, 11 Nov 2013 14:08:11 +0800
Message-Id: <1384150091-582-1-git-send-email-xu.simon@oracle.com>
Subject: [LTP] [PATCH] tcpdump01: specify interface for ping
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

Always specify interface for ping because it is possible that pings to RHOST
can go through multiple interfaces.  Also add -q to ping.

Signed-off-by: Simon Xu <xu.simon@oracle.com>
---
 testcases/network/tcp_cmds/tcpdump/tcpdump01 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/network/tcp_cmds/tcpdump/tcpdump01 b/testcases/network/tcp_cmds/tcpdump/tcpdump01
index 6d6d399..6296ad2 100755
--- a/testcases/network/tcp_cmds/tcpdump/tcpdump01
+++ b/testcases/network/tcp_cmds/tcpdump/tcpdump01
@@ -51,7 +51,7 @@ do_setup()
     # Find the first interface that can ping RHOST
     IF=""
     for i in $(netstat -i | tail -n+3 | sed '/^lo/d' | cut -f1 -d' '); do
-        ping -I $i -c 3 $RHOST && { IF="$i"; break; }
+        ping -I $i -c 3 -q $RHOST && { IF="$i"; break; }
     done
     test -z $IF && end_testcase "Could not find an interface that can ping remote host $RHOST"
     IFNAME=${IF}
@@ -62,7 +62,7 @@ do_setup()
 
 do_test()
 {
-    ping -f $RHOST > /dev/null 2>&1 &
+    ping -I $IFNAME -f $RHOST > /dev/null 2>&1 &
     if ! tcpdump -i $IFNAME -c $NUMLOOPS > $OUTFILE; then
         end_testcase "Problems trying to launch tcpdump"
     fi
-- 
1.8.4.2


------------------------------------------------------------------------------
November Webinars for C, C++, Fortran Developers
Accelerate application performance with scalable programming models. Explore
techniques for threading, error checking, porting, and tuning. Get the most 
from the latest Intel processors and coprocessors. See abstracts and register
http://pubads.g.doubleclick.net/gampad/clk?id=60136231&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
