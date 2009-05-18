Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <serge@us.ibm.com>) id 1M64RZ-0007bF-Fk
	for ltp-list@lists.sourceforge.net; Mon, 18 May 2009 15:07:57 +0000
Received: from e37.co.us.ibm.com ([32.97.110.158])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1M64RY-00067Y-1u
	for ltp-list@lists.sourceforge.net; Mon, 18 May 2009 15:07:57 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e37.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n4IF7EL4025930
	for <ltp-list@lists.sourceforge.net>; Mon, 18 May 2009 09:07:14 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n4IF7cRq030944
	for <ltp-list@lists.sourceforge.net>; Mon, 18 May 2009 09:07:45 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n4IF7Rq2023564
	for <ltp-list@lists.sourceforge.net>; Mon, 18 May 2009 09:07:36 -0600
Date: Mon, 18 May 2009 10:07:25 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
Message-ID: <20090518150725.GA9790@us.ibm.com>
References: <4A0D13F2.8030804@cn.fujitsu.com>
	<20090515134519.GA21654@us.ibm.com>
	<1242647979.5161.12.camel@subratamodak.linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1242647979.5161.12.camel@subratamodak.linux.ibm.com>
Subject: Re: [LTP] [PATCH] Synchronization between two processes
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
To: Subrata Modak <subrata@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net

Quoting Subrata Modak (subrata@linux.vnet.ibm.com):
> On Fri, 2009-05-15 at 08:45 -0500, Serge E. Hallyn wrote: 
> > Quoting Gui Xiaohua (guixh@cn.fujitsu.com):
> > > The child-process wait SIGUSR1 which would be sended by parent-process,
> > > if the child-process execute sigtimedwait() after parent-process send 
> > > the signal, it would never receive the SIGUSR1 from parent-process.
> > > I cann't make sure the SIGUSR1 be sended after child-process execute 
> > > sigtimedwait() with 100 percent, and i try my best.
> > 
> > Well, in theory I suppose this could happen, but you'd have to have
> > a pretty bad scheduler if the parent can do a strcmp(buf, "c:go")
> > between the pipe read and signal send, while the child goes straight
> > from pipe write to sigtimedwait.
> > 
> > Have you seen this signal be missed?  If not, then I'd rather assume
> > things are reasonable.  If you have seen this happen, then why not
> > instead set up a SIGUSR1 handler in the child before doing the pipe
> > write, then just sleep for 3 seconds instead of doing sigtimedwait?
> 
> Thanks Serge.

Or, if I'm being unreasonable, then at least have the parent only wait
for at most 1 second, and leave the child alone.  Every every ltp test
is going to hang for 5 seconds...

But I prefer setting the signal handler ahead of time.

> Gui,
> 
> Are you planning any further patch(s) for this ?

thanks,
-serge

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
