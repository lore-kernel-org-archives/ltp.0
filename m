Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1P5vGA-0000z5-7S
	for ltp-list@lists.sourceforge.net; Wed, 13 Oct 2010 06:56:22 +0000
Received: from e32.co.us.ibm.com ([32.97.110.150])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1P5vG8-0005vX-Ni
	for ltp-list@lists.sourceforge.net; Wed, 13 Oct 2010 06:56:22 +0000
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by e32.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o9D6lMNi018948
	for <ltp-list@lists.sourceforge.net>; Wed, 13 Oct 2010 00:47:22 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o9D6uFPm174430
	for <ltp-list@lists.sourceforge.net>; Wed, 13 Oct 2010 00:56:15 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o9D6uEXB005209
	for <ltp-list@lists.sourceforge.net>; Wed, 13 Oct 2010 00:56:14 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <1286952767.4893.3.camel@subratamodak.linux.ibm.com>
References: <AANLkTimb=F0NaS+Sipp8EzrbRUqPqRf+9-nBZQMPpD=w@mail.gmail.com>
	<AANLkTimhAOpaWN7KDwg_PCQ=_j81A1fddRe5_KaB+RLY@mail.gmail.com>
	<AANLkTinOLVvd1B90s3Hn735YqH+Ku=BmUwyu-w1yZK_Y@mail.gmail.com>
	<AANLkTi=-CoyH2++-d45KaWq0ZzUsxaQUXN4g4q-vQYrb@mail.gmail.com>
	<AANLkTin4N8BpJ5xXs8TAV+1xQNjTEO+KzO6h=ZJVjv08@mail.gmail.com>
	<1286952767.4893.3.camel@subratamodak.linux.ibm.com>
Date: Wed, 13 Oct 2010 12:26:03 +0530
Message-Id: <1286952965.4893.6.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] Patch to record kernel dump message to each testcases log
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
To: hake huang <hakehuang@gmail.com>
Cc: ltp-list@lists.sourceforge.net

On Wed, 2010-10-13 at 12:22 +0530, Subrata Modak wrote:
> On Wed, 2010-10-13 at 13:30 +0800, hake huang wrote:
> > 2010/10/13 Garrett Cooper <yanegomi@gmail.com>
> > >
> > > On Tue, Oct 12, 2010 at 9:38 PM, hake huang <hakehuang@gmail.com> wrote:
> > > > Hi
> > > >
> > > > I see this simple solution is no quite fit. But the kernel dump message for
> > > > each test case is necessary for analysing. I can work on this further, with
> > > > below help:
> > > > 1. Where can I find the reason for the IIRC break?
> > >
> > > IIRC -> If I remember correctly.
> > so I need ask Subrata about this problem, right? what is the existing
> > functionality?
> 
> I believe the functionality your original patch was proposing is already
> in LTP . I guess they will solve your problem. See the following
> commits:
> 
> git show e3bc3758d3e4d17a0e04009ef873df53819b9ec6
> git show bd9d440be1da8020c93ac92e497e3a16e66e9fa3
> 
> Just use:
> 
> ./runltp -K <DMESG_DIRECTORY_NAME>

Basically, its a choice given to users who would like to record the
kernel messages, and not forcing recording all kernel messages which
your original patch is proposing :-)

Regards--
Subrata

> 
> option while running ltp.
> 
> Regards--
> Subrata
> 
> > >
> > > > 2. Can it  be an option to avoid the size limitation on some embedded
> > > > system?
> > >
> > > No. This is outside the realm of LTP, but we must remain conscious of
> > > the fact that there are folks running LTP on cellphones, etc, where
> > > space is very much a luxury.
> > I see. but why can't they run in quit_mode?
> > >
> > > > 3.  A kind of seperating tag is needed for kernel message, right? e.g
> > > > <kernel_dump_start>dump message<kernel_dump_end>
> > >
> > > I think that adding an optional capture feature might be worthwhile,
> > > but you'll no doubt quickly find with some processes that the dmesg
> > > buffer will fill up quickly.
> > I have seen such events, and such cases need to be checked manually.
> > >
> > > > 4.  I see in ltp-pan.c the file descriptors, terminals are changed in child
> > > > process. if the system(3) has problem, the worst cases is there are no
> > > > kernel messge output in parent process, but the pan can still function well.
> > >
> > > Can you say that with 100% certainty? One of the potential problems
> > > with system is the fact that it allocates a shell and depending on how
> > > processes are executed and how file descriptors are cleaned up,
> > >
> > > Actually, pan makes zero attempts at closing open file descriptors and
> > > the like, so the problem is still very much with pan.
> > >
> > So your concerns is about file descriptors which open in ltp process,
> > I think this is an existing problem. I mean maybe pan need to attempt
> > to close open file descriptors. system(3) only increases the change of
> > occurrence caused by this problem, right?
> > > > if not use system(3), can you give your suggestion on this, exec(3) seems to
> > > > have the same problem as system(3)?
> > >
> > > Yes and no. In this case the problems that exist with open file
> > > descriptor inheritance, etc are unfortunately no worse from that
> > > perspective than your proposed code would do, but there are still
> > > other problems that need to be resolved with your proposed change
> > > anyhow that are much more pressing.
> > >
> > > -Garrett
> 
> 
> ------------------------------------------------------------------------------
> Beautiful is writing same markup. Internet Explorer 9 supports
> standards for HTML5, CSS3, SVG 1.1,  ECMAScript5, and DOM L2 & L3.
> Spend less time writing and  rewriting code and more time creating great
> experiences on the web. Be a part of the beta today.
> http://p.sf.net/sfu/beautyoftheweb
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
Beautiful is writing same markup. Internet Explorer 9 supports
standards for HTML5, CSS3, SVG 1.1,  ECMAScript5, and DOM L2 & L3.
Spend less time writing and  rewriting code and more time creating great
experiences on the web. Be a part of the beta today.
http://p.sf.net/sfu/beautyoftheweb
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
