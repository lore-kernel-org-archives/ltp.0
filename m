Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <chrubis@suse.de>) id 1QCFKv-0007nL-9Z
	for ltp-list@lists.sourceforge.net; Tue, 19 Apr 2011 18:07:41 +0000
Date: Tue, 19 Apr 2011 20:32:31 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110419183231.GC4194@saboteur.suse.cz>
References: <BANLkTi=Q+MM0JLVtRD6C0__doJzP6axMwA@mail.gmail.com>
	<331823962.36120.1303234323973.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
	<BANLkTinx31ZQfzb9=z8M-x2x9UOnguJ2Gg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BANLkTinx31ZQfzb9=z8M-x2x9UOnguJ2Gg@mail.gmail.com>
Subject: Re: [LTP] [PATCH] cgroups/cpuset_base_ops: 6 is valid value for
 sched_relax_domain_level
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
Cc: ltp-list@lists.sourceforge.net

Hi!
> > I don't see any way to find out range from user-space.
> > Even with CONFIG_SCHED_DEBUG, sched_domain->level isn't exported to /proc.
> >
> > I think whole test isn't much useful, as it is very unlikely
> > you would have all scheduling domains available:
> > http://lxr.linux.no/#linux+v2.6.38/kernel/sched.c#L6995
> >
> > Quoting Peter Zijlstra:
> > "More like, use sched_debug boot parameter and see your dmesg output.
> > I've recently merged a patch that makes the whole level thing completely
> > dynamic, there's no more fixed levels."
> >
> > At the moment, I'm out of ideas how to find out acceptable range.
> 
>     Just make the test only run on kernels without that particular
> functionality. I assume that's possible in some way, or was the author
> not nice enough to do that (I have to remember that this is Linux and
> sane versioning with kernel/userland sources, etc aren't commonplace
> like BSD)?

It's more complicated than that. There are several kernel constants that
are considered internal, these may be changed by config knobs
architecture or particular commit. And sometimes there is no way to get
these from running kernel (as it doesn't make sence to get them until
you are trying to test that particular part of the kernel works some
way).

Even more the kernel is every changing codebase, so what was influenced
by constant may not exist anymore (and the interface for userspace
don't need to be changed at all) just internal implementation.

And if that's the case. I would rather get rid of test that rely on some
kernel internals and speculated behaviour, rather than spending eternity
patching it for each release.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Benefiting from Server Virtualization: Beyond Initial Workload 
Consolidation -- Increasing the use of server virtualization is a top
priority.Virtualization can reduce costs, simplify management, and improve 
application availability and disaster protection. Learn more about boosting 
the value of server virtualization. http://p.sf.net/sfu/vmware-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
