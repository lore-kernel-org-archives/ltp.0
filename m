Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MyEYw-0001Jd-66
	for ltp-list@lists.sourceforge.net; Thu, 15 Oct 2009 00:51:26 +0000
Received: from mail-pz0-f188.google.com ([209.85.222.188])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MyEYv-0007qb-8G
	for ltp-list@lists.sourceforge.net; Thu, 15 Oct 2009 00:51:26 +0000
Received: by pzk26 with SMTP id 26so294574pzk.4
	for <ltp-list@lists.sourceforge.net>;
	Wed, 14 Oct 2009 17:51:19 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 14 Oct 2009 17:51:19 -0700
Message-ID: <364299f40910141751o69a05cfbwecb30c5d1307e7cf@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: [LTP] [issue 13] ip_tests takes down interfaces;
	affects nfs rootfs based 	testing on slower platforms
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
To: LTP list <ltp-list@lists.sourceforge.net>

Hi again,
    I've noticed on one of our slower platforms (k5 -- patterned after
the FreeScale 8548 board) that when using NFS rootfs and executing
this test, the probability of the test interrupting the connection
between the NFS rootfs server and the k5 is high, such that the target
gets completely hosed.
    How about this: the test should be modified to use loopback or a
psuedo interfaces, and then if and when that fails, use any and all
real interfaces (preference going to unused devices)?
Thanks,
-Garrett

------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
