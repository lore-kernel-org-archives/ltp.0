Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MJ7Nl-0002bQ-1F
	for ltp-list@lists.sourceforge.net; Tue, 23 Jun 2009 14:53:57 +0000
Received: from e2.ny.us.ibm.com ([32.97.182.142])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MJ7Nk-0002By-0L
	for ltp-list@lists.sourceforge.net; Tue, 23 Jun 2009 14:53:57 +0000
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
	by e2.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n5NEn8bE001106
	for <ltp-list@lists.sourceforge.net>; Tue, 23 Jun 2009 10:49:08 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5NErp9w884964
	for <ltp-list@lists.sourceforge.net>; Tue, 23 Jun 2009 10:53:52 -0400
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5NErjQv021080
	for <ltp-list@lists.sourceforge.net>; Tue, 23 Jun 2009 08:53:45 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <1234847707.5375.29.camel@subratamodak.linux.ibm.com>
References: <364299f40808210412n255a45edw50bdbdb69ae23960@mail.gmail.com>
	<1219335135.4941.72.camel@subratamodak.linux.ibm.com>
	<1219442652.5129.27.camel@subratamodak.linux.ibm.com>
	<364299f40808221619i2a097b31jd1bcb4d47eec18da@mail.gmail.com>
	<1224680271.9160.67.camel@subratamodak.linux.ibm.com>
	<364299f40810231422i7f41858dn2d83a6178c25327f@mail.gmail.com>
	<1234847707.5375.29.camel@subratamodak.linux.ibm.com>
Date: Tue, 23 Jun 2009 20:18:25 +0530
Message-Id: <1245768505.4860.57.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [Catepault->LTP] Coming soon
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
Cc: ltp-list <ltp-list@lists.sourceforge.net>

Garrett ?

Regards--
Subrata

On Tue, 2009-02-17 at 10:45 +0530, Subrata Modak wrote: 
> Garrett,
> 
> Would you be pushing some changes to LTP Ballista ?
> 
> On Thu, 2008-10-23 at 14:22 -0700, Garrett Cooper wrote:
> > On Wed, Oct 22, 2008 at 5:57 AM, Subrata Modak
> > <subrata@linux.vnet.ibm.com> wrote:
> > > Garrett,
> > >
> > > Any changes for LTP Ballista ?
> > >
> > > Regards--
> > > Subrata
> > >
> > > On Fri, 2008-08-22 at 16:19 -0700, Garrett Cooper wrote:
> > >> On Fri, Aug 22, 2008 at 3:04 PM, Subrata Modak
> > >> <subrata@linux.vnet.ibm.com> wrote:
> > >> >
> > >> > On Thu, 2008-08-21 at 21:42 +0530, Subrata Modak wrote:
> > >> >> Hi Garrett,
> > >> >>
> > >> >> On Thu, 2008-08-21 at 04:12 -0700, Garrett Cooper wrote:
> > >> >> > So, as I said earlier I was going to repost Ballista under another
> > >> >> > project name up on SF thanks to the PI's blessings, so here's the
> > >> >> > placeholder:
> > >> >> >
> > >> >> > http://sf.net/projects/catepault/ (haven't posted the source files yet)
> > >> >>
> > >> >> Good to see that you have come up with the rewrite so fast.
> > >> >>
> > >> >> >
> > >> >> > Catepault so far does not differ from Ballista, apart from the fact
> > >> >> > that I rewrote the Makefiles to support cross-compilation, simplify
> > >> >> > logic, and to properly clean all binary targets (YAY!).
> > >> >> >
> > >> >> > I'm going to try pushing some of the platform dependent items from
> > >> >> > "configure" (a glorified Perl script) to the actual C++ files, or
> > >> >> > their respective headers, to get rid of the Perl dependency in the
> > >> >> > system for compilation. This will be a win-win (IMO) as it will allow
> > >> >> > more restricted embedded environments to compile the sources for
> > >> >> > Catepault without having an unnecessary Perl interpreter to just fill
> > >> >> > in the platform dependent API gaps.
> > >> >> >
> > >> >>
> > >> >> How do you plan this to handle in LTP ? Do you want to remove the folder
> > >> >> ballista completely and replace with new catepault ?
> > >> >
> > >> > Garrett,
> > >> >
> > >> > Would you like to convey your Idea here ?
> > >> >
> > >> > Regards--
> > >> > Subrata
> > >> >
> > >> >>
> > >> >> Regards--
> > >> >> Subrata
> > >> >>
> > >> >> > Will keep you guys posted as things transpire.
> > >> >> >
> > >> >> > Cheers,
> > >> >> > -Garrett
> > >> >> >
> > >>
> > >> Well, quite frankly it would be silly to have Ballista and Catepault
> > >> both in the LTP repository, as they provide basically the same
> > >> purpose, minus Ballista being executable on the target machine whereas
> > >> Catepault can only be executed on the build host.
> > >>
> > >> Plus Catepault will do the right thing by cleaning itself properly :D.
> > >> -Garrett
> > 
> > It's in my backlog, which is pretty long right now. Our group at Cisco
> > has been really bad in terms getting automated testing infrastructure
> > out the door, due to lack of resources, so until these issues get
> > worked out I'm stuck with manually testing things, which is both time
> > consuming and error prone (test engineers are required for commit --
> > for anything, as well as release/integration validation :(..).
> > Thankfully help is on the horizon, but it's still ~1 month away.
> > 
> > FWIW, LTP on the mips architecture introduces some interesting issues
> > that I'll need to discuss with you guys later, and adds to support
> 
> Some thing here to discuss as well ?
> 
> Regards--
> Subrata
> 
> > overhead -- then again the image we're working with is from April, so
> > I'm almost positive some bugfixes have been made that address issues
> > that I see on a regular release basis.
> > 
> > -Garrett
> 
> 
> ------------------------------------------------------------------------------
> Open Source Business Conference (OSBC), March 24-25, 2009, San Francisco, CA
> -OSBC tackles the biggest issue in open source: Open Sourcing the Enterprise
> -Strategies to boost innovation and cut costs with open source participation
> -Receive a $600 discount off the registration fee with the source code: SFAD
> http://p.sf.net/sfu/XcvMzF8H
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
Are you an open source citizen? Join us for the Open Source Bridge conference!
Portland, OR, June 17-19. Two days of sessions, one day of unconference: $250.
Need another reason to go? 24-hour hacker lounge. Register today!
http://ad.doubleclick.net/clk;215844324;13503038;v?http://opensourcebridge.org
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
