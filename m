From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 9 Dec 2020 23:10:56 +0100
Subject: [LTP] [PATCH 1/1] syscalls/get_mempolicy01: Rewrite to new API
In-Reply-To: <X9DO3uytgBaTrVwi@yuki.lan>
References: <20201208132814.16497-1-pvorel@suse.cz> <X9DO3uytgBaTrVwi@yuki.lan>
Message-ID: <20201209221056.GB69775@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

...
> > -	if (!is_numa(NULL, NH_MEMS, 1))
> > -		tst_brkm(TCONF, NULL, "requires NUMA with at least 1 node");
> > +	if (get_allowed_nodes(NH_MEMS, 1, &test_node) < 0)
> > +		tst_brk(TBROK | TERRNO, "get_allowed_nodes failed");

> The is_numa() and get_allowed_nodes() is deprecated API, we do have new
> tst_get_nodemap() function that replaces them. See set_mempolicy()
> testcases for reference.
Thanks!

> > -	TEST_PAUSE;
> > -	tst_tmpdir();
> > +	nodemask = numa_allocate_nodemask();
> > +	getnodemask = numa_allocate_nodemask();
> > +	numa_bitmask_setbit(nodemask, test_node);
> >  }

> > -#else
> > -int main(void)
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
Thanks for catching this. I actually run it more with -i500,
but it looks laptop has enough memory :). Anyway, what you suggest is obviously
much better solution, thanks!

> Also I would pass the struct test_case pointer to these instead of i
> since they convert the i to the testcase pointer as the first thing
> anyways.
+1

Kind regards,
Petr
