Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VYyIq-00046R-85
	for ltp-list@lists.sourceforge.net; Wed, 23 Oct 2013 13:16:48 +0000
Date: Wed, 23 Oct 2013 15:16:29 +0200
From: chrubis@suse.cz
Message-ID: <20131023131629.GF24275@rei.Home>
References: <5266530C.5070604@cn.fujitsu.com> <20131023125206.GD24275@rei.Home>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131023125206.GD24275@rei.Home>
Subject: Re: [LTP] [PATCH] acct/acct01.c: Add ELOOP ENAMETOOLONG EROFS
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
To: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> > Add ELOOP, ENAMETOOLONG, EROFS error number test in acct01.c for acct(2)
> > 
> > Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
> > ---
> >  runtest/syscalls                        |  2 +-
> >  testcases/kernel/syscalls/acct/acct01.c | 77 ++++++++++++++++++++++++++++++++-
> >  2 files changed, 77 insertions(+), 2 deletions(-)
> > 
> > diff --git a/runtest/syscalls b/runtest/syscalls
> > index 09e5f7f..a3a65b6 100644
> > --- a/runtest/syscalls
> > +++ b/runtest/syscalls
> > @@ -10,7 +10,7 @@ access03 access03
> >  access04 access04
> >  access05 access05
> >  
> > -acct01 acct01
> > +acct01 acct01 -D DEVICE -T DEVICE_FS_TYPE
> >  acct02 acct02
> >  
> >  add_key01 add_key01
> > diff --git a/testcases/kernel/syscalls/acct/acct01.c b/testcases/kernel/syscalls/acct/acct01.c
> > index 062cc2b..1545df1 100644
> > --- a/testcases/kernel/syscalls/acct/acct01.c
> > +++ b/testcases/kernel/syscalls/acct/acct01.c
> > @@ -44,22 +44,41 @@
> >  #include <stdio.h>		/* needed by testhead.h */
> >  #include <stdlib.h>
> >  #include <unistd.h>
> > +#include <sys/mount.h>
> 
> 
> I've tried to apply this one, but it appears to be based on the first
> version of the cleanup patch (see the /* needed by testhead.h */ comment
> for example).
> 
> Can you please rebase it on the current cleanup (as pushed to git) and
> resend?

Also note that I've just added one more testcase into acct01 and removed
the messy acct02 that is now covered by the acct01 test.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60135991&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
