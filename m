Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MfsoF-0003AY-68
	for ltp-list@lists.sourceforge.net; Tue, 25 Aug 2009 09:59:23 +0000
Received: from e38.co.us.ibm.com ([32.97.110.159])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Mfso9-0003H2-0y
	for ltp-list@lists.sourceforge.net; Tue, 25 Aug 2009 09:59:23 +0000
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <d51f89b0908242305x19faae50h741f0d3bd9de5df1@mail.gmail.com>
References: <d51f89b0908240516n1b4ca28m988feb00f077fbd7@mail.gmail.com>
	<364299f40908241629x7dcfcbc2sdb2322198b7b729c@mail.gmail.com>
	<d51f89b0908242305x19faae50h741f0d3bd9de5df1@mail.gmail.com>
Date: Tue, 25 Aug 2009 15:28:35 +0530
Message-Id: <1251194315.5534.30.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] Patch for smt_smp_affinity
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
To: rohit verma <rohit.170309@gmail.com>
Cc: ltp-list <ltp-list@lists.sf.net>

On Tue, 2009-08-25 at 11:35 +0530, rohit verma wrote: 
> Thanks Garrett...
> 
> On Tue, Aug 25, 2009 at 4:59 AM, Garrett Cooper<yanegomi@gmail.com> wrote:
> > On Mon, Aug 24, 2009 at 5:16 AM, rohit verma<rohit.170309@gmail.com> wrote:
> >> Dear Subrata,
> >>
> >> smt_smp_ affinity test case is passing on Fedora but fails on Ubuntu
> >> for the same H/W.On Ubuntu system, after doing strace i observed that
> >> system call sched_getaffinity was returning -1 [ERROR:EINVAL] due to
> >> second argument.
> >>
> >> sched_getaffinity(pid, sizeof(unsigned int), &mask1)

Thanks. Also removed the "\n"s.

Regards--
Subrata

> >>
> >> Please find attached herewith the patch which fixes the issue.
> >
> > Rohit,
> >    Good catch -- one style note though: tst_resm doesn't require a
> > "\n" because that's automatically appended to each message.
> > Thanks,
> > -Garrett
> >
> 
> 
> 


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
