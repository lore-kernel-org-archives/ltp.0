Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1RbA3l-000452-TF
	for ltp-list@lists.sourceforge.net; Thu, 15 Dec 2011 12:05:13 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1RbA3h-0005ab-Vx
	for ltp-list@lists.sourceforge.net; Thu, 15 Dec 2011 12:05:13 +0000
Date: Thu, 15 Dec 2011 07:05:03 -0500 (EST)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <f0db187c-f0fd-4362-a618-f9c2dcd081e2@zmail16.collab.prod.int.phx2.redhat.com>
In-Reply-To: <CAGH67wTvxOTeyN6K2a23FG30TDA=Mn6xT6Xy4X3Hjmph09yBTg@mail.gmail.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH v2 2/2] pipeio: prevent race between SIGCHLD and
	open()
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net



----- Original Message -----
> From: "Garrett Cooper" <yanegomi@gmail.com>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp-list@lists.sourceforge.net
> Sent: Thursday, December 15, 2011 12:10:17 PM
> Subject: Re: [LTP] [PATCH v2 2/2] pipeio: prevent race between SIGCHLD and open()
> 
> On Thu, Dec 15, 2011 at 2:36 AM, Jan Stancek <jstancek@redhat.com>
> wrote:
> > Garrett,
> >
> > I'm not sure what happened, but I see only first patch from series
> > committed with description belonging to second one.
> >
> > Regards,
> > Jan
> 
>     I got confused by the multiple patches. Is this thread the one I
> need to look at to rectify the other issues identified?

Yes, this is the one.

I posted single patch yesterday:
[LTP] [PATCH] pipeio: prevent race between SIGCHLD and open()

You requested to use TERRNO instead of strerror(errno), so
while I was at it, I made this change for all existing code in pipeio.c:
[LTP] [PATCH v2 1/2] pipeio: convert strerror(errno) to TERRNO

and then put my original patch (with minor changes) on top of that:
[LTP] [PATCH v2 2/2] pipeio: prevent race between SIGCHLD and open()

Regards,
Jan

> Thanks,
> -Garrett
> 

------------------------------------------------------------------------------
10 Tips for Better Server Consolidation
Server virtualization is being driven by many needs.  
But none more important than the need to reduce IT complexity 
while improving strategic productivity.  Learn More! 
http://www.accelacomm.com/jaw/sdnl/114/51507609/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
