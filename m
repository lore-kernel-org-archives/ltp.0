Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <matthltc@us.ibm.com>) id 1MMTGH-0001kl-FS
	for ltp-list@lists.sourceforge.net; Thu, 02 Jul 2009 20:52:05 +0000
Received: from e1.ny.us.ibm.com ([32.97.182.141])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MMTFx-0007fw-3x
	for ltp-list@lists.sourceforge.net; Thu, 02 Jul 2009 20:52:05 +0000
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n62KSAKf015693
	for <ltp-list@lists.sourceforge.net>; Thu, 2 Jul 2009 16:28:10 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n62KWw78256574
	for <ltp-list@lists.sourceforge.net>; Thu, 2 Jul 2009 16:32:58 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n62KWt1m005800
	for <ltp-list@lists.sourceforge.net>; Thu, 2 Jul 2009 16:32:57 -0400
Date: Thu, 2 Jul 2009 13:32:53 -0700
From: Matt Helsley <matthltc@us.ibm.com>
Message-ID: <20090702203253.GI19135@count0.beaverton.ibm.com>
References: <20090702084828.GC19135@count0.beaverton.ibm.com>
	<20090702090532.GF19135@count0.beaverton.ibm.com>
	<200907021435.48510.vapier@gentoo.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200907021435.48510.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH 4/4] netns: Change interpretters from sh to bash
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
To: Mike Frysinger <vapier@gentoo.org>
Cc: Poornima Nayak <poornima.nayak@in.ibm.com>, ltp-list@lists.sourceforge.net, Daniel Lezcano <daniel.lezcano@free.fr>, Veerendra C <vechandr@in.ibm.com>, Munipradeep <mbeeraka@in.ibm.com>

On Thu, Jul 02, 2009 at 02:35:46PM -0400, Mike Frysinger wrote:
> On Thursday 02 July 2009 05:05:32 Matt Helsley wrote:
> > As best I can tell these tests do not use true sh syntax -- they use bash
> > syntax. Rather than bother hunting down all the bash-isms just convert
> > them to use bash as their interpretter.
> 
> the changelog doesnt seem to jive with the commit.  if you were merely 
> changing the shebang, why did you also fix the bashisms like s/==/-eq/ ?

Good point -- it does make the == -> -eq and the || -> -o conversions
pointless.

> 
> at any rate, someone (i dont recall who) posted fixes to these files recently 
> to de-bashify them.  there was some feedback though, so perhaps you should 
> address those minor issues and submit an updated patch.

OK, I'll look for that patch and consider it as a replacement for 3 and 4 of
this series.

> 
> in general, converting sh to bash is a bad idea as it can cause issues for us 
> embedded peeps.
> -mike

I suppose that's because of the memory bash consumes. Is there anything else
it does which is bad for embedded?

Cheers,
	-Matt Helsley

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
