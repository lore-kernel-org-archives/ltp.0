Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MYH04-0003fM-TT
	for ltp-list@lists.sourceforge.net; Tue, 04 Aug 2009 10:12:08 +0000
Received: from e31.co.us.ibm.com ([32.97.110.149])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MYH00-0005g7-JD
	for ltp-list@lists.sourceforge.net; Tue, 04 Aug 2009 10:12:08 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n74A6hSf003333
	for <ltp-list@lists.sourceforge.net>; Tue, 4 Aug 2009 04:06:43 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n74ABwEd218878
	for <ltp-list@lists.sourceforge.net>; Tue, 4 Aug 2009 04:11:58 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n74ABw4F007081
	for <ltp-list@lists.sourceforge.net>; Tue, 4 Aug 2009 04:11:58 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <4A77F359.40901@petalogix.com>
References: <20090724110008.GA11878@linux.vnet.ibm.com>
	<4A6AA306.3060107@petalogix.com>
	<364299f40907250948sb1a8cc5o7afba11ac2d83ef9@mail.gmail.com>
	<4A6D7367.70306@petalogix.com>
	<1248978579.5788.66.camel@subratamodak.linux.ibm.com>
	<20090803104746.GA31767@schrodinger.suse.cz>
	<4A76EA47.7070209@petalogix.com>
	<20090803135451.GA11225@schrodinger.suse.cz>
	<4A76F856.6030307@petalogix.com>
	<364299f40908030944n74d79509r716dcbcc8875677b@mail.gmail.com>
	<4A77F359.40901@petalogix.com>
Date: Tue, 04 Aug 2009 15:41:47 +0530
Message-Id: <1249380712.15587.3.camel@subratamodak.linux.ibm.com>
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
Cc: ltp-list@lists.sourceforge.net, naresh.kernel@gmail.com, Jyoti <jyotiv@linux.vnet.ibm.com>, Mike Frysinger <vapier.adi@gmail.com>

Hi Michal/Garret/all,

On Tue, 2009-08-04 at 10:37 +0200, Michal Simek wrote:
> Garrett Cooper wrote:
> > On Mon, Aug 3, 2009 at 7:46 AM, Michal Simek<michal.simek@petalogix.com> wrote:
> >   
> >> Cyril Hrubis wrote:
> >>     
> >>> Hi!
> >>>
> >>>       
> >>>>> What's wrong with linux kernel coding style? Most of the decent text editors
> >>>>> that are used these days (vim, emacs...) just helps format code like this. (Eg.
> >>>>> default intendation is done by tabs and so on...) I don't like the idea
> >>>>> changing tabs to spaces before sending a patch.
> >>>>>
> >>>>>           
> >>>> There is only one thing which is IMHO not good - it is 80 char line size.
> >>>> I would prefer longer lines (maybe 120 chars).
> >>>> This is for C code not for any other.
> >>>> Are you ok with it?
> >>>>
> >>>>         
> >>> Well, I'm not happy with very long lines, but there are indeed circumstances
> >>> where long lines are best solution.
> >>>
> >>>       
> >> I am not happy with it too but there are some cases where is really ugly
> >> to have 80chars lines.
> >>     
> >
> > IMHO 95% of the time you can get away with shorter lines with
> > different constructs or more clever indentation. 
> I don't want to do any clever indentation. This discuss is again and
> again the same!!!
> 
> I vote for standard linux indentation - tab (size 8 chars) for whole C code.
> Follow linux kernel coding style for whole C code. As we discussed in
> this thread 80 chars line are strongly recommended.
> For checking C source code use checkpatch.pl script which is in linux
> kernel before sending patches to mailing list
> and of course checking patches before applying.
> 

Yes, checkpatch.pl for C code patches.

> Cyril, Mike, Subrata and others: Can you send us your opinion? I don't
> want to spend my time with discuss about it.
> 
> I am not interested in any other code that's why I don't write any
> comment to it.
> You can choose what you want. Of course if is similar utility like
> checkpatch.pl it will be good to use it and not to check
> it by hand.
> 
> Subrata can we please write output from this discussion to web / doc
> somewhere?
> 

I will do that soon.

> Thanks,
> Michal
> 
> 
> > Take for example what
> > I just did with delete_module* -- now that was a mess to cleanup, but
> > quick nonetheless and necessary:
> > http://ltp.cvs.sourceforge.net/viewvc/ltp/ltp/testcases/kernel/module/delete_module/delete_module01.c?view=log&pathrev=makefile_infra_rework
> > , http://ltp.cvs.sourceforge.net/viewvc/ltp/ltp/testcases/kernel/module/delete_module/delete_module02.c?view=log&pathrev=makefile_infra_rework
> > , http://ltp.cvs.sourceforge.net/viewvc/ltp/ltp/testcases/kernel/module/delete_module/delete_module03.c?view=log&pathrev=makefile_infra_rework
> >
> > We should aim for 80 column lines wherever possible because it's the
> > defacto standard, and where we can't do that (and there are a handful
> > of areas with shell code and Makefile code where I couldn't without
> > changing the meaning of the message I was trying to convey), we should
> > go over 80 cols.
> >
> > At least that's how every project I know has done it.
> >
> > General rules of thumb for shell / python / perl code (from dealing
> > with other projects) was 4 space indents. Perl tends to go whacky
> > though because of all of the different ways to express constructs
> > though xD.

Again, checkpatch.pl for non-C code as well. But, need to carefully
review the errors it will generate for non-C code like the Makefiles,
perl, shell, python, etc.

Garret,

Can you please come up with a list of exceptions for
     1. line length,
     2. tab length,
     3. etc

for non-C code like the perl, Makefiles, etc. I would then document them
all.

Regards--
Subrata

> >
> > Thanks!
> > -Garrett
> >   
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
