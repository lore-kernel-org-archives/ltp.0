Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1Rb8fm-0001ww-7i
	for ltp-list@lists.sourceforge.net; Thu, 15 Dec 2011 10:36:22 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Rb8fg-0004FY-FL
	for ltp-list@lists.sourceforge.net; Thu, 15 Dec 2011 10:36:22 +0000
Date: Thu, 15 Dec 2011 05:36:09 -0500 (EST)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <ee737595-7ec2-4e85-a5fe-a393c4a86c7f@zmail16.collab.prod.int.phx2.redhat.com>
In-Reply-To: <CAGH67wSnNDgrg5700WhGZ_8==v2wpo9AzSGwnwvVpyUzPq3QEQ@mail.gmail.com>
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

Garrett,

I'm not sure what happened, but I see only first patch from series
committed with description belonging to second one.

Regards,
Jan

----- Original Message -----
> From: "Garrett Cooper" <yanegomi@gmail.com>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp-list@lists.sourceforge.net
> Sent: Thursday, December 15, 2011 11:15:34 AM
> Subject: Re: [LTP] [PATCH v2 2/2] pipeio: prevent race between SIGCHLD and open()
> 
> On Thu, Dec 15, 2011 at 1:35 AM, Jan Stancek <jstancek@redhat.com>
> wrote:
> >
> > This test occasionally hangs on some machines. The hang has been
> > observed mostly on single CPU ones.
> >
> > pipeio code is using signal(2), setting by default SA_RESTART
> > flag, which is also the case for SIGCHLD.
> >
> > If last child manages to exit while parent is still at open(),
> > parent gets SIGCHLD and open() is restarted. At this point test
> > hangs.
> >
> > Here's strace output from parent point of view:
> 
> Committed -- thanks!
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
