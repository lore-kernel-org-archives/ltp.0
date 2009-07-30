Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MWaPS-0006Xa-SU
	for ltp-list@lists.sourceforge.net; Thu, 30 Jul 2009 18:31:22 +0000
Received: from e39.co.us.ibm.com ([32.97.110.160])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MWaPN-0002Gj-Rd
	for ltp-list@lists.sourceforge.net; Thu, 30 Jul 2009 18:31:22 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e39.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n6UIQSJ9021346
	for <ltp-list@lists.sourceforge.net>; Thu, 30 Jul 2009 12:26:28 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n6UITth1150286
	for <ltp-list@lists.sourceforge.net>; Thu, 30 Jul 2009 12:29:55 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n6UITt3J008057
	for <ltp-list@lists.sourceforge.net>; Thu, 30 Jul 2009 12:29:55 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <4A6D7367.70306@petalogix.com>
References: <20090724110008.GA11878@linux.vnet.ibm.com>
	<4A6AA306.3060107@petalogix.com>
	<364299f40907250948sb1a8cc5o7afba11ac2d83ef9@mail.gmail.com>
	<4A6D7367.70306@petalogix.com>
Date: Thu, 30 Jul 2009 23:59:38 +0530
Message-Id: <1248978579.5788.66.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] Submitting patch
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
To: michal.simek@petalogix.com
Cc: ltp-list@lists.sourceforge.net, Jyoti <jyotiv@linux.vnet.ibm.com>

On Mon, 2009-07-27 at 11:29 +0200, Michal Simek wrote: 
> Hi Garrett,
> > On Fri, Jul 24, 2009 at 11:15 PM, Michal
> > Simek<michal.simek@petalogix.com> wrote:
> >   
> >> Please fix coding style. Use tab instead of space for indentation.
> >>     
> >
> >   
> You wrote nice email and I have to react on it.
> 
> > There is nothing that states that 8-space tabs aren't appropriate in
> > the kernel.org coding / style guide:
> > http://www.kernel.org/doc/Documentation/CodingStyle
> >
> > Please stop saying that tabs are required. 8-space / tabs _are_
> > required according to the guide.
> >   
> I invest a lot of time to fix testcases/kernel/syscalls. I used there
> tabs instead of spaces.
> You can use what you want but please keep in your mind.
> There should be one coding style for all source code. (for C, C++,
> Makefile, etc)
> 
> If you want to use spaces instead of tab and you hate tab you can of course.
> I expect that if you replaced all tabs in every C code ltp code will
> grow up.
> I am not sure if only this change help anybody.
> 
> IMHO use one tab instead of 8 spaces make more sense.
> 
> > Please also thoroughly read through the document as it says 80-char
> > lines are preferred, etc. It does not say they are required.
> >   
> There is not possible to have 80-char lines for every file but if you
> can use 80-chars line -
> you should do it. For large function is not possible to do it. If your
> function is large you should
> start to think how others will read it.
> > At the same time though, these guidelines do not necessarily apply to
> > userland apps, as far as the comment:
> >
> > "The answer to that is that if you need more than 3 levels of
> > indentation, you're screwed anyway, and should fix your program."
> >
> > is concerned. Yes, that's true for kernel code. No it's not
> > necessarily true for userland apps as more than 3 levels of branches
> > may be required.
> >
> > So, in conclusion, yes -- we should try to stick to the kernel.org
> > coding guidelines, but 1) we are not kernel.org and 2) we're not
> > producing kernel code, so the coding guidelines may be more of a
> > shoehorn fit than an appropriate one. It also doesn't apply to
> > anything beyond C/C++ code.
> >   
> Really? But you should look at patches how they looks like. Code don't have
> any style. If is preferable style for Cisco - it is your problem not
> mine. Your code
> present you and your coding style too. LTP contains a lot of code and I
> thought
> that will be good to clear.
> 
> Anyway this bring me up only troubles nothing else.
> It is up to Subrata what coding style/patches wants.

We indeed need coding styles for LTP. Let take this up once and all
after the release.

Regards--
Subrata

> I won't spend my time on cleaning LTP or disturb people.
> 
> > Mike/Subrata,
> >     Can we actually write up a style guide for folks to follow that
> > applies for code, as the kernel.org guidelines don't apply that well
> > to our circumstances?
> >   
> > Thanks,
> > -Garrett
> >   
> Thanks for your email -> it save me a lot of time for future.
> 
> Enjoy your day,
> Michal
> 
> 
> >   
> >>> PATCH IS CREATED FOR ltp-full-20090630.
> >>>
> >>> I am submitting a patch to kernel/fs/fs_di
> >>>
> >>> In this file data integity is performed by creating the file at
> >>> different directory depth and then by comparing with original file.
> >>>
> >>> To this I have added one more approach to perform integrity test.
> >>> 1. Creating two fragmented files each of size DiskSize/2.
> >>> 2. Then comapring against the original file.
> >>> 3. If not equal test case fails.
> >>>
> >>> My ultimate goal in creating fragmented files is that,
> >>> 1. It creates many extents (fragments for each file)
> >>> 2. FS code may behave wrong at corner cases which may come into picture
> >>>    after many extents gets added to the file.
> >>> 3. Data corruption chances are there
> >>>      i. when file metadata updation is not proper (corner cases when fragments are more)
> >>>      ii.If write and read is not matching (write operation might have updated the block
> >>>         number some where and read may skip that block in some corner cases)
> >>> 4. In reality fragments can occur only after much usage of the disk(create/delete file)
> >>> 5. This is good test case for bigger size disk.(it can create more extents)
> >>>       
> 
> 
> -- 
> Michal Simek, Ing. (M.Eng)
> PetaLogix - Linux Solutions for a Reconfigurable World
> w: www.petalogix.com p: +61-7-30090663,+42-0-721842854 f: +61-7-30090663
> 
> 
> ------------------------------------------------------------------------------
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
