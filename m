Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1MlMtL-0007DC-Qu
	for ltp-list@lists.sourceforge.net; Wed, 09 Sep 2009 13:07:19 +0000
Date: Wed, 9 Sep 2009 15:07:00 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20090909130700.GB5751@schrodinger.suse.cz>
References: <20090831174107.GB30788@schrodinger.suse.cz>
	<200909072235.00963.vapier@gentoo.org>
	<20090909123110.GA5751@schrodinger.suse.cz>
	<200909090844.25484.vapier@gentoo.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200909090844.25484.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH] broken epoll Makefile
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
> > > the _GNU_SOURCE change shouldnt be in there (existing style is correct)
> > 
> > I don't like adding spaces between # and keyword but changed back as you
> >  wish.
> 
> lack of indentation in nested #if quickly makes for unreadable and 
> unmaintainable code.
> #ifdef FOO
> #some more ifdefs
> #ifdef MOO
> #some more ifdesf
> #else
> #some more
> #endif
> #endif
> 
> whereas the whitespace makes the nested logic trivial to track

Agree with that (and I would be nice to fix all unreadable code in ltp). But as
I rarely use anything else that gcc, puting whitespaces before # is not
problem for me and this style IMHO looks better. I know that works only for my
personal projects, but have you seen compiler that is used these days and has
problems with that? 

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
