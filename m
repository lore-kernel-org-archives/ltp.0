Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1N7RQU-00079V-NU
	for ltp-list@lists.sourceforge.net; Mon, 09 Nov 2009 10:24:46 +0000
Date: Mon, 9 Nov 2009 11:24:31 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20091109102431.GE631@schrodinger.suse.cz>
References: <20091105131852.GA13908@schrodinger.suse.cz>
	<200911061511.57777.vapier@gentoo.org>
	<364299f40911061405y5834100eua9a254f2abe0cdfe@mail.gmail.com>
	<200911061748.35248.vapier@gentoo.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200911061748.35248.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH] replacing -Wextra with -W
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
> > >> > > Lately gcc developers introduced -Wextra flag that does the same as
> > >> > > -W but is more descriptive. According to this using -W flag should
> > >> > > be safe (as gcc is backward compatlible) but using -Wextra is
> > >> > > limited to newer gcc releases.
> > >> > >
> > >> > > Attached patch replaces all -Wextra occurences with -W and thus
> > >> > > fixes compliation failures with older gcc (mine was gcc-3.3.3 on
> > >> > > sles).
> > >> >
> > >> > it'd be better if we had configure tests for -W flags, but that would
> > >> > take a bit more effort, and i dont think it should preclude applying
> > >> > your patch. however, please make this change first:
> > >> >  - integrated Makefiles shouldnt be setting flags at all, so just
> > >> > delete the whole line in
> > >> > testcases/kernel/controllers/{cpuctl,cgroup}_fj/Makefile
> > >>
> > >> Patch that should be applied over the previous one attached.
> > >
> > > thanks, ive merged the two and added to the tree.  hopefully i didnt
> > > screw anything up in the (simple) process ;).
> > 
> >     It looks fine from my end :]. We should really restrict the -W*
> > flag setting to include/mk/config.mk like you suggested though, so
> > maybe we should clean up all of the Makefiles in one shot.
> 
> some of the Makefiles Cyril highlighted havent been converted to the common 
> .mk framework.  we could cheat and just pull in config.mk fo some, but for 
> others (ones that build kernel modules), i'm not sure that will work.  linux' 
> kbuild gets pissy if you try to tweak build flags like CFLAGS/CPPFLAGS.  so we 
> might have to create a new .mk target specifically for kernel modules that 
> takes care of these details.

In these I've only replaced -Wextra with -W. Is there any way this could broke them?

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
