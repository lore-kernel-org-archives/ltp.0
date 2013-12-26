Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1Vw6uo-0005LB-L7
	for ltp-list@lists.sourceforge.net; Thu, 26 Dec 2013 09:07:38 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Vw6un-00071g-Pz
	for ltp-list@lists.sourceforge.net; Thu, 26 Dec 2013 09:07:38 +0000
Received: from acsinet22.oracle.com (acsinet22.oracle.com [141.146.126.238])
	by userp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id rBQ97U1C028245
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 26 Dec 2013 09:07:31 GMT
Received: from userz7021.oracle.com (userz7021.oracle.com [156.151.31.85])
	by acsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rBQ97UxK001926
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Thu, 26 Dec 2013 09:07:30 GMT
Received: from ubhmt120.oracle.com (ubhmt120.oracle.com [156.151.24.25])
	by userz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rBQ97TcP027143
	for <ltp-list@lists.sourceforge.net>; Thu, 26 Dec 2013 09:07:29 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Thu, 26 Dec 2013 13:07:17 +0400
Message-Id: <1388048842-28373-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] rpc-tirpc-full-test-suite
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
Cc: vasily.isaenko@oracle.com

Hi!

I found that run_rpc_test.sh fails during ltpstress.sh execution. And it fails
because the rpc-tirpc-full-test-suite is not compiled.

So I:
* integrated a part of the rpc-tirpc-full-test-suite into the LTP
  building process (added Makefiles and etc). This part is the one
  which was executed by run_rpc_tests.sh.

* changed the description of the testcases in runtest/.
  To ease debugging.

I couldn't find a solution to make 'make' add the '.bin' suffix to the produced
binaries. Therefore I had to fix some of the test scripts for that fact.

Does anybody know how to do that?

Thank you.

PS: in my environment rpc_broadc_basic_lib fails. But it fails with the current git
version as well. I've not yet figured out why.


------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349831&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
