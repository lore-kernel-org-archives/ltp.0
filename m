Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1WCrgk-0004Rx-Oo
	for ltp-list@lists.sourceforge.net; Mon, 10 Feb 2014 14:18:22 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WCrgj-0000Cd-DG
	for ltp-list@lists.sourceforge.net; Mon, 10 Feb 2014 14:18:22 +0000
Date: Mon, 10 Feb 2014 09:18:15 -0500 (EST)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <1775991870.554840.1392041895068.JavaMail.zimbra@redhat.com>
In-Reply-To: <52F83739.4000106@oracle.com>
References: <1387171228-505-1-git-send-email-xu.simon@oracle.com>
	<52BA3898.3050909@oracle.com> <52DDD0ED.6040702@oracle.com>
	<2085388669.1674106.1391081515715.JavaMail.root@redhat.com>
	<20140204132922.GA6597@rei> <52F83739.4000106@oracle.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] sctp: Avoid using file descriptor 0
	to	get	ENOTSOCK
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
To: Simon Xu <xu.simon@oracle.com>
Cc: ltp-list@lists.sourceforge.net





----- Original Message -----
> From: "Simon Xu" <xu.simon@oracle.com>
> To: ltp-list@lists.sourceforge.net
> Sent: Monday, 10 February, 2014 3:19:37 AM
> Subject: Re: [LTP] [PATCH] sctp: Avoid using file descriptor 0 to	get	ENOTSOCK
> 
> Any extra steps needed before applying it in LTP?

Pushed, thank you,
Jan

> 
> Thanks
> Simon
> 
> On 2014/2/4 21:29, chrubis@suse.cz wrote:
> > Hi!
> >> Given that this is identical to c43ead6daa0b9ae5763d6cf3d21357a789651417
> >> from
> >> https://github.com/borkmann/lksctp-tools :
> >>
> >> Acked-by: Jan Stancek <jstancek@redhat.com>
> > I would be tempted to put the repeated code fragemnts into single place
> > (header included by all of the testcases). But given that the patch is
> > in upstream I'm OK with applying it in LTP as well.
> 
> ------------------------------------------------------------------------------
> Managing the Performance of Cloud-Based Applications
> Take advantage of what the Cloud has to offer - Avoid Common Pitfalls.
> Read the Whitepaper.
> http://pubads.g.doubleclick.net/gampad/clk?id=121051231&iu=/4140/ostg.clktrk
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 

------------------------------------------------------------------------------
Managing the Performance of Cloud-Based Applications
Take advantage of what the Cloud has to offer - Avoid Common Pitfalls.
Read the Whitepaper.
http://pubads.g.doubleclick.net/gampad/clk?id=121051231&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
