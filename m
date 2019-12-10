From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 10 Dec 2019 08:38:09 +0100
Subject: [LTP] [PATCH] lib: Add fifo library
In-Reply-To: <79cfa9ef-b122-b2e1-4051-e16eff04d6be@jv-coder.de>
References: <20191209064110.67975-1-lkml@jv-coder.de>
 <20191209222557.GA31054@dell5510>
 <79cfa9ef-b122-b2e1-4051-e16eff04d6be@jv-coder.de>
Message-ID: <20191210073808.GA4143@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Joerg,

> > > +#ifndef PATH_MAX
> > > +#ifdef MAXPATHLEN
> > > +#define PATH_MAX	MAXPATHLEN
> > > +#else
> > > +#define PATH_MAX	1024
> > > +#endif
> > > +#endif
> > Hm, this is copy paste from old tests (all use test.h, even quite new and clean tests/tst_tmpdir_test.c).
> > I wonder if this is still relevant, can't we use #include <limits.h>?
> Right, if there is nothing against using limits.h, I'll change it. I just
> used other code for reference for my code.
I don't know the purpose of this code (anybody knows?), but unless there is good
reason for it, I'd be for using <limits.h>.

> > > +++ b/testcases/Makefile
> > > @@ -28,7 +28,7 @@ include $(top_srcdir)/include/mk/env_pre.mk
> > >   # 1. kdump shouldn't be compiled by default, because it's runtime based and
> > >   #    WILL crash the build host (the tests need to be fixed to just build, not
> > >   #    run).
> > > -FILTER_OUT_DIRS		:= kdump
> > > +FILTER_OUT_DIRS		:= kdump open_posix_testsuite realtime kernel network misc
> > I guess this is unrelated change for your debug.
> Damn... This happens to me all the time, it's time for configure switches ;)
Yep, I have it on my todo list, but haven't forced to do it. Feel free to
implement it.
https://github.com/linux-test-project/ltp/issues/617

> > > +[ "$TST_NEEDS_TMPDIR" != 1 ] && tst_brk TCONF "fifo library requires TST_NEEDS_TMPDIR=1"
> > If we apply https://patchwork.ozlabs.org/patch/1206399/, it should be
> > $TST_NEEDS_TMPDIR=1
> I don't get it? The path you linked seems unrelated to me and did you mean
> [? "$TST_NEEDS_TMPDIR" = 1 ] || ... ?
> > +	[ "$TST_NEEDS_FIFO" = 1 ] && . tst_fifo.sh
> > I'd load it at the top, just below
> > . tst_ansi_color.sh
> > . tst_security.sh
> The way I implemented it, I can't load it at the top, because tst_fifo.sh
> requires
> TST_TMPDIR to be already set, when it is included.
Right, sorry. BTW, am I missing something or you don't use this variable in
shell? I see it ony defined in tst_fifo.sh, then you use $TST_TMPDIR.
(+ defined and used in tst_fifo.c)
+ local _tst_path_req="${TST_TMPDIR}/tst_fifo_$1.req"
So what is the purpose of the variable in shell?

And maybe the test for $TST_TMPDIR might not be needed (it's not supposed to be
used without tst_test.sh, but there is no harm to have it (maybe the error
message should be something like "tst_test.sh is part of shell API and shouldn't
be loaded separately").

Kind regards,
Petr
