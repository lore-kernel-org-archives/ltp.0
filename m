Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1RiU6p-00014z-Sy
	for ltp-list@lists.sourceforge.net; Wed, 04 Jan 2012 16:54:39 +0000
Date: Wed, 4 Jan 2012 18:05:27 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20120104170526.GA19397@saboteur.suse.cz>
References: <4F02CC46.9000106@imgtec.com>
	<201201031356.11319.vapier@gentoo.org>
	<20120104134651.GA14739@saboteur.suse.cz>
	<CAGH67wRsHvHkdvPrC5y4Fm7TuYxs1dHytJnnK3d54PxG-vukYA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAGH67wRsHvHkdvPrC5y4Fm7TuYxs1dHytJnnK3d54PxG-vukYA@mail.gmail.com>
Subject: Re: [LTP] [PATCH 03/21] test.h/tst_brkm: Drop
 __attribute__((noreturn)) since tst_brk can return to caller
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net, Mike Frysinger <vapier@gentoo.org>, Markos Chandras <Markos.Chandras@imgtec.com>

Hi!
> 1. Create consistent code that matched what we wanted as far as style
> and structure was concerned. A lot of the time Cyril and I (as well as
> you and other folks in the past) were making modifications to files
> and instead of it being just a "oh, I fixed this thing", it generally
> turned into a full-scale rewrite of the testcase because we weren't
> very restrained in how changes were done. Furthermore, without there
> being better examples in the tree for developers to look at, it was
> believed (at least by me) that people were following the wrong
> examples when designing fixes and the like, and regardless of what the
> style guide said, or whether or not they were told to run
> check_patches.pl, contributors provided code that be more of a burden
> in the long run. This also extended to proper design patterns as noted
> in the style guide.

Yes we have a problem with very unconsistent usage of the test
interfaces but I don't see any other way than taking and fixing these
tests one by one.

And for that we need clear definitions and docummentation how to use the
test interface. The style guide is good, but I'm thinking about
something more detailed with actuall code examples.

I would love to write such documment but so far I haven't had time for
it.

> 2. Create a means where people could call "SAFE_*" macros instead of
> doing ad hoc error checking (there was a lot of duplication in the LTP
> tree, and there were a lot of gaps because test writers didn't write
> their error codes and things would go downhill quickly and be hard to
> troubleshoot if the issue was transient). In order to do this, we
> needed a means to push 'Exceptions' on a stack and execute all of the
> cleanup functions in order to ensure that everything was completed to
> the best of the ability of the testcase. In python terms what I was
> looking for was something like the following (basic pseudocode,
> similar to what's done in unittest):
> 
> setup()
> try:
>     test()
> finally:
>     # Execute all of the cleanup tasks in order. If something fatal
> occurs here, die.
>     map(lambda cleanup_task: cleanup_task(), cleanup_tasks.iteritems())
> 
> In order to do this, tst_brkm needed to become reentrant to avoid
> rewriting everything to use a new API.
> 
> Like all things, I'm not 100% pleased with how things turned out
> (things aren't cleanly formulated in the C code, similar to what I
> show above in the python psuedocode), but if you have some suggestions
> for how we should resolve this in a sane manner (maybe grow another
> API that's reentrant, adjust the behavior of the current one to once
> again be non-reentrant, etc?) -- I'm all ears.

Growing parallel API is not a good option, that way we would have to
maintain two broken interfaces ;).

My only recipe for that is gradually fix tests one by one (And I'm
working on that as fast as I can).

> PS This work burned me out on LTP as I took on the tedious task of
> changing a couple thousands of lines of code in all the testcases in
> the period of a couple weeks (it was sometime between Thanksgiving and
> somewhere around New Year's), originally by hand, then I tried to do
> via script, then I went back and had to manually fix things the script
> didn't catch the first go around. This was reiterated a few times. And
> I didn't catch all the bugs (I've sighed in regret at a few commit
> messages I've seen over the past year caused by my rototilling).

Hey, that's not a big deal, so far I've managed to fix most of the
problems caused by that. Mostly it caused broken things to broke even
more and things that accidentally stopped working after they were
accidentally working before.

The git history is another story, but at least it's challenging and fun
;).

And one thing that I've learnt while maintaining LTP is that it's ok to
try things and break something occasionally if you fix that later. If
you are too afraid you wouldn't be able to do anything. 

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Ridiculously easy VDI. With Citrix VDI-in-a-Box, you don't need a complex
infrastructure or vast IT resources to deliver seamless, secure access to
virtual desktops. With this all-in-one solution, easily deploy virtual 
desktops for less than the cost of PCs and save 60% on VDI infrastructure 
costs. Try it free! http://p.sf.net/sfu/Citrix-VDIinabox
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
