Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MJ7La-0002Mz-CF
	for ltp-list@lists.sourceforge.net; Tue, 23 Jun 2009 14:51:42 +0000
Received: from e37.co.us.ibm.com ([32.97.110.158])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MJ7LW-0001Wh-Ml
	for ltp-list@lists.sourceforge.net; Tue, 23 Jun 2009 14:51:42 +0000
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <1DCCECAE-C103-4C69-B87A-39481998D222@gmail.com>
References: <906633.66122.qm@web1106.biz.mail.sk1.yahoo.com>
	<1232357659.5057.18.camel@subratamodak.linux.ibm.com>
	<1DCCECAE-C103-4C69-B87A-39481998D222@gmail.com>
Date: Tue, 23 Jun 2009 20:18:10 +0530
Message-Id: <1245768490.4860.54.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] sched_cli_serv: client: connect failure,
	no =	111 v2
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: "ltp-list@lists.sf.net" <ltp-list@lists.sf.net>

On Mon, 2009-01-19 at 02:59 -0800, Garrett Cooper wrote: 
> On Jan 19, 2009, at 1:34, Subrata Modak <subrata@linux.vnet.ibm.com>  
> wrote:
> 
> >
> > On Fri, 2009-01-16 at 01:25 -0800, CAI Qian wrote:
> >> Hi,
> >>
> >>
> >> --- On Fri, 1/16/09, Garrett Cooper <yanegomi@gmail.com> wrote:
> >>
> >>> From: Garrett Cooper <yanegomi@gmail.com>
> >>> Subject: Re: [LTP] [PATCH] sched_cli_serv: client: connect  
> >>> failure, no = 111 v2
> >>> To: caiqian@cclom.cn
> >>> Cc: ltp-list@lists.sf.net
> >>> Date: Friday, January 16, 2009, 3:39 PM
> >>> On Thu, Jan 15, 2009 at 11:25 PM, CAI Qian
> >>> <caiqian@cclom.cn> wrote:
> >>>> Hi,
> >>>>
> >>>> Sometimes, sched_cli_serv test case can still fail due
> >>> to,
> >>>>
> >>>> client: connect failure, no = 111
> >>>>
> >>>> This is because when the system is under load, the
> >>> client may connect
> >>>> before the server is ready. This patch fixes it by
> >>> letting the server
> >>>> run for 10 seconds first. It also disable shell
> >>> command tracing by
> >>>> default which was accidentally introduced by the last
> >>> patch,
> >>>>
> >>>> http://article.gmane.org/gmane.linux.ltp/7149
> >>>>
> >>>> Signed-off-by: CAI Qian <caiqian@cclom.cn>
> >>>>
> >>>> ---
> >>> ltp-full-20081031/testcases/kernel/sched/clisrv/ 
> >>> run_sched_cliserv.sh.orig
> >>>  2009-01-16 11:12:49.821546689 +0800
> >>>> +++
> >>> ltp-full-20081031/testcases/kernel/sched/clisrv/run_sched_cliserv.sh
> >>>       2009-01-16 11:13:18.935562956 +0800
> >>>> @@ -1,6 +1,7 @@
> >>>> -#!/bin/sh -x
> >>>> +#!/bin/sh
> >>>>
> >>>> pthserv &
> >>>> +sleep 10
> >>>> pthcli 127.0.0.1 $LTPROOT/testcases/bin/data
> >>>> clientCode=$?
> >>>> killall pthserv
> >>>
> >>> Sorry for interjecting, but I don't like hacks like
> >>> this; there are
> >>> some bad decisions like this that occur in my everyday
> >>> work, and in
> >>> order to make everything magically work the timeout keeps
> >>> on growing,
> >>> instead of the components working together with some level
> >>> of
> >>> cohesion. A better idea: make pthserv and pthcli more
> >>> forgiving in
> >>> terms of timeouts in their respective codebases, so that
> >>> they're more
> >>> robust when it comes to latency issues when connecting.
> >>>
> >>> Should be simple to implement -- add a counter and a loop /
> >>> condition
> >>> at the top of a loop to wait for the connection to occur or
> >>> fail.
> >>>
> >>> If you want I'll write up the required changes in C.
> >>>
> >>
> >> Yes, it is a hack indeed. The patch was to quickly workaround the
> >> original false negative, and also make it reasonable robust. I am  
> >> happy
> >> to test and review your version though.
> >
> > Garret,
> >
> > Would you be working on this ??
> >
> > Regards--
> > Subrata
> >
> >>
> >> CAI Qian
> >>
> >>> Cheers,
> >>> -Garrett
> >>
> 
> I'd just go with the temporary workaround for now. I'll get to this in  
> due time.

Garrett,

About this as well ?

Regards--
Subrata

> Thanks,
> -Garrett


------------------------------------------------------------------------------
Are you an open source citizen? Join us for the Open Source Bridge conference!
Portland, OR, June 17-19. Two days of sessions, one day of unconference: $250.
Need another reason to go? 24-hour hacker lounge. Register today!
http://ad.doubleclick.net/clk;215844324;13503038;v?http://opensourcebridge.org
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
