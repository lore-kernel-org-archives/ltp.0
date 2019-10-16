From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 16 Oct 2019 16:21:01 +0200
Subject: [LTP] [PATCH] lib: tst_taint: Ignore WARN taint flag if already
 set
In-Reply-To: <bc2f54f1-3be1-cf77-7475-3c08cbd24850@suse.de>
References: <20191016131506.17193-1-chrubis@suse.cz>
 <bc2f54f1-3be1-cf77-7475-3c08cbd24850@suse.de>
Message-ID: <20191016142101.GC19297@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > diff --git a/lib/tst_taint.c b/lib/tst_taint.c
> > index a5dbf77d2..3de6d72f4 100644
> > --- a/lib/tst_taint.c
> > +++ b/lib/tst_taint.c
> > @@ -82,8 +82,13 @@ void tst_taint_init(unsigned int mask)
> >  		tst_res(TCONF, "Kernel is too old for requested mask");
> >  
> >  	taint_mask = mask;
> > -
> >  	taint = tst_taint_read();
> > +
> > +	if (mask & TST_TAINT_W && taint & TST_TAINT_W) {
> > +		tst_res(TCONF, "Ignoring already set kernel warning taint");
> > +		mask &= ~TST_TAINT_W;
> > +	}
> > +
> >  	if ((taint & mask) != 0)
> >  		tst_brk(TBROK, "Kernel is already tainted: %u", taint);
> >  }
> > 
> 
> Tests may rely on TAINT_W to decide the result. If we need TAINT_W, we
> can only run the test when it was not set before. For example,
> testcases/cve/cve-2017-17053.c relies on this.
> This may render this testcase unusable, or do I get this wrong?

Only on systems where something set the flag already. Ideally that will
not happen on many systems.

-- 
Cyril Hrubis
chrubis@suse.cz
