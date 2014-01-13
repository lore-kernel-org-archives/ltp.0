Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1W2jyr-0004bO-2s
	for ltp-list@lists.sourceforge.net; Mon, 13 Jan 2014 16:03:13 +0000
Date: Mon, 13 Jan 2014 17:02:48 +0100
From: chrubis@suse.cz
Message-ID: <20140113160248.GB1945@rei>
References: <1387358991.1664.37.camel@G08JYZSD130126>
	<629935924.13499645.1389289589284.JavaMail.root@redhat.com>
	<20140109180804.GA9619@rei> <201401091417.16506.vapier@gentoo.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <201401091417.16506.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH???v3] lib/cloner.c: add function ltp_clone7 when
 clone supports???7 arguments
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
> > >  extern int __clone2(int (*fn) (void *arg), void *child_stack_base,
> > > -                   size_t child_stack_size, int flags, void *arg,
> > > -                   pid_t *parent_tid, void *tls, pid_t *child_tid);
> > > +                   size_t child_stack_size, int flags, void *arg, ...);
> > >  #endif
> > >  #ifndef CLONE_SUPPORTS_7_ARGS
> > 
> > I've been unable to locate ia64 distribution that does not support the
> > additional parameters so I've leaved that out. It may be related to a
> > fact that linux was ported to ia64 after the interface has changed, but
> > that is just my guess.
> > 
> > And I guess that we may drop the extern int definition too, at least the
> > configure script with __clone2() function seems to work fine just with
> > the <sched.h>
> 
> the ia64 glibc port has never included a prototype for the clone2 func.  so 
> the configure test (which is really just doing a compile time test against the 
> prototype in the C library's header) would never fail.

Ah, you are right, the build has finished fine but there are implicit
declaration warnings in the log. I should have checked it.

> in terms of the actual code, the clone2 func was updated here to take 7 args:
> commit 625f22fc7f8e0d61e3e6cff2c65468b91dbad426
> Author: Ulrich Drepper <drepper@redhat.com>
> Date:   Mon Mar 3 19:53:27 2003 +0000
> 
> that commit was first released in glibc-2.3.3.  but even if you were using an 
> older glibc, the configure would pass and the code would compile fine (again, 
> due to the fact glibc has never included a prototype for __clone2).

I've looked at the SLES9 and RHEL4 and they both have glibc at least
2.3.3. So I think that it's safe to assume that __clone2() on ia64
supports eight arguments and simply decleare the prototype in
lib/cloner.c.

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
