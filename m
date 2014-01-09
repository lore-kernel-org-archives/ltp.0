Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1W1FMi-00071U-Dg
	for ltp-list@lists.sourceforge.net; Thu, 09 Jan 2014 13:09:40 +0000
Date: Thu, 9 Jan 2014 14:09:19 +0100
From: chrubis@suse.cz
Message-ID: <20140109130919.GF5125@rei.Home>
References: <1387358991.1664.37.camel@G08JYZSD130126>
	<20140107140910.GD27135@rei.Home>
	<1389191490.2879.27.camel@G08JYZSD130126>
	<201401090803.39606.vapier@gentoo.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <201401090803.39606.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH] clone/clone08.c: check whether clone supports 7
 arguments
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
> > +AC_DEFUN([LTP_CHECK_CLONE7ARGS],[
> > +AH_TEMPLATE(HAVE_CLONE7ARGS,
> > +[Define to 1 if clone() supports 7 arguments.])
> > +AC_MSG_CHECKING([for CLONE7ARGS])
> > +AC_TRY_LINK([#define _GNU_SOURCE
> > +		#include <sched.h>
> > +		#include <stdlib.h>],
> > +		[
> > +		#if !defined(__ia64__)
> > +		clone(NULL, NULL, 0, NULL, NULL, NULL, NULL);
> > +		#endif
> > +		],
> > +		AC_DEFINE(HAVE_CLONE7ARGS) AC_MSG_RESULT(yes), AC_MSG_RESULT(no))
> > +])
> 
> you aren't really testing for "clone takes 7 args", you're testing for "clone 
> has varargs support".  rename the define (and use _ in its name), and drop the 
> ia64 check as it isn't needed.

I wouldn't call it varargs because there are only three more pointers to
pass to clone() and the only reason it's defined as varargs is to be
compatible with the previous clone definition...

Frankly if they did clone7() in glibc instead it would be much more
clear and easier to figure out.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
CenturyLink Cloud: The Leader in Enterprise Cloud Services.
Learn Why More Businesses Are Choosing CenturyLink Cloud For
Critical Workloads, Development Environments & Everything In Between.
Get a Quote or Start a Free Trial Today. 
http://pubads.g.doubleclick.net/gampad/clk?id=119420431&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
