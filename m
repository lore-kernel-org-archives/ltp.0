Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VGT9u-0000mb-Ii
	for ltp-list@lists.sourceforge.net; Mon, 02 Sep 2013 12:23:06 +0000
Date: Mon, 2 Sep 2013 14:23:16 +0200
From: chrubis@suse.cz
Message-ID: <20130902122315.GC3269@rei>
References: <20130711110014.GB6142@rei.suse.cz> <20130828115601.GA4804@rei>
	<201308281234.41447.vapier@gentoo.org>
	<201308281237.03104.vapier@gentoo.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <201308281237.03104.vapier@gentoo.org>
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
> > > That wouldn't work here, as config.h is included only in a few testcases
> > > (in these that actually use some of the defines there).
> > > 
> > > But given that this just copies some ifdefs into config.h what about
> > > adding the snippet directly into compiler.h that is included from
> > > test.h thus ends up in all testcases?
> > 
> > SGTM
> 
> err, no, that won't work either.  _FORTIFY_SOURCE must be defined before any 
> header file is included.  otherwise, including all the C lib headers and then 
> test.h and then defining this won't accomplish anything.

Ah, you are right.

> you could probably turn that AH_VERBATIM into a compile test and then add it 
> to CPPFLAGS based on the result.  that would probably work in most cases.

So back to the beginning...

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
