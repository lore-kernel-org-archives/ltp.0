Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <xu.simon@oracle.com>) id 1VebFQ-0007H5-Sd
	for ltp-list@lists.sourceforge.net; Fri, 08 Nov 2013 01:52:33 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VebFN-0007We-3f
	for ltp-list@lists.sourceforge.net; Fri, 08 Nov 2013 01:52:32 +0000
Received: from acsinet21.oracle.com (acsinet21.oracle.com [141.146.126.237])
	by userp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id rA81qMTo011238
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 8 Nov 2013 01:52:23 GMT
Received: from userz7021.oracle.com (userz7021.oracle.com [156.151.31.85])
	by acsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rA81qLjZ021698
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Fri, 8 Nov 2013 01:52:22 GMT
Received: from abhmt103.oracle.com (abhmt103.oracle.com [141.146.116.55])
	by userz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rA81qKex019758
	for <ltp-list@lists.sourceforge.net>; Fri, 8 Nov 2013 01:52:21 GMT
From: Simon Xu <xu.simon@oracle.com>
Date: Fri,  8 Nov 2013 09:52:15 +0800
Message-Id: <1383875535-496-1-git-send-email-xu.simon@oracle.com>
In-Reply-To: <20131107163021.GE9653@rei.Home>
References: <20131107163021.GE9653@rei.Home>
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
index e9b7bb5..d27f669 100755
--- a/testcases/network/multicast/mc_cmds/mc_cmds
+++ b/testcases/network/multicast/mc_cmds/mc_cmds
@@ -127,7 +127,8 @@ for eth in $IFNAME
    cat /proc/sys/net/ipv4/icmp_echo_ignore_broadcasts | grep 1 > /dev/null
    if [ $? -eq 0 ]
    then
-       end_testcase "Multicast ping disabled on this system (this is normal on post year:2005 kernels)"
+       tst_resm TCONF "Multicast ping disabled on this system (this is normal on post year:2005 kernels)"
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
