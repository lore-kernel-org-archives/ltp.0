Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1MjGgN-0001vS-9U
	for ltp-list@lists.sourceforge.net; Thu, 03 Sep 2009 18:05:15 +0000
Date: Thu, 3 Sep 2009 20:05:02 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20090903180502.GA30854@schrodinger.suse.cz>
References: <alpine.LRH.2.00.0908271703550.1134@vixen.sonytel.be>
	<200908281517.46228.vapier@gentoo.org>
	<20090831100651.GA4020@schrodinger.suse.cz>
	<200908311633.32124.vapier@gentoo.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200908311633.32124.vapier@gentoo.org>
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
Cc: ltp-list@lists.sourceforge.net

Ahoj!
> > That's still gives warning for me:
> >
> > warning: format '%lld' expects type 'long long int', but argument 6 has
> > type 'off_t'
> >
> > > i converted some tests to do this already (fallocate maybe?)
> >
> > Hmm, looks like there is loff_t used instead of off_t.
> 
> loff_t is probably PRId64 while off_t is probably PRIu64

Hmm, seems like off_t is defined as long int on my machine. So following code
is came to my mind:

off_t t;
...
printf("off_t value %"PRId64"\n", (uint64_t) t);


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
