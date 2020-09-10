From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 10 Sep 2020 17:24:47 +0200
Subject: [LTP] [PATCH v2] syscall/ptrace08: Simplify the test.
In-Reply-To: <5d127ee5-56d1-01c5-c364-dcb004204e9d@suse.cz>
References: <20200904140931.10153-1-chrubis@suse.cz>
 <5d127ee5-56d1-01c5-c364-dcb004204e9d@suse.cz>
Message-ID: <20200910152447.GA10844@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> looks good and the test passes on older fixed kernels. Just one
> compatibility issue below.

I've fixed that and also the kernel version when the behavior had
changed and pushed, thanks for the review and testing.

...

> > +	if (TST_RET != -1) {
> > +		tst_res(TFAIL, "ptrace() breakpoint with kernel addr succeeded");
> > +	} else {
> > +		if (TST_ERR == EINVAL) {
> > +			tst_res(TPASS | TTERRNO,
> > +				"ptrace() breakpoint with kernel addr failed");
> > +		} else {
> > +			tst_res(TFAIL | TTERRNO,
> > +				"ptrace() breakpoint on kernel addr should return EINVAL, got");
> > +		}
> > +	}
> > +
> > +	unsigned long addr;
> 
> AFAICT, we're not compiling with --std=c99 so older compilers may
> complain about the variable declaration here.

The default std for gcc has been at least gnu90 for ages, which includes
subset of c99 features as well including this one. So unless you
explicitly pass --std=c90 or older it will work just fine.

I've moved the declaration to the top of the function nevertheless.

-- 
Cyril Hrubis
chrubis@suse.cz
