From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 6 Jan 2021 12:23:05 +0100
Subject: [LTP] [PATCH 1/1] syscalls/get_mempolicy01: Rewrite to new API
In-Reply-To: <X9DO3uytgBaTrVwi@yuki.lan>
References: <20201208132814.16497-1-pvorel@suse.cz> <X9DO3uytgBaTrVwi@yuki.lan>
Message-ID: <X/WdmfIFbH/85wVO@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

...
> > +static void do_test(unsigned int i)
> >  {
> > -	tst_brkm(TCONF, NULL, NUMA_ERROR_MSG);
> > +	struct test_case *tc = &tcase[i];
> > +	int policy;
> > +
> > +	tst_res(TINFO, "test #%d: %s", (i+1), tc->desc);
> > +
> > +	setup_node();
> > +
> > +	if (tc->pre_test)
> > +		if (tc->pre_test(i) == -1)
> > +			return;
> > +
> > +	if (tc->test) {
> > +		tc->test(i);
> > +
> > +		if (TST_RET < 0) {
> > +			tst_res(TFAIL | TERRNO, ".test failed");
> > +			return;
> > +		}
> > +	}

> We call test_mbind() here for each iteration which calls mmap()
> and the memory is never freed. Which means that this will fail sooner or
> later with the -i option.

> Why can't we allocate all the blocks with different mempolicy and
> or/bind the memory once in the test setup instead? We can keep the
> callback in-place as they are we just need to loop over them in the
> setup() instead. Also I would rename them to alloc, setup, or something
> like that so that it's clear that they are just preparing the
> environment and not doing the actuall test.
OK, I'll loop over ARRAY_SIZE(tcase) in the setup().
But the original code first set NUMA node (setup_node()), then did the
preparation (SAFE_MMAP() and mbind()) and then call set_mempolicy().

Do you suggest instead of testing just take "safe" approach - tst_brk(TBROK)
on any failure as it's in the setup?

Kind regards,
Petr
