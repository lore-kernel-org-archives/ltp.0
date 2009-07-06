Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MNqTG-0001r6-PR
	for ltp-list@lists.sourceforge.net; Mon, 06 Jul 2009 15:51:10 +0000
Received: from e36.co.us.ibm.com ([32.97.110.154])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MNqTG-0002Ul-9q
	for ltp-list@lists.sourceforge.net; Mon, 06 Jul 2009 15:51:10 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n66FnT8M017860
	for <ltp-list@lists.sourceforge.net>; Mon, 6 Jul 2009 09:49:29 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n66Foxrt213258
	for <ltp-list@lists.sourceforge.net>; Mon, 6 Jul 2009 09:50:59 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n66FowOu022957
	for <ltp-list@lists.sourceforge.net>; Mon, 6 Jul 2009 09:50:58 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <20090702203253.GI19135@count0.beaverton.ibm.com>
References: <20090702084828.GC19135@count0.beaverton.ibm.com>
	<20090702090532.GF19135@count0.beaverton.ibm.com>
	<200907021435.48510.vapier@gentoo.org>
	<20090702203253.GI19135@count0.beaverton.ibm.com>
Date: Mon, 06 Jul 2009 21:20:45 +0530
Message-Id: <1246895446.4887.50.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH 4/4] netns: Change interpretters from sh to bash
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
To: Matt Helsley <matthltc@us.ibm.com>
Cc: Poornima Nayak <poornima.nayak@in.ibm.com>, ltp-list@lists.sourceforge.net, Mike Frysinger <vapier@gentoo.org>, Daniel Lezcano <daniel.lezcano@free.fr>, Veerendra C <vechandr@in.ibm.com>, Munipradeep <mbeeraka@in.ibm.com>

On Thu, 2009-07-02 at 13:32 -0700, Matt Helsley wrote: 
> On Thu, Jul 02, 2009 at 02:35:46PM -0400, Mike Frysinger wrote:
> > On Thursday 02 July 2009 05:05:32 Matt Helsley wrote:
> > > As best I can tell these tests do not use true sh syntax -- they use bash
> > > syntax. Rather than bother hunting down all the bash-isms just convert
> > > them to use bash as their interpretter.
> > 
> > the changelog doesnt seem to jive with the commit.  if you were merely 
> > changing the shebang, why did you also fix the bashisms like s/==/-eq/ ?
> 
> Good point -- it does make the == -> -eq and the || -> -o conversions
> pointless.
> 
> > 
> > at any rate, someone (i dont recall who) posted fixes to these files recently 
> > to de-bashify them.  there was some feedback though, so perhaps you should 
> > address those minor issues and submit an updated patch.
> 
> OK, I'll look for that patch and consider it as a replacement for 3 and 4 of
> this series.

Will wait for this from you.

Regards--
Subrata

> 
> > 
> > in general, converting sh to bash is a bad idea as it can cause issues for us 
> > embedded peeps.
> > -mike
> 
> I suppose that's because of the memory bash consumes. Is there anything else
> it does which is bad for embedded?
> 
> Cheers,
> 	-Matt Helsley


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
