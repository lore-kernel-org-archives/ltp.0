Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1N9wix-0006lZ-B2
	for ltp-list@lists.sourceforge.net; Mon, 16 Nov 2009 08:14:11 +0000
Received: from e38.co.us.ibm.com ([32.97.110.159])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1N9win-0005sh-FG
	for ltp-list@lists.sourceforge.net; Mon, 16 Nov 2009 08:14:09 +0000
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <4AFA45B0.7070608@cn.fujitsu.com>
References: <4AF93496.3030408@cn.fujitsu.com>
	<200911102333.55526.vapier@gentoo.org>
	<4AFA45B0.7070608@cn.fujitsu.com>
Date: Mon, 16 Nov 2009 13:43:44 +0530
Message-Id: <1258359225.5677.35.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] syscalls: fix some failure on arch X86_64
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
To: liubo <liubo2009@cn.fujitsu.com>
Cc: ltp-list <ltp-list@lists.sf.net>, Mike Frysinger <vapier@gentoo.org>

Liubo,

Are you sending an updated patch post this discussion ?

Regards--
Subrata

On Wed, 2009-11-11 at 13:03 +0800, Wei Yongjun wrote: 
> 
> Mike Frysinger wrote:
> > On Tuesday 10 November 2009 04:38:30 liubo wrote:
> >   
> >> 1) rt_sigaction
> >>     "sigaction" has the structure:
> >>
> >>  struct sigaction {
> >>          __sighandler_t sa_handler;
> >>          unsigned long sa_flags;
> >>   #ifdef SA_RESTORER
> >>           __sigrestore_t sa_restorer;
> >>   #endif
> >>           sigset_t sa_mask;               /* mask last for extensibility */
> >>  };
> >>
> >>     However, on arch x86_64, if we directly get to call rt_sigaction,
> >> the argument "sa_restorer" will not be fulfilled, and this will lead
> >>  to segment fault.
> >>     on arch x86_64, if sa_restorer is not set, kernel will lead to segment
> >>  fault. In other arch, if sa_restorer is not set, kernel can do the correct
> >>  work. To avoid this segment fault, we use glibc function
> >> "int sigaction(...);" instead, which can fulfill the argument
> >>  "sa_restorer".
> >>     
> >
> > which defeats the purpose of the test.  there is no guarantee that the C 
> > library sigaction function is implemented via the __NR_rt_sigaction syscall.
> >   
> 
> In x86_64, it do this. And If we want to use __NR_rt_sigaction syscall
> directly, we must fill the sa_restorer and set the RESTORER flag to
> sa_mask. If we do not set the sa_restorer, kill will always cause
> segment fault.
> 
> >   
> >> 2) rt_sigprocmask
> >>     This failure contains two aspects,
> >> the first is the segment fault as described in 1),
> >> the second is that testcase uses a unknown signal 33 for test,
> >> and this will lead sigaction cannot bind signal 33 to the action.
> >>
> >>     So, we attempt to use a known signal instead, such as 34.
> >>     
> >
> > which is just as bogus and unportable.  if the test needs a real time signal, 
> > it should leverage the sigrtmin...sigrtmax defines.
> > -mike
> >   
> > ------------------------------------------------------------------------
> >
> > ------------------------------------------------------------------------------
> > Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
> > trial. Simplify your report design, integration and deployment - and focus on 
> > what you do best, core application coding. Discover what's new with
> > Crystal Reports now.  http://p.sf.net/sfu/bobj-july
> > ------------------------------------------------------------------------
> >
> > _______________________________________________
> > Ltp-list mailing list
> > Ltp-list@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/ltp-list
> >   
> 
> ------------------------------------------------------------------------------
> Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
> trial. Simplify your report design, integration and deployment - and focus on 
> what you do best, core application coding. Discover what's new with
> Crystal Reports now.  http://p.sf.net/sfu/bobj-july
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
