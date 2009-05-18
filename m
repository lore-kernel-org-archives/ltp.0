Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1M61VW-0005Oe-L7
	for ltp-list@lists.sourceforge.net; Mon, 18 May 2009 11:59:50 +0000
Received: from e31.co.us.ibm.com ([32.97.110.149])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1M61VS-0006Zn-3a
	for ltp-list@lists.sourceforge.net; Mon, 18 May 2009 11:59:50 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n4IBtqac024551
	for <ltp-list@lists.sourceforge.net>; Mon, 18 May 2009 05:55:52 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n4IBxikf078512
	for <ltp-list@lists.sourceforge.net>; Mon, 18 May 2009 05:59:44 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n4IBxhrZ025362
	for <ltp-list@lists.sourceforge.net>; Mon, 18 May 2009 05:59:43 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <20090515134519.GA21654@us.ibm.com>
References: <4A0D13F2.8030804@cn.fujitsu.com>
	<20090515134519.GA21654@us.ibm.com>
Date: Mon, 18 May 2009 17:29:38 +0530
Message-Id: <1242647979.5161.12.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Synchronization between two processes
Reply-To: subrata@linux.vnet.ibm.com
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
To: "Serge E. Hallyn" <serue@us.ibm.com>, Gui Xiaohua <guixh@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

On Fri, 2009-05-15 at 08:45 -0500, Serge E. Hallyn wrote: 
> Quoting Gui Xiaohua (guixh@cn.fujitsu.com):
> > The child-process wait SIGUSR1 which would be sended by parent-process,
> > if the child-process execute sigtimedwait() after parent-process send 
> > the signal, it would never receive the SIGUSR1 from parent-process.
> > I cann't make sure the SIGUSR1 be sended after child-process execute 
> > sigtimedwait() with 100 percent, and i try my best.
> 
> Well, in theory I suppose this could happen, but you'd have to have
> a pretty bad scheduler if the parent can do a strcmp(buf, "c:go")
> between the pipe read and signal send, while the child goes straight
> from pipe write to sigtimedwait.
> 
> Have you seen this signal be missed?  If not, then I'd rather assume
> things are reasonable.  If you have seen this happen, then why not
> instead set up a SIGUSR1 handler in the child before doing the pipe
> write, then just sleep for 3 seconds instead of doing sigtimedwait?

Thanks Serge.

Gui,

Are you planning any further patch(s) for this ?

Regards--
Subrata

> 
> > Signed-off-by: Gui Xiaohua <guixh@cn.fujitsu.com>
> > --- testcases/kernel/containers/pidns/pidns12-old.c	2009-05-14 17:00:20.000000000 +0800
> > +++ testcases/kernel/containers/pidns/pidns12.c	2009-05-15 15:15:22.000000000 +0800
> > @@ -109,7 +109,7 @@ int child_fn(void *arg)
> >  	}
> > 
> >  	/* Set timeout for sigtimedwait */
> > -	timeout.tv_sec = 3;
> > +	timeout.tv_sec = 10;
> >  	timeout.tv_nsec = 0;
> > 
> >  	/* Set mask to wait for SIGUSR1 signal */
> > @@ -182,6 +182,9 @@ int main(int argc, char *argv[])
> >  		cleanup();
> >  	}
> > 
> > +	/*Try best to make sure the SIGUSR1 be sended after child-process execute sigtimedwait*/
> > +	sleep(5);
> > +
> >  	/* Send SIGUSR1 to container init */
> >  	if (kill(cpid, SIGUSR1) == -1) {
> >  		tst_resm(TBROK, "parent: kill() failed(%s).", strerror(errno));
> > 
> > 
> > ------------------------------------------------------------------------------
> > Crystal Reports - New Free Runtime and 30 Day Trial
> > Check out the new simplified licensing option that enables 
> > unlimited royalty-free distribution of the report engine 
> > for externally facing server and web deployment. 
> > http://p.sf.net/sfu/businessobjects
> > _______________________________________________
> > Ltp-list mailing list
> > Ltp-list@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/ltp-list
> 
> ------------------------------------------------------------------------------
> Crystal Reports - New Free Runtime and 30 Day Trial
> Check out the new simplified licensing option that enables 
> unlimited royalty-free distribution of the report engine 
> for externally facing server and web deployment. 
> http://p.sf.net/sfu/businessobjects
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables 
unlimited royalty-free distribution of the report engine 
for externally facing server and web deployment. 
http://p.sf.net/sfu/businessobjects
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
