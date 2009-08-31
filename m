Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1Mi3my-00017C-IR
	for ltp-list@lists.sourceforge.net; Mon, 31 Aug 2009 10:07:04 +0000
Date: Mon, 31 Aug 2009 12:06:51 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20090831100651.GA4020@schrodinger.suse.cz>
References: <alpine.LRH.2.00.0908271703550.1134@vixen.sonytel.be>
	<200908281106.13828.vapier@gentoo.org>
	<20090828162925.GB7218@schrodinger.suse.cz>
	<200908281517.46228.vapier@gentoo.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200908281517.46228.vapier@gentoo.org>
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

Hi!
>
> include inttypes.h and use PRId64
>

That's still gives warning for me:

warning: format '%lld' expects type 'long long int', but argument 6 has type 'off_t'

>
> i converted some tests to do this already (fallocate maybe?)

Hmm, looks like there is loff_t used instead of off_t.

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
