Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1T46mP-0005tb-LU
	for ltp-list@lists.sourceforge.net; Wed, 22 Aug 2012 08:59:13 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1T46mK-0001OU-2p
	for ltp-list@lists.sourceforge.net; Wed, 22 Aug 2012 08:59:13 +0000
Date: Wed, 22 Aug 2012 04:58:59 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <40249568.8900482.1345625939805.JavaMail.root@redhat.com>
In-Reply-To: <5034984B.3020905@windriver.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] pthread_detach/4-3: workaround for segment fault
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
To: Kang Kai <Kai.Kang@windriver.com>
Cc: ltp-list@lists.sourceforge.net, Zhenfeng Zhao <Zhenfeng.Zhao@windriver.com>



----- Original Message -----
> From: "Kang Kai" <Kai.Kang@windriver.com>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: gaowanlong@cn.fujitsu.com, ltp-list@lists.sourceforge.net, "Zhenfeng Zhao" <Zhenfeng.Zhao@windriver.com>
> Sent: Wednesday, 22 August, 2012 10:28:59 AM
> Subject: Re: [LTP] [PATCH] pthread_detach/4-3: workaround for segment fault

> Hi Jan,
> 
> > Is the above output from mips or x86_64?
> > Are you running it as root user?
> 
> This was tested on x86_64 with unprivileged  user. I retest it with
> root
> and test passes.

Your unprivileged user is hitting some resource limit, I'd be interested
to see how many threads are actually running at the same time. 

> It passes on routerstation(mips) with your patch too.
> So it looks like a race condition issue about stack attribute between
> threads, right?

I think so. We can try different way of signalling when threaded() is done
and try it again with all scenarios.

Regards,
Jan

> 
> Thanks a lot.
> Kai
> 


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
