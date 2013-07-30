Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1V46ik-0004VQ-KK
	for ltp-list@lists.sourceforge.net; Tue, 30 Jul 2013 09:59:58 +0000
Date: Tue, 30 Jul 2013 11:59:50 +0200
From: chrubis@suse.cz
Message-ID: <20130730095950.GC1184@rei.scz.novell.com>
References: <51F7338D.4060804@cn.fujitsu.com> <51F735B2.5030007@cn.fujitsu.com>
	<51F73E13.9040802@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <51F73E13.9040802@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] mount/mount06.c: fix a compile error
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
To: DAN LI <li.dan@cn.fujitsu.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

Hi!
> >> The definitions of MS_PRIVATE and MS_MOVE were only added to glibc headers
> >> in version 2.12.
> >>
> >> If the version of glibc is older than 2.12, define these two flags.
> >>
> >> Signed-off-by: DAN LI <li.dan@cn.fujitsu.com>
> >> ---
> >>  testcases/kernel/syscalls/mount/mount06.c |    5 +++++
> >>  1 files changed, 5 insertions(+), 0 deletions(-)
> >>
> >> diff --git a/testcases/kernel/syscalls/mount/mount06.c b/testcases/kernel/syscalls/mount/mount06.c
> >> index acfb22d..ab1a472 100644
> >> --- a/testcases/kernel/syscalls/mount/mount06.c
> >> +++ b/testcases/kernel/syscalls/mount/mount06.c
> >> @@ -31,6 +31,11 @@
> >>  #include "usctest.h"
> >>  #include "safe_macros.h"
> >>
> >> +#if !(__GLIBC_PREREQ(2, 12))
> > 
> > Why not do like below?
> 
> I think it also clearly shows the reason why this definition should
> exist here(glibc version related).

Well the same is told in the git commit log anyway.
(Which is the place where people should look for verbose description of
 changes.)

And this kind of code may break with different libc implementation where
there is no __GLIBC_PREREQ() macro.


So I vote for the:

#ifndef FOO
# define FOO xyz
#endif

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Get your SQL database under version control now!
Version control is standard for application code, but databases havent 
caught up. So what steps can you take to put your SQL databases under 
version control? Why should you start doing it? Read more to find out.
http://pubads.g.doubleclick.net/gampad/clk?id=49501711&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
