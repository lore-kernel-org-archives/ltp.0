Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1O9v2a-0007fp-Kp
	for ltp-list@lists.sourceforge.net; Thu, 06 May 2010 06:58:36 +0000
Received: from e38.co.us.ibm.com ([32.97.110.159])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1O9v2Z-0001OE-Dg
	for ltp-list@lists.sourceforge.net; Thu, 06 May 2010 06:58:36 +0000
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e38.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o466qCUO012530
	for <ltp-list@lists.sourceforge.net>; Thu, 6 May 2010 00:52:12 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o466wRoE087398
	for <ltp-list@lists.sourceforge.net>; Thu, 6 May 2010 00:58:27 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o45NwPhw006477
	for <ltp-list@lists.sourceforge.net>; Wed, 5 May 2010 17:58:26 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
Date: Thu, 06 May 2010 12:28:17 +0530
Message-Id: <20100506065815.23879.4005.sendpatchset@subratamodak.linux.ibm.com>
In-Reply-To: <20100506065548.23879.63131.sendpatchset@subratamodak.linux.ibm.com>
References: <20100506065548.23879.63131.sendpatchset@subratamodak.linux.ibm.com>
Subject: [09/12 FAILURE] LTPX timer create04 fails
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0405714898457694547=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Linus Test Project <ltp-list@lists.sourceforge.net>
Cc: Sharyathi Nagesh <sharyath@in.ibm.com>, Sachin P Sant <ssant@in.ibm.com>, "SUZUKI K. POULOSE" <suzuki@in.ibm.com>, B N Poornima <bnpoorni@in.ibm.com>

--===============0405714898457694547==

Subject: LTP�� timer_create04 fails

Issues Description below:
=======================================
# ./runltp -s timer_create04
<<<test_output>>>
timer_create04    1  TFAIL  :  didn't fail as expected [expected errno = 22
(Invalid argument)]: TEST_ERRNO=???(95): Operation not supported
timer_create04    2  TFAIL  :  didn't fail as expected [expected errno = 22
(Invalid argument)]: TEST_ERRNO=???(95): Operation not supported
timer_create04    3  TPASS  :  failed as expected: TEST_ERRNO=EFAULT(14): Bad
address
timer_create04    4  TPASS  :  failed as expected: TEST_ERRNO=EFAULT(14): Bad
address
timer_create04    5  TPASS  :  failed as expected: TEST_ERRNO=EFAULT(14): Bad
address
timer_create04    6  TPASS  :  failed as expected: TEST_ERRNO=EFAULT(14): Bad
address
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=0 cstime=0
<<<test_end>>>

SUZUKI K. POULOSE said that the same patch for issue #8 will solve the problem :-)

Regards--
Subrata



--===============0405714898457694547==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--===============0405714898457694547==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============0405714898457694547==--
