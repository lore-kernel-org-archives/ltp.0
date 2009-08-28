Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1Mh2r8-0000ZW-S6
	for ltp-list@lists.sourceforge.net; Fri, 28 Aug 2009 14:55:10 +0000
Date: Fri, 28 Aug 2009 16:54:54 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20090828145454.GA4567@schrodinger.suse.cz>
References: <alpine.LRH.2.00.0908271703550.1134@vixen.sonytel.be>
	<200908280514.03971.vapier@gentoo.org>
	<1251454262.9081.16.camel@subratamodak.linux.ibm.com>
	<200908281044.04663.vapier@gentoo.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200908281044.04663.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH] Annotate tst_*() helpers
	with?__attribute__	((format (printf, M, N)))
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
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, ltp-list@lists.sourceforge.net

Hi!
> > Great Mike. I am already seeing you doing some changes to the headers in
> > CVS. Can you also push this patch once you are done with all the
> > changes. Please notify me once all are done. I plan to checkout a fresh
> > one for the upcoming release ;-)
> 
> ive fixed a good chunk of the warnings now, but there's still a good number 
> left.  maybe someone else feels like taking a crack at them, but i'm bored 
> now.  i'll leave it up to you to apply said patch now or wait a few days so it 
> goes in after the next release.

Could you point me to the sources you have been working with. I'll try to have
look.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
