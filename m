From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 16 Oct 2019 16:13:39 +0200
Subject: [LTP] [PATCH] lib: tst_taint: Ignore WARN taint flag if already
 set
In-Reply-To: <1282930646.6466524.1571232948788.JavaMail.zimbra@redhat.com>
References: <20191016131506.17193-1-chrubis@suse.cz>
 <1282930646.6466524.1571232948788.JavaMail.zimbra@redhat.com>
Message-ID: <20191016141339.GA19297@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > +
> > +	if (mask & TST_TAINT_W && taint & TST_TAINT_W) {
> > +		tst_res(TCONF, "Ignoring already set kernel warning taint");
> > +		mask &= ~TST_TAINT_W;
> 
> Shouldn't this rather mask it from taint_mask?
> Otherwise, won't you still get an error in tst_taint_check()?

Of course.

> > +	}
> > +
> >  	if ((taint & mask) != 0)

And this has to be changed so that we check the taint againts the
taint_mask .

> >  		tst_brk(TBROK, "Kernel is already tainted: %u", taint);
> >  }
> > --
> > 2.21.0
> > 
> > 

-- 
Cyril Hrubis
chrubis@suse.cz
