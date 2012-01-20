Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1RoFP5-0000KW-AW
	for ltp-list@lists.sourceforge.net; Fri, 20 Jan 2012 14:25:19 +0000
Date: Fri, 20 Jan 2012 15:37:30 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20120120143730.GC13447@saboteur.suse.cz>
References: <20120111125642.GD7143@saboteur.suse.cz>
	<201201181139.19497.vapier@gentoo.org>
	<20120119174355.GF10302@saboteur.suse.cz>
	<201201191334.47413.vapier@gentoo.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <201201191334.47413.vapier@gentoo.org>
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
> > > certainly the existing FORK_OR_VFORK/self_exec api could do with a minor
> > > cleanup and unification.  i think the reason we have it do
> > > vfork+self-exec on nommu but fork on mmu is to keep things simpler for
> > > the main dev base, but i wouldn't be opposed to just always having tsts
> > > do vfork+self-exec so as to reduce the #ifdef ugliness in tests.
> > 
> > I will meditate about that (I do not fully understand how exactly is
> > maybe_run_child() and self_exec() working yet).
> 
> many tests want to fork a child to run some code.  and the parent watches that 
> in parallel.  on no-mmu, we can't do that (vfork blocks the parent until the 
> child exits or execs).  so instead, we vfork, then exec the test with special 
> params.  the test code looks at its args to see if it is being executed like 
> normal, or if it needs to execute in "child mode".  once it does, the test 
> continues on like it would normally.

Ah, right, I expected something like that.

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
