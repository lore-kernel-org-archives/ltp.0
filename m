Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <qcai@redhat.com>) id 1PUwO4-00026a-1Z
	for ltp-list@lists.sourceforge.net; Tue, 21 Dec 2010 07:11:56 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PUwO2-0008Ms-MJ
	for ltp-list@lists.sourceforge.net; Tue, 21 Dec 2010 07:11:56 +0000
Date: Tue, 21 Dec 2010 02:11:43 -0500 (EST)
From: CAI Qian <caiqian@redhat.com>
Message-ID: <1920170050.25294.1292915503845.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <4D105104.1000506@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH]Fix building error.
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
To: Bian Naimeng <biannm@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

> Could you tell me which kernels are this test fit to?
It is hard to tell. The old kernel might decide to back-port this feature.
> If there is old KSM interface, and this test can not work correctly on
> it, i think we should fix the test, it should not do anything but reports
> "This test is unsupported!"
Anyway, it would be more code to test here and there rather than kernel version. Isn't LTP's guideline to only support the latest and greatest kernels?

CAI Qian

------------------------------------------------------------------------------
Lotusphere 2011
Register now for Lotusphere 2011 and learn how
to connect the dots, take your collaborative environment
to the next level, and enter the era of Social Business.
http://p.sf.net/sfu/lotusphere-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
