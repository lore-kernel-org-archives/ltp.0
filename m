Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VEeLt-0003LS-5K
	for ltp-list@lists.sourceforge.net; Wed, 28 Aug 2013 11:55:57 +0000
Date: Wed, 28 Aug 2013 13:56:01 +0200
From: chrubis@suse.cz
Message-ID: <20130828115601.GA4804@rei>
References: <20130711110014.GB6142@rei.suse.cz>
	<201308242143.45598.vapier@gentoo.org>
	<20130827110434.GA10995@rei.Home>
	<201308271218.22009.vapier@gentoo.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <201308271218.22009.vapier@gentoo.org>
Subject: Re: [LTP] RFC add _FORTIFY_SOURCE to default LTP CFLAGS
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
> unfortunately that does not work.  this snippet from coreutils is probably 
> better:
>   AH_VERBATIM([FORTIFY_SOURCE],
>   [/* Enable compile-time and run-time bounds-checking, and some warnings,
>       without upsetting glibc 2.15+. */
>    #if !defined _FORTIFY_SOURCE && defined __OPTIMIZE__ && __OPTIMIZE__
>    # define _FORTIFY_SOURCE 2   
>    #endif
>   ])

That wouldn't work here, as config.h is included only in a few testcases
(in these that actually use some of the defines there).

But given that this just copies some ifdefs into config.h what about
adding the snippet directly into compiler.h that is included from
test.h thus ends up in all testcases?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Learn the latest--Visual Studio 2012, SharePoint 2013, SQL 2012, more!
Discover the easy way to master current and previous Microsoft technologies
and advance your career. Get an incredible 1,500+ hours of step-by-step
tutorial videos with LearnDevNow. Subscribe today and save!
http://pubads.g.doubleclick.net/gampad/clk?id=58040911&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
