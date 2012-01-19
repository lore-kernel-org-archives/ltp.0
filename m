Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1Rnvpx-0001hv-6k
	for ltp-list@lists.sourceforge.net; Thu, 19 Jan 2012 17:31:45 +0000
Date: Thu, 19 Jan 2012 18:43:55 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20120119174355.GF10302@saboteur.suse.cz>
References: <20120111125642.GD7143@saboteur.suse.cz>
	<201201131216.03211.vapier@gentoo.org>
	<20120118161754.GA5353@saboteur.suse.cz>
	<201201181139.19497.vapier@gentoo.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <201201181139.19497.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH] syscalls/getrusage03: flush stdout to avoid
 duplicated output
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
> > > > I don't like idea of defining fork to tst_fork that's exactly the
> > > > magic that may take hours to figure out.
> > > > 
> > > > Forcing it, in this case, is probably good idea.
> > > 
> > > tst_fork() would be the route i'd prefer to go, and i think since we
> > > already take pains in this area to support NOMMU, it isn't an additional
> > > burden.
> > 
> > Hmm, maybe we could get rid of the FORK_OR_VFORK macro and use
> > tst_fork() to cover both flusing and no NOMMU target. That actually
> > looks like good way to go. So let's fix this that way.
> 
> my concern with this is that by having "vfork" in the name people know they 
> need to be aware of the vfork semantics.  there are places where vfork/fork 
> are interchangeable (and hence we use FORK_OR_VFORK).  but there are places 
> where they are not, and so we end up doing one of two things:
> 	- rewrite it to use FORK_OR_VFORK and self_exec
> 	- disable the test altogether

Ah, I see, so vfork() doesn't do the copy on write thing with program
memory. Hmm and it makes sense to use vfork() on non-mmu system as you
can't implement copy on write approach there. I think I'm starting to
uderstand this works.

> so i don't think we want to blindly have everyone get "fork or vfork" 
> semantics.  the current methodology allows for mmu devs to contribute tests 
> without worrying about these issues.  then the non-mmu peeps notice the new 
> tests (because they get build failures due to fork() not being defined), and 
> they get to go in and review each test to see what's needed.

Okay, that makes sense.

> certainly the existing FORK_OR_VFORK/self_exec api could do with a minor 
> cleanup and unification.  i think the reason we have it do vfork+self-exec on 
> nommu but fork on mmu is to keep things simpler for the main dev base, but i 
> wouldn't be opposed to just always having tsts do vfork+self-exec so as to 
> reduce the #ifdef ugliness in tests.

I will meditate about that (I do not fully understand how exactly is
maybe_run_child() and self_exec() working yet).

> > > does that happen ?  POSIX guarantees printf() and friends to be
> > > multithreaded safe, so no lines would be inter-mingled, and they're
> > > sharing the same FILE*, so i wouldn't see adding a fflush() making a
> > > difference.
> > 
> > Looked at the code and there is yet another reason for this, the
> > printing is done with more than one printf(), so rarely the lines could
> > get intermixed. I'll fix that.
> 
> that would be good ... i think even if we had flushing, the multi-thread issue 
> would still be there because of what you've found.

I've just commited fix for this one. But there are some more problems,
global buffer for composing warning messages for example, which is not
likely to cause trouble as you would need to use the tst interface
incorrectly from more threads at once, but still that could happen.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Keep Your Developer Skills Current with LearnDevNow!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
