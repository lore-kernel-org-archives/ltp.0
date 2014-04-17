Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Wanot-0006IS-Ri
	for ltp-list@lists.sourceforge.net; Thu, 17 Apr 2014 15:01:43 +0000
Date: Thu, 17 Apr 2014 17:00:56 +0200
From: chrubis@suse.cz
Message-ID: <20140417150056.GA1483@rei.Home>
References: <20140416190028.GA2093@ls3530.fritz.box>
	<20140417093329.GA6558@rei.suse.cz>
	<trinity-7fc052ce-4544-4fa4-afc0-9b68430ef693-1397729289569@3capp-gmx-bs62>
	<20140417132750.GA6420@rei>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140417132750.GA6420@rei>
Subject: Re: [LTP] [PATCH] fix fanotify syscall check on compat kernel
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
To: Helge Deller <deller@gmx.de>
Cc: ltp-list@lists.sourceforge.net, Mike Frysinger <vapier@gentoo.org>

Hi!
> > > Also I've been unable to make the testcases work with -m32 on x86_64
> > > both with and without the patch and even when using glibc wrappers from
> > > sys/fallocate.h, in all cases the error is EINVAL which suggets that the
> > > parameters are passed wrongly somewhere on the way.
> > 
> > Does it work on the same kernel with -m64 ?
> > In any case, for the tests to work the kernel needs to have been compiled with the
> > kernel option CONFIG_FANOTIFY_ACCESS_PERMISSIONS set. In my initial tests this
> > option wasn't set and I got EINVAL too.
> 
> And it seems to work (-m32 with your patch) on two testing machines with
> slightly older kernel. So I guess that the patch is fine and I had just
> bad luck with one particular machine.

Found the cause:

commit 91c2e0bcae72a3086c698b5de2b950b885abb0e6
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Tue Mar 5 20:10:59 2013 -0500

    unify compat fanotify_mark(2), switch to COMPAT_SYSCALL_DEFINE
    
    Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>


Which was fixed in:

commit 592f6b842f64e416c7598a1b97c649b34241e22d
Author: Heiko Carstens <heiko.carstens@de.ibm.com>
Date:   Mon Jan 27 17:07:19 2014 -0800

    compat: fix sys_fanotify_mark
    
    Commit 91c2e0bcae72 ("unify compat fanotify_mark(2), switch to
    COMPAT_SYSCALL_DEFINE") added a new unified compat fanotify_mark syscall
    to be used by all architectures.
    
    Unfortunately the unified version merges the split mask parameter in a
    wrong way: the lower and higher word got swapped.
    
    This was discovered with glibc's tst-fanotify test case.


So kernels between 3.10 and 3.14 are broken.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
