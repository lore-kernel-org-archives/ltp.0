Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <paul.larson@canonical.com>) id 1MqSUC-00040p-3y
	for Ltp-list@lists.sourceforge.net; Wed, 23 Sep 2009 14:06:24 +0000
Received: from adelie.canonical.com ([91.189.90.139])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MqSU5-0004aD-S1
	for Ltp-list@lists.sourceforge.net; Wed, 23 Sep 2009 14:06:23 +0000
Received: from hutte.canonical.com ([91.189.90.181])
	by adelie.canonical.com with esmtp (Exim 4.69 #1 (Debian))
	id 1MqSKc-0005Or-1l
	for <Ltp-list@lists.sourceforge.net>; Wed, 23 Sep 2009 14:56:30 +0100
Received: from 75-27-138-126.lightspeed.austtx.sbcglobal.net ([75.27.138.126]
	helo=[192.168.1.70]) by hutte.canonical.com with esmtpsa
	(TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32) (Exim 4.69)
	(envelope-from <paul.larson@canonical.com>) id 1MqSKb-00009N-MX
	for Ltp-list@lists.sourceforge.net; Wed, 23 Sep 2009 14:56:30 +0100
From: Paul Larson <paul.larson@canonical.com>
Date: Wed, 23 Sep 2009 08:56:27 -0500
Message-Id: <1253714187.5697.13.camel@plars-t500>
Mime-Version: 1.0
Subject: [LTP] quotactl01 broken
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Linux Test Project <Ltp-list@lists.sourceforge.net>

quotactl01 appears to need some work.  I'm not terribly familiar with
this interface, but I spent a few minutes playing around with it this
morning.

First problem I was seeing is that all tests within it return EFAULT due
to a bad addr value  (for ref, see man page [1]).  This is not
surprising since it is being passed (caddr_t)NULL for the address.  I
worked around this by simply creating a dummy struct dqblk for it to use
instead.

Next problem is that it complained that the device it was being passed
was not valid.  Again, not a big surprise here since (const char *)NULL
is being passed as the device.  A possible workaround for this would be
to create a dummy loop0 device and mount it as part of the test setup.

Next problem I was seeing is that the QCMDs passed to it were not
correctly specified.  I believe in the TEST() call, we should be passing
QCMD(cmd[i],USRQUOTA) instead of just cmd[i].

I didn't get all the way to making it function correctly, but these 3
things alone got me to a point where several of the tests would pass at
least.  Before doing any of this, my output (running on x86_64, 2.6.31
based kernel) looked like:
quotactl01    1  TFAIL  :  quotactl01 failed, cmd=0x800002:
TEST_ERRNO=EFAULT(14): Bad address
quotactl01    2  TFAIL  :  quotactl01 failed, cmd=0x800003:
TEST_ERRNO=EFAULT(14): Bad address
quotactl01    3  TFAIL  :  quotactl01 failed, cmd=0x800007:
TEST_ERRNO=EFAULT(14): Bad address
quotactl01    4  TFAIL  :  quotactl01 failed, cmd=0x800008:
TEST_ERRNO=EFAULT(14): Bad address
quotactl01    5  TFAIL  :  quotactl01 failed, cmd=0x800005:
TEST_ERRNO=EFAULT(14): Bad address
quotactl01    6  TFAIL  :  quotactl01 failed, cmd=0x800006:
TEST_ERRNO=EFAULT(14): Bad address
quotactl01    7  TFAIL  :  quotactl01 failed, cmd=0x800004:
TEST_ERRNO=EFAULT(14): Bad address
quotactl01    8  TFAIL  :  quotactl01 failed, cmd=0x800001:
TEST_ERRNO=EFAULT(14): Bad address

I believe this test should be removed from the runtest file until it can
be fixed properly.

Thanks,
Paul Larson


[1]
http://www.kernel.org/doc/man-pages/online/pages/man2/quotactl.2.html


------------------------------------------------------------------------------
Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#33;
http://p.sf.net/sfu/devconf
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
