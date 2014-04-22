Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1WcZJw-00065l-Uu
	for ltp-list@lists.sourceforge.net; Tue, 22 Apr 2014 11:57:04 +0000
Received: from mx5-phx2.redhat.com ([209.132.183.37])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WcZJt-0005wW-Dd
	for ltp-list@lists.sourceforge.net; Tue, 22 Apr 2014 11:57:04 +0000
Date: Tue, 22 Apr 2014 07:56:55 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <29506955.7719026.1398167815215.JavaMail.zimbra@redhat.com>
In-Reply-To: <1398078461-23926-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1398078461-23926-1-git-send-email-stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
Subject: Re: [LTP] OpenPosix timeout fixes
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
To: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Cc: vasily isaenko <vasily.isaenko@oracle.com>, ltp-list@lists.sourceforge.net





----- Original Message -----
> From: "Stanislav Kholmanskikh" <stanislav.kholmanskikh@oracle.com>
> To: ltp-list@lists.sourceforge.net
> Cc: "vasily isaenko" <vasily.isaenko@oracle.com>
> Sent: Monday, 21 April, 2014 1:07:39 PM
> Subject: [LTP] OpenPosix timeout fixes
> 
> Hi!
> 
> We intentionally compile this suite without any optimizations.
> 
> On some non-x86 platforms the test cases may execute longer that it's
> expected.
> 
> Perhaps, the timeout values were initially set for x86 environment.
> 
> Given that OpenPosix Test Suite is not a benchmark, I see no problem in
> increasing
> the values a bit...

Me neither, ACK.

Regards,
Jan

> 
> Thanks.
> 
> 
> ------------------------------------------------------------------------------
> Start Your Social Network Today - Download eXo Platform
> Build your Enterprise Intranet with eXo Platform Software
> Java Based Open Source Intranet - Social, Extensible, Cloud Ready
> Get Started Now And Turn Your Intranet Into A Collaboration Platform
> http://p.sf.net/sfu/ExoPlatform
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 

------------------------------------------------------------------------------
Start Your Social Network Today - Download eXo Platform
Build your Enterprise Intranet with eXo Platform Software
Java Based Open Source Intranet - Social, Extensible, Cloud Ready
Get Started Now And Turn Your Intranet Into A Collaboration Platform
http://p.sf.net/sfu/ExoPlatform
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
