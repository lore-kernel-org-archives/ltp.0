Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <xu.simon@oracle.com>) id 1VeElV-0007Xy-TV
	for ltp-list@lists.sourceforge.net; Thu, 07 Nov 2013 01:52:09 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VeElV-0003Sn-2O
	for ltp-list@lists.sourceforge.net; Thu, 07 Nov 2013 01:52:09 +0000
Received: from acsinet21.oracle.com (acsinet21.oracle.com [141.146.126.237])
	by userp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id rA71q2ef007675
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 7 Nov 2013 01:52:03 GMT
Received: from aserz7022.oracle.com (aserz7022.oracle.com [141.146.126.231])
	by acsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rA71q15h009475
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Thu, 7 Nov 2013 01:52:01 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
	by aserz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rA71q1l4020276
	for <ltp-list@lists.sourceforge.net>; Thu, 7 Nov 2013 01:52:01 GMT
From: Simon Xu <xu.simon@oracle.com>
Date: Thu,  7 Nov 2013 09:51:55 +0800
Message-Id: <1383789115-553-1-git-send-email-xu.simon@oracle.com>
Subject: [LTP] [PATCH] mc_cmds: Multicast ping being disabled should not
	fail the test
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

Signed-off-by: Simon Xu <xu.simon@oracle.com>
---
 testcases/network/multicast/mc_cmds/mc_cmds | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/testcases/network/multicast/mc_cmds/mc_cmds b/testcases/network/multicast/mc_cmds/mc_cmds
index e9b7bb5..47bd4b9 100755
--- a/testcases/network/multicast/mc_cmds/mc_cmds
+++ b/testcases/network/multicast/mc_cmds/mc_cmds
@@ -127,7 +127,8 @@ for eth in $IFNAME
    cat /proc/sys/net/ipv4/icmp_echo_ignore_broadcasts | grep 1 > /dev/null
    if [ $? -eq 0 ]
    then
-       end_testcase "Multicast ping disabled on this system (this is normal on post year:2005 kernels)"
+       tst_resm TINFO "Multicast ping disabled on this system (this is normal on post year:2005 kernels)"
+       exit 0
    fi
 
    # Do the ping tests: Execute ping 224.0.0.1 - Verify that the proper
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
