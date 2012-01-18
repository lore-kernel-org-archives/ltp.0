Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1RnY1K-0004pD-00
	for ltp-list@lists.sourceforge.net; Wed, 18 Jan 2012 16:05:54 +0000
Date: Wed, 18 Jan 2012 17:17:54 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20120118161754.GA5353@saboteur.suse.cz>
References: <20120111125642.GD7143@saboteur.suse.cz>
	<201201130101.06630.vapier@gentoo.org>
	<20120113130703.GA14943@saboteur.suse.cz>
	<201201131216.03211.vapier@gentoo.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <201201131216.03211.vapier@gentoo.org>
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
> > > if we wanted to be lazy, it would be easy to catch.  in our test.h:
> > > 	#define fork() tst_fork()
> > > 
> > > then in the single file defining tst_fork(), we do:
> > > 	#undef fork
> > > 
> > > or forcing it via:
> > > 	#define fork() __use_tst_fork()
> > > 
> > > but we already have to track in the ltp tests where fork() is used since
> > > this breaks NOMMU builds (i.e. UCLINUX), so it's not like we don't
> > > already have this issue.
> > 
> > I don't like idea of defining fork to tst_fork that's exactly the
> > magic that may take hours to figure out.
> > 
> > Forcing it, in this case, is probably good idea.
> 
> tst_fork() would be the route i'd prefer to go, and i think since we already 
> take pains in this area to support NOMMU, it isn't an additional burden.

Hmm, maybe we could get rid of the FORK_OR_VFORK macro and use
tst_fork() to cover both flusing and no NOMMU target. That actually
looks like good way to go. So let's fix this that way.

> > > > Or we could flush the output after each test message is printed with
> > > > tst_resm(). That is IMHO ideal solution. The only drawback is that this
> > > > may interfere with timings in some testcases (but testcases that
> > > > expects exacts timings are usually broken anyway).
> > > 
> > > i agree those tests are broken if the flushing causes issues due to a
> > > slow down.  however, slow downs in general are not a good thing,
> > > especially when these are only needed for apps that fork.  i'd like to
> > > think we could do better.
> > 
> > Still I'm slighlty for this one. In general case, flushing the buffer
> > often is bad, but considering relatively rare usage of tst_resm() the
> > slowdowns woudn't be most likely measurable (and it's flushed after
> > every '\n' when you run the test in the terminal anyway).
> 
> i just recall seeing some verbose tests in the past, and often times people 
> are writing to logs.  maybe in that case, there would be a bit of test time 
> slow down, and if there's one thing i learned from doing release engineering 
> at my last job, testing causes the longest delays :(.

I remeber some too, and also remember silecing some of them as the output
was no more than forgotten debug output and was interfering with the
testing as well (the realtime testcases that were printing someting in
the ineer loops, etc...).

And yes, careful testing takes time, a lot of it.

> > Side effects of this are generally possitive too, the messages from
> > parent and child, or several threads wouldn't be so badly intermixed in
> > the output.
> 
> does that happen ?  POSIX guarantees printf() and friends to be multithreaded 
> safe, so no lines would be inter-mingled, and they're sharing the same FILE*, 
> so i wouldn't see adding a fflush() making a difference.

Looked at the code and there is yet another reason for this, the
printing is done with more than one printf(), so rarely the lines could
get intermixed. I'll fix that.

> > > a fifth option would be to use libdl, override the fork() symbol with our
> > > own and then dlsym() to the direct fork() symbol.  but like the pthread
> > > solution, this would require linking all apps with -ldl, and it would
> > > only work on ELF based systems (so it would break embedded things like
> > > FLAT on NOMMU).
> > 
> > Not to mention, this is starting to fall into 'overcomplicated solutions'
> > category. I would like to keep things as simple as possible.
> 
> overcomplicated ?  absolutely.  a lot of fun and interesting to implement ?  
> absolutely ;).

Totally understand that, however I like to keep such fun out of the
projects I need to maintain ;).

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
